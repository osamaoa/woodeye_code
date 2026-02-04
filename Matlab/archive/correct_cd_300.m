n_boards
if n_boards>300
    disp('The current implementation does not allow n_boards>201 but this is easily fixed in the file correct_cd...')
    %break
    return
end

%cd(DIRstr_project);

    if board==1
     DIRstr='B_001';
    elseif board==2
        DIRstr='B_002';
    elseif board==3
        DIRstr='B_003';
    elseif board==4
        DIRstr='B_004';
    elseif board==5
        DIRstr='B_005';    
    elseif board==6
        DIRstr='B_006';
    elseif board==7
        DIRstr='B_007';
    elseif board==8
        DIRstr='B_008';
    elseif board==9
        DIRstr='B_009';
    elseif board==10
        DIRstr='B_010';
    elseif board==11
        DIRstr='B_011';
    elseif board==12
        DIRstr='B_012';
    elseif board==13
        DIRstr='B_013';
    elseif board==14
        DIRstr='B_014';
    elseif board==15
        DIRstr='B_015';
    elseif board==16
        DIRstr='B_016';
    elseif board==17
        DIRstr='B_017';
    elseif board==18
        DIRstr='B_018';
    elseif board==19
        DIRstr='B_019';
    elseif board==20
        DIRstr='B_020';
    elseif board==21
        DIRstr='B_021';
    elseif board==22
        DIRstr='B_022';
    elseif board==23
        DIRstr='B_023';
    elseif board==24
        DIRstr='B_024';
    elseif board==25
        DIRstr='B_025';
    elseif board==26
        DIRstr='B_026';
    elseif board==27
        DIRstr='B_027';
    elseif board==28
        DIRstr='B_028';
    elseif board==29
        DIRstr='B_029';
    elseif board==30
        DIRstr='B_030';
    elseif board==31
        DIRstr='B_031';
    elseif board==32
        DIRstr='B_032';
    elseif board==33
        DIRstr='B_033';
    elseif board==34
        DIRstr='B_034';
    elseif board==35
        DIRstr='B_035';
    elseif board==36
        DIRstr='B_036';
    elseif board==37
        DIRstr='B_037';
    elseif board==38
        DIRstr='B_038';
    elseif board==39
        DIRstr='B_039';
    elseif board==40
        DIRstr='B_040';
    elseif board==41
        DIRstr='B_041';
    elseif board==42
        DIRstr='B_042';
    elseif board==43
        DIRstr='B_043';
    elseif board==44
        DIRstr='B_044';
    elseif board==45
        DIRstr='B_045';
    elseif board==46
        DIRstr='B_046';
    elseif board==47
        DIRstr='B_047';
    elseif board==48
        DIRstr='B_048';
    elseif board==49
        DIRstr='B_049';
    elseif board==50
        DIRstr='B_050';
    elseif board==51
        DIRstr='B_051';
    elseif board==52
        DIRstr='B_052';
    elseif board==53
        DIRstr='B_053';
    elseif board==54
        DIRstr='B_054';
    elseif board==55
        DIRstr='B_055';
    elseif board==56
        DIRstr='B_056';
    elseif board==57
        DIRstr='B_057';
    elseif board==58
        DIRstr='B_058';
    elseif board==59
        DIRstr='B_059';
    elseif board==60
        DIRstr='B_060';
    elseif board==61
        DIRstr='B_061';
    elseif board==62
        DIRstr='B_062';
    elseif board==63
        DIRstr='B_063';
    elseif board==64
        DIRstr='B_064';
    elseif board==65
        DIRstr='B_065';
    elseif board==66
        DIRstr='B_066';
    elseif board==67
        DIRstr='B_067';
    elseif board==68
        DIRstr='B_068';
    elseif board==69
        DIRstr='B_069';
    elseif board==70
        DIRstr='B_070';
    elseif board==71
        DIRstr='B_071';
    elseif board==72
        DIRstr='B_072';
    elseif board==73
        DIRstr='B_073';
    elseif board==74
        DIRstr='B_074';
    elseif board==75
        DIRstr='B_075';
    elseif board==76
        DIRstr='B_076';
    elseif board==77
        DIRstr='B_077';
    elseif board==78
        DIRstr='B_078';
    elseif board==79
        DIRstr='B_079';
    elseif board==80
        DIRstr='B_080';
    elseif board==81
        DIRstr='B_081';
    elseif board==82
        DIRstr='B_082';
    elseif board==83
        DIRstr='B_083';
    elseif board==84
        DIRstr='B_084';
    elseif board==85
        DIRstr='B_085';
    elseif board==86
        DIRstr='B_086';
    elseif board==87
        DIRstr='B_087';
    elseif board==88
        DIRstr='B_088';
    elseif board==89
        DIRstr='B_089';
    elseif board==90
        DIRstr='B_090';
    elseif board==91
        DIRstr='B_091';
    elseif board==92
        DIRstr='B_092';
    elseif board==93
        DIRstr='B_093';
    elseif board==94
        DIRstr='B_094';
    elseif board==95
        DIRstr='B_095';
    elseif board==96
        DIRstr='B_096';
    elseif board==97
        DIRstr='B_097';
    elseif board==98
        DIRstr='B_098';
    elseif board==99
        DIRstr='B_099';
    elseif board==100
        DIRstr='B_100';
    elseif board==101
        DIRstr='B_101';
    elseif board==102
        DIRstr='B_102';
    elseif board==103
        DIRstr='B_103';
    elseif board==104
        DIRstr='B_104';
    elseif board==105
        DIRstr='B_105';
    elseif board==106
        DIRstr='B_106';
    elseif board==107
        DIRstr='B_107';
    elseif board==108
        DIRstr='B_108';
    elseif board==109
        DIRstr='B_109';
    elseif board==110
        DIRstr='B_110';
    elseif board==111
        DIRstr='B_111';
    elseif board==112
        DIRstr='B_112';
    elseif board==113
        DIRstr='B_113';
    elseif board==114
        DIRstr='B_114';
    elseif board==115
        DIRstr='B_115';
    elseif board==116
        DIRstr='B_116';
    elseif board==117
        DIRstr='B_117';
    elseif board==118
        DIRstr='B_118';
    elseif board==119
        DIRstr='B_119';
    elseif board==120
        DIRstr='B_120';
    elseif board==121
        DIRstr='B_121';
    elseif board==122
        DIRstr='B_122';
    elseif board==123
        DIRstr='B_123';
    elseif board==124
        DIRstr='B_124';
    elseif board==125
        DIRstr='B_125';
    elseif board==126
        DIRstr='B_126';
    elseif board==127
        DIRstr='B_127';
    elseif board==128
        DIRstr='B_128';
    elseif board==129
        DIRstr='B_129';
    elseif board==130
        DIRstr='B_130';
    elseif board==131
        DIRstr='B_131';
    elseif board==132
        DIRstr='B_132';
    elseif board==133
        DIRstr='B_133';
    elseif board==134
        DIRstr='B_134';
    elseif board==135
        DIRstr='B_135';
    elseif board==136
        DIRstr='B_136';
    elseif board==137
        DIRstr='B_137';
    elseif board==138
        DIRstr='B_138';
    elseif board==139
        DIRstr='B_139';
    elseif board==140
        DIRstr='B_140';
    elseif board==141
        DIRstr='B_141';
    elseif board==142
        DIRstr='B_142';
    elseif board==143
        DIRstr='B_143';
    elseif board==144
        DIRstr='B_144';
    elseif board==145
        DIRstr='B_145';
    elseif board==146
        DIRstr='B_146';
    elseif board==147
        DIRstr='B_147';
    elseif board==148
        DIRstr='B_148';
    elseif board==149
        DIRstr='B_149';
    elseif board==150
        DIRstr='B_150';
    elseif board==151
        DIRstr='B_151';
    elseif board==152
        DIRstr='B_152';
    elseif board==153
        DIRstr='B_153';
    elseif board==154
        DIRstr='B_154';
    elseif board==155
        DIRstr='B_155';
    elseif board==156
        DIRstr='B_156';
    elseif board==157
        DIRstr='B_157';
    elseif board==158
        DIRstr='B_158';
    elseif board==159
        DIRstr='B_159';
    elseif board==160
        DIRstr='B_160';
    elseif board==161
        DIRstr='B_161';
    elseif board==162
        DIRstr='B_162';
    elseif board==163
        DIRstr='B_163';
    elseif board==164
        DIRstr='B_164';
    elseif board==165
        DIRstr='B_165';
    elseif board==166
        DIRstr='B_166';
    elseif board==167
        DIRstr='B_167';
    elseif board==168
        DIRstr='B_168';
    elseif board==169
        DIRstr='B_169';
    elseif board==170
        DIRstr='B_170';
    elseif board==171
        DIRstr='B_171';
    elseif board==172
        DIRstr='B_172';
    elseif board==173
        DIRstr='B_173';
    elseif board==174
        DIRstr='B_174';
    elseif board==175
        DIRstr='B_175';
    elseif board==176
        DIRstr='B_176';
    elseif board==177
        DIRstr='B_177';
    elseif board==178
        DIRstr='B_178';
    elseif board==179
        DIRstr='B_179';
    elseif board==180
        DIRstr='B_180';
    elseif board==181
        DIRstr='B_181';
    elseif board==182
        DIRstr='B_182';
    elseif board==183
        DIRstr='B_183';
    elseif board==184
        DIRstr='B_184';
    elseif board==185
        DIRstr='B_185';
    elseif board==186
        DIRstr='B_186';
    elseif board==187
        DIRstr='B_187';
    elseif board==188
        DIRstr='B_188';
    elseif board==189
        DIRstr='B_189';
    elseif board==190
        DIRstr='B_190';
    elseif board==191
        DIRstr='B_191';
    elseif board==192
        DIRstr='B_192';
    elseif board==193
        DIRstr='B_193';
    elseif board==194
        DIRstr='B_194';
    elseif board==195
        DIRstr='B_195';
    elseif board==196
        DIRstr='B_196';
    elseif board==197
        DIRstr='B_197';
    elseif board==198
        DIRstr='B_198';
    elseif board==199
        DIRstr='B_199';
    elseif board==200
        DIRstr='B_200';
    elseif board==201
        DIRstr='B_201';
    elseif board==202
        DIRstr='B_202';
    elseif board==203
        DIRstr='B_203';
    elseif board==204
        DIRstr='B_204';
    elseif board==205
        DIRstr='B_205';
    elseif board==206
        DIRstr='B_206';
    elseif board==207
        DIRstr='B_207';
    elseif board==208
        DIRstr='B_208';
    elseif board==209
        DIRstr='B_209';
    elseif board==210
        DIRstr='B_210';
    elseif board==211
        DIRstr='B_211';
    elseif board==212
        DIRstr='B_212';
    elseif board==213
        DIRstr='B_213';
    elseif board==214
        DIRstr='B_214';
    elseif board==215
        DIRstr='B_215';
    elseif board==216
        DIRstr='B_216';
    elseif board==217
        DIRstr='B_217';
    elseif board==218
        DIRstr='B_218';
    elseif board==219
        DIRstr='B_219';
    elseif board==220
        DIRstr='B_220';
    elseif board==221
        DIRstr='B_221';
    elseif board==222
        DIRstr='B_222';
    elseif board==223
        DIRstr='B_223';
    elseif board==224
        DIRstr='B_224';
    elseif board==225
        DIRstr='B_225';
    elseif board==226
        DIRstr='B_226';
    elseif board==227
        DIRstr='B_227';
    elseif board==228
        DIRstr='B_228';
    elseif board==229
        DIRstr='B_229';
    elseif board==230
        DIRstr='B_230';
    elseif board==231
        DIRstr='B_231';
    elseif board==232
        DIRstr='B_232';
    elseif board==233
        DIRstr='B_233';
    elseif board==234
        DIRstr='B_234';
    elseif board==235
        DIRstr='B_235';
    elseif board==236
        DIRstr='B_236';
    elseif board==237
        DIRstr='B_237';
    elseif board==238
        DIRstr='B_238';
    elseif board==239
        DIRstr='B_239';
    elseif board==240
        DIRstr='B_240';
    elseif board==241
        DIRstr='B_241';
    elseif board==242
        DIRstr='B_242';
    elseif board==243
        DIRstr='B_243';
    elseif board==244
        DIRstr='B_244';
    elseif board==245
        DIRstr='B_245';
    elseif board==246
        DIRstr='B_246';
    elseif board==247
        DIRstr='B_247';
    elseif board==248
        DIRstr='B_248';
    elseif board==249
        DIRstr='B_249';
    elseif board==250
        DIRstr='B_250';
    elseif board==251
        DIRstr='B_251';
    elseif board==252
        DIRstr='B_252';
    elseif board==253
        DIRstr='B_253';
    elseif board==254
        DIRstr='B_254';
    elseif board==255
        DIRstr='B_255';
    elseif board==256
        DIRstr='B_256';
    elseif board==257
        DIRstr='B_257';
    elseif board==258
        DIRstr='B_258';
    elseif board==259
        DIRstr='B_259';
    elseif board==260
        DIRstr='B_260';
    elseif board==261
        DIRstr='B_261';
    elseif board==262
        DIRstr='B_262';
    elseif board==263
        DIRstr='B_263';
    elseif board==264
        DIRstr='B_264';
    elseif board==265
        DIRstr='B_265';
    elseif board==266
        DIRstr='B_266';
    elseif board==267
        DIRstr='B_267';
    elseif board==268
        DIRstr='B_268';
    elseif board==269
        DIRstr='B_269';
    elseif board==270
        DIRstr='B_270';
    elseif board==271
        DIRstr='B_271';
    elseif board==272
        DIRstr='B_272';
    elseif board==273
        DIRstr='B_273';
    elseif board==274
        DIRstr='B_274';
    elseif board==275
        DIRstr='B_275';
    elseif board==276
        DIRstr='B_276';
    elseif board==277
        DIRstr='B_277';
    elseif board==278
        DIRstr='B_278';
    elseif board==279
        DIRstr='B_279';
    elseif board==280
        DIRstr='B_280';
    elseif board==281
        DIRstr='B_281';
    elseif board==282
        DIRstr='B_282';
    elseif board==283
        DIRstr='B_283';
    elseif board==284
        DIRstr='B_284';
    elseif board==285
        DIRstr='B_285';
    elseif board==286
        DIRstr='B_286';
    elseif board==287
        DIRstr='B_287';
    elseif board==288
        DIRstr='B_288';
    elseif board==289
        DIRstr='B_289';
    elseif board==290
        DIRstr='B_290';
    elseif board==291
        DIRstr='B_291';
    elseif board==292
        DIRstr='B_292';
    elseif board==293
        DIRstr='B_293';
    elseif board==294
        DIRstr='B_294';
    elseif board==295
        DIRstr='B_295';
    elseif board==296
        DIRstr='B_296';
    elseif board==297
        DIRstr='B_297';
    elseif board==298
        DIRstr='B_298';
    elseif board==299
        DIRstr='B_299';
    elseif board==300
        DIRstr='B_300';
    end

%cd(DIRstr)