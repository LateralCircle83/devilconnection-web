[_tb_system_call storage=system/_scenario_cony.ks]

[achieve_sticker no="23"]

[cm  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="1000"  ]
[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[call  storage="mp.ks"  target="*hide"  ]
[call  storage="phase.ks"  target="*show_top"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="コニー"  time="0"  wait="false"  storage="chara/29/1.png"  width="632"  height="738"  left="326"  top="22"  reflect="false"  ]
[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="false"  time="0"  wait="false"  video="kiri2.mp4"  ]
[call  storage="maku.ks"  target="*open"  ]
[bg_layermode  name="mahou"  folder="bgimage"  storage="haikei_mahou_Small.webp"  mode="color-dodge"]

[wait  time="700"  ]
[free_bg_layermode  name="mahou"  time="5000"  ]

*x

[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
汪！[wait time=100]这……，这是哪儿？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/7.png"  width="383"  height="400"  left="7"  top="308"  ]
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
呼呼呼……，欢迎光临，狗狗警官。[r]
就算你急的汪汪叫也是没什么用的啦。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[jump  storage="scenario_cony.ks"  target="*maki"  cond="Boolean(f.makiPhotoId)"  ]
[tb_start_text mode=1 ]
#柯妮
[if exp="f.maki_cony== 1"]莫非你们就是[r]
玛奇昨天所说的……！[else]莫非你们就是……！[endif][p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/3.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[tb_start_text mode=1 ]
#柯妮
嗅到了……，可疑的气味！[r]
你们，是不是隐瞒了什么！[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/10.png"  ]
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
[font size=50]突然间要干嘛！？[resetfont][if exp="f.blueberry == 1][r]
本大爷身上怎么可能有味道！[else]怎么可能有气味啊！[r]
今天刚起床就被拖进浴室里了！[endif][p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[image  name="newspaper"  layer="0"  zindex="2"  folder="image"  storage="shin.png"  x="0"  y="0"]

[image  name="newspaper"  layer="0"  zindex="2"  folder="image"  storage="shin1.png"  x="0"  y="0"]

[wait  time="100"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/102.png"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[chara_move  name="コニー"  anim="false"  time="0"  effect="linear"  wait="false"  left="228"  top="22"  width="632"  height="738"  ]
[playse  volume="100"  time="0"  buf="1"  storage="idou.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#柯妮
[if exp="f.blueberry == 1]你身上确实有蓝莓的气味呢……[r]
不过先不谈这个！[endif]请看今早的报纸。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
这是位于魔吉利西亚中心位置的巨大魔石柱，[r]
名叫「彩虹之塔」。[p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/7.png"  ]
[tb_start_text mode=1 ]
#柯妮
平时该塔外表会闪耀着鲜艳的色彩，[r]
并提供充沛的魔力……[p]
但近几日塔体颜色突然变得浑浊发白，[r]
魔力供给量也急剧下跌。[p]
[_tb_end_text]

[tb_eval  exp="f.cony=1"  name="cony"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
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
言下之意，你认为是我们干的？[r]
开什么玩笑……[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/102.png"  ]
[tb_start_text mode=1 ]
#柯妮
在上述现象的发生的同时，这几天以索尔希艾为中心，[r]
部分居民感受到了莫名的倦怠。[p]

[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/106.png"  ]
[tb_start_text mode=1 ]
#德比伦
啊～，倦怠感？那确实可能是我们干……[r]
[font size=25]不过情况有这么严重吗？[resetfont][p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[call  storage="mp.ks"  target="*show"  ]
[free  layer="0"  name="newspaper"]

[eval exp="f.makiPhotoId=null"]

[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_move  name="コニー"  anim="false"  time="0"  effect="linear"  wait="false"  left="326"  top="22"  width="632"  height="738"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#柯妮
然后，这里到处堆放的教科书……。那边穿长袍的，[r]
你是索尔希艾尔魔法学校的学生吧。[p]

[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/7.png"  ]
[tb_start_text mode=1 ]
#柯妮
也就是说，这里是位于魔法学校的附近……[r]
我之前正好调查过这一带，但是从街道外完全看不出来。[p]


[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/20.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="maryoku.ogg"  loop="true"  ]
[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="true"  time="500"  wait="false"  video="oto2.mp4"  ]
[tb_start_text mode=1 ]
#柯妮
对了，这个魔力探测机，自从被召唤到这个房间里后，[r]
就一直发出哔哔这样强烈的反应。[p]


[_tb_end_text]

[stopse  time="300"  buf="1"  ]
[playse  volume="100"  time="0"  buf="1"  storage="ka-.ogg"  ]
[free_layermode  time="500"  wait="false"  ]
[layermode  mode="exclusion"  color="0xffffff"  time="0"  wait="false"  graphic="syuutyuu.png"  ]
[camera  time="1000"  zoom="1.3"  wait="false"  y="80"  layer="base"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  y="80"  layer="0"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  y="80"  layer="1"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/3.png"  ]
[tb_start_text mode=1 ]
#柯妮
也就是说，你们在这间屋子里[r]
藏匿了惊人的魔力。[p]


[_tb_end_text]

[reset_camera  time="500"  wait="false"  layer="base"  ]
[reset_camera  time="500"  wait="false"  layer="0"  ]
[reset_camera  time="500"  wait="false"  layer="1"  ]
[free_layermode  time="500"  wait="false"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="3"  storage="sasu3.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/82.png"  ]
[tb_start_text mode=1 ]
#德比伦
可恶……，明明昨天在室外布下了结界，[r]
没想竟然以这种形式暴露了。[p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[tb_start_text mode=1 ]
#柯妮
照这样下去，明天就会扩散到全世界！[r]
现在，请立刻自首！[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/64.png"  ]
[tb_start_text mode=1 ]
#德比伦
[delay speed=100]……[resetdelay]既然被发现，那就没辙了。[r]
事已至此，[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
你懂本大爷的意思吧……？[r]
[emb exp="f.name"]？[p]
[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*maki_jump"  ]
*maki

[comment  c="マキ写真見せたとき"  ]
[tb_start_text mode=1 ]
#柯妮
你那表情……！[p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/3.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[tb_start_text mode=1 ]
#柯妮
嗅到了……，啊不对，现在已经不是单纯嗅到的程度！[r]
请你们立刻自首！[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/10.png"  ]
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
[font size=50]突然间要干嘛！？[resetfont][if exp="f.blueberry == 1][r]
本大爷身上怎么可能有味道！[else]怎么可能有气味啊！[r]
今天刚起床就被拖进浴室里了！[endif][p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[image  name="newspaper"  layer="0"  zindex="2"  folder="image"  storage="shin.png"  x="0"  y="0"]

[image  name="newspaper,photo"  layer="0"  zindex="2"  storage="&dc.getPhotoThumb(f.makiPhotoId)"  x="813"  y="144"  width="410"  height="303"]

[wait  time="100"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/102.png"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[chara_move  name="コニー"  anim="false"  time="0"  effect="linear"  wait="false"  left="228"  top="22"  width="632"  height="738"  ]
[playse  volume="100"  time="0"  buf="1"  storage="idou.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#柯妮
[if exp="f.blueberry == 1]你身上确实有蓝莓的气味呢……[r]
不过先不谈这个！[endif]请看今早的报纸。[p]
[_tb_end_text]

[stopbgm  time="0"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[tb_start_text mode=1 ]
#柯妮
这个，怎么看都是你们吧。[p]
[_tb_end_text]

[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[tb_eval  exp="f.cony=1"  name="cony"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/95.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]确实怎么看都是我们啊。[resetfont][p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[call  storage="mp.ks"  target="*show"  ]
[free  layer="0"  name="newspaper"]

[eval exp="f.makiPhotoId=null"]

[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_move  name="コニー"  anim="false"  time="0"  effect="linear"  wait="false"  left="326"  top="22"  width="632"  height="738"  ]
[tb_start_text mode=1 ]
#柯妮

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/82.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/7.png"  ]
[tb_start_text mode=1 ]
#柯妮
正如这篇报道所说，现在因为你们的缘故，[r]
魔吉利西亚的魔力急剧枯竭，导致社会陷入了大混乱！[p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[tb_start_text mode=1 ]
#柯妮
所以说！[r]
请立刻自首！[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/64.png"  ]
[tb_start_text mode=1 ]
#德比伦
[delay speed=100]……[resetdelay]没想到真的会上新闻……[r]
事到如今已经走到这一步了[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
你懂本大爷的意思吧……？[r]
[emb exp="f.name"]？[p]
[_tb_end_text]

*maki_jump

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/3.png"  ]
[tb_start_text mode=1 ]
#柯妮
如果不自首的话，就请做好觉悟，[r]
[font size=50]我绝对要逮捕你们！[resetfont][p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/67.png"  ]
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
噗，还挺有气势的嘛。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/7.png"  ]
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
那就让本大爷来好好地欣赏一下，[r]
你那满脸通红的窘态吧。[p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[eval exp="f.zyagan_count = 0"]

*zyagan1_modoru

[choice2 text1="史莱姆魔法" target1="*sura" text2="透明魔法" target2="*fuku"]

[zyagan target="*zyagan1,*zyagan1_2serihu" borders="77, 97, 103, 123"]

[s  ]
*zyagan1

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/4.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
你、你要干什么！[r]
我必须先冷静下来，确认对方的动向后……[p]
[_tb_end_text]

[tb_eval  exp="f.HANYOU=1"  name="HANYOU"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_start_text mode=1 ]
#柯妮
藏在领带背面的录音机……[r]
这将成为铁证如山的证据。[p]
[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*zyagan1_modoru_2"  ]
*zyagan1_2serihu

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/4.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
真是一脸下流表情的恶魔啊……[r]
不过只要有这副眼镜在，我就是无敌的，绝不屈服！[p]


[_tb_end_text]

*zyagan1_modoru_2

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_cony.ks"  target="*zyagan1_modoru"  ]
*sura

[achieve_sticker no="20"]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[playse  volume="100"  time="0"  buf="5"  storage="suraimu.ogg"  loop="true"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="200"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/5.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ1"  time="1000"  wait="false"  storage="chara/11/moya1.png"  width="460"  height="200"  left="230"  top="58"  reflect="false"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#柯妮
[font size=46]嘿呜，好凉啊！我最讨厌黏糊糊的东西了！[r]
不要，快住手！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/6.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[free_apng name="debi_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
[font size=50]哒呀哈～！[resetfont][r]
这景色可真养眼呀～[p]
[_tb_end_text]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[stopse  time="1000"  buf="5"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[jump  storage="scenario_cony.ks"  target="*sura_jump"  ]
*fuku

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="200"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/6.png"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#柯妮
工作时会穿着制服，[r]
但我在家中就是这幅打扮！[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_show  name="感情オーラ1"  time="1000"  wait="false"  storage="chara/11/moya1-1.png"  width="460"  height="200"  left="230"  top="58"  reflect="false"  ]
[tb_start_text mode=1 ]
#柯妮
你们是想要为难我吧？[r]
不过我才不在乎呢！[p]

[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/21.png"  width="383"  height="400"  left="7"  top="308"  ]
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
为什么她这么正言厉色地说完后，[r]
气氛反而一下子不暧昧了啊。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
莫非[r]
我们之前其实是……[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/24.png"  ]
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
对裸体无关的窘迫反应产生了异样的快感！？[p]
[_tb_end_text]

[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/21.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/7.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#柯妮
咳咳……，即便如此，[r]
虽然我是不在意……[p]

[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
*sura_jump

[tb_start_text mode=1 ]
#柯妮
但、但是你们这样的行径，[r]
可是会构成猥亵罪的！[p]

[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*zyagan_mita"  cond="f.HANYOU==1"  ]
[tb_start_text mode=1 ]
#柯妮
刚才所有的行为，都被藏在领带背后的[r]
录音设备给全部记录了下来。[p]
现以未经许可召唤罪、恐吓罪以及[r]
猥亵罪的名义，逮捕你们！[p]

[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*zyagan_mitemai_jump"  ]
*zyagan_mita

[tb_start_text mode=1 ]
#柯妮
刚才的一切行为皆已记录在案，现以未经许可召唤罪、[r]
恐吓罪以及猥亵罪的名义，逮捕你们！[p]

[_tb_end_text]

*zyagan_mitemai_jump

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/67.png"  ]
[tb_start_text mode=1 ]
#德比伦
录音啊……。哼哼，那我就把那段音频[r]
给你变成无法公开的内容！[p]

[_tb_end_text]

[eval exp="f.zyagan_count = 0"]

*zyagan2_modoru

[tb_hide_message_window  ]
[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[choice2 text1="绊倒魔法" target1="*ten" text2="拘束魔法" target2="*kou"]

[zyagan target="*zyagan2" borders="84, 98, 103, 117"]

[s  ]
*zyagan2

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/4.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
最近一直没出什么成绩，[r]
这可是个大好机会……！[p]
绝对要抓住这只恶魔，[r]
还有那位身着长袍的怪异魔法师。[p]
就算经历挫折，也定有收获……[r]
这就是我的座右铭！[p]
[_tb_end_text]

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/2.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[tb_start_tyrano_code]
[_tb_end_tyrano_code]

[jump  storage="scenario_cony.ks"  target="*zyagan2_modoru"  ]
[s  ]
*ten

[achieve_sticker no="21"]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="200"  ]
[playse  volume="100"  time="0"  buf="3"  storage="koke.ogg"  loop="false"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/8.png"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#柯妮
[font face="DZUYOKU"][font size=50]……！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/6.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[free_apng name="debi_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
呀哈哈～，如我所料，[r]
屁股都摔痛了吧～！[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/18.png"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2-2.png"  width="396"  height="297"  left="668"  top="208"  reflect="false"  ]
[tb_start_text mode=1 ]
#柯妮
[font face="YOWAKU"]呜……，又搞砸了……[resetfont][p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/9.png"  ]
[camera  time="8000"  zoom="1.15"  wait="false"  layer="base"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="0"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="1"  ]
[tb_start_text mode=1 ]
#柯妮
不过，我可不会……[r]
被这种小事给打倒的！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
本来我就是个冒失鬼……[r]
从小到大就这么跌跌撞撞地走过来的。[p]
就算是魔法警察录取考试……[r]
都数次落榜。[p]
[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/3.png"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/11.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/1.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="3"  storage="sasu.ogg"  ]
[reset_camera  time="600"  wait="false"  layer="base"  ]
[reset_camera  time="600"  wait="false"  layer="0"  ]
[reset_camera  time="600"  wait="false"  layer="1"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#柯妮
但每次都能重振旗鼓！[r]
现在这种事，对我来说已经算不了什么了！[p]
[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*megane"  ]
*kou

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[playse  volume="100"  time="0"  buf="5"  storage="marusu.ogg"  loop="false"  ]
[wait  time="200"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/10.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2.png"  width="398"  height="298"  left="685"  top="214"  reflect="false"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#柯妮
[font face="DZUYOKU"][font size=50]呜哇！？[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/18.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[free_apng name="debi_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
哟～，这下可丢大发了吧！[r]
身为警察的你反而被逮捕了算什么话喔！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
[font size=50]居、居然如此卑鄙！[r]
讨厌！不要！放开我！[resetfont][p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/65.png"  ]
[tb_start_text mode=1 ]
#德比伦
你这幅没出息的模样[r]
可是被清清楚楚录下来了喽～[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/67.png"  ]
[tb_start_text mode=1 ]
#德比伦
就这玩意还能当做证据提交出来吗～？[r]
要是剪辑处理的话，会被怀疑成伪造的喔！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
[font face="YOWAKU"]呜……呜……[resetfont][p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/11.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#柯妮
[font size=80]快放开我！！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
糟糕。绑的太松了……？[p]
[_tb_end_text]

*megane

[achieve_sticker no="22"]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="0"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/12.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#柯妮
[font size=60]！？[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
眼……[delay speed=300]……[resetdelay][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[tb_start_text mode=1 ]
#柯妮
[font size=50]眼镜掉了！[r]
掉哪里去了！？我、我看不见……[resetfont][p]



[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/74.png"  ]
[tb_start_text mode=1 ]
#德比伦
这就是所谓的「冒失娘」吗？[r]
总感觉，有点可怜啊。[p]
[_tb_end_text]

[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[eval exp="f.zyagan_count = 0"]

*zyagan3_modoru

[choice2 text1="出手相助" target1="te" text2="夺走眼镜" target2="*kame"]

[zyagan target="*zyagan3,*zyagan3_serihu" borders="88, 98, 102, 112"]

[s  ]
*zyagan3

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/13.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
啊啊，偏偏在这么关键的时候把眼镜给弄掉了，[r]
我这个笨蛋笨蛋笨蛋！[p]


[_tb_end_text]

[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/14.png"  ]
[tb_start_text mode=1 ]
#柯妮
呜呜……，我果然是个……[r]
超级无能的警察呢……[p]


[_tb_end_text]

[jump  storage="scenario_cony.ks"  target="*zyagan3_modoru2"  ]
*zyagan3_serihu

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#柯妮
[_tb_end_text]

[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/13.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#柯妮
这种时候就要靠想象力、想象力啊！柯妮！[r]
让大脑转起来呀。[p]

[_tb_end_text]

[chara_mod  name="コニー"  time="60"  cross="false"  storage="chara/29/21.png"  ]
[tb_start_text mode=1 ]
#柯妮
啊对了！不如将计就计，继续冒冒失失地演下去，[r]
伺机钻他们的空子就行啦！[p]
[_tb_end_text]

*zyagan3_modoru2

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/te.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/12.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_cony.ks"  target="*zyagan3_modoru"  ]
*te

[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[chara_show  name="サブでび"  time="0"  wait="true"  storage="chara/30/c1.png"  width="432"  height="502"  left="36"  top="340"  reflect="false"  ]
[chara_move  name="サブでび"  anim="true"  time="500"  effect="easeOutQuad"  wait="true"  left="216"  top="329"  width="334"  height="388"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="10"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="サブでび" keyframe="fuwa" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
真是拿你没办法，[r]
捡给你吧。[p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="0"  ]
[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/15.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="サブでび"  time="0"  cross="false"  storage="chara/30/c2.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#柯妮
[font size=80]抓住你了！[resetfont][p]
[_tb_end_text]

[playbgm  volume="50"  time="0"  loop="false"  storage="maneko.ogg"  ]
[chara_mod  name="サブでび"  time="0"  cross="false"  storage="chara/30/c3.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" x="0"]
[frame p="50%" x="5"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="サブでび" keyframe="fuwa" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=60]哒呀！？！？！？[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#柯妮
太小看我了吧！[r]
这就是所谓的「反败为胜」……[p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="サブでび"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="感情オーラ1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="感情オーラ2"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="コニー"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="コニー"  time="0"  wait="false"  storage="chara/29/19.png"  width="1280"  height="960"  left=""  top=""  reflect="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="Horror.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[camera  time="10000"  zoom="1.1"  wait="false"  y="0"  layer="0"  ]
[tb_start_text mode=1 ]
#柯妮
[font size=50]还有那边的，[r]
我要把你们一起押送到派出所。[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
哒呀呀呀……[p]
[_tb_end_text]

[stopbgm  time="0"  ]
[tb_eval  exp="f.photoDeviPose=1"  name="photoDeviPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[ending no="17"]

[reset_camera  time="0"  wait="false"  ]
*kame

[playse  volume="100"  time="0"  buf="1"  storage="idou.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/79.png"  width="383"  height="400"  left="7"  top="308"  ]
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

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
「嗖」地一下，顺手把录音机也抢走啦，[r]
还真谢谢你告诉本大爷藏在领带背面呢。[p]

[_tb_end_text]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/11.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ3"  time="1000"  wait="false"  storage="chara/13/moya3.png"  width="400"  height="200"  left="304"  top="442"  reflect="false"  ]
[tb_start_text mode=1 ]
#柯妮
[font size=50]怎、怎么会这样！[r]
还给我！[resetfont][p]


[_tb_end_text]

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
唔呀～，这情感灵气的颜色，可真是太棒了……[r]
不错，真不错！开始回收魔力咯！[p]

[_tb_end_text]

[kyushu]

[tb_show_message_window  ]
[tb_start_tyrano_code]
[anim layer="message0" time="300" opacity="255"]
[anim name="fixlayer" time="300" opacity="255"]
[wait time="300"]
[_tb_end_tyrano_code]

[chara_mod  name="コニー"  time="0"  cross="false"  storage="chara/29/17.png"  ]
[tb_start_text mode=1 ]
#柯妮
[font face="YOWAKU"]呜呜……，早知如此……，[r]
就该提前学个临时提高视力的魔法啊……[resetfont][p]

[_tb_end_text]

[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[call  storage="maku.ks"  target="*close"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[chara_hide_all  time="0"  wait="false"  ]
[chara_show  name="でびるん"  time="0"  wait="false"  storage="chara/1/11.png"  width="1280"  height="960"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="-50"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="でびるん" keyframe="fuwa" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[flash_off  time="0"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="1_debirun_no_theme.ogg"  ]
[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="maku.ks"  target="*open"  ]
[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
那家伙冒冒失失的样子还挺可爱呢，[r]
差点就要上前帮忙，要不是拼命忍住了……[p]

[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/6.png"  ]
[tb_start_text mode=1 ]
#德比伦
哒呀？本大爷很温柔……？[p]
[_tb_end_text]

[camera  time="1000"  zoom="1.3"  wait="false"  x="0"  y="50"  rotate="0"  layer="base"  ease_type="ease"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  x="0"  y="50"  rotate="0"  layer="0"  ease_type="ease"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  x="0"  y="50"  rotate="0"  layer="1"  ease_type="ease"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/44.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
毛线，才没有！只是单纯的喜欢，[r]
跟温柔什么的不搭呀！[p]
[_tb_end_text]

[reset_camera  time="1000"  wait="false"  layer="base"  ]
[reset_camera  time="1000"  wait="false"  layer="0"  ]
[reset_camera  time="1000"  wait="false"  layer="1"  ]
[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/10.png"  ]
[tb_start_text mode=1 ]
#德比伦
本大爷可是那种习惯掌握主导权的类型～[r]
就喜欢看起来柔弱的家伙。[p]
[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
那家伙是最适合当宠物的吧？[r]
你这家伙是不是也欠调教了？！[p]
[_tb_end_text]

[iscript]
// 全部見たら記録する（初回だけ）
if (f.chara && !f.finished.includes(f.chara.name)) {
f.finished = [...f.finished, f.chara.name];
}
[endscript]

[tb_hide_message_window  ]
[call  storage="maku.ks"  target="*close"  ]
[chara_hide  name="でびるん"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[free_layermode  time="1000"  wait="true"  ]
[jump  storage="syoukan.ks"  target=""  ]
[s  ]
