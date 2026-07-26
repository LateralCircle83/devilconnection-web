[_tb_system_call storage=system/_omake_yume_kupya.ks]

[cm  ]
[tb_ptext_hide  time="0"  ]
[tb_image_hide  time="0"  ]
[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="開発陣"  time="0"  wait="false"  storage="chara/79/2.png"  width="668"  height="675"  left="298"  top="20"  reflect="false"  ]
[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="false"  time="0"  wait="false"  video="kiri2.mp4"  ]
[bg_layermode  name="mahou"  folder="bgimage"  storage="haikei_mahou_Small.webp"  mode="color-dodge"]

[lbgm str="3_connection_communication.ogg" vol="50" loop="true" time="0" buf="0"]

[call  storage="maku.ks"  target="*open"  ]
[flash_off  time="500"  effect="fadeOut"  ]

[wait  time="700"  ]
[free_bg_layermode  name="mahou"  time="5000"  ]

[tb_start_text mode=1 ]
#Babichao
[_tb_end_text]

[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#Babichao
[font size=50]Chao！[resetfont][p]
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
你、你谁啊……[p]
[_tb_end_text]

[camera  time="5000"  zoom="1.3"  wait="false"  y="60"  layer="base"  ]
[camera  time="5000"  zoom="1.5"  wait="false"  y="60"  layer="0"  ]
[camera  time="5000"  zoom="1.5"  wait="false"  y="60"  layer="1"  ]
[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/1.png"  ]
[tb_start_text mode=1 ]
#Babichao
那个[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[reset_camera  time="10"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/2.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#Babichao
恶魔连结，您玩的还开心吗！？[p]

[_tb_end_text]

[tb_hide_message_window  ]
[eval exp="f.zyagan_count = 0"]

*zyagan1_modoru

[choice2 text1="点头" target1="*yes" text2="……" target2="*no"]

[zyagan target="*zyagan1,*zyagan1_2serihu" borders="106, 124, 142, 160" focus="開発陣"]

[s  ]
*zyagan1

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan_player.ks"  target=""  ]
[tb_start_text mode=1 ]
#Babichao
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/3.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te.png"  ]
[bg  time="0"  method="crossfade"  storage="player_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#Babichao
毕竟连全部结局都收集齐了，[r]
没有理由不开心的！[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/4.png"  ]
[tb_start_text mode=1 ]
#Babichao
[delay speed=100]……[resetdelay]对吧？[p]
[_tb_end_text]

[jump  storage="omake_yume_kupya.ks"  target="*zyagan1_modoru_2"  ]
*zyagan1_2serihu

[mp_check]

[s  cond="!f.mp_check_pass"  ]
[call  storage="zyagan_player.ks"  target=""  ]
[tb_start_text mode=1 ]
#Babichao
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/5.png"  ]
[bg  time="0"  method="crossfade"  storage="player_zyagan_Small.webp"  ]
[call  storage="me.ks"  target="*meopen"  ]
[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#Babichao
如果是你为了观察差分而沉默不语，那倒也可以原谅。[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="ka-.ogg"  ]
[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/6.png"  ]
[tb_start_text mode=1 ]
#Babichao
届时，我会拼尽全力做出反应给你看的喔！！[p]
[_tb_end_text]

*zyagan1_modoru_2

[call  storage="me.ks"  target="*me_ENDtozi"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/2.png"  ]
[chara_show  name="コマでび"  time="0"  wait="true"  storage="chara/10/12.png"  width="383"  height="400"  left="7"  top="308"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[call  storage="me.ks"  target="*me_ENDake"  ]
[disable_menu_button]

[hide_photo_button]

[jump  storage="omake_yume_kupya.ks"  target="*zyagan1_modoru"  ]
*yes

[playse  volume="100"  time="0"  buf="1"  storage="kawaii.ogg"  ]
[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/9.png"  ]
[wait  time="500"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#Babichao
[delay speed=100]……[resetdelay]这个世界，是我的宝物。[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/2.png"  ]
[tb_start_text mode=1 ]
#Babichao
希望这个世界，还有这份回忆[delay speed=100]……[resetdelay][r]
也能成为你的宝物！[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/8.png"  ]
[tb_start_text mode=1 ]
#Babichao
啊，如果有你中意的孩子，或者感想什么的，[r]
都可以跟我说喔，我会很开心的呢。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/84_.png"  ]
[tb_start_text mode=1 ]
#德比伦
被你这么一讲……[r]
本大爷反而不想说了。[p]
[_tb_end_text]

[jump  storage="omake_yume_kupya.ks"  target="*po"  ]
*no

[chara_mod  name="開発陣"  time="0"  cross="false"  storage="chara/79/7.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="Horror.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#Babichao
[delay speed=100]……[resetdelay]你们可要记住，这一切由我的意愿所裁定。[r]
抹消它，也不过是一念之间。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/85.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="aseru.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
下、下一个！下一个！[p]
[_tb_end_text]

*po

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="開発陣"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="開発陣"  time="0"  wait="true"  storage="chara/79/10.png"  width="650"  height="708"  left="323"  top="6"  reflect="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/12.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="pon2.ogg"  ]
[wait  time="300"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#poshi
哈啊，修Bug修得累死了。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/115.png"  ]
[tb_start_text mode=1 ]
#德比伦
你是刚才那家伙的同伴吗……[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/11.png"  ]
[tb_start_text mode=1 ]
#poshi
若发现任何问题，请通过表单进行提交。[p]
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
啥啥？[r]
是害怕Bug吗～？[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/170.png"  ]
[tb_start_text mode=1 ]
#德比伦
喂喂，快用鼠标给他点爆，[r]
搞点Bug出来～！[p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_show  name="TAP"  time="300"  wait="false"  storage="chara/18/TAP_title.png"  width="400"  height="200"  left="443"  top="319"  reflect="false"  ]
[comment  c="↓ここから連打"  ]
[camera  time="6000"  zoom="1.1"  wait="false"  layer="layer_camera"  ease_type="ease"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/79.png"  ]
[iscript]
const time = 3
// タイマーセット
f.timerId = setTimeout(() => {
TYRANO.kag.ftag.startTag("jump",{target:"*failure"})
}, time * 1000)
tf.count = 10
[endscript]

[clickable  storage="omake_yume_kupya.ks"  width="650"  height="708"  x="323"  y="6"  target="*da"  cm="false"  _clickable_img=""  ]
[s  ]
*da

[eval exp="tf.count--"]

[quake  time="100"  count="2"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="2"  storage="mp.ogg"  ]
[jump  target="*success"  storage="omake_yume_kupya.ks"  cond="tf.count<=0"  ]
[s  ]
[comment  c="↑ここまで連打"  ]
*success

[cm  ]
[iscript]
clearTimeout(f.timerId)
[endscript]

[chara_hide  name="TAP"  time="100"  wait="false"  pos_mode="false"  ]
[reset_camera  time="300"  wait="false"  ]
[lbgmvol vol="0"]

[playse  volume="100"  time="0"  buf="1"  storage="bug.ogg"  ]
[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/11_.png"  ]
[bg  time="0"  method="crossfade"  wait="false"  storage="BG.webp"  ]
[wait  time="1000"  ]
[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/12_.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/67.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[lbgmvol vol="50"]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#poshi
[font size=50]喂，快停下！！！！[r]
这、这Bug是怎么回事！[resetfont][wait time=100][p]
[_tb_end_text]

[jump  storage="omake_yume_kupya.ks"  target="*a"  ]
*failure

[cm  ]
[chara_hide  name="TAP"  time="100"  wait="false"  pos_mode="false"  ]
[reset_camera  time="300"  wait="false"  ]
[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/12.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/12.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#poshi
[font size=50]喂！！！！！[resetfont][r]
快停下！！！！[wait time=100][p]
[_tb_end_text]

*a

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[bg  time="0"  method="crossfade"  storage="haikei_Small.webp"  ]
[chara_hide  name="開発陣"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="開発陣"  time="0"  wait="true"  storage="chara/79/14.png"  width="626"  height="682"  left="318"  top="32"  reflect="false"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/12.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[playse  volume="100"  time="0"  buf="1"  storage="pon2.ogg"  ]
[wait  time="500"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#星驱君
好美味～！[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/84_.png"  ]
[tb_start_text mode=1 ]
#德比伦
这次又是什么样的家伙。[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/15.png"  ]
[tb_start_text mode=1 ]
#星驱君
[font size=50][font face="KaiseiDecol-Bold"]这首曲子，还真就是得意之作呢～[resetfont][resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
莫非，就是你这家伙写的？[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/16.png"  ]
[tb_start_text mode=1 ]
#星驱君
是的喵！[p]

[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/21.png"  ]
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
真的～？[r]
要怎么证明？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#星驱君
嗯！既然机会难得，[r]
就请你们听听我创作这首曲子的过程吧～[p]


[_tb_end_text]

[tb_hide_message_window  ]
[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/17.png"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/74.png"  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[stopbgm  time="0"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="connection_communication_wip1.ogg"  ]
[layermode_movie  mode="screen"  speed="1"  volume="100"  loop="true"  time="0"  wait="false"  video="oto2.mp4"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
哦哦！声音在哔哔作响呢！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#星驱君
「以这种感觉为目标」，构思曲子的整体氛围，[r]
同时把大致的音符和节奏搭配好。[p]

[_tb_end_text]

[tb_hide_message_window  ]
[stopbgm  time="0"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="connection_communication_wip2.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#星驱君
接下来是这个～[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/146.png"  ]
[tb_start_text mode=1 ]
#德比伦
嗯哼。哔哔啵啵的音色又变回熟悉的样子了呢！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#星驱君
将草稿阶段写下的音符，[r]
替换成不同的乐器，再酌情添加一些～[p]

[_tb_end_text]

[tb_hide_message_window  ]
[free_layermode  time="1000"  wait="false"  ]
[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/16.png"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="3_connection_communication.ogg"  ]
[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/19.png"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#星驱君
再和刚才的节奏组合起来……[r]
锵～锵！这就是你们现在听到的完成版啦！[p]

[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/6.png"  ]
[tb_start_text mode=1 ]
#德比伦
哒呀～，真的呢！[r]
居然能编写出这么好听的曲子，太了不起了！[p]
[_tb_end_text]

[chara_mod  name="開発陣"  time="0"  cross="true"  storage="chara/79/14.png"  ]
[tb_start_text mode=1 ]
#星驱君
诶嘿嘿……，也希望你们今后可以[r]
多多欣赏我的作品呢。[p]
[_tb_end_text]

[chara_mod  name="コマでび"  time="0"  cross="false"  storage="chara/10/79.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]嘿，气氛一下子就上来了！[resetfont][p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="コマでび"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="開発陣"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[bg  time="0"  method="crossfade"  storage="Development.webp"  ]
[wait  time="100"  ]
[playse  volume="100"  time="0"  buf="1"  storage="pu.ogg"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#德比伦
[font size=80]YEAH～！[resetfont][p]
[_tb_end_text]

[tb_hide_message_window  ]
[stopbgm  time="10000"  fadeout="true"  ]
[flash  time="7000"  effect="fadeIn"  color="0x000000"  ]

[bg  time="0"  method="crossfade"  storage="kuro.webp"  ]
[call  storage="me.ks"  target="*meclose_kioku2"  ]
[wait  time="50"  ]
[chara_hide_all  time="0"  wait="true"  ]
[bg  time="0"  method="crossfade"  storage="w15.webp"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[stopbgm  time="0"  ]
[playse  volume="100"  time="0"  buf="5"  storage="tori2.ogg"  ]
[playse  volume="100"  time="0"  buf="2"  storage="hirameki.ogg"  ]
[call  storage="me.ks"  target="*meopen_kioku2"  ]
[disable_menu_button]

[wait  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[_tb_end_text]

[fadein_window  time="300"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
库啪[delay speed=100]……[resetdelay]方才，仿佛窥见了[r]
不该看到的真相。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
这、这只是个梦[delay speed=100]……[resetdelay]对吧？[p]
[_tb_end_text]

[tb_hide_message_window  ]
[stopbgm  time="1000"  fadeout="true"  ]
[jump  storage="collection_omake.ks"  target="*resume_to_ng"  ]
