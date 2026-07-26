[_tb_system_call storage=system/_scenario_fuga.ks]

[cm  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="1000"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="mp.ks"  target="*show"  ]
[call  storage="phase.ks"  target="*show_top"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="シルフィ"  time="0"  wait="false"  storage="chara/24/1.png"  width="394"  height="398"  left="230"  top="32"  reflect="false"  ]
[chara_show  name="フウガ"  time="0"  wait="false"  storage="chara/23/1.png"  width="1058"  height="826"  left="160"  top="55"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="false"  time="0"  wait="false"  video="kiri2.mp4"  ]
[call  storage="maku.ks"  target="*open"  ]
[bg_layermode  name="mahou"  folder="bgimage"  storage="haikei_mahou2.webp"  mode="color-dodge"]

[wait  time="700"  ]
[free_bg_layermode  name="mahou"  time="5000"  ]

*x

[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[fadein_window  time="300"  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="fuga3.ogg"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/2.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#风雅
[delay speed=100]…………[resetdelay]这是哪。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
风～雅，你在吵什么。[p]

[_tb_end_text]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/2.png"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#西尔菲
啊，[wait time=200]恶魔！[wait time=200]有恶魔！[r]
这副样子，看起来还是个高阶恶魔！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/1.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[free_apng name="debi_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
唔、[wait time=200]怎么还有个奇怪的玩意也跟过来了。[r]
这家伙……是用刀的精灵使？[p]
[_tb_end_text]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/3.png"  ]
[tb_start_text mode=1 ]
#西尔菲
没错，风雅是精灵剑客！[wait time=200][r]
然后呢，咱叫西尔菲，是风之精灵喔！[p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
哼。精灵啊[delay speed=400]……[resetdelay][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/20.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]区区下等生物罢了w！[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/4.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#西尔菲
你说什么！无论天使恶魔还是精灵，大家不都是魔神同属吗！[r]
你是真不知道还是在这里装糊涂！[p]

[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/3.png"  ]
[tb_start_text mode=1 ]
#风雅
西尔菲，勿受挑衅……[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#西尔菲
[font size=50]我要让你见识一下，精灵的实力！[resetfont][p]

[_tb_end_text]

[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[tb_hide_message_window  ]
[eval exp="f.zyagan_count = 0"]

*zyagan1_modoru

[choice2 text1="藤蔓魔法" target1="*syo" text2="烟雾魔法" target2="*kemu"]

[zyagan target="*zyagan1" borders="70, 95, 105, 130"]

[s  ]
*zyagan1

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[chara_mod  name="フウガ"  time="60"  cross="false"  storage="chara/23/4.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#风雅
唉，西尔菲总是沉不住气，真是没办法。[r]
不过这种时候，也是展现我修行成果的好机会……[p]

[_tb_end_text]

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/20.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/2.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_fuga.ks"  target="*zyagan1_modoru"  ]
*syo

[tb_hide_message_window  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="200"  ]
[tb_eval  exp="f.kansou1=1"  name="kansou1"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/5.png"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/5.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ1"  time="1000"  wait="false"  storage="chara/11/moya1.png"  width="437"  height="190"  left="480"  top="51"  reflect="false"  ]
[tb_start_text mode=1 ]
#风雅
[delay speed=200]……[resetdelay]！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
[font face="DZUYOKU"][font size=50]呜呀～！放开我！[resetfont][p]
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/6.png"  ]
[tb_start_text mode=1 ]
#风雅
西、[wait time=300]西尔菲……[r]
你变成风不就好了！[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/6.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=50]你不说我都忘了～！[resetfont][p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/20.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
呼呼，[wait time=100]你们这着急忙慌的表情[delay speed=200]……[resetdelay]。[r]
真是叫人欲罢不能啊，多来点！[p]

[_tb_end_text]

[chara_mod  name="シルフィ"  time="400"  cross="false"  storage="chara/24/3.png"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="100"  cross="false"  storage="chara/23/1.png"  ]
[tb_start_text mode=1 ]
#风雅
终、终于挣脱了……[r]
你，[wait time=300]把我们弄到这里是有何目的。[p]
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*syo_jump"  ]
*kemu

[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_hide_message_window  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_show  name="感情オーラ1"  time="1000"  wait="false"  storage="chara/11/moya1-1.png"  width="423"  height="184"  left="482"  top="53"  reflect="false"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/61.png"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/7.png"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/6.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="fuga1.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=4 ]
#德比伦
[_tb_end_text]

[wait  time="700"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=75]哎呀！[r]
[wait time=300]被刀到了！！[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
区区烟雾，驱散便可～[p]

[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*tarinai"  cond="f.mp<30"  ]
[jump  storage="scenario_fuga.ks"  target="*MPari"  ]
*tarinai

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/68.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="YOWAKU"]就用MP来修复吧[delay speed=300]……[resetdelay][resetfont][p]
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*END2"  ]
*MPari

[tb_eval  exp="f.fuga_mp=1"  name="fuga_mp"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[eval exp="f.mp-=30"]

[call  storage="mp.ks"  target="*update"  ]
[tb_eval  exp="f.photoDeviPose=1"  name="photoDeviPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/7.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri2" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
你以为本大爷[r]
会这么轻易地被你斩杀？[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="aseru.ogg"  ]
[chara_mod  name="シルフィ"  time="100"  cross="false"  storage="chara/24/2.png"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#西尔菲
修、[wait time=300]修复了！[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/62.png"  ]
[tb_start_text mode=1 ]
#德比伦
[emb exp="f.name"]……[r]
刚才那一下耗了点MP。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/63.png"  ]
[tb_start_text mode=1 ]
#德比伦
都是你这家伙的锅！[r]
要是刚刚本大爷[font color=0xEC6FC5 bold=true]在没有MP的状态下被砍中[resetfont]，就要当场去世了。[p]
[_tb_end_text]

[chara_mod  name="フウガ"  time="100"  cross="false"  storage="chara/23/1.png"  ]
[tb_start_text mode=1 ]
#风雅
还挺顽强的。[r]
[wait time=300]把我们弄到这里，是何目的。[p]
[_tb_end_text]

*syo_jump

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/63.png"  ]
[tb_start_text mode=1 ]
#德比伦
问得好。[wait time=300]那当然是为了欣赏你们那狼狈不堪的模样，[r]
顺带收割魔力！[p]
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/8.png"  ]
[tb_start_text mode=1 ]
#风雅
卑劣……[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/64.png"  ]
[tb_start_text mode=1 ]
#德比伦
库呼呼，恐惧吗，害怕吗？[r]
事到如今，还要夹着尾巴一脸蠢相地逃窜吗？[p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[eval exp="f.zyagan_count = 0"]

*zyagan2_modoru

[choice2 text1="饭团魔法" target1="*oni" text2="泳装魔法" target2="*mizu"]

[zyagan target="*zyagan2,*zyagan2_2serihu" borders="75, 96, 104, 125"]

[s  ]
*zyagan2

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/4.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_eval  exp="f.HANYOU=1"  name="HANYOU"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#风雅
恶魔的腹部有一只眼睛……[r]
莫非和那家伙一样，有着读心的能力？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#风雅
……倘若如此，那我必须无念无想，[r]
不可让他看穿动向。[p]
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*zyagan1_modoru_2"  ]
*zyagan2_2serihu

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/4.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#风雅
话说回来，这只恶魔接下来又要刷什么花招……[r]
[if exp="f.kansou1 == 1]不会又要把我绑起来弄成奇怪的模样吧，[else]不会是要把我弄成奇怪的模样吧，[endif]还是饶了我吧。[p]
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/17.png"  ]
[tb_start_text mode=1 ]
#风雅
……不行，不能再继续想下去了。[p]
[_tb_end_text]

*zyagan1_modoru_2

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te2.png"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/64.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/2.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_fuga.ks"  target="*kansou2_skip"  cond="f.kansou2==1"  ]
*kansou2

[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
呵……这小子，隐约察觉到本大爷的能力了？[r]
难道身边有人是邪眼持有者？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
哼、有意思。[r]
[font size=50]本大爷才不会照着你的套路走！[resetfont][p]
[_tb_end_text]

[tb_hide_message_window  ]
[tb_eval  exp="f.kansou2=1"  name="kansou2"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
*kansou2_skip

[jump  storage="scenario_fuga.ks"  target="*zyagan2_modoru"  ]
*oni

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_hide_message_window  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="200"  ]
[chara_mod  name="フウガ"  time="100"  cross="false"  storage="chara/23/9.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[chara_mod  name="シルフィ"  time="100"  cross="false"  storage="chara/24/7.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=50]咱可是超爱饭团侠！[resetfont][r]
怎么样，风雅，你看这个适合我吗？[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2-2.png"  width="409"  height="178"  left="759"  top="293"  reflect="false"  ]
[tb_start_text mode=1 ]
#风雅
不是食物而是头套？[r]
匪夷所思的魔法。[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/10.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
你搞个啥玩意出来了！怕不会是魔法失败了吧？[r]
[font size=50]给我认真点，笨蛋！[resetfont][p]
[_tb_end_text]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/2.png"  ]
[tb_start_text mode=1 ]
#风雅
……我们这边[r]
也不能一直被动！[p]

[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*oni_jump"  ]
*mizu

[tb_hide_message_window  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/18.png"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/2.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="600" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="200"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/10.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2.png"  width="362"  height="181"  left="780"  top="289"  reflect="false"  ]
[tb_eval  exp="f.fuga_sukumizu=1"  name="fuga_sukumizu"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#风雅
[font face="YOWAKU"]哈啊……，如此折腾，有何乐趣可言。[resetfont][p]



[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/8.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#西尔菲
[font size=50]！！[resetfont][p]
[_tb_end_text]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/9.png"  ]
[tb_start_text mode=1 ]
#西尔菲
平时都没穿衣服，可一套上布料……[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/10.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=50]莫名产生了一股迷之禁忌感！[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/65.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]没错！[resetfont]你明白那种感觉了吗，风之精灵！[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=50]原本就赤身裸体到处跑，也是很了不起的！[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/66.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
[font size=50]对吧！[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=50]这衣服真的很适合你呀！风雅！[resetfont][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="sasu3.ogg"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/11.png"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/11.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#风雅
[font size=60]不许跟着恶魔瞎起哄！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
[font face="YOWAKU"][font size=25]好、好的……，对不起。[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/16.png"  ]
[tb_start_text mode=1 ]
#风雅
这该死的恶魔[delay speed=300]……[resetdelay][r][font size=50]不可饶恕！[resetfont][p]
[_tb_end_text]

*oni_jump

[tb_hide_message_window  ]
[eval exp="f.zyagan_count = 0"]

*zyagan3_modoru

[choice2 text1="往右侧闪避" target1="*ransuu" text2="往左侧闪避" target2="*ransuu"]

[zyagan target="*zyagan3" borders="80, 97, 103, 120"]

[s  ]
*zyagan3

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[chara_mod  name="フウガ"  time="60"  cross="false"  storage="chara/23/17.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#风雅
[delay speed=200]…………[resetdelay][p]
我[delay speed=100]……[resetdelay]要冷静下来。[p]
恶魔，我知道你此刻正在洞察着我的想法。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/4.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#风雅
所以，我会坚持把心思彻底放空！[p]
[_tb_end_text]

[tb_hide_message_window  ]
[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/1.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/2.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_fuga.ks"  target="*kansou3_jump"  cond="f.kansou3==1"  ]
[jump  storage="scenario_fuga.ks"  target="*kan"  cond="f.HANYOU==1"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
啥！？邪眼探查居然暴露了！[r]
这家伙……有两把刷子！[p]
[_tb_end_text]

[tb_eval  exp="f.kansou3=1"  name="kansou3"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[jump  storage="scenario_fuga.ks"  target="*kansou3_jump"  ]
*kan

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/64.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
有本事就放马过来！[r]
无论你怎么攻击，砍到算我输！[p]
[_tb_end_text]

*kansou3_jump

[tb_hide_message_window  ]
[jump  storage="scenario_fuga.ks"  target="*zyagan3_modoru"  ]
*ransuu

[tb_eval  exp="f.RANSUU=Math.floor(Math.random()*(3-0+1)+0)"  name="RANSUU"  cmd="="  op="r"  val="0"  val_2="3"  ]
[jump  storage="scenario_fuga.ks"  target="*OK_nige"  cond="f.HANYOU==1"  ]
[jump  storage="scenario_fuga.ks"  target="*OK_nige"  cond="f.RANSUU==0"  ]
[jump  storage="scenario_fuga.ks"  target="*NO_tukamae"  cond="f.RANSUU==1"  ]
[jump  storage="scenario_fuga.ks"  target="*NO_tukamae"  cond="f.RANSUU==2"  ]
[jump  storage="scenario_fuga.ks"  target="*NO_tukamae"  cond="f.RANSUU==3"  ]
*NO_tukamae

[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_hide_message_window  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="-10"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="でびるん" keyframe="fuwa" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/14.png"  ]
[chara_move  name="感情オーラ2"  anim="false"  time="0"  effect="linear"  wait="false"  left="822"  top="345"  width="360"  height="179"  ]
[chara_hide  name="コマでび"  time="0"  wait="false"  pos_mode="false"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/10.png"  ]
[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_show  name="サブでび"  time="0"  wait="false"  storage="chara/30/bura.png"  width="400"  height="520"  left="83"  top="147"  reflect="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="fuga1.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#西尔菲
[font size=60]逮到你了！[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=75]哒呀！[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#风雅
不想挨刀，就乖乖送我们回去！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[font size=50]可、可恶……[resetfont][p]

[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/12.png"  ]
[tb_start_text mode=1 ]
#西尔菲
别嘴硬了！[r]
快道歉！[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="aseru.ogg"  ]
[chara_mod  name="サブでび"  time="0"  cross="false"  storage="chara/30/bura2.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=75]偏不说！！[resetfont][p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/15.png"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/1.png"  ]
[chara_hide  name="サブでび"  time="0"  wait="false"  pos_mode="false"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="fuga1.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_show  name="感情オーラ3"  time="1000"  wait="false"  storage="chara/13/moya3-3.png"  width="528"  height="229"  left="322"  top="486"  reflect="false"  ]
[tb_eval  exp="f.kansou1=1"  name="kansou1"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=75]哒呀！[resetfont][p]

[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/68.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[free_apng name="debi_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
你们真是[r]
毫无怜悯之心……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#风雅
面对如此卑劣的恶魔，[r]
我怎可能施以任何慈悲！[p]
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*END"  cond="f.mp<30"  ]
[eval exp="f.mp-=30"]

[call  storage="mp.ks"  target="*update"  ]
[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/78.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri2" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[if exp="f.fuga_mp == 1]又[endif]虽然用魔力修复好了，但已是破烂不堪。[r]
[delay speed=100]……[resetdelay]赶紧吸走魔力开润啦！[resetfont][p]

[_tb_end_text]

[tb_eval  exp="f.HANYOU=0"  name="HANYOU"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*kyuusyu"  ]
*END

[tb_start_text mode=1 ]
#德比伦
[if exp="f.fuga_mp == 1]就、[wait time=100]就像刚才被砍时候的那样。[endif]就用MP来修复吧[delay speed=100]……[resetdelay][p]
[_tb_end_text]

*END2

[tb_start_text mode=1 ]
#德比伦
[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="0"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="0" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/61.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="ka-.ogg"  ]
[stopbgm  time="0"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU" size=75]今天剩余的MP[resetfont][font face="DZUYOKU"][r]
不够修复用的啦！[resetfont][p]

[_tb_end_text]

[tb_eval  exp="f.photoDeviPose=1"  name="photoDeviPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[ending no="12"]

*OK_nige

[tb_hide_message_window  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[tb_start_tyrano_code]
[keyframe name="shiru"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="シルフィ" keyframe="shiru" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_move  name="感情オーラ2"  anim="false"  time="300"  effect="linear"  wait="true"  left="798"  top="301"  width="400"  height="200"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/6.png"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/12.png"  ]
[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/2.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="kawasu.ogg"  ]
[playse  volume="100"  time="0"  buf="4"  storage="fuga4.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
嘿嘿，你往哪里砍呢。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#风雅
[font size=50]什么！[resetfont][p]




[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/65.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]杂鱼w[resetfont][p]


[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/67.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]弱爆啦w[resetfont]，好不容易放空了心思，[r]
却依旧被看穿了动向……[p]


[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*YONDENAI"  cond="f.HANYOU==0"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/7.png"  ]
[tb_start_text mode=1 ]
#德比伦
所谓的思考啊，就是你越觉得不能去想，[r]
反而会让它在脑中挥之不去。小子，你还太嫩了。[p]



[_tb_end_text]

*YONDENAI

[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ3"  time="1000"  wait="false"  storage="chara/13/moya3.png"  width="400"  height="200"  left="428"  top="518"  reflect="false"  ]
[chara_mod  name="フウガ"  time="0"  cross="false"  storage="chara/23/13.png"  ]
[tb_start_text mode=1 ]
#风雅
（咬牙切齿）……[p]




[_tb_end_text]

[chara_mod  name="シルフィ"  time="0"  cross="false"  storage="chara/24/8.png"  ]
[tb_start_text mode=1 ]
#西尔菲
喂，风雅，你还好吗？[r]
冷静点……[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/6.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_eval  exp="f.HANYOU=1"  name="HANYOU"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#德比伦
呀哈哈哈！这表情配上这股高涨的情绪，可谓堪称完美～[r]
那么，这满满的魔力本大爷就不客气啦！[p]



[_tb_end_text]

[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#风雅
[_tb_end_text]

*kyuusyu

[kyushu]

[chara_mod  name="フウガ"  time="80"  cross="false"  storage="chara/23/8.png"  ]
[chara_mod  name="シルフィ"  time="80"  cross="false"  storage="chara/24/13.png"  ]
[tb_show_message_window  ]
[tb_start_tyrano_code]
[anim layer="message0" time="300" opacity="255"]
[anim name="fixlayer" time="300" opacity="255"]
[wait time="300"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#风雅
怎么回事，这种感觉……[r]
是魔力被吸走了吗？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#西尔菲
呜呜……，咱也突然间浑身无力了……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_hide_message_window  ]
[call  storage="maku.ks"  target="*close"  ]
[chara_hide_all  time="0"  wait="false"  ]
[jump  storage="scenario_fuga.ks"  target="*OK"  cond="f.HANYOU==1"  ]
[chara_show  name="でびるん"  time="0"  wait="false"  storage="chara/1/5.png"  width="1280"  height="960"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="1_debirun_no_theme.ogg"  ]
[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="maku.ks"  target="*open"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="-50"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="でびるん" keyframe="fuwa" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
可恶[delay speed=100]……[resetdelay]，修复耗费了魔力，[r]
这次有点不够完美啊。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
往后也得像这样使用魔力，[r]
否则可能会遇到麻烦[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/8.png"  ]
[tb_start_text mode=1 ]
#德比伦
[if exp="f.finished.length%3==2"]算了，收拾收拾心情吧！[r]
一会就是MP的判定时间啦！[else]算了，打起精神来，继续继续！[endif] [p]
[_tb_end_text]

[jump  storage="scenario_fuga.ks"  target="*OWARI"  ]
*OK

[chara_show  name="でびるん"  time="0"  wait="false"  storage="chara/1/10.png"  width="1280"  height="960"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="1_debirun_no_theme.ogg"  ]
[call  storage="maku.ks"  target="*open"  ]
[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/10.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="-50"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="でびるん" keyframe="fuwa" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
你也看到了吧？最后那副无能狂怒的表情[r]
也真是看爽本大爷了～♥[p]
[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/1.png"  ]
[tb_start_text mode=1 ]
#德比伦
这会儿，他应该和那个精灵一起，因倦怠感而动弹不得吧……[r]
两个家伙一起倒下，还真是可怜哟～[p]
[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/11.png"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  x="0"  y="50"  rotate="0"  layer="0"  ease_type="ease"  ]
[tb_start_text mode=1 ]
#德比伦
继续，照着这个势头把其他家伙一并拖入深渊！[p]
[_tb_end_text]

*OWARI

[iscript]
// 全部見たら記録する（初回だけ）
if (f.chara && !f.finished.includes(f.chara.name)) {
f.finished = [...f.finished, f.chara.name];
}
[endscript]

[collect_character name="シルフィ"]

[tb_hide_message_window  ]
[call  storage="maku.ks"  target="*close"  ]
[tb_start_tyrano_code]
[stop_kanim name="シルフィ"]
[_tb_end_tyrano_code]

[chara_hide  name="でびるん"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[free_layermode  time="1000"  wait="true"  ]
[jump  storage="syoukan.ks"  target=""  ]
[s  ]
