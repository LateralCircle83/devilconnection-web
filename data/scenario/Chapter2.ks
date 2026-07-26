[_tb_system_call storage=system/_Chapter2.ks]

[call  storage="phase.ks"  target="*hide"  ]
[skipstop]

[disable_skip_button visible="true"]

[layopt layer=0 visible=true]

[tb_eval  exp="f.photoNonFixedPose=0"  name="photoNonFixedPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[hide_photo_button]

[cm  ]
[bg  time="0"  method="crossfade"  storage="haikei_bed.webp"  ]
[tb_start_tyrano_code]
[image name="hon1" layer="0" left="183" top="412" width="313" height="296" folder="image" storage="hon_zibun.png"]
[image name="hon2" layer="0" left="468" top="379" width="313" height="296" folder="image" storage="hon_lapis.png" cond="f.finished.includes('ラピス')"]
[image name="hon3" layer="0" left="787" top="428" width="313" height="296" folder="image" storage="hon_ramuru.png" cond="f.finished.includes('ネゼル')"]
[_tb_end_tyrano_code]

[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[wait  time="1500"  ]
*x

[tb_start_text mode=1 ]
#①
[_tb_end_text]

[tb_start_tyrano_code]
[position layer="message0" frame="Message2.png" height="265"]
[_tb_end_tyrano_code]

[fadein_window  time="1000"  ]
*hon_modoru

[tb_start_text mode=3 ]
#①
要读哪本书？[r]

[_tb_end_text]

[tb_start_tyrano_code]
[glink name="hon1" target="hon1_confirm" x="183" y="412" width="313" height="296" graphic="hon_zibun.png" enterimg="hon_zibun2.png" enterse="tap.ogg" clickse="OK.ogg"]
[glink name="hon2" target="hon2_confirm" x="468" y="379" width="313" height="296" graphic="hon_lapis.png" enterimg="hon_lapis2.png" enterse="tap.ogg" clickse="OK.ogg" cond="f.finished.includes('ラピス')"]
[glink name="hon3" target="hon3_confirm" x="787" y="428" width="313" height="296" graphic="hon_ramuru.png" enterimg="hon_ramuru2.png" enterse="tap.ogg" clickse="OK.ogg" cond="f.finished.includes('ネゼル')"]
[_tb_end_tyrano_code]

[s  ]
*hon1_confirm

[tb_start_text mode=3 ]
#①
自己的书　▶魔吉利西亚的种族◀[r]

[_tb_end_text]

[tb_start_tyrano_code]
[glink name="waku_small" font_color="white" target="*hon1" face="KaiseiDecol-Bold"  text="读" x="264" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[glink name="waku_small" font_color="white" target="*hon_modoru" face="KaiseiDecol-Bold"  text="不读" x="664" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[_tb_end_tyrano_code]

[s  ]
*hon1

[disable_menu_button]

[tb_start_tyrano_code]
[free name="hon1" layer="0"]
[free name="hon2" layer="0"]
[free name="hon3" layer="0"]
[_tb_end_tyrano_code]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon.mp4"  ]
[wait  time="500"  ]
[bg  time="0"  method="crossfade"  storage="20.webp"  ]
[stop_bgmovie  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/1.png"  width="1280"  height="960"  left=""  top=""  reflect="false"  ]
[tb_show_message_window  ]
[enable_skip_button visible="true"]

[tb_start_text mode=1 ]
#①
▶魔吉利西亚的种族◀[p]
这个名为魔吉利西亚的魔法世界里，[r]
主要存在着三大种族：[p]
没有语言的怪物　　魔物[p]
构筑文明的  　魔兽[p]
倚仗魔力与信仰维系存在的  　魔神[p]
[_tb_end_text]

[chara_hide  name="本"  time="100"  wait="false"  pos_mode="false"  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon_mekuru.mp4"  ]
[wait  time="200"  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/2.png"  width="1280"  height="960"  ]
[tb_start_text mode=1 ]
#①
魔神是一种以魔力为养分的灵体种族。[r]
精灵、天使、邪神等皆归类于此。[p]
■精灵……魔吉利西亚中央位置有个巨大的魔石柱，名为[r]
「彩虹之塔」。精灵是诞生于塔周围「灵魂之泉」的灵体种族。[p]
精灵通过与伙伴缔结契约作为自身的魔力供给源，并获取实体。[r]
同时也能与契约者共享魔力与能力。[p]
■天使……从邪神的魔爪中守护世界秩序的化身。[r]
每日的魔力供给取决于其在下界的功绩。[p]
天使身上所具备的「真视之眼」，能洞悉各种真相、[r]
引导众生，但想熟练驾驭极为困难。[p]
■邪神……栖息在魔力供应匮乏的异次元，[r]
属于混沌的存在。别称「恶魔」。[p]
故此，他们偶尔会潜入魔吉利西亚，[r]
通过各种手段来掠夺魔力。[p]
这些魔神们通过收集信仰与魔力，[r]
从而蜕变成更为强大的姿态。[p]
[_tb_end_text]

[jump  storage="Chapter2.ks"  target="*end_complete"  cond="f.end_complete==1"  ]
[jump  storage="Chapter2.ks"  target="*oi"  ]
*hon2_confirm

[tb_start_text mode=3 ]
#①
拉匹斯的书　▶魔界的七大恶魔◀[r]

[_tb_end_text]

[tb_start_tyrano_code]
[glink name="waku_small" font_color="white" target="*hon2" face="KaiseiDecol-Bold"  text="读" x="264" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[glink name="waku_small" font_color="white" target="*hon_modoru" face="KaiseiDecol-Bold"  text="不读" x="664" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[_tb_end_tyrano_code]

[s  ]
*hon2

[disable_menu_button]

[tb_start_tyrano_code]
[free name="hon1" layer="0"]
[free name="hon2" layer="0"]
[free name="hon3" layer="0"]
[_tb_end_tyrano_code]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon.mp4"  ]
[wait  time="500"  ]
[bg  time="0"  method="crossfade"  storage="20.webp"  ]
[stop_bgmovie  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/3.png"  width="1280"  height="960"  ]
[tb_show_message_window  ]
[enable_skip_button visible="true"]

[tb_start_text mode=1 ]
#①
▶魔界的七大恶魔◀[p]
[_tb_end_text]

[tb_start_text mode=1 ]
统领魔界大军的愤怒大将　撒旦[p]
[_tb_end_text]

[tb_start_text mode=1 ]
[font face="KaiseiDecol-Bold"]傲[resetfont]慢的恶魔　路西法[p]
[_tb_end_text]

[tb_start_text mode=1 ]
暴食之蝇　别西卜[p]
[_tb_end_text]

[tb_start_text mode=1 ]
燃烧嫉妒的苍蓝之炎　利维坦[p]
[_tb_end_text]

[tb_start_text mode=1 ]
祸端的招财猫　贪婪的玛门[p]
[_tb_end_text]

[tb_start_text mode=1 ]
魔界的天使　淫欲的阿斯莫德[p]
[_tb_end_text]

[tb_start_text mode=1 ]
沉眠于冬的怠惰　贝尔芬格[p]
[_tb_end_text]

[chara_hide  name="本"  time="100"  wait="false"  pos_mode="false"  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon_mekuru.mp4"  ]
[wait  time="200"  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/4.png"  width="1280"  height="960"  ]
[tb_start_text mode=1 ]
#①
以他们为首的魔界上级恶魔，会伺机爬到地表，[r]
为夺取魔力而使用邪神之力祸害众生。[p]
然而，邪神之力的过度滥用会使其不断地丧失自我，[r]
直至恶魔的本性完全显露。[p]
虽然下级恶魔会对大蒜退避三舍，[r]
但对高阶恶魔无效。[p]
[_tb_end_text]

[jump  storage="Chapter2.ks"  target="*end_complete"  cond="f.end_complete==1"  ]
[jump  storage="Chapter2.ks"  target="*oi"  ]
*hon3_confirm

[tb_start_text mode=3 ]
#①
奈泽尔的书　▶恶魔之力[font size=28]～名字与灵魂的深刻联系～[resetfont]◀[r]
[_tb_end_text]

[tb_start_tyrano_code]
[glink name="waku_small" font_color="white" target="*hon3" face="KaiseiDecol-Bold"  text="读" x="264" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[glink name="waku_small" font_color="white" target="*hon_modoru" face="KaiseiDecol-Bold"  text="不读" x="664" y="200" width="352" height="79" size="30" graphic="ui/waku_small.png" enterimg="ui/waku_small_.png" enterse="tap.ogg" clickse="OK.ogg"]
[_tb_end_tyrano_code]

[s  ]
*hon3

[disable_menu_button]

[tb_start_tyrano_code]
[free name="hon1" layer="0"]
[free name="hon2" layer="0"]
[free name="hon3" layer="0"]
[_tb_end_tyrano_code]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon.mp4"  ]
[wait  time="500"  ]
[bg  time="0"  method="crossfade"  storage="20.webp"  ]
[stop_bgmovie  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/5.png"  width="1280"  height="960"  ]
[tb_show_message_window  ]
[enable_skip_button visible="true"]

[tb_start_text mode=1 ]
#①
▶悪魔的力量[font size=28]～名字与灵魂的深刻联系～[resetfont]◀[p]
高阶大恶魔拥有邪眼、邪口、邪手等掌控第六感的部位，[r]
并以此来惑乱人心。[p]
与名号不详的恶魔缔结非正当契约后，便可驱使其力量。[r]
同时，力量本身亦将随之寄宿于契约者体内。[p]
此后，契约者的灵魂便被恶魔完全掌控，[r]
根据信仰的深浅，其力量或可延续至末代。[p]
亦有契约者不得不背负[r]
转生成为恶魔这样巨大的代价。[p]
[_tb_end_text]

[chara_hide  name="本"  time="100"  wait="false"  pos_mode="false"  ]
[playse  volume="100"  time="1000"  buf="4"  storage="hon_ake.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon_mekuru.mp4"  ]
[wait  time="200"  ]
[chara_show  name="本"  time="200"  wait="false"  storage="chara/26/6.png"  width="1280"  height="960"  ]
[tb_start_text mode=1 ]
#①
被非正当契约蚕食殆尽的魂魄，[r]
最终将被脖颈处的「灵魂骷髅」彻底吞噬。[p]
在一切变得不可挽回之前，[r]
唯有一种方法能切断恶魔的束缚。[p]
恶魔平日里以「化名」自称，[r]
而契约者必须亲自揭露其「真名」，方可斩断其力量。[p]
被道出真名的恶魔[r]
必将绝对服从于契约者，然后……[p]
[_tb_end_text]

[jump  storage="Chapter2.ks"  target="*end_complete"  cond="f.end_complete==1"  ]
[jump  storage="Chapter2.ks"  target="*oi"  ]
*oi

[tb_start_tyrano_code]
[position layer="message0" frame="Message.png" height="258"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
[font size=50]喂！[resetfont][p]
[_tb_end_text]

[chara_hide  name="本"  time="100"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[enable_menu_button]

[show_photo_button]

[playse  volume="100"  time="1000"  buf="1"  storage="fuku.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon_owari.mp4"  ]
[wait  time="4000"  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[stop_bgmovie  time="0"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/7.png"  width="1140"  height="855"  left="62"  top="58"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[wait  time="100"  ]
[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[tb_eval  exp="f.photoPose=1"  name="photoPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[tb_eval  exp="f.photoDeviPose=0"  name="photoDeviPose"  cmd="="  op="t"  val="0"  val_2="undefined"  ]
[call  storage="phase.ks"  target="*show_top"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
[if exp="f.ne == 1]你还真听话啊，本大爷让你读书你就老老实实地看书呢。[else]读的还挺专注的嘛，[r]
想炫耀自己是优等生？[endif][p]
[_tb_end_text]

*end_complete2

[image name="笛" layer=0 time="500"  wait="false"  folder="image"  storage="fue/fuki.png"  width="294"  height="258"  left="132"  top="194"  reflect="false"  ]

[tb_start_tyrano_code]
[keyframe name="item"]
[frame p="0%" y="0"]
[frame p="50%" y="-5"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="笛" keyframe="item" count="infinite" time="1500" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/6.png"  ]
[tb_start_text mode=1 ]
#德比伦
[if exp="f.end_complete == 1"]别读啦，[else]别读啦，[endif]来看这个，有支笛子掉在玄关那里了。[r]
是魔笛哦！Mo・Di！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
看来你不是很懂呢？[r]
这玩意可是个稀罕物，一吹就能恢复魔力喔。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
不过这只已经被吹废了，现在就只是个普通的笛子而已。[r]
只能发出「[font color=0xEC6FC5 bold=true]芬～[resetfont]」这样奇怪的声音。[p]
[_tb_end_text]

[free name="笛"  layer=0 time="500"  wait="false"]

[tb_start_text mode=1 ]
#德比伦
丢你桌上了，或许以后用这个[r]
还能稍微恢复点魔力。[p]

[_tb_end_text]

[stopbgm  time="1000"  fadeout="true"  ]
[camera  time="8000"  zoom="1.15"  wait="false"  layer="base"  y="50"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="0"  y="50"  ]
[camera  time="8000"  zoom="1.3"  wait="false"  layer="1"  y="50"  ]
[tb_start_text mode=1 ]
#德比伦
对了[delay speed=100]……[resetdelay][p]
[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[reset_camera  time="0"  wait="false"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/7.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[playbgm  volume="50"  time="0"  loop="true"  storage="7_before_sleep.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=63]我们吃夜宵吧～！[resetfont][p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/6.png"  ]
[tb_start_text mode=1 ]
#德比伦
虽然魔力是恶魔所必须的能量……[r]
但是也得吃点东西，来吸收一些微量积存的魔力。[p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/9.png"  ]
[tb_start_text mode=1 ]
#德比伦
说起来本大爷有个哥们，[r]
是个饭量大的不得了的家伙。[p]
偏偏那家伙光靠吃饭就能回收魔力，[r]
真是令人羡慕无比啊……[p]
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/5.png"  ]
[tb_start_text mode=1 ]
#德比伦
为毛本大爷就必须要主动去找对象[r]
来吸魔啊……[p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/2.png"  ]
[tb_start_text mode=1 ]
#德比伦
嘛～，不过现在被你这家伙给[r]
召唤来了，倒也轻松不少。[p]
这么想想，各方面还受到你[r]
不少的帮助呢……[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/10.png"  ]
[tb_start_text mode=1 ]
#德比伦
今晚啊，就特别地款待你一下！[r]
嗯……[wait time=100]想吃啥尽管说！[p]
[_tb_end_text]

[jump  storage="Chapter2.ks"  target="*loop2"  cond="f.currentLoop!=1"  ]
[playse  volume="100"  time="0"  buf="1"  storage="aseru.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/12.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
唔，你说啥？[wait time=300]为啥偏要在[r]
这个时间点来吃？[p]

[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/13.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
哼、哼、哼[delay speed=100]……[resetdelay]，看来你这家伙[r]
是没干过坏事吧？[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/14.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
本大爷就特别传授一个秘密给你！[p]
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/17.png"  ]
[camera  time="1000"  zoom="1.15"  wait="false"  layer="base"  y="20"  ]
[camera  time="1000"  zoom="1.3"  wait="false"  layer="0"  y="20"  ]
[camera  time="1000"  zoom="1.3"  wait="false"  layer="1"  y="20"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
深夜吃美食，超有「罪恶感」的哟！[p]
[_tb_end_text]

[camera  time="1000"  zoom="1.3"  wait="false"  layer="base"  y="40"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  layer="0"  y="40"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  layer="1"  y="40"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/15.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[tb_start_text mode=1 ]
#德比伦
此乃整个世界的禁忌……[p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/16.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="syakira.ogg"  ]
[camera  time="1000"  zoom="1.6"  wait="false"  layer="base"  y="60"  ]
[camera  time="1000"  zoom="1.8"  wait="false"  layer="0"  y="60"  ]
[camera  time="1000"  zoom="1.8"  wait="false"  layer="1"  y="60"  ]
[tb_start_text mode=1 ]
#德比伦
没错！[wait time=300][r][font size=50]会・[wait time=300]上・[wait time=300]瘾・[wait time=300]的[wait time=300][resetfont]喔！[p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/10.png"  ]
[reset_camera  time="700"  wait="false"  layer="base"  ]
[reset_camera  time="700"  wait="false"  layer="0"  ]
[reset_camera  time="700"  wait="false"  layer="1"  ]
[tb_start_text mode=4 ]
#德比伦
所有的恶魔，都超级热爱「禁忌之事」啊。[wait time=200][r]
喏，这两个你二选一吧？[wait time=500]

[_tb_end_text]

[choice2 text1="酸酸甜甜的树莓派" target1="*pie" text2="爆蒜拉面" target2="*ramen" y="500"]

[s  ]
*loop2

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="aseru.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/12.png"  ]
[tb_start_text mode=1 ]
#德比伦
诶？你是要酸甜可口的树莓派，[r]
还是蒜头多多的爆蒜拉面……？[p]
[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/16.png"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]你这家伙！很懂行嘛！[resetfont][r]
没想到和本大爷口味一样！[p]
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/10.png"  ]
[tb_start_text mode=4 ]
#德比伦
不过可别太得意忘形喔？[r]
[font size=50]只许选一个！[resetfont][wait time=500]
[_tb_end_text]

[choice2 text1="酸酸甜甜的树莓派" target1="*pie" text2="爆蒜拉面" target2="*ramen" y="500"]

[s  ]
[comment  c="差分"  ]
*pie

[achieve_sticker no="16"]

[if exp="f.currentLoop==1"]

[eval exp="tf.pie=1"]

[elsif exp="f.currentLoop==2"]

[eval exp="tf.pie=7"]

[else]

[eval exp="tf.pie=Math.floor(Math.random()*13)+1"]

[eval exp="tf.pie=1" cond="f.end_complete==1"]

[endif]

[jump  storage="loop_Chapter2.ks"  target="*raspberry"  cond="tf.pie>=1&&tf.pie<=6"  ]
[jump  storage="loop_Chapter2.ks"  target="*blueberry"  cond="tf.pie>=7&&tf.pie<=12"  ]
[jump  storage="loop_Chapter2.ks"  target="*raspberry_pi"  cond="tf.pie>=13"  ]
*loop_back

[achieve_sticker no="79"]

[tb_hide_message_window  ]
[tb_eval  exp="f.mp=10"  name="mp"  cmd="="  op="t"  val="10"  val_2="undefined"  ]
[call  storage="maku.ks"  target="*close"  ]
[chara_hide_all  time="0"  wait="false"  ]
[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[jump  storage="syoukan.ks"  target=""  ]
[s  ]
*ramen

[achieve_sticker no="17"]

[tb_hide_message_window  ]
[playse  volume="100"  time="0"  buf="1"  storage="hazikeru.ogg"  ]
[tb_start_tyrano_code]
[play_apng name="kemuri" layer="1" x="0" y="0" width="1280" height="960" mode="screen" free="true"]
[_tb_end_tyrano_code]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[wait  time="200"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/25.png"  ]
[wait  time="700"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
喏！[wait time=100]立马就给你偷来咯～，[font size=45]深夜之罪恶爆蒜拉面！[resetfont][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
那个超能吃的哥们老是喜欢带本大爷来这家店，[wait time=500][r]
这种爽口又劲道的面条真是好吃～[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
最近还流行在点餐的同时……[r]
念出「阿布拉卡达布拉」这样的咒语。[p]
所有的浇头都加满啦！[r]
那么，开动咯！[p]


[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="paku.ogg"  ]
[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/27.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]（唔咕）[resetfont][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[delay speed=200]…………[resetdelay][p]
[_tb_end_text]

[stopbgm  time="0"  ]
[chara_mod  name="ベッド"  time="30"  cross="false"  storage="chara/19/26.png"  ]
[playse  volume="100"  time="0"  buf="1"  storage="gimon.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]…………！！！！！！[resetfont][p]



[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
不好、[wait time=400]糟[wait time=200]糕[wait time=200]，[wait time=200][p]

[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="8_gag.ogg"  ]
[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/28.png"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
平时吃的时候都没问题！[r]
这身体……，现在居然不能接受大蒜了！[p]


[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
呜哇！冷汗止不住了！唔咕！[r]
不、不行了不行了，浑身无力！[p]


[_tb_end_text]

[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="ベッド"  time="0"  wait="false"  pos_mode="false"  ]
[playse  volume="100"  time="0"  buf="1"  storage="nigeru.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#德比伦
厕、厕所！[r]
[font size=50]厕所！！！！！[resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
[font size=20]哒呀……[p]


[_tb_end_text]

[playse  volume="100"  time="0"  buf="1"  storage="sasu2.ogg"  ]
[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=75]哒呀～～～！[resetfont][p]


[_tb_end_text]

[tb_hide_message_window  ]
[ending no="15"]

[s  ]
*end_complete

[tb_start_tyrano_code]
[position layer="message0" frame="Message.png" height="258"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
这故事，说的啥？[p]
[_tb_end_text]

[chara_hide  name="本"  time="100"  wait="false"  pos_mode="false"  ]
[tb_hide_message_window  ]
[enable_menu_button]

[show_photo_button]

[playse  volume="100"  time="1000"  buf="1"  storage="fuku.ogg"  ]
[bgmovie  time="0"  volume="100"  loop="false"  storage="hon_owari2.mp4"  ]
[wait  time="4000"  ]
[flash  time="80"  effect="fadeIn"  color="0x000000"  ]

[bg  time="0"  method="crossfade"  storage="haikei_bed2.webp"  ]
[stop_bgmovie  time="0"  ]
[chara_show  name="ベッド"  time="0"  wait="false"  storage="chara/19/61.png"  width="1140"  height="855"  left="62"  top="58"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[wait  time="100"  ]
[playse  volume="100"  time="0"  buf="3"  storage="aseru.ogg"  ]
[tb_eval  exp="f.photoPose=1"  name="photoPose"  cmd="="  op="t"  val="1"  val_2="undefined"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#德比伦
咋啦，本大爷也试着模仿你这家伙[r]
来看看书。[p]

[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/60.png"  ]
[tb_start_text mode=1 ]
#德比伦
……这册绘本的名字叫「哭泣的红鬼」。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
讲的是红鬼想与村民搞好关系，[r]
铁哥们蓝鬼为了它特地去扮演反派角色……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
结果计策是成功了，但是被贴上反派标签的蓝鬼[r]
却没法继续留在村里，于是就从红鬼身边消失了……[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
……为什么蓝鬼能为红鬼[r]
做到如此的地步呢？[p]
[_tb_end_text]

[chara_mod  name="ベッド"  time="0"  cross="false"  storage="chara/19/61.png"  ]
[tb_start_text mode=1 ]
#德比伦
八成是受够了红鬼平日里的态度，[r]
一走了之反而会感到心情舒畅吧？[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
这种硬装好人的感觉，[r]
只会让人更起疑心。[p]

[_tb_end_text]

[playse  volume="100"  time="1000"  buf="1"  storage="hon_tozi.ogg"  ]
[jump  storage="Chapter2.ks"  target="*end_complete2"  ]
