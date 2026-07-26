[_tb_system_call storage=system/_collection.ks]

[tb_nolog  ]
[free_layermode  time="0"  wait="false"  ]
[playbgm  volume="50"  time="0"  loop="true"  storage="14_collection_room.ogg"  ]

*resume
[iscript]
tf.omakeAvailable =
sf.collectedEndings.includes('2') ||
sf.collectedEndings.includes('30') ||
sf.collectedEndings.includes('31')
tf.bgPrefix = sf.characters.includes('クピャドエル') && Math.random()*100+1>=100 ? '_' : ''
[endscript]

[bg  time="200"  method="crossfade"  storage="&`hondana${tf.bgPrefix}.webp`"  ]
[call  target="*image"  storage=""  ]
[layopt layer="3" visible="true"]

[image layer="0" name="hand" folder="image/collection" storage="te_collection.png" x="0" y="0" width="1280" height="960"]

[flash_off  time="300"]

*button

[glink  graphic="menu/modoru.png"  enterimg="menu/modoru2.png"  enterse="tap.ogg"  target="*back"  x="1196"  y="874"  width="84"  height="86"  size="0"  ]
[glink  name="collection_book,chara"  target="*chara"  x="97"  y="82"  width="100"  height="600"  size="22"  face="KaiseiDecol-Bold"  text="&`${dc.collectedCharacterCount()}/${dc.collectedTotalCharacters()}`"  graphic="collection/character.png"  enterimg="collection/character_.png"  enterse="tap.ogg"  clickse="OK.ogg"  cond="$('canvas.collection_chara_a').length==0"  ]
[glink  name="collection_book,ending"  target="*ending"  x="197"  y="82"  width="100"  height="600"  size="22"  face="KaiseiDecol-Bold"  text="&`${dc.collectedEndCount()}/${dc.collectedTotalEndings()}`"  graphic="collection/ending.png"  enterimg="collection/ending_.png"  enterse="tap.ogg"  clickse="OK.ogg"  cond="$('canvas.collection_ending_a').length==0"  ]
[glink  name="collection_book,album"  target="*album"  x="415"  y="153"  width="142"  height="530"  size="0"  graphic="collection/album.png"  enterimg="collection/album_.png"  enterse="tap.ogg"  clickse="OK.ogg"  cond="sf.albumEnable&&$('canvas.collection_album_a').length==0"  ]
[glink  name="collection_book,omake"  target="*omake"  x="297"  y="82"  width="100"  height="600"  size="0"  graphic="collection/omake.png"  enterimg="collection/omake_.png"  enterse="tap.ogg"  clickse="OK.ogg"  cond="tf.omakeAvailable&&$('canvas.collection_omake_a').length==0"  ]
[s  ]
*chara

[eval exp="tf.collectionSelected='chara'"]

[jump  target="*apng"  storage=""  ]
*ending

[eval exp="tf.collectionSelected='ending'"]

[jump  target="*apng"  storage=""  ]
*album

[eval exp="tf.collectionSelected='album'"]

[jump  target="*apng"  storage=""  ]
*omake

[eval exp="tf.collectionSelected='omake'"]

[jump  target="*apng"  storage=""  ]
*apng

[call  target="*free_apng"  storage=""  ]
[iscript]
$('.collection_book.' + tf.collectionSelected).remove()
[endscript]

[play_apng name="&`collection_${tf.collectionSelected}_a`" layer="3" x="0" y="0" width="1280" height="960"]

[free layer="0" name="hand"]

[call  target="*image"  storage=""  ]
[wait  time="400"  ]
[clickable  target="*goto"  x="619"  y="79"  width="637"  height="744"  storage=""  ]
[jump  target="*button"  storage=""  ]
*goto

[flash  time="80"  effect="fadeIn"  color="0xFFFFFF"  ]

[call  target="*free_image"  storage=""  ]
[call  target="*free_apng"  storage=""  ]
[jump  storage="&`collection_${tf.collectionSelected}.ks`"  target=""  ]
*image

[wait  time="10"  ]
[image  layer="0"  name="collection_book,chara"  folder="image"  storage="collection/character.png"  x="97"  y="82"  width="100"  height="600"  cond="$('canvas.collection_chara_a').length==0"]

[ptext  layer="2"  name="collection_book,chara"  face="KaiseiDecol-Bold"  x="97"  y="617"  width="100"  align="center"  size="22"  color="0xf6ebad"  wait="false"  text="&`${dc.collectedCharacterCount()}/${dc.collectedTotalCharacters()}`"  cond="$('canvas.collection_chara_a').length==0"  ]

[image  layer="0"  name="collection_book,ending"  folder="image"  storage="collection/ending.png"  x="197"  y="82"  width="100"  height="600"  cond="$('canvas.collection_ending_a').length==0"]

[ptext  layer="2"  name="collection_book,ending"  face="KaiseiDecol-Bold"  x="197"  y="617"  width="100"  align="center"  size="22"  color="0xf6ebad"  wait="false"  text="&`${dc.collectedEndCount()}/${dc.collectedTotalEndings()}`"  cond="$('canvas.collection_ending_a').length==0"  ]

[image  layer="0"  name="collection_book,album"  folder="image"  storage="collection/album.png"  x="415"  y="153"  width="142"  height="530"  cond="sf.albumEnable&&$('canvas.collection_album_a').length==0"]

[image  layer="0"  name="collection_book,omake"  folder="image"  storage="collection/omake.png"  x="297"  y="82"  width="100"  height="600"  cond="tf.omakeAvailable&&$('canvas.collection_omake_a').length==0"]

[image  layer="0"  name="modoru"  folder="image"  storage="menu/modoru.png"  x="1196"  y="874"  width="84"  height="86"]

[return  ]
*free_image

[iscript]
$('.collection_book,.modoru').remove()
[endscript]

*free_apng

[free_apng  name="collection_chara_a"]

[free_apng  name="collection_ending_a"]

[free_apng  name="collection_album_a"]

[free_apng  name="collection_omake_a"]

[return  ]
*back

[stopbgm  time="1000"  fadeout="true"  ]
[free_body_bg time="800,1000,800"]

[flash  time="800"  color="0x000000"]

[free layer="0" name="hand"]

[playse  volume="100"  time="0"  buf="1"  storage="collection_close.ogg"  ]
[if exp="f.backStorage.includes('syoukan')"]

[preload storage="./data/bgm/2_jingle1.ogg"  cond="f.day==0"  ]

[preload storage="./data/bgm/2_jingle2.ogg"  cond="f.day==1"  ]

[preload storage="./data/bgm/2_jingle3.ogg"  cond="f.day==2"  ]

[preload storage="./data/bgm/2_jingle4.ogg"  cond="f.day==3"  ]

[elsif exp="f.backStorage=='title_screen'"]

[bg  time="0"  storage="kuro.webp"  ]
[endif]

[wait  time="1000"  ]
[call  target="*free_image"  storage=""  ]
[call  target="*free_apng"  storage=""  ]
[tb_endnolog  ]
[jump  storage="&`${f.backStorage}.ks`"  target="&`*${f.backTarget}`"  ]
