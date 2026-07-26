; ティラノスクリプト標準テーマプラグイン
[clearfix]
[nolog]
[popopo type=file storage="po_ka.ogg" mode="interval" buf="2" noplaychars=""]
[free_quake_text]
[deffont face="Yawamin" edge="none" size=30]

;=========================================
; コンフィグ モード　画面作成
;=========================================

;	メッセージレイヤ０を不可視に
	[layopt layer=message0 visible=false]
	[layopt layer=message2 visible=false]
;	fixボタン消し
	[layopt layer=fixlayer visible=false]
	
;ゲーム中に効果が設定されている場合は無効
	
;　イメージ消去

[iscript]
$(".layer_camera").not('.base_fore').children().not('.shiro,.kuro').empty();
	
[endscript]

;	メニューボタン非表示
	[hidemenubutton]

;	レイヤ1を可視に
	[layopt layer=1 visible=true]

[cm]

;	コンフィグ用の背景を読み込んでトランジション
	[image name="bg" layer=fix storage="../image/menu/op.png" time=100 zindex=100]

;	画面右上の「Back」ボタン
	[glink graphic="menu/modoru.png" enterimg="menu/modoru2.png" enterse="tap.ogg" target="*backtitle" x=1196 y=874 width=84 height=86 size=0]

[iscript]

	tf.current_bgm_vol=parseInt(TG.config.defaultBgmVolume);
	tf.current_se_vol=parseInt(TG.config.defaultSeVolume);
	tf.current_mov_vol=parseInt(sf._system_config_movie_volume || TG.config.defaultMovieVolume);
	
	tf.current_ch_speed=parseInt(TG.config.chSpeed);
	tf.current_auto_speed=parseInt(TG.config.autoSpeed);
	
	tf.text_skip ="ON";
	
	if(TG.config.unReadTextSkip != "true"){
		tf.text_skip ="OFF";
	} 

  // 一瞬背景が消えるのを防止するために無理やり追加した画像を消す
	$('#bg_tmp').remove()

[endscript]

[jump target="*config_page"]

*config_page

;かなり横長なスクリプトになってしまったのでマクロにしたほうがスッキリします
;c_btn.png は 4×4px の完全透明な画像です。width.heightを使って拡大しています
;一部のスマホブラウザでは音量変更に対応していないのでご留意ください

;------------------------------------------------------------------------------------------------------
;▼BGM音量
;------------------------------------------------------------------------------------------------------
;BGM音量-1０
[glink cm="false" size="0" name="bgmvol,bgmvol_10"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=491 y=205 exp="tf.current_bgm_vol=10"]
;BGM音量-20
[glink cm="false" size="0" name="bgmvol,bgmvol_20"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=539 y=205 exp="tf.current_bgm_vol=20"]
;BGM音量-30
[glink cm="false" size="0" name="bgmvol,bgmvol_30"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=587 y=205 exp="tf.current_bgm_vol=30"]
;BGM音量-40
[glink cm="false" size="0" name="bgmvol,bgmvol_40"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=635 y=205 exp="tf.current_bgm_vol=40"]
;BGM音量-50
[glink cm="false" size="0" name="bgmvol,bgmvol_50"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=683 y=205 exp="tf.current_bgm_vol=50"]
;BGM音量-60
[glink cm="false" size="0" name="bgmvol,bgmvol_60"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=731 y=205 exp="tf.current_bgm_vol=60"]
;BGM音量-70
[glink cm="false" size="0" name="bgmvol,bgmvol_70"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=779 y=205 exp="tf.current_bgm_vol=70"]
;BGM音量-80
[glink cm="false" size="0" name="bgmvol,bgmvol_80"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=827 y=205 exp="tf.current_bgm_vol=80"]
;BGM音量-90
[glink cm="false" size="0" name="bgmvol,bgmvol_90"  target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=875 y=205 exp="tf.current_bgm_vol=90"]
;BGM音量-100
[glink cm="false" size="0" name="bgmvol,bgmvol_100" target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=923 y=205 exp="tf.current_bgm_vol=100"]

;BGM音量-ミュート（音量=0）
[glink cm="false" size="0" name="bgmvol,bgmvol_0"    target="*vol_bgm_change" graphic="toumei.png" width=49 height=55 x=491 y=343 exp="tf.current_bgm_vol=0"]


;------------------------------------------------------------------------------------------------------
;▼SE音量
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="sevol,sevol_10"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=491 y=264 exp="tf.current_se_vol=10"]
[glink cm="false" size="0" name="sevol,sevol_20"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=539 y=264 exp="tf.current_se_vol=20"]
[glink cm="false" size="0" name="sevol,sevol_30"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=587 y=264 exp="tf.current_se_vol=30"]
[glink cm="false" size="0" name="sevol,sevol_40"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=635 y=264 exp="tf.current_se_vol=40"]
[glink cm="false" size="0" name="sevol,sevol_50"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=683 y=264 exp="tf.current_se_vol=50"]
[glink cm="false" size="0" name="sevol,sevol_60"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=731 y=264 exp="tf.current_se_vol=60"]
[glink cm="false" size="0" name="sevol,sevol_70"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=779 y=264 exp="tf.current_se_vol=70"]
[glink cm="false" size="0" name="sevol,sevol_80"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=827 y=264 exp="tf.current_se_vol=80"]
[glink cm="false" size="0" name="sevol,sevol_90"    target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=875 y=264 exp="tf.current_se_vol=90"]
[glink cm="false" size="0" name="sevol,sevol_100"  target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=923 y=264 exp="tf.current_se_vol=100"]

;SEミュート
[glink cm="false" size="0" name="sevol,sevol_0"      target="*vol_se_change" graphic="toumei.png" width=49 height=55 x=491 y=407 exp="tf.current_se_vol=0"]

;------------------------------------------------------------------------------------------------------
;▼テキスト速度
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="ch,ch_100"  target="*ch_speed_change" exp="tf.set_ch_speed=100" graphic="toumei.png" width=49 height=55 x=491 y=550]
[glink cm="false" size="0" name="ch,ch_80"  target="*ch_speed_change" exp="tf.set_ch_speed=80"    graphic="toumei.png" width=49 height=55 x=539 y=550]
[glink cm="false" size="0" name="ch,ch_50"  target="*ch_speed_change" exp="tf.set_ch_speed=50"    graphic="toumei.png" width=49 height=55 x=587 y=550]
[glink cm="false" size="0" name="ch,ch_40"  target="*ch_speed_change" exp="tf.set_ch_speed=40"    graphic="toumei.png" width=49 height=55 x=635 y=550]
[glink cm="false" size="0" name="ch,ch_30"  target="*ch_speed_change" exp="tf.set_ch_speed=30"    graphic="toumei.png" width=49 height=55 x=683 y=550]
[glink cm="false" size="0" name="ch,ch_25"  target="*ch_speed_change" exp="tf.set_ch_speed=25"    graphic="toumei.png" width=49 height=55 x=731 y=550]
[glink cm="false" size="0" name="ch,ch_20"  target="*ch_speed_change" exp="tf.set_ch_speed=20"    graphic="toumei.png" width=49 height=55 x=779 y=550]
[glink cm="false" size="0" name="ch,ch_11"  target="*ch_speed_change" exp="tf.set_ch_speed=11"    graphic="toumei.png" width=49 height=55 x=827 y=550]
[glink cm="false" size="0" name="ch,ch_8"  target="*ch_speed_change" exp="tf.set_ch_speed=8"       graphic="toumei.png" width=49 height=55 x=875 y=550]
[glink cm="false" size="0" name="ch,ch_5"  target="*ch_speed_change" exp="tf.set_ch_speed=5"       graphic="toumei.png" width=49 height=55 x=923 y=550]

;------------------------------------------------------------------------------------------------------
;▼UIオフ
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="ui_off" target="*ui_off" graphic="&!sf.showMessage2?'menu/op2.png':'toumei.png'" width=49 height=55 x=491 y=470 clickse="photo_AURA.ogg"]

;------------------------------------------------------------------------------------------------------
;▼フルスクリーン
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="fullscreen" target="*fullscreen" graphic="&sf.fullscreen?'menu/op2.png':'toumei.png'" width=49 height=55 x=875 y=348 clickse="photo_AURA.ogg"]

;------------------------------------------------------------------------------------------------------
;▼軽量化モード
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="light" target="*light_mode" graphic="&sf.lightMode?'menu/op2.png':'toumei.png'" width=49 height=55 x=875 y=410 clickse="photo_AURA.ogg"]

;------------------------------------------------------------------------------------------------------
;▼伏せ字モード
;------------------------------------------------------------------------------------------------------
[glink cm="false" size="0" name="censorshipMode" target="*censorship" graphic="&sf.censorship?'menu/op2.png':'toumei.png'" width=49 height=55 x=875 y=470 clickse="photo_AURA.ogg"]

;------------------------------------------------------------------------------------------------------
;▼1回目のループに戻る（2週目以降）
;------------------------------------------------------------------------------------------------------
[if exp="sf.loopCount>=1"]
[glink cm="false" size="0" name="delete_all_data" target="*delete_all_data" graphic="menu/op_back_to_loop_1.png" width=224 height=33 x=792 y=667]
[mo_scale name="delete_all_data" rate="95"]
[endif]
;------------------------------------------------------------------------------------------------------
;▼コンフィグ起動時の画面更新
;------------------------------------------------------------------------------------------------------
; BGM音量・SE音量・テキスト速度・オート速度・未読スキップの順
; $(セレクタ).css("background-image","url(\"画像ファイルの場所\")")

;※画像差し替え版を使用するときは c_set.gif を c_set.png に書き換えてね

[iscript]
	$(".bgmvol_"+tf.current_bgm_vol).css("background-image","url(\"data/image/menu/op2.png\")");

	$(".sevol_"+tf.current_se_vol).css("background-image","url(\"data/image/menu/op2.png\")")

	$(".movvol_"+tf.current_mov_vol).css("background-image","url(\"data/image/menu/op2.png\")")

	$(".ch_"+tf.current_ch_speed).css("background-image","url(\"data/image/menu/op2.png\")")

	const bindGuide = (name, msg) => {
		$(`.${name}`).on('mouseover', function () {
			$('.guide').text(msg)
		}).on('mouseout', function () {
			$('.guide').text('')
		})
	}
	bindGuide('bgmvol_0', '关闭背景音乐')
	bindGuide('sevol_0', '关闭音效')
	bindGuide('sevol_0', '关闭音效')
	bindGuide('ui_off', '开启后将隐藏日期和魔力槽')
	bindGuide('fullscreen', '开启全屏模式')
	bindGuide('light', '开启后将减少特效')
	bindGuide('censorshipMode', '开启后将隐藏部分文字')
[endscript]

[ptext name="guide" layer="fix" text="" color="0x242247" size="30" x="234" y="660" ]

[s]

;--------------------------------------------------------------------------------
; タイトルに戻る
;--------------------------------------------------------------------------------
*backtitle
[endnolog]

[iscript]
tf.flag_back=$(".message1_fore").css("display");
[endscript]

[if exp="tf.flag_back=='none'"]

[cm]
[free name="bg" layer=fix]
[layopt layer=message1 visible=false]
[freeimage layer=1]
[clearfix name="bg"]
[free layer="fix" name="guide"]
;コンフィグの呼び出しに sleepgame を使っているので、必ず awakegame で戻してやってください
[if exp="f.configFromTitle==1"]
[deffont face="craftmincho" edge="#242247" size=36]
[eval exp="f.configFromTitle=0"]
[current layer=message0]
[jump storage="&`${f.backFromConfigTo}.ks`" target="*title"]
[else]
[awakegame]
[endif]

[endif]

[return]


;===================================================

;★ボタンクリック時の処理

;===================================================
;--------------------------------------------------------------------------------
;▼BGM音量
;--------------------------------------------------------------------------------
*vol_bgm_change
[eval exp="sf._system_config_movie_volume=tf.current_bgm_vol"]
[iscript]
	$(".bgmvol").css("background-image","url(\"data/image/toumei.png\")")
	$(".bgmvol_"+tf.current_bgm_vol).css("background-image","url(\"data/image/menu/op2.png\")")
	$("video").each(function(_, e) {
		if ($(e).attr('volume'))
			e.volume = parseFloat(parseInt($(e).attr('volume')) / 100) * parseFloat(parseInt(tf.current_bgm_vol) / 100)
	})
[endscript]
[bgmopt volume="&tf.current_bgm_vol"]
[lbgmmaster vol="&tf.current_bgm_vol" buf="0"]
[s]

;--------------------------------------------------------------------------------
;▼SE音量
;--------------------------------------------------------------------------------
*vol_se_change
[iscript]
	$(".sevol").css("background-image","url(\"data/image/toumei.png\")")
	$(".sevol_"+tf.current_se_vol).css("background-image","url(\"data/image/menu/op2.png\")")
[endscript]
[seopt volume="&tf.current_se_vol"]
[lsemaster vol="&tf.current_se_vol" buf="1"]
[playse  volume="100"  buf="0"  storage="photo_AURA.ogg"  ]
[s]

;---------------------------------------------------------------------------------
;▼テキスト速度
;--------------------------------------------------------------------------------
*ch_speed_change
[eval exp="tf.showSpecialText=Math.random()*300+1>=300"]
[guard_click]
[iscript]
	$(".ch").css("background-image","url(\"data/image/toumei.png\")")
	$(".ch_"+tf.set_ch_speed).css("background-image","url(\"data/image/menu/op2.png\")")
[endscript]
[configdelay speed="&tf.set_ch_speed"]

;	テキスト速度サンプル
	[position layer=message1 left=212 top=616 width=880 height=110 page=fore visible=true opacity=0]
	[layopt layer=message1 visible=true]
	[current layer=message1]
	[if exp="tf.showSpecialText"]
		[if exp="sf.killed"]
		[font color="0xff0000" face="kowai"]縺薙?繧ｹ繝斐?繝峨〒陦ｨ遉ｺ縺輔
		[else]
		[font color="0x5da3ad"]真是怎么看你都看不腻呢
		[endif]
	[else]
		[if exp="sf.killed"]
		[font color="0xff0000" face="kowai"]绝不原谅你
		[else]
		[font color="0x242247"]文字将以此速度显示
		[endif]
	[endif]
		[iscript]
		tf.system.backlog.pop(); // 上の「このスピードで表示されます」のテキストを履歴から削除
		[endscript]

	[wait time=2000]
	[er]
	[layopt layer=message1 visible=false]
	[free_guard_click]
	[s]

;---------------------------------------------------------------------------------
;▼UIオフ
;--------------------------------------------------------------------------------
*ui_off
[eval exp="sf.showMessage2=!sf.showMessage2"]
[iscript]
	tf.uiImage = !sf.showMessage2 ? 'data/image/menu/op2.png' : 'data/image/toumei.png'
	$(".ui_off").css("background-image",`url("${tf.uiImage}")`)
[endscript]
[s]

;---------------------------------------------------------------------------------
;▼フルスクリーン
;--------------------------------------------------------------------------------
*fullscreen
[eval exp="sf.fullscreen=!sf.fullscreen"]
[iscript]
	tf.fullscreenImage = sf.fullscreen ? 'data/image/menu/op2.png' : 'data/image/toumei.png'
	$(".fullscreen").css("background-image",`url("${tf.fullscreenImage}")`)
	if (window.api) {
		window.api.setFullScreen(sf.fullscreen)
	} else {
		TYRANO.kag.menu.screenFull()
	}
[endscript]
[s]

;---------------------------------------------------------------------------------
;▼軽量化モード
;--------------------------------------------------------------------------------
*light_mode
[eval exp="sf.lightMode=!sf.lightMode"]
[iscript]
	tf.lightImage = sf.lightMode ? 'data/image/menu/op2.png' : 'data/image/toumei.png'
	$(".light").css("background-image",`url("${tf.lightImage}")`)
[endscript]
[s]

;---------------------------------------------------------------------------------
;▼伏せ字モード
;--------------------------------------------------------------------------------
*censorship
[eval exp="sf.censorship=!sf.censorship"]
[iscript]
	tf.csImage = sf.censorship ? 'data/image/menu/op2.png' : 'data/image/toumei.png'
	$(".censorshipMode").css("background-image",`url("${tf.csImage}")`)
[endscript]
[s]

;---------------------------------------------------------------------------------
;▼セーブデータの消去
;--------------------------------------------------------------------------------
*delete_all_data
[if exp="sf.kill>0"]
[iscript]
const msg = $.lang(`delete_all_data_kill_${sf.kill}`)
$.alert(msg, null, $.lang('silent'))
[endscript]
[else]
[loadjs storage="delete_all_data.js"]
[endif]
[s]
