[_tb_system_call storage=system/_AAAAkarioki.ks]

[tb_start_text mode=1 ]
#德比伦
[if exp="f.point == 0]……[endif][p]
[_tb_end_text]

[mind_voice  color="0x56b0af"  name="でびるん"  text="よぉ、ブブゥ・・・って邪眼が無いから伝わらんか"  face="craftmincho"  ]
[reset_mind_voice  ]
[jump  storage="Devil_Hardester.ks"  target="*trueEND"  cond="dc.aibou()"  ]
[comment  c="↑トゥルーエンド行った分岐"  ]
[comment  c="カメラ装飾"  ]
[camera  time="1000"  zoom="1.1"  wait="false"  layer="layer_camera"  ]
[reset_camera  time="5000"  wait="false"  layer="layer_camera"  ]
[memory name="kupya_meteor" val="1"]

[tb_start_tyrano_code]
[position layer="message0" frame="Message3.png"  height="258"  ]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[tb_start_text mode=1 ]
#むずかしいかんじ
範[font face="KaiseiDecol-Bold"]疇[resetfont]　[font face="KaiseiDecol-Bold"]舐[resetfont]める　[font face="KaiseiDecol-Bold"]完美[resetfont]を深める[p]
[_tb_end_text]

[tb_start_text mode=1 ]
[ruby text="ビー"][p]
[ruby text="⠀"][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#強弱
[font face="DZUYOKU"]あああ[resetfont][p]
[font face="YOWAKU"]あああ[resetfont][p]
[font face="kowai"]あああ[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#&f.debiName
[r][playse  volume="100"  time="0"  buf="3"  storage="bane.ogg"  ][font size=45]一[wait time=400][playse  volume="100"  time="0"  buf="3"  storage="bane.ogg"  ]条[wait time=400][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#カメラif
[if exp="f.cameraEnable"]カメラオン[else]カメラオフ[endif] [p]

[_tb_end_text]

[tb_start_text mode=1 ]
#3キャラ目
[if exp="f.finished.length==2"]3匹目のとき[else]それ以外[endif] [p]
[_tb_end_text]

[tb_start_text mode=1 ]
#文字サイズ
[font size=50][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[if exp="sf.kill == 0]殺してない[else]殺した[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[if exp="sf.epilogue == 0]行ってない[else]行った[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[if exp="sf.kill == 0][emb exp="f.name"][else]ザコ[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#ウェイト
[delay speed=100]・・・[resetdelay][p]
[wait time=300][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#文字デカく
[font size=50]！[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#名前文字列
[emb exp="f.name"]♥[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#loop1のみ
[if exp="f.currentLoop == 1]いっかいめ[else]いっかいめいがい[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#オスメス分岐
[if exp="f.seibetu == 1]オニーサン[else]オネーサン[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#うきうきでびコマ↓
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#横震えでびコマ↓
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#色
[font color=0xEC6FC5 bold=true]怠惰[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#赤
[font color=0xFF0000][p]
[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BGM止め鳴らす

[_tb_end_text]

[stopbgm  time="0"  ]
[tb_start_text mode=1 ]
#ゲージ移動

[_tb_end_text]

[tb_start_text mode=1 ]
#If構文
[if exp="f.end_complete == 1"]君[else]桑[endif][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#If構文
[if exp="f.seibetu == 1"]君[else]桑[endif][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#If構文
[if exp="dc.aibou()"]トゥルー行った[else]トゥルー行ってない[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#ネオ
[font color=0xab0009 bold=true][quake_text][delay speed=100][if exp="dc.aibou()"]トゥルー行った[else]トゥルー行ってない[endif][resetdelay][free_quake_text][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#If構文
[if exp="f.syo == 1"][else]召唤师[endif][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#If構文
[if exp="f.hutanari == 1"]ふたなり[else]ちがう[endif][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#システム変数If構文
[if exp="sf.hensuu == 1"]この数字[else]この数字以外[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#震える
[quake_text]なれた[free_quake_text][p]
[_tb_end_text]

[call  storage="mp.ks"  target="*update"  ]
[tb_start_text mode=1 ]
↓フェードインアウト画像[p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[flash_off  time="20"  effect="fadeOut"  ]

[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#↓拡大手
[_tb_end_text]

[chara_move  name="プレイヤー"  anim="true"  time="1000"  effect="easeOutCubic"  wait="false"  left="1"  top="-184"  width="1234"  height="925"  ]
[chara_move  name="プレイヤー"  anim="true"  time="1000"  effect="easeOutCubic"  wait="false"  left="1"  top="0"  width="1280"  height="960"  ]
[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[tb_start_text mode=1 ]
#↓音量0

[_tb_end_text]

[lbgmvol vol="0"]

[lbgmvol vol="50"]

[tb_start_text mode=1 ]
#途中再生
[_tb_end_text]

[lbgmstop]

[lbgmresume str="3_connection_communication.ogg"]

[tb_start_text mode=1 ]
#メニュー消し
[_tb_end_text]

[disable_menu_button]

[enable_menu_button]

[tb_start_text mode=1 ]
#スキップ消し
[_tb_end_text]

[disable_skip_button visible="true"]

[enable_skip_button visible="true"]

[tb_start_text mode=1 ]
#スキップ止め
[_tb_end_text]

[skipstop]

[tb_start_text mode=1 ]
#フォトボタン消し
[_tb_end_text]

[hide_photo_button]

[show_photo_button  visible="true"]

[tb_start_text mode=1 ]
#フォトポーズオフ
[_tb_end_text]

[tb_eval  exp="f.photoPose=0"  name="photoPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.photoPose=1"  name="photoPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#でびフォト消し
[_tb_end_text]

[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.photoDeviPose=1"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#固定じゃないポーズ消し(後ろにいる召喚士消し)
[_tb_end_text]

[tb_eval  exp="f.photoNonFixedPose=0"  name="photoNonFixedPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="f.photoNonFixedPose=1"  name="photoNonFixedPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_tyrano_code]
[if exp="f.gauru==1"]
#ガウルォス
ちゃんと魔眼を使えー！[p]
[elsif exp="f.gauru==2"]
#ガウルォス
ちゃんと魔眼を使えー！[r]ツー[p]
[elsif exp="f.gauru==3"]
#ガウルォス
ちゃんと魔眼を使えー！[r]スリー[p]
[elsif exp="f.gauru==4"]
#ガウルォス
屈伸煽りやめろ[p]
[elsif exp="f.gauru==5"]
#ガウルォス
遊んでるよな[r]…この俺で。[p]
[elsif exp="f.gauru==6"]
#ガウルォス
フッ、おもしれぇ[if exp="f.seibetu == 1]男[else]女[endif]…[p]
[elsif exp="f.gauru==7"]
#ガウルォス
お前さん…なかなか前髪が[r]イケてるな！[p]
[elsif exp="f.gauru==8"]
#ガウルォス
…そろそろ俺の思考にも[r]向き合おうぜ[p]
[elsif exp="f.gauru==9"]
#ガウルォス
好きな食べ物はメンマです[p]
[elsif exp="f.gauru==10"]
#ガウルォス
そろそろお仕置きしちゃうぞ？[p]
[elsif exp="f.gauru==11"]
#ガウルォス
カウントダウンしちゃうからね！？[p]
[elsif exp="f.gauru==12"]
#ガウルォス
[font size=50]三！[resetfont][p]
[elsif exp="f.gauru==13"]
#ガウルォス
[font size=60]にー！[resetfont][p]
[elsif exp="f.gauru==14"]
#ガウルォス
[font size=70]いち！[resetfont][p]
[elsif exp="f.gauru==15"]
#ガウルォス
[jump  storage="scenario_gauru.ks"  target="*15"  cond=""  ][p]
[else]
#ガウルォス
・・・[p]
[endif]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#心の声出す
[_tb_end_text]

[mind_voice  color="0x56b0af"  name="でびるん"  text="サキュバスの真似事とは…強欲の悪魔も<br>兼任できそうなくらいがめついな…"  face="craftmincho"  ]
[reset_mind_voice  ]
[mind_voice  color="0xfffb7a"  name="クピャドエル"  text="絶対…見つけてみせますから…"  face="KaiseiDecol-Bold"  ]
[tb_start_text mode=1 ]
#心の声消す
[_tb_end_text]

[reset_mind_voice  ]
[tb_start_text mode=1 ]
#ウインドウ表示しながら暗く
[_tb_end_text]

[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[free layer=4 name="kuro" time="0"  ]

[tb_start_tyrano_code]
[if exp="f.currentLoop == 3"]
#库皮亚多艾露
！
[elsif exp="f.currentLoop == 4"]
#库皮亚多艾露
！
[else]
#库皮亚多艾露
・・・
[endif]
[p]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[if exp="f.kupya_owari == 0"]
#库皮亚多艾露
差不多该聊的都聊了[r]
还请您谅解
[elsif exp="f.kupya_owari == 1"]
#库皮亚多艾露
咱的话题卡组已经空空如也了喔～
[elsif exp="f.kupya_owari == 2"]
#库皮亚多艾露
咱们来聊聊天气如何？
[elsif exp="f.kupya_owari == 3"]
#库皮亚多艾露
偶尔，[emb exp="f.name"]さんから[r]話題を振ってくれてもいいのですよぅ
[elsif exp="f.kupya_owari == 4"]
#库皮亚多艾露
[emb exp="f.name"]您[r]
意外地还挺粘人的呢～
[elsif exp="f.kupya_owari == 5"]
#库皮亚多艾露
也得多陪陪德比君呀？
[elsif exp="f.kupya_owari == 6"]
#库皮亚多艾露
ワタクシもでびくんのツノ[r]つんつーんってしたいですぅ！
[elsif exp="f.kupya_owari == 7"]
#库皮亚多艾露
若是需要建议的话[r]
还请您如此吩咐呢
[elsif exp="f.kupya_owari == 8"]
#库皮亚多艾露
くぴゃあ～なんだか眠くなってきましたぁ
[elsif exp="f.kupya_owari == 9"]
#库皮亚多艾露
この顔なのでこっそり教会で[r]寝ててもバレないのですぅ
[elsif exp="f.kupya_owari == 10"]
#库皮亚多艾露
すぴゃあ～delay speed=100]・・・[resetdelay]
[elsif exp="f.kupya_owari == 11"]
#库皮亚多艾露
すぴゃあ～delay speed=100]・・・・・・[resetdelay]
[elsif exp="f.kupya_owari == 12"]
#库皮亚多艾露
この顔なのでこっそり教会で[r]寝ててもバレないのですぅ
[elsif exp="f.kupya_owari == 13"]
#库皮亚多艾露
到底是真睡着了还是装睡的判断就交给您了啦
[elsif exp="f.kupya_owari == 14"]
#库皮亚多艾露
嘶啪啊～[delay speed=100]・・・[resetdelay]
[else]
#库皮亚多艾露
嘶啪啊～[delay speed=100]・・・・・・[resetdelay]
[endif]
[p]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#振り子
[_tb_end_text]

[comment  c="小"  ]
[swing  name="でび縛り"  angle="1"  axis="181,0"  time="2000"  easing="sine"]

[comment  c="中"  ]
[swing  name="でび縛り"  angle="3"  axis="181,0"  time="2000"  easing="sine"]

[comment  c="大"  ]
[swing  name="でび縛り"  angle="7"  axis="181,0"  time="2000"  easing="sine"]

[tb_start_text mode=1 ]
#キャラ解禁
[_tb_end_text]

[collect_character name="めだま"]

[comment  c="カメラ有効化"  ]
[memory name="cameraEnable" val="1"]

[eval exp="sf.albumEnable=1"]

[iscript]
// カメラ未解禁の場合はスキップボタンを移動する
$('.skip_button,.skipping').css('left', '916px')
[endscript]

[show_photo_button  visible="true"]

[comment  c="カメラ有効化"  ]
