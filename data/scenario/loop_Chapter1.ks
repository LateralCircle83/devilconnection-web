[_tb_system_call storage=system/_loop_Chapter1.ks]

*loop1

[tb_start_text mode=1 ]
#①玛尔斯①
[_tb_end_text]

[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/2.png"  width="779"  height="1072"  left="255"  top="-72"  reflect="false"  ]
[wait  time="500"  ]
[flash_off  time="800"  effect="fadeOut"  ]

[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/1.png"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
晚、[wait time=300]晚上好。[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]……[r]
[wait time=300]不好意思,这么晚来打扰你。[p]
我是索尔希艾尔魔法学校的班主任，玛尔斯。[r]
[wait time=300]那个……，你可能不记得了……[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/3.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
距离[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]你最后一次来校，已经过去整整一个月了。[r]
实在是放心不下，就过来看看情况……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
呃……，你的成绩确实优秀，猜测可能是对[r]
我的课程感到无聊，或因优秀而被周围人疏远……[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
如、[wait time=200]如果不嫌弃的话……，什么都可以和我商议的。[r]
请随时来学校找我吧。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/2.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=100]…………[resetdelay][p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
那、那么，就此告辞了。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#？？？①
[_tb_end_text]

[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="ashi.ogg"  ]
[wait  time="1500"  ]
[chara_hide  name="マルス"  time="0"  wait="false"  pos_mode="false"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[stopbgm  time="2000"  fadeout="true"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#？？？①
[delay speed=100]……[resetdelay]啪[p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[chara_move  name="プレイヤー"  anim="true"  time="1000"  effect="easeInCubic"  wait="false"  left="0"  top="250"  width="1280"  height="960"  ]
[tb_start_text mode=1 ]
#？？？①
库啪～[p]

[_tb_end_text]

[bgmovie  volume="0"  storage="kupya3.mp4"  skip="false"  loop="false"  ]
[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#库皮亚多艾露


[_tb_end_text]

[wait  time="5000"  ]
[stop_bgmovie  time="0"  ]
[bg  time="0"  method="fadeIn"  storage="kupya.webp"  ]
[playbgm  volume="50"  time="300"  loop="true"  storage="9_cupyadoel.ogg"  ]
[chara_show  name="クピャドエル"  time="500"  wait="false"  storage="chara/14/1.png"  width="1280"  height="960"  left="0"  top="-91"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[wait  time="500"  ]
[bg_layermode name="ring" folder="bgimage" storage="kupya2.webp" mode="screen" time="1000"]

[wait  time="2000"  ]
[chara_move  name="プレイヤー"  anim="true"  time="1000"  effect="easeInCubic"  wait="false"  left="0"  top="0"  width="1280"  height="960"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
晚上好呀～[r]
在下爱之天使，库皮亚多艾露。[p]


[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/4.png"  ]
[tb_start_text mode=4 ]
#库皮亚多艾露
虽然很是冒昧……，但请问您是否有藏匿恶魔！？[wait time=500]

[_tb_end_text]

[choice2 text1="点头" target1="*yes" text2="……" target2="*no" y="500"]

[s  ]
*yes

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/2.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
诚实是种美德。[wait time=300][r]
[l]那，[wait time=100]……您是否知晓他的真名？[p]


[_tb_end_text]

[jump  storage=""  target="*yes_jump"  ]
*no

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/2.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
无需隐瞒，身为天使，一切真相皆逃不过我的目光。[wait time=300][r]
[l]那，[wait time=100]……您是否知晓他的真名？[p]


[_tb_end_text]

*yes_jump

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=300]……[resetdelay]不过，想必您也确实无从得知。[r]
[wait time=200]然而，此事对您而言，仍是必须了解的。[p]

[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/4.png"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
……那只恶魔是个麻烦，若不尽早处理，[r]
迟早会给您……[wait time=300]不，会给这个世界带来无法估量的灾难。[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/2.png"  ]
[tb_start_text mode=4 ]
#库皮亚多艾露
因此，咱想向您提出一个建议。[wait time=300]愿与咱携手，[r]
[wait time=100]共同缉捕那只恶魔吗？[wait time=500]
[_tb_end_text]

[choice2 text1="同意协助" target1="*suru" text2="拒绝协助" target2="*shinai" y="500"]

[s  ]
*suru

[tb_start_text mode=1 ]
#库皮亚多艾露
他本就是个怠惰之徒，[r]
[wait time=200]趁其松懈之时将其擒获，实在不算难事。[p]
哪怕仅能再拯救一位，像您这样的迷途羔羊，[r]
亦是咱身为天使的职责所在……[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/2.png"  ]
[camera  time="15000"  zoom="1.5"  wait="false"  layer="0"  x="0"  y="90"  rotate="0"  ease_type="ease"  ]
[stopbgm  time="2000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
接下来，咱将悄然隐于您的长袍之中，[r]
请务必与往常无异，不要流露出丝毫破绽喔♪[p]

[_tb_end_text]

[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[free_bg_layermode name="ring" time="500"]

[reset_camera  time="10"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="fuku.ogg"  ]
[wait  time="2000"  ]
[chara_hide  name="クピャドエル"  time="0"  wait="false"  pos_mode="false"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
慢死了，[wait time=200]真是的，你搞什么搞到现在[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="0"  fadeout="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_hide  name="ベッド"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/2_b.png"  width="1140"  height="855"  left="108"  top="-2"  reflect="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=63]库啪～❤︎[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/1_b.png"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="8_gag.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]多……多艾露！？[wait time=200][r]
你怎么会出现在这里。[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
呼呼呼……，咱是顺着德比君的行踪找到这里的喔！[wait time=200][r]
这次可不会让您逃掉了啦♥[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/3_b.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]嘿、嘿呀！[wait time=300]这、这个……[r]
放……放开我……[resetfont][p]


[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="ベッド"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/4_b.png"  width="340"  height="600"  left="-2"  top="213"  reflect="false"  ]
[wait  time="40"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]哒呀！[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="kupya_fuki_show" layer="1" x="234" y="196" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマえる"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/21/8.png"  width="383"  height="400"  left="234"  top="196"  reflect="false"  ]
[tb_start_tyrano_code]
[free_apng name="kupya_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
库啪？[wait time=300]很抱歉让您看到了咱不雅的一面。[r]
身为天使，[wait time=100]让所有人幸福是在下的职责[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/6.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
但是，恶魔可不在此范畴内呢！[p]
因此，咱就把追踪他的去向[r]
当作是日常的舒压工具啦♥[p]



[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[camera  time="1000"  zoom="1.1"  wait="false"  layer="layer_camera"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=60]堕落吧！[r]
你这屑天使！！[resetfont][p]


[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/7.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
稍后咱会给您塞住嘴巴哦[delay speed=100]……[resetdelay]❤︎[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/5.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
感谢您的配合。[wait time=300]如此，今日暂且告一段落。[r]
库啪～[delay speed=100]……[resetdelay]，祝您永享幸福[delay speed=100]……[resetdelay][p]



[_tb_end_text]

[reset_camera  time="5000"  wait="false"  layer="layer_camera"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=95]救[delay speed=100]……[resetdelay]命啊啊啊啊啊啊啊！[resetfont][p]


[_tb_end_text]

[chara_hide  name="コマえる"  time="0"  wait="false"  pos_mode="false"  ]
[tb_eval  exp="sf.END10=1"  name="END10"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.kupya_kyo=1"  name="kupya_kyo"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[collect_character name="クピャドエル"]

[ending no="10"]

[s  ]
[comment  c="話の都合上、絶対にクピャENDを通らせる"  ]
*shinai_1

[tb_start_text mode=1 ]
#库皮亚多艾露
哪怕仅能再拯救一位，像您这样的迷途羔羊，[r]
亦是咱身为天使的职责所在……[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]倘若您不愿协助，倒也无妨。毕竟，[r]
如今的德比君于咱而言，不过是轻而易举便能制伏的小兽罢了。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[stopbgm  time="2000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
那么……[r]
今日便告辞了。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[tb_hide_message_window  ]
[free_bg_layermode name="ring" time="500"]

[reset_camera  time="10"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[wait  time="2000"  ]
[chara_hide  name="クピャドエル"  time="0"  wait="false"  pos_mode="false"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
慢死了，[wait time=200]真是的，你搞什么搞到现在[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="0"  fadeout="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_hide  name="ベッド"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/2_b.png"  width="1140"  height="855"  left="108"  top="-2"  reflect="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=63]库啪～❤︎[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/1_b.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="8_gag.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]多……多艾露！？[wait time=200][r]
你怎么会出现在这里。[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
呼呼呼……，咱是顺着德比君的行踪找到这里的喔！[wait time=200][r]
这次可不会让您逃掉了啦♥[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/3_b.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]嘿、嘿呀！[wait time=300]这、这个……[r]
放……放开我……[resetfont][p]


[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="ベッド"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/4_b.png"  width="340"  height="600"  left="-2"  top="213"  reflect="false"  ]
[wait  time="40"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]哒呀！[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="kupya_fuki_show" layer="1" x="234" y="196" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[chara_show  name="コマえる"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/21/8.png"  width="383"  height="400"  left="234"  top="196"  reflect="false"  ]
[tb_start_tyrano_code]
[free_apng name="kupya_fuki_show" ]
[_tb_end_tyrano_code]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
库啪？[wait time=300]很抱歉让您看到了咱不雅的一面。[r]
身为天使，[wait time=100]让所有人幸福是在下的职责[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/6.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
但是，恶魔可不在此范畴内呢！[p]
因此，咱就把追踪他的去向[r]
当作是日常的舒压工具啦♥[p]



[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[camera  time="1000"  zoom="1.1"  wait="false"  layer="layer_camera"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=60]堕落吧！[r]
你这屑天使！！[resetfont][p]


[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="1000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/7.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
稍后咱会给您塞住嘴巴哦[delay speed=100]……[resetdelay]❤︎[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" y="-10"]
[frame p="50%" y="0"]
[frame p="100%" y="-1"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="400" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/5.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
能够守护世界的安宁，实乃天大的欣慰。[wait time=300]如此，今日暂且告一段落。[r]
库啪～[delay speed=100]……[resetdelay]，祝您永享幸福[delay speed=100]……[resetdelay][p]



[_tb_end_text]

[reset_camera  time="5000"  wait="false"  layer="layer_camera"  ]
[tb_start_text mode=1 ]
#德比伦
[font face="DZUYOKU"][font size=95]救[delay speed=100]……[resetdelay]命啊啊啊啊啊啊啊！[resetfont][p]


[_tb_end_text]

[tb_eval  exp="f.kupya_kyo=0"  name="kupya_kyo"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_eval  exp="sf.END10=1"  name="END10"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[collect_character name="クピャドエル"]

[ending no="10"]

[s  ]
*shinai

[jump  storage="loop_Chapter1.ks"  target="*shinai_1"  cond="sf.END10!=1"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
他本就是个怠惰之徒，[r]
[wait time=300]趁其松懈之时将其擒获，实在不算难事。[p]
哪怕仅能再拯救一位，像您这样的迷途羔羊，[r]
亦是咱身为天使的职责所在……[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]即便如此，若您依然希望维持与那位恶魔的牵绊，[r]
咱也会尊重您的意愿，绝不干涉。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/4.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
但关于他的真名……[r]
若有可能，咱亦愿尽力相助。[p]
往后咱将于言辞间点缀些许提示。[r]
倘若您察觉到任意违和之处，还请想起今日之言。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
若您有任何需要，[r]
请随时呼唤爱之天使，库皮亚多艾露。[p]
库啪～[delay speed=100]……[resetdelay][r]
祝您永享幸福[delay speed=100]……[resetdelay][p]

[_tb_end_text]

[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="1000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[free_bg_layermode name="ring" time="1000"]

[chara_hide  name="クピャドエル"  time="500"  wait="false"  pos_mode="false"  ]
[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[wait  time="2500"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[jump  storage="Chapter1.ks"  target="*loop_back_bed"  ]
*loop2

[stopbgm  time="3000"  fadeout="true"  ]
[chara_show  name="クピャドエル"  time="500"  wait="false"  storage="chara/14/13.png"  width="1280"  height="960"  left="0"  top="-91"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[wait  time="500"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="500"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
哈啊……哈啊……[emb exp="f.name"]！[p]


[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
……待咱回过神来时，便已置身于灵魂之泉，[r]
正注视着将德比君吞噬殆尽的魔法阵。[p]


[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/14.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
因此，那个，咱想表达的是……[r]
那些发生过的事情，其实……咱一件也未曾忘却。[p]



[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/13.png"  ]
[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[wait  time="100"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
德比君化作异形的姿态，[if exp="f.bel_name_first>0"][if exp="f.BBB_kidoku == 1"]被吞噬而丧失记忆，[else]身着婚纱时那痛苦难耐的表情，[endif][else]只剩下一只眼睛的形体，[endif]全部……[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[emb exp="f.name"]明明已经将这些记忆重置抹除，[r]
……咱却全数继承下来！[p]



[_tb_end_text]

[comment  c="bel_name_firstが2になった週だけ*bel_name_firstにジャンプする"  ]
[jump  storage="loop_Chapter1.ks"  target="*bel_name_first"  cond="f.bel_name_first==2"  ]
[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/14.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
……仅仅是回想起来，胸口便仿佛被重压般揪紧。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/15.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
但是，多亏了[emb exp="f.name"]您的魔法，[r]
现在的德比君依然安然无恙，精神如常！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]太好了。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
这次一定要查出他的真实之名，[r]
务必将德比君从命运之中解救出来！[p]
[_tb_end_text]

*bel_name_first_jump

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]既然如此，[p]
[_tb_end_text]

[bg_layermode name="ring" folder="bgimage" storage="kupya2.webp" mode="screen" time="1000"]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/5.png"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="9_cupyadoel.ogg"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
咱也将以能够洞察「真相」的双眸－－「真视之眼」，[r]
为您探寻幸福的可能性献上拙见！[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/4.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
……此前未予以说明，还请见谅。腹部的这只眼睛，[r]
具备洞见过去与未来真相的能力。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
先前在床上抓住德比君之时，也确实观测到[r]
[emb exp="f.name"]您读取存档的真实。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
由于咱仅是对真实本身进行观测，并未保留事件内容的记忆。[r]
正因如此，咱才能察觉到您曾以读档之力将时间线重置。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
然而，您读档与存档的能力，[r]
其检查点似乎是停留在召唤德比君的前一刻……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
似乎每当咱在那个位置重生之时，[r]
便会连带保留此前所有的记忆。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
诚然神秘难解……，但若能以天使之身[r]
助您一臂之力，实乃吾之幸事。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/6.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
……虽如此，但以如今真视之眼的精度，[r]
尚不足以洞见德比君的真正名称。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
唔……。截至目前，咱能看见的幸福可能性共有[font color=0xEC6FC5 bold=true]30[resetfont]种呢。[r]
而到目前为止，已经寻见的大概就[font color=0xEC6FC5 bold=true][emb exp="dc.endCount()"][resetfont]种左右……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
想必[emb exp="f.name"]的[font color=0xEC6FC5 bold=true]结局记录[resetfont]一览表，或许也能成为重要的线索……[p]
[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0xFFFFFF"  ]

[free_bg_layermode name="ring" time="300"]

[bg  time="0"  method="crossfade"  storage="kupya.webp"  ]
[chara_hide  name="クピャドエル"  time="0"  wait="false"  pos_mode="false"  ]
[wait  time="50"  ]
[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/20.png"  width="568"  height="781"  left="352"  top="57"  reflect="false"  ]
[chara_show  name="クピャドエル"  time="0"  wait="false"  storage="chara/14/1.png"  width="1280"  height="960"  left="0"  top="-91"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[wait  time="50"  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hirameki.ogg"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
库啪……！似乎逗留得有些过久！[r]
那么，先行告退。[p]
[_tb_end_text]

[playse  volume="100"  time="1000"  buf="4"  storage="kieru2.ogg"  ]
[chara_hide  name="クピャドエル"  time="1000"  wait="false"  pos_mode="false"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
若是有任何事情，[r]
随时鸣响铃兰之铃唤咱便好～[p]
[_tb_end_text]

[tb_hide_message_window  ]
[stopbgm  time="0"  ]
[wait  time="1000"  ]
[l  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
啊、那个[delay speed=100]……[resetdelay][emb exp="f.name"][delay speed=100]……[resetdelay][r]
刚刚[delay speed=100]……[resetdelay]好像看到天使来迎接了。[p]
[_tb_end_text]

[tb_eval  exp="f.marusu_tenshi=1"  name="marusu_tenshi"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/3.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
你、你还活着吗？[r]
哦哦，还活着啊。太好了[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/22.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
那个[delay speed=100]……[resetdelay]，突然冒昧打扰，实在抱歉。[r]
我是索尔希艾尔魔法学校的班主任，玛尔斯。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=100]……[resetdelay]呃[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/21.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[font size=50]啊！你有任何事情[r]
都可以与我商议！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
所以啊[delay speed=100]……[resetdelay]请不要冲动！[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/2.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=100]…………[resetdelay][p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=100]……[resetdelay]你可以随时来[r]
学校找我。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
那么，就此告辞了。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[chara_hide  name="マルス"  time="0"  wait="false"  pos_mode="false"  ]
[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[wait  time="2500"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
慢死了，[emb exp="f.name"]。[wait time=300][r]
喂，你口袋里装着啥玩意？[p]

[_tb_end_text]

[image name="ベル" layer=0  time="500"  wait="false"   folder="image" storage="bell/fuki.png"  width="294"  height="258"  left="132"  top="194"  reflect="false"  ]

[tb_start_tyrano_code]
[keyframe name="item"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="ベル" keyframe="item" count="infinite" time="1500" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
喏，就是那个[font color=0xEC6FC5 bold=true]铃铛[resetfont][delay speed=100]……[resetdelay]，难道是玄关的那个坏掉了？[r]
[l]嘛，就先丢到召唤间的桌上吧。[p]


[_tb_end_text]

[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/4.png"  ]
[free name="ベル"  layer=0 time="500"  wait="false"]

[tb_start_text mode=1 ]
#德比伦
说起来啊，刚才无意中听见你们的对话了[delay speed=100]……[resetdelay][p]


[_tb_end_text]

[stopbgm  time="1000"  fadeout="true"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="0"  y="30"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="1"  y="30"  ]
[camera  time="8000"  zoom="1.15"  wait="false"  layer="base"  y="30"  ]
[tb_start_text mode=1 ]
#德比伦
你……[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[reset_camera  time="10"  wait="false"  ]
[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/7.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=63]是要去寻短见吗！[resetfont][p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/6.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
要是活腻了，就赶紧把灵魂和魔力全献出来。[r]
不然，就把当本大爷的下仆，作为你活下去的意义。[p]
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/4.png"  ]
[tb_start_text mode=4 ]
#德比伦
……怎么？难不成你召唤本大爷，[r]
还有别的目的？[wait time=500]
[_tb_end_text]

[jump  storage="Chapter1.ks"  target="*loop_back_select"  ]
*bel_name_first

[memory name="bel_name_first" val="1"]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/14.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]咱以为查出了德比君的真名[r]
就能阻止其暴走。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=300]……[resetdelay]但是，[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/12.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
那样的结果[delay speed=100]……[resetdelay][r]
一定不是德比君所期待的呢。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/15.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]不过太好了！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
这次，一定能救回德比君了！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
为此，咱必须不断地探求更多的结局，[r]
以期从中找出诸位通往幸福的可能性。[p]
[_tb_end_text]

[jump  storage="loop_Chapter1.ks"  target="*bel_name_first_jump"  cond=""  ]
*loop3

[tb_start_text mode=1 ]
#①玛尔斯①
[_tb_end_text]

[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/2.png"  width="779"  height="1072"  left="255"  top="-72"  reflect="false"  ]
[wait  time="500"  ]
[flash_off  time="800"  effect="fadeOut"  ]

[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/1.png"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
晚、晚上好。[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]……[r]
这么晚打扰您，实在抱歉。[p]
我是索尔希艾尔魔法学校的班主任，玛尔斯。[r]
[wait time=100]那个……，你可能不记得了……[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/3.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
距离[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]你最后一次来校，已经过去整整一个月了。[r]
实在是放心不下，就过来看看情况……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
呃……，你的成绩确实优秀，猜测可能是对[r]
我的课程感到无聊，或因优秀而被周围人疏远……[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
如果不嫌弃的话……，什么都可以和我商议。[r]
请随时来学校找我吧。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/2.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=100]…………[resetdelay][p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
那、那么，就此告辞了。[p]
[_tb_end_text]

[stopbgm  time="2000"  fadeout="true"  ]
[tb_hide_message_window  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[_tb_end_text]

[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="ashi.ogg"  ]
[wait  time="1500"  ]
[chara_hide  name="マルス"  time="0"  wait="false"  pos_mode="false"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[comment  c="bel_nameが2になった週だけ*bel_nameにジャンプする"  ]
[jump  storage="loop_Chapter1.ks"  target="*bel_name"  cond="f.bel_name==2"  ]
[playbgm  volume="50"  time="300"  loop="true"  storage="9_cupyadoel.ogg"  ]
[chara_show  name="クピャドエル"  time="500"  wait="false"  storage="chara/14/1.png"  width="1280"  height="960"  left="0"  top="-91"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[bg_layermode name="ring" folder="bgimage" storage="kupya2.webp" mode="screen" time="1000"]

[wait  time="500"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
晚上好呀。如您所知，[r]
咱是爱之天使，库皮亚多艾露。[p]

[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/17.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
这是您[r]
第[emb exp="f.currentLoop-1"]次重新开始了呢。[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay][if exp="f.bel_name==1||f.bel_name_first==1"]没关系[else]真正名字[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[if exp="f.bel_name==1||f.bel_name_first==1"]大家一定能迎来属于自己的幸福结局。[r]
让我们一同探寻那份可能吧。[else]一定要查明德比君的真名，[r]
我们携手将他从命运中解救出来吧。[endif][p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/4.png"  ]
[tb_start_tyrano_code]
[if exp="f.currentLoop == 3"]
#库皮亚多艾露
为此，还请与我并肩同行，一起努力！[r]
[emb exp="f.name"]
[elsif exp="f.currentLoop == 4"]
#库皮亚多艾露
咱亦会尽力搜寻线索，[r]
还请与我协力同行！
[elsif exp="f.currentLoop == 5"]
#库皮亚多艾露
此事我希望能随时向您确认，[r]
今后也请继续与咱携手合作吧！[emb exp="f.name"]
[elsif exp="f.currentLoop == 6"]
#库皮亚多艾露
下一次必能成功。请您切莫放弃，[r]
与咱携手继续努力吧！[emb exp="f.name"]
[else]
下次一定会……，请您莫气馁，[r]
与咱共同协力前行吧！[emb exp="f.name"]
[endif]
[wait time=500]
[_tb_end_tyrano_code]

[choice2 text1="点头" target1="*suru_loop" text2="……" target2="*shinai_loop" y="500"]

[s  ]
*suru_loop

[comment  c="END11を踏んでいたらkupya_ninchiを1にする（踏まない場合は0のまま先に進む）"  ]
[memory name="kupya_ninchi" val="1" cond="sf.endings.includes('11')"]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[tb_start_tyrano_code]
[if exp="f.currentLoop == 3"]
#库皮亚多艾露
耶耶欧，加油～！[r]
[delay speed=100]……[resetdelay]！
[elsif exp="f.currentLoop == 4"]
#库皮亚多艾露
没错没错！[r]
就是这股气势！
[elsif exp="f.currentLoop == 5"]
#库皮亚多艾露
[delay speed=100]……[resetdelay]无论要重来多少次，「想要拯救」的这份心意[r]
咱绝不愿忘却。
[elsif exp="f.currentLoop == 6"]
#库皮亚多艾露
[delay speed=100]……[resetdelay]您也愿意不放弃，坚持到现在。[r]
这对咱而言，也是莫大的支撑。
[elsif exp="f.currentLoop == 7"]
#库皮亚多艾露
[emb exp="f.name"]的话，[delay speed=100]……[resetdelay][r]
一定会没问题的。
[elsif exp="f.currentLoop == 8"]
#库皮亚多艾露
[delay speed=100]……[resetdelay]心怀希望，继续前行！
[else]
[delay speed=100]……[resetdelay]真是太好了！
[endif]
[wait time=500][p]
[_tb_end_tyrano_code]

*bel_name_end

[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="1000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[free_bg_layermode name="ring" time="1000"]

[chara_hide  name="クピャドエル"  time="500"  wait="false"  pos_mode="false"  ]
[wait  time="1000"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[wait  time="1500"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[jump  storage="Chapter1.ks"  target="*loop_back_bed"  ]
*bel_name

[memory name="bel_name" val="1"]

[wait  time="500"  ]
[chara_move  name="プレイヤー"  anim="true"  time="1000"  effect="easeInCubic"  wait="false"  left="0"  top="0"  width="1280"  height="960"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]看来您已经顺利查明[r]
德比君的真名了呢。[p]
[_tb_end_text]

[chara_show  name="クピャドエル"  time="500"  wait="false"  storage="chara/14/12.png"  width="1280"  height="960"  left="0"  top="-91"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=300]……[resetdelay]但是……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
但是那样的结果[delay speed=100]……[resetdelay][r]
这并非是德比君所期待的那样呢。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/13.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=50][delay speed=300]……[resetdelay]让我们再来一次吧！[resetfont][p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/14.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
无论多少次，我们都能重新来过！[r]
也正因如此，大家能够获得幸福的可能性，必定尚在。[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/15.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]所以，没问题的！[r]
咱也会一直伴您左右。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
不管是德比君，[emb exp="f.name"]，还是其他的人。[delay speed=100]……[resetdelay][r]
我们都要为所有人的幸福而共同奋斗！[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[tb_start_text mode=4 ]
#库皮亚多艾露
库啪，一起努力吧。[r]
[emb exp="f.name"]……[wait time=500]
[_tb_end_text]

[choice2 text1="点头" target1="*tugi" text2="……" target2="*shinai_loop" y="500"]

[s  ]
*tugi

[jump  storage="loop_Chapter1.ks"  target="*bel_name_end"  ]
*shinai_loop

[jump  storage="loop_Chapter1.ks"  target="*END11_kidoku"  cond="f.kupya_ninchi==1"  ]
[tb_hide_message_window  ]
[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[playse  volume="100"  time="1000"  buf="1"  storage="hirameki.ogg"  loop="false"  ]
[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/1.png"  ]
[wait  time="100"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[wait  time="1000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=300]！……[resetdelay]看来您找到了某种方法[r]
甚至无需天使之力的协助呢！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
若如此……[delay speed=100]……[resetdelay]那真是太好了。[r]
咱由衷祈愿一切顺利。[p]
[_tb_end_text]

[tb_hide_message_window  ]
[jump  storage="loop_Chapter1.ks"  target="*END11_bed"  ]
*END11_kidoku

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
又[delay speed=100]……[resetdelay]来了吗？[p]
[_tb_end_text]

[chara_mod  name="クピャドエル"  time="0"  cross="false"  storage="chara/14/6.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
没、没关系的。因为连咱自己……[r]
也沉浸在这短暂的甜美之中了。[p]
[_tb_end_text]

[stopbgm  time="1000"  fadeout="true"  ]
[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=100]……[resetdelay]所以，请去吧。[p]
[_tb_end_text]

[tb_hide_message_window  ]
*END11_bed

[flash  time="1000"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="1000"  fadeout="true"  ]
[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[wait  time="1000"  ]
[free layer=4 name="kuro" time="0"  ]

[free_bg_layermode name="ring" time="0"]

[chara_hide  name="クピャドエル"  time="500"  wait="false"  pos_mode="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
慢死了，[wait time=200]真是的，你搞什么搞到现在[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[stopbgm  time="0"  fadeout="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/12.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te2.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#德比伦
[font size=75]哈啊！？[resetfont][p]


[_tb_end_text]

[playbgm  volume="60"  time="0"  loop="true"  storage="8_gag.ogg"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/32.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=75]你，你要干什么！？[r]
快把那根法杖收起来！[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
每次偷偷用邪眼探查瞄你一眼的时候，[r]
发现你满脑子想的都是本大爷，感觉超恶心。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
现在本大爷的力量还未能完全释放，[r]
你怕不是打算趁机用擅长的魔法来收拾本大爷吧！[p]
[_tb_end_text]

[tb_filter_invert  layer="all"  invert="100"  time="200"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/fu_te2.png"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/50.png"  ]
[playse  volume="100"  time="0"  buf="4"  storage="panpu2.ogg"  ]
[stopbgm  time="0"  fadeout="false"  ]
[tb_hide_message_window  ]
[tb_chara_shake  name="コマでび"  direction="x"  count="2"  swing="10"  time="100"  ]
[wait  time="200"  ]
[tb_free_filter  layer="undefined"  time="200"  ]
[wait  time="3300"  ]
[tb_show_message_window  ]
[tb_start_tyrano_code]
[keyframe name="fuwakoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマでび" keyframe="fuwakoma" count="infinite" time="300" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="プレイヤー"  time="80"  cross="false"  storage="chara/2/te.png"  ]
[chara_move  name="プレイヤー"  anim="true"  time="3000"  effect="easeInCubic"  wait="false"  left="0"  top="120"  width="1280"  height="960"  ]
[tb_start_text mode=1 ]
#德比伦
啊[delay speed=100]……[resetdelay]呀[delay speed=100]……[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[emb exp="f.name"][delay speed=100]……[resetdelay][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[delay speed=100]留在我……身边吧……[resetdelay][p]


[_tb_end_text]

[camera  time="6000"  zoom="1.3"  wait="false"  layer="layer_camera"  y="50"  ]
[camera  time="6000"  zoom="1.2"  wait="false"  layer="1"  y="50"  ]
[tb_hide_message_window  ]
[wait  time="2000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
[delay speed=100]还要、还要……[resetdelay][p]

[_tb_end_text]

[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[tb_start_text mode=1 ]
#德比伦
[delay speed=100]这就是本大爷的……幸福。[resetdelay][p]

[_tb_end_text]

[reset_camera  time="0"  wait="false"  layer="layer_camera"  ]
[stopse  time="0"  buf="5"  ]
[ending no="11"]

*end_complete

[hide_photo_button]

[stopbgm  time="1000"  fadeout="true"  ]
[wait  time="500"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="500"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
[emb exp="f.name"][delay speed=100]……[resetdelay][p]

[_tb_end_text]

[chara_show  name="クピャドエル"  time="1000"  wait="false"  storage="chara/14/18.png"  width="950"  height="712"  left="154"  top="25"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]……真实之眼的视野一片漆黑。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=200]已经什么都看不见了。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]……咱已经尽了全力。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]可依然毫无意义。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]无论多少次重来，都已无济于事。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]所有人皆可获得幸福的结局……[r]
从一开始便不曾存在过。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]铃兰之铃，也已经……不再需要了。[resetdelay][resetfont][p]
[_tb_end_text]

[layopt layer=4 visible="true"]

[playse  volume="50"  time="1000"  buf="1"  storage="Bell2.ogg"  ]
[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25][delay speed=100]……那么，先告辞了。[resetdelay][resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
[_tb_end_text]

[tb_hide_message_window  ]
[bg  time="0"  method="crossfade"  storage="kupya.webp"  ]
[chara_hide  name="クピャドエル"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/22.png"  width="568"  height="781"  left="352"  top="57"  reflect="false"  ]
[wait  time="3000"  ]
[tb_filter_blur  layer="all"  blur="10"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[emb exp="f.name"][if exp="f.seibetu == 1][else][endif][p]

[_tb_end_text]

[tb_hide_message_window  ]
[tb_free_filter  layer="undefined"  time="2000"  ]
[free layer=4 name="kuro" time="500"  ]

[wait  time="1000"  ]
[l  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
你，[wait time=300]你还好吗？[delay speed=100]……[resetdelay]？[r]
你的表情，看上去有些严肃呢。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/4.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
晚、[wait time=300]晚上好，很抱歉在这么晚来打扰你。[r]
我是索尔希艾尔魔法学校的班主任，玛尔斯。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
距离[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]你最后一次来校，已经是上个月的事情了。[r]
实在是放心不下，就过来看看情况……[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/22.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
那个[delay speed=300]……[resetdelay][p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/21.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[font size=50]如果可以的话，[r]
能让我听听你的烦恼吗！[resetfont][p]

[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/19.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
啊，总感觉好像提出了[r]
一个奇怪的请求。[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]只是……你看上去真的很难过，[r]
我想尽绵薄之力……[p]

[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/22.png"  ]
[tb_start_text mode=4 ]
#①玛尔斯①
那个[delay speed=100]……[resetdelay]当然，你也不必[r]
勉强自己说出来。[wait time=500]
[_tb_end_text]

[choice2 text1="说出" target1="*hanasu" text2="不说" target2="*hanasa" y="500"]

[s  ]
*hanasu

[tb_eval  exp="f.photoPose=0"  name="photoPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_hide_message_window  ]
[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="1000"  wait="false"  ]

[wait  time="3000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
竟、[wait time=300]竟然发生了这样的事情……！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
老实说……，一时间我都不知该如何措辞……[p]
[_tb_end_text]

[playse  volume="50"  time="0"  buf="1"  storage="ashi.ogg"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=500]……[resetdelay]但是[p]
[_tb_end_text]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="マルス"  time="1000"  wait="false"  pos_mode="false"  ]
[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/1_.png"  width="1280"  height="960"  ]
[tb_hide_message_window  ]
[free layer=4 name="kuro" time="500"  ]

[l  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
你真的，已经很努力了。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]，你十分勇敢。[r]
身为班主任，我真的为你感到骄傲。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/2_.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
虽、虽然我当班主任也不过一个学期……[r]
这么讲或许有点不自量力。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/1_.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
但是，[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]的话，我相信一定会没事的。[wait time=300][r]
呃、这句话听起来可能有些不负责任，[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
可是在现在的[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]身上……[r]
我能感受到一种非常强烈的意志。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
所以我相信，[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]你终有一日，会带着笑容[r]
出现在学校里。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=300]……[resetdelay]那么……[wait time=300]我们学校见。[p]
[_tb_end_text]

[jump  storage="loop_Chapter1.ks"  target="*hanasu_jump"  ]
*hanasa

[tb_eval  exp="f.photoPose=0"  name="photoPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[tb_hide_message_window  ]
[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="1000"  wait="false"  ]

[wait  time="500"  ]
[wait  time="1000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
即使这样也没关系的哟[p]
[_tb_end_text]

[playse  volume="50"  time="0"  buf="1"  storage="ashi.ogg"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
不过……[delay speed=300]……[resetdelay][p]
[_tb_end_text]

[tb_hide_message_window  ]
[chara_hide  name="マルス"  time="1000"  wait="false"  pos_mode="false"  ]
[chara_show  name="マルス"  time="0"  wait="false"  storage="chara/20/1_.png"  width="1280"  height="960"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[free layer=4 name="kuro" time="500"  ]

[l  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#①玛尔斯①
可以的话，请允许我给你一个拥抱。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/2_.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
我、我只能以这样的方式鼓励你……，哪怕能稍微给[r]
[emb exp="f.name"][if exp="f.seibetu == 1][else][endif]一点力量，我就很高兴了。[p]
[_tb_end_text]

[chara_mod  name="マルス"  time="0"  cross="false"  storage="chara/20/1_.png"  ]
[tb_start_text mode=1 ]
#①玛尔斯①
[delay speed=300]……[resetdelay]那么，再见。[p]
[_tb_end_text]

*hanasu_jump

[show_photo_button]

[tb_eval  exp="f.photoPose=1"  name="photoPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_hide_message_window  ]
[flash  time="500"  effect="fadeIn"  color="0x000000"  ]

[tb_start_text mode=1 ]
#德比伦
[_tb_end_text]

[chara_hide  name="マルス"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa2.ogg"  ]
[wait  time="2500"  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/6.png"  width="1140"  height="855"  left="62"  top="58"  reflect="false"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
慢死了，[emb exp="f.name"]。[wait time=300][r]
喂，你手里紧捏的那个东西是什么？[p]
[_tb_end_text]

[image name="ベル" layer=0  time="500"  wait="false"   folder="image" storage="bell/fuki.png"  width="294"  height="258"  left="132"  top="194"  reflect="false"  ]

[tb_start_tyrano_code]
[keyframe name="item"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="ベル" keyframe="item" count="infinite" time="1500" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
喏，就是那个[font color=0xEC6FC5 bold=true]铃铛[resetfont]……[p]


[_tb_end_text]

[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/4.png"  ]
[free name="ベル"  layer=0 time="500"  wait="false"]

[tb_start_text mode=1 ]
#德比伦
说起来啊，刚才无意中听见你们的对话了[delay speed=100]……[resetdelay][p]


[_tb_end_text]

[stopbgm  time="1000"  fadeout="true"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="0"  y="30"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="1"  y="30"  ]
[camera  time="8000"  zoom="1.15"  wait="false"  layer="base"  y="30"  ]
[tb_start_text mode=1 ]
#德比伦
你……[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[reset_camera  time="10"  wait="false"  ]
[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/7.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]哼，看样子你刚刚是在找人诉苦啊！[resetfont][p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/13.png"  ]
[tb_start_text mode=4 ]
#德比伦
真是没办法呢，本大爷也就特别破例[r]
听听你的烦恼吧！
[_tb_end_text]

[comment  c="差分2"  ]
*

[choice2 text1="想要朋友" target1="*a" text2="感到寂寞" target2="*a" y="500"]

[s  ]
*a

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/6.png"  ]
[tb_start_text mode=1 ]
#德比伦
哼！[delay speed=400]……[resetdelay][p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/30.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=25]那、那就破例给你从使魔[r]
升级到朋友也行……[resetfont][p]

[_tb_end_text]

[tb_hide_message_window  ]
[chara_show  name="TAP"  time="500"  wait="false"  storage="chara/18/TAP.png"  width="400"  height="200"  left="445"  top="9"  reflect="false"  ]
[clickable  storage="loop_Chapter1.ks"  x="469"  y="148"  width="339"  height="566"  target="*tap3"  _clickable_img=""  ]
[s  ]
*tap3

[flash  time="50"  effect="fadeIn"  color="0x000000"  ]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="mp.ogg"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/4.png"  ]
[chara_hide  name="TAP"  time="500"  wait="false"  pos_mode="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
啥？你还有意见？[p]
[_tb_end_text]

[tb_hide_message_window  ]
[chara_show  name="TAP"  time="500"  wait="false"  storage="chara/18/TAP.png"  width="400"  height="200"  left="445"  top="9"  reflect="false"  ]
[clickable  storage="loop_Chapter1.ks"  x="469"  y="148"  width="339"  height="566"  target="*tap4"  _clickable_img=""  ]
[s  ]
*tap4

[flash  time="50"  effect="fadeIn"  color="0x000000"  ]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="mp.ogg"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/32.png"  ]
[chara_hide  name="TAP"  time="500"  wait="false"  pos_mode="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[playse  volume="100"  time="0"  buf="4"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
草！刚才那句不算！[r]
混蛋，竟敢拿本大爷开涮！[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
快、快给本大爷把灯关了！[p]

[_tb_end_text]

[tb_hide_message_window  ]
[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="200"  wait="false"  ]

[playse  volume="100"  time="0"  buf="1"  storage="off.ogg"  ]
[stopbgm  time="3000"  fadeout="true"  ]
[wait  time="1000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
[delay speed=400]……[resetdelay]乖乖听话这点倒是值得表扬。[r]
你这使魔，滚去地板上睡！[p]

[_tb_end_text]

[jump  storage="Chapter1.ks"  target="*lapis_jump"  ]
