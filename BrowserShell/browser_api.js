/**
 * Browser API shim for TyranoScript
 * Replaces Electron preload's window.api in browser environments.
 *
 * Boundary: this file owns browser replacements for the original preload API
 * (storage, dialogs, fullscreen, file download/upload helpers). Tyrano engine
 * patches live in BrowserShell/electron_latest.js; DCML mod compatibility
 * lives under Modloader/.
 */
;(function () {
  if (window.api) {
    return
  }

  // Web 版 Tyrano グローバル設定（リソースローダー・テキストキャッシュ用）
  window.TYRANO = window.TYRANO || {}
  // テキスト系ファイル（.ks / .tjs / .html）をブラウザキャッシュするか
  if (window.TYRANO.cache_text === undefined) {
    window.TYRANO.cache_text = true
  }
  // 画像・音声・動画の同時並列数（ブラウザの推奨は 6 前後）
  if (window.TYRANO.resource_concurrency === undefined) {
    window.TYRANO.resource_concurrency = 6
  }

  // SweetAlert2 ダイアログ切替フラグ
  window.USE_SWEETALERT2 = false
  window.TYRANO.USE_SWEETALERT2 = false

  // Corrupt save data is isolated by key; full storage clear requires user confirmation.
  window.TYRANO.clear_on_corrupt_save = true

  function getBasePath() {
    var href = location.href
    var i = href.lastIndexOf('/')
    return href.substring(0, i + 1)
  }

  function resolvePath(path) {
    if (!path) return getBasePath()
    if (/^https?:\/\//.test(path) || /^file:\/\//.test(path) || path.startsWith('/')) {
      return path
    }
    return getBasePath() + path
  }

  function localStorageKey(key) {
    return '_tyrano_browser_' + key
  }

  // IndexedDB-backed key/value store for saves (much larger quota than localStorage)
  function createIndexedDBStorage() {
    var DB_NAME = 'tyrano_browser_storage'
    var STORE_NAME = 'kv'
    var VERSION = 1

    var fallback = {
      cache: {},
      ready: Promise.resolve(false),
      _useIndexedDB: false,
      init: function () {
        return this.ready
      },
      getItem: function (key) {
        if (this.cache.hasOwnProperty(key)) return this.cache[key]
        try {
          return localStorage.getItem(key)
        } catch (e) {
          return null
        }
      },
      setItem: function (key, value) {
        this.cache[key] = value
        try {
          localStorage.setItem(key, value)
        } catch (e) {}
      },
      removeItem: function (key) {
        delete this.cache[key]
        try {
          localStorage.removeItem(key)
        } catch (e) {}
      },
      clear: function () {
        this.cache = {}
        try {
          localStorage.clear()
        } catch (e) {}
        return Promise.resolve()
      },
      keys: function () {
        var result = {}
        try {
          for (var i = 0; i < localStorage.length; i++) {
            var k = localStorage.key(i)
            if (k) result[k] = true
          }
        } catch (e) {}
        Object.keys(this.cache).forEach(function (k) {
          result[k] = true
        })
        return Object.keys(result)
      },
      flush: function () {
        return Promise.resolve()
      },
    }

    if (!window.indexedDB) {
      console.warn('IndexedDB is not available; falling back to localStorage')
      return fallback
    }

    var storage = {
      db: null,
      cache: {},
      pending: {},
      ready: null,
      _flushTimer: null,
      _useIndexedDB: true,

      init: function () {
        var that = this
        if (this.ready) return this.ready
        this.ready = new Promise(function (resolve) {
          var req
          try {
            req = indexedDB.open(DB_NAME, VERSION)
          } catch (e) {
            console.warn('IndexedDB open failed; falling back to localStorage', e)
            return resolve(false)
          }
          req.onerror = function () {
            console.warn('IndexedDB open error; falling back to localStorage', req.error)
            resolve(false)
          }
          req.onsuccess = function () {
            that.db = req.result
            that.db.onversionchange = function () {
              that.db.close()
            }
            that.loadAll().then(
              function () {
                resolve(true)
              },
              function (e) {
                console.warn('IndexedDB load failed; falling back to localStorage', e)
                resolve(false)
              }
            )
          }
          req.onupgradeneeded = function (e) {
            var db = e.target.result
            if (!db.objectStoreNames.contains(STORE_NAME)) {
              db.createObjectStore(STORE_NAME)
            }
          }
        }).then(function (ok) {
          if (!ok) {
            storage._useIndexedDB = false
            storage.getItem = fallback.getItem.bind(storage)
            storage.setItem = fallback.setItem.bind(storage)
            storage.removeItem = fallback.removeItem.bind(storage)
            storage.clear = fallback.clear.bind(storage)
            storage.keys = fallback.keys.bind(storage)
            storage.flush = fallback.flush.bind(storage)
          }
          return !!ok
        })
        return this.ready
      },

      loadAll: function () {
        var that = this
        return new Promise(function (resolve, reject) {
          var tx = that.db.transaction(STORE_NAME, 'readonly')
          var store = tx.objectStore(STORE_NAME)
          var req = store.openCursor()
          req.onsuccess = function (e) {
            var cursor = e.target.result
            if (cursor) {
              that.cache[cursor.key] = cursor.value
              cursor.continue()
            } else {
              resolve()
            }
          }
          req.onerror = function () {
            reject(req.error)
          }
        })
      },

      getItem: function (key) {
        return this.cache.hasOwnProperty(key) ? this.cache[key] : null
      },

      setItem: function (key, value) {
        this.cache[key] = value
        this.pending[key] = true
        this._scheduleFlush()
      },

      removeItem: function (key) {
        delete this.cache[key]
        this.pending[key] = true
        this._scheduleFlush()
      },

      clear: function () {
        this.cache = {}
        this.pending = {}
        if (this._flushTimer) {
          clearTimeout(this._flushTimer)
          this._flushTimer = null
        }
        var that = this
        return this.init().then(function () {
          if (!that._useIndexedDB) return fallback.clear.call(that)
          return new Promise(function (resolve, reject) {
            var tx = that.db.transaction(STORE_NAME, 'readwrite')
            var store = tx.objectStore(STORE_NAME)
            tx.oncomplete = resolve
            tx.onerror = function () {
              reject(tx.error)
            }
            tx.onabort = function () {
              reject(tx.error)
            }
            store.clear()
          })
        })
      },

      keys: function () {
        return Object.keys(this.cache)
      },

      _scheduleFlush: function () {
        if (this._flushTimer) return
        var that = this
        this._flushTimer = setTimeout(function () {
          that._flushTimer = null
          that.flush()
        }, 50)
      },

      flush: function () {
        var that = this
        var keys = Object.keys(this.pending)
        if (keys.length === 0) return Promise.resolve()
        this.pending = {}
        return this.init().then(function () {
          if (!that._useIndexedDB) return Promise.resolve()
          return new Promise(function (resolve, reject) {
            var tx = that.db.transaction(STORE_NAME, 'readwrite')
            var store = tx.objectStore(STORE_NAME)
            tx.oncomplete = resolve
            tx.onerror = function () {
              reject(tx.error)
            }
            keys.forEach(function (key) {
              if (that.cache.hasOwnProperty(key)) {
                store.put(that.cache[key], key)
              } else {
                store.delete(key)
              }
            })
          })
        })
      },
    }

    storage.init()

    window.addEventListener('beforeunload', function () {
      storage.flush()
    })
    window.addEventListener('pagehide', function () {
      storage.flush()
    })
    document.addEventListener('visibilitychange', function () {
      if (document.visibilityState === 'hidden') storage.flush()
    })

    return storage
  }

  var storage = createIndexedDBStorage()
  var corruptSaveNoticeShown = false

  function clearSaveDataOnCorruption(key, rawValue, error) {
    if (!window.TYRANO || !window.TYRANO.clear_on_corrupt_save) return
    console.error('Save data corruption detected for key:', key, error)
    try {
      if (key) {
        storage.removeItem(key)
        if (storage.flush) {
          storage.flush().catch(function (e) {
            console.error('Failed to flush after corrupt save removal:', e)
          })
        }
      }
      if (corruptSaveNoticeShown) return
      corruptSaveNoticeShown = true
      if (typeof Swal !== 'undefined') {
        Swal.fire({
          icon: 'warning',
          title: '存档数据损坏',
          text:
            '已删除损坏的存储项：' +
            (key || '未知') +
            '。其他存档与模组配置已保留。如果游戏仍无法启动，可以清除全部浏览器存储。',
          showDenyButton: true,
          confirmButtonText: '保留其他数据',
          denyButtonText: '清除全部存储',
        }).then(function (result) {
          if (!result.isDenied) return
          Promise.resolve(storage.clear()).then(function () {
            if (typeof Swal !== 'undefined') {
              Swal.fire({
                icon: 'info',
                text: '已清除全部浏览器存储。请刷新页面后重新导入或开始游戏。',
              })
            }
          }).catch(function (e) {
            console.error('Failed to clear storage after corruption:', e)
          })
        })
      } else {
        alert(
          '存档数据损坏，已删除损坏的存储项：' +
            (key || '未知') +
            '。其他数据已保留。'
        )
      }
    } catch (e) {
      console.error('Failed to isolate corrupt save data:', e)
    }
  }

  function validateSaveData(key, decoded) {
    if (decoded == null || decoded === '' || decoded === 'null') return true
    try {
      JSON.parse(decoded)
      return true
    } catch (e) {
      clearSaveDataOnCorruption(key, decoded, e)
      return false
    }
  }

  window.api = {
    // process info
    returnProcess: function () {
      return {
        platform: 'browser',
        execPath: location.href,
      }
    },

    // dirname equivalent
    returnDirName: function () {
      return getBasePath().replace(/\/$/, '')
    },

    // app path equivalent
    returnAppPath: function () {
      return getBasePath().replace(/\/$/, '')
    },

    // single instance lock is irrelevant in browser
    returnSingleInstanceLock: function () {
      return true
    },

    quit: function () {
      window.close()
    },

    returnRelativePath: function (file_path, item_path) {
      var base = getBasePath()
      var target = resolvePath(file_path)
      if (target.indexOf(base) === 0) {
        target = target.substring(base.length)
      }
      if (item_path) {
        var item = resolvePath(item_path)
        if (item.indexOf(base) === 0) {
          item = item.substring(base.length)
        }
        return { file_path: target, item_path: item }
      }
      return target
    },

    // file system shims backed by IndexedDB (with localStorage fallback)
    existFile: function (path) {
      return storage.getItem(localStorageKey(path)) !== null
    },

    makeDir: function (path) {
      // no-op in browser
    },

    writeFile: function (path, value) {
      storage.setItem(localStorageKey(path), value)
    },

    writeFileEnc: function (path, value) {
      storage.setItem(localStorageKey(path), value)
    },

    readFile: function (path) {
      var val = storage.getItem(localStorageKey(path))
      return val === null ? '' : val
    },

    readFileDec: function (path) {
      return this.readFile(path)
    },

    readFileBin: async function (path) {
      var response = await fetch(resolvePath(path))
      if (!response.ok) {
        throw new Error('failed to load: ' + path)
      }
      return response.arrayBuffer()
    },

    rm: function (path) {
      storage.removeItem(localStorageKey(path))
    },

    unlink: function (path) {
      storage.removeItem(localStorageKey(path))
    },

    saveFile: async function (param) {
      var dataUrl = param.dataUrl || param
      var link = document.createElement('a')
      link.href = dataUrl
      link.download = 'photo.png'
      document.body.appendChild(link)
      link.click()
      document.body.removeChild(link)
      return true
    },

    showDialog: async function (option) {
      var message = option.detail || option.message || ''
      if (option.type === 'warning' || option.type === 'question') {
        var result = await Swal.fire({
          text: message,
          icon: 'warning',
          showCancelButton: true,
        })
        return result.isConfirmed ? 0 : option.cancelId || 1
      }
      await Swal.fire({
        text: message,
        icon: 'info',
      })
      return 0
    },

    setFullScreen: async function (fullscreen) {
      if (!fullscreen) {
        if (document.fullscreenElement && document.exitFullscreen) {
          document.exitFullscreen()
        }
      } else {
        var el = document.documentElement
        if (el.requestFullscreen) {
          el.requestFullscreen().catch(function (e) {
            console.log(e)
          })
        }
      }
    },

    applyPatch: async function () {
      console.warn('applyPatch is not supported in browser environment')
      return false
    },

    openWebPage: async function (url) {
      window.open(url, '_blank')
    },

    // debug helpers (no-ops in browser)
    readSubDir: async function () {
      return []
    },
    toggleDevTools: async function () {
      /* no-op */
    },
    isMuteAudio: async function (enable) {
      var media = document.querySelectorAll('audio, video')
      for (var i = 0; i < media.length; i++) {
        media[i].muted = !!enable
      }
    },
    captureWindow: async function (x, y, width, height) {
      return ''
    },
    registerHotKey: async function () {
      /* no-op */
    },

    getSaveKey: function () {
      // Return null so Tyrano falls back to localStorage generated key
      return null
    },

    // Steam shims (no Steam in browser)
    isAppActivated: async function () {
      return true
    },
    activateAchievement: async function () {
      /* no-op */
    },
    triggerScreenshot: async function () {
      /* no-op */
    },

    log: async function () {
      console.log.apply(console, arguments)
    },

    storage: storage,
    validateSaveData: validateSaveData,
  }
})()
