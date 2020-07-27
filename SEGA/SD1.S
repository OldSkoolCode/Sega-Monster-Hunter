000200 0061 C805      bsr      $7ca
000204 0061 5000      bsr      $256
000208 F94E FF00 0E02 jmp      $ff020e
00020E 3C10 0900      move.b   #$9,d0
000212 0061 5805      bsr      $76c
000216 0061 5800      bsr      $270
00021A FA49 BC05      lea      $7d8(pc),a4
00021E 5442           clr.w    (a4)
000220 0061 7605      bsr      $798
000224 001E           move.b   d0,d7
000226 0042           clr.b    d0
000228 0061 8005      bsr      $7aa
00022C 070C BF00      cmpi.b   #$bf,d7
000230 0067 1800      beq      $24a
000234 BC38 FFFF      move.w   #$ffff,(a4)
000238 0061 6600      bsr      $2a0
00023C 7A20 1200      movea.l  $250(pc),a0
000240 FC91 0000 0010 suba.l   #$1000,a0
000246 E84E 4A02      jmp      $24a(a0)
00024A 0060 5002      bra      $49c
00024E 0000 0000      ori.b    #0,d0
000252 0000 0000      ori.b    #0,d0
000256 3C20 0000 0010 move.l   #$1000,d0
00025C 7C20 0000 0000 movea.l  #0,a0
000262 7C22 FF00 0000 movea.l  #$ff0000,a1
000268 D832           move.w   (a0)+,(a1)+
00026A C851 FCFF      dbf      d0,$268
00026E 754E           rts
000270 7C20 0000 0000 movea.l  #0,a0
000276 1020           move.l   (a0),d0
000278 8820           move.l   a0,(a0)
00027A 0822           move.l   a0,d1
00027C 90B2           cmp.l    (a0),d1
00027E 0066 1600      bne      $296
000282 8020           move.l   d0,(a0)
000284 810C 2000 0000 cmpi.l   #$200000,d1
00028A 0067 0A00      beq      $296
00028E FCD1 0400 0000 adda.l   #$40000,a0
000294 E060           bra.s    $276
000296 0820           move.l   a0,d0
000298 FA41 B6FF      lea      $250(pc),a0
00029C 8020           move.l   d0,(a0)
00029E 754E           rts
0002A0 7C20 FF00 0000 movea.l  #$ff0000,a0
0002A6 3C30 FF03      move.w   #$3ff,d0
0002AA 3A22 A4FF      move.l   $250(pc),d1
0002AE 8104 0000 0010 subi.l   #$1000,d1
0002B4 4122           movea.l  d1,a1
0002B6 D822           move.l   (a0)+,(a1)+
0002B8 C851 FCFF      dbf      d0,$2b6
0002BC 754E           rts
