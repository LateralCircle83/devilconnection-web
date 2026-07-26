[_tb_system_call storage=system/_Chapter4_BBB.ks]

[hide_photo_button]

[eval exp="f.previousEnding=30"]

[quake  time="300"  count="5"  hmax="3"  wait="false"  ]
[stopbgm  time="0"  ]
[playse  volume="100"  time="1000"  buf="4"  storage="syougeki.ogg"  ]
[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[free_bg_loop]

[free_guard_click]
[wait  time="300"  ]
[layopt layer=4 visible="true"]

[image name="shiro" layer=4 folder="fgimage" storage="default/shiro.webp" time="0"  wait="false"  ]

[flash_off  time="0"  effect="fadeOut"  ]

[tb_show_message_window  ]
*x

[tb_start_text mode=1 ]
#NEO德比伦
[quake_text][font face="DZUYOKU"][font size=95]唔哇啊啊啊啊啊啊啊！[resetfont][free_quake_text][p]


[_tb_end_text]

[tb_hide_message_window  ]
[wait  time="8000"  ]
[tb_start_tyrano_code]
[position layer="message0" frame="Message3.png"  height="258"  ]
[_tb_end_tyrano_code]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#？？？②
[delay speed=100]驳回。[resetdelay][p]

[_tb_end_text]

[camera  time="10"  zoom="1.15"  wait="false"  ]
[tb_hide_message_window  ]
[flash  time="0"  effect="fadeIn"  color="0xFFFFFF"  ]

[free layer=4 name="shiro"]

[chara_hide  name="ネオでび"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="コマえる"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="ネオでび邪眼"  time="0"  wait="false"  pos_mode="false"  ]
[bg  time="0"  method="crossfade"  storage="medama_.webp"  ]
[layermode  mode="multiply"  color="0xffffff"  time="0"  wait="false"  graphic="bb2.png"  ]
[chara_show  name="BBB"  time="0"  wait="false"  storage="chara/64/2.png"  width="794"  height="625"  left="292"  top="25"  reflect="false"  ]
[chara_show  name="プレイヤー"  zindex="2"  layer="1"  time="0"  wait="false"  storage="chara/2/te.png"  width="1280"  height="960"  ]
[playse  volume="100"  time="5000"  buf="5"  storage="taida2.ogg"  fadein="true"  loop="true"  ]
[reset_camera  time="9000"  wait="false"  ]
[flash_off  time="3000"  effect="fadeOut"  ]

[wait  time="1000"  ]
[l  ]
[tb_show_message_window  ]
[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/3.png"  ]
[tb_start_text mode=1 ]
#？？？②
[delay speed=100]何谓朋友？你竟欲与恶魔贝尔立下正式契约，[r]
然后借以真名之力，将他终生驱役？[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[_tb_end_text]

[tb_start_tyrano_code]
[play_apng name="kupya_fuki2_show" layer="0" x="7" y="308" width="384" height="400"]
[_tb_end_tyrano_code]

[wait  time="350"  ]
[tb_start_tyrano_code]
[if exp="f.BBB_kidoku == 1"]
[_tb_end_tyrano_code]

[chara_show  name="コマえる"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/21/10.png"  width="383"  height="400"  left="7"  top="308"  reflect="false"  ]
[tb_start_tyrano_code]
[free_apng name="kupya_fuki2_show" ]
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
[emb exp="f.name"]为了德比君[r]
一直努力至今！[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]……不解。[resetdelay][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]仅不过三四天的短期接触……[r]
却自以为已洞悉贝尔的全貌，依据何在？[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]地上之民果然浅薄。[r]
是否因生命短暂、形骸脆弱，故而不具备远见？[resetdelay][p]


[_tb_end_text]

[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/13.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]……你们终究无法理解。[resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]若就此回到魔界，对贝尔而言，[r]
是何等羞辱，甚至足以让他宁愿消亡。[resetdelay][p]


[_tb_end_text]

[playse  volume="40"  time="1000"  buf="0"  storage="gauru1.ogg"  ]
[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/6.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]……现在，就让你解脱。[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]贝尔……，请原谅老夫……[resetdelay][p]


[_tb_end_text]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/10.png"  ]
[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=50]请停手！[r]
切莫、切莫如此！[resetfont][p]

[_tb_end_text]

[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="100"  wait="false"  ]

[playse  volume="60"  time="1000"  buf="0"  storage="BBB.ogg"  ]
[stopse  time="500"  buf="5"  fadeout="true"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]老夫竟将你逼到如此境地！[r]
贝尔，还请[wait time=500]宽恕。[resetdelay][p]


[_tb_end_text]

[tb_hide_message_window  ]
[wait  time="3000"  ]
[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/7.png"  ]
[free_layermode  time="0"  wait="false"  ]
[layermode  mode="hard-light"  color="0xffffff"  time="0"  wait="true"  graphic="bb.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te_hurue.png"  ]
[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/14.png"  ]
[free layer=4 name="kuro" time="1000"  ]

[l  ]
[tb_start_tyrano_code]
[position layer="message0" frame="Message_black.png" height="265"]
[_tb_end_tyrano_code]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#BBB
[font size=25 color=0xEA0F18 bold=true][delay speed=120]咸咸甜甜[resetdelay][resetfont][p]



[_tb_end_text]

[tb_start_tyrano_code]
[else]
[_tb_end_tyrano_code]

[chara_show  name="コマえる"  layer="0"  zindex="2"  time="0"  wait="false"  storage="chara/21/13.png"  width="383"  height="400"  left="7"  top="308"  reflect="false"  ]
[tb_start_tyrano_code]
[free_apng name="kupya_fuki2_show" ]
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
您是……[p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[ruby text="⠀"][delay speed=100]老夫之名，BBB。[wait time=300][r]
与此者，算上下级关系。[resetdelay][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]贝尔已觉醒，积蓄魔力之能，足以惊世。[wait time=500][r]
然而，能否巧妙驾驭，仍是未知之数。[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]若欲效仿天生之恶魔，踏上邪神化之途，[r]
实乃极其艰难。[resetdelay][p]


[_tb_end_text]

[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/13.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]若你未能取得真名，[r]
便必然会遭邪眼所吞噬……[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]不，恐怕连邪眼本身，也难以承受那般巨量的魔力。[r]
其身躯终将腐朽崩坏，化作异形之神。[resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]也许对贝尔而言，[r]
那反倒才是他所谓的幸福……[resetdelay][p]


[_tb_end_text]

[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/4.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]老夫曾思量，是否应将其带回魔界。[wait time=500][r]
但对贝尔而言，恐怕是莫大的屈辱。[resetdelay][p]

[_tb_end_text]

[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/3.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]然而，也不能任由你们当作玩物！[resetdelay][p]


[_tb_end_text]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/10.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
我、我们没有那个打算！！[p]




[_tb_end_text]

[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/4.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]把拼命抵抗的贝尔追得四处逃窜，[r]
到了此刻，竟还有脸如此狡辩，[wait time=200]卑俗的天使！[resetdelay][p]


[_tb_end_text]

[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/9.png"  ]
[tb_start_text mode=1 ]
#库皮亚多艾露
那是……，那是……[r]
呜呜……！[p]



[_tb_end_text]

[playse  volume="40"  time="1000"  buf="0"  storage="gauru1.ogg"  ]
[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/6.png"  ]
[tb_start_text mode=1 ]
#BBB
[delay speed=100]……贝尔[resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]老夫[resetdelay][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[delay speed=100]竟将你逼到如此境地！[r]
宽恕这个愚不可及的[resetdelay][p]


[_tb_end_text]

[layopt layer=4 visible="true"]

[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="100"  wait="false"  ]

[playse  volume="60"  time="1000"  buf="0"  storage="BBB.ogg"  ]
[stopse  time="500"  buf="5"  fadeout="true"  ]
[tb_start_text mode=1 ]
#BBB
[font size=25][delay speed=100]老夫吧。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_hide_message_window  ]
[wait  time="3000"  ]
[chara_mod  name="BBB"  time="0"  cross="false"  storage="chara/64/7.png"  ]
[free_layermode  time="0"  wait="false"  ]
[layermode  mode="hard-light"  color="0xffffff"  time="0"  wait="true"  graphic="bb.png"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te_hurue.png"  ]
[chara_mod  name="コマえる"  time="0"  cross="false"  storage="chara/21/19.png"  ]
[tb_start_tyrano_code]
[keyframe name="erukoma"]
[frame p="0%" x="0"]
[frame p="50%" x="3"]
[frame p="100%" x="0"]
[endkeyframe]
[kanim name="コマえる" keyframe="erukoma" count="infinite" time="100" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[free layer=4 name="kuro" time="1000"  ]

[l  ]
[tb_start_tyrano_code]
[position layer="message0" frame="Message_black.png" height="265"]
[_tb_end_tyrano_code]

[tb_show_message_window  ]
[tb_start_text mode=1 ]
#BBB
[font size=25 color=0xEA0F18 bold=true][delay speed=120]咸咸甜甜[resetdelay][resetfont][p]



[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[font size=25]刚、刚刚……，做了什么……[resetfont][p]




[_tb_end_text]

[tb_start_tyrano_code]
[endif]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#BBB
[_tb_end_text]

[playbgm  volume="50"  time="0"  loop="true"  storage="shinnona.ogg"  fadein="false"  ]
[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]放心。[wait time=300][r]
仅不过将其记忆与肉身一并抹去。[resetdelay][resetfont][p]







[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]若任其为游魂漂泊，[wait time=200]重塑肉体[r]
需数百年。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]因此，老夫赐其最低限魔力，使其得以重生。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]其名、其耻、其苦……尽皆忘却。[r]
当可重返下级恶魔之位，度安稳之日。[resetdelay][resetfont][p]



[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]他之堕落，皆老夫之过。[wait time=500][r]
故此责任，也需老夫来担。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]若任之不管，[wait time=100]他只会再陷痛苦。[resetdelay][resetfont][p]




[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]……如此即可。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]如此……，便是最善。[resetdelay][resetfont][p]


[_tb_end_text]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]聊算合格罢了。[resetdelay][resetfont][p]



[_tb_end_text]

[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[layopt layer=4 visible="true"]

[free_layermode  time="0"  wait="false"  ]
[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[stopbgm  time="0"  fadeout="true"  ]
[wait  time="1000"  ]
[flash_off  time="0"  effect="fadeOut"  ]

[tb_start_text mode=1 ]
#BBB
[font color=0xEA0F18 bold=true][delay speed=120]不，实乃最优之策。[resetdelay][resetfont][p]



[_tb_end_text]

[tb_hide_message_window  ]
[flash  time="0"  effect="fadeIn"  color="0x000000"  ]

[chara_hide  name="BBB"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="コマえる"  time="0"  wait="false"  pos_mode="false"  ]
[chara_show  name="クピャドエル"  time="0"  wait="false"  storage="chara/14/12.png"  width="1015"  height="761"  left="125"  top="-44"  reflect="false"  ]
[layermode  mode="multiply"  color="0xffffff"  time="0"  wait="false"  graphic="bb2.png"  ]
[tb_start_tyrano_code]
[keyframe name="kupya"]
[frame p="0%" y="0"]
[frame p="50%" y="-30"]
[frame p="100%" y="0"]
[endkeyframe]
[kanim name="クピャドエル" keyframe="kupya" count="infinite" time="4000" direction="alternate" easing="linear"]
[_tb_end_tyrano_code]

[bg  time="0"  method="crossfade"  storage="haikei_black.webp"  ]
[free layer=4 name="kuro" time="0"  ]

[wait  time="3000"  ]
[flash_off  time="1000"  effect="fadeOut"  ]

[tb_start_tyrano_code]
[position layer="message0" frame="Message3.png"  height="258"  ]
[_tb_end_tyrano_code]

[wait  time="1000"  ]
[tb_show_message_window  ]
[jump  storage="Chapter4_BBB.ks"  target="*30"  cond="dc.endCount()>=dc.totalEndings()"  ]
[tb_start_tyrano_code]
[if exp="f.BBB_kidoku == 1"]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]……最终，还是这般。[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]…………[resetfont][resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]请您，请您快点重新来过！[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]重新……来过。[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_tyrano_code]
[else]
[_tb_end_tyrano_code]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]身为天使，却未能对[emb exp="f.name"]施予拯救……[r]
甚至连德比君也未能救下，非常抱歉。[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]然而，德比君仍然赐予了……[wait time=200][r][emb exp="f.name"]一直渴求的……朋友。[resetfont][resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]然而，纵使我们竭尽所能，终究还是有所不及呢……[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_tyrano_code]
[endif]
[_tb_end_tyrano_code]

[jump  storage="Chapter4_BBB.ks"  target="*BBB_jump"  ]
*30

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]未能救回NEO德比君呢……[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]……[resetfont][resetdelay][p]

[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]…………啊咧，[resetfont][resetdelay][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#库皮亚多艾露
[delay speed=120][font size=25]…………什么都，看不见了。[resetfont][resetdelay][p]
[_tb_end_text]

*BBB_jump

[tb_hide_message_window  ]
[stopbgm  time="5000"  fadeout="true"  ]
[playse  volume="100"  time="0"  buf="1"  storage="beru.ogg"  ]
[wait  time="2500"  ]
[jump  storage="Chapter4_BBB.ks"  target="*deru"  cond="f.BBB_kidoku==0"  ]
[choice2 text1="去玄关" target1="*deru" text2="不去玄关" target2="*denai" ]

[s  ]
*deru

[tb_start_text mode=1 ]
#咪蒂尔
[_tb_end_text]

[flash  time="600"  effect="fadeIn"  color="0x000000"  ]

[wait  time="1000"  ]
[stopbgm  time="1000"  ]
[playse  volume="100"  time="0"  buf="1"  storage="doa1.ogg"  ]
[flash  time="600"  effect="fadeIn"  color="0xFFFFFF"  ]

[free_layermode  time="0"  wait="true"  ]
[wait  time="1000"  ]
[chara_hide  name="クピャドエル"  time="0"  wait="false"  pos_mode="false"  ]
[chara_mod  name="プレイヤー"  time="0"  cross="false"  storage="chara/2/te.png"  ]
[bg  time="0"  method="crossfade"  storage="kupya_10.webp"  ]
[chara_show  name="ミーティア"  time="0"  wait="false"  storage="chara/39/14.png"  width="632"  height="648"  left="318"  top="145"  reflect="false"  ]
[wait  time="500"  ]
[playse  volume="100"  time="0"  buf="5"  storage="tyun.ogg"  loop="true"  ]
[flash_off  time="800"  effect="fadeOut"  ]

[wait  time="1500"  ]
[playse  volume="100"  time="0"  buf="1"  storage="hirameki.ogg"  ]
[chara_mod  name="ミーティア"  time="0"  cross="false"  storage="chara/39/2.png"  ]
[tb_start_tyrano_code]
[position layer="message0" frame="Message.png"  height="258"  ]
[_tb_end_tyrano_code]

[fadein_window  time="1000"  ]
[tb_start_text mode=1 ]
#咪蒂尔
早安的说！[p]

[_tb_end_text]

[chara_mod  name="ミーティア"  time="0"  cross="false"  storage="chara/39/1.png"  ]
[tb_start_text mode=1 ]
#咪蒂尔
[emb exp="f.name"]，居然真的能和你一起去上学……[r]
小咪的梦想实现了，超～开心的说！[p]
[_tb_end_text]

[chara_mod  name="ミーティア"  time="0"  cross="false"  storage="chara/39/8.png"  ]
[tb_start_text mode=1 ]
#咪蒂尔
走啦走啦！出发咯！[p]
[_tb_end_text]

[tb_hide_message_window  ]
[layopt layer=4 visible="true"]

[image name="shiro" layer=4 folder="fgimage" storage="default/shiro.webp" time="1000"  wait="false"  ]

[playse  volume="100"  time="0"  buf="0"  storage="ashi.ogg"  ]
[wait  time="3000"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#咪蒂尔
……总感觉你看起来没什么精神呀～[r]
要是身体不舒服的话，就不要强撑了的说。[p]
[_tb_end_text]

[chara_hide  name="プレイヤー"  layer="1"  time="0"  wait="false"  pos_mode="false"  ]
[chara_hide  name="ミーティア"  time="0"  wait="false"  pos_mode="false"  ]
[bg  time="0"  method="crossfade"  wait="false"  storage="BBB1.webp"  ]
[camera  time="10"  zoom="1.1"  wait="false"  ]
[tb_start_text mode=1 ]
#咪蒂尔
毕竟很久没有去上学了呢……[r]
有点紧张也是理所当然的说。[p]
[_tb_end_text]

[tb_start_text mode=1 ]
#咪蒂尔
下次就不用拘谨啦！带上你的那位[r]
小恶魔友人也是可以的喔！[p]
[_tb_end_text]

[stopse  time="1000"  buf="5"  fadeout="true"  ]
[tb_start_text mode=1 ]
#咪蒂尔
其实[if exp="f.meteor== 1]我还想再见一见，那位小恶魔先生的说。[else]我还想再见一见，梦里遇到的那位小恶魔先生的说。[endif][r]
所以下次大家一起上学吧！[p]
[_tb_end_text]

[tb_hide_message_window  ]
[reset_camera  time="12000"  wait="false"  ]
[playse  volume="40"  time="1000"  buf="5"  storage="tori2.ogg"  loop="true"  fadein="true"  ]
[free layer=4 name="shiro" time="1000"  ]

[l  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#咪蒂尔
咪呀，快看，快看！小小的蝙蝠呢！[r]
[if exp="f.meteor == 1"]头上长着角……，肯定是小恶魔先生的说。[endif][p]
[_tb_end_text]

[tb_start_text mode=1 ]
#咪蒂尔
[font face="KaiseiDecol-Bold"]树莓[resetfont]有刺，要小心呢！[p]
[_tb_end_text]

[tb_hide_message_window  ]
[bg  time="1000"  method="crossfade"  wait="true"  storage="shiro.webp"  ]
[camera  time="10"  zoom="1.5"  wait="false"  layer="layer_camera"  ]
[skipstop]

[disable_skip_button visible="true"]

[bg  time="0"  method="crossfade"  wait="false"  storage="BBB2.webp"  ]
[playse  volume="100"  time="0"  buf="1"  storage="iya.ogg"  loop="false"  fadein="false"  ]
[flash_off  time="20"  effect="fadeOut"  ]

[reset_camera  time="10000"  wait="false"  layer="layer_camera"  ]
[wait  time="4800"  ]
[layopt layer=4 visible="true"]

[open_omake  category="gallery"  name="BBB_2"  ]
[image name="kuro" layer=4 folder="fgimage" storage="default/kuro.webp" time="0"  wait="false"  ]

[bg  time="0"  method="crossfade"  storage="kuro.webp"  wait="false"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#？？？
哒呀……？[p]
[_tb_end_text]

[tb_hide_message_window  ]
[memory name="BBB_kidoku" val="1"]

[l  ]
[stopse  time="1000"  buf="5"  fadeout="false"  ]
[free layer=4 name="kuro" time="0"]

[wait  time="5000"  ]
[collect_ending no="30"]

[steam_achievement_activate name="OMAKE"]

[playse  volume="100"  time="1000"  buf="0"  storage="maki.ogg"  ]
[wait  time="2000"  ]
[jump  storage="loop_to_scene1.ks"  target=""  ]
[s  ]
*denai

[tb_hide_message_window  ]
[tb_start_tyrano_code]
[position layer="message0" frame="Message.png"  height="258"  ]
[_tb_end_tyrano_code]

[comment  c="タイトル"  ]
[chara_move  name="プレイヤー"  anim="true"  time="7000"  effect="easeInQuad"  wait="true"  left="0"  top="500"  width="1280"  height="960"  ]
[wait  time="5000"  ]
[tb_clear_images]

[tb_autosave  title="b"  ]
[preload  storage="./data/image/menu_Title/hon_title_koukai.png"  ]

[wait  time="100"  ]
[chara_show  time="500"  wait="false"  name="TAP"  storage="chara/18/TAP_title.png"  width="400"  height="200"  left="433"  top="523"  reflect="false"  ]
[clickable  storage=""  x="0"  y="0"  width="1280"  height="960"  target="*title"  _clickable_img=""  ]
[s  ]
*title

[chara_hide  name="TAP"  time="200"  wait="false"  pos_mode="true"  ]
[playse  volume="100"  time="1000"  buf="0"  storage="hon_ake.ogg"  ]
[play_apng name="hon_title" layer="fix" x="0" y="0" width="1280" height="960" zindex="100"]

[wait  time="300"  ]
[image name="title_menu_bg"  x="0"  y="0"  width="1280"  height="960"  folder="image"  storage="menu_Title/hon_title_koukai.png" layer="fix" zindex="101"]

[glink  name="title_menu"  target="*start"  x="58"  y="483"  width="320"  height="80"  size="0"  graphic="menu_Title/hazimekara_.png"  enterimg="menu_Title/hazimekara.png"  enterse="tap.ogg"  ]
[glink  name="title_menu"  target="*load"  x="43"  y="592"  width="307"  height="80"  size="0"  graphic="menu_Title/tudukikara_.png"  enterimg="menu_Title/tudukikara.png"  enterse="tap.ogg"  clickse="OK.ogg"  ]
[glink  name="title_menu"  target="*option"  x="19"  y="699"  width="318"  height="75"  size="0"  graphic="menu_Title/option_.png"  enterimg="menu_Title/option.png"  enterse="tap.ogg"  clickse="OK.ogg"  ]
[image  name="title_menu"  layer=fix zindex=101 folder="image" storage="menu_Title/collection__.png"  x="4"  y="805"  width="346"  height="75"  ]

[free_apng name="hon_title"]

[s  ]
*start

[chara_hide  name="クピャドエル"  time="0"  wait="true"  pos_mode="true"  ]
[bg  time="0"  method="crossfade"  storage="kuro.webp"  ]
[playse  volume="100"  time="1000"  buf="0"  storage="maki.ogg"  ]
[free layer="fix" name="title_menu"]

[free layer="fix" name="title_menu_bg"]

[free_title_loop]

[wait  time="3000"  ]
[jump  storage="loop_to_scene1.ks"  target=""  ]
[s  ]
*load

[free layer="fix" name="title_menu"]

[free layer="fix" name="title_menu_bg"]

[showload]

[jump  storage="Chapter4_BBB.ks"  target="*title"  ]
*option

[free layer="fix" name="title_menu"]

[free layer="fix" name="title_menu_bg"]

[eval exp="f.configFromTitle=1"]

[eval exp="f.backFromConfigTo='Chapter4_BBB'"]

[jump  storage="config.ks"  target=""  ]
[s  ]
