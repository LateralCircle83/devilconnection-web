[_tb_system_call storage=system/_gekizyou_END9.ks]

[jump  storage="gekizyou_END9_3day.ks"  cond="f.day==3"  target=""  ]
[cm  ]
[if exp="f.day==0"]

[bg_loop name="gekizyo2"]

[chara_show  name="劇場でび"  time="0"  wait="false"  storage="chara/15/dagya8.png"  width="523"  height="551"  left="384"  top="172"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="DEBI"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場でび" keyframe="DEBI" count="infinite" time="3300" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[flash_off  time="0"  effect="fadeOut"  ]

[stopse  time="300"  buf="1"  fadeout="true"  ]
[call  storage="maku.ks"  target="*open_gekizyou"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="5_theater.ogg"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#德比伦
唔喔，[wait time=300][emb exp="f.name"]，你好呀ｗ[p]



[_tb_end_text]

[tb_start_text mode=1 ]
#德比伦
这才刚刚开始，就没有收集到足够的魔力，[r]
你跑到这个彩蛋环节来有什么用？[p]
[_tb_end_text]

[image  name="kuro"  time="500"  wait="false"  layer="0"  folder="fgimage"  storage="default/kuro_.png"  width="1280"  height="960"  ]

[camera  time="1000"  zoom="1.1"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.06"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]杂鱼w[p]
[_tb_end_text]

[camera  time="1000"  zoom="1.3"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.15"  wait="false"  layer="base"  ]
[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya21.png"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=60]菜逼ｗ[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya22.png"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.3"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=70]语文0分w[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya23.png"  ]
[camera  time="1000"  zoom="1.8"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.6"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=80]感受性0w[resetfont][p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya24.png"  ]
[free layer="0" name="kuro" time="500"  wait="false"  ]

[reset_camera  time="1000"  wait="false"  layer="0"  ]
[reset_camera  time="1000"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
唉，好好运用邪眼探查，[r]
拿出点水平来好吧。[p]



[_tb_end_text]

[elsif exp="f.day>=1"]

[bg_loop name="gekizyo"]

[chara_show  name="劇場でび"  time="0"  wait="false"  storage="chara/15/dagya18.png"  width="523"  height="551"  left="560"  top="161"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="DEBI"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場でび" keyframe="DEBI" count="infinite" time="3300" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_show  name="劇場える"  time="0"  wait="false"  storage="chara/16/kupya1.png"  width="517"  height="547"  left="173"  top="151"  reflect="false"  ]
[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="3000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[flash_off  time="0"  effect="fadeOut"  ]

[stopse  time="300"  buf="1"  fadeout="true"  ]
[call  storage="maku.ks"  target="*open_gekizyou"  ]
[playbgm  volume="60"  time="0"  loop="true"  storage="5_theater.ogg"  ]
[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
库皮哒呀小剧场开！演！啦！[wait time=300]今天也要悄悄与您邂逅！[p]


[_tb_end_text]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya3.png"  ]
[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
爱之天使库皮亚多艾露与恶魔德比伦君，[r]
谨此奉上天使与恶魔的私语～……[p]



[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="3000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya2.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
哎呀呀……[emb exp="f.name"][r]
没能收集到魔力呢，辛苦啦……[p]



[_tb_end_text]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya7.png"  ]
[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="800" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
人家可是为了德比君而奔走劳作！[r]
不妨用话语来慰藉一下？[p]



[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya24.png"  ]
[tb_start_text mode=1 ]
#德比伦
嘁……，如此无能的杂鱼使魔，[r]
才懒得理会。[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="3000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya2.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
唔～[delay speed=300]……[resetdelay][p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="ERU"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場える" keyframe="ERU" count="infinite" time="2000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya3.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
对了！[wait time=300]德比君，要不你再多撩拨撩拨[if exp="f.seibetu == 1]他[else]她[endif]吧！[wait time=300][r]
就是，[wait time=100]下界最近流行的那・[wait time=300]个。[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya29.png"  ]
[tb_start_text mode=1 ]
#德比伦
哒呀？你说那个啊！[r]
嘿嘿，好主意。[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya6.png"  ]
[image  name="kuro"  time="500"  wait="false"  layer="0"  folder="fgimage"  storage="default/kuro_.png"  width="1280"  height="960"  ]

[camera  time="1000"  zoom="1.1"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.06"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
[font size=50]杂～鱼♥[p]
[_tb_end_text]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya5.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
丢人现眼♥[p]
[_tb_end_text]

[camera  time="1000"  zoom="1.3"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.15"  wait="false"  layer="base"  ]
[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya21.png"  ]
[tb_start_text mode=1 ]
#德比伦
战五渣[emb exp="f.name"]♥[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
菜逼召唤师♥[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya22.png"  ]
[camera  time="1000"  zoom="1.5"  wait="false"  layer="0"  ]
[camera  time="1000"  zoom="1.3"  wait="false"  layer="base"  ]
[tb_start_text mode=1 ]
#德比伦
无能的家伙，就这样被本大爷[r]
吸干魔力去死吧♥[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
来吧～，咱会带你飞升天界，[r]
从此永远不用再勉强自己了喔♥[resetfont][p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya29.png"  ]
[free layer="0" name="kuro" time="500"  wait="false"  ]

[reset_camera  time="1000"  wait="false"  layer="base"  ]
[reset_camera  time="1000"  wait="false"  layer="0"  ]
[tb_start_tyrano_code]
[keyframe name="DEBI"]
[frame p="0%" y="-20"]
[frame p="50%" y="0"]
[frame p="100%" y="-3"]
[endkeyframe]
[kanim name="劇場でび" keyframe="DEBI" count="infinite" time="800" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#德比伦
库呼呼！[wait time=300]你明明是天使之身，[r]
却颇有几分坏心肠啊！[p]


[_tb_end_text]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya1.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
不不不，[wait time=300]仅以天使之身，行了应尽的善事。[p]
[_tb_end_text]

[tb_start_tyrano_code]
[keyframe name="DEBI"]
[frame p="0%" y="0"]
[frame p="50%" y="-20"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="劇場でび" keyframe="DEBI" count="infinite" time="3300" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya5.png"  ]
[tb_start_text mode=1 ]
#德比伦
哈？[p]

[_tb_end_text]

[chara_mod  name="劇場える"  time="0"  cross="false"  storage="chara/16/kupya4.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
有人会因这些话而心生喜悦。[p]
[_tb_end_text]

[chara_mod  name="劇場でび"  time="0"  cross="false"  storage="chara/15/dagya33.png"  ]
[tb_start_text mode=1 ]
#德比伦
诶……[p]

[_tb_end_text]

[endif]

[jump  storage="gekizyou_END_menu.ks"  target=""  ]
