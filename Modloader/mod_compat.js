/*
 * Minimal DCML hook compatibility shim.
 *
 * Provides the Electron preload / Node-like globals that renderer hook.js
 * files commonly expect. This is intentionally not a general filesystem:
 * config files are mapped to localStorage and resource overrides belong in
 * mod_loader.js.
 */
;(function () {
  if (window.ModCompat) return

  function configKeyFromPath(path) {
    var m = String(path).match(/plugins[\/\\]config[\/\\](.+)\.json/)
    return m ? 'mod_config_' + m[1] : 'mod_config_' + String(path).replace(/[^a-zA-Z0-9_]/g, '_')
  }
  function readRawConfig(path) {
    try { return localStorage.getItem(configKeyFromPath(path)) } catch (e) { return null }
  }
  function writeRawConfig(path, data) {
    try { localStorage.setItem(configKeyFromPath(path), data) } catch (e) {}
  }

  var modCompat = {
    electronAPI: {
      joinPath: function () {
        return Array.prototype.join.call(arguments, '/')
      },
      getPath: function () {
        return ''
      },
      readFile: function () {
        return Promise.resolve('')
      },
      writeFile: function () {
        return Promise.resolve()
      },
      existsSync: function (path) {
        return readRawConfig(path) !== null
      },
      readFileSync: function (path, encoding) {
        return readRawConfig(path) || ''
      },
      writeFileSync: function (path, data) {
        writeRawConfig(path, data)
      },
    },

    fs: {
      readFileSync: function (path, encoding) {
        return readRawConfig(path) || ''
      },
      existsSync: function (path) {
        return readRawConfig(path) !== null
      },
      readdirSync: function () {
        return []
      },
      mkdirSync: function () {},
      writeFileSync: function (path, data) {
        writeRawConfig(path, data)
      },
    },

    // Shim for require('path')
    path: {
      join: function () {
        return Array.prototype.join.call(arguments, '/')
      },
      resolve: function () {
        return Array.prototype.join.call(arguments, '/')
      },
      basename: function (p) {
        return p.split('/').pop() || p
      },
      dirname: function (p) {
        var parts = p.split('/')
        parts.pop()
        return parts.join('/') || '.'
      },
      extname: function (p) {
        var dot = p.lastIndexOf('.')
        return dot >= 0 ? p.slice(dot) : ''
      },
    },

    // Shim for process (extends the one from BrowserShell/browser_api.js)
    process: {
      platform: 'browser',
      env: {},
      argv: [],
      cwd: function () {
        return location.href.split('/').slice(0, -1).join('/')
      },
      type: 'renderer',
    },

    // Shim for Buffer
    Buffer: {
      from: function (data, encoding) {
        if (typeof data === 'string') {
          if (encoding === 'base64') {
            var bin = atob(data)
            var arr = new Uint8Array(bin.length)
              for (var i = 0; i < bin.length; i++) {
                arr[i] = bin.charCodeAt(i)
              }
              return arr
            }
            var enc = new TextEncoder()
            return enc.encode(data)
        }
        return data
      },
      isBuffer: function () {
        return false
      },
    },
  }

  window.ModCompat = modCompat
  window.electronAPI = modCompat.electronAPI

  // Shim require() if not already defined
  if (typeof window.require === 'undefined') {
    window.require = function (mod) {
      if (modCompat[mod]) return modCompat[mod]
      if (mod === 'electron') return {}
      return {}
    }
  }

  console.log('ModCompat: loaded')
})()
