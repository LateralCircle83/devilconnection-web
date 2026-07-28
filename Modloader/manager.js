// ===== 模组管理器 - 配置逻辑 =====
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
    var view = new Uint8Array(buf)
    var bracePos = -1
    for (var i = 0; i < 2048 && i < view.length; i++) {
      if (view[i] === 0x7b) { bracePos = i; break }
    }
    if (bracePos === -1) throw new Error('JSON { not found')
    var depth = 0, endPos = -1
    for (var i = bracePos; i < view.length; i++) {
      if (view[i] === 0x7b) depth++
      if (view[i] === 0x7d) { depth--; if (depth === 0) { endPos = i; break } }
    }
    if (endPos === -1) throw new Error('JSON } not found')
    var dec = new TextDecoder('utf-8')
    var headerJson = dec.decode(new Uint8Array(buf, bracePos, endPos - bracePos + 1))
    var header = JSON.parse(headerJson)

    var schemaOffset = null, schemaSize = null
    function findFile(tree, prefix) {
      if (!tree || !tree.files) return
      for (var name in tree.files) {
        var entry = tree.files[name]
        var path = prefix ? prefix + '/' + name : name
        if (entry.files) { findFile(entry, path) }
        else if (path === 'config.schema.json' || path === '/config.schema.json') {
          schemaOffset = parseInt(entry.offset, 10)
          schemaSize = parseInt(entry.size, 10)
          return
        }
      }
    }
    findFile(header, '')
    if (schemaOffset === null) throw new Error('config.schema.json not in ASAR')

    var dOff = endPos + 1
    while (dOff < view.length && (view[dOff] === 0 || view[dOff] === 10 || view[dOff] === 13)) dOff++
    var schemaBytes = new Uint8Array(buf, dOff + schemaOffset, schemaSize)
    var schemaText = dec.decode(schemaBytes)
    var schema = JSON.parse(schemaText)
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
    html += '<div style="margin-bottom:12px;"><label for="' + inputId + '" style="display:block;font-size:13px;margin-bottom:4px;opacity:0.8;">' + esc(f.label || f.key) + '</label>'
    if (f.type === 'toggle') {
      html += '<input type="checkbox" id="' + inputId + '" ' + (val ? 'checked' : '') + ' style="width:20px;height:20px;accent-color:#7c3aed;">'
    } else if (f.type === 'number') {
      html += '<input type="number" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid rgba(255,255,255,0.15);border-radius:6px;background:rgba(0,0,0,0.3);color:#e2e8f0;font-size:14px;box-sizing:border-box;">'
    } else if (f.type === 'password') {
      html += '<input type="password" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid rgba(255,255,255,0.15);border-radius:6px;background:rgba(0,0,0,0.3);color:#e2e8f0;font-size:14px;box-sizing:border-box;">'
    } else {
      html += '<input type="text" id="' + inputId + '" value="' + esc(String(val != null ? val : '')) + '" placeholder="' + esc(f.placeholder || '') + '" style="width:100%;padding:8px 10px;border:1px solid rgba(255,255,255,0.15);border-radius:6px;background:rgba(0,0,0,0.3);color:#e2e8f0;font-size:14px;box-sizing:border-box;">'
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

  function switchPage(page) {
    document.querySelectorAll('.page').forEach(function(p) { p.style.display = 'none' })
    var target = document.getElementById('page-' + page)
    if (target) target.style.display = 'block'
    document.querySelectorAll('.nav-item').forEach(function(n) {
      var act = n.getAttribute('data-page') === page
      n.style.background = act ? 'rgba(124,58,237,0.15)' : 'transparent'
      n.style.color = act ? '#a78bfa' : '#94a3b8'
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

  function renderModList(mods) {
    _modList = mods || []
    if (!mods || mods.length === 0) {
      modListEl.innerHTML = '<div style="text-align:center;color:#475569;padding:24px;font-size:13px;">没有可用模组</div>'
      return
    }
    var html = ''
    for (var i = 0; i < mods.length; i++) {
      var m = mods[i]
      html +=
        '<div class="mod-item" data-id="' + m.id + '">' +
        '<span class="drag-handle">☰☰</span>' +
        '<div class="mod-info"><div class="mod-name">' + esc(m.name) + '</div>' +
        (m.description ? '<div class="mod-desc">' + esc(m.description) + '</div>' : '') +
        (m.isLocal ? '<span class="mod-local">[本地]</span>' : '') + '</div>' +
        '<button onclick="openModConfig(\'' + m.id + '\',\'' + esc(m.name) + '\');event.stopPropagation()" class="btn-config">配置</button>' +
        '<input type="checkbox" class="mod_checkbox" data-id="' + m.id + '" checked>' +
        '</div>'
    }
    modListEl.innerHTML = html
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

  var engineScripts = ['tyrano/lang.js','tyrano/libs.js','tyrano/tyrano.js','tyrano/tyrano.base.js','tyrano/plugins/kag/kag.js','tyrano/plugins/kag/kag.event.js','tyrano/plugins/kag/kag.key_mouse.js','tyrano/plugins/kag/kag.layer.js','tyrano/plugins/kag/kag.menu.js','tyrano/plugins/kag/kag.parser.js','tyrano/plugins/kag/kag.rider.js','tyrano/plugins/kag/kag.studio.js','tyrano/plugins/kag/kag.tag_audio.js','tyrano/plugins/kag/kag.tag_camera.js','tyrano/plugins/kag/kag.tag_ext.js','tyrano/plugins/kag/kag.tag_system.js','tyrano/plugins/kag/kag.tag_vchat.js','tyrano/plugins/kag/kag.tag_ar.js','tyrano/plugins/kag/kag.tag_three.js','tyrano/plugins/kag/kag.tag.js','data/system/KeyConfig.js','electron_latest.js']

  function loadEngine(index) {
    if (index >= engineScripts.length) { finishStart(); return }
    var s = document.createElement('script')
    s.src = './' + engineScripts[index]
    s.onload = function() { loadEngine(index + 1) }
    s.onerror = function() { console.warn('引擎加载失败:', engineScripts[index]); loadEngine(index + 1) }
    document.head.appendChild(s)
  }

  function startGame(e) {
    if (e) e.stopPropagation()
    startBtn.disabled = true; startBtn.textContent = '加载中...'
    var cbs = document.querySelectorAll('.mod_checkbox:checked'), ids = []
    for (var i = 0; i < cbs.length; i++) ids.push(cbs[i].getAttribute('data-id'))
    function go() { loadEngine(0) }
    if (window.ModLoader) { ModLoader.init(ids).then(go).catch(function(e) { console.warn(e); go() }) } else { go() }
  }

  function finishStart() {
    try { new Audio('./tyrano/audio/silent.mp3').play() } catch(e) {}
    try { if (Howler && Howler.ctx && Howler.ctx.state === 'suspended') Howler.ctx.resume() } catch(e) {}
    overlay.style.transition = 'opacity 0.4s ease'
    overlay.style.opacity = '0'
    setTimeout(function() {
      if (overlay.parentNode) overlay.parentNode.removeChild(overlay)
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
        _modList.push({ id: localId, name: name, description: (meta && meta.description) || '本地加载的 ASAR 模组', author: '', isLocal: true })
        renderModList(_modList)
        var cbs = document.querySelectorAll('.mod_checkbox')
        if (cbs.length) cbs[cbs.length - 1].checked = true
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
    var reader = new FileReader()
    reader.onload = function(ev) {
      try {
        JSZip.loadAsync(ev.target.result).then(function(zip) {
          var done = 0
          zip.forEach(function(p, f) {
            f.async('string').then(function(content) {
              var key = decodeURIComponent(p.replace(/\.sav$/i, ''))
              var storage = window.api && window.api.storage
              if (storage && storage.setItem) storage.setItem(key, content)
              else localStorage.setItem(key, content)
              done++
            })
          })
          setTimeout(function() { alert('导入完成 (' + done + ' 个存档)') }, 500)
        }).catch(function() { alert('导入失败：ZIP 格式错误') })
      } catch(e) { alert('导入失败') }
    }
    reader.readAsArrayBuffer(file)
    importInput.value = ''
  })
})
