/*
 * Browser DCML mod loader.
 *
 * Owns ASAR parsing, resource override indexing, browser resource
 * interception, hook.js execution, and the public window.ModLoader API.
 * Manager UI and Electron/Node compatibility shims live in manager.js and
 * mod_compat.js respectively; keep those boundaries separate.
 */
;(function () {
  if (window.ModLoader) return

  var mimeMap = {
    png: 'image/png',
    webp: 'image/webp',
    jpg: 'image/jpeg',
    jpeg: 'image/jpeg',
    gif: 'image/gif',
    svg: 'image/svg+xml',
    ogg: 'audio/ogg',
    mp3: 'audio/mpeg',
    m4a: 'audio/mp4',
    wav: 'audio/wav',
    mp4: 'video/mp4',
    webm: 'video/webm',
    ks: 'text/plain',
    tjs: 'text/plain',
    js: 'application/javascript',
    json: 'application/json',
    html: 'text/html',
    css: 'text/css',
    ttf: 'font/ttf',
    woff: 'font/woff',
    woff2: 'font/woff2',
  }

  function getMime(path) {
    var ext = path.split('.').pop().toLowerCase()
    return mimeMap[ext] || 'application/octet-stream'
  }

  function stripURLSuffix(path) {
    var value = String(path || '')
    var q = value.indexOf('?')
    var h = value.indexOf('#')
    var cut = -1
    if (q >= 0) cut = q
    if (h >= 0 && (cut < 0 || h < cut)) cut = h
    return cut >= 0 ? value.slice(0, cut) : value
  }

  function safeDecodePath(path) {
    try { return decodeURIComponent(path) } catch (e) { return path }
  }

  function getPageBasePath() {
    var loc = typeof location !== 'undefined' ? location : null
    var path = (loc && loc.pathname) || '/'
    return path.charAt(path.length - 1) === '/' ? path : path.replace(/\/[^\/]*$/, '/')
  }

  function isSameOriginURL(url) {
    var loc = typeof location !== 'undefined' ? location : null
    if (loc && url.protocol === 'file:' && loc.protocol === 'file:') return true
    return !!(loc && url.origin === loc.origin)
  }

  function pathFromSameOriginURL(path) {
    var raw = String(path || '')
    if (!raw || /^(?:blob|data|javascript):/i.test(raw)) return ''
    try {
      var loc = typeof location !== 'undefined' ? location : null
      var url = loc ? new URL(raw, loc.href) : null
      if (!url) return stripURLSuffix(raw)
      if (!isSameOriginURL(url)) return stripURLSuffix(raw)
      var pathname = safeDecodePath(url.pathname)
      var basePath = safeDecodePath(getPageBasePath())
      if (pathname.indexOf(basePath) === 0) pathname = pathname.slice(basePath.length)
      else pathname = pathname.replace(/^\/+/, '')
      return pathname
    } catch (e) {
      return stripURLSuffix(raw)
    }
  }

  function normalizePath(path) {
    return String(path || '').replace(/^\.\//, '').replace(/\\/g, '/')
  }

  var MAX_SAFE_INTEGER = Number.MAX_SAFE_INTEGER || 9007199254740991

  function align4(n) {
    return n + ((4 - (n % 4)) % 4)
  }

  function normalizeAsarPath(path) {
    return normalizePath(pathFromSameOriginURL(path)).replace(/^\/+/, '')
  }

  function readUint32LE(view, offset) {
    return view.getUint32(offset, true)
  }

  function stripJSONBOM(text) {
    return text && text.charCodeAt(0) === 0xfeff ? text.slice(1) : text
  }

  function parseJSONText(text) {
    if (!text) return null
    try { return JSON.parse(stripJSONBOM(text)) } catch (e) { return null }
  }

  function toArrayBuffer(buffer) {
    if (buffer instanceof ArrayBuffer) return buffer
    if (buffer && buffer.buffer instanceof ArrayBuffer) {
      return buffer.buffer.slice(buffer.byteOffset || 0, (buffer.byteOffset || 0) + buffer.byteLength)
    }
    return null
  }

  function parseNonNegativeInteger(value) {
    var n
    if (typeof value === 'number') {
      n = value
    } else if (typeof value === 'string' && /^[0-9]+$/.test(value)) {
      n = Number(value)
    } else {
      return null
    }
    if (!isFinite(n) || n < 0 || Math.floor(n) !== n || n > MAX_SAFE_INTEGER) return null
    return n
  }

  // ASAR format (Electron/DCML):
  //   [4 bytes: pickle size] [4 bytes: header blob size]
  //   [4 bytes: padded JSON size + 4] [4 bytes: JSON byte length]
  //   [JSON header] [NUL padding to 4 bytes] [file data]
  // Offsets in JSON are relative to the file data section start.
  function parseAsar(buffer) {
    buffer = toArrayBuffer(buffer)
    if (!buffer || buffer.byteLength < 16) {
      console.warn('ModLoader: ASAR header too short')
      return null
    }

    var dataView = new DataView(buffer)
    var headerJsonSize = readUint32LE(dataView, 12)
    var headerStart = 16
    var headerEnd = headerStart + headerJsonSize
    var dataOffset = headerStart + align4(headerJsonSize)
    if (headerJsonSize <= 0 || headerEnd > buffer.byteLength || dataOffset > buffer.byteLength) {
      console.warn('ModLoader: ASAR header size is invalid')
      return null
    }

    var dec = new TextDecoder('utf-8')
    var headerJson = dec.decode(new Uint8Array(buffer, headerStart, headerJsonSize))
    var header
    try {
      header = JSON.parse(stripJSONBOM(headerJson))
    } catch (e) {
      console.warn('ModLoader: ASAR header parse failed', e)
      return null
    }

    var files = new Map()
    var dataSize = buffer.byteLength - dataOffset
    function walk(tree, prefix) {
      if (!tree || !tree.files) return
      for (var name in tree.files) {
        var entry = tree.files[name]
        var path = prefix ? prefix + '/' + name : name
        if (entry.files) {
          walk(entry, path)
        } else if (entry.offset !== undefined && entry.size !== undefined) {
          var offset = parseNonNegativeInteger(entry.offset)
          var size = parseNonNegativeInteger(entry.size)
          var normalizedPath = normalizeAsarPath(path)
          if (
            offset === null ||
            size === null ||
            offset > dataSize ||
            size > dataSize - offset
          ) {
            console.warn('ModLoader: invalid ASAR entry skipped', normalizedPath)
            continue
          }
          files.set(normalizedPath, { offset: offset, size: size })
        }
      }
    }
    walk(header, '')
    return { dataOffset: dataOffset, files: files, buffer: buffer }
  }

  var loadedAsars = []
  var fileIndex = new Map()
  var debug = window.__MOD_DEBUG__
  var blobURLCache = {}
  var interceptorsWired = false
  var initPromise = null
  var initialized = false
  var initSelectedKey = ''

  function revokeBlobURLs() {
    for (var k in blobURLCache) URL.revokeObjectURL(blobURLCache[k])
    blobURLCache = {}
  }

  function resetLoadedState() {
    revokeBlobURLs()
    loadedAsars = []
    fileIndex = new Map()
  }

  function readParsedFileData(asar, path) {
    if (!asar || !asar.files) return null
    var entry = asar.files.get(normalizeAsarPath(path))
    if (!entry) return null
    return new Uint8Array(asar.buffer, asar.dataOffset + entry.offset, entry.size)
  }

  function readParsedFileText(asar, path) {
    var data = readParsedFileData(asar, path)
    if (!data) return null
    return new TextDecoder('utf-8').decode(data)
  }

  function readParsedFileJSON(asar, path) {
    var text = readParsedFileText(asar, path)
    return parseJSONText(text)
  }

  function readFileData(path) {
    var entry = fileIndex.get(normalizeAsarPath(path))
    if (!entry) return null
    var asar = loadedAsars[entry.asarIdx]
    if (!asar) return null
    return new Uint8Array(asar.buffer, asar.dataOffset + entry.offset, entry.size)
  }

  function createBlobURL(path) {
    var key = normalizeAsarPath(path)
    var cached = blobURLCache[key]
    if (cached) return cached
    var data = readFileData(key)
    if (!data) return null
    var blob = new Blob([data], { type: getMime(key) })
    var url = URL.createObjectURL(blob)
    blobURLCache[key] = url
    return url
  }

  window.addEventListener('beforeunload', revokeBlobURLs)

  function execHookCode(hookCode) {
    try {
      ;(function () {
        var origEAPI = window.electronAPI
        // DCML hooks expect the Electron preload-compatible API here,
        // not the ModCompat root object.
        window.electronAPI = (window.ModCompat && window.ModCompat.electronAPI) || origEAPI || {}
        try { eval(hookCode) } finally {
          if (origEAPI === undefined) delete window.electronAPI
          else window.electronAPI = origEAPI
        }
      })()
    } catch (e) { console.warn('ModLoader: hook.js error', e) }
  }

  function findURLPropertyDescriptor(el, prop) {
    var proto = Object.getPrototypeOf(el)
    while (proto) {
      var desc = Object.getOwnPropertyDescriptor(proto, prop)
      if (desc && desc.set) return desc
      proto = Object.getPrototypeOf(proto)
    }
    return null
  }

  function wireURLPropertyInterceptor(el, prop, label) {
    try {
      var desc = findURLPropertyDescriptor(el, prop)
      if (desc && desc.set) {
        Object.defineProperty(el, prop, {
          get: desc.get,
          set: function (v) {
            if (typeof v === 'string') {
              var blob = createBlobURL(v)
              if (blob) return desc.set.call(this, blob)
            }
            return desc.set.call(this, v)
          },
          configurable: true
        })
      }
    } catch (e) { if (debug) console.warn('ModLoader: ' + label + ' interceptor failed', e) }
  }

  function wireElementURLInterceptor(el, tag) {
    tag = String(tag || '').toLowerCase()
    if (tag === 'img' || tag === 'video' || tag === 'script') {
      wireURLPropertyInterceptor(el, 'src', tag)
    } else if (tag === 'link') {
      wireURLPropertyInterceptor(el, 'href', tag)
    }
  }

  function wireInterceptors() {
    if (interceptorsWired) return
    if (typeof $ === 'undefined') return
    interceptorsWired = true

    // Global XHR override — catches XMLHttpRequest (Howler, older code)
    try {
      var _origXHROpen = XMLHttpRequest.prototype.open
      XMLHttpRequest.prototype.open = function (method, url) {
        if (typeof url === 'string') {
          var blob = createBlobURL(url)
          if (blob) {
            var args = Array.prototype.slice.call(arguments)
            args[1] = blob
            return _origXHROpen.apply(this, args)
          }
        }
        return _origXHROpen.apply(this, arguments)
      }
    } catch (e) { if (debug) console.warn('ModLoader: XHR override failed', e) }

    // Global fetch override — catches any fetch() call by engine or hooks
    try {
      var _origFetch = window.fetch
      window.fetch = function (input, init) {
        var url = typeof input === 'string' ? input : (input && input.url ? input.url : '')
        if (url) {
          var blobUrl = createBlobURL(url)
          if (blobUrl) {
            // blobUrl is a blob: URL string; fetch it via native fetch to get actual data
            if (typeof Request !== 'undefined' && input instanceof Request) {
              return _origFetch.call(window, new Request(blobUrl, input), init)
            }
            return _origFetch.call(window, blobUrl, init)
          }
        }
        return _origFetch.call(window, input, init)
      }
    } catch (e) { if (debug) console.warn('ModLoader: fetch override failed', e) }

    var _origLoadText = $.loadText
    $.loadText = function (path, cb) {
      var data = readFileData(path)
      if (data) {
        var text = new TextDecoder('utf-8').decode(data)
        setTimeout(function () {
          cb && cb(text)
        }, 0)
        return
      }
      if (typeof _origLoadText === 'function') return _origLoadText.apply($, arguments)
      fetch(path)
        .then(function (response) {
          if (!response.ok) throw new Error('failed to load: ' + path)
          return response.text()
        })
        .then(function (text) {
          cb && cb(text)
        })
        .catch(function () {
          cb && cb('')
        })
    }
    var _origLoadQueue = $.loadQueue
    $.loadQueue = function (url, priority) {
      var blobUrl = createBlobURL(url)
      if (blobUrl) url = blobUrl
      if (typeof _origLoadQueue === 'function') return _origLoadQueue.call($, url, priority)
    }

    function rewriteCSSURLs(val) {
      if (typeof val !== 'string') return val
      return val.replace(/url\(['"]?([^'"\)]+)['"]?\)/g, function (m, url) {
        var blob = createBlobURL(url)
        return blob ? 'url("' + blob + '")' : m
      })
    }

    // Intercept jQuery background-image CSS URLs
    try {
      var _origCss = $.fn.css
      $.fn.css = function (prop, val) {
        if (typeof prop === 'string' && val !== undefined) {
          var propName = prop.toLowerCase()
          if (propName === 'background-image' || propName === 'background') {
            var args = Array.prototype.slice.call(arguments)
            args[1] = rewriteCSSURLs(val)
            return _origCss.apply(this, args)
          }
        }
        if (typeof prop === 'object') {
          var nextProp = prop
          var rewritten
          if (prop['background-image']) {
            rewritten = rewriteCSSURLs(prop['background-image'])
            if (rewritten !== prop['background-image']) {
              nextProp = Object.assign({}, nextProp)
              nextProp['background-image'] = rewritten
            }
          }
          if (prop['background']) {
            rewritten = rewriteCSSURLs(prop['background'])
            if (rewritten !== prop['background']) {
              nextProp = nextProp === prop ? Object.assign({}, nextProp) : nextProp
              nextProp['background'] = rewritten
            }
          }
          if (nextProp !== prop) {
            var objArgs = Array.prototype.slice.call(arguments)
            objArgs[0] = nextProp
            return _origCss.apply(this, objArgs)
          }
        }
        return _origCss.apply(this, arguments)
      }
    } catch (e) { if (debug) console.warn('ModLoader: jQuery css override failed', e) }

    // Intercept setAttribute for img/video/script src and link href
    try {
      var _origSetAttr = Element.prototype.setAttribute
      Element.prototype.setAttribute = function (attr, value) {
        var attrName = String(attr || '').toLowerCase()
        if (attrName === 'src' && (this.tagName === 'IMG' || this instanceof HTMLImageElement || this.tagName === 'VIDEO' || this instanceof HTMLVideoElement || this.tagName === 'SCRIPT' || this instanceof HTMLScriptElement)) {
          if (typeof value === 'string') {
            var blob = createBlobURL(value)
            if (blob) return _origSetAttr.call(this, attr, blob)
          }
        }
        if (attrName === 'href' && (this.tagName === 'LINK' || this instanceof HTMLLinkElement)) {
          if (typeof value === 'string') {
            var blob = createBlobURL(value)
            if (blob) return _origSetAttr.call(this, attr, blob)
          }
        }
        return _origSetAttr.call(this, attr, value)
      }
    } catch (e) { if (debug) console.warn('ModLoader: setAttribute override failed', e) }

    // Intercept CSS setProperty for background-image
    try {
      var _origSetProp = CSSStyleDeclaration.prototype.setProperty
      CSSStyleDeclaration.prototype.setProperty = function (prop, value) {
        var propName = String(prop || '').toLowerCase()
        if (typeof value === 'string' && (propName === 'background-image' || propName === 'background')) {
          var args = Array.prototype.slice.call(arguments)
          args[1] = rewriteCSSURLs(value)
          return _origSetProp.apply(this, args)
        }
        return _origSetProp.apply(this, arguments)
      }
    } catch (e) { if (debug) console.warn('ModLoader: CSS setProperty override failed', e) }

    // Intercept new Audio(url) for mod-created audio
    try {
      var _origAudio = window.Audio
      window.Audio = function (src) {
        if (typeof src === 'string') {
          var blob = createBlobURL(src)
          if (blob) src = blob
        }
        var a = new _origAudio(src)
        return a
      }
      window.Audio.prototype = _origAudio.prototype
    } catch (e) { if (debug) console.warn('ModLoader: Audio override failed', e) }

    // Intercept $.getScript (jQuery 在 mod_loader 前缓存了 document.createElement，
    // 导致 document.createElement 的 script.src 拦截无法覆盖 $.getScript 创建的 <script>)
    try {
      if (typeof $ !== 'undefined' && $.getScript) {
        var _origGetScript = $.getScript
        $.getScript = function (url, callback) {
          var blobUrl = createBlobURL(url)
          if (blobUrl) {
            // $.ajax 不会给 blob URL 加 ?_=timestamp
            return $.ajax({ url: blobUrl, dataType: 'script', cache: true }).done(callback)
          }
          return _origGetScript.call(this, url, callback)
        }
      }
    } catch (e) { if (debug) console.warn('ModLoader: $.getScript override failed', e) }

    // Intercept element URL properties via document.createElement, Image(), and innerHTML
    try {
      var _origCreate = document.createElement
      document.createElement = function (tag, opt) {
        var el = _origCreate.call(document, tag, opt)
        wireElementURLInterceptor(el, tag)
        return el
      }
      var _origImage = window.Image
      window.Image = function (w, h) {
        var img = new _origImage(w, h)
        wireURLPropertyInterceptor(img, 'src', 'img')
        return img
      }
      window.Image.prototype = _origImage.prototype
      // innerHTML: rewrite src in <img> tags to blob URLs
      var _htmlDesc = Object.getOwnPropertyDescriptor(Element.prototype, 'innerHTML')
      if (_htmlDesc && _htmlDesc.set) {
        var _htmlSet = _htmlDesc.set
        // Updating only the setter preserves the native getter on this accessor property,
        // so $.html() / element.innerHTML reads continue to work normally.
        Object.defineProperty(Element.prototype, 'innerHTML', {
          set: function (html) {
            if (typeof html === 'string' && html.indexOf('<img') !== -1) {
              html = html.replace(/(<img[^>]*\s)src="([^"]+)"/gi, function (m, pre, url) {
                var blob = createBlobURL(url)
                return blob ? pre + 'src="' + blob + '"' : m
              })
            }
            _htmlSet.call(this, html)
          },
        })
      }
    } catch (e) { if (debug) console.warn('ModLoader: createElement/Image/innerHTML override failed', e) }
  }

  function tryResolveURL(url) {
    var normalized = normalizeAsarPath(url)
    if (fileIndex.has(normalized)) return createBlobURL(normalized)
    var stripped = normalized.replace(/^data\//, '')
    if (stripped !== normalized && fileIndex.has(stripped)) return createBlobURL(stripped)
    return url
  }

  window.ModLoader = {
    // Load a single ASAR and index its files
    loadAsar: async function (asarUrl) {
      var resp
      try {
        resp = await fetch(asarUrl)
      } catch (e) {
        console.warn('ModLoader: failed to fetch', asarUrl, e)
        return false
      }
      if (!resp.ok) {
        console.warn('ModLoader: fetch failed', asarUrl, resp.status)
        return false
      }
      var buffer
      try {
        buffer = await resp.arrayBuffer()
      } catch (e) {
        console.warn('ModLoader: failed to read buffer', e)
        return false
      }
      return this.parseAndIndex(buffer)
    },

    // Parse an ArrayBuffer ASAR and add to file index; returns { meta, asarIdx }
    parseAndIndex: function (buffer) {
      var parsed = parseAsar(buffer)
      if (!parsed) return null
      var idx = loadedAsars.length
      loadedAsars.push(parsed)
      parsed.files.forEach(function (info, path) {
        var normalizedPath = normalizeAsarPath(path)
        fileIndex.set(normalizedPath, { asarIdx: idx, offset: info.offset, size: info.size })
        if (normalizedPath.indexOf('data/') === 0) {
          fileIndex.set('./' + normalizedPath, {
            asarIdx: idx,
            offset: info.offset,
            size: info.size,
          })
        }
      })
      var meta = readParsedFileJSON(parsed, 'mods.json') || {}
      return { meta: meta, asarIdx: idx }
    },

    // 注册本地模组（存入缓冲区，init 时按顺序加载）
    _localBuffers: {},
    _localConfigs: {},
    registerLocalMod: function (id, buffer) {
      this._localBuffers[id] = buffer
      // 预读 config.schema.json
      try {
        var parsed = parseAsar(buffer)
        if (parsed) {
          var schema = readParsedFileJSON(parsed, 'config.schema.json')
          if (schema) this._localConfigs[id] = schema
          else delete this._localConfigs[id]
        }
      } catch (e) {}
    },

    init: async function (selectedIds) {
      selectedIds = selectedIds || []
      var selectedKey = selectedIds.join('\n')
      if (initialized) {
        if (selectedKey !== initSelectedKey) console.warn('ModLoader: init already completed; ignoring different mod selection')
        return true
      }
      if (initPromise) return initPromise

      var self = this
      initPromise = (async function () {
        resetLoadedState()
        var resp = await fetch('./mods/mods.json')
        var modList = []
        if (resp.ok) modList = await resp.json()
        // 按 selectedIds 的顺序加载模组（拖拽排序后的顺序）
        var modMap = {}
        for (var mi = 0; mi < modList.length; mi++) modMap[modList[mi].id] = modList[mi]
        var loadedMods = []
        for (var si = 0; si < selectedIds.length; si++) {
          var sid = selectedIds[si]
          var entry = modMap[sid]
          if (self._localBuffers[sid]) {
            // 本地导入的同 id ASAR 只在当前页面会话内覆盖内置模组。
            var idxBeforeLocal = loadedAsars.length
            var result = self.parseAndIndex(self._localBuffers[sid])
            if (result) {
              console.log('ModLoader: loaded local mod', sid)
              loadedMods.push({ id: sid, asarIdx: idxBeforeLocal })
            }
          } else if (entry) {
            // 常规模组
            var idxBefore = loadedAsars.length
            var ok = await self.loadAsar('./mods/' + entry.file)
            if (ok) {
              console.log('ModLoader: loaded', entry.name)
              loadedMods.push({ id: entry.id, asarIdx: idxBefore })
            }
          }
        }
        wireInterceptors()
        // Execute hook.js from ALL loaded ASARs (including local ones from parseAndIndex)
        for (var i = 0; i < loadedAsars.length; i++) {
          var asar = loadedAsars[i]
          var hookEntry = asar.files.get('hook.js')
          if (hookEntry) {
            var hookBytes = readParsedFileData(asar, 'hook.js')
            if (hookBytes) execHookCode(new TextDecoder('utf-8').decode(hookBytes))
          }
        }
        initialized = true
        initSelectedKey = selectedKey
        console.log('ModLoader: ready,', fileIndex.size, 'files indexed')
        return true
      })()

      try {
        return await initPromise
      } catch (e) {
        resetLoadedState()
        throw e
      } finally {
        initPromise = null
      }
    },

    // Check if a file exists in mod file index
    hasFile: function (path) {
      return fileIndex.has(normalizeAsarPath(path))
    },

    // Read a text file from mod file index
    getFileText: function (path) {
      var data = readFileData(path)
      if (!data) return null
      return new TextDecoder('utf-8').decode(data)
    },

    // Read a JSON file from mod file index
    getFileJSON: function (path) {
      var text = this.getFileText(path)
      return parseJSONText(text)
    },

    // Read a text file from a specific ASAR by index
    getAsarFileText: function (asarIdx, path) {
      var asar = loadedAsars[asarIdx]
      if (!asar) return null
      return readParsedFileText(asar, path)
    },

    getAsarFileJSON: function (asarIdx, path) {
      var text = this.getAsarFileText(asarIdx, path)
      return parseJSONText(text)
    },

    // Get/set mod config (stored in localStorage)
    getModConfig: function (modId) {
      try {
        var raw = localStorage.getItem('mod_config_' + modId)
        return raw ? JSON.parse(raw) : null
      } catch (e) { return null }
    },
    setModConfig: function (modId, data) {
      try { localStorage.setItem('mod_config_' + modId, JSON.stringify(data)) } catch (e) { console.warn('ModLoader: failed to save mod config', e) }
    },

    // Get mod list with config.schema.json flag
    getModListWithSchema: async function () {
      var list = await this.getModList()
      var result = []
      for (var i = 0; i < list.length; i++) {
        var item = Object.assign({}, list[i])
        item.hasSchema = false
        if (item.id && this._localBuffers[item.id]) {
          item.hasSchema = !!this._localConfigs[item.id]
        } else if (item.file) {
          try {
            var resp = await fetch('./mods/' + item.file)
            if (resp.ok) {
              var parsed = parseAsar(await resp.arrayBuffer())
              item.hasSchema = !!(parsed && readParsedFileJSON(parsed, 'config.schema.json'))
            }
          } catch (e) {
            if (debug) console.warn('ModLoader: failed to inspect config schema for', item.id || item.file, e)
          }
        }
        result.push(item)
      }
      return result
    },

    // Start the game after mods are loaded
    startGame: function () {
      // Resume AudioContext
      if (Howler && Howler.ctx) {
        Howler.ctx.resume()
      } else if (TYRANO && TYRANO.kag && TYRANO.kag.tmp && TYRANO.kag.tmp.audio_context) {
        TYRANO.kag.tmp.audio_context.resume()
      }
      // Check if TYRANO.init exists (BrowserShell/electron_latest.js wraps it)
      if (TYRANO && TYRANO.init) {
        TYRANO.init()
      }
    },

    // Get mod list from mods.json
    getModList: async function () {
      var resp = await fetch('./mods/mods.json')
      if (!resp.ok) return []
      return await resp.json()
    },

    // 读取 ASAR 的 metadata（不修改内部状态）
    readAsarMeta: function (buffer) {
      var parsed = parseAsar(buffer)
      if (!parsed) return null
      return readParsedFileJSON(parsed, 'mods.json') || {}
    },

    readAsarFileText: function (buffer, path) {
      var parsed = parseAsar(buffer)
      if (!parsed) return null
      return readParsedFileText(parsed, path)
    },

    readAsarFileJSON: function (buffer, path) {
      var parsed = parseAsar(buffer)
      if (!parsed) return null
      return readParsedFileJSON(parsed, path)
    },

    getFileIndex: function () {
      return fileIndex
    },

    readFile: function (path) {
      var data = readFileData(path)
      if (!data) return null
      // Return only the requested ASAR entry, not the whole underlying package buffer.
      return data.buffer.slice(data.byteOffset, data.byteOffset + data.byteLength)
    },

    resolveURL: tryResolveURL,
  }

  console.log('ModLoader: loaded')
})()
