[_tb_system_call storage=system/_scenario_Lai.ks]

[cm  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="mp.ks"  target="*show"  ]
[call  storage="phase.ks"  target="*show_top"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="ライ"  time="0"  wait="false"  storage="chara/58/1.png"  width="676"  height="880"  left="309"  top="-69"  reflect="false"  ]
[playbgm  volume="100"  time="0"  loop="true"  storage="3_connection_communication_a_loop.ogg"  ]
[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="false"  time="0"  wait="false"  video="kiri2.mp4"  ]
[call  storage="maku.ks"  target="*open"  ]
[bg_layermode  name="mahou"  folder="bgimage"  storage="haikei_mahou2.webp"  mode="color-dodge"]

[wait  time="700"  ]
[free_bg_layermode  name="mahou"  time="5000"  ]

*x

[tb_start_text mode=1 ]
#雷依
[_tb_end_text]

[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#雷依
嘿、嘿哎……[r]
这是哪儿。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦

[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/20.png"  width="383"  height="400"  left="7"  top="308"  ]
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

[stopbgm  time="1000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]魔力交出来！[resetfont][p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/2.png"  ]
[playse  volume="100"  time="0"  buf="3"  storage="gimon.ogg"  ]
[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[quake  time="600"  count="10"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#雷依
[font size=50]呜哇啊啊啊啊是恶魔！[r]
对、对不起！对不起！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
[font size=50]我总是这么畏畏缩缩的……[r]
真的抱歉！[resetfont][p]


[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/3.png"  ]
[tb_start_text mode=1 ]
#雷依
我……我不太擅长魔法，[r]
也没有多少魔力，所以请不要伤害我……[p]



[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
……太吵了，[r]
让他稍微安静点。[p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te2.png"  ]
[eval exp="f.zyagan_count = 0"]

*zyagan1_modoru

[choice2 text1="恐吓魔法" target1="*odo" text2="布娃娃魔法" target2="*nui"]

[zyagan target="*zyagan1" borders="25, 35, 40, 50"]

[s  ]
*zyagan1

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#雷依
[_tb_end_text]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/24.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#雷依
呜呜、怎么办啊……[r]
好可怕……好可怕啊……[p]
[_tb_end_text]

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

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_Lai.ks"  target="*zyagan1_modoru"  ]
*odo

[achieve_sticker no=84]

[layermode  mode="overlay"  color="0x8082ad"  time="300"  wait="false"  ]
[stopbgm  time="1000"  fadeout="true"  ]
[playse  volume="100"  time="0"  buf="3"  storage="fuga2.ogg"  ]
[playse  volume="40"  time="0"  buf="5"  storage="huan.ogg"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/che_2.png"  ]
[camera  time="4000"  zoom="1.5"  wait="false"  y="90"  ease_type="ease"  layer="base"  ]
[camera  time="4000"  zoom="1.8"  wait="false"  y="90"  ease_type="ease"  layer="0"  ]
[chara_move  name="プレイヤー"  anim="true"  time="300"  effect="easeOutCubic"  wait="false"  left="0"  top="39"  width="1280"  height="960"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/5.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=4 ]
#雷依
呀……呀……
[_tb_end_text]

[wait  time="3000"  ]
[tb_start_text mode=4 ]
#雷依
[er]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0xFFFFFF"  ]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="ライ"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="TAP"  time="0"  wait="false"  storage="chara/18/lai.png"  width="1280"  height="960"  ]
[wait  time="10"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[quake  time="600"  count="10"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="3"  storage="lai.ogg"  ]
[playse  volume="100"  time="0"  buf="5"  storage="lai_bili.ogg"  loop="true"  ]
[tb_start_text mode=4 ]
#雷依
[font face="DZUYOKU"][font size=80]不要啊啊啊啊啊！[resetfont]

[_tb_end_text]

[wait  time="100"  ]
[free_layermode  time="0"  wait="false"  ]
[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="80"  wait="false"  ]

[l  ]
[stopse  time="500"  buf="5"  fadeout="true"  ]
[ending no="7"]

*nui

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="300"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/6.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#雷依
嘿呀！[p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[playse  volume="100"  time="0"  buf="3"  storage="hirameki.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/7.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="50"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#雷依
……啊咧？这个，难道是……[r]
模仿我的样子做出来的布娃娃？[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/8.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ1"  time="1000"  wait="false"  storage="chara/11/moya1.png"  width="460"  height="200"  left="242"  top="123"  reflect="false"  ]
[tb_start_text mode=1 ]
#雷依
炸虾狮子……吗？[r]
莫非是「炸虾狮」的意思！？ 呼呼……哈哈哈……[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦

[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/19.png"  width="383"  height="400"  left="7"  top="308"  ]
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
炸虾是很好吃的啦～[r]
还有你这家伙啊，笑点真低，挺好。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="nega.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/9.png"  ]
[tb_start_text mode=1 ]
#雷依
呜呜、可是……，就算收到了可爱的毛绒玩具，[r]
我的处境也没有得到任何的改善啊……[p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
虽然比起反抗要好一些，[r]
但这家伙畏畏缩缩的态度真是有点棘手。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
呜呜……是这样……。就因为这个，[r]
至今还在被人吐槽没个狮子样……[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
如果能做到的话，我也想成为最强的百兽之王啊……[r]
那么一来，大概就能应付现在这种局面了吧……[p]


[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/64.png"  ]
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
呵，就当是给你带赴黄泉的礼物吧。[r]
你的愿望，由本大爷来实现。[p]
[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/10.png"  ]
[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[tb_start_text mode=1 ]
#雷依
带赴黄泉的礼物！？[r]
被夺走魔力会死的吗！？[p]


[_tb_end_text]

[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/fu_te2.png"  ]
[tb_hide_message_window  ]
[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[eval exp="f.zyagan_count = 0"]

*zyagan2_modoru

[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
[choice2 text1="飘飘魔法" target1="*huri" text2="力量强化魔法" target2="*up" graphic2="mp" cm2=false]

[zyagan target="*zyagan2,*zyagan2_2serihu" borders="20, 30, 35, 45"]

[s  ]
*zyagan2

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#雷依
[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/11.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#雷依
我不想死……不想死啊……[r]
竟然要死在这种潮湿阴暗的房间里……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
最后的归宿要能在阳光和煦的草原上就好了。[p]
[_tb_end_text]

[jump  storage="scenario_Lai.ks"  target="*zyagan2_modoru_2"  ]
*zyagan2_2serihu

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_start_text mode=1 ]
#雷依
[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/12.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#雷依
不……不过，刚刚那只恶魔说，会帮我变得有狮样，[r]
是真的吗？希望不要太痛啊。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
唔～，可是……比起帅气，[r]
我好像更喜欢可爱点的……？[p]
[_tb_end_text]

*zyagan2_modoru_2

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te2.png"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/9.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei2.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_Lai.ks"  target="*kansou2_jump"  cond="f.kansou2==1"  ]
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
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#德比伦
这家伙是不是一直都以为，魔力被吸走就会[c]死[_c]掉啊？[p]
[_tb_end_text]

[tb_hide_message_window  ]
[tb_eval  exp="f.kansou2=1"  name="kansou2"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[chara_hide  name="コマでび"  time="80"  wait="false"  pos_mode="false"  ]
*kansou2_jump

[jump  storage="scenario_Lai.ks"  target="*zyagan2_modoru"  ]
*huri

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="100"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="200"  ]
[chara_mod  name="ライ"  time="100"  cross="false"  storage="chara/58/13.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#雷依
哇！好可爱...！[r]
这就是百兽之王？[p]


[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦

[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/66.png"  width="383"  height="400"  left="7"  top="308"  ]
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
[force_size size=42][font size=25]单单就是本大爷想鉴赏一下而已……[resetfont][r]
诶～嘛，反正就是那么回事。[p]

[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[tb_start_text mode=1 ]
#德比伦
在现代社会里，可爱就是正义！[r]
这可是萌萌锦标赛中，百兽之王的服装。[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/14.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2.png"  width="460"  height="200"  left="629"  top="259"  reflect="false"  ]
[tb_start_text mode=1 ]
#雷依
原来如此！战队服什么的虽然也挺好，[r]
不过这身打扮我之前也有点憧憬呢～。哎嘿！嘿嘿嘿……[p]

[_tb_end_text]

[tb_hide_message_window  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="300"  ]
[playse  volume="100"  time="0"  buf="3"  storage="nega.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/15.png"  ]
[wait  time="1000"  ]
[tb_show_message_window  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
喂，怎么啦～？[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
……但是，像我这样的家伙，[r]
穿着这种衣服出去的话，会被大家笑掉大牙吧。[p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/115.png"  ]
[tb_start_text mode=1 ]
#德比伦
啊～，真麻烦。管你是狮子还是什么玩意，[r]
在本恶魔眼里看来，都只是路边的毛球罢了。[p]

[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/66.png"  ]
[tb_start_text mode=1 ]
#德比伦
不管是哪个家伙，[r]
全都是杂・鱼！[p]


[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[tb_start_text mode=1 ]
#雷依
原来在恶魔的眼中……[r]
是那样看待的啊……[p]



[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/11.png"  ]
[tb_start_text mode=1 ]
#德比伦
嘁、动不动这么吐槽本大爷的家伙，[r]
不过都是一些内心脆弱的真正杂鱼罢了。[p]


[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
至少在本大爷看来，你小子比那些攻击性强[r]
还吵死人的家伙要好对付得多了。[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/16.png"  ]
[tb_start_text mode=1 ]
#雷依
是吗？[r]
竟然被恶魔夸奖了，好开心呀。[p]



[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/25.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]才没夸你，[r]
这是讽刺！[resetfont][p]
[_tb_end_text]

[jump  storage="scenario_Lai.ks"  target="*huri_jump"  cond=""  ]
*up

[mp_check  min="30"]

[s  cond="!f.mp_check_pass"  ]
[cm  ]
[iscript]
const fixLayer = $('.fixlayer')
$('.message0_fore').css('display') == 'none' && $('.message0_fore').attr('l_visible') == 'false' && fixLayer.hide()
fixLayer.filter('.skip_button').css('visibility', '')
fixLayer.filter('.waku.disabled').remove()
[endscript]

[eval exp="f.mp-=30"]

[call  storage="mp.ks"  target="*update"  ]
[playse  volume="100"  time="0"  buf="4"  storage="kaihuku.ogg"  ]
[layopt layer=4 visible="true"]

[image name="shiro" layer=4 folder="fgimage" storage="default/shiro.webp" time="300"  wait="false"  ]

[wait  time="300"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#雷依
[font face="DZUYOKU"][font size=60]哇啊！[r]
怎么回事！身体好热！[resetfont][p]


[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/17.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[free layer=4 name="shiro" time="300"  wait="false"  ]

[tb_start_text mode=1 ]
#雷依②
[font face="DZUYOKU"][font size=60]这……这是我！？[r]
力量……正在源源不断地涌现出来……！[resetfont][p]




[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="debi_fuki_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/10/65.png"  width="383"  height="400"  left="7"  top="308"  ]
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

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

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
快看，连布娃娃[r]
都轻而易举地撕碎了！[p]





[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/18.png"  ]
[chara_show  name="ライ"  time="0"  wait="false"  storage="chara/58/17.png"  width="676"  height="880"  left="309"  top="-69"  reflect="false"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_show  name="感情オーラ2"  time="1000"  wait="false"  storage="chara/12/moya2-2.png"  width="460"  height="200"  left="627"  top="258"  reflect="false"  ]
[tb_start_text mode=1 ]
#雷依②
[font face="DZUYOKU"][font size=60]嘿诶！？ 完、完全控制不住力道啊！[r]
这样或许……是不是……有点可怕……[resetfont][p]






[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/10.png"  ]
[tb_start_text mode=1 ]
#德比伦
本大爷不惜消耗MP去实现了你的愿望，[r]
你这话是什么意思！[p]









[_tb_end_text]

[tb_hide_message_window  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[wait  time="300"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/15.png"  ]
[tb_show_message_window  ]
[playse  volume="100"  time="0"  buf="3"  storage="nega.ogg"  ]
[tb_start_text mode=1 ]
#雷依
呜呜，对不起……[r]
对不起……[p]






[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/121.png"  ]
[tb_start_text mode=1 ]
#德比伦
就算得到了力量，精神层面[r]
不改变的话还是不行啊。[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/102.png"  ]
[playse  volume="100"  time="0"  buf="3"  storage="hirameki.ogg"  ]
[tb_start_text mode=1 ]
#雷依
啊，但是……多亏了你，[r]
我才意识到了一件事……！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
周围人一直吐槽我狮子的身份，[r]
所以我也憎恶自己不像只狮子……[p]


[_tb_end_text]

[tb_start_text mode=1 ]
#雷依
其实……[r]
就算我没什么狮样……好像也没什么问题吧。[p]


[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/16.png"  ]
[tb_start_text mode=1 ]
#雷依
是我太在意周围人的目光……[r]
就算是变得强大起来……但那样的我也不再是我了！[p]


[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/11.png"  ]
[tb_start_text mode=1 ]
#德比伦
啊啊，说的也是。唔嘛，能让你悟出这个道理，[r]
魔力也算没白白浪费。[p]

[_tb_end_text]

*huri_jump

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/19.png"  ]
[tb_start_text mode=1 ]
#雷依
……你虽然是恶魔，[r]
但思考方式却不像恶魔呢。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/91.png"  ]
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
嗯？你是在侮辱本大爷吗？[r]
本大爷可不想被你这样的蛆虫给指指点点。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/2.png"  ]
[tb_start_text mode=1 ]
#雷依
蛆、蛆虫！？ 不是不是，[r]
我、我是在夸你啊！？[p]


[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/138.png"  ]
[tb_start_text mode=1 ]
#德比伦
那可是你的价值观。[r]
喂，尽量去回击那些蔑视你的家伙们！[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/172.png"  ]
[tb_start_text mode=1 ]
#德比伦
库呼呼，这就是恶魔的思考方式吧？[r]
要怎么教训那些一直在蔑视人的家伙们呢……[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/19.png"  ]
[tb_start_text mode=1 ]
#雷依
呜呜，还是算了吧。[p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[tb_start_text mode=1 ]
#德比伦
为什么。[r]
[font size=25]你这家伙一副畏畏缩缩的样子，说话倒是直言不讳……[resetfont][p]
[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[tb_start_text mode=1 ]
#雷依
我只是……想以自己的方式，[r]
安安稳稳地过好每一天。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/66.png"  ]
[tb_start_text mode=1 ]
#德比伦
嘁，真就是个……[r]
杂鱼路人的想法。[p]


[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="nega.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/15.png"  ]
[tb_start_text mode=1 ]
#雷依
反正我本来不就是个杂鱼路人嘛……[p]


[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[tb_start_text mode=1 ]
#雷依
呜呜……，也确实如你所说，好不容易才悟通的重要道理……[r]
难道我真要像个路人一般过完此生吗……[r]
[p]



[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/19.png"  ]
[tb_start_text mode=1 ]
#雷依
好……好吧……[p]



[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/21.png"  ]
[tb_start_text mode=1 ]
#雷依
[font size=75]放马过来吧～！[resetfont][p]


[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/121.png"  ]
[tb_start_text mode=1 ]
#德比伦
明明连个像样的魔法都使不出来，[r]
这家伙怕不是被吓傻了？[p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_hide  name="コマでび"  time="100"  wait="false"  pos_mode="false"  ]
[eval exp="f.zyagan_count = 0"]

*zyagan3_modoru

[choice2 text1="鞭击魔法" target1="mu" text2="屏障魔法" target2="*ba"]

[zyagan target="*zyagan3" borders="15, 25, 30, 40"]

[s  ]
*zyagan3

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan.ks"  target=""  ]
[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#雷依
[_tb_end_text]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/4.png"  ]
[bg  time="0"  method="crossfade"  storage="haikei_zyagan.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#雷依
呜呜……，唯有在走投无路时才能发动的雷电魔法……[r]
现在这种危急关头或许能施展出来……！[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/20.png"  ]
[tb_start_text mode=1 ]
#雷依
[font size=70]拜托啦……出现吧！[resetfont][p]
[_tb_end_text]

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[bg  time="0"  method="crossfade"  storage="haikei2.webp"  wait="false"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[jump  storage="scenario_Lai.ks"  target="*zyagan3_modoru"  ]
[s  ]
*mu

[flash  time="0"  effect="fadeIn"  color="0xFFFFFF"  ]

[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/0.png"  ]
[playse  volume="100"  time="0"  buf="3"  storage="lie.ogg"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[wait  time="600"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/2.png"  ]
[quake  time="600"  count="10"  hmax="3"  wait="false"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[playse  volume="100"  time="0"  buf="4"  storage="gimon.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#雷依
[font size=50]嘿呀！[resetfont][p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="nega.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/3.png"  ]
[tb_start_text mode=1 ]
#雷依
啊呜～，居然突然间就一鞭子抽过来了……[r]
好疼啊……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦

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
不是你这家伙先出的招吗？[r]
唔……，还真就是，杂鱼一条。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="saimin.ogg"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/22.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_OK.ogg"  ]
[chara_show  name="感情オーラ3"  time="1000"  wait="false"  storage="chara/13/moya3.png"  width="460"  height="200"  left="187"  top="320"  reflect="false"  ]
[tb_start_text mode=1 ]
#雷依
但、但是……总感觉……[r]
好像……有点舒服？[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[tb_start_text mode=1 ]
#德比伦
啊……，在他往奇怪方向觉醒之前，[r]
先回收魔力吧。[p]

[_tb_end_text]

[jump  storage="scenario_Lai.ks"  target="*kyu"  ]
*ba

[wait  time="200"  ]
[playse  volume="100"  time="0"  buf="1"  storage="barrier2.ogg"  ]
[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="true"  time="1000"  wait="false"  video="baria_gaku.mp4"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="80"  wait="false"  pos_mode="false"  ]
[wait  time="1000"  ]
[tb_show_message_window  ]
[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[chara_show  name="コマでび"  layer="0"  zindex="2"  time="20"  wait="false"  storage="chara/10/84.png"  width="383"  height="400"  top="308"  left="7"  ]
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
根本不需要什么屏障吧……[r]
你在期待着什么啊？[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/23.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="gauru3.ogg"  ]
[stopbgm  time="0"  ]
[tb_start_text mode=1 ]
#雷依
[font size=65]降临吧！雷电……黄光雷暴！[resetfont][p]
[_tb_end_text]

[tb_hide_message_window  ]
[l  ]
[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[playse  volume="100"  time="0"  buf="4"  storage="ting.ogg"  ]
[free_layermode  time="500"  wait="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="500"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[tb_show_message_window  ]
[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/3.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="AURA_NG.ogg"  ]
[chara_show  name="感情オーラ3"  time="1000"  wait="false"  storage="chara/13/moya3-3.png"  width="460"  height="200"  left="190"  top="322"  reflect="false"  ]
[tb_start_text mode=1 ]
#雷依
啊呜～……[r]
果然还是不行啊……[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[tb_start_text mode=1 ]
#德比伦
好了，干掉他吧。[p]
[_tb_end_text]

*kyu

[kyushu]

[tb_start_tyrano_code]
[anim layer="message0" time="300" opacity="255"]
[anim name="fixlayer" time="300" opacity="255"]
[wait time="300"]
[_tb_end_tyrano_code]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/1.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
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
话说，你这家伙是不是以为自己就要[c]死[_c]了。[r]
放心吧，只是魔力不足，卧床几天就没事了，感激涕零吧你。[p]

[_tb_end_text]

[chara_mod  name="ライ"  time="0"  cross="false"  storage="chara/58/16.png"  ]
[tb_start_text mode=1 ]
#雷依
诶，是这样吗？太好啦！[r]
只要躺着休息几天吗！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[tb_hide_message_window  ]
[stopse  time="0"  buf="5"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[call  storage="maku.ks"  target="*close"  ]
[chara_hide_all  time="0"  wait="false"  ]
[chara_show  name="でびるん"  time="0"  wait="false"  storage="chara/1/10.png"  width="1280"  height="960"  ]
[tb_start_tyrano_code]
[keyframe name="fuwa"]
[frame p="0%" y="0"]
[frame p="50%" y="-50"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="でびるん" keyframe="fuwa" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[bg  time="0"  method="crossfade"  storage="haikei2.webp"  wait="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="1_debirun_no_theme.ogg"  ]
[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[call  storage="maku.ks"  target="*open"  ]
[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
哼，从头到尾[r]
都是只没出息的狮子。[p]

[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/8.png"  ]
[tb_start_text mode=1 ]
#德比伦
话说回来，本大爷是无法理解被蔑视人的家伙[r]
骑在头上还无所谓的心态。[p]


[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/10.png"  ]
[tb_start_text mode=1 ]
#德比伦
明明可以展现自己最厉害的一面，[r]
狠狠反击他们一次不就完事了嘛！[p]


[_tb_end_text]

[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/31.png"  ]
[tb_start_text mode=1 ]
#德比伦
……等到本大爷取回真姿，也要让那些混蛋明白。[r]
只要本大爷出手，就没有办不成的事情。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[chara_mod  name="でびるん"  time="0"  cross="false"  storage="chara/1/8.png"  ]
[tb_start_text mode=1 ]
#德比伦
[if exp="f.finished.length%3==2"][font size=50]走着瞧吧！[else]走着瞧吧……[font size=50]换人，下一个！[endif] [resetfont][p]
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
