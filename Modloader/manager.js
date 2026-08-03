// ===== 模组管理器 - 配置逻辑 =====
// Browser UI for selecting, importing, ordering, and configuring mods.
// ASAR parsing and resource interception stay in mod_loader.js.
var _cfgModId = null, _cfgSchema = null
var _modList = []
var _importingSave = false

function esc(s) {
  if (!s) return ''
  return String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;')
}

function setClassState(el, className, enabled) {
  if (!el) return
  if (el.classList) {
    el.classList[enabled ? 'add' : 'remove'](className)
    return
  }
  var names = String(el.className || '').split(/\s+/).filter(Boolean)
  var index = names.indexOf(className)
  if (enabled && index < 0) names.push(className)
  if (!enabled && index >= 0) names.splice(index, 1)
  el.className = names.join(' ')
}

function configMessage(text) {
  return '<div class="cfg-message">' + esc(text) + '</div>'
}

function openModConfig(modId, modName) {
  _cfgModId = modId
  document.getElementById('mod_config_title').textContent = modName + ' 配置'
  var fieldsEl = document.getElementById('mod_config_fields')
  fieldsEl.innerHTML = configMessage('读取配置中...')
  setClassState(document.getElementById('mod_config_modal'), 'is-open', true)

  var modEntry = _modList ? _modList.find(function(m) { return m.id === modId }) : null
  if (!modEntry) { fieldsEl.innerHTML = configMessage('模组信息缺失'); return }

  if (modEntry.isLocal) {
    var s = (window.ModLoader && ModLoader._localConfigs) ? ModLoader._localConfigs[modId] : null
    if (s) { renderConfigForm(s); return }
    fieldsEl.innerHTML = configMessage('该模组无可配置项')
    return
  }

  fetch('./mods/' + modEntry.file).then(function(r) {
    if (!r.ok) throw new Error('fetch failed: ' + r.status)
    return r.arrayBuffer()
  }).then(function(buf) {
    if (!window.ModLoader || !ModLoader.readAsarFileJSON) throw new Error('ModLoader parser unavailable')
    var schema = ModLoader.readAsarFileJSON(buf, 'config.schema.json')
    if (!schema) throw new Error('config.schema.json not in ASAR')
    renderConfigForm(schema)
  }).catch(function(e) {
    console.warn('ModLoader: config load error', e)
    fieldsEl.innerHTML = configMessage('该模组无可配置项')
  })
}

function renderConfigForm(schema) {
  _cfgSchema = schema
  var fieldsEl = document.getElementById('mod_config_fields')
  if (!schema || !schema.fields || !schema.fields.length) {
    fieldsEl.innerHTML = configMessage('无可配置项')
    return
  }
  var html = ''
  if (schema.description) {
    html += '<div class="cfg-description">' + esc(schema.description) + '</div>'
  }
  var saved = {}
  try { saved = JSON.parse(localStorage.getItem('mod_config_' + _cfgModId)) || {} } catch(e) {}

  for (var i = 0; i < schema.fields.length; i++) {
    var f = schema.fields[i]
    var val = saved[f.key] !== undefined ? saved[f.key] : f.default
    var inputId = 'cfg_' + f.key
    html += '<div class="cfg-field"><label class="cfg-label" for="' + esc(inputId) + '">' + esc(f.label || f.key) + '</label>'
    if (f.type === 'toggle') {
      html += '<input type="checkbox" class="cfg-toggle" id="' + esc(inputId) + '" ' + (val ? 'checked' : '') + '>'
    } else {
      var type = f.type === 'number' || f.type === 'password' ? f.type : 'text'
      html += '<input type="' + type + '" class="cfg-input" id="' + esc(inputId) + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '">'
    }
    if (f.help) html += '<div class="cfg-help">' + esc(f.help) + '</div>'
    html += '</div>'
  }
  fieldsEl.innerHTML = html
}

function saveModConfig() {
  if (!_cfgSchema || !_cfgModId) return
  var obj = {}
  for (var i = 0; i < _cfgSchema.fields.length; i++) {
    var f = _cfgSchema.fields[i]
    var el = document.getElementById('cfg_' + f.key)
    if (!el) continue
    if (f.type === 'toggle') obj[f.key] = el.checked
    else if (f.type === 'number') obj[f.key] = parseFloat(el.value) || 0
    else obj[f.key] = el.value
  }
  localStorage.setItem('mod_config_' + _cfgModId, JSON.stringify(obj))
  alert('配置已保存')
  closeModConfig()
}

function closeModConfig() {
  setClassState(document.getElementById('mod_config_modal'), 'is-open', false)
  _cfgModId = null; _cfgSchema = null
}

function isSaveStorageKey(key) {
  return typeof key === 'string' && (
    key === 'NEO' || key.indexOf('DevilConnection_') === 0
  )
}

function getSaveStorageKeys(storage) {
  var keys = null
  if (storage && storage.keys) {
    try { keys = storage.keys() } catch(e) {}
  }
  if (!Array.isArray(keys)) {
    try { keys = Object.keys(localStorage) } catch(e) { keys = [] }
  }
  return keys.filter(isSaveStorageKey)
}

function createSaveOperationError(stage, message, cause) {
  var error = new Error(message)
  error.name = 'SaveOperationError'
  error.stage = stage
  if (cause) error.cause = cause
  return error
}

function errorDetail(error) {
  return error && error.message ? error.message : String(error || '未知错误')
}

function setSaveOperationStatus(message) {
  var status = document.getElementById('save_operation_status')
  if (status) status.textContent = message || ''
}

function setSaveOperationBusy(busy) {
  var buttons = document.querySelectorAll('.save-btn')
  for (var i = 0; i < buttons.length; i++) {
    setClassState(buttons[i], 'is-busy', busy)
  }
}

function beginSaveOperation(message) {
  if (_importingSave) return false
  _importingSave = true
  setSaveOperationBusy(true)
  setSaveOperationStatus(message)
  return true
}

function finishSaveOperation() {
  _importingSave = false
  setSaveOperationBusy(false)
  setSaveOperationStatus('')
}

function waitForSaveStorage(storage) {
  if (!storage || !storage.ready) return Promise.resolve(storage)
  return Promise.resolve(storage.ready).then(function() { return storage })
}

function getSaveStorageValue(storage, key) {
  return storage && storage.getItem
    ? storage.getItem(key)
    : localStorage.getItem(key)
}

function setSaveStorageValue(storage, key, value) {
  if (storage && storage.setItem) storage.setItem(key, value)
  else localStorage.setItem(key, value)
}

function removeSaveStorageValue(storage, key) {
  if (storage && storage.removeItem) storage.removeItem(key)
  else localStorage.removeItem(key)
}

function flushSaveStorage(storage) {
  return storage && storage.flush ? storage.flush() : Promise.resolve()
}

async function restoreSaveSnapshot(storage, snapshot) {
  for (var i = 0; i < snapshot.length; i++) {
    var item = snapshot[i]
    if (item.exists) setSaveStorageValue(storage, item.key, item.value)
    else removeSaveStorageValue(storage, item.key)
  }
  await flushSaveStorage(storage)
}

// ===== 存档清除 =====
async function clearAllSaves() {
  if (!confirm('确定清除所有存档数据？此操作不可恢复！')) return
  if (!confirm('再次确认：所有存档数据将被永久删除！')) return
  if (!beginSaveOperation('正在读取存档...')) return
  try {
    var storage = window.api && window.api.storage
    await waitForSaveStorage(storage)
    var keys = getSaveStorageKeys(storage)
    setSaveOperationStatus('正在清除存档...')
    for (var i = 0; i < keys.length; i++) {
      removeSaveStorageValue(storage, keys[i])
    }
    await flushSaveStorage(storage)
    alert('已清除 ' + keys.length + ' 个存档数据')
  } catch(e) {
    console.warn('存档清除失败:', e)
    alert('清除失败：' + errorDetail(e))
  } finally {
    finishSaveOperation()
  }
}

// ===== 存档导出 =====
async function toggleSaveImport() {
  if (!beginSaveOperation('正在读取存档...')) return
  try {
    if (typeof JSZip === 'undefined') throw new Error('JSZip 库未加载')
    var storage = window.api && window.api.storage
    if (!storage) throw new Error('存储不可用')
    await waitForSaveStorage(storage)
    var zip = new JSZip()
    var keys = getSaveStorageKeys(storage)
    var count = 0
    for (var i = 0; i < keys.length; i++) {
      var k = keys[i], v = getSaveStorageValue(storage, k)
      if (v != null) { zip.file(encodeURIComponent(k) + '.sav', v); count++ }
    }
    if (count === 0) {
      alert('没有可导出的存档数据')
      return
    }
    setSaveOperationStatus('正在导出存档 0%')
    var blob = await zip.generateAsync({ type: 'blob' }, function(metadata) {
      var percent = metadata && isFinite(metadata.percent)
        ? Math.round(metadata.percent)
        : 0
      setSaveOperationStatus('正在导出存档 ' + percent + '%')
    })
    var url = URL.createObjectURL(blob), a = document.createElement('a')
    a.href = url; a.download = 'DevilConnection_saves.zip'
    document.body.appendChild(a); a.click(); document.body.removeChild(a)
    setTimeout(function() { URL.revokeObjectURL(url) }, 10000)
  } catch(e) {
    console.warn('存档导出失败:', e)
    alert('导出失败：' + errorDetail(e))
  } finally {
    finishSaveOperation()
  }
}

// ===== 页面初始化 =====
document.addEventListener('DOMContentLoaded', function() {
  var modListEl = document.getElementById('mod_list')
  var startBtn = document.getElementById('start_game_btn')
  var overlay = document.getElementById('tyrano_click_to_start')
  var startButtonText = startBtn ? startBtn.textContent : '启动游戏'
  var startFailed = false

  function switchPage(page) {
    document.querySelectorAll('.page').forEach(function(p) { setClassState(p, 'active', false) })
    var target = document.getElementById('page-' + page)
    setClassState(target, 'active', true)
    document.querySelectorAll('.nav-item').forEach(function(n) {
      var act = n.getAttribute('data-page') === page
      setClassState(n, 'active', act)
    })
  }
  document.querySelectorAll('.nav-item').forEach(function(n) {
    n.addEventListener('click', function() { switchPage(this.getAttribute('data-page')) })
  })
  document.querySelectorAll('.tile-btn').forEach(function(n) {
    n.addEventListener('click', function() { switchPage(this.getAttribute('data-target')) })
  })
  switchPage('console')

  var sortable = null

  function getCheckedState() {
    var state = {}
    var cbs = modListEl.querySelectorAll('.mod_checkbox')
    for (var i = 0; i < cbs.length; i++) {
      state[cbs[i].getAttribute('data-id')] = cbs[i].checked
    }
    return state
  }

  function renderModList(mods) {
    var checkedState = getCheckedState()
    _modList = mods || []
    if (!mods || mods.length === 0) {
      modListEl.innerHTML = '<div class="mod-empty">没有可用模组</div>'
      return
    }
    var html = ''
    for (var i = 0; i < mods.length; i++) {
      var m = mods[i]
      var checked = Object.prototype.hasOwnProperty.call(checkedState, m.id) ? checkedState[m.id] : true
      html +=
        '<div class="mod-item" data-id="' + esc(m.id) + '">' +
        '<span class="drag-handle">☰☰</span>' +
        '<div class="mod-info"><div class="mod-name">' + esc(m.name) + '</div>' +
        (m.description ? '<div class="mod-desc">' + esc(m.description) + '</div>' : '') +
        (m.isLocal ? '<span class="mod-local">[本地]</span>' : '') + '</div>' +
        '<button type="button" class="btn-config" data-id="' + esc(m.id) + '">配置</button>' +
        '<input type="checkbox" class="mod_checkbox" data-id="' + esc(m.id) + '"' + (checked ? ' checked' : '') + '>' +
        '</div>'
    }
    modListEl.innerHTML = html
    modListEl.querySelectorAll('.btn-config').forEach(function(btn) {
      btn.addEventListener('click', function(event) {
        event.stopPropagation()
        var modId = this.getAttribute('data-id')
        var modEntry = _modList.find(function(x) { return x.id === modId })
        openModConfig(modId, modEntry ? modEntry.name : modId)
      })
    })
    if (sortable) sortable.destroy()
    sortable = new Sortable(modListEl, {
      handle: '.drag-handle', animation: 150, ghostClass: 'ghost',
      onEnd: function() {
        var items = modListEl.querySelectorAll('.mod-item'), newOrder = []
        for (var j = 0; j < items.length; j++) {
          var id = items[j].getAttribute('data-id'), found = _modList.find(function(x) { return x.id === id })
          if (found) newOrder.push(found)
        }
        _modList = newOrder
      }
    })
  }

  var engineScripts = ['tyrano/lang.js','tyrano/libs.js','tyrano/tyrano.js','tyrano/tyrano.base.js','tyrano/plugins/kag/kag.js','tyrano/plugins/kag/kag.event.js','tyrano/plugins/kag/kag.key_mouse.js','tyrano/plugins/kag/kag.layer.js','tyrano/plugins/kag/kag.menu.js','tyrano/plugins/kag/kag.parser.js','tyrano/plugins/kag/kag.rider.js','tyrano/plugins/kag/kag.studio.js','tyrano/plugins/kag/kag.tag_audio.js','tyrano/plugins/kag/kag.tag_camera.js','tyrano/plugins/kag/kag.tag_ext.js','tyrano/plugins/kag/kag.tag_system.js','tyrano/plugins/kag/kag.tag_vchat.js','tyrano/plugins/kag/kag.tag_ar.js','tyrano/plugins/kag/kag.tag_three.js','tyrano/plugins/kag/kag.tag.js','data/system/KeyConfig.js','BrowserShell/electron_latest.js']

  function showStartFailure(message, detail) {
    var text = message + (detail ? '\n' + detail : '')
    if (typeof Swal !== 'undefined' && Swal.fire) {
      Swal.fire({ icon: 'error', title: '启动失败', text: text })
    } else {
      alert(text)
    }
  }

  function failStart(message, detail) {
    if (startFailed) return
    startFailed = true
    console.warn(message, detail || '')
    startBtn.disabled = false
    startBtn.textContent = startButtonText
    showStartFailure(message, detail)
  }

  function getMissingEnginePieces() {
    var missing = []
    if (!window.jQuery || typeof window.jQuery.loadText !== 'function') missing.push('$.loadText')
    if (!window.jQuery || typeof window.jQuery.loadQueue !== 'function') missing.push('$.loadQueue')
    if (!window.TYRANO) missing.push('TYRANO')
    else {
      if (typeof TYRANO.init !== 'function') missing.push('TYRANO.init')
      if (TYRANO.browser_shell_ready !== true) missing.push('BrowserShell/electron_latest.js')
    }
    if (!window.tyrano || !tyrano.plugin || !tyrano.plugin.kag) {
      missing.push('tyrano.plugin.kag')
    } else {
      var kag = tyrano.plugin.kag
      var required = ['event', 'ftag', 'key_mouse', 'layer', 'menu', 'parser', 'rider', 'studio', 'tag']
      for (var i = 0; i < required.length; i++) {
        if (!kag[required[i]]) missing.push('tyrano.plugin.kag.' + required[i])
      }
      if (kag.tag) {
        var requiredTags = ['bgcamera', 'camera', 'eval', 'jump', 'loadjs', 'playbgm', 'text', 'vchat_in', '3d_init']
        for (var j = 0; j < requiredTags.length; j++) {
          if (!kag.tag[requiredTags[j]]) missing.push('tyrano.plugin.kag.tag.' + requiredTags[j])
        }
      }
    }
    return missing
  }

  function loadEngine(index) {
    if (startFailed) return
    if (index >= engineScripts.length) {
      var missing = getMissingEnginePieces()
      if (missing.length) {
        failStart('引擎初始化检查失败', '缺少组件：' + missing.join(', '))
        return
      }
      finishStart()
      return
    }
    var s = document.createElement('script')
    s.src = './' + engineScripts[index]
    s.async = false
    s.onload = function() { loadEngine(index + 1) }
    s.onerror = function() { failStart('引擎脚本加载失败', engineScripts[index]) }
    document.head.appendChild(s)
  }

  function startGame(e) {
    if (e) e.stopPropagation()
    startFailed = false
    startBtn.disabled = true; startBtn.textContent = '加载中...'
    var cbs = document.querySelectorAll('.mod_checkbox:checked'), ids = []
    for (var i = 0; i < cbs.length; i++) ids.push(cbs[i].getAttribute('data-id'))
    function go() { loadEngine(0) }
    if (window.ModLoader) {
      ModLoader.init(ids).then(go).catch(function(e) {
        if (ids.length) {
          failStart('所选模组加载失败', e && e.message ? e.message : String(e))
        } else {
          console.warn('ModLoader init failed; starting without mods', e)
          go()
        }
      })
    } else { go() }
  }

  function finishStart() {
    try { new Audio('./tyrano/audio/silent.mp3').play() } catch(e) {}
    try { if (Howler && Howler.ctx && Howler.ctx.state === 'suspended') Howler.ctx.resume() } catch(e) {}
    setClassState(overlay, 'is-exiting', true)
    setTimeout(function() {
      if (overlay.parentNode) overlay.parentNode.removeChild(overlay)
      // 恢复触摸阻止，防止游戏画面滚动
      document.body.style.touchAction = 'none'
      document.body.style.overflow = 'hidden'
      if (window.TYRANO && TYRANO.init) TYRANO.init()
    }, 400)
  }

  if (window.ModLoader) { ModLoader.getModList().then(renderModList).catch(function() { renderModList([]) })
  } else { renderModList([]) }

  startBtn.addEventListener('click', startGame)

  var fileInput = document.getElementById('asar_file_input')
  document.getElementById('load_local_btn').addEventListener('click', function() { fileInput.click() })
  fileInput.addEventListener('change', function(e) {
    var file = e.target.files && e.target.files[0]
    if (!file) return
    var reader = new FileReader()
    reader.onload = function(ev) {
      var buf = ev.target.result
      if (window.ModLoader) {
        var meta
        try {
          meta = ModLoader.readAsarMeta(buf)
        } catch (err) {
          console.warn('本地模组解析失败:', file.name, err)
          alert('模组导入失败：ASAR 文件无效或已损坏')
          return
        }
        if (meta === null) {
          alert('模组导入失败：ASAR 文件无效或已损坏')
          return
        }
        var name = meta.name || file.name.replace(/\.asar$/, '')
        var localId = meta.id || file.name.replace(/\.asar$/, '').replace(/[^a-zA-Z0-9_]/g, '_')
        ModLoader.registerLocalMod(localId, buf.slice(0))
        var localEntry = { id: localId, name: name, description: (meta && meta.description) || '本地加载的 ASAR 模组', author: '', isLocal: true }
        var replaced = false
        for (var i = 0; i < _modList.length; i++) {
          if (_modList[i].id === localId) {
            _modList[i] = localEntry
            replaced = true
            break
          }
        }
        if (!replaced) _modList.push(localEntry)
        renderModList(_modList)
      }
    }
    reader.readAsArrayBuffer(file)
    fileInput.value = ''
  })
})

// 导入存档
document.addEventListener('DOMContentLoaded', function() {
  var importInput = document.getElementById('import_save_input')
  if (!importInput) return
  importInput.addEventListener('change', function(e) {
    var file = e.target.files && e.target.files[0]
    if (!file) return
    if (_importingSave) { importInput.value = ''; return }
    if (!beginSaveOperation('正在读取存档...')) { importInput.value = ''; return }

    function finishImport() {
      finishSaveOperation()
      importInput.value = ''
    }

    var reader = new FileReader()
    reader.onload = async function(ev) {
      if (typeof JSZip === 'undefined') {
        alert('导入失败：JSZip 库未加载')
        finishImport()
        return
      }
      try {
        var storage = window.api && window.api.storage
        await waitForSaveStorage(storage)
        var zip
        try {
          zip = await JSZip.loadAsync(ev.target.result)
        } catch (zipError) {
          throw createSaveOperationError('zip', 'ZIP 格式错误或读取失败', zipError)
        }
        var entries = []
        var seenKeys = Object.create(null)
        var ignored = 0
        var saveFiles = 0
        var collectError = null

        zip.forEach(function(p, f) {
          if (collectError || f.dir || !/\.sav$/i.test(p)) return
          saveFiles++
          var key
          try {
            key = decodeURIComponent(p.replace(/\.sav$/i, ''))
          } catch (err) {
            collectError = createSaveOperationError(
              'validation',
              '存档文件名无法解析：' + p,
              err
            )
            return
          }
          if (!isSaveStorageKey(key)) {
            ignored++
            return
          }
          if (seenKeys[key]) {
            collectError = createSaveOperationError(
              'validation',
              'ZIP 中存在重复存档键：' + key
            )
            return
          }
          seenKeys[key] = true
          entries.push({ key: key, path: p, file: f, content: null })
        })

        if (collectError) throw collectError
        if (saveFiles === 0) {
          throw createSaveOperationError('validation', 'ZIP 中没有可导入的 .sav 存档文件')
        }
        if (entries.length === 0) {
          throw createSaveOperationError('validation', 'ZIP 中没有 DevilConnection 存档')
        }
        if (!window.api || typeof window.api.decodeSaveData !== 'function') {
          throw createSaveOperationError('validation', '存档格式验证组件不可用')
        }

        for (var i = 0; i < entries.length; i++) {
          var entry = entries[i]
          setSaveOperationStatus(
            '正在验证存档（' + (i + 1) + '/' + entries.length + '）...'
          )
          try {
            entry.content = await entry.file.async('string')
          } catch (readError) {
            throw createSaveOperationError(
              'zip',
              '无法读取存档文件：' + entry.path,
              readError
            )
          }
          var decoded = window.api.decodeSaveData(entry.content)
          if (!decoded || decoded.decoded === '') {
            throw createSaveOperationError(
              'validation',
              '存档内容无效或已损坏：' + entry.key
            )
          }
        }

        var snapshot = []
        var overwriteCount = 0
        for (var snapshotIndex = 0; snapshotIndex < entries.length; snapshotIndex++) {
          var snapshotKey = entries[snapshotIndex].key
          var oldValue = getSaveStorageValue(storage, snapshotKey)
          var exists = oldValue !== null && oldValue !== undefined
          if (exists) overwriteCount++
          snapshot.push({ key: snapshotKey, exists: exists, value: oldValue })
        }
        if (
          overwriteCount > 0 &&
          !confirm('导入将覆盖 ' + overwriteCount + ' 个现有存档，确定继续吗？')
        ) {
          return
        }

        setSaveOperationStatus('正在写入存档...')
        try {
          for (var writeIndex = 0; writeIndex < entries.length; writeIndex++) {
            setSaveStorageValue(
              storage,
              entries[writeIndex].key,
              entries[writeIndex].content
            )
          }
          await flushSaveStorage(storage)
        } catch (writeError) {
          var rollbackError = null
          try {
            await restoreSaveSnapshot(storage, snapshot)
          } catch (restoreError) {
            rollbackError = restoreError
          }
          var writeMessage = rollbackError
            ? '浏览器存储写入失败，自动恢复也未能安全落盘，请保持页面打开并导出备份'
            : '浏览器存储写入失败，原有存档已恢复'
          var operationError = createSaveOperationError('storage', writeMessage, writeError)
          operationError.rollbackError = rollbackError
          throw operationError
        }

        var message = '导入完成：' + entries.length + ' 个存档'
        if (ignored > 0) message += '，' + ignored + ' 个非存档项已忽略'
        alert(message)
      } catch(err) {
        console.warn('存档导入失败:', err)
        alert('导入失败：' + errorDetail(err))
      } finally {
        finishImport()
      }
    }
    reader.onerror = function() {
      alert('导入失败：无法读取文件')
      finishImport()
    }
    try {
      reader.readAsArrayBuffer(file)
    } catch (readStartError) {
      console.warn('[SaveManager] 无法读取存档压缩包:', readStartError)
      alert('导入失败：无法读取文件：' + errorDetail(readStartError))
      finishImport()
    }
  })
})
