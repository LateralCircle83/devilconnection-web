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

function openModConfig(modId, modName) {
  _cfgModId = modId
  document.getElementById('mod_config_title').textContent = modName + ' 配置'
  var fieldsEl = document.getElementById('mod_config_fields')
  fieldsEl.innerHTML = '<div style="opacity:0.5;text-align:center;">读取配置中...</div>'
  document.getElementById('mod_config_modal').style.display = 'flex'

  var modEntry = _modList ? _modList.find(function(m) { return m.id === modId }) : null
  if (!modEntry) { fieldsEl.innerHTML = '<div style="opacity:0.5;text-align:center;">模组信息缺失</div>'; return }

  if (modEntry.isLocal) {
    var s = (window.ModLoader && ModLoader._localConfigs) ? ModLoader._localConfigs[modId] : null
    if (s) { renderConfigForm(s); return }
    fieldsEl.innerHTML = '<div style="opacity:0.5;text-align:center;">该模组无可配置项</div>'
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
    fieldsEl.innerHTML = '<div style="opacity:0.5;text-align:center;">该模组无可配置项</div>'
  })
}

function renderConfigForm(schema) {
  _cfgSchema = schema
  var fieldsEl = document.getElementById('mod_config_fields')
  if (!schema || !schema.fields || !schema.fields.length) {
    fieldsEl.innerHTML = '<div style="opacity:0.5;text-align:center;">无可配置项</div>'
    return
  }
  var html = ''
  if (schema.description) {
    html += '<div style="font-size:12px;opacity:0.6;margin-bottom:14px;">' + esc(schema.description) + '</div>'
  }
  var saved = {}
  try { saved = JSON.parse(localStorage.getItem('mod_config_' + _cfgModId)) || {} } catch(e) {}

  for (var i = 0; i < schema.fields.length; i++) {
    var f = schema.fields[i]
    var val = saved[f.key] !== undefined ? saved[f.key] : f.default
    var inputId = 'cfg_' + f.key
    html += '<div style="margin-bottom:12px;"><label for="' + inputId + '" style="display:block;font-size:13px;margin-bottom:4px;color:#7ea8b4;">' + esc(f.label || f.key) + '</label>'
    if (f.type === 'toggle') {
      html += '<input type="checkbox" id="' + inputId + '" ' + (val ? 'checked' : '') + ' style="width:20px;height:20px;accent-color:#ffc1b3;">'
    } else if (f.type === 'number') {
      html += '<input type="number" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid #dce8ec;border-radius:6px;background:#f0f6f8;color:#4a5568;font-size:14px;box-sizing:border-box;outline:none;">'
    } else if (f.type === 'password') {
      html += '<input type="password" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid #dce8ec;border-radius:6px;background:#f0f6f8;color:#4a5568;font-size:14px;box-sizing:border-box;outline:none;">'
    } else {
      html += '<input type="text" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid #dce8ec;border-radius:6px;background:#f0f6f8;color:#4a5568;font-size:14px;box-sizing:border-box;outline:none;">'
    }
    if (f.help) html += '<div style="font-size:11px;opacity:0.4;margin-top:3px;">' + esc(f.help) + '</div>'
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
  document.getElementById('mod_config_modal').style.display = 'none'
  _cfgModId = null; _cfgSchema = null
}

// ===== 存档清除 =====
function clearAllSaves() {
  if (!confirm('确定清除所有存档数据？此操作不可恢复！')) return
  if (!confirm('再次确认：所有存档数据将被永久删除！')) return
  try {
    var storage = window.api && window.api.storage
    var keys = []
    if (storage && storage.keys) { try { keys = storage.keys() || [] } catch(e) {} }
    else { keys = Object.keys(localStorage).filter(function(k) { return k.indexOf('DevilConnection') >= 0 || k.indexOf('_tyrano_') >= 0 }) }
    for (var i = 0; i < keys.length; i++) {
      if (storage && storage.removeItem) storage.removeItem(keys[i])
      else localStorage.removeItem(keys[i])
    }
    var flushed = storage && storage.flush ? storage.flush() : Promise.resolve()
    Promise.resolve(flushed).then(function() {
      alert('已清除 ' + keys.length + ' 个存档数据')
    }).catch(function(e) {
      alert('清除失败: ' + (e && e.message ? e.message : e))
    })
  } catch(e) { alert('清除失败: ' + e.message) }
}

// ===== 存档导出 =====
function toggleSaveImport() {
  if (_importingSave) return; _importingSave = true
  try {
    var zip = new JSZip(), storage = window.api && window.api.storage
    if (!storage) { alert('存储不可用'); _importingSave = false; return }
    var keys = []
    try { keys = storage.keys() || [] } catch(e) { keys = Object.keys(localStorage) }
    var count = 0
    for (var i = 0; i < keys.length; i++) {
      var k = keys[i], v = storage.getItem ? storage.getItem(k) : localStorage.getItem(k)
      if (v != null) { zip.file(encodeURIComponent(k) + '.sav', v); count++ }
    }
    if (count === 0) { alert('没有可导出的存档数据'); _importingSave = false; return }
    zip.generateAsync({ type: 'blob' }).then(function(blob) {
      var url = URL.createObjectURL(blob), a = document.createElement('a')
      a.href = url; a.download = 'DevilConnection_saves.zip'
      document.body.appendChild(a); a.click(); document.body.removeChild(a)
      setTimeout(function() { URL.revokeObjectURL(url) }, 10000); _importingSave = false
    }).catch(function() { _importingSave = false })
  } catch(e) { alert('导出失败'); _importingSave = false }
}

// ===== 页面初始化 =====
document.addEventListener('DOMContentLoaded', function() {
  var modListEl = document.getElementById('mod_list')
  var startBtn = document.getElementById('start_game_btn')
  var overlay = document.getElementById('tyrano_click_to_start')
  var startButtonText = startBtn ? startBtn.textContent : '启动游戏'
  var startFailed = false

  function switchPage(page) {
    document.querySelectorAll('.page').forEach(function(p) { p.style.display = 'none' })
    var target = document.getElementById('page-' + page)
    if (target) target.style.display = 'block'
    document.querySelectorAll('.nav-item').forEach(function(n) {
      var act = n.getAttribute('data-page') === page
      n.style.background = act ? '#7ea8b4' : 'transparent'
      n.style.color = act ? '#fff' : '#7ea8b4'
      n.style.fontWeight = act ? '600' : '400'
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
      modListEl.innerHTML = '<div style="text-align:center;color:#475569;padding:24px;font-size:13px;">没有可用模组</div>'
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
          failStart('模组加载器初始化失败', e && e.message ? e.message : String(e))
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
    overlay.style.transition = 'opacity 0.4s ease'
    overlay.style.opacity = '0'
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
        var meta = ModLoader.readAsarMeta(buf) || {}
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
    _importingSave = true

    function finishImport() {
      _importingSave = false
      importInput.value = ''
    }

    var reader = new FileReader()
    reader.onload = function(ev) {
      if (typeof JSZip === 'undefined') {
        alert('导入失败：JSZip 库未加载')
        finishImport()
        return
      }
      JSZip.loadAsync(ev.target.result).then(function(zip) {
        var storage = window.api && window.api.storage
        var tasks = []
        var imported = 0
        var failed = 0

        zip.forEach(function(p, f) {
          if (f.dir || !/\.sav$/i.test(p)) return
          tasks.push(
            f.async('string').then(function(content) {
              var key = decodeURIComponent(p.replace(/\.sav$/i, ''))
              if (storage && storage.setItem) storage.setItem(key, content)
              else localStorage.setItem(key, content)
              imported++
            }).catch(function(err) {
              console.warn('存档导入失败:', p, err)
              failed++
            })
          )
        })

        if (tasks.length === 0) {
          alert('ZIP 中没有可导入的 .sav 存档文件')
          return null
        }

        return Promise.all(tasks).then(function() {
          if (storage && storage.flush) return storage.flush()
        }).then(function() {
          alert('导入完成：' + imported + ' 个成功，' + failed + ' 个失败')
        })
      }).catch(function(err) {
        console.warn('存档导入失败:', err)
        alert('导入失败：ZIP 格式错误或读取失败')
      }).then(finishImport)
    }
    reader.onerror = function() {
      alert('导入失败：无法读取文件')
      finishImport()
    }
    reader.readAsArrayBuffer(file)
  })
})
