import assert from 'node:assert/strict'
import { Blob } from 'node:buffer'
import fs from 'node:fs'
import path from 'node:path'
import { TextDecoder, TextEncoder } from 'node:util'
import { fileURLToPath, URL } from 'node:url'
import vm from 'node:vm'

const __dirname = path.dirname(fileURLToPath(import.meta.url))
const repoRoot = path.resolve(__dirname, '..')
const loaderSource = fs.readFileSync(path.join(repoRoot, 'Modloader', 'mod_loader.js'), 'utf8')

async function runTests(tests) {
  for (const [name, test] of tests) {
    await test()
    console.log(`ok - ${name}`)
  }
}

function align4(n) {
  return n + ((4 - (n % 4)) % 4)
}

function toArrayBuffer(buffer) {
  return buffer.buffer.slice(buffer.byteOffset, buffer.byteOffset + buffer.byteLength)
}

function addHeaderEntry(root, filePath, entry) {
  const parts = filePath.split('/').filter(Boolean)
  let tree = root
  for (let i = 0; i < parts.length; i += 1) {
    const name = parts[i]
    if (i === parts.length - 1) {
      tree.files[name] = entry
    } else {
      tree.files[name] ||= { files: {} }
      tree = tree.files[name]
    }
  }
}

function assembleAsar(header, dataBuffer) {
  const headerJson = Buffer.from(JSON.stringify(header), 'utf8')
  const paddedHeader = Buffer.alloc(align4(headerJson.length))
  const prefix = Buffer.alloc(16)
  headerJson.copy(paddedHeader)
  prefix.writeUInt32LE(0, 0)
  prefix.writeUInt32LE(0, 4)
  prefix.writeUInt32LE(paddedHeader.length + 4, 8)
  prefix.writeUInt32LE(headerJson.length, 12)
  return toArrayBuffer(Buffer.concat([prefix, paddedHeader, dataBuffer]))
}

function buildAsar(files) {
  const header = { files: {} }
  const dataParts = []
  let offset = 0
  for (const [filePath, content] of Object.entries(files)) {
    const data = Buffer.isBuffer(content) ? content : Buffer.from(String(content), 'utf8')
    addHeaderEntry(header, filePath, { offset: String(offset), size: data.length })
    dataParts.push(data)
    offset += data.length
  }
  return assembleAsar(header, Buffer.concat(dataParts))
}

function buildOffsetValidationAsar() {
  const header = { files: {} }
  const goodData = Buffer.from('good', 'utf8')
  const entries = {
    'good.txt': { offset: '0', size: 4 },
    'bad-negative.txt': { offset: '-1', size: 1 },
    'bad-float-offset.txt': { offset: 0.5, size: 1 },
    'bad-float-size.txt': { offset: 0, size: 1.5 },
    'bad-huge-offset.txt': { offset: '9007199254740992', size: 1 },
    'bad-out-of-range.txt': { offset: '99', size: 1 },
    'bad-overflow.txt': { offset: '3', size: 2 },
  }
  for (const [filePath, entry] of Object.entries(entries)) addHeaderEntry(header, filePath, entry)
  return assembleAsar(header, goodData)
}

function createJQueryStub(options = {}) {
  function jqueryStub() {
    return Object.create(jqueryStub.fn)
  }
  jqueryStub.cssCalls = []
  jqueryStub.fn = {
    css(...args) {
      jqueryStub.cssCalls.push({ target: this, args })
      return this
    },
  }
  if (options.withLoadText !== false) {
    jqueryStub.loadText = function loadText(pathValue, cb) {
      if (cb) cb('')
    }
  }
  jqueryStub.loadQueue = function loadQueue(url) {
    return url
  }
  jqueryStub.ajax = function ajax() {
    return {
      done(callback) {
        if (callback) callback()
        return this
      },
    }
  }
  jqueryStub.getScript = function getScript(url, callback) {
    if (callback) callback()
    return jqueryStub.ajax({ url })
  }
  return jqueryStub
}

function createHarness(options = {}) {
  const fetchCalls = []
  const warnings = []
  const logs = []
  let blobCounter = 0

  class URLShim extends URL {}
  URLShim.createObjectURL = function createObjectURL() {
    blobCounter += 1
    return `blob:http://localhost:3000/modloader-self-check-${blobCounter}`
  }
  URLShim.revokeObjectURL = function revokeObjectURL() {}

  class CSSStyleDeclarationShim {
    constructor() {
      this.calls = []
      this.values = {}
    }

    setProperty(prop, value, priority) {
      this.calls.push({ prop, value, priority })
      this.values[prop] = value
      return 'setProperty-result'
    }
  }

  class ElementShim {
    constructor(tagName = 'div') {
      this.tagName = String(tagName).toUpperCase()
      this.attributes = {}
      this.children = []
      this.style = new CSSStyleDeclarationShim()
    }

    setAttribute(attr, value) {
      this.attributes[attr] = String(value)
      if (attr === 'src') this.src = value
      if (attr === 'href') this.href = value
      return 'setAttribute-result'
    }

    getAttribute(attr) {
      return this.attributes[attr] ?? null
    }

    appendChild(child) {
      this.children.push(child)
      return child
    }
  }

  Object.defineProperty(ElementShim.prototype, 'innerHTML', {
    get() {
      return this._innerHTML || ''
    },
    set(value) {
      this._innerHTML = String(value)
    },
    configurable: true,
  })

  function defineURLProperty(proto, prop) {
    Object.defineProperty(proto, prop, {
      get() {
        return this[`_${prop}`] || ''
      },
      set(value) {
        this[`_${prop}`] = String(value)
      },
      configurable: true,
    })
  }

  class HTMLImageElementShim extends ElementShim {
    constructor() {
      super('img')
    }
  }
  class HTMLVideoElementShim extends ElementShim {
    constructor() {
      super('video')
    }
  }
  class HTMLScriptElementShim extends ElementShim {
    constructor() {
      super('script')
    }
  }
  class HTMLLinkElementShim extends ElementShim {
    constructor() {
      super('link')
    }
  }

  defineURLProperty(HTMLImageElementShim.prototype, 'src')
  defineURLProperty(HTMLVideoElementShim.prototype, 'src')
  defineURLProperty(HTMLScriptElementShim.prototype, 'src')
  defineURLProperty(HTMLLinkElementShim.prototype, 'href')

  class XMLHttpRequestShim {
    open(...args) {
      this.openArgs = args
      this.method = args[0]
      this.url = args[1]
    }
  }

  class AudioShim {
    constructor(src) {
      this.src = src || ''
    }
  }

  const document = {
    createElement(tagName) {
      const tag = String(tagName || '').toLowerCase()
      if (tag === 'img') return new HTMLImageElementShim()
      if (tag === 'video') return new HTMLVideoElementShim()
      if (tag === 'script') return new HTMLScriptElementShim()
      if (tag === 'link') return new HTMLLinkElementShim()
      return new ElementShim(tag)
    },
  }

  const localStorage = new Map()
  const localStorageShim = {
    getItem(key) {
      return localStorage.has(key) ? localStorage.get(key) : null
    },
    setItem(key, value) {
      localStorage.set(key, String(value))
    },
    removeItem(key) {
      localStorage.delete(key)
    },
  }

  async function fetchStub(input, init) {
    const url = typeof input === 'string' ? input : (input && input.url) || ''
    fetchCalls.push({ input, init, url })
    if (url === './mods/mods.json') {
      const modList = options.modList || []
      return {
        ok: true,
        status: 200,
        json: async () => modList,
        arrayBuffer: async () => new ArrayBuffer(0),
        text: async () => JSON.stringify(modList),
      }
    }
    if (options.fetchBuffers && Object.prototype.hasOwnProperty.call(options.fetchBuffers, url)) {
      const buffer = options.fetchBuffers[url]
      return {
        ok: true,
        status: 200,
        json: async () => ({}),
        arrayBuffer: async () => buffer,
        text: async () => '',
      }
    }
    return {
      ok: false,
      status: 404,
      json: async () => ({}),
      arrayBuffer: async () => new ArrayBuffer(0),
      text: async () => '',
    }
  }

  const context = {
    ArrayBuffer,
    Audio: AudioShim,
    Blob,
    CSSStyleDeclaration: CSSStyleDeclarationShim,
    DataView,
    Element: ElementShim,
    HTMLImageElement: HTMLImageElementShim,
    HTMLLinkElement: HTMLLinkElementShim,
    HTMLScriptElement: HTMLScriptElementShim,
    HTMLVideoElement: HTMLVideoElementShim,
    Image: HTMLImageElementShim,
    Map,
    Number,
    Promise,
    Request,
    TextDecoder,
    TextEncoder,
    Uint8Array,
    URL: URLShim,
    XMLHttpRequest: XMLHttpRequestShim,
    addEventListener() {},
    clearTimeout,
    console: {
      log(...args) {
        logs.push(args.map(String).join(' '))
      },
      warn(...args) {
        warnings.push(args.map(String).join(' '))
      },
      error(...args) {
        warnings.push(args.map(String).join(' '))
      },
    },
    document,
    fetch: fetchStub,
    isFinite,
    localStorage: localStorageShim,
    location: {
      href: 'http://localhost:3000/index.html',
      origin: 'http://localhost:3000',
      pathname: '/index.html',
      protocol: 'http:',
    },
    setTimeout,
  }

  const jqueryStub = createJQueryStub(options)
  context.$ = jqueryStub
  context.jQuery = jqueryStub
  context.window = context
  context.globalThis = context

  vm.createContext(context)
  vm.runInContext(loaderSource, context, { filename: 'Modloader/mod_loader.js' })

  return {
    context,
    fetchCalls,
    logs,
    ModLoader: context.ModLoader,
    warnings,
  }
}

function countModIndexFetches(fetchCalls) {
  return fetchCalls.filter((call) => call.url === './mods/mods.json').length
}

function testAsarPathNormalization() {
  const { ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  const indexed = ModLoader.parseAndIndex(asar)
  assert.equal(indexed.meta.id, 'self-check')

  for (const pathValue of [
    'data/system/KeyConfig.js',
    './data/system/KeyConfig.js?_=123',
    '/data/system/KeyConfig.js?v_=123#hash',
    'http://localhost:3000/data/system/KeyConfig.js?v_=123#hash',
  ]) {
    assert.equal(ModLoader.hasFile(pathValue), true, `${pathValue} should match the ASAR entry`)
  }

  assert.equal(ModLoader.hasFile('https://example.invalid/data/system/KeyConfig.js'), false)
  assert.equal(ModLoader.hasFile('blob:http://localhost:3000/not-a-real-file'), false)
  assert.equal(ModLoader.hasFile('data:text/plain,hello'), false)

  const resolved = ModLoader.resolveURL('http://localhost:3000/data/system/KeyConfig.js?v_=123')
  assert.match(resolved, /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
}

function testAsarOffsetValidation() {
  const { ModLoader } = createHarness()
  const asar = buildOffsetValidationAsar()

  const indexed = ModLoader.parseAndIndex(asar)
  assert.ok(indexed, 'ASAR with some bad entries should still parse')
  assert.equal(ModLoader.hasFile('good.txt'), true)
  assert.equal(ModLoader.readAsarFileText(asar, 'good.txt'), 'good')

  for (const pathValue of [
    'bad-negative.txt',
    'bad-float-offset.txt',
    'bad-float-size.txt',
    'bad-huge-offset.txt',
    'bad-out-of-range.txt',
    'bad-overflow.txt',
  ]) {
    assert.equal(ModLoader.hasFile(pathValue), false, `${pathValue} should not be indexed`)
    assert.equal(ModLoader.readAsarFileText(asar, pathValue), null, `${pathValue} should not be readable`)
  }
}

async function testRepeatedInitGuard() {
  const { context, fetchCalls, ModLoader, warnings } = createHarness()
  const originalFetch = context.fetch

  assert.equal(await ModLoader.init([]), true)
  assert.equal(countModIndexFetches(fetchCalls), 1)
  const wrappedFetch = context.fetch
  assert.notEqual(wrappedFetch, originalFetch, 'init should wire fetch in a browser-like environment')

  assert.equal(await ModLoader.init([]), true)
  assert.equal(await ModLoader.init(['different-after-init']), true)
  assert.equal(context.fetch, wrappedFetch, 'repeated init should not wrap fetch again')
  assert.equal(countModIndexFetches(fetchCalls), 1, 'repeated init should not reload mods.json')
  assert.ok(
    warnings.some((line) => line.includes('init already completed; ignoring different mod selection')),
    'different repeated init should warn instead of mutating loaded state',
  )
}

async function testXHRInterceptorPreservesOpenArguments() {
  const { context, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const xhr = new context.XMLHttpRequest()
  xhr.open('POST', 'data/system/KeyConfig.js', false, 'user-name', 'password-value')

  assert.equal(xhr.openArgs[0], 'POST')
  assert.match(xhr.openArgs[1], /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
  assert.equal(xhr.openArgs[2], false, 'async flag should be preserved')
  assert.equal(xhr.openArgs[3], 'user-name', 'username should be preserved')
  assert.equal(xhr.openArgs[4], 'password-value', 'password should be preserved')
}

async function testFetchInterceptorPreservesInit() {
  const { context, fetchCalls, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const init = {
    method: 'POST',
    headers: { 'X-Self-Check': '1' },
    cache: 'no-store',
  }
  await context.fetch('data/system/KeyConfig.js', init)

  const call = fetchCalls[fetchCalls.length - 1]
  assert.match(call.url, /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
  assert.equal(call.init, init, 'fetch init should be forwarded for string URLs')
}

async function testFetchInterceptorPreservesRequestInput() {
  const { context, fetchCalls, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const request = new Request('http://localhost:3000/data/system/KeyConfig.js', {
    method: 'HEAD',
    headers: { 'X-Self-Check': '1' },
    cache: 'reload',
  })
  await context.fetch(request)

  const call = fetchCalls[fetchCalls.length - 1]
  assert.ok(call.input instanceof Request, 'Request input should stay a Request')
  assert.match(call.input.url, /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
  assert.equal(call.input.method, 'HEAD')
  assert.equal(call.input.headers.get('X-Self-Check'), '1')
  assert.equal(call.input.cache, 'reload')
}

async function testCSSInterceptorsPreserveSemantics() {
  const { context, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const cssObject = {
    background: 'url(data/system/KeyConfig.js)',
    color: 'red',
  }
  context.$().css(cssObject)

  assert.equal(cssObject.background, 'url(data/system/KeyConfig.js)', 'css object should not be mutated')
  const cssCall = context.$.cssCalls[context.$.cssCalls.length - 1]
  assert.notEqual(cssCall.args[0], cssObject, 'rewritten css object should be a copy')
  assert.match(cssCall.args[0].background, /^url\("blob:http:\/\/localhost:3000\/modloader-self-check-\d+"\)$/)
  assert.equal(cssCall.args[0].color, 'red')

  const style = new context.CSSStyleDeclaration()
  const result = style.setProperty('background-image', 'url(data/system/KeyConfig.js)', 'important')
  const setPropertyCall = style.calls[style.calls.length - 1]

  assert.equal(result, 'setProperty-result', 'setProperty return value should be preserved')
  assert.match(setPropertyCall.value, /^url\("blob:http:\/\/localhost:3000\/modloader-self-check-\d+"\)$/)
  assert.equal(setPropertyCall.priority, 'important', 'setProperty priority should be preserved')
}

async function testLoadTextInterceptorPreservesAsyncCallback() {
  const { context, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  let loadedText = null
  context.$.loadText('data/system/KeyConfig.js', function (text) {
    loadedText = text
  })

  assert.equal(loadedText, null, 'ASAR loadText callback should not run synchronously')
  await new Promise((resolve) => setTimeout(resolve, 0))
  assert.equal(loadedText, 'window.__key_config_self_check__ = true')
}

async function testLoadTextInterceptorFallbackWithoutOriginal() {
  const { context, ModLoader } = createHarness({ withLoadText: false })

  assert.equal(await ModLoader.init([]), true)

  const loadedText = await new Promise((resolve) => {
    context.$.loadText('missing.txt', function (text) {
      resolve(text)
    })
  })

  assert.equal(loadedText, '', 'loadText fallback should resolve misses as empty text')
}

async function testSetAttributeInterceptorPreservesSemantics() {
  const { context, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const img = context.document.createElement('img')
  const result = img.setAttribute('SRC', 'data/system/KeyConfig.js')

  assert.equal(result, 'setAttribute-result', 'setAttribute return value should be preserved')
  assert.match(img.attributes.SRC, /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
}

async function testAudioInterceptorPreservesPrototype() {
  const { context, ModLoader } = createHarness()
  const asar = buildAsar({
    'mods.json': JSON.stringify({ id: 'self-check', name: 'self-check' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })

  assert.equal(await ModLoader.init([]), true)
  ModLoader.parseAndIndex(asar)

  const audio = new context.Audio('data/system/KeyConfig.js')

  assert.ok(audio instanceof context.Audio, 'Audio wrapper should preserve instanceof Audio')
  assert.match(audio.src, /^blob:http:\/\/localhost:3000\/modloader-self-check-\d+$/)
}

async function testGetModListWithSchemaUsesPerModAsar() {
  const withSchema = buildAsar({
    'mods.json': JSON.stringify({ id: 'has-schema', name: 'has-schema' }),
    'config.schema.json': JSON.stringify({ fields: [{ key: 'enabled', type: 'toggle' }] }),
  })
  const withoutSchema = buildAsar({
    'mods.json': JSON.stringify({ id: 'no-schema', name: 'no-schema' }),
    'data/system/KeyConfig.js': 'window.__key_config_self_check__ = true',
  })
  const localWithSchema = buildAsar({
    'mods.json': JSON.stringify({ id: 'local-schema', name: 'local-schema' }),
    'config.schema.json': JSON.stringify({ fields: [{ key: 'level', type: 'number' }] }),
  })
  const originalModList = [
    { id: 'has-schema', name: 'Has Schema', file: 'has-schema.asar' },
    { id: 'no-schema', name: 'No Schema', file: 'no-schema.asar' },
    { id: 'local-schema', name: 'Local Schema', file: 'local-schema.asar' },
    { id: 'missing-file', name: 'Missing File', file: 'missing-file.asar' },
  ]
  const { ModLoader } = createHarness({
    modList: originalModList,
    fetchBuffers: {
      './mods/has-schema.asar': withSchema,
      './mods/no-schema.asar': withoutSchema,
      './mods/local-schema.asar': withoutSchema,
    },
  })

  ModLoader.parseAndIndex(withSchema)
  ModLoader.registerLocalMod('local-schema', localWithSchema)

  const list = await ModLoader.getModListWithSchema()

  const schemaFlags = JSON.parse(JSON.stringify(list.map((entry) => [entry.id, entry.hasSchema])))
  assert.deepEqual(
    schemaFlags,
    [
      ['has-schema', true],
      ['no-schema', false],
      ['local-schema', true],
      ['missing-file', false],
    ],
  )
  assert.equal(originalModList[0].hasSchema, undefined, 'getModListWithSchema should not mutate getModList entries')
}

const tests = [
  ['ASAR path normalization', testAsarPathNormalization],
  ['ASAR offset validation', testAsarOffsetValidation],
  ['repeated init guard', testRepeatedInitGuard],
  ['XHR interceptor argument preservation', testXHRInterceptorPreservesOpenArguments],
  ['fetch interceptor init preservation', testFetchInterceptorPreservesInit],
  ['fetch interceptor Request preservation', testFetchInterceptorPreservesRequestInput],
  ['CSS interceptor semantic preservation', testCSSInterceptorsPreserveSemantics],
  ['loadText interceptor async preservation', testLoadTextInterceptorPreservesAsyncCallback],
  ['loadText interceptor fallback without original', testLoadTextInterceptorFallbackWithoutOriginal],
  ['setAttribute interceptor semantic preservation', testSetAttributeInterceptorPreservesSemantics],
  ['Audio interceptor prototype preservation', testAudioInterceptorPreservesPrototype],
  ['getModListWithSchema per-mod schema detection', testGetModListWithSchemaUsesPerModAsar],
]

await runTests(tests)
