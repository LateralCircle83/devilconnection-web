import assert from 'node:assert/strict'
import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import vm from 'node:vm'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const repoRoot = path.resolve(__dirname, '..')
const browserApiSource = fs.readFileSync(path.join(repoRoot, 'BrowserShell', 'browser_api.js'), 'utf8')
const electronLatestSource = fs.readFileSync(path.join(repoRoot, 'BrowserShell', 'electron_latest.js'), 'utf8')
const managerSource = fs.readFileSync(path.join(repoRoot, 'Modloader', 'manager.js'), 'utf8')

async function runTests(tests) {
  for (const [name, test] of tests) {
    await test()
    console.log(`ok - ${name}`)
  }
}

async function runSuite(name, tests) {
  console.log(`\n== ${name} ==`)
  await runTests(tests)
}

function createBrowserShellJQueryStub() {
  function jqueryStub() {
    return {
      attr() {
        return ''
      },
      each() {
        return this
      },
    }
  }
  jqueryStub.extend = function extend() {
    return Object.assign.apply(Object, arguments)
  }
  jqueryStub.isNWJS = function isNWJS() {
    return false
  }
  jqueryStub.getBrowser = function getBrowser() {
    return {}
  }
  jqueryStub.lang = function lang(key) {
    return key
  }
  jqueryStub.confirm = function confirm() {}
  jqueryStub.alert = function alert() {}
  return jqueryStub
}

function createLocalStorageStub() {
  const values = new Map()
  return {
    get length() {
      return values.size
    },
    getItem(key) {
      return values.has(key) ? values.get(key) : null
    },
    setItem(key, value) {
      values.set(key, String(value))
    },
    removeItem(key) {
      values.delete(key)
    },
    clear() {
      values.clear()
    },
    key(index) {
      return Array.from(values.keys())[index] || null
    },
  }
}

function createBrowserShellHarness({ indexedDB } = {}) {
  const calls = []
  const jqueryStub = createBrowserShellJQueryStub()
  const context = {
    ArrayBuffer,
    AudioContext: function AudioContext() {},
    Blob,
    DataView,
    LZString: {
      compress(value) {
        return value
      },
      decompress(value) {
        return value
      },
    },
    Promise,
    Swal: {
      fire() {
        return Promise.resolve({})
      },
    },
    TextDecoder,
    TextEncoder,
    TYRANO: {
      init() {
        calls.push('original-init')
      },
    },
    Uint8Array,
    addEventListener() {},
    alert() {},
    clearTimeout,
    close() {},
    console: {
      log() {},
      warn() {},
      error() {},
    },
    document: {
      addEventListener() {},
      body: {
        appendChild() {},
        removeChild() {},
      },
      createElement() {
        return {
          click() {},
        }
      },
      documentElement: {},
      fullscreenElement: null,
      querySelectorAll() {
        return []
      },
      visibilityState: 'visible',
    },
    fetch() {
      return Promise.resolve({ ok: false })
    },
    indexedDB,
    jQuery: jqueryStub,
    $: jqueryStub,
    localStorage: createLocalStorageStub(),
    location: {
      href: 'http://localhost:3000/index.html',
    },
    navigator: {},
    open() {},
    setTimeout,
    tyrano: {
      plugin: {
        kag: {
          checkUpdate(callback) {
            callback()
          },
          config: {},
          define: {},
          ftag: { master_tag: {} },
          parser: {},
          tag: {},
          tmp: {},
        },
      },
    },
  }
  context.window = context
  context.globalThis = context
  vm.createContext(context)
  vm.runInContext(browserApiSource, context, { filename: 'BrowserShell/browser_api.js' })
  vm.runInContext(electronLatestSource, context, { filename: 'BrowserShell/electron_latest.js' })
  return { calls, context }
}

async function testNoIndexedDBFallbackStillStarts() {
  const { calls, context } = createBrowserShellHarness()
  assert.equal(context.api.storage._useIndexedDB, false)
  assert.equal(typeof context.api.storage.init, 'function')
  assert.equal(typeof context.api.storage.ready?.then, 'function')
  assert.equal(await context.api.storage.ready, false)

  await context.TYRANO.init()
  assert.deepEqual(calls, ['original-init'])
}

async function testIndexedDBOpenFailureStillStarts() {
  const indexedDB = {
    open() {
      throw new Error('blocked')
    },
  }
  const { calls, context } = createBrowserShellHarness({ indexedDB })

  assert.equal(await context.api.storage.ready, false)
  await context.TYRANO.init()
  assert.equal(context.api.storage._useIndexedDB, false)
  assert.deepEqual(calls, ['original-init'])
}

const browserShellTests = [
  ['no IndexedDB fallback still starts', testNoIndexedDBFallbackStillStarts],
  ['IndexedDB open failure still starts', testIndexedDBOpenFailureStillStarts],
]

class ManagerElementShim {
  constructor(idOrTag) {
    this.id = idOrTag
    this.tagName = String(idOrTag).toUpperCase()
    this.children = []
    this.className = ''
    this.disabled = false
    this.innerHTML = ''
    this.listeners = {}
    this.parentNode = {
      removeChild: () => {
        this.removed = true
      },
    }
    this.style = {}
    this.textContent = idOrTag === 'start_game_btn' ? '启动游戏' : ''
    this.classList = {
      add: (name) => {
        const names = this.className ? this.className.split(/\s+/) : []
        if (!names.includes(name)) names.push(name)
        this.className = names.join(' ')
      },
      remove: (name) => {
        this.className = (this.className ? this.className.split(/\s+/) : [])
          .filter((item) => item !== name)
          .join(' ')
      },
      contains: (name) => (this.className ? this.className.split(/\s+/) : []).includes(name),
    }
  }

  addEventListener(type, callback) {
    this.listeners[type] = callback
  }

  appendChild(child) {
    this.children.push(child)
    return child
  }

  click() {
    if (this.listeners.click) {
      return this.listeners.click({ stopPropagation() {} })
    }
    return undefined
  }

  getAttribute() {
    return ''
  }

  querySelectorAll() {
    return []
  }
}

function createManagerHarness(options = {}) {
  const alerts = []
  const failed = []
  const initCalls = []
  const loaded = []
  const warnings = []
  const elements = new Map()
  const jQueryStub = {}
  const selectedModIds = options.selectedModIds || []

  const context = {
    Audio: function Audio() {
      return { play() {} }
    },
    FileReader: function FileReader() {},
    Howler: { ctx: { resume() {}, state: 'running' } },
    Sortable: function Sortable() {
      this.destroy = function destroy() {}
    },
    TYRANO: {},
    alert(message) {
      alerts.push(String(message))
    },
    closeModConfig() {},
    console: {
      log() {},
      warn(...args) {
        warnings.push(args.map(String).join(' '))
      },
      error() {},
    },
    fetch() {
      return Promise.resolve({ ok: false })
    },
    jQuery: jQueryStub,
    $: jQueryStub,
    localStorage: {
      getItem() {
        return null
      },
      removeItem() {},
      setItem() {},
    },
    setTimeout(callback) {
      callback()
    },
    tyrano: undefined,
  }

  function getElementById(id) {
    if (!elements.has(id)) elements.set(id, new ManagerElementShim(id))
    return elements.get(id)
  }

  function ensureKag() {
    context.tyrano ||= { plugin: {} }
    context.window.tyrano = context.tyrano
    context.tyrano.plugin ||= {}
    context.tyrano.plugin.kag ||= { tag: {} }
    return context.tyrano.plugin.kag
  }

  function applyMockScript(src) {
    if (src === 'tyrano/libs.js') {
      jQueryStub.loadQueue = function loadQueue() {}
      jQueryStub.loadText = function loadText() {}
    } else if (src === 'tyrano/tyrano.js') {
      context.tyrano = { plugin: {} }
      context.window.tyrano = context.tyrano
      context.TYRANO = {
        init() {
          initCalls.push('TYRANO.init')
        },
      }
      context.window.TYRANO = context.TYRANO
    } else if (src === 'tyrano/plugins/kag/kag.js') {
      context.tyrano.plugin.kag = { tag: {} }
    } else if (src === 'tyrano/plugins/kag/kag.event.js') {
      ensureKag().event = {}
    } else if (src === 'tyrano/plugins/kag/kag.key_mouse.js') {
      ensureKag().key_mouse = {}
    } else if (src === 'tyrano/plugins/kag/kag.layer.js') {
      ensureKag().layer = {}
    } else if (src === 'tyrano/plugins/kag/kag.menu.js') {
      ensureKag().menu = {}
    } else if (src === 'tyrano/plugins/kag/kag.parser.js') {
      ensureKag().parser = {}
    } else if (src === 'tyrano/plugins/kag/kag.rider.js') {
      ensureKag().rider = {}
    } else if (src === 'tyrano/plugins/kag/kag.studio.js') {
      ensureKag().studio = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_audio.js') {
      ensureKag().tag.playbgm = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_camera.js') {
      ensureKag().tag.camera = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_ext.js') {
      ensureKag().tag.loadjs = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_system.js') {
      ensureKag().tag.eval = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_vchat.js') {
      ensureKag().tag.vchat_in = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_ar.js') {
      ensureKag().tag.bgcamera = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag_three.js') {
      ensureKag().tag['3d_init'] = {}
    } else if (src === 'tyrano/plugins/kag/kag.tag.js') {
      ensureKag().ftag = {}
      ensureKag().tag.jump = {}
      ensureKag().tag.text = {}
    } else if (src === 'BrowserShell/electron_latest.js' && !options.skipBrowserPatchMarker) {
      context.TYRANO.browser_shell_ready = true
    }
  }

  const document = {
    body: { style: {} },
    createElement(tag) {
      return new ManagerElementShim(tag)
    },
    getElementById,
    head: {
      appendChild(scriptEl) {
        const src = String(scriptEl.src).replace(/^\.\//, '')
        if (src === options.failScript) {
          failed.push(src)
          if (scriptEl.onerror) scriptEl.onerror({ target: scriptEl })
        } else {
          loaded.push(src)
          applyMockScript(src)
          if (scriptEl.onload) scriptEl.onload()
        }
        return scriptEl
      },
    },
    addEventListener(type, callback) {
      if (type === 'DOMContentLoaded') callback()
    },
    querySelectorAll(selector) {
      if (selector === '.mod_checkbox:checked') {
        return selectedModIds.map((id) => ({
          getAttribute(attr) {
            return attr === 'data-id' ? id : ''
          },
        }))
      }
      return []
    },
  }

  context.document = document
  context.window = context
  if (options.modLoaderFails) {
    context.ModLoader = {
      getModList() {
        return Promise.resolve([])
      },
      init() {
        return Promise.reject(new Error('mod init failed'))
      },
    }
  }

  vm.createContext(context)
  vm.runInContext(managerSource, context, { filename: 'Modloader/manager.js' })

  return { alerts, context, elements, failed, initCalls, loaded, warnings }
}

async function flushMicrotasks() {
  await Promise.resolve()
  await Promise.resolve()
}

async function clickStart(harness) {
  harness.elements.get('start_game_btn').click()
  await flushMicrotasks()
}

function assertStartupStopped(harness) {
  const startBtn = harness.elements.get('start_game_btn')
  const overlay = harness.elements.get('tyrano_click_to_start')
  assert.equal(startBtn.disabled, false)
  assert.equal(startBtn.textContent, '启动游戏')
  assert.equal(overlay.removed, undefined)
  assert.deepEqual(harness.initCalls, [])
  assert.equal(harness.alerts.length, 1)
}

async function testScriptErrorStopsStartup() {
  const harness = createManagerHarness({ failScript: 'tyrano/libs.js' })
  await clickStart(harness)

  assert.deepEqual(harness.failed, ['tyrano/libs.js'])
  assert.equal(harness.loaded.includes('tyrano/tyrano.js'), false)
  assert.match(harness.alerts[0], /tyrano\/libs\.js/)
  assertStartupStopped(harness)
}

async function testBrowserPatchErrorStopsStartup() {
  const harness = createManagerHarness({ failScript: 'BrowserShell/electron_latest.js' })
  await clickStart(harness)

  assert.deepEqual(harness.failed, ['BrowserShell/electron_latest.js'])
  assert.match(harness.alerts[0], /BrowserShell\/electron_latest\.js/)
  assertStartupStopped(harness)
}

async function testSanityCheckStopsUnpatchedStartup() {
  const harness = createManagerHarness({ skipBrowserPatchMarker: true })
  await clickStart(harness)

  assert.equal(harness.failed.length, 0)
  assert.match(harness.alerts[0], /BrowserShell\/electron_latest\.js/)
  assertStartupStopped(harness)
}

async function testModLoaderFailureStopsStartup() {
  const harness = createManagerHarness({ modLoaderFails: true, selectedModIds: ['selected-mod'] })
  await clickStart(harness)

  assert.equal(harness.loaded.length, 0)
  assert.match(harness.alerts[0], /mod init failed/)
  assertStartupStopped(harness)
}

async function testModLoaderFailureWithoutSelectionContinues() {
  const harness = createManagerHarness({ modLoaderFails: true })
  await clickStart(harness)

  const overlay = harness.elements.get('tyrano_click_to_start')
  assert.deepEqual(harness.initCalls, ['TYRANO.init'])
  assert.equal(overlay.removed, true)
  assert.equal(harness.alerts.length, 0)
}

async function testSuccessfulStartupStillStartsGame() {
  const harness = createManagerHarness()
  await clickStart(harness)

  const overlay = harness.elements.get('tyrano_click_to_start')
  assert.deepEqual(harness.failed, [])
  assert.deepEqual(harness.initCalls, ['TYRANO.init'])
  assert.equal(overlay.removed, true)
  assert.equal(harness.alerts.length, 0)
}

const managerTests = [
  ['script error stops startup', testScriptErrorStopsStartup],
  ['browser patch error stops startup', testBrowserPatchErrorStopsStartup],
  ['sanity check stops unpatched startup', testSanityCheckStopsUnpatchedStartup],
  ['ModLoader failure stops startup', testModLoaderFailureStopsStartup],
  ['ModLoader failure without selection continues', testModLoaderFailureWithoutSelectionContinues],
  ['successful startup still starts game', testSuccessfulStartupStillStartsGame],
]

const suites = {
  'browser-shell': browserShellTests,
  manager: managerTests,
}

const requestedSuites = process.argv.slice(2)
const suiteNames = requestedSuites.length && requestedSuites[0] !== 'all'
  ? requestedSuites
  : Object.keys(suites)

for (const name of suiteNames) {
  if (!suites[name]) {
    console.error(`Unknown startup self-check suite: ${name}`)
    console.error(`Available suites: ${Object.keys(suites).join(', ')}`)
    process.exit(1)
  }
  await runSuite(name, suites[name])
}
