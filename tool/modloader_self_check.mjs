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

function createJQueryStub() {
  function jqueryStub() {
    return Object.create(jqueryStub.fn)
  }
  jqueryStub.fn = {
    css() {
      return this
    },
  }
  jqueryStub.loadText = function loadText(pathValue, cb) {
    if (cb) cb('')
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

function createHarness() {
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
      this.values = {}
    }

    setProperty(prop, value) {
      this.values[prop] = value
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
    open(method, url) {
      this.method = method
      this.url = url
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

  async function fetchStub(input) {
    const url = typeof input === 'string' ? input : (input && input.url) || ''
    fetchCalls.push(url)
    if (url === './mods/mods.json') {
      return {
        ok: true,
        status: 200,
        json: async () => [],
        arrayBuffer: async () => new ArrayBuffer(0),
      }
    }
    return {
      ok: false,
      status: 404,
      json: async () => ({}),
      arrayBuffer: async () => new ArrayBuffer(0),
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

  const jqueryStub = createJQueryStub()
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
  return fetchCalls.filter((url) => url === './mods/mods.json').length
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

const tests = [
  ['ASAR path normalization', testAsarPathNormalization],
  ['ASAR offset validation', testAsarOffsetValidation],
  ['repeated init guard', testRepeatedInitGuard],
]

for (const [name, test] of tests) {
  await test()
  console.log(`ok - ${name}`)
}
