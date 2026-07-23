/**
 * 调试菜单
 * config.ks 调用，提供场景跳转、标签触发、Ending 跳转、KS 执行、sf/存储 编辑
 */
;(function () {
  if (window.TYRANO && window.TYRANO.debugMenu) return

  var NS = window.TYRANO || (window.TYRANO = {})
  var container = null
  var sfArea = null
  var lsList = null
  var storageModified = false

  function markStorageModified() {
    storageModified = true
  }

  function setStyle(el, css) {
    for (var k in css) el.style[k] = css[k]
  }

  function createButton(text, onClick) {
    var btn = document.createElement('button')
    btn.textContent = text
    setStyle(btn, {
      padding: '5px 12px',
      border: '1px solid #ff88cc',
      borderRadius: '4px',
      background: 'rgba(255,136,204,0.15)',
      color: '#fff',
      cursor: 'pointer',
      fontSize: '12px',
      transition: 'background 0.2s',
    })
    btn.onmouseenter = function () {
      btn.style.background = 'rgba(255,136,204,0.35)'
    }
    btn.onmouseleave = function () {
      btn.style.background = 'rgba(255,136,204,0.15)'
    }
    btn.onclick = onClick
    return btn
  }

  function createInput(placeholder, value) {
    var input = document.createElement('input')
    input.type = 'text'
    input.placeholder = placeholder || ''
    input.value = value || ''
    setStyle(input, {
      width: '100%',
      padding: '5px 8px',
      border: '1px solid #555',
      borderRadius: '4px',
      background: 'rgba(0,0,0,0.5)',
      color: '#fff',
      fontSize: '12px',
      boxSizing: 'border-box',
      userSelect: 'text',
      webkitUserSelect: 'text',
    })
    input.onkeydown = function (e) {
      e.stopPropagation()
    }
    input.onkeyup = function (e) {
      e.stopPropagation()
    }
    input.onkeypress = function (e) {
      e.stopPropagation()
    }
    input.onselectstart = function (e) {
      e.stopPropagation()
    }
    return input
  }

  function createTextarea(value, rows) {
    var ta = document.createElement('textarea')
    ta.value = value || ''
    ta.spellcheck = false
    setStyle(ta, {
      width: '100%',
      minHeight: (rows || 5) * 16 + 'px',
      padding: '6px',
      border: '1px solid #555',
      borderRadius: '4px',
      background: 'rgba(0,0,0,0.5)',
      color: '#fff',
      fontSize: '11px',
      fontFamily: 'monospace',
      boxSizing: 'border-box',
      resize: 'vertical',
      userSelect: 'text',
      webkitUserSelect: 'text',
    })
    ta.onkeydown = function (e) {
      e.stopPropagation()
    }
    ta.onkeyup = function (e) {
      e.stopPropagation()
    }
    ta.onkeypress = function (e) {
      e.stopPropagation()
    }
    ta.onselectstart = function (e) {
      e.stopPropagation()
    }
    return ta
  }

  function createSection(title) {
    var sec = document.createElement('div')
    setStyle(sec, {
      marginBottom: '14px',
      padding: '10px',
      border: '1px solid #444',
      borderRadius: '6px',
      background: 'rgba(255,255,255,0.03)',
    })
    var h = document.createElement('div')
    h.textContent = title
    setStyle(h, {
      fontSize: '13px',
      fontWeight: 'bold',
      color: '#ff88cc',
      marginBottom: '8px',
      borderBottom: '1px solid #444',
      paddingBottom: '4px',
    })
    sec.appendChild(h)
    return sec
  }

  function createLabel(text) {
    var lbl = document.createElement('div')
    lbl.textContent = text
    setStyle(lbl, {
      fontSize: '11px',
      color: '#ccc',
      marginBottom: '3px',
      marginTop: '6px',
    })
    return lbl
  }

  function tryDecodeLsValue(key, raw) {
    // 尝试按 Tyrano 压缩格式解码
    if (window.LZString && raw && raw.length > 0) {
      try {
        var decompressed = LZString.decompress(raw)
        if (decompressed) {
          var decoded
          try {
            decoded = decodeURIComponent(decompressed)
          } catch (e) {
            decoded = unescape(decompressed)
          }
          var parsed = JSON.parse(decoded)
          return { type: 'json', value: parsed, text: JSON.stringify(parsed, null, 2) }
        }
      } catch (e) {}
      try {
        var decoded
        try {
          decoded = decodeURIComponent(raw)
        } catch (e) {
          decoded = unescape(raw)
        }
        var parsed = JSON.parse(decoded)
        return { type: 'json', value: parsed, text: JSON.stringify(parsed, null, 2) }
      } catch (e) {}
    }
    return { type: 'raw', value: raw, text: raw }
  }

  var globalBtn = null

  function updateGlobalDebugButton() {
    var show = false
    try {
      show = TYRANO.kag.variable.sf._debug_button_always_show === true
    } catch (e) {}

    if (!globalBtn) {
      globalBtn = document.createElement('div')
      globalBtn.id = 'tyrano_global_debug_btn'
      globalBtn.textContent = 'DEBUG'
      setStyle(globalBtn, {
        position: 'fixed',
        right: '8px',
        top: '8px',
        zIndex: '2147483646',
        padding: '4px 10px',
        background: 'rgba(255,0,0,0.55)',
        border: '1px solid #ff4444',
        borderRadius: '4px',
        color: '#fff',
        fontSize: '11px',
        fontFamily: 'sans-serif',
        cursor: 'pointer',
        textShadow: '1px 1px 2px #000',
        boxShadow: '0 0 10px rgba(255,0,0,0.4)',
        display: 'none',
        pointerEvents: 'auto',
      })
      globalBtn.onclick = function () {
        NS.showDebugMenu()
      }
      document.body.appendChild(globalBtn)
    }

    globalBtn.style.display = show ? 'block' : 'none'
  }
  NS.updateGlobalDebugButton = updateGlobalDebugButton

  function ensureContainer() {
    if (container) return container

    container = document.createElement('div')
    container.id = 'tyrano_debug_menu'
    setStyle(container, {
      position: 'fixed',
      left: '0',
      top: '0',
      width: '100vw',
      height: '100vh',
      zIndex: '2147483647',
      background: 'rgba(0,0,0,0.94)',
      color: '#fff',
      fontFamily: 'sans-serif',
      display: 'none',
      flexDirection: 'column',
      padding: '12px',
      boxSizing: 'border-box',
      overflow: 'auto',
      touchAction: 'pan-y',
      webkitOverflowScrolling: 'touch',
    })

    container.ontouchmove = function (e) {
      e.stopPropagation()
    }

    var header = document.createElement('div')
    setStyle(header, {
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'center',
      marginBottom: '8px',
      paddingBottom: '6px',
      borderBottom: '1px solid #444',
      flexShrink: '0',
    })
    var title = document.createElement('div')
    title.textContent = '调试菜单'
    setStyle(title, { fontSize: '16px', fontWeight: 'bold', color: '#ff88cc' })
    header.appendChild(title)
    header.appendChild(createButton('关闭', tryHideDebugMenu))
    container.appendChild(header)

    var warn = document.createElement('div')
    warn.textContent = '注意：修改 sf/存储 可能导致存档损坏。'
    setStyle(warn, {
      fontSize: '10px',
      color: '#ff8888',
      marginBottom: '8px',
      flexShrink: '0',
    })
    container.appendChild(warn)

    var content = document.createElement('div')
    setStyle(content, {
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))',
      gap: '12px',
      alignItems: 'start',
    })

    // ---------- 1. 场景跳转 ----------
    var secJump = createSection('场景跳转')
    secJump.appendChild(createLabel('场景文件（例：title_screen.ks）'))
    var jumpStorage = createInput('title_screen.ks')
    secJump.appendChild(jumpStorage)
    secJump.appendChild(createLabel('标签（例：*title，可留空）'))
    var jumpTarget = createInput('*title')
    secJump.appendChild(jumpTarget)
    secJump.appendChild(document.createElement('div'))
    secJump.appendChild(
      createButton('跳转', function () {
        var s = jumpStorage.value.trim()
        var t = jumpTarget.value.trim()
        if (!s) return Swal.fire({ text: '请输入场景文件', icon: 'info' })
        try {
          TYRANO.kag.ftag.startTag('jump', {
            storage: s,
            target: t || undefined,
          })
          hideDebugMenu()
          TYRANO.kag.layer.hideEventLayer()
        } catch (e) {
          Swal.fire({ text: '跳转失败：' + e.message, icon: 'info' })
        }
      })
    )
    content.appendChild(secJump)

    // ---------- 2. Ending 跳转 ----------
    var secEnding = createSection('Ending 跳转')
    secEnding.appendChild(createLabel('Ending 场景文件（例：Chapter4_trueEND.ks）'))
    var endingStorage = createInput('Chapter4_trueEND.ks')
    secEnding.appendChild(endingStorage)
    secEnding.appendChild(createLabel('标签（例：*title，可留空）'))
    var endingTarget = createInput('*title')
    secEnding.appendChild(endingTarget)
    secEnding.appendChild(document.createElement('div'))
    secEnding.appendChild(
      createButton('跳转至 Ending', function () {
        var s = endingStorage.value.trim()
        var t = endingTarget.value.trim()
        if (!s) return Swal.fire({ text: '请输入场景文件', icon: 'info' })
        try {
          TYRANO.kag.ftag.startTag('jump', {
            storage: s,
            target: t || undefined,
          })
          hideDebugMenu()
        } catch (e) {
          Swal.fire({ text: 'Ending 跳转失败：' + e.message, icon: 'info' })
        }
      })
    )
    content.appendChild(secEnding)

    // ---------- 3. 标签触发 ----------
    var secTag = createSection('标签触发')
    secTag.appendChild(createLabel('标签名（例：playbgm）'))
    var tagName = createInput('playbgm')
    secTag.appendChild(tagName)
    secTag.appendChild(createLabel('参数 JSON'))
    var tagParams = createTextarea('{"storage":"title_main.mp3","buf":"0"}', 3)
    secTag.appendChild(tagParams)
    secTag.appendChild(document.createElement('div'))
    secTag.appendChild(
      createButton('触发', function () {
        var name = tagName.value.trim()
        if (!name) return Swal.fire({ text: '请输入标签名', icon: 'info' })
        try {
          var pm = JSON.parse(tagParams.value || '{}')
          TYRANO.kag.ftag.startTag(name, pm)
        } catch (e) {
          Swal.fire({ text: '触发失败：' + e.message, icon: 'info' })
        }
      })
    )
    var presets = document.createElement('div')
    setStyle(presets, { marginTop: '8px', display: 'flex', gap: '6px', flexWrap: 'wrap' })
    ;[
      ['playbgm', '{"storage":"title_main.mp3","buf":"0"}'],
      ['playse', '{"storage":"tap.ogg","buf":"0"}'],
      ['bg', '{"storage":"kuro.webp","time":"500"}'],
      ['s', '{}'],
    ].forEach(function (p) {
      presets.appendChild(
        createButton(p[0], function () {
          tagName.value = p[0]
          tagParams.value = p[1]
        })
      )
    })
    secTag.appendChild(presets)
    content.appendChild(secTag)

    // ---------- 4. KS 脚本直接执行 ----------
    var secKs = createSection('KS 脚本直接执行')
    secKs.appendChild(createLabel('输入 KS 脚本（例：[bg storage="kuro.webp" time="500"]）'))
    var ksArea = createTextarea('[bg storage="kuro.webp" time="500"]', 4)
    secKs.appendChild(ksArea)
    secKs.appendChild(document.createElement('div'))
    secKs.appendChild(
      createButton('执行 KS', function () {
        var src = ksArea.value.trim()
        if (!src) return Swal.fire({ text: '请输入脚本', icon: 'info' })
        try {
          var result = TYRANO.kag.parser.parseScenario(src)
          if (!result || !result.array_s || !result.array_s.length) {
            return Swal.fire({ text: '解析结果为空', icon: 'info' })
          }
          result.array_s.forEach(function (tag) {
            TYRANO.kag.ftag.startTag(tag.name, tag.pm)
          })
          hideDebugMenu()
        } catch (e) {
          Swal.fire({ text: 'KS 执行失败：' + e.message, icon: 'info' })
        }
      })
    )
    content.appendChild(secKs)

    // ---------- 5. 全局 DEBUG 按钮开关 ----------
    var secGlobal = createSection('全局 DEBUG 按钮')
    var globalToggleWrap = document.createElement('div')
    setStyle(globalToggleWrap, {
      display: 'flex',
      alignItems: 'center',
      gap: '10px',
    })
    var globalToggle = document.createElement('input')
    globalToggle.type = 'checkbox'
    globalToggle.id = 'debug_global_toggle'
    globalToggle.onkeydown = function (e) {
      e.stopPropagation()
    }
    globalToggle.onkeyup = function (e) {
      e.stopPropagation()
    }
    globalToggle.onkeypress = function (e) {
      e.stopPropagation()
    }
    try {
      globalToggle.checked = TYRANO.kag.variable.sf._debug_button_always_show === true
    } catch (e) {
      globalToggle.checked = false
    }
    globalToggle.onchange = function () {
      try {
        TYRANO.kag.variable.sf._debug_button_always_show = globalToggle.checked
        var cfg = TYRANO.kag.config
        $.setStorage(cfg.projectID + '_sf', TYRANO.kag.variable.sf, cfg.configSave)
        markStorageModified()
        updateGlobalDebugButton()
        Swal.fire({ text: globalToggle.checked ? '已开启：DEBUG 按钮将始终显示' : '已关闭：DEBUG 按钮仅在设置页面显示', icon: 'info' })
      } catch (e) {
        Swal.fire({ text: '保存失败：' + e.message, icon: 'info' })
      }
    }
    var globalToggleLabel = document.createElement('label')
    globalToggleLabel.htmlFor = 'debug_global_toggle'
    globalToggleLabel.textContent = 'DEBUG 始终显示在屏幕上'
    setStyle(globalToggleLabel, { fontSize: '12px', cursor: 'pointer' })
    globalToggleWrap.appendChild(globalToggle)
    globalToggleWrap.appendChild(globalToggleLabel)
    secGlobal.appendChild(globalToggleWrap)
    secGlobal.appendChild(
      createButton('立即刷新显示状态', function () {
        updateGlobalDebugButton()
      })
    )
    content.appendChild(secGlobal)

    // ---------- 6. sf 编辑器 ----------
    var secSf = createSection('System Flag (sf) 编辑器')
    sfArea = createTextarea('', 10)
    sfArea.placeholder = '点击“重新加载 sf”后显示内容'
    secSf.appendChild(sfArea)
    secSf.appendChild(document.createElement('div'))
    secSf.appendChild(
      createButton('重新加载 sf', function () {
        try {
          sfArea.value = JSON.stringify(TYRANO.kag.variable.sf, null, 2)
        } catch (e) {
          sfArea.value = '读取失败：' + e.message
        }
      })
    )
    secSf.appendChild(
      createButton('保存 sf', function () {
        try {
          var obj = JSON.parse(sfArea.value)
          TYRANO.kag.variable.sf = obj
          var cfg = TYRANO.kag.config
          $.setStorage(cfg.projectID + '_sf', obj, cfg.configSave)
          Swal.fire({ text: 'sf 已保存', icon: 'info' })
        } catch (e) {
          Swal.fire({ text: 'JSON 错误：' + e.message, icon: 'info' })
        }
      })
    )
    content.appendChild(secSf)

    // ---------- 6. 存储编辑器 ----------
    var secLs = createSection('存储编辑器')

    var lsFilter = createInput('搜索 key...')
    secLs.appendChild(lsFilter)

    lsList = document.createElement('div')
    setStyle(lsList, {
      maxHeight: '240px',
      overflow: 'auto',
      border: '1px solid #444',
      borderRadius: '4px',
      padding: '6px',
      background: 'rgba(0,0,0,0.3)',
      marginTop: '6px',
    })
    secLs.appendChild(lsList)

    var lsDetail = document.createElement('div')
    setStyle(lsDetail, {
      marginTop: '8px',
      padding: '8px',
      border: '1px solid #444',
      borderRadius: '4px',
      background: 'rgba(0,0,0,0.3)',
      display: 'none',
    })
    secLs.appendChild(lsDetail)

    var currentEditingKey = null

    function renderLsList(filter) {
      lsList.innerHTML = ''
      filter = (filter || '').toLowerCase()
      var keys = window.api && window.api.storage ? window.api.storage.keys() : []
      keys = keys.filter(function (k) {
        return !filter || k.toLowerCase().indexOf(filter) >= 0
      })
      keys.forEach(function (key) {
        var row = document.createElement('div')
        setStyle(row, {
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          padding: '4px 6px',
          marginBottom: '3px',
          borderRadius: '3px',
          background: 'rgba(255,255,255,0.05)',
          cursor: 'pointer',
        })
        row.onmouseenter = function () {
          row.style.background = 'rgba(255,136,204,0.2)'
        }
        row.onmouseleave = function () {
          row.style.background = 'rgba(255,255,255,0.05)'
        }
        var keyText = document.createElement('span')
        keyText.textContent = key
        setStyle(keyText, {
          fontSize: '11px',
          fontFamily: 'monospace',
          overflow: 'hidden',
          textOverflow: 'ellipsis',
          whiteSpace: 'nowrap',
          maxWidth: 'calc(100% - 50px)',
        })
        row.appendChild(keyText)
        row.appendChild(
          createButton('编辑', function () {
            openLsEdit(key)
          })
        )
        row.onclick = function (e) {
          if (e.target.tagName !== 'BUTTON') openLsEdit(key)
        }
        lsList.appendChild(row)
      })
      if (keys.length === 0) {
        lsList.textContent = '无匹配项'
        setStyle(lsList, { color: '#888', fontSize: '12px', textAlign: 'center' })
      }
    }

    function openLsEdit(key) {
      currentEditingKey = key
      var raw = window.api && window.api.storage ? window.api.storage.getItem(key) : null
      var decoded = tryDecodeLsValue(key, raw)
      lsDetail.style.display = 'block'
      lsDetail.innerHTML = ''

      var keyInput = createInput('key', key)
      var valArea = createTextarea(decoded.text, 8)
      var typeLabel = document.createElement('div')
      typeLabel.textContent = '类型：' + (decoded.type === 'json' ? 'JSON（已解码）' : '原始文本')
      setStyle(typeLabel, { fontSize: '11px', color: '#aaa', marginBottom: '6px' })

      var btnRow = document.createElement('div')
      setStyle(btnRow, { display: 'flex', gap: '6px', marginTop: '6px', flexWrap: 'wrap' })

      btnRow.appendChild(
        createButton('保存', function () {
          try {
            var newKey = keyInput.value.trim()
            if (!newKey) return Swal.fire({ text: 'key 不能为空', icon: 'info' })
            if (decoded.type === 'json') {
              // 验证 JSON 并按原格式保存
              var obj = JSON.parse(valArea.value)
              var cfg = TYRANO.kag.config
              if (newKey === cfg.projectID + '_sf' || key === cfg.projectID + '_sf') {
                $.setStorage(newKey, obj, cfg.configSave)
              } else {
                window.api.storage.setItem(newKey, encodeURIComponent(JSON.stringify(obj)))
              }
            } else {
              window.api.storage.setItem(newKey, valArea.value)
            }
            if (newKey !== key) window.api.storage.removeItem(key)
            markStorageModified()
            renderLsList(lsFilter.value)
            Swal.fire({ text: '已保存', icon: 'info' })
          } catch (e) {
            Swal.fire({ text: '保存失败：' + e.message, icon: 'info' })
          }
        })
      )
      btnRow.appendChild(
        createButton('删除', function () {
          Swal.fire({
            text: '确定删除 ' + key + ' ？',
            icon: 'warning',
            showCancelButton: true,
          }).then(function (result) {
            if (!result.isConfirmed) return
            window.api.storage.removeItem(key)
            markStorageModified()
            lsDetail.style.display = 'none'
            renderLsList(lsFilter.value)
          })
        })
      )
      btnRow.appendChild(
        createButton('关闭', function () {
          lsDetail.style.display = 'none'
        })
      )

      lsDetail.appendChild(createLabel('Key'))
      lsDetail.appendChild(keyInput)
      lsDetail.appendChild(typeLabel)
      lsDetail.appendChild(createLabel('Value'))
      lsDetail.appendChild(valArea)
      lsDetail.appendChild(btnRow)
    }

    lsFilter.oninput = function () {
      renderLsList(lsFilter.value)
    }

    secLs.appendChild(
      createButton('刷新列表', function () {
        renderLsList(lsFilter.value)
      })
    )

    // 新增存储项
    secLs.appendChild(document.createElement('div'))
    secLs.appendChild(createLabel('新增 key / value'))
    var newKey = createInput('new key')
    var newVal = createInput('new value')
    secLs.appendChild(newKey)
    secLs.appendChild(newVal)
    secLs.appendChild(
      createButton('添加', function () {
        if (!newKey.value) return Swal.fire({ text: '请输入 key', icon: 'info' })
        window.api.storage.setItem(newKey.value, newVal.value)
        markStorageModified()
        newKey.value = ''
        newVal.value = ''
        renderLsList(lsFilter.value)
      })
    )

    // 导入原版游戏 .sav 存档
    secLs.appendChild(document.createElement('div'))
    secLs.appendChild(createLabel('导入原版存档（多选 .sav）'))
    var importInput = document.createElement('input')
    importInput.type = 'file'
    importInput.multiple = true
    importInput.accept = '.sav'
    importInput.style.display = 'none'
    importInput.onchange = function (e) {
      var files = e.target.files
      if (!files || files.length === 0) return
      if (!window.api || !window.api.storage) {
        Swal.fire({ text: 'window.api.storage 不可用', icon: 'info' })
        importInput.value = ''
        return
      }
      var imported = 0
      var failed = 0
      var pending = files.length

      function checkDone() {
        if (pending > 0) return
        Swal.fire({ text: '导入完成：' + imported + ' 个成功，' + failed + ' 个失败', icon: 'info' })
        window.api.storage.flush()
        renderLsList(lsFilter.value)
        importInput.value = ''
      }

      Array.prototype.forEach.call(files, function (file) {
        var reader = new FileReader()
        reader.onload = function (ev) {
          try {
            var name = file.name
            if (name.toLowerCase().lastIndexOf('.sav') === name.length - 4) {
              name = name.slice(0, -4)
            }
            // 文件名对应原键（可能被 URL 编码）
            var key = decodeURIComponent(name)
            // .sav 文件内容已经是 encodeURIComponent(JSON.stringify(...)) 的格式，
            // 直接存入 IndexedDB 即可被 Tyrano 的读取流程正确解码
            var value = ev.target.result
            window.api.storage.setItem(key, value)
            markStorageModified()
            imported++
          } catch (err) {
            console.error('导入失败', file.name, err)
            failed++
          }
          pending--
          checkDone()
        }
        reader.onerror = function () {
          failed++
          pending--
          checkDone()
        }
        reader.readAsText(file, 'UTF-8')
      })
    }
    secLs.appendChild(importInput)
    secLs.appendChild(
      createButton('导入原版存档 (.sav)', function () {
        importInput.click()
      })
    )

    // 导出原版游戏 .sav 存档
    secLs.appendChild(document.createElement('div'))
    secLs.appendChild(createLabel('导出原版存档为 zip'))
    secLs.appendChild(
      createButton('导出原版存档 (.zip)', function () {
        if (!window.api || !window.api.storage) {
          Swal.fire({ text: 'window.api.storage 不可用', icon: 'info' })
          return
        }
        if (typeof JSZip === 'undefined') {
          Swal.fire({ text: 'JSZip 库未加载', icon: 'info' })
          return
        }
        try {
          var keys = window.api.storage.keys().filter(function (key) {
            return key && !key.startsWith('_tyrano_browser_')
          })
          var zip = new JSZip()
          var exported = 0
          keys.forEach(function (key) {
            var value = window.api.storage.getItem(key)
            if (value === null) return
            var filename = encodeURIComponent(key) + '.sav'
            zip.file(filename, value)
            exported++
          })
          if (exported === 0) {
            Swal.fire({ text: '没有可导出的存档数据', icon: 'info' })
            return
          }
          zip.generateAsync({ type: 'blob' }).then(function (blob) {
            var url = URL.createObjectURL(blob)
            var link = document.createElement('a')
            link.href = url
            link.download = 'DevilConnection_saves.zip'
            document.body.appendChild(link)
            link.click()
            document.body.removeChild(link)
            URL.revokeObjectURL(url)
            Swal.fire({ text: '已导出 ' + exported + ' 个存档文件', icon: 'success' })
          })
        } catch (e) {
          console.error('导出存档失败', e)
          Swal.fire({ text: '导出失败：' + e.message, icon: 'info' })
        }
      })
    )

    content.appendChild(secLs)

    // 页脚占位，防止移动端浏览器地址栏遮住底部按钮
    var footer = document.createElement('div')
    footer.textContent = ' '
    setStyle(footer, {
      height: '120px',
      flexShrink: '0',
    })
    container.appendChild(content)
    container.appendChild(footer)
    document.body.appendChild(container)

    NS.reloadDebugMenu = function () {
      // sf / 存储 は手動で読み込み（自動読み込みは重いため）
      sfArea.value = ''
      lsList.innerHTML = '<div style="color:#888;font-size:12px;text-align:center;padding:8px">点击“刷新列表”加载</div>'
    }

    return container
  }

  NS.showDebugMenu = function () {
    ensureContainer()
    if (container) {
      container.style.display = 'flex'
      if (NS.reloadDebugMenu) NS.reloadDebugMenu()
    }
  }

  function tryHideDebugMenu() {
    if (storageModified) {
      Swal.fire({
        html: '已修改存储数据，需要刷新页面才能使更改生效，否则继续游戏可能会覆盖修改。<br>确定要刷新页面吗？<br>（取消可继续留在调试菜单）',
        icon: 'warning',
        showCancelButton: true,
      }).then(function (result) {
        if (result.isConfirmed) {
          location.reload()
        }
      })
      return
    }
    hideDebugMenu()
  }

  function hideDebugMenu() {
    if (container) container.style.display = 'none'
  }
  NS.hideDebugMenu = tryHideDebugMenu

  NS.debugMenu = { show: NS.showDebugMenu, hide: tryHideDebugMenu }
})()
