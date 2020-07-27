000440 FC46 0027      move     #$2700,sr
000444 0E2F           move.l   a6,-(a7)
000446 FA4D A6FF      lea      $3ee(pc),a6
00044A BC1C 0200      move.b   #$2,(a6)
00044E 0060 1000      bra      $460
000452 FC46 0027      move     #$2700,sr
000456 0E2F           move.l   a6,-(a7)
000458 FA4D 94FF      lea      $3ee(pc),a6
00045C BC1C 0400      move.b   #$4,(a6)
000460 FA4D 94FF      lea      $3f6(pc),a6
000464 C02C           move.l   d0,(a6)+
000466 C12C           move.l   d1,(a6)+
000468 C22C           move.l   d2,(a6)+
00046A C32C           move.l   d3,(a6)+
00046C C42C           move.l   d4,(a6)+
00046E C52C           move.l   d5,(a6)+
000470 C62C           move.l   d6,(a6)+
000472 C72C           move.l   d7,(a6)+
000474 C82C           move.l   a0,(a6)+
000476 C92C           move.l   a1,(a6)+
000478 CA2C           move.l   a2,(a6)+
00047A CB2C           move.l   a3,(a6)+
00047C CC2C           move.l   a4,(a6)+
00047E CD2C           move.l   a5,(a6)+
000480 1F20           move.l   (a7)+,d0
000482 C02C           move.l   d0,(a6)+
000484 FA41 69FF      lea      $3ef(pc),a0
000488 1F30           move.w   (a7)+,d0
00048A 1010           move.b   (a0),d0
00048C FA41 62FF      lea      $3f0(pc),a0
000490 9F20           move.l   (a7)+,(a0)
000492 FA41 60FF      lea      $3f4(pc),a0
000496 9F30           move.w   (a7)+,(a0)
000498 0060 4E00      bra      $4e8
00049C FC46 0027      move     #$2700,sr
0004A0 0E2F           move.l   a6,-(a7)
0004A2 002F           move.l   d0,-(a7)
0004A4 FA4D 48FF      lea      $3ee(pc),a6
0004A8 3930 A100 0030 move.w   $a13000,d0
0004AE 4002 0001      andi.w   #$100,d0
0004B2 0067 0A00      beq      $4be
0004B6 BC1C 8100      move.b   #$81,(a6)
0004BA 0060 0600      bra      $4c2
0004BE BC1C 0100      move.b   #$1,(a6)
0004C2 1F20           move.l   (a7)+,d0
0004C4 FA4D 30FF      lea      $3f6(pc),a6
0004C8 C02C           move.l   d0,(a6)+
0004CA C12C           move.l   d1,(a6)+
0004CC C22C           move.l   d2,(a6)+
0004CE C32C           move.l   d3,(a6)+
0004D0 C42C           move.l   d4,(a6)+
0004D2 C52C           move.l   d5,(a6)+
0004D4 C62C           move.l   d6,(a6)+
0004D6 C72C           move.l   d7,(a6)+
0004D8 C82C           move.l   a0,(a6)+
0004DA C92C           move.l   a1,(a6)+
0004DC CA2C           move.l   a2,(a6)+
0004DE CB2C           move.l   a3,(a6)+
0004E0 CC2C           move.l   a4,(a6)+
0004E2 CD2C           move.l   a5,(a6)+
0004E4 1F20           move.l   (a7)+,d0
0004E6 C02C           move.l   d0,(a6)+
0004E8 FA41 54FF      lea      $43e(pc),a0
0004EC 9F30           move.w   (a7)+,(a0)
0004EE 5002 FF7F      andi.w   #$7fff,(a0)
0004F2 FA41 46FF      lea      $43a(pc),a0
0004F6 9F20           move.l   (a7)+,(a0)
0004F8 FA41 38FF      lea      $432(pc),a0
0004FC 8F20           move.l   a7,(a0)
0004FE FA43 36FF      lea      $436(pc),a1
000502 684E           move     usp,a0
000504 8822           move.l   a0,(a1)
000506 FA4F E4FE      lea      $3ec(pc),a7
00050A 0061 B403      bsr      $8c0
00050E 3C10 0600      move.b   #$6,d0
000512 0061 5802      bsr      $76c
000516 0061 8002      bsr      $798
00051A 000C 0100      cmpi.b   #$1,d0
00051E 0066 1000      bne      $530
000522 0070           moveq    #0,d0
000524 0061 8402      bsr      $7aa
000528 0061 B002      bsr      $7da
00052C 0060 3A02      bra      $768
000530 000C 0200      cmpi.b   #$2,d0
000534 0066 1000      bne      $546
000538 0070           moveq    #0,d0
00053A 0061 6E02      bsr      $7aa
00053E 0061 AC02      bsr      $7ec
000542 0060 2402      bra      $768
000546 000C 0300      cmpi.b   #$3,d0
00054A 0066 1000      bne      $55c
00054E 0070           moveq    #0,d0
000550 0061 5802      bsr      $7aa
000554 0061 B202      bsr      $808
000558 0060 0E02      bra      $768
00055C 000C 0400      cmpi.b   #$4,d0
000560 0066 1000      bne      $572
000564 0070           moveq    #0,d0
000566 0061 4202      bsr      $7aa
00056A 0061 0803      bsr      $874
00056E 0060 F801      bra      $768
000572 000C 0500      cmpi.b   #$5,d0
000576 0066 1000      bne      $588
00057A 0070           moveq    #0,d0
00057C 0061 2C02      bsr      $7aa
000580 0061 DA02      bsr      $85c
000584 0060 E201      bra      $768
000588 000C 0600      cmpi.b   #$6,d0
00058C 0066 0C00      bne      $59a
000590 0070           moveq    #0,d0
000592 0061 1602      bsr      $7aa
000596 0060 D001      bra      $768
00059A 000C 0700      cmpi.b   #$7,d0
00059E 0066 0C00      bne      $5ac
0005A2 0070           moveq    #0,d0
0005A4 0061 0402      bsr      $7aa
0005A8 0060 BE01      bra      $768
0005AC 000C 0800      cmpi.b   #$8,d0
0005B0 0066 1000      bne      $5c2
0005B4 0070           moveq    #0,d0
0005B6 0061 F201      bsr      $7aa
0005BA 0061 B603      bsr      $972
0005BE 0060 A801      bra      $768
0005C2 000C 0900      cmpi.b   #$9,d0
0005C6 0066 1000      bne      $5d8
0005CA 0070           moveq    #0,d0
0005CC 0061 DC01      bsr      $7aa
0005D0 0061 5202      bsr      $824
0005D4 0060 9201      bra      $768
0005D8 000C 0A00      cmpi.b   #$a,d0
0005DC 0066 1000      bne      $5ee
0005E0 0070           moveq    #0,d0
0005E2 0061 C601      bsr      $7aa
0005E6 0061 3003      bsr      $918
0005EA 0060 7C01      bra      $768
0005EE 000C 0B00      cmpi.b   #$b,d0
0005F2 0066 1000      bne      $604
0005F6 0070           moveq    #0,d0
0005F8 0061 B001      bsr      $7aa
0005FC 0061 F602      bsr      $8f4
000600 0060 6601      bra      $768
000604 000C 0C00      cmpi.b   #$c,d0
000608 0066 1000      bne      $61a
00060C 0070           moveq    #0,d0
00060E 0061 9A01      bsr      $7aa
000612 0061 3603      bsr      $94a
000616 0060 5001      bra      $768
00061A 000C 1000      cmpi.b   #$10,d0
00061E 0066 1000      bne      $630
000622 0870           moveq    #$8,d0
000624 0061 8401      bsr      $7aa
000628 0061 5004      bsr      $a7a
00062C 0060 3A01      bra      $768
000630 000C 2000      cmpi.b   #$20,d0
000634 0066 1000      bne      $646
000638 0870           moveq    #$8,d0
00063A 0061 6E01      bsr      $7aa
00063E 0061 5404      bsr      $a94
000642 0060 2401      bra      $768
000646 000C 3000      cmpi.b   #$30,d0
00064A 0066 1000      bne      $65c
00064E 0870           moveq    #$8,d0
000650 0061 5801      bsr      $7aa
000654 0061 5604      bsr      $aac
000658 0060 0E01      bra      $768
00065C 000C 4000      cmpi.b   #$40,d0
000660 0066 1000      bne      $672
000664 0870           moveq    #$8,d0
000666 0061 4201      bsr      $7aa
00066A 0061 5804      bsr      $ac4
00066E 0060 F800      bra      $768
000672 000C 5000      cmpi.b   #$50,d0
000676 0066 1000      bne      $688
00067A 0870           moveq    #$8,d0
00067C 0061 2C01      bsr      $7aa
000680 0061 7C04      bsr      $afe
000684 0060 E200      bra      $768
000688 000C 6000      cmpi.b   #$60,d0
00068C 0066 1000      bne      $69e
000690 0870           moveq    #$8,d0
000692 0061 1601      bsr      $7aa
000696 0061 8204      bsr      $b1a
00069A 0060 CC00      bra      $768
00069E 000C 7000      cmpi.b   #$70,d0
0006A2 0066 1400      bne      $6b8
0006A6 0870           moveq    #$8,d0
0006A8 0061 0001      bsr      $7aa
0006AC 0061 DE05      bsr      $c8c
0006B0 0061 3606      bsr      $ce8
0006B4 0060 B200      bra      $768
0006B8 000C 8000      cmpi.b   #$80,d0
0006BC 0066 1000      bne      $6ce
0006C0 0870           moveq    #$8,d0
0006C2 0061 E600      bsr      $7aa
0006C6 0061 5205      bsr      $c1a
0006CA 0060 9C00      bra      $768
0006CE 000C 9000      cmpi.b   #$90,d0
0006D2 0066 1000      bne      $6e4
0006D6 0870           moveq    #$8,d0
0006D8 0061 D000      bsr      $7aa
0006DC 0061 5805      bsr      $c36
0006E0 0060 8600      bra      $768
0006E4 000C A000      cmpi.b   #$a0,d0
0006E8 0066 1000      bne      $6fa
0006EC 0870           moveq    #$8,d0
0006EE 0061 BA00      bsr      $7aa
0006F2 0061 3C04      bsr      $b30
0006F6 0060 7000      bra      $768
0006FA 000C B000      cmpi.b   #$b0,d0
0006FE 0066 1000      bne      $710
000702 0870           moveq    #$8,d0
000704 0061 A400      bsr      $7aa
000708 0061 CA04      bsr      $bd4
00070C 0060 5A00      bra      $768
000710 000C C000      cmpi.b   #$c0,d0
000714 0066 1000      bne      $726
000718 0870           moveq    #$8,d0
00071A 0061 8E00      bsr      $7aa
00071E 0061 4004      bsr      $b60
000722 0060 4400      bra      $768
000726 000C D000      cmpi.b   #$d0,d0
00072A 0066 1000      bne      $73c
00072E 0870           moveq    #$8,d0
000730 0061 7800      bsr      $7aa
000734 0061 7204      bsr      $ba8
000738 0060 2E00      bra      $768
00073C 000C E000      cmpi.b   #$e0,d0
000740 0066 1000      bne      $752
000744 0870           moveq    #$8,d0
000746 0061 6200      bsr      $7aa
00074A 0061 5E05      bsr      $caa
00074E 0060 1800      bra      $768
000752 000C F000      cmpi.b   #$f0,d0
000756 0066 1000      bne      $768
00075A 0870           moveq    #$8,d0
00075C 0061 4C00      bsr      $7aa
000760 0061 6605      bsr      $cc8
000764 0060 0200      bra      $768
000768 0060 ACFD      bra      $516
00076C 3932 A100 0030 move.w   $a13000,d1
000772 010C FF00      cmpi.b   #$ff,d1
000776 F466           bne.s    $76c
000778 0002 0F00      andi.b   #$f,d0
00077C C033 A100 0030 move.w   d0,$a13000
000782 3932 A100 0030 move.w   $a13000,d1
000788 010C 0000      cmpi.b   #0,d1
00078C F466           bne.s    $782
00078E FC33 8F00 A100 move.w   #$8f,$a13000
000796 754E           rts
000798 3930 A100 0030 move.w   $a13000,d0
00079E 0008 0F00      btst     #$f,d0
0007A2 F466           bne.s    $798
0007A4 4002 FF00      andi.w   #$ff,d0
0007A8 754E           rts
0007AA 0000 8000      ori.b    #$80,d0
0007AE C033 A100 0030 move.w   d0,$a13000
0007B4 3930 A100 0030 move.w   $a13000,d0
0007BA 0008 0F00      btst     #$f,d0
0007BE F467           beq.s    $7b4
0007C0 FC33 8F00 A100 move.w   #$8f,$a13000
0007C8 754E           rts
0007CA FC33 FF00 A100 move.w   #$ff,$a13000
0007D2 754E           rts
0007D4 0000 0000      ori.b    #0,d0
0007D8 0000 0061      ori.b    #0,d0
0007DC B400 0061 B8FF ori.l    #$6100ffb8,-$80(a4,d1.w)
0007E4 0270           moveq    #$2,d0
0007E6 0061 C2FF      bsr      $7aa
0007EA 754E           rts
0007EC 0061 A200      bsr      $890
0007F0 017C           moveq    #$1,d6
0007F2 0061 A4FF      bsr      $798
0007F6 49E1           lsl.w    #8,d1
0007F8 0012           move.b   d0,d1
0007FA 0270           moveq    #$2,d0
0007FC 0061 ACFF      bsr      $7aa
000800 CE51 F0FF      dbf      d6,$7f2
000804 8130           move.w   d1,(a0)
000806 754E           rts
000808 0061 8600      bsr      $890
00080C 037C           moveq    #$3,d6
00080E 0061 88FF      bsr      $798
000812 89E1           lsl.l    #8,d1
000814 0012           move.b   d0,d1
000816 0270           moveq    #$2,d0
000818 0061 90FF      bsr      $7aa
00081C CE51 F0FF      dbf      d6,$80e
000820 8120           move.l   d1,(a0)
000822 754E           rts
000824 0061 6A00      bsr      $890
000828 0061 7E00      bsr      $8a8
00082C 8642           clr.l    d6
00082E 003C           move.w   d0,d6
000830 8653           subq.l   #1,d6
000832 F945 A100 0030 lea      $a13000,a2
000838 4A26           movea.l  a2,a3
00083A 8B52           addq.l   #1,a3
00083C 3C3A 8200      move.w   #$82,d5
000840 3C38 FF00      move.w   #$ff,d4
000844 524A           tst.w    (a2)
000846 FC6B           bmi.s    $844
000848 D310           move.b   (a3),(a0)+
00084A 8534           move.w   d5,(a2)
00084C 524A           tst.w    (a2)
00084E FC6A           bpl.s    $84c
000850 8434           move.w   d4,(a2)
000852 CE51 F0FF      dbf      d6,$844
000856 0061 6800      bsr      $8c0
00085A 754E           rts
00085C 4772           moveq    #$47,d1
00085E FA41 96FB      lea      $3f6(pc),a0
000862 0061 34FF      bsr      $798
000866 C010           move.b   d0,(a0)+
000868 0270           moveq    #$2,d0
00086A 0061 3EFF      bsr      $7aa
00086E C951 F2FF      dbf      d1,$862
000872 754E           rts
000874 017C           moveq    #$1,d6
000876 0061 20FF      bsr      $798
00087A 49E1           lsl.w    #8,d1
00087C 0012           move.b   d0,d1
00087E 0270           moveq    #$2,d0
000880 0061 28FF      bsr      $7aa
000884 CE51 F0FF      dbf      d6,$876
000888 FA41 B4FB      lea      $43e(pc),a0
00088C 8130           move.w   d1,(a0)
00088E 754E           rts
000890 037C           moveq    #$3,d6
000892 0061 04FF      bsr      $798
000896 89E1           lsl.l    #8,d1
000898 0012           move.b   d0,d1
00089A 0170           moveq    #$1,d0
00089C 0061 0CFF      bsr      $7aa
0008A0 CE51 F0FF      dbf      d6,$892
0008A4 4120           movea.l  d1,a0
0008A6 754E           rts
0008A8 017C           moveq    #$1,d6
0008AA 0061 ECFE      bsr      $798
0008AE 89E1           lsl.l    #8,d1
0008B0 0012           move.b   d0,d1
0008B2 0270           moveq    #$2,d0
0008B4 0061 F4FE      bsr      $7aa
0008B8 CE51 F0FF      dbf      d6,$8aa
0008BC 0130           move.w   d1,d0
0008BE 754E           rts
0008C0 FA41 16FF      lea      $7d8(pc),a0
0008C4 500C 0000      cmpi.w   #0,(a0)
0008C8 0066 0400      bne      $8ce
0008CC 754E           rts
0008CE FA41 CCFB      lea      $49c(pc),a0
0008D2 C823 0000 1000 move.l   a0,$10
0008D8 C823 0000 2400 move.l   a0,$24
0008DE FA41 60FB      lea      $440(pc),a0
0008E2 C823 0000 0C00 move.l   a0,$c
0008E8 FA41 68FB      lea      $452(pc),a0
0008EC C823 0000 0800 move.l   a0,$8
0008F2 754E           rts
0008F4 B261           bsr.s    $8a8
0008F6 0034           move.w   d0,d2
0008F8 AE61           bsr.s    $8a8
0008FA 8AE1           lsl.l    #8,d2
0008FC 8AE1           lsl.l    #8,d2
0008FE 8202 7F00 0000 andi.l   #$7f0000,d2
000904 8200 00C0 0000 ori.l    #$c0000000,d2
00090A C223 C000 0400 move.l   d2,$c00004
000910 C033 C000 0000 move.w   d0,$c00000
000916 754E           rts
000918 8E61           bsr.s    $8a8
00091A 0034           move.w   d0,d2
00091C 8A61           bsr.s    $8a8
00091E 0222           move.l   d2,d1
000920 89E1           lsl.l    #8,d1
000922 89E1           lsl.l    #8,d1
000924 8102 FF3F 0000 andi.l   #$3fff0000,d1
00092A 8AE0           lsr.l    #8,d2
00092C 8AEC           lsr.l    #6,d2
00092E 8202 0000 0300 andi.l   #$3,d2
000934 8282           or.l     d2,d1
000936 8100 0040 0000 ori.l    #$40000000,d1
00093C C123 C000 0400 move.l   d1,$c00004
000942 C033 C000 0000 move.w   d0,$c00000
000948 754E           rts
00094A 0061 5CFF      bsr      $8a8
00094E 0034           move.w   d0,d2
000950 0061 56FF      bsr      $8a8
000954 8AE1           lsl.l    #8,d2
000956 8AE1           lsl.l    #8,d2
000958 8202 7F00 0000 andi.l   #$7f0000,d2
00095E 8200 0040 1000 ori.l    #$40000010,d2
000964 C223 C000 0400 move.l   d2,$c00004
00096A C033 C000 0000 move.w   d0,$c00000
000970 754E           rts
000972 0061 1CFF      bsr      $890
000976 0061 30FF      bsr      $8a8
00097A 8642           clr.l    d6
00097C 003C           move.w   d0,d6
00097E 4EE2           lsr.w    #1,d6
000980 8653           subq.l   #1,d6
000982 F945 A100 0030 lea      $a13000,a2
000988 4A26           movea.l  a2,a3
00098A 8B52           addq.l   #1,a3
00098C 3C3A 8200      move.w   #$82,d5
000990 3C38 FF00      move.w   #$ff,d4
000994 524A           tst.w    (a2)
000996 FC6B           bmi.s    $994
000998 D310           move.b   (a3),(a0)+
00099A 8534           move.w   d5,(a2)
00099C 524A           tst.w    (a2)
00099E FC6A           bpl.s    $99c
0009A0 D310           move.b   (a3),(a0)+
0009A2 8434           move.w   d4,(a2)
0009A4 CE51 EEFF      dbf      d6,$994
0009A8 0061 16FF      bsr      $8c0
0009AC 754E           rts
