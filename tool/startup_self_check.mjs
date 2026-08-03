import assert from 'node:assert/strict'
import fs from 'node:fs'
import path from 'node:path'
import { fileURLToPath } from 'node:url'
import vm from 'node:vm'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const repoRoot = path.resolve(__dirname, '..')
const browserApiSource = fs.readFileSync(path.join(repoRoot, 'BrowserShell', 'browser_api.js'), 'utf8')
const electronLatestSource = fs.readFileSync(path.join(repoRoot, 'BrowserShell', 'electron_latest.js'), 'utf8')
const lzStringSource = fs.readFileSync(path.join(repoRoot, 'tyrano', 'libs', 'lz-string.min.js'), 'utf8')
const managerSource = fs.readFileSync(path.join(repoRoot, 'Modloader', 'manager.js'), 'utf8')
const markdownViewerSource = fs.readFileSync(path.join(repoRoot, 'Modloader', 'markdown_viewer.js'), 'utf8')

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

function createIndexedDBWriteStub(outcomes = []) {
  const persisted = new Map()
  let writeTransactions = 0

  const db = {
    objectStoreNames: {
      contains() { return true },
    },
    close() {},
    transaction(name, mode) {
      if (mode === 'readonly') {
        return {
          objectStore() {
            return {
              openCursor() {
                const request = {}
                const entries = Array.from(persisted.entries())
                let index = 0
                function emitCursor() {
                  const entry = entries[index]
                  const cursor = entry ? {
                    key: entry[0],
                    value: entry[1],
                    continue() {
                      index++
                      queueMicrotask(emitCursor)
                    },
                  } : null
                  request.onsuccess({ target: { result: cursor } })
                }
                queueMicrotask(emitCursor)
                return request
              },
            }
          },
        }
      }

      writeTransactions++
      const operations = []
      const outcome = outcomes.shift() || 'success'
      let scheduled = false
      let finished = false
      const tx = {
        error: null,
        abort() {
          finish('abort')
        },
        objectStore() {
          return {
            clear() {
              operations.push(['clear'])
              scheduleFinish()
            },
            delete(key) {
              operations.push(['delete', key])
              scheduleFinish()
            },
            put(value, key) {
              if (outcome === 'throw') {
                throw Object.assign(new Error('quota exceeded'), { name: 'QuotaExceededError' })
              }
              operations.push(['put', key, value])
              scheduleFinish()
            },
          }
        },
      }

      function scheduleFinish() {
        if (scheduled) return
        scheduled = true
        queueMicrotask(function () { finish(outcome) })
      }

      function finish(result) {
        if (finished) return
        finished = true
        if (result === 'fail' || result === 'abort') {
          const error = Object.assign(new Error('quota exceeded'), {
            name: result === 'fail' ? 'QuotaExceededError' : 'AbortError',
          })
          tx.error = error
          if (tx.onerror) tx.onerror({ target: { error } })
          if (tx.onabort) tx.onabort({ target: { error } })
          return
        }
        operations.forEach(function(operation) {
          if (operation[0] === 'clear') persisted.clear()
          if (operation[0] === 'delete') persisted.delete(operation[1])
          if (operation[0] === 'put') persisted.set(operation[1], operation[2])
        })
        if (tx.oncomplete) tx.oncomplete()
      }

      return tx
    },
  }

  const indexedDB = {
    open() {
      const request = {}
      queueMicrotask(function () {
        request.result = db
        request.onsuccess()
      })
      return request
    },
  }

  return {
    indexedDB,
    persisted,
    get writeTransactions() { return writeTransactions },
  }
}

function createBrowserShellHarness(options = {}) {
  const calls = []
  const swalCalls = []
  const indexedDB = options.indexedDB
  const localStorage = options.localStorage || createLocalStorageStub()
  const jqueryStub = createBrowserShellJQueryStub()
  const context = {
    ArrayBuffer,
    AudioContext: function AudioContext() {},
    Blob,
    DataView,
    Promise,
    Swal: {
      fire(config) {
        swalCalls.push(config)
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
    clearTimeout: options.clearTimeout || clearTimeout,
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
      getElementById(id) {
        return id === 'tyrano_base' ? options.gameBase || null : null
      },
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
    localStorage,
    location: {
      href: 'http://localhost:3000/index.html',
    },
    navigator: {},
    open() {},
    requestAnimationFrame: options.requestAnimationFrame,
    setTimeout: options.setTimeout || setTimeout,
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
          tag: {
            commit: {
              start: options.commitStart || function commitStart() {
                calls.push('original-commit')
              },
            },
          },
          tmp: {},
        },
      },
    },
  }
  context.window = context
  context.globalThis = context
  vm.createContext(context)
  vm.runInContext(browserApiSource, context, { filename: 'BrowserShell/browser_api.js' })
  vm.runInContext(lzStringSource, context, { filename: 'tyrano/libs/lz-string.min.js' })
  vm.runInContext(electronLatestSource, context, { filename: 'BrowserShell/electron_latest.js' })
  return { calls, context, swalCalls }
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

async function testIndexedDBFlushFailureRetainsPendingForRetry() {
  const idb = createIndexedDBWriteStub(['throw', 'success'])
  const key = 'DevilConnection_sf'
  idb.persisted.set(key, 'old-value')
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  await storage.ready

  storage.setItem(key, 'new-value')
  await assert.rejects(storage.flush(), { name: 'QuotaExceededError' })

  assert.equal(storage.getItem(key), 'new-value')
  assert.equal(idb.persisted.get(key), 'old-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), true)

  await storage.flush()
  assert.equal(idb.persisted.get(key), 'new-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), false)
  assert.equal(idb.writeTransactions, 2)
}

async function testIndexedDBLoadDoesNotOverwritePreReadyWrite() {
  const idb = createIndexedDBWriteStub(['success'])
  const key = 'DevilConnection_sf'
  idb.persisted.set(key, 'old-value')
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage

  storage.setItem(key, 'new-value')
  await storage.ready

  assert.equal(storage.getItem(key), 'new-value')
  await storage.flush()
  assert.equal(idb.persisted.get(key), 'new-value')
}

async function testIndexedDBAbortRetainsPendingForRetry() {
  const idb = createIndexedDBWriteStub(['abort', 'success'])
  const key = 'DevilConnection_tyrano_data'
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  await storage.ready

  storage.setItem(key, 'new-value')
  await assert.rejects(storage.flush(), { name: 'AbortError' })

  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), true)
  await storage.flush()
  assert.equal(idb.persisted.get(key), 'new-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), false)
}

async function testFailedFlushKeepsNewerConcurrentWrite() {
  const idb = createIndexedDBWriteStub(['fail', 'success'])
  const key = 'DevilConnection_sf'
  idb.persisted.set(key, 'old-value')
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  await storage.ready

  storage.setItem(key, 'first-value')
  const failedFlush = storage.flush()
  storage.setItem(key, 'second-value')
  await assert.rejects(failedFlush, { name: 'QuotaExceededError' })

  assert.equal(storage.getItem(key), 'second-value')
  assert.equal(idb.persisted.get(key), 'old-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), true)

  await storage.flush()
  assert.equal(idb.persisted.get(key), 'second-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), false)
}

async function testIndexedDBFlushKeepsNewerConcurrentWritePending() {
  const idb = createIndexedDBWriteStub(['success', 'success'])
  const key = 'DevilConnection_tyrano_data'
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  await storage.ready

  storage.setItem(key, 'first-value')
  const firstFlush = storage.flush()
  storage.setItem(key, 'second-value')
  await firstFlush

  assert.equal(idb.persisted.get(key), 'first-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), true)

  await storage.flush()
  assert.equal(idb.persisted.get(key), 'second-value')
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), false)
}

async function testScheduledFlushFailureIsReported() {
  const idb = createIndexedDBWriteStub(['fail'])
  const { context, swalCalls } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  await storage.ready

  storage.setItem('DevilConnection_sf', 'new-value')
  await new Promise((resolve) => setTimeout(resolve, 80))

  assert.equal(Object.keys(storage.pending).length, 1)
  assert.equal(swalCalls.length, 1)
  assert.equal(swalCalls[0].title, '存档写入失败')
}

async function testLocalStorageQuotaFailureIsReportedAndRetained() {
  const localStorage = createLocalStorageStub()
  localStorage.setItem = function setItem() {
    throw Object.assign(new Error('quota exceeded'), { name: 'QuotaExceededError' })
  }
  const { context, swalCalls } = createBrowserShellHarness({ localStorage })
  const storage = context.api.storage

  storage.setItem('DevilConnection_sf', 'new-value')

  assert.equal(storage.getItem('DevilConnection_sf'), 'new-value')
  assert.equal(Object.keys(storage.pending).length, 1)
  assert.equal(swalCalls.length, 1)
  await assert.rejects(storage.flush(), { name: 'QuotaExceededError' })
}

async function testLocalStorageFailedRemovalUsesPendingTombstone() {
  const localStorage = createLocalStorageStub()
  const key = 'DevilConnection_sf'
  localStorage.setItem(key, 'old-value')
  const removeItem = localStorage.removeItem.bind(localStorage)
  let removalFails = true
  localStorage.removeItem = function failingRemoveItem(value) {
    if (removalFails) {
      throw Object.assign(new Error('storage unavailable'), { name: 'UnknownError' })
    }
    removeItem(value)
  }
  const { context } = createBrowserShellHarness({ localStorage })
  const storage = context.api.storage

  storage.removeItem(key)
  assert.equal(storage.getItem(key), null)
  assert.equal(storage.keys().includes(key), false)
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), true)

  removalFails = false
  await storage.flush()
  assert.equal(localStorage.getItem(key), null)
  assert.equal(Object.prototype.hasOwnProperty.call(storage.pending, key), false)
}

async function testIndexedDBRepeatedFailuresPreserveLatestState() {
  const outcomes = []
  const idb = createIndexedDBWriteStub(outcomes)
  const { context } = createBrowserShellHarness({ indexedDB: idb.indexedDB })
  const storage = context.api.storage
  const expected = new Map()
  const keys = ['DevilConnection_sf', 'DevilConnection_tyrano_data', 'NEO']
  await storage.ready

  for (let i = 0; i < 30; i++) {
    const key = keys[i % keys.length]
    if (i % 5 === 4) {
      storage.removeItem(key)
      expected.delete(key)
    } else {
      const value = `value-${i}`
      storage.setItem(key, value)
      expected.set(key, value)
    }

    if (i % 3 === 0) {
      const beforeFailure = Array.from(idb.persisted.entries()).sort()
      outcomes.push(i % 2 === 0 ? 'fail' : 'abort')
      await assert.rejects(storage.flush())
      assert.deepEqual(Array.from(idb.persisted.entries()).sort(), beforeFailure)
      assert.ok(Object.keys(storage.pending).length > 0)
    }

    outcomes.push('success')
    await storage.flush()
    assert.deepEqual(Array.from(idb.persisted.entries()).sort(), Array.from(expected.entries()).sort())
    assert.equal(Object.keys(storage.pending).length, 0)
  }
}

function getSaveFormats(context, json) {
  return [
    ['raw JSON', json],
    ['percent-encoded JSON', encodeURIComponent(json)],
    ['legacy escaped JSON', escape(json)],
    ['compressed percent-encoded JSON', context.LZString.compress(encodeURIComponent(json))],
    ['compressed legacy escaped JSON', context.LZString.compress(escape(json))],
  ]
}

async function testSaveReadersPreserveSupportedFormats() {
  const json = JSON.stringify({ slot: 3, title: '恶魔连结 100%', nested: { ok: true } })

  for (const reader of ['getStorageWeb', 'getStorageCompress']) {
    const { context } = createBrowserShellHarness()
    for (const [format, stored] of getSaveFormats(context, json)) {
      const key = `save-${reader}-${format}`
      context.localStorage.setItem(key, stored)

      assert.equal(context.$[reader](key), json, `${reader} should read ${format}`)

      const encoded = encodeURIComponent(json)
      const canonical = reader === 'getStorageCompress'
        ? context.LZString.compress(encoded)
        : encoded
      assert.equal(
        context.localStorage.getItem(key),
        canonical,
        `${reader} should retain and normalize ${format}`,
      )
    }
  }
}

async function testSaveReadersRemoveOnlyInvalidData() {
  for (const reader of ['getStorageWeb', 'getStorageCompress']) {
    const { context } = createBrowserShellHarness()
    const key = `invalid-${reader}`
    context.localStorage.setItem(key, '%E0%A4%A')

    assert.equal(context.$[reader](key), null)
    assert.equal(context.localStorage.getItem(key), null)
  }
}

async function testSharedSaveDecoderIsSideEffectFree() {
  const { context } = createBrowserShellHarness()
  const json = JSON.stringify({ slot: 8, title: '共享解码器' })
  context.localStorage.setItem('unrelated-key', 'keep-me')

  for (const [format, stored] of getSaveFormats(context, json)) {
    const result = context.api.decodeSaveData(stored)
    assert.ok(result, `shared decoder should accept ${format}`)
    assert.equal(result.decoded, json)
  }

  assert.equal(context.api.decodeSaveData('bad'), null)
  assert.equal(context.localStorage.getItem('unrelated-key'), 'keep-me')
}

async function testFormCommitResetsScaledContainerScroll() {
  const gameBase = { scrollLeft: 17, scrollTop: 66 }
  const animationFrames = []
  const commitResult = { committed: true }
  const commitContext = { name: 'tag-context' }
  const commitParams = { source: 'test' }
  let receivedContext = null
  let receivedParams = null
  const { context } = createBrowserShellHarness({
    commitStart(pm) {
      receivedContext = this
      receivedParams = pm
      return commitResult
    },
    gameBase,
    requestAnimationFrame(callback) {
      animationFrames.push(callback)
      return animationFrames.length
    },
  })

  const result = context.tyrano.plugin.kag.tag.commit.start.call(
    commitContext,
    commitParams,
  )

  assert.equal(result, commitResult)
  assert.equal(receivedContext, commitContext)
  assert.equal(receivedParams, commitParams)
  assert.equal(gameBase.scrollTop, 0)
  assert.equal(gameBase.scrollLeft, 0)
  assert.equal(animationFrames.length, 1)

  gameBase.scrollTop = 31
  gameBase.scrollLeft = 9
  animationFrames[0]()
  assert.equal(gameBase.scrollTop, 0)
  assert.equal(gameBase.scrollLeft, 0)
}

const browserShellTests = [
  ['no IndexedDB fallback still starts', testNoIndexedDBFallbackStillStarts],
  ['IndexedDB open failure still starts', testIndexedDBOpenFailureStillStarts],
  ['IndexedDB flush failure retains pending for retry', testIndexedDBFlushFailureRetainsPendingForRetry],
  ['IndexedDB load keeps writes made before ready', testIndexedDBLoadDoesNotOverwritePreReadyWrite],
  ['IndexedDB abort retains pending for retry', testIndexedDBAbortRetainsPendingForRetry],
  ['failed flush keeps newer concurrent write', testFailedFlushKeepsNewerConcurrentWrite],
  ['IndexedDB flush keeps newer concurrent write pending', testIndexedDBFlushKeepsNewerConcurrentWritePending],
  ['scheduled flush failure is reported', testScheduledFlushFailureIsReported],
  ['localStorage quota failure is reported and retained', testLocalStorageQuotaFailureIsReportedAndRetained],
  ['localStorage failed removal uses pending tombstone', testLocalStorageFailedRemovalUsesPendingTombstone],
  ['IndexedDB repeated failures preserve latest state', testIndexedDBRepeatedFailuresPreserveLatestState],
  ['shared save decoder is side-effect free', testSharedSaveDecoderIsSideEffectFree],
  ['form commit resets scaled container scroll', testFormCommitResetsScaledContainerScroll],
  ['save readers preserve supported formats', testSaveReadersPreserveSupportedFormats],
  ['save readers remove only invalid data', testSaveReadersRemoveOnlyInvalidData],
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
  const confirmations = []
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
    FileReader: options.FileReader || function FileReader() {},
    Howler: { ctx: { resume() {}, state: 'running' } },
    JSZip: options.JSZip,
    Sortable: function Sortable() {
      this.destroy = function destroy() {}
    },
    TYRANO: {},
    URL: options.URL || {
      createObjectURL() { return 'blob:test' },
      revokeObjectURL() {},
    },
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
    confirm(message) {
      confirmations.push(String(message))
      if (options.confirmHandler) {
        return options.confirmHandler(String(message), confirmations.length)
      }
      return options.confirmResult !== false
    },
    fetch() {
      return Promise.resolve({ ok: false })
    },
    jQuery: jQueryStub,
    $: jQueryStub,
    localStorage: options.localStorage || {
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
  if (options.storage || options.decodeSaveData) {
    context.api = {
      storage: options.storage,
      decodeSaveData: options.decodeSaveData || function decodeSaveData(raw) {
        const seen = []
        const candidates = [String(raw)]
        try { candidates.push(decodeURIComponent(raw)) } catch (e) {}
        try { candidates.push(unescape(raw)) } catch (e) {}
        for (const candidate of candidates) {
          if (seen.includes(candidate)) continue
          seen.push(candidate)
          try {
            JSON.parse(candidate)
            return { decoded: candidate, format: 'test' }
          } catch (e) {}
        }
        return null
      },
    }
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
    body: new ManagerElementShim('body'),
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
  if (options.modLoader) {
    context.ModLoader = options.modLoader
  } else if (options.modLoaderFails) {
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

  return { alerts, confirmations, context, elements, failed, initCalls, loaded, warnings }
}

async function flushMicrotasks() {
  for (let i = 0; i < 24; i++) await Promise.resolve()
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
  assert.match(harness.alerts[0], /所选模组加载失败/)
  assert.match(harness.alerts[0], /mod init failed/)
  assertStartupStopped(harness)
}

async function testInvalidLocalAsarIsRejectedBeforeSelection() {
  let registrations = 0
  function FileReader() {}
  FileReader.prototype.readAsArrayBuffer = function readAsArrayBuffer() {
    this.onload({ target: { result: new ArrayBuffer(8) } })
  }
  const modLoader = {
    getModList() {
      return Promise.resolve([])
    },
    readAsarMeta() {
      return null
    },
    registerLocalMod() {
      registrations++
    },
  }
  const harness = createManagerHarness({ FileReader, modLoader })
  const fileInput = harness.elements.get('asar_file_input')

  fileInput.listeners.change({ target: { files: [{ name: 'broken.asar' }] } })
  await flushMicrotasks()

  assert.equal(registrations, 0)
  assert.match(harness.alerts.at(-1), /ASAR 文件无效或已损坏/)
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

async function testManifestCanDisableModByDefault() {
  const harness = createManagerHarness({
    modLoader: {
      getModList() {
        return Promise.resolve([
          { id: 'normal-mod', name: 'Normal mod' },
          { id: 'opt-in-mod', name: 'Opt-in mod', defaultEnabled: false },
        ])
      },
    },
  })
  await flushMicrotasks()

  const html = harness.elements.get('mod_list').innerHTML
  const normal = html.match(/<input[^>]+data-id="normal-mod"[^>]*>/)
  const optIn = html.match(/<input[^>]+data-id="opt-in-mod"[^>]*>/)
  assert.ok(normal)
  assert.ok(optIn)
  assert.match(normal[0], / checked/)
  assert.doesNotMatch(optIn[0], / checked/)
}

function createManagerStorageFixture(options = {}) {
  const values = new Map([
    ['DevilConnection_sf', 'sf-value'],
    ['DevilConnection_tyrano_data', 'save-value'],
    ['NEO', 'neo-value'],
    ['mod_config_test', 'mod-value'],
    ['_tyrano_browser_plugins/config/test.json', 'file-value'],
    ['_tyrano_other_app', 'other-tyrano-value'],
    ['AnotherDevilConnection_sf', 'other-game-value'],
    ['same_origin_state', 'same-origin-value'],
  ])
  const removed = []
  const written = []
  let flushes = 0
  const flushOutcomes = (options.flushOutcomes || []).slice()
  const storage = {
    ready: options.ready || Promise.resolve(true),
    flush() {
      flushes++
      const outcome = flushOutcomes.shift()
      if (outcome instanceof Error) return Promise.reject(outcome)
      return Promise.resolve()
    },
    getItem(key) {
      return values.has(key) ? values.get(key) : null
    },
    keys() {
      return Array.from(values.keys())
    },
    removeItem(key) {
      removed.push(key)
      values.delete(key)
    },
    setItem(key, value) {
      written.push([key, value])
      values.set(key, value)
    },
  }
  return { get flushes() { return flushes }, removed, storage, values, written }
}

function createDeferred() {
  let resolve
  const promise = new Promise((resolvePromise) => {
    resolve = resolvePromise
  })
  return { promise, resolve }
}

function createSaveImportStubs(entries, options = {}) {
  let loadCalls = 0
  function FileReader() {}
  FileReader.prototype.readAsArrayBuffer = function readAsArrayBuffer() {
    this.onload({ target: { result: new ArrayBuffer(0) } })
  }
  function JSZip() {}
  JSZip.loadAsync = function loadAsync() {
    loadCalls++
    if (options.loadError) return Promise.reject(options.loadError)
    return Promise.resolve({
      forEach(callback) {
        entries.forEach(function(entry) {
          callback(entry[0], {
            dir: false,
            async() {
              return entry[1] instanceof Error
                ? Promise.reject(entry[1])
                : Promise.resolve(entry[1])
            },
          })
        })
      },
    })
  }
  return { FileReader, JSZip, get loadCalls() { return loadCalls } }
}

async function testClearSavesKeepsNonSaveStorage() {
  const fixture = createManagerStorageFixture()
  const harness = createManagerHarness({ storage: fixture.storage })

  harness.context.clearAllSaves()
  await flushMicrotasks()

  assert.deepEqual(
    fixture.removed.sort(),
    ['DevilConnection_sf', 'DevilConnection_tyrano_data', 'NEO'].sort(),
  )
  assert.equal(fixture.values.get('mod_config_test'), 'mod-value')
  assert.equal(fixture.values.get('_tyrano_browser_plugins/config/test.json'), 'file-value')
  assert.equal(fixture.values.get('same_origin_state'), 'same-origin-value')
  assert.equal(fixture.flushes, 1)
  assert.match(harness.alerts.at(-1), /3 个存档数据/)
}

async function testExportIncludesOnlySaveStorage() {
  const fixture = createManagerStorageFixture()
  const files = new Map()
  function JSZip() {}
  JSZip.prototype.file = function file(name, value) {
    files.set(name, value)
  }
  JSZip.prototype.generateAsync = function generateAsync() {
    return Promise.resolve({})
  }
  const harness = createManagerHarness({ JSZip, storage: fixture.storage })

  harness.context.toggleSaveImport()
  await flushMicrotasks()

  assert.deepEqual(
    Array.from(files.keys()).sort(),
    ['DevilConnection_sf.sav', 'DevilConnection_tyrano_data.sav', 'NEO.sav'].sort(),
  )
  assert.equal(files.has('mod_config_test.sav'), false)
  assert.equal(files.has('_tyrano_browser_plugins%2Fconfig%2Ftest.json.sav'), false)
}

async function testSaveManagerWaitsForStorageReady() {
  const exportReady = createDeferred()
  const exportFixture = createManagerStorageFixture({ ready: exportReady.promise })
  const exportedFiles = new Map()
  let generated = 0
  function JSZip() {}
  JSZip.prototype.file = function file(name, value) {
    exportedFiles.set(name, value)
  }
  JSZip.prototype.generateAsync = function generateAsync() {
    generated++
    return Promise.resolve({})
  }
  const exportHarness = createManagerHarness({ JSZip, storage: exportFixture.storage })

  exportHarness.context.toggleSaveImport()
  await flushMicrotasks()
  assert.equal(exportedFiles.size, 0)
  assert.equal(generated, 0)

  exportReady.resolve(true)
  await flushMicrotasks()
  assert.equal(exportedFiles.size, 3)
  assert.equal(generated, 1)

  const clearReady = createDeferred()
  const clearFixture = createManagerStorageFixture({ ready: clearReady.promise })
  const clearHarness = createManagerHarness({ storage: clearFixture.storage })

  clearHarness.context.clearAllSaves()
  await flushMicrotasks()
  assert.equal(clearFixture.removed.length, 0)

  clearReady.resolve(true)
  await flushMicrotasks()
  assert.equal(clearFixture.removed.length, 3)

  const importReady = createDeferred()
  const importFixture = createManagerStorageFixture({ ready: importReady.promise })
  const importStubs = createSaveImportStubs([
    ['DevilConnection_ready_slot.sav', JSON.stringify({ slot: 'ready' })],
  ])
  const importHarness = createManagerHarness({
    FileReader: importStubs.FileReader,
    JSZip: importStubs.JSZip,
    storage: importFixture.storage,
  })

  importHarness.elements.get('import_save_input').listeners.change({
    target: { files: [{}] },
  })
  await flushMicrotasks()
  assert.equal(importStubs.loadCalls, 0)
  assert.equal(importFixture.written.length, 0)

  importReady.resolve(true)
  await flushMicrotasks()
  assert.equal(importStubs.loadCalls, 1)
  assert.deepEqual(importFixture.written, [
    ['DevilConnection_ready_slot', JSON.stringify({ slot: 'ready' })],
  ])
}

async function testExportFailureIsReported() {
  const fixture = createManagerStorageFixture()
  function JSZip() {}
  JSZip.prototype.file = function file() {}
  JSZip.prototype.generateAsync = function generateAsync(options, onUpdate) {
    onUpdate({ percent: 42 })
    return Promise.reject(new Error('archive out of memory'))
  }
  const harness = createManagerHarness({ JSZip, storage: fixture.storage })

  harness.context.toggleSaveImport()
  await flushMicrotasks()

  assert.match(harness.alerts.at(-1), /导出失败：archive out of memory/)
  assert.equal(harness.elements.get('save_operation_status').textContent, '')
  assert.equal(harness.context._importingSave, false)
}

async function testImportIgnoresNonSaveStorage() {
  const fixture = createManagerStorageFixture()
  const importedSf = encodeURIComponent(JSON.stringify({ imported: 'sf' }))
  const importedNeo = JSON.stringify('imported-neo')
  const stubs = createSaveImportStubs([
    ['DevilConnection_sf.sav', importedSf],
    ['NEO.sav', importedNeo],
    ['mod_config_test.sav', 'injected-mod-config'],
    ['_tyrano_browser_secret.sav', 'injected-file-data'],
  ])
  const harness = createManagerHarness({
    FileReader: stubs.FileReader,
    JSZip: stubs.JSZip,
    storage: fixture.storage,
  })
  const importInput = harness.elements.get('import_save_input')

  importInput.listeners.change({ target: { files: [{}] } })
  await flushMicrotasks()

  assert.deepEqual(fixture.written.sort(), [
    ['DevilConnection_sf', importedSf],
    ['NEO', importedNeo],
  ].sort())
  assert.equal(fixture.values.get('mod_config_test'), 'mod-value')
  assert.equal(fixture.values.has('_tyrano_browser_secret'), false)
  assert.match(harness.alerts.at(-1), /2 个非存档项已忽略/)
}

async function testImportRejectsInvalidAndDuplicateSaves() {
  const invalidFixture = createManagerStorageFixture()
  const invalidStubs = createSaveImportStubs([
    ['DevilConnection_sf.sav', JSON.stringify({ imported: true })],
    ['NEO.sav', 'not-json'],
  ])
  const invalidHarness = createManagerHarness({
    FileReader: invalidStubs.FileReader,
    JSZip: invalidStubs.JSZip,
    storage: invalidFixture.storage,
  })

  invalidHarness.elements.get('import_save_input').listeners.change({ target: { files: [{}] } })
  await flushMicrotasks()

  assert.deepEqual(invalidFixture.written, [])
  assert.equal(invalidFixture.flushes, 0)
  assert.equal(invalidFixture.values.get('DevilConnection_sf'), 'sf-value')
  assert.match(invalidHarness.alerts.at(-1), /存档内容无效或已损坏：NEO/)

  const duplicateFixture = createManagerStorageFixture()
  const duplicateStubs = createSaveImportStubs([
    ['DevilConnection_sf.sav', JSON.stringify({ first: true })],
    ['DevilConnection_%73f.sav', JSON.stringify({ second: true })],
  ])
  const duplicateHarness = createManagerHarness({
    FileReader: duplicateStubs.FileReader,
    JSZip: duplicateStubs.JSZip,
    storage: duplicateFixture.storage,
  })

  duplicateHarness.elements.get('import_save_input').listeners.change({ target: { files: [{}] } })
  await flushMicrotasks()

  assert.deepEqual(duplicateFixture.written, [])
  assert.equal(duplicateFixture.flushes, 0)
  assert.match(duplicateHarness.alerts.at(-1), /重复存档键：DevilConnection_sf/)
}

async function testImportCanCancelOverwriteBeforeWriting() {
  const fixture = createManagerStorageFixture()
  const stubs = createSaveImportStubs([
    ['DevilConnection_sf.sav', JSON.stringify({ imported: true })],
  ])
  const harness = createManagerHarness({
    FileReader: stubs.FileReader,
    JSZip: stubs.JSZip,
    confirmHandler(message) {
      return message.indexOf('导入将覆盖') === -1
    },
    storage: fixture.storage,
  })

  harness.elements.get('import_save_input').listeners.change({ target: { files: [{}] } })
  await flushMicrotasks()

  assert.deepEqual(fixture.written, [])
  assert.equal(fixture.flushes, 0)
  assert.match(harness.confirmations.at(-1), /覆盖 1 个现有存档/)
  assert.equal(fixture.values.get('DevilConnection_sf'), 'sf-value')
}

async function testImportWriteFailureRestoresPreviousSaves() {
  const writeError = Object.assign(new Error('quota exceeded'), { name: 'QuotaExceededError' })
  const fixture = createManagerStorageFixture({ flushOutcomes: [writeError, null] })
  const importedSf = JSON.stringify({ imported: true })
  const stubs = createSaveImportStubs([
    ['DevilConnection_sf.sav', importedSf],
  ])
  const harness = createManagerHarness({
    FileReader: stubs.FileReader,
    JSZip: stubs.JSZip,
    storage: fixture.storage,
  })

  harness.elements.get('import_save_input').listeners.change({ target: { files: [{}] } })
  await flushMicrotasks()

  assert.equal(fixture.flushes, 2)
  assert.deepEqual(fixture.written, [
    ['DevilConnection_sf', importedSf],
    ['DevilConnection_sf', 'sf-value'],
  ])
  assert.equal(fixture.values.get('DevilConnection_sf'), 'sf-value')
  assert.match(harness.alerts.at(-1), /浏览器存储写入失败，原有存档已恢复/)
  assert.doesNotMatch(harness.alerts.at(-1), /ZIP 格式错误/)
}

const managerTests = [
  ['script error stops startup', testScriptErrorStopsStartup],
  ['browser patch error stops startup', testBrowserPatchErrorStopsStartup],
  ['sanity check stops unpatched startup', testSanityCheckStopsUnpatchedStartup],
  ['ModLoader failure stops startup', testModLoaderFailureStopsStartup],
  ['invalid local ASAR is rejected before selection', testInvalidLocalAsarIsRejectedBeforeSelection],
  ['ModLoader failure without selection continues', testModLoaderFailureWithoutSelectionContinues],
  ['successful startup still starts game', testSuccessfulStartupStillStartsGame],
  ['manifest can disable a mod by default', testManifestCanDisableModByDefault],
  ['clear saves keeps non-save storage', testClearSavesKeepsNonSaveStorage],
  ['export includes only save storage', testExportIncludesOnlySaveStorage],
  ['save manager waits for storage ready', testSaveManagerWaitsForStorageReady],
  ['export failure is reported', testExportFailureIsReported],
  ['import ignores non-save storage', testImportIgnoresNonSaveStorage],
  ['import rejects invalid and duplicate saves', testImportRejectsInvalidAndDuplicateSaves],
  ['import can cancel overwrite before writing', testImportCanCancelOverwriteBeforeWriting],
  ['import write failure restores previous saves', testImportWriteFailureRestoresPreviousSaves],
]

function renderMarkdown(markdown) {
  const context = { console }
  vm.createContext(context)
  vm.runInContext(markdownViewerSource, context, { filename: 'Modloader/markdown_viewer.js' })
  return context.ManagerMarkdown.render(markdown)
}

async function testMarkdownCodeLinkLabels() {
  const markdown = [
    '- [`Modloader/README.md`](Modloader/README.md)：模组加载器边界、约束与验证清单',
    '- [`tool/README.md`](tool/README.md)：本地工具与 DevTools 调试入口',
    '- [`AGENTS.md`](AGENTS.md)：给 AI agent 的项目结构、运行时事实与维护约定',
  ].join('\n')
  const html = renderMarkdown(markdown)

  assert.match(html, /<a href="Modloader\/README\.md"[^>]*><code>Modloader\/README\.md<\/code><\/a>/)
  assert.match(html, /<a href="tool\/README\.md"[^>]*><code>tool\/README\.md<\/code><\/a>/)
  assert.match(html, /<a href="AGENTS\.md"[^>]*><code>AGENTS\.md<\/code><\/a>/)
  assert.equal(html.includes('\u0000'), false)
}

const markdownTests = [
  ['code-formatted link labels render correctly', testMarkdownCodeLinkLabels],
]

const suites = {
  'browser-shell': browserShellTests,
  manager: managerTests,
  markdown: markdownTests,
}

const requestedSuites = process.argv.slice(2)
const suiteNames = requestedSuites.length && requestedSuites[0] !== 'all'
  ? requestedSuites
  : Object.keys(suites)

for (const name of suiteNames) {
  if (!suites[name]) {
    console.error(`Unknown self-check suite: ${name}`)
    console.error(`Available suites: ${Object.keys(suites).join(', ')}`)
    process.exit(1)
  }
  await runSuite(name, suites[name])
}
