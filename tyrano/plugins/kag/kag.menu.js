function playSE(storage, buf = '1') {
  buf = buf.toString()
  tyrano.plugin.kag.ftag.startTag('playse', {
    storage,
    buf,
    stop: true,
  })
}

function bindHover(to, img, before, after) {
  $(to)
    .mouseover(e => {
      $(img).attr('src', `data/image/menu/${after}`)
      playSE('tap.ogg')
      e.stopPropagation()
    })
    .mouseout(e => {
      $(img).attr('src', `data/image/menu/${before}`)
      e.stopPropagation()
    })
}

tyrano.plugin.kag.menu = {
  tyrano: null,
  kag: null,
  snap: null,
  bg: null,
  maxSaveCount: 600,
  init: function () {
    var that = this
    readAsArrayBuffer('./data/image/menu/menu.png')
      .then(loadAPNG)
      .then(apng => {
        that.bg = apng
      })
  },
  showMenu: function (force) {
    const layer_menu = this.kag.layer.getMenuLayer()
    // メニューボタンが表示されていない・既にメニューが表示されている場合は開かない
    if (
      !force &&
      ($('.menu_button.event-setting-element:visible,.menu_syoukan:visible')
        .length == 0 ||
        layer_menu.css('display') != 'none')
    )
      return !1
    $('.layer_event_guard').show()
    // 召喚画面ではnemumi用のタイマーを切る
    const timerId = this.kag.stat.f.timerId
    if (timerId) {
      clearTimeout(timerId)
      this.kag.stat.f.timerId = null
    }
    if (
      !force &&
      'none' == this.kag.layer.layer_event.css('display') &&
      1 != this.kag.stat.is_strong_stop
    )
      return !1
    if (1 == this.kag.stat.is_wait) return !1
    var that = this
    this.kag.stat.is_skip = !1
    this.kag.stat.is_auto = !1
    this.kag.stat.is_auto_wait = !1
    layer_menu.empty()
    const kSuffix = this.kag.variable.sf.kill > 0 ? '_k' : ''
    const day = this.kag.stat.f.day_epilogue || this.kag.stat.f.day
    this.kag.html(
      'menu',
      {
        novel: $.novel,
        day,
        epilogue: this.kag.stat.f.day_epilogue != 0,
        finished: this.kag.stat.f.finished,
        kSuffix,
        sex:
          this.kag.variable.sf.kill != 0
            ? 0
            : this.kag.stat.f.hutanari == 1
            ? 3
            : this.kag.stat.f.seibetu,
      },
      function (html_str) {
        var j_menu = $(html_str)
        layer_menu.append(j_menu)
        const menuImages = layer_menu.find(
          '#menu_items img, #menu_items p, .img_label_story'
        )
        menuImages.hide()
        const canvas = layer_menu.find('.img_bg_base')[0]
        $(canvas).attr({
          width: `${that.kag.config.scWidth}`,
          height: `${that.kag.config.scHeight}`,
        })
        playAPNG(
          that.bg,
          canvas,
          0,
          0,
          that.kag.config.scWidth,
          that.kag.config.scHeight
        )
        playSE('hon_ake.ogg', '3')
        setTimeout(() => {
          menuImages.fadeIn(200)
        }, 300)
        const dc = that.kag.dc
        layer_menu
          .find('#ending_count')
          .text(`${dc.endCount()}/${dc.totalEndings()}`)
        layer_menu
          .find('#character_count')
          .text(`${dc.characterCount()}/${dc.totalCharacters()}`)
        const autoSaveData = that.getAutoSaveData()
        if (autoSaveData) {
          layer_menu.find('#auto_save_date').text(autoSaveData.save_date)
        }
        // オプション表示
        layer_menu.find('.area_option').click(e => {
          // 召喚画面からオプション画面に行く場合は、戻るときにタイマーセットが必要なため変数を設定する
          that.kag.stat.f.resumeToSyoukan = timerId
          // オプションから戻るときは演出を入れたくないので変数を設定する
          that.kag.stat.f.backFromConfig = true
          // 一瞬背景が消えるのを防止するため、無理やり画像を追加する(config.ksで消す)
          TYRANO.kag.layer
            .getLayer('fix')
            .append(
              $('<img>')
                .attr('id', 'bg_tmp')
                .attr('src', './data/image/menu/menu_.png')
                .css('z-index', 100000000)
                .css('position', 'absolute')
            )
          setTimeout(function () {
            that.kag.ftag.startTag('sleepgame', {
              storage: 'config.ks',
              next: false,
            })
            layer_menu.hide()
            e.stopPropagation()
          }, 10)
        })
        // メッセージスキップ（不使用）
        layer_menu.find('.menu_skip').click(function (e) {
          layer_menu.html('')
          layer_menu.hide()
          1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
          that.kag.stat.is_skip = !0
          'none' == that.kag.layer.layer_event.css('display') ||
            that.kag.ftag.nextOrder()
          e.stopPropagation()
        })
        // メッセージウィンドウ非表示（不使用）
        layer_menu.find('.menu_window_close').click(function (e) {
          that.kag.layer.hideMessageLayers()
          layer_menu.hide()
          1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
          e.stopPropagation()
        })
        // メニュー閉じる
        layer_menu.find('.area_close').click(function (e) {
          menuImages.fadeOut(200)
          playAPNG(
            that.bg,
            canvas,
            0,
            0,
            that.kag.config.scWidth,
            that.kag.config.scHeight,
            true,
            () => {
              layer_menu.hide()
              $('.layer_event_guard').hide()
              1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
              e.stopPropagation()
            }
          )
          playSE('hon_tozi.ogg')
          // メニューを閉じたらタイマーをセットする
          const stat = that.kag.stat
          if (
            stat.current_scenario == 'syoukan.ks' ||
            (stat.current_scenario == 'syoukan_k.ks' &&
              stat.f.finished.slice(-1)[0] == 'ルビー') ||
            stat.current_scenario == 'syoukan_Devil.ks'
          ) {
            that.kag.stat.f.timerId = setTimeout(() => {
              if (
                stat.current_scenario == 'syoukan.ks' ||
                (stat.current_scenario == 'syoukan_k.ks' &&
                  stat.f.finished.slice(-1)[0] == 'ルビー') ||
                stat.current_scenario == 'syoukan_Devil.ks'
              ) {
                that.kag.ftag.startTag('jump', { target: '*nemumi' })
              }
            }, stat.f.nemumiInterval)
          }
        })
        // セーブ
        layer_menu.find('.area_save').click(function (e) {
          that.displaySave(null, true)
          e.stopPropagation()
        })
        // ロード
        layer_menu.find('.area_load').click(function (e) {
          that.displayLoad(null, true)
          e.stopPropagation()
        })
        // タイトルに戻る
        layer_menu.find('.area_back_title').click(function () {
          that.kag.backTitle()
        })

        // area mouse over
        bindHover(
          '.area_save',
          '.menu_save',
          `button_save${kSuffix}.png`,
          `save${kSuffix}.png`
        )
        bindHover(
          '.area_load',
          '.menu_load',
          `button_load${kSuffix}.png`,
          `load${kSuffix}.png`
        )
        bindHover(
          '.area_option',
          '.menu_option',
          `button_option${kSuffix}.png`,
          `option${kSuffix}.png`
        )
        bindHover(
          '.area_back_title',
          '.menu_back_title',
          `button_title${kSuffix}.png`,
          `title${kSuffix}.png`
        )
        bindHover('.area_close', '.menu_close', 'modoru.png', 'modoru2.png')
        $.preloadImgCallback(
          j_menu,
          function () {
            layer_menu.stop(!0, !0).fadeIn(0)
            $('.button_menu').hide()
          },
          that
        )
      }
    )
  },
  displaySave: function (cb, force) {
    if (this.kag.stat.f.stopSave) {
      $.alert($.lang('stop_save'))
      return !1
    }
    console.log()
    const layer_menu = this.kag.layer.getMenuLayer()
    // メニューボタンが表示されていない・既にメニューが表示されている場合は開かない（ただし強制表示の場合を除く）
    if (
      ($('.menu_button.event-setting-element:visible,.menu_syoukan:visible')
        .length == 0 ||
        layer_menu.css('display') != 'none') &&
      !force
    )
      return !1
    this.kag.stat.is_skip = !1
    // 召喚画面ではnemumi用のタイマーを切る
    const timerId = this.kag.stat.f.timerId
    if (timerId) {
      clearTimeout(timerId)
      this.kag.stat.f.timerId = null
    }
    this.displaySavePage(cb)
  },
  displaySavePage: function (cb) {
    this.kag.ftag.startTag('guard_click', { stop: 'true' })
    const that = this
    const pageSize = 6
    this.kag.html('save', { novel: $.novel }, function (html_str) {
      const j_save = $(html_str)
      j_save.find('.button_smart').hide()
      if ('pc' != $.userenv()) {
        j_save.find('.button_smart').show()
        j_save.find('.button_arrow_up').click(function () {
          var pos = j_save.find('.area_save_list').scrollTop() - 160
          layer_menu
            .find('.area_save_list')
            .animate({ scrollTop: pos }, { queue: !1 })
        })
        j_save.find('.button_arrow_down').click(function () {
          var pos = j_save.find('.area_save_list').scrollTop() + 160
          j_save
            .find('.area_save_list')
            .animate({ scrollTop: pos }, { queue: !1 })
        })
      }
      const saveListNo = that.kag.variable.sf.saveListNo
      that.displaySaveList(
        'save',
        pageSize,
        saveListNo,
        true,
        j_save.find('.area_save_list'),
        cb
      )
      var layer_menu = that.kag.layer.getMenuLayer()
      that.setMenu(j_save, cb)
    })
  },
  displaySaveList: function (type, pageSize, pageNo, visible, parent, cb) {
    const wholeArray = this.getSaveData().data.map((datum, index) => ({
      ...datum,
      num: index,
    }))
    const pageCount = Math.ceil(wholeArray.length / pageSize)
    const array = wholeArray.slice(
      (pageNo - 1) * pageSize,
      (pageNo - 1) * pageSize + pageSize
    )
    const effectForEmptySlot = type == 'save'
    const onClick =
      type == 'save'
        ? function () {
            const j_slot = $(this)
            const num = j_slot.attr('data-num')
            const saveData = that.getSaveData().data[num]
            if (saveData.save_date) {
              const msg =
                that.kag.variable.sf.kill == 0
                  ? $.lang('overwrite_save')
                  : $.lang('overwrite_save_kill')
              $.confirm(
                msg,
                function () {
                  that.onSave(num, cb, j_slot)
                },
                function () {
                  return !1
                },
                $.lang('yes'),
                $.lang('no')
              )
            } else {
              that.onSave(num, cb, j_slot)
            }
          }
        : function (e) {
            const elem = this
            var num = $(elem).attr('data-num')
            if ('' != array.find(datum => datum.num == num).save_date) {
              const msg =
                that.kag.variable.sf.kill == 0
                  ? $.lang('load_data')
                  : $.lang('load_data_kill')
              $.confirm(
                msg,
                function () {
                  that.snap = null
                  that.loadGame(num)
                  var layer_menu = that.kag.layer.getMenuLayer()
                  layer_menu.hide()
                  layer_menu.empty()
                  1 == that.kag.stat.visible_menu_button &&
                    $('.button_menu').show()
                },
                function () {
                  return !1
                },
                $.lang('yes'),
                $.lang('no')
              )
            }
          }
    const that = this
    const newest = this.kag.variable.sf.currentSaveNo
    this.kag.html(
      'saveList',
      { array_save: array, novel: $.novel, page: pageNo, type, newest },
      function (html_str) {
        const saveList = $(html_str).css('display', visible ? 'grid' : 'none')
        saveList.find('.save_display_area').each(function () {
          const saveElement = $(this).click(onClick)
          const applyEffect =
            saveElement.find('img').length > 0 || effectForEmptySlot
          applyEffect &&
            saveElement
              .mouseover(function () {
                $(this)
                  .find('.save_list_item_scale_container')
                  .css('transform', 'scale(0.98)')
                  .find('.img_hover')
                  .css('visibility', 'visible')
                if (
                  $(this).find('.save_list_item_text').text() ==
                  $.lang('not_saved')
                )
                  $(this)
                    .find('.save_list_item_border_container')
                    .css(
                      'background-image',
                      'url(./data/image/menu/save_hover2.png)'
                    )
                    .find('.save_list_item_text')
                    .css('color', '#cb6db0')
              })
              .mouseout(function () {
                $(this)
                  .find('.save_list_item_scale_container')
                  .css('transform', '')
                  .find('.img_hover')
                  .css('visibility', 'hidden')
                if (
                  $(this).find('.save_list_item_text').text() ==
                  $.lang('not_saved')
                )
                  $(this)
                    .find('.save_list_item_border_container')
                    .css('background-image', '')
                    .find('.save_list_item_text')
                    .css('color', '')
              })
        })
        const prevButton = saveList.find('.prev_page')
        prevButton.click(function () {
          playSE('hon_ake.ogg', '3')
          that.displaySaveList(
            type,
            pageSize,
            pageNo === 1 ? pageCount : pageNo - 1,
            false,
            parent
          )
          // 先頭ページから前に戻ったときに最終ページに移動する
          that.switchSaveList(pageNo === 1 ? pageCount : pageNo - 1)
        })
        const nextButton = saveList.find('.next_page')
        nextButton.click(function () {
          playSE('hon_ake.ogg', '3')
          that.displaySaveList(
            type,
            pageSize,
            pageNo === pageCount ? 1 : pageNo + 1,
            false,
            parent
          )
          // 最終ページから前に戻ったときに先頭ページに移動する
          that.switchSaveList(pageNo === pageCount ? 1 : pageNo + 1)
        })
        saveList.find('.page_no').text(pageNo)
        parent.append(saveList)
      }
    )
  },
  switchSaveList(page) {
    const that = this
    this.kag.ftag.startTag('guard_click', { stop: 'true' })
    $('.save_list')
      .filter(function () {
        return $(this).attr('id') !== `save_list_${page}`
      })
      .fadeOut({
        duration: 300,
        queue: false,
      })
    $(`#save_list_${page}`).fadeIn({
      duration: 300,
      queue: false,
      start: function () {
        $(this).css('display', 'grid')
      },
      complete: function () {
        that.kag.ftag.startTag('free_guard_click', { stop: 'true' })
      },
    })
    this.kag.variable.sf.saveListNo = page
    this.kag.saveSystemVariable()
  },
  onSave(num, cb, j_slot) {
    this.kag.variable.sf.currentSaveNo = num
    this.kag.saveSystemVariable()
    const that = this
    this.kag.ftag.startTag('guard_click', { stop: 'true' })
    this.snap = null
    playSE('save.ogg')
    this.doSave(num, function (save_data) {
      if ('' != save_data.img_data)
        if (j_slot.find('.save_list_item_thumb').find('img').get(0))
          j_slot
            .find('.save_list_item_thumb')
            .find('img')
            .not('.img_hover')
            .attr('src', save_data.img_data)
        else {
          j_slot.find('.save_list_item_thumb').css('background-image', '')
          j_slot
            .find('.save_list_item_thumb')
            .append($('<img>').attr('src', save_data.img_data))
            .append(
              $('<img>')
                .attr('src', 'data/image/menu/save_hover.png')
                .addClass('img_hover')
            )
        }
      if ('' != save_data.phase_file) {
        j_slot.find('.phase_meter').remove()
        save_data.phase_meter.forEach(() => {
          j_slot
            .find('.phase')
            .append('<img class="phase_meter" src="data/image/ui/save.png">')
        })

        j_slot.find('.phase_base').remove()
        j_slot
          .find('.phase')
          .append(`<img class="phase_base" src="${save_data.phase_file}">`)
      }
      j_slot.find('.save_list_item_date').html(save_data.save_date)
      j_slot.find('.save_list_item_text').remove()
      if (save_data.subtitle != '') {
        const itemArea = j_slot.find('.save_list_item_area')
        const subtitle = itemArea.find('.save_list_item_subtitle')
        const subtitles = Object.keys($.lang('subtitle')).join(' ')
        console.log(save_data)
        subtitle
          .removeClass(subtitles)
          .addClass(save_data.subtitle)
          .text(save_data.subtitleText)
      }
      $('.img_new').remove()
      j_slot
        .find('.save_list_item_thumb')
        .append(
          $('<img>').addClass('img_new').attr('src', 'data/image/menu/NEW.png')
        )
      'function' == typeof cb && cb()
      that.kag.ftag.startTag('free_guard_click', { stop: 'true' })
    })
  },
  doSave: function (num, cb) {
    var array_save = this.getSaveData(),
      data = {},
      that = this
    if (null == this.snap)
      this.snapSave(this.kag.stat.current_save_str, function () {
        ;(data = that.snap).save_date = $.getNowDate() + ' ' + $.getNowTime()
        array_save.data[num] = data
        if (
          array_save.data.length < that.maxSaveCount &&
          !array_save.data.find(s => s.title == $.lang('not_saved'))
        ) {
          const pageSize = 6
          const newSave = {
            title: $.lang('not_saved'),
            current_order_index: 0,
            save_date: '',
            img_data: '',
            phase_file: '',
            stat: {},
          }
          array_save.data = array_save.data.concat(
            new Array(pageSize).fill(newSave)
          )
        }
        $.setStorage(
          that.kag.config.projectID + '_tyrano_data',
          array_save,
          that.kag.config.configSave
        )
        'function' == typeof cb && cb(data)
      })
    else {
      ;(data = that.snap).save_date = $.getNowDate() + ' ' + $.getNowTime()
      array_save.data[num] = data
      if (!array_save.data.find(s => s.title == $.lang('not_saved'))) {
        const pageSize = 6
        const newSave = {
          title: $.lang('not_saved'),
          current_order_index: 0,
          save_date: '',
          img_data: '',
          phase_file: '',
          stat: {},
        }
        array_save.data = array_save.data.concat(
          new Array(pageSize).fill(newSave)
        )
      }
      $.setStorage(
        that.kag.config.projectID + '_tyrano_data',
        array_save,
        that.kag.config.configSave
      )
      'function' == typeof cb && cb(data)
    }
  },
  setQuickSave: function () {
    var that = this,
      saveTitle = that.kag.stat.current_save_str
    that.kag.menu.snapSave(saveTitle, function () {
      var data = that.snap
      data.save_date = $.getNowDate() + ' ' + $.getNowTime()
      $.setStorage(
        that.kag.config.projectID + '_tyrano_quick_save',
        data,
        that.kag.config.configSave
      )
      that.kag.layer.getMenuLayer().hide()
    })
  },
  loadQuickSave: function () {
    var data = $.getStorage(
      this.kag.config.projectID + '_tyrano_quick_save',
      this.kag.config.configSave
    )
    if (!data) return !1
    data = JSON.parse(data)
    this.loadGameData($.extend(!0, {}, data))
  },
  doSetAutoSave: function (title) {
    var data = this.snap
    const suffix = title ? '_' + title : ''
    data.save_date = $.getNowDate() + ' ' + $.getNowTime()
    $.setStorage(
      this.kag.config.projectID + '_tyrano_auto_save' + suffix,
      data,
      this.kag.config.configSave
    )
    this.kag.layer.getMenuLayer().hide()
  },
  loadAutoSave: function (title) {
    const data = this.getAutoSaveData(title)
    this.loadGameData($.extend(!0, {}, data), { auto_next: 'yes' })
  },
  getAutoSaveData: function (title) {
    const suffix = title ? '_' + title : ''
    var data = $.getStorage(
      this.kag.config.projectID + '_tyrano_auto_save' + suffix,
      this.kag.config.configSave
    )
    if (!data) return undefined
    return JSON.parse(data)
  },
  snapSave: function (title, call_back, flag_thumb) {
    var that = this,
      _current_order_index = that.kag.ftag.current_order_index - 1,
      _stat = $.extend(!0, {}, $.cloneObject(that.kag.stat)),
      models = (three = this.kag.tmp.three).models,
      three_save = {}
    three_save.stat = three.stat
    three_save.evt = three.evt
    var three = this.kag.tmp.three,
      save_models = {}
    for (var key in models) {
      var model = models[key]
      save_models[key] = model.toSaveObj()
    }
    three_save.models = save_models
    void 0 === flag_thumb && (flag_thumb = this.kag.config.configThumbnail)
    const removeBgLoop = (layer_obj, data) => {
      // bg_loopで表示している背景ムービーを名前だけ取得して削除
      const baseLayer = $(layer_obj.map_layer_fore['base'])
      const bgLoop = baseLayer.find('.bg_loop')
      if (bgLoop.length > 0) {
        const bgLoopName = [...bgLoop[0].classList].filter(
          c => c != 'bg_loop'
        )[0]
        data.bgLoopName = bgLoopName
        bgLoop.remove()
        layer_obj.map_layer_fore['base'] = baseLayer.outerHTML()
      }
    }
    if ('false' == flag_thumb) {
      var data = {}
      data.title = title
      data.stat = _stat
      data.phase_file = `data/image/ui/save${_stat.f.day}.png`
      data.three = three_save
      data.current_order_index = _current_order_index
      data.save_date = $.getNowDate() + ' ' + $.getNowTime()
      data.subtitle = _stat.f.subtitle
      data.subtitleText = $.lang('subtitle')[_stat.f.subtitle]
      data.img_data = ''
      var layer_obj = that.kag.layer.getLayeyHtml()
      removeBgLoop(layer_obj, data)
      data.layer = layer_obj
      that.snap = $.extend(!0, {}, $.cloneObject(data))
      call_back && call_back()
    } else {
      setTimeout(function () {
        var completeImage = function (img_code) {
          var data = {}
          data.title = title
          data.stat = _stat
          const epilogueSuffix = _stat.f.day_epilogue > 0 ? '_epilogue' : ''
          const day =
            _stat.f.day_epilogue > 0 ? _stat.f.day_epilogue : _stat.f.day
          data.phase_file = `data/image/ui/save${day}${epilogueSuffix}.png`
          data.phase_meter =
            _stat.f.day_epilogue > 0
              ? []
              : _stat.f.finished.slice(_stat.f.day * 3)
          data.three = three_save
          data.current_order_index = _current_order_index
          data.save_date = $.getNowDate() + ' ' + $.getNowTime()
          data.subtitle = _stat.f.subtitle
          data.subtitleText = $.lang('subtitle')[_stat.f.subtitle]
          data.img_data =
            that.kag.variable.sf.kill == 0
              ? img_code
              : './data/image/ui/thumb_kill.png'
          var layer_obj = that.kag.layer.getLayeyHtml()
          removeBgLoop(layer_obj, data)
          data.layer = layer_obj
          that.snap = $.extend(!0, {}, $.cloneObject(data))
          call_back && call_back()
        }
        if ('' != that.kag.stat.save_img) {
          var img = new Image()
          img.src = _stat.save_img
          img.onload = function () {
            var canvas = document.createElement('canvas')
            canvas.width = parseInt(
              $('#tyrano_base').css('width').replace('px', '')
            )
            canvas.height = parseInt(
              $('#tyrano_base').css('height').replace('px', '')
            )
            canvas.getContext('2d').drawImage(img, 0, 0)
            var img_code = that.createImgCode(canvas)
            completeImage(img_code)
          }
        } else {
          let w,
            h,
            canvas = document.createElement('canvas'),
            ctx = canvas.getContext('2d'),
            videos = document.querySelectorAll('video')
          for (let i = 0, len = videos.length; i < len; i++) {
            const v = videos[i]
            try {
              w = v.videoWidth
              h = v.videoHeight
              const { left, top, width, height, zIndex, mixBlendMode } = v.style
              canvas.style.left = left
              canvas.style.top = top
              canvas.style.width = width
              canvas.style.height = height
              canvas.width = w
              canvas.height = h
              ctx.fillRect(0, 0, w, h)
              ctx.drawImage(v, 0, 0, w, h)
              $('<img>')
                .addClass('tmp_video_canvas')
                .css({
                  position: 'absolute',
                  left,
                  top,
                  width,
                  height,
                  zIndex,
                  mixBlendMode,
                })
                .attr('src', canvas.toDataURL())
                .appendTo(that.kag.layer.getLayer('fix'))
              // v.style.backgroundImage = `url(${canvas.toDataURL()})`
              // v.style.backgroundSize = 'cover'
              // v.classList.add('tmp_video_canvas')
              ctx.clearRect(0, 0, w, h)
            } catch (e) {
              continue
            }
          }
          var tmp_base,
            flag_canvas = !1,
            array_canvas = []
          $('#tyrano_base')
            .find('canvas')
            .each(function (index, element) {
              array_canvas.push(element)
            })
          array_canvas.length > 0 && (flag_canvas = !0)
          if (flag_canvas) tmp_base = $('#tyrano_base')
          else {
            ;(tmp_base = $('#tyrano_base').clone()).addClass('snap_tmp_base')
            $('body').append(tmp_base)
          }
          var tmp_left = tmp_base.css('left'),
            tmp_top = tmp_base.css('top')
          tmp_base.css('left', 0)
          tmp_base.css('top', 0)
          tmp_base.find('.layer_menu').hide()
          const mpGauge = tmp_base.find('.mp_gauge')
          const mpHeight = mpGauge.css('max-height')
          const mpWrapper = $('<div>').css({
            position: 'absolute',
            left: '1210px',
            bottom: '331px',
            width: '26px',
            height: mpHeight,
            overflow: 'hidden',
            display: 'flex',
            'flex-direction': 'column',
            'justify-content': 'flex-end',
          })
          mpGauge.css('max-height', '').removeClass('mp_gauge').wrap(mpWrapper)
          $('.suisyou').hide()
          var opt = {
            scale: 1,
            height: parseInt($('#tyrano_base').css('height').replace('px', '')),
            width: parseInt($('#tyrano_base').css('width').replace('px', '')),
            onclone: function (clonedDoc, clonedElement) {
              var textInputs = clonedElement.querySelectorAll(
                'input:not([type]),input[type="text"],input[type="search"],input[type="url"],input[type="tel"],input[type="email"],input[type="password"],textarea'
              )
              for (var i = 0; i < textInputs.length; i++) textInputs[i].value = ''
            },
          }
          html2canvas(tmp_base.get(0), opt).then(function (canvas) {
            $('#tyrano_base').find('.tmp_video_canvas').remove()
            var img_code = that.createImgCode(canvas)
            completeImage(img_code)
          })
          $('.suisyou').show()
          mpGauge.unwrap().addClass('mp_gauge').css('max-height', mpHeight)
          tmp_base.hide()
          tmp_base.css('left', tmp_left)
          tmp_base.css('top', tmp_top)
          tmp_base.find('.layer_menu').show()
          $('body').find('.snap_tmp_base').remove()
          tmp_base.show()
        }
      }, 20)
    }
  },
  createImgCode: function (canvas) {
    var q = this.kag.config.configThumbnailQuality
    return 'low' == q
      ? canvas.toDataURL('image/jpeg', 0.3)
      : 'middle' == q
      ? canvas.toDataURL('image/jpeg', 0.7)
      : canvas.toDataURL()
  },
  setGameSleep: function (next_flag) {
    this.kag.tmp.sleep_game_next = !!next_flag
    this.kag.tmp.sleep_game = this.snap
  },
  displayLoad: function (cb, force) {
    const layer_menu = this.kag.layer.getMenuLayer()
    // メニューボタンが表示されていない・既にメニューが表示されている場合は開かない（ただし強制表示の場合を除く）
    if (
      ($('.menu_button.event-setting-element:visible,.menu_syoukan:visible')
        .length == 0 ||
        layer_menu.css('display') != 'none') &&
      !force
    )
      return !1
    this.kag.stat.is_skip = !1
    // 召喚画面ではnemumi用のタイマーを切る
    const timerId = this.kag.stat.f.timerId
    if (timerId) {
      clearTimeout(timerId)
      this.kag.stat.f.timerId = null
    }
    this.displayLoadPage(cb)
    if (this.kag.variable.sf.showAutoSaveTutorial) {
      this.kag.variable.sf.showAutoSaveTutorial = 0
      const overlay = $('<img>')
        .addClass('bg_auto_load')
        .hide()
        .css({
          position: 'absolute',
          top: 0,
          left: 0,
          zIndex: 1000000001,
        })
        .attr('src', './tyrano/images/system/bg_auto_load.png')
      this.kag.layer.getLayer('fix').append(overlay)
      $('.remodal-overlay').css('background-color', 'unset')
      overlay.fadeIn(300)
      $.alert(
        $.lang('load_auto_save_tutorial'),
        function () {
          overlay.fadeOut(300)
          $('.remodal-overlay').css('background-color', '')
        },
        $.lang('ok')
      )
    }
  },
  displayLoadPage: function (cb) {
    this.kag.ftag.startTag('guard_click', { stop: 'true' })
    const that = this
    this.kag.html(
      'load',
      {
        novel: $.novel,
        autoLoad: Boolean(this.getAutoSaveData()),
      },
      function (html_str) {
        const j_save = $(html_str)
        j_save.find('.button_smart').hide()
        if ('pc' != $.userenv()) {
          j_save.find('.button_smart').show()
          j_save.find('.button_arrow_up').click(function () {
            var pos = j_save.find('.area_save_list').scrollTop() - 160
            layer_menu
              .find('.area_save_list')
              .animate({ scrollTop: pos }, { queue: !1 })
          })
          j_save.find('.button_arrow_down').click(function () {
            var pos = j_save.find('.area_save_list').scrollTop() + 160
            j_save
              .find('.area_save_list')
              .animate({ scrollTop: pos }, { queue: !1 })
          })
        }
        j_save.find('.button_auto_load').click(function () {
          const data = that.getAutoSaveData()
          if (!data) {
            return !1
          }
          $.confirm(
            $.lang('load_auto_save').replace('$time', data.save_date),
            function () {
              that.snap = null
              that.loadAutoSave()
              var layer_menu = that.kag.layer.getMenuLayer()
              layer_menu.hide()
              layer_menu.empty()
              1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
            },
            function () {
              return !1
            },
            $.lang('yes'),
            $.lang('no')
          )
        })
        const saveListNo = TYRANO.kag.variable.sf.saveListNo
        const pageSize = 6
        that.displaySaveList(
          'load',
          pageSize,
          saveListNo,
          true,
          j_save.find('.area_save_list')
        )
        var layer_menu = that.kag.layer.getMenuLayer()
        that.setMenu(j_save, cb)
        bindHover(
          '.button_auto_load',
          '.button_auto_load',
          'auto.png',
          'auto2.png'
        )
      }
    )
  },
  loadGame: function (num) {
    var array = this.getSaveData().data
    if ('' != array[num].save_date) {
      var auto_next = 'no'
      if (1 == array[num].stat.load_auto_next) {
        array[num].stat.load_auto_next = !1
        auto_next = 'yes'
      }
      this.loadGameData($.extend(!0, {}, array[num]), { auto_next: auto_next })
    }
  },
  loadGameData: function (data, options) {
    // タイトル画面を通過していない場合はbootload済みとすること（プレビュー時）
    this.kag.tmp.titlePassed || (this.kag.tmp.bootload = true)
    // マクロ定義を最新化する
    const mapMacro = this.kag.stat.map_macro
    data.stat.map_macro = mapMacro
    // （セーブデータのキャラ定義を残したうえで）初期のキャラ定義を反映する
    data.stat.charas = {
      ...this.kag.stat.charas,
      ...data.stat.charas,
    }
    // （セーブデータの変数を残したうえで）初期変数を反映する
    data.stat.f = { ...this.kag.variable.sf.initialVars, ...data.stat.f }
    const currentScenario = data.stat.current_scenario
    var auto_next = 'no'
    void 0 === options
      ? (options = { bgm_over: 'false' })
      : void 0 === options.bgm_over && (options.bgm_over = 'false')
    options.auto_next && (auto_next = options.auto_next)
    if ('undefined' != typeof Live2Dcanvas)
      for (model_id in Live2Dcanvas)
        if (Live2Dcanvas[model_id]) {
          Live2Dcanvas[model_id].check_delete = 2
          Live2D.deleteBuffer(Live2Dcanvas[model_id].modelno)
          delete Live2Dcanvas[model_id]
        }
    data.stat.mindVoices = []
    this.kag.stat = data.stat
    let strongStop = this.kag.stat.is_strong_stop
    1 == strongStop ? (auto_next = 'stop') : (this.kag.stat.is_strong_stop = !1)
    this.kag.setTitle(this.kag.stat.title)
    // 起動時オートロードしてないorコンフィグから戻ってきた => 演出無しでロード
    const immediateLoad =
      !this.kag.tmp.bootload || this.kag.stat.f.backFromConfig
    if (!this.kag.tmp.bootload) {
      const flash = $(`<div class="flash">`)
      flash.css({
        position: 'absolute',
        top: 0,
        left: 0,
        width: this.kag.config.scWidth + 'px',
        height: this.kag.config.scHeight + 'px',
        'z-index': 111111111,
        backgroundColor: 'black',
      })
      this.kag.layer.getLayer('fix').append(flash)
    }
    if (!immediateLoad) {
      if ('false' == options.bgm_over) {
        var map_se = this.kag.tmp.map_se
        for (var key in map_se)
          map_se[key] &&
            this.kag.ftag.startTag('stopse', { stop: 'true', buf: key })
        var map_bgm = this.kag.tmp.map_bgm
        for (var key in map_bgm)
          this.kag.ftag.startTag('stopbgm', { stop: 'true', buf: key })
      }
      $('video').each(function (_, e) {
        e.volume = 0
      })
      this.kag.ftag.startTag('clear_autosave', { title: 'b', stop: 'true' })
      playSE('load.ogg', 2)
      this.kag.ftag.startTag('guard_click', { stop: 'true' })
      const kill = this.kag.variable.sf.kill
      this.kag.ftag.startTag('flash', {
        time: '300',
        stop: 'true',
        color: kill == 0 ? '0x41c3cb' : 'red',
      })
      this.kag.variable.tf.system.backlog = []
    }
    const that = this
    const waitTime = immediateLoad ? 0 : 1000
    setTimeout(() => {
      this.kag.layer.setLayerHtml(data.layer)
      setTimeout(() => {
        data.bgLoopName &&
          this.kag.ftag.startTag('bg_loop', {
            name: data.bgLoopName,
            stop: 'true',
          })
      }, 10)
      // コンフィグから戻ってきたとき以外はBGMを再生
      if (!this.kag.stat.f.backFromConfig) {
        if ('false' == options.bgm_over) {
          if ('' != that.kag.stat.current_bgm) {
            var pm = {
              loop: that.kag.stat.current_bgm_loop,
              storage: that.kag.stat.current_bgm,
              html5: that.kag.stat.current_bgm_html5,
              stop: 'true',
            }
            '' != that.kag.stat.current_bgm_vol &&
              (pm.volume = that.kag.stat.current_bgm_vol)
            that.kag.ftag.startTag('playbgm', pm)
          }
          for (key in that.kag.stat.current_se) {
            var pm_obj = that.kag.stat.current_se[key]
            pm_obj.stop = 'true'
            that.kag.ftag.startTag('playse', pm_obj)
          }
        }
      }
      $('head').find('._tyrano_cssload_tag').remove()
      if (that.kag.stat.cssload)
        for (file in that.kag.stat.cssload) {
          var style =
            '<link class="_tyrano_cssload_tag" rel="stylesheet" href="' +
            $.escapeHTML(file) +
            '?' +
            Math.floor(1e7 * Math.random()) +
            '">'
          $('head link:last').after(style)
        }
      else that.kag.stat.cssload = {}
      that.kag.layer.getLayer('base').removeClass('animated')
      that.kag.stat.current_bgmovie ||
        (that.kag.stat.current_bgmovie = { storage: '', volume: '' })

      // See: plugin/swing/main.js
      that.kag.stat.swing &&
        Object.entries(that.kag.stat.swing).forEach(([name, a3dDefine]) => {
          const swinged = $(`.${name}`)
          swinged.a3d(a3dDefine)
        })
      if ('true' == that.kag.config.useCamera) {
        $('.layer_camera').css({
          '-animation-name': '',
          '-animation-duration': '',
          '-animation-play-state': '',
          '-animation-delay': '',
          '-animation-iteration-count': '',
          '-animation-direction': '',
          '-animation-fill-mode': '',
          '-animation-timing-function': '',
        })
        for (const key in that.kag.stat.current_camera) {
          const a3d_define = {
            frames: {
              '0%': { trans: that.kag.stat.current_camera[key] },
              '100%': { trans: that.kag.stat.current_camera[key] },
            },
            config: { duration: '5ms', state: 'running', easing: 'ease' },
            complete: function () {},
          }
          if ('layer_camera' == key) {
            $('.layer_camera').css('-webkit-transform-origin', 'center center')
            setTimeout(function () {
              $('.layer_camera').a3d(a3d_define)
            }, 1)
          } else {
            $('.' + key + '_fore').css(
              '-webkit-transform-origin',
              'center center'
            )
            setTimeout(function () {
              $('.' + key + '_fore').a3d(a3d_define)
            }, 1)
          }
        }
      }
      $('.tyrano_base').find('video').remove()
      that.kag.tmp.video_playing = !1
      if (
        '' != that.kag.stat.current_bgmovie.storage &&
        that.kag.stat.current_bgmovie.loop == 'true'
      ) {
        pm = {
          storage: that.kag.stat.current_bgmovie.storage,
          volume: that.kag.stat.current_bgmovie.volume,
          stop: 'true',
        }
        that.kag.tmp.video_playing = !1
        that.kag.ftag.startTag('bgmovie', pm)
      }
      if ('' != that.kag.stat.current_bgcamera) {
        that.kag.stat.current_bgcamera.stop = 'true'
        that.kag.ftag.startTag('bgcamera', that.kag.stat.current_bgcamera)
      }
      // kanim 復活
      that.kag.stat.playingKeyFrameName &&
        Object.entries(that.kag.stat.playingKeyFrameName).forEach(
          ([name, animName]) => {
            that.resumeAnimation(name, animName)
          }
        )
      var three = data.three
      if (1 == three.stat.is_load) {
        that.kag.stat.is_strong_stop = !0
        var init_pm = three.stat.init_pm
        that.kag.ftag.startTag('3d_close', {})
        init_pm.next = 'false'
        that.kag.ftag.startTag('3d_init', init_pm)
        var models = three.models,
          scene_pm = three.stat.scene_pm
        scene_pm.next = 'false'
        that.kag.ftag.startTag('3d_scene', scene_pm)
        for (var key in models) {
          var model = models[key]
          ;(pm = model.pm).pos = model.pos
          pm.rot = model.rot
          pm.scale = model.scale
          pm._load = 'true'
          var tag = pm._tag
          'camera' == key && (tag = '3d_camera')
          pm.next = 'false'
          that.kag.ftag.startTag(tag, pm)
        }
        var gyro = three.stat.gyro
        if (1 == gyro.enable) {
          var gyro_pm = gyro.pm
          gyro_pm.next = 'false'
          that.kag.ftag.startTag('3d_gyro', gyro_pm)
        }
        three.stat.canvas_show
          ? that.kag.tmp.three.j_canvas.show()
          : that.kag.tmp.three.j_canvas.hide()
        that.kag.tmp.three.stat = three.stat
        that.kag.tmp.three.evt = three.evt
        that.kag.stat.is_strong_stop = !1
      }
      that.kag.setCursor(that.kag.stat.current_cursor)
      1 == that.kag.stat.visible_menu_button
        ? $('.button_menu').show()
        : $('.button_menu').hide()
      $('.event-setting-element').each(function () {
        var j_elm = $(this),
          kind = j_elm.attr('data-event-tag'),
          pm = JSON.parse(j_elm.attr('data-event-pm'))
        object(tyrano.plugin.kag.tag[kind]).setEvent(j_elm, pm)
        j_elm.trigger('mouseout')
      })
      var insert = {
        name: 'call',
        pm: { storage: 'make.ks', auto_next: auto_next },
        val: '',
      }
      that.kag.clearTmpVariable()
      if (
        currentScenario == 'syoukan.ks' ||
        currentScenario == 'syoukan_k.ks' ||
        currentScenario == 'syoukan_Devil.ks'
      ) {
        data.stat.f.resumeToSyoukan = true
      }
      that.kag.ftag.nextOrderWithIndex(
        data.current_order_index,
        data.stat.current_scenario,
        !0,
        insert,
        'yes'
      )
      that.kag.ftag.startTag('free_apng', { name: 'makuake_end', stop: true })
      !immediateLoad &&
        this.kag.ftag.startTag('flash_off', {
          time: '1000',
          stop: 'true',
          wait: 'false',
        })
      !this.kag.tmp.bootload &&
        setTimeout(
          () =>
            this.kag.ftag.startTag('flash_off', {
              time: '100',
              stop: 'true',
              wait: 'false',
            }),
          100
        )
      this.kag.tmp.bootload = true
      setTimeout(() => {
        that.kag.ftag.startTag('free_guard_click', { stop: 'true' })
        $('.layer_event_guard').hide()
      }, waitTime)
    }, waitTime)
    this.kag.stat.f.backFromConfig = false
  },
  resumeAnimation: function (charaName, animName) {
    const that = this
    const chara = this.kag.stat.charas[charaName]
    if (chara && chara.is_show == 'true') {
      // ex: [kanim name="でびるん" keyframe="fuwa" count="infinite" time="???" direction="alternate" easing="linear"]
      const anim = this.kag.stat.map_keyframe[animName]
      console.log(anim)
      $(`.${charaName}`).each(function () {
        that.kag.pushAnimStack()
        $(this).a3d(anim)
      })
    }
  },
  setMenu: function (j_obj, cb) {
    var that = this,
      layer_menu = this.kag.layer.getMenuLayer()
    const menuClose = j_obj.find('.menu_close')
    menuClose
      .click(function (e) {
        that.kag.ftag.startTag('guard_click', { stop: 'true' })
        layer_menu.fadeOut(300, function () {
          layer_menu.empty()
          that.kag.ftag.startTag('free_guard_click', { stop: 'true' })
          'function' == typeof cb && cb()
        })
        1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
        // 召喚画面からのメニュー表示の場合、メニューを閉じたらタイマーをセットする
        const stat = that.kag.stat
        if (
          stat.current_scenario == 'syoukan.ks' ||
          (stat.current_scenario == 'syoukan_k.ks' &&
            stat.f.finished.slice(-1)[0] == 'ルビー') ||
          stat.current_scenario == 'syoukan_Devil.ks'
        ) {
          that.kag.stat.f.timerId = setTimeout(() => {
            if (
              stat.current_scenario == 'syoukan.ks' ||
              (stat.current_scenario == 'syoukan_k.ks' &&
                stat.f.finished.slice(-1)[0] == 'ルビー') ||
              stat.current_scenario == 'syoukan_Devil.ks'
            ) {
              that.kag.ftag.startTag('jump', { target: '*nemumi' })
            }
          }, stat.f.nemumiInterval)
        }
      })
      .hover(
        () => menuClose.attr('src', 'data/image/menu/modoru2.png'),
        () => menuClose.attr('src', 'data/image/menu/modoru.png')
      )
    j_obj.hide()
    layer_menu.append(j_obj)
    layer_menu.show()
    $.preloadImgCallback(
      layer_menu,
      function () {
        j_obj.stop(!0, !0).fadeIn(300, function () {
          that.kag.ftag.startTag('free_guard_click', { stop: 'true' })
        })
        layer_menu.find('.block_menu').fadeOut(300)
      },
      that
    )
  },
  hideMenu: function () {},
  getSaveData: function () {
    var tmp_array = $.getStorage(
      this.kag.config.projectID + '_tyrano_data',
      this.kag.config.configSave
    )
    if (tmp_array) return JSON.parse(tmp_array)
    tmp_array = new Array()
    for (
      var root = { kind: 'save', hash: this.kag.save_key_val },
        save_slot_num = this.kag.config.configSaveSlotNum || 5,
        i = 0;
      i < save_slot_num;
      i++
    ) {
      var json = {}
      json.title = $.lang('not_saved')
      json.current_order_index = 0
      json.save_date = ''
      json.img_data = ''
      json.phase_file = ''
      json.stat = {}
      tmp_array.push(json)
    }
    root.data = tmp_array
    return root
  },
  displayLog: function () {
    var that = this
    this.kag.stat.is_skip = !1
    $('<div></div>')
    this.kag.html('backlog', { novel: $.novel }, function (html_str) {
      var j_menu = $(html_str),
        layer_menu = that.kag.layer.getMenuLayer()
      layer_menu.empty()
      layer_menu.append(j_menu)
      layer_menu.find('.menu_close').click(function () {
        layer_menu.fadeOut(300, function () {
          layer_menu.empty()
        })
        1 == that.kag.stat.visible_menu_button && $('.button_menu').show()
      })
      layer_menu.find('.button_smart').hide()
      if ('pc' != $.userenv()) {
        layer_menu.find('.button_smart').show()
        layer_menu.find('.button_arrow_up').click(function () {
          var pos = layer_menu.find('.log_body').scrollTop() - 60
          layer_menu
            .find('.log_body')
            .animate({ scrollTop: pos }, { queue: !1 })
        })
        layer_menu.find('.button_arrow_down').click(function () {
          var pos = layer_menu.find('.log_body').scrollTop() + 60
          layer_menu
            .find('.log_body')
            .animate({ scrollTop: pos }, { queue: !1 })
        })
      }
      for (
        var log_str = '',
          array_log = that.kag.variable.tf.system.backlog,
          i = 0;
        i < array_log.length;
        i++
      )
        log_str += array_log[i] + '<br />'
      layer_menu.find('.log_body').html(log_str)
      layer_menu.find('.log_body').css('font-family', that.kag.config.userFace)
      $.preloadImgCallback(
        layer_menu,
        function () {
          layer_menu.stop(!0, !0).fadeIn(300)
          layer_menu.find('.log_body').scrollTop(9999999999)
        },
        that
      )
      $('.button_menu').hide()
    })
  },
  screenFull: function () {
    var isFullScreen =
        document.webkitFullscreenElement ||
        document.mozFullScreenElement ||
        document.msFullscreenElement ||
        document.fullScreenElement ||
        !1,
      isEnableFullScreen =
        document.fullscreenEnabled ||
        document.webkitFullscreenEnabled ||
        document.mozFullScreenEnabled ||
        document.msFullscreenEnabled ||
        !1,
      elem = document.body
    isEnableFullScreen &&
      (elem.requestFullscreen
        ? isFullScreen
          ? document.exitFullscreen()
          : elem.requestFullscreen()
        : elem.webkitRequestFullscreen
        ? isFullScreen
          ? document.webkitExitFullscreen()
          : elem.webkitRequestFullscreen()
        : elem.mozRequestFullScreen
        ? isFullScreen
          ? document.mozCancelFullScreen()
          : elem.mozRequestFullScreen()
        : elem.msRequestFullscreen &&
          (isFullScreen
            ? document.msExitFullscreen()
            : elem.msRequestFullscreen()))
  },
  test: function () {},
}
