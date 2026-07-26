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

  function normalizePath(path) {
    return path.replace(/^\.\//, '').replace(/\\/g, '/')
  }

  // ASAR format (DCML variant):
  //   [4 bytes: count] [4 bytes: total header len]
  //   [4 bytes: ???] [4 bytes: JSON len]
  //   [JSON header] [padding] [file data]
  // Offsets in JSON are relative to data section start.
  function parseAsar(buffer) {
    var view = new Uint8Array(buffer)
    // Search for { in first 1024 bytes
    var bracePos = -1
    for (var i = 0; i < 1024 && i < view.length; i++) {
      if (view[i] === 0x7b) {
        bracePos = i
        break
      }
    }
    if (bracePos === -1) {
      console.warn('ModLoader: ASAR header JSON not found')
      return null
    }
    // Find matching }
    var depth = 0
    var endPos = -1
    for (var i = bracePos; i < view.length; i++) {
      if (view[i] === 0x7b) depth++
      if (view[i] === 0x7d) {
        depth--
        if (depth === 0) {
          endPos = i
          break
        }
      }
    }
    if (endPos === -1) {
      console.warn('ModLoader: ASAR header JSON incomplete')
      return null
    }
    var dec = new TextDecoder('utf-8')
    var headerJson = dec.decode(new Uint8Array(buffer, bracePos, endPos - bracePos + 1))
    var header
    try {
      header = JSON.parse(headerJson)
    } catch (e) {
      console.warn('ModLoader: ASAR header parse failed', e)
      return null
    }
    // Data section starts after JSON end + any padding
    var dataOffset = endPos + 1
    while (dataOffset < view.length && (view[dataOffset] === 0x00 || view[dataOffset] === 0x0a || view[dataOffset] === 0x0d)) {
      dataOffset++
    }
    var files = new Map()
    function walk(tree, prefix) {
      if (!tree || !tree.files) return
      for (var name in tree.files) {
        var entry = tree.files[name]
        var path = prefix ? prefix + '/' + name : name
        if (entry.files) {
          walk(entry, path)
        } else if (entry.offset !== undefined && entry.size !== undefined) {
          files.set(path, {
            offset: parseInt(entry.offset, 10),
            size: parseInt(entry.size, 10),
          })
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

  function readFileData(path) {
    var entry = fileIndex.get(normalizePath(path))
    if (!entry) return null
    var asar = loadedAsars[entry.asarIdx]
    if (!asar) return null
    return new Uint8Array(asar.buffer, asar.dataOffset + entry.offset, entry.size)
  }

  function createBlobURL(path) {
    var key = normalizePath(path)
    var cached = blobURLCache[key]
    if (cached) return cached
    var data = readFileData(path)
    if (!data) return null
    var blob = new Blob([data], { type: getMime(path) })
    var url = URL.createObjectURL(blob)
    blobURLCache[key] = url
    return url
  }

  window.addEventListener('beforeunload', function () {
    for (var k in blobURLCache) URL.revokeObjectURL(blobURLCache[k])
    blobURLCache = {}
  })

  function execHookCode(hookCode) {
    try {
      ;(function () {
        var origEAPI = window.electronAPI
        window.electronAPI = window.ModCompat || {}
        try { eval(hookCode) } finally {
          if (origEAPI === undefined) delete window.electronAPI
          else window.electronAPI = origEAPI
        }
      })()
    } catch (e) { console.warn('ModLoader: hook.js error', e) }
  }

  function wireImgInterceptor(el) {
    try {
      var desc = Object.getOwnPropertyDescriptor(Object.getPrototypeOf(el), 'src')
      if (desc && desc.set) {
        Object.defineProperty(el, 'src', {
          get: desc.get,
          set: function (v) {
            if (typeof v === 'string') {
              var blob = createBlobURL(v) || createBlobURL(normalizePath(v)) || createBlobURL(normalizePath(v).replace(/^data\//, './data/'))
              if (blob) { desc.set.call(this, blob); return }
            }
            desc.set.call(this, v)
          },
          configurable: true
        })
      }
    } catch (e) { if (debug) console.warn('ModLoader: img interceptor failed', e) }
  }

  function wireInterceptors() {
    if (typeof $ === 'undefined') return

    // Global XHR override — catches XMLHttpRequest (Howler, older code)
    try {
      var _origXHROpen = XMLHttpRequest.prototype.open
      XMLHttpRequest.prototype.open = function (method, url) {
        if (typeof url === 'string') {
          var blob = createBlobURL(normalizePath(url).replace(/^\.\//, ''))
          if (!blob) blob = createBlobURL(normalizePath(url))
          if (!blob) {
            var norm = normalizePath(url)
            blob = createBlobURL(norm.replace(/^data\//, 'data/')) || createBlobURL(norm.replace(/^data\//, './data/'))
          }
          if (blob) {
            return _origXHROpen.call(this, method, blob, true)
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
          var blobUrl = createBlobURL(normalizePath(url).replace(/^\.\//, ''))
          if (!blobUrl) blobUrl = createBlobURL(normalizePath(url))
          if (!blobUrl) {
            var norm = normalizePath(url)
            blobUrl = createBlobURL(norm.replace(/^data\//, 'data/')) || createBlobURL(norm.replace(/^data\//, './data/'))
          }
          if (blobUrl) {
            // blobUrl is a blob: URL string; fetch it via native fetch to get actual data
            return _origFetch(blobUrl)
          }
        }
        return _origFetch.call(window, input, init)
      }
    } catch (e) { if (debug) console.warn('ModLoader: fetch override failed', e) }

    var _origLoadText = $.loadText
    $.loadText = function (path, cb) {
      var data = readFileData(path) || readFileData(normalizePath(path).replace(/^data\//, './data/'))
      if (data) {
        cb && cb(new TextDecoder('utf-8').decode(data))
        return
      }
      _origLoadText(path, cb)
    }
    var _origLoadQueue = $.loadQueue
    $.loadQueue = function (url, priority) {
      var blobUrl = createBlobURL(url)
      if (blobUrl) url = blobUrl
      return _origLoadQueue.call($, url, priority)
    }

    // Intercept jQuery background-image CSS URLs
    try {
      var _origCss = $.fn.css
      var _rewriteCSS = function (val) {
        if (typeof val !== 'string') return val
        return val.replace(/url\(['"]?([^'"\)]+)['"]?\)/g, function (m, url) {
          var blob = createBlobURL(url) || createBlobURL(normalizePath(url).replace(/^\.\//, ''))
          return blob ? 'url("' + blob + '")' : m
        })
      }
      $.fn.css = function (prop, val) {
        if (typeof prop === 'string' && val !== undefined) {
          if (prop === 'background-image' || prop === 'background') val = _rewriteCSS(val)
          return _origCss.call(this, prop, val)
        }
        if (typeof prop === 'object') {
          if (prop['background-image']) prop['background-image'] = _rewriteCSS(prop['background-image'])
          if (prop['background']) prop['background'] = _rewriteCSS(prop['background'])
        }
        return _origCss.apply(this, arguments)
      }
    } catch (e) { if (debug) console.warn('ModLoader: jQuery css override failed', e) }

    // Intercept setAttribute for img/video/script src and link href
    try {
      var _origSetAttr = Element.prototype.setAttribute
      Element.prototype.setAttribute = function (attr, value) {
        if (attr === 'src' && (this.tagName === 'IMG' || this instanceof HTMLImageElement || this.tagName === 'VIDEO' || this instanceof HTMLVideoElement || this.tagName === 'SCRIPT' || this instanceof HTMLScriptElement)) {
          if (typeof value === 'string') {
            var blob = createBlobURL(value) || createBlobURL(normalizePath(value))
            if (!blob) blob = createBlobURL(normalizePath(value).replace(/^data\//, './data/'))
            if (blob) { _origSetAttr.call(this, attr, blob); return }
          }
        }
        if (attr === 'href' && (this.tagName === 'LINK' || this instanceof HTMLLinkElement)) {
          if (typeof value === 'string') {
            var blob = createBlobURL(value) || createBlobURL(normalizePath(value))
            if (!blob) blob = createBlobURL(normalizePath(value).replace(/^data\//, './data/'))
            if (blob) { _origSetAttr.call(this, attr, blob); return }
          }
        }
        _origSetAttr.call(this, attr, value)
      }
    } catch (e) { if (debug) console.warn('ModLoader: setAttribute override failed', e) }

    // Intercept CSS setProperty for background-image
    try {
      var _origSetProp = CSSStyleDeclaration.prototype.setProperty
      CSSStyleDeclaration.prototype.setProperty = function (prop, value) {
        if (typeof value === 'string' && (prop === 'background-image' || prop === 'background')) {
          value = value.replace(/url\(['"]?([^'"\)]+)['"]?\)/g, function (m, url) {
            var blob = createBlobURL(url) || createBlobURL(normalizePath(url))
            return blob ? 'url("' + blob + '")' : m
          })
        }
        _origSetProp.call(this, prop, value)
      }
    } catch (e) { if (debug) console.warn('ModLoader: CSS setProperty override failed', e) }

    // Intercept new Audio(url) for mod-created audio
    try {
      var _origAudio = window.Audio
      window.Audio = function (src) {
        if (typeof src === 'string') {
          var blob = createBlobURL(src) || createBlobURL(normalizePath(src))
          if (blob) src = blob
        }
        var a = new _origAudio(src)
        return a
      }
    } catch (e) { if (debug) console.warn('ModLoader: Audio override failed', e) }

    // Wire video.src for mod file interception
    function wireVideoInterceptor(el) {
      try {
        var proto = el
        while (proto) {
          var desc = Object.getOwnPropertyDescriptor(proto, 'src')
          if (desc && desc.set) break
          proto = Object.getPrototypeOf(proto)
        }
        if (desc && desc.set) {
          Object.defineProperty(el, 'src', {
            get: desc.get,
            set: function (v) {
              if (typeof v === 'string') {
                var blob = createBlobURL(v) || createBlobURL(normalizePath(v)) || createBlobURL(normalizePath(v).replace(/^data\//, './data/'))
                if (blob) { desc.set.call(this, blob); return }
              }
              desc.set.call(this, v)
            },
            configurable: true
          })
        }
      } catch (e) { if (debug) console.warn('ModLoader: video interceptor failed', e) }
    }

    // Wire script.src for mod file interception
    function wireScriptInterceptor(el) {
      try {
        var proto = el
        while (proto) {
          var desc = Object.getOwnPropertyDescriptor(proto, 'src')
          if (desc && desc.set) break
          proto = Object.getPrototypeOf(proto)
        }
        if (desc && desc.set) {
          Object.defineProperty(el, 'src', {
            get: desc.get,
            set: function (v) {
              if (typeof v === 'string') {
                var blob = createBlobURL(v) || createBlobURL(normalizePath(v)) || createBlobURL(normalizePath(v).replace(/^data\//, './data/'))
                if (blob) { desc.set.call(this, blob); return }
              }
              desc.set.call(this, v)
            },
            configurable: true
          })
        }
      } catch (e) { if (debug) console.warn('ModLoader: script interceptor failed', e) }
    }

    // Wire link.href for mod file interception
    function wireLinkInterceptor(el) {
      try {
        var desc = Object.getOwnPropertyDescriptor(HTMLLinkElement.prototype, 'href')
        if (desc && desc.set) {
          Object.defineProperty(el, 'href', {
            get: desc.get,
            set: function (v) {
              if (typeof v === 'string') {
                var blob = createBlobURL(v) || createBlobURL(normalizePath(v)) || createBlobURL(normalizePath(v).replace(/^data\//, './data/'))
                if (blob) { desc.set.call(this, blob); return }
              }
              desc.set.call(this, v)
            },
            configurable: true
          })
        }
      } catch (e) { if (debug) console.warn('ModLoader: link interceptor failed', e) }
    }

    // Intercept img src via document.createElement, Image(), and innerHTML
    try {
      var _origCreate = document.createElement
      document.createElement = function (tag, opt) {
        var el = _origCreate.call(document, tag, opt)
        if ((tag || '').toLowerCase() === 'img') wireImgInterceptor(el)
        else if ((tag || '').toLowerCase() === 'video') wireVideoInterceptor(el)
        else if ((tag || '').toLowerCase() === 'script') wireScriptInterceptor(el)
        else if ((tag || '').toLowerCase() === 'link') wireLinkInterceptor(el)
        return el
      }
      var _origImage = window.Image
      window.Image = function (w, h) {
        var img = new _origImage(w, h)
        wireImgInterceptor(img)
        return img
      }
      window.Image.prototype = _origImage.prototype
      // innerHTML: rewrite src in <img> tags to blob URLs
      var _htmlDesc = Object.getOwnPropertyDescriptor(Element.prototype, 'innerHTML')
      if (_htmlDesc && _htmlDesc.set) {
        var _htmlSet = _htmlDesc.set
        Object.defineProperty(Element.prototype, 'innerHTML', {
          set: function (html) {
            if (typeof html === 'string' && html.indexOf('<img') !== -1) {
              html = html.replace(/(<img[^>]*\s)src="([^"]+)"/gi, function (m, pre, url) {
                var blob = createBlobURL(url) || createBlobURL(normalizePath(url))
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
    var normalized = normalizePath(url)
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
        fileIndex.set(path, { asarIdx: idx, offset: info.offset, size: info.size })
        if (path.indexOf('data/') === 0) {
          fileIndex.set('./' + path, {
            asarIdx: idx,
            offset: info.offset,
            size: info.size,
          })
        }
      })
      var meta = {}
      var metaEntry = parsed.files.get('mods.json')
      if (metaEntry) {
        try {
          var metaBytes = new Uint8Array(parsed.buffer, parsed.dataOffset + metaEntry.offset, metaEntry.size)
          var metaText = new TextDecoder('utf-8').decode(metaBytes)
          meta = JSON.parse(metaText)
        } catch (e) { console.warn('ModLoader: failed to parse mod meta', e) }
      }
      return { meta: meta, asarIdx: idx }
    },

    init: async function (selectedIds) {
      var resp = await fetch('./mods/mods.json')
      var modList = []
      if (resp.ok) modList = await resp.json()
      var loadedMods = []
      for (var i = 0; i < modList.length; i++) {
        if (selectedIds.indexOf(modList[i].id) !== -1) {
          var idxBefore = loadedAsars.length
          var ok = await this.loadAsar('./mods/' + modList[i].file)
          if (ok) {
            console.log('ModLoader: loaded', modList[i].name)
            loadedMods.push({ id: modList[i].id, asarIdx: idxBefore })
          }
        }
      }
      wireInterceptors()
      // Execute hook.js from ALL loaded ASARs (including local ones from parseAndIndex)
      for (var i = 0; i < loadedAsars.length; i++) {
        var asar = loadedAsars[i]
        var hookEntry = asar.files.get('hook.js')
        if (hookEntry) {
          var hookBytes = new Uint8Array(asar.buffer, asar.dataOffset + hookEntry.offset, hookEntry.size)
          execHookCode(new TextDecoder('utf-8').decode(hookBytes))
        }
      }
      console.log('ModLoader: ready,', fileIndex.size, 'files indexed')
      return true
    },

    // Check if a file exists in mod file index
    hasFile: function (path) {
      return fileIndex.has(normalizePath(path))
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
      if (!text) return null
      try { return JSON.parse(text) } catch (e) { return null }
    },

    // Read a text file from a specific ASAR by index
    getAsarFileText: function (asarIdx, path) {
      var asar = loadedAsars[asarIdx]
      if (!asar) return null
      var entry = asar.files.get(normalizePath(path))
      if (!entry) return null
      return new TextDecoder('utf-8').decode(new Uint8Array(asar.buffer, asar.dataOffset + entry.offset, entry.size))
    },

    getAsarFileJSON: function (asarIdx, path) {
      var text = this.getAsarFileText(asarIdx, path)
      if (!text) return null
      try { return JSON.parse(text) } catch (e) { return null }
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
      for (var i = 0; i < list.length; i++) {
        list[i].hasSchema = fileIndex.has('config.schema.json')
      }
      return list
    },

    // Start the game after mods are loaded
    startGame: function () {
      // Resume AudioContext
      if (Howler && Howler.ctx) {
        Howler.ctx.resume()
      } else if (TYRANO && TYRANO.kag && TYRANO.kag.tmp && TYRANO.kag.tmp.audio_context) {
        TYRANO.kag.tmp.audio_context.resume()
      }
      // Check if TYRANO.init exists (electron_latest.js wraps it)
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

    getFileIndex: function () {
      return fileIndex
    },

    readFile: function (path) {
      var data = readFileData(path)
      if (!data) return null
      return data.buffer
    },

    resolveURL: tryResolveURL,
  }

  console.log('ModLoader: loaded')
})()
