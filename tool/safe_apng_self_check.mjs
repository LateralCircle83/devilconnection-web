import assert from 'node:assert/strict'
import { readFileSync } from 'node:fs'
import vm from 'node:vm'

const packedPath = 'mods/dc_safe_apng.asar'
const pluginPath = 'data/others/plugin/apng/tyrano_apng.js'
const scenarioPath = 'data/scenario/system/apng.ks'
const packedMod = parseAsar(readFileSync(packedPath))

function readPackedText(path) {
  const entry = packedMod.files.get(path)
  assert.ok(entry, 'missing packed mod entry: ' + path)
  return packedMod.buffer.subarray(entry.offset, entry.offset + entry.size).toString('utf8')
}

const pluginSource = readPackedText(pluginPath)
const lazyScenario = readPackedText(scenarioPath)
const coreScenario = readFileSync('data/scenario/system/apng.ks', 'utf8')

function flushMicrotasks() {
  return new Promise((resolve) => setImmediate(resolve))
}

async function waitFor(predicate, message) {
  for (let i = 0; i < 40; i++) {
    if (predicate()) return
    await flushMicrotasks()
  }
  assert.fail(message)
}

function createCanvasLayer() {
  const canvases = new Map()

  function collection(name) {
    const canvas = canvases.get(name)
    return {
      0: canvas,
      length: canvas ? 1 : 0,
      css() { return this },
      fadeOut(time, callback) {
        callback()
        return this
      },
      remove() {
        canvases.delete(name)
        this.length = 0
      },
    }
  }

  return {
    append(html) {
      const match = String(html).match(/class="([^"]+)"/)
      if (match) canvases.set(match[1], { getContext() { return {} } })
    },
    find(selector) {
      return collection(String(selector).replace(/^canvas\./, ''))
    },
  }
}

function createHarness(options = {}) {
  const warnings = []
  const nextOrders = []
  const plays = []
  const reads = []
  const workers = []
  const pathIds = new Map()
  const idPaths = new Map()
  const failures = new Map(Object.entries(options.failures || {}))
  const fakeTimers = new Map()
  let nextPathId = 1
  let nextTimerId = 1
  let activeWorkers = 0
  let maxActiveWorkers = 0

  class WorkerStub {
    constructor(path) {
      this.path = path
      this.terminated = false
      workers.push(this)
    }

    postMessage(buffer) {
      const id = new Uint8Array(buffer)[0]
      const resourcePath = idPaths.get(id)
      activeWorkers++
      maxActiveWorkers = Math.max(maxActiveWorkers, activeWorkers)
      queueMicrotask(() => {
        const remaining = failures.get(resourcePath) || 0
        if (remaining > 0) {
          failures.set(resourcePath, remaining - 1)
          if (this.onerror) this.onerror(new Error('worker failure'))
          return
        }
        if (this.onmessage) {
          this.onmessage({
            data: {
              frames: [{ blob: { resourcePath } }],
              delays: [25],
            },
          })
        }
      })
    }

    terminate() {
      if (this.terminated) return
      this.terminated = true
      activeWorkers--
    }
  }

  class ImageStub {
    set src(value) {
      this._src = value
      queueMicrotask(() => {
        if (this.onload) this.onload()
      })
    }
    get src() { return this._src }
  }

  const layer = createCanvasLayer()
  const kag = {
    config: { scWidth: 1280, scHeight: 960 },
    dc: { preserved: true },
    ftag: {
      master_tag: {},
      nextOrder() { nextOrders.push('next') },
    },
    layer: {
      getLayer() { return layer },
    },
    stat: { is_wait: 'owned-by-scenario' },
  }

  const context = {
    ArrayBuffer,
    Date,
    FileReader: class FileReaderStub {},
    Image: ImageStub,
    Object,
    Promise,
    TYRANO: { kag },
    URL: {
      createObjectURL(blob) { return 'blob:' + blob.resourcePath },
      revokeObjectURL() {},
    },
    Worker: WorkerStub,
    clearTimeout(id) { fakeTimers.delete(id) },
    console: {
      log() {},
      warn(...args) { warnings.push(args.map(String).join(' ')) },
    },
    playAPNG(decoded, canvas, x, y, width, height, reversed, onFinish, onTick) {
      plays.push({ decoded, canvas, x, y, width, height, reversed })
      if (onTick) onTick(0)
      if (onFinish && options.finishImmediately) onFinish()
    },
    queueMicrotask,
    readAsArrayBuffer(path) {
      reads.push(path)
      if (!pathIds.has(path)) {
        const id = nextPathId++
        pathIds.set(path, id)
        idPaths.set(id, path)
      }
      return Promise.resolve(Uint8Array.of(pathIds.get(path)).buffer)
    },
    setInterval() { return 1 },
    setTimeout(callback, delay) {
      const id = nextTimerId++
      fakeTimers.set(id, { callback, delay })
      return id
    },
  }
  context.window = context

  vm.createContext(context)
  vm.runInContext(pluginSource, context, { filename: pluginPath })

  return {
    context,
    failures,
    kag,
    nextOrders,
    plays,
    reads,
    warnings,
    workers,
    get maxActiveWorkers() { return maxActiveWorkers },
  }
}

function startTag(harness, name, params) {
  const tag = harness.kag.ftag.master_tag[name]
  tag.start.call(tag, params || {})
}

function register(harness, name, storage = name + '.png') {
  startTag(harness, 'register_apng', { folder: 'image', storage, name })
}

async function activateLazy(harness, preload = '') {
  const before = harness.nextOrders.length
  startTag(harness, 'load_apng', { lazy: 'true', preload })
  await waitFor(
    () => harness.nextOrders.length === before + 1,
    'lazy activation did not release the scenario order',
  )
}

async function testCompatibilityPreloadAndLazyPlay() {
  const harness = createHarness()
  register(harness, 'hon_title')
  register(harness, 'effect')
  const registrationOrders = harness.nextOrders.length

  startTag(harness, 'load_apng', { lazy: 'true', preload: 'hon_title' })
  assert.equal(harness.nextOrders.length, registrationOrders)
  await waitFor(
    () => harness.nextOrders.length === registrationOrders + 1,
    'compatibility preload did not finish',
  )

  assert.ok(harness.kag.dc.apng.apngs.hon_title)
  assert.equal(harness.kag.dc.apng.apngs.effect, undefined)
  assert.deepEqual(harness.reads, ['./data/image/hon_title.png'])

  const beforePlay = harness.nextOrders.length
  startTag(harness, 'play_apng', {
    name: 'effect', layer: '0', page: 'fore', x: 0, y: 0, width: 10, height: 10,
  })
  assert.equal(harness.nextOrders.length, beforePlay)
  await waitFor(() => harness.plays.length === 1, 'lazy play did not decode and start')
  assert.equal(harness.nextOrders.length, beforePlay + 1)
  assert.equal(harness.kag.stat.is_wait, 'owned-by-scenario')
  assert.equal(harness.maxActiveWorkers, 1)
}

async function testThirdPartyLoadRemainsEager() {
  const harness = createHarness()
  register(harness, 'third_party')
  const beforeLoad = harness.nextOrders.length
  startTag(harness, 'load_apng', {})
  assert.equal(harness.nextOrders.length, beforeLoad)
  await waitFor(() => harness.nextOrders.length === beforeLoad + 1, 'eager load did not finish')
  assert.ok(harness.kag.dc.apng.apngs.third_party)
  assert.equal(harness.kag.dc.apng.safeLazy.lazyNames.third_party, undefined)
}

async function testDuplicatePathsDecodeOnce() {
  const harness = createHarness()
  register(harness, 'smoke_a', 'smoke.png')
  register(harness, 'smoke_b', 'smoke.png')
  await activateLazy(harness, 'smoke_a smoke_b')

  assert.equal(harness.reads.length, 1)
  assert.equal(harness.workers.length, 1)
  assert.equal(harness.kag.dc.apng.apngs.smoke_a, harness.kag.dc.apng.apngs.smoke_b)
}

async function testDecodeFailureCanRetry() {
  const path = './data/image/retry.png'
  const harness = createHarness({ failures: { [path]: 1 } })
  register(harness, 'retry')
  await activateLazy(harness)

  const beforeFirst = harness.nextOrders.length
  startTag(harness, 'play_apng', {
    name: 'retry', layer: '0', page: 'fore', x: 0, y: 0, width: 10, height: 10,
  })
  await waitFor(() => harness.nextOrders.length === beforeFirst + 1, 'failed play stalled')
  assert.equal(harness.plays.length, 0)
  assert.match(harness.warnings.at(-1), /play skipped after decode failure/)

  const beforeRetry = harness.nextOrders.length
  startTag(harness, 'play_apng', {
    name: 'retry', layer: '0', page: 'fore', x: 0, y: 0, width: 10, height: 10,
  })
  await waitFor(() => harness.plays.length === 1, 'retry did not recover')
  assert.equal(harness.nextOrders.length, beforeRetry + 1)
  assert.equal(harness.reads.filter((item) => item === path).length, 2)
}

async function testTheatreCurtainsRemainUsable() {
  const harness = createHarness({ finishImmediately: true })
  register(harness, 'makutozi_geki')
  register(harness, 'makuake_geki')
  await activateLazy(harness)

  const beforeClose = harness.nextOrders.length
  startTag(harness, 'play_apng', {
    name: 'makutozi_geki', layer: 'fix', page: 'fore', x: 0, y: 0,
    width: 1280, height: 960, zindex: 111111111, free: false,
  })
  await waitFor(() => harness.plays.length === 1, 'theatre close curtain did not play')
  assert.equal(harness.nextOrders.length, beforeClose + 1)
  assert.ok(harness.kag.dc.apng.played.makutozi_geki)

  const beforeOpen = harness.nextOrders.length
  startTag(harness, 'play_apng', {
    name: 'makuake_geki', layer: 'fix', page: 'fore', x: 0, y: 0,
    width: 1280, height: 960, zindex: 9998, free: true,
  })
  await waitFor(() => harness.plays.length === 2, 'theatre open curtain did not play')
  assert.equal(harness.nextOrders.length, beforeOpen + 1)
  assert.equal(harness.kag.stat.is_wait, 'owned-by-scenario')

  const beforeFree = harness.nextOrders.length
  startTag(harness, 'free_apng', {
    name: 'makutozi_geki', time: 0, wait: false, stop: false,
  })
  assert.equal(harness.nextOrders.length, beforeFree + 1)
  assert.equal(harness.kag.dc.apng.played.makutozi_geki, undefined)
}

function registrationLines(source) {
  return source.split(/\r?\n/).filter((line) => line.startsWith('[register_apng '))
}

function testScenarioPreservesRegistryAndCriticalPreloads() {
  assert.deepEqual(registrationLines(lazyScenario), registrationLines(coreScenario))
  const loadLine = lazyScenario.split(/\r?\n/).find((line) => line.startsWith('[load_apng '))
  assert.match(loadLine, /lazy="true"/)
  assert.match(loadLine, /preload="hon_title"/)

  const registry = registrationLines(lazyScenario).join('\n')
  for (const name of [
    'makutozi', 'makuake', 'makutozi_geki', 'makuake_geki',
    'hazime1', 'k_hazime1', 'hazime1_kupya', 'owari', 'k_owari', 'owari_kupya',
  ]) {
    assert.match(registry, new RegExp('name="' + name + '"'))
  }
}

function testEarlyAndDuplicateLoadsAreSafe() {
  const earlyWarnings = []
  const earlyContext = {
    console: {
      log() {},
      warn(...args) { earlyWarnings.push(args.map(String).join(' ')) },
    },
  }
  earlyContext.window = earlyContext
  vm.createContext(earlyContext)
  assert.doesNotThrow(() => {
    vm.runInContext(pluginSource, earlyContext, { filename: pluginPath })
  })
  assert.ok(earlyWarnings.some((message) => message.includes('before Tyrano was ready')))

  const harness = createHarness()
  register(harness, 'preserved')
  const originalAPNG = harness.kag.dc.apng
  const originalPlayTag = harness.kag.ftag.master_tag.play_apng
  const originalLoads = originalAPNG.loads

  vm.runInContext(pluginSource, harness.context, { filename: pluginPath })

  assert.equal(harness.kag.dc.apng, originalAPNG)
  assert.equal(harness.kag.dc.apng.loads, originalLoads)
  assert.equal(harness.kag.ftag.master_tag.play_apng, originalPlayTag)
  assert.ok(harness.warnings.some((message) => message.includes('duplicate load ignored')))
}

function testStartupPreloadStaysWithinBudget() {
  const loadLine = lazyScenario.split(/\r?\n/).find((line) => line.startsWith('[load_apng '))
  const preloadMatch = loadLine.match(/preload="([^"]*)"/)
  const preloadNames = preloadMatch ? preloadMatch[1].split(/[\s,]+/).filter(Boolean) : []
  const registrations = new Map()

  for (const line of registrationLines(lazyScenario)) {
    const folder = line.match(/folder="([^"]+)"/)[1]
    const storage = line.match(/storage="([^"]+)"/)[1]
    const name = line.match(/name="([^"]+)"/)[1]
    registrations.set(name, 'data/' + folder + '/' + storage)
  }

  let decodedBytes = 0
  for (const name of preloadNames) {
    const assetPath = registrations.get(name)
    assert.ok(assetPath, 'preload name is not registered: ' + name)
    const png = readFileSync(assetPath)
    let offset = 8
    while (offset + 12 <= png.length) {
      const length = png.readUInt32BE(offset)
      const type = png.toString('ascii', offset + 4, offset + 8)
      if (type === 'fcTL') {
        const width = png.readUInt32BE(offset + 12)
        const height = png.readUInt32BE(offset + 16)
        decodedBytes += width * height * 4
      }
      offset += 12 + length
      if (type === 'IEND') break
    }
  }

  assert.ok(decodedBytes > 0)
  assert.ok(
    decodedBytes <= 96 * 1024 * 1024,
    'startup APNG preload exceeds the 96 MiB decoded-frame budget',
  )
}

function parseAsar(buffer) {
  const jsonLength = buffer.readUInt32LE(12)
  const header = JSON.parse(buffer.subarray(16, 16 + jsonLength).toString('utf8'))
  const dataOffset = 16 + Math.ceil(jsonLength / 4) * 4
  const files = new Map()

  function walk(node, prefix) {
    for (const [name, entry] of Object.entries(node.files || {})) {
      const path = prefix ? prefix + '/' + name : name
      if (entry.files) walk(entry, path)
      else files.set(path, {
        offset: dataOffset + Number(entry.offset),
        size: Number(entry.size),
      })
    }
  }
  walk(header, '')
  return { buffer, files }
}

function testPackedModLayout() {
  const expectedFiles = [
    'README.md',
    'hook.js',
    'mods.json',
    pluginPath,
    scenarioPath,
  ]
  assert.deepEqual([...packedMod.files.keys()].sort(), expectedFiles.slice().sort())
  for (const path of expectedFiles) {
    assert.ok(packedMod.files.get(path).size > 0, 'empty packed mod entry: ' + path)
  }
  const metadata = JSON.parse(readPackedText('mods.json'))
  assert.equal(metadata.id, 'dc_safe_apng')
}

const tests = [
  ['compatibility preload and lazy play', testCompatibilityPreloadAndLazyPlay],
  ['third-party load remains eager', testThirdPartyLoadRemainsEager],
  ['duplicate paths decode once', testDuplicatePathsDecodeOnce],
  ['decode failure can retry', testDecodeFailureCanRetry],
  ['theatre curtains remain usable', testTheatreCurtainsRemainUsable],
  ['scenario preserves registry and critical preloads', testScenarioPreservesRegistryAndCriticalPreloads],
  ['early and duplicate plugin loads are safe', testEarlyAndDuplicateLoadsAreSafe],
  ['startup preload stays within budget', testStartupPreloadStaysWithinBudget],
  ['packed mod layout is complete', testPackedModLayout],
]

let failed = 0
for (const [name, test] of tests) {
  try {
    await test()
    console.log('ok - ' + name)
  } catch (error) {
    failed++
    console.error('not ok - ' + name)
    console.error(error)
  }
}

if (failed) process.exit(1)
console.log('safe APNG self-check passed (' + tests.length + ' tests)')
