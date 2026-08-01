;(function () {
  /**
   * Browser adaptation layer for TyranoScript.
   * Replaces Electron/NW.js specific behavior with browser equivalents.
   *
   * Boundary: this file runs after the Tyrano engine is available and patches
   * engine behavior. Browser preload shims belong in BrowserShell/browser_api.js;
   * DCML mod loading belongs under Modloader/.
   */

  /**
   * IndexedDB storage integration for TyranoScript saves.
   * Replaces localStorage-backed $.setStorageWeb / $.getStorageWeb /
   * $.setStorageCompress / $.getStorageCompress / $.clearStorage
   * so that save data (including base64 thumbnails) can exceed localStorage quota.
   */
  function initIndexedDBSaveIntegration() {
    if (!window.api || !window.api.storage) {
      console.warn('window.api.storage is not available')
      return
    }

    var storage = window.api.storage

    // Uncompressed webstorage mode (UTF-8 percent encoding, matches Steam .sav files)
    $.setStorageWeb = function (key, val) {
      val = JSON.stringify(val)
      storage.setItem(key, encodeURIComponent(val))
    }

    $.getStorageWeb = function (key) {
      try {
        var gv = storage.getItem(key)
        if (gv == 'null' || gv == null) return null
        // Steam / Electron .sav files use encodeURIComponent; legacy browser data used escape
        var decoded
        try {
          decoded = decodeURIComponent(gv)
        } catch (e) {
          decoded = unescape(gv)
        }
        if (!window.api.validateSaveData(key, decoded)) return null
        return decoded
      } catch (e) {
        console.error('IndexedDB save read failed', e)
        return null
      }
    }

    // Compressed webstorage mode (LZString) — also accepts plain percent-encoded data
    $.setStorageCompress = function (key, val) {
      val = JSON.stringify(val)
      storage.setItem(key, LZString.compress(encodeURIComponent(val)))
    }

    $.getStorageCompress = function (key) {
      try {
        var gv = storage.getItem(key)
        if (gv == 'null' || gv == null) return null

        // Steam .sav files are plain percent-encoded, not LZString compressed
        try {
          var plain = decodeURIComponent(gv)
          if (window.api.validateSaveData(key, plain)) return plain
        } catch (e) {}

        // Legacy compressed data
        var decompressed = LZString.decompress(gv)
        if (!decompressed) {
          decompressed = gv
        }
        var decoded
        try {
          decoded = decodeURIComponent(decompressed)
        } catch (e) {
          decoded = unescape(decompressed)
        }
        if (!window.api.validateSaveData(key, decoded)) return null
        return decoded
      } catch (e) {
        console.error('IndexedDB compressed save read failed', e)
        return null
      }
    }

    // Make "corrupted save data" reset clear IndexedDB as well
    $.confirmSaveClear = function () {
      Swal.fire({
        text: 'セーブデータが壊れている可能性があります。セーブデータを初期化しますか？',
        icon: 'warning',
        showCancelButton: true,
      }).then(function (result) {
        if (result.isConfirmed) {
          Swal.fire({ text: '初期化', icon: 'info' }).then(function () {
            storage.clear()
          })
        }
      })
    }

    // Copy existing localStorage saves into IndexedDB on first run
    function migrateLocalStorageSaves() {
      if (!storage._useIndexedDB) return Promise.resolve()
      var migrated = false
      for (var i = 0; i < localStorage.length; i++) {
        var key = localStorage.key(i)
        if (!key) continue
        if (/tyrano|_save_key|_sf$|_data$|_quick_save|_auto_save|_photo_/i.test(key)) {
          if (storage.getItem(key) === null) {
            var val = localStorage.getItem(key)
            if (val !== null) {
              storage.setItem(key, val)
              migrated = true
            }
          }
        }
      }
      if (migrated) {
        console.log('Migrated localStorage save data to IndexedDB')
        return storage.flush()
      }
      return Promise.resolve()
    }

    // Wait for IndexedDB cache (and any migration) before starting the game
    var originalInit = TYRANO.init
    TYRANO.init = function () {
      storage.ready.then(function () {
        return migrateLocalStorageSaves()
      }).then(function () {
        originalInit.call(TYRANO)
      })
    }
  }

  initIndexedDBSaveIntegration()

  /**
   * kag.init
   */
  tyrano.plugin.kag.init = function () {
    this.kag = this
    var that = this
    this.tyrano.test()

    // Single instance lock is irrelevant in browsers.
    this.parser.loadConfig(function (map_config) {
      that.config = $.extend(!0, that.config, map_config)
      // ブラウザ版は IndexedDB で容量に余裕があるので無圧縮 webstorage を使用
      that.config.configSave = 'webstorage'
      that.checkUpdate(function () {
        that.init_game()
      })
    })

    $('script').each(function () {
      $(this).attr('src') &&
        ((-1 == $(this).attr('src').indexOf('cordova') &&
          -1 == $(this).attr('src').indexOf('phonegap')) ||
          (that.define.FLAG_APRI = !0))
    })

    ;('function' == typeof TyranoPlayer || $.isNWJS()) &&
      (this.tmp.ready_audio = !0)

    var AudioContext = window.AudioContext || window.webkitAudioContext || !1
    AudioContext && (this.tmp.audio_context = new AudioContext())

    try {
      $.getBrowser()
    } catch (e) {
      console.log(e)
    }
  }

  /**
   * パッチ適用関連：ブラウザでは無効
   */
  tyrano.plugin.kag.checkUpdate = function (call_back) {
    call_back()
  }

  tyrano.plugin.kag.applyPatch = function (patch_path, flag_reload, call_back) {
    console.warn('applyPatch is not supported in browser environment')
    if (typeof call_back === 'function') call_back()
  }

  /**
   * webページ開く
   */
  tyrano.plugin.kag.tag.web = {
    vital: ['url'],
    pm: { url: '' },
    start: function (pm) {
      if (pm.url.indexOf('http') !== -1) {
        window.open(pm.url, '_blank')
      } else {
        window.open(pm.url, '_blank')
      }
      this.kag.ftag.nextOrder()
    },
  }
  tyrano.plugin.kag.ftag.master_tag.web = tyrano.plugin.kag.tag.web
  tyrano.plugin.kag.ftag.master_tag.web.kag = tyrano.plugin.kag

  /**
   * ウィンドウを閉じる
   */
  tyrano.plugin.kag.tag.close = {
    pm: { ask: 'true' },
    start: function (pm) {
      var that = this
      'true' == pm.ask
        ? $.confirm(
            $.lang('exit_game'),
            function () {
              that.close()
            },
            function () {
              that.kag.ftag.nextOrder()
            }
          )
        : this.close()
    },
    close: function () {
      window.close()
      void 0 !== navigator.app && navigator.app.exitApp()
    },
  }
  tyrano.plugin.kag.ftag.master_tag.close = tyrano.plugin.kag.tag.close
  tyrano.plugin.kag.ftag.master_tag.close.kag = tyrano.plugin.kag

  /**
   * webから更新取得：ブラウザではスキップ
   */
  tyrano.plugin.kag.tag.check_web_patch = {
    vital: ['url'],
    pm: { url: '', reload: 'false' },
    start: function (pm) {
      this.kag.ftag.nextOrder()
    },
  }
  tyrano.plugin.kag.ftag.master_tag.check_web_patch =
    tyrano.plugin.kag.tag.check_web_patch
  tyrano.plugin.kag.ftag.master_tag.check_web_patch.kag = tyrano.plugin.kag
})()

/**
 * jQuery拡張
 */
;(function ($) {
  const storageFolder = '_storage'

  /**
   * 実行環境判定
   * @returns {boolean}
   */
  $.isElectron = function () {
    return false
  }

  /**
   * PC用の実行パスを取得（ブラウザ版）
   * @returns {string} ベースURL
   */
  $.getExePath = function () {
    var href = location.href
    var i = href.lastIndexOf('/')
    return href.substring(0, i)
  }

  $.setStorageFile = function (key, val) {
    if (!window.api || !window.api.storage) return
    val = JSON.stringify(val)
    window.api.storage.setItem(key, encodeURIComponent(val))
  }

  $.getStorageFile = function (key) {
    if (!window.api || !window.api.storage) return null
    try {
      var gv = window.api.storage.getItem(key)
      if (gv == 'null' || gv == null) return null
      var decoded
      try {
        decoded = decodeURIComponent(gv)
      } catch (e) {
        decoded = unescape(gv)
      }
      if (!window.api.validateSaveData(key, decoded)) return null
      return decoded
    } catch (e) {
      console.log(e)
      Swal.fire({ text: $.lang('save_does_not_work'), icon: 'info' }).then(function () {
        $.confirmSaveClear()
      })
    }
    return null
  }

  $.clearStorage = function (type, key) {
    if (!window.api || !window.api.storage) return
    key = key || ''
    if (key) {
      window.api.storage.removeItem(key)
    } else {
      window.api.storage.clear()
    }
  }

  $.saveFile = async function (dataUrl) {
    try {
      await window.api.saveFile({ title: $.lang('save_photo'), dataUrl: dataUrl })
      $.alert($.lang('photo_saved'))
    } catch (e) {
      console.log(e)
      $.alert($.lang('photo_save_failed'))
    }
  }

  $.loadText = function (path, cb) {
    fetch(path)
      .then(function (response) {
        if (!response.ok) throw new Error('failed to load: ' + path)
        return response.text()
      })
      .then(function (text) {
        cb(text)
      })
      .catch(function (e) {
        console.error(e)
        cb('')
      })
  }

  // いま終了時コンファームが有効かどうか
  let is_close_confirm_enabled = false

  $.enableCloseConfirm = function () {
    if (is_close_confirm_enabled) return
    is_close_confirm_enabled = true

    window.onbeforeunload = function () {
      return $.lang('confirm_beforeunload')
    }
  }
})(jQuery)
