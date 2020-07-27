000A7A 0061 14FE      bsr      $890
000A7E 1018           move.b   (a0),d4
000A80 017C           moveq    #$1,d6
000A82 1CE8           ror.b    #4,d4
000A84 0410           move.b   d4,d0
000A86 0061 E4FC      bsr      $76c
000A8A 1CE9           rol.b    #4,d4
000A8C 0410           move.b   d4,d0
000A8E CE51 F6FF      dbf      d6,$a86
000A92 754E           rts
000A94 0061 FAFD      bsr      $890
000A98 1038           move.w   (a0),d4
000A9A 037C           moveq    #$3,d6
000A9C 5CE9           rol.w    #4,d4
000A9E 0430           move.w   d4,d0
000AA0 0061 CAFC      bsr      $76c
000AA4 5CE9           rol.w    #4,d4
000AA6 CE51 F6FF      dbf      d6,$a9e
000AAA 754E           rts
000AAC 0061 E2FD      bsr      $890
000AB0 1028           move.l   (a0),d4
000AB2 077C           moveq    #$7,d6
000AB4 9CE9           rol.l    #4,d4
000AB6 0420           move.l   d4,d0
000AB8 0061 B2FC      bsr      $76c
000ABC 9CE9           rol.l    #4,d4
000ABE CE51 F6FF      dbf      d6,$ab6
000AC2 754E           rts
000AC4 0061 CAFD      bsr      $890
000AC8 3C2C 0000 FF00 move.l   #$ff,d6
000ACE 007E           moveq    #0,d7
000AD0 1818           move.b   (a0)+,d4
000AD2 04DE           add.b    d4,d7
000AD4 017A           moveq    #$1,d5
000AD6 1CE9           rol.b    #4,d4
000AD8 0410           move.b   d4,d0
000ADA 0061 90FC      bsr      $76c
000ADE 1CE9           rol.b    #4,d4
000AE0 CD51 F6FF      dbf      d5,$ad8
000AE4 CE51 EAFF      dbf      d6,$ad0
000AE8 0718           move.b   d7,d4
000AEA 017A           moveq    #$1,d5
000AEC 1CE9           rol.b    #4,d4
000AEE 0410           move.b   d4,d0
000AF0 0061 7AFC      bsr      $76c
000AF4 1CE9           rol.b    #4,d4
000AF6 0410           move.b   d4,d0
000AF8 CD51 F6FF      dbf      d5,$af0
000AFC 754E           rts
000AFE FA41 F6F8      lea      $3f6(pc),a0
000B02 1178           moveq    #$11,d4
000B04 1824           move.l   (a0)+,d2
000B06 0776           moveq    #$7,d3
000B08 9AE9           rol.l    #4,d2
000B0A 0210           move.b   d2,d0
000B0C 0061 5EFC      bsr      $76c
000B10 CB51 F6FF      dbf      d3,$b08
000B14 CC51 EEFF      dbf      d4,$b04
000B18 754E           rts
000B1A 3A38 22F9      move.w   $43e(pc),d4
000B1E 037C           moveq    #$3,d6
000B20 5CE9           rol.w    #4,d4
000B22 0430           move.w   d4,d0
000B24 0061 46FC      bsr      $76c
000B28 5CE9           rol.w    #4,d4
000B2A CE51 F6FF      dbf      d6,$b22
000B2E 754E           rts
000B30 3A10 BCF8      move.b   $3ee(pc),d0
000B34 40E1           asl.w    #8,d0
000B36 3A10 B7F8      move.b   $3ef(pc),d0
000B3A 003F           move.w   d0,-(a7)
000B3C 3A3F B6F8      move.w   $3f4(pc),-(a7)
000B40 3A2F AEF8      move.l   $3f0(pc),-(a7)
000B44 017A           moveq    #$1,d5
000B46 1F28           move.l   (a7)+,d4
000B48 077C           moveq    #$7,d6
000B4A 9CE9           rol.l    #4,d4
000B4C 0410           move.b   d4,d0
000B4E 0061 1CFC      bsr      $76c
000B52 9CE9           rol.l    #4,d4
000B54 0410           move.b   d4,d0
000B56 CE51 F6FF      dbf      d6,$b4e
000B5A CD51 EAFF      dbf      d5,$b46
000B5E 754E           rts
000B60 FA41 96FE      lea      $9f8(pc),a0
000B64 FC33 028F C000 move.w   #$8f02,$c00004
000B6C FC23 0000 2000 move.l   #$20,$c00004
000B76 FC23 0000 2000 move.l   #$20,$c00004
000B80 3F72           moveq    #$3f,d1
000B82 3930 C000 0000 move.w   $c00000,d0
000B88 C030           move.w   d0,(a0)+
000B8A C951 F6FF      dbf      d1,$b82
000B8E FA41 68FE      lea      $9f8(pc),a0
000B92 7F7C           moveq    #$7f,d6
000B94 1010           move.b   (a0),d0
000B96 18E8           ror.b    #4,d0
000B98 0061 D2FB      bsr      $76c
000B9C 1810           move.b   (a0)+,d0
000B9E 0061 CCFB      bsr      $76c
000BA2 CE51 F0FF      dbf      d6,$b94
000BA6 754E           rts
000BA8 FA41 4EFE      lea      $9f8(pc),a0
000BAC FC33 028F C000 move.w   #$8f02,$c00004
000BB4 FC23 0000 1000 move.l   #$10,$c00004
000BBE 2772           moveq    #$27,d1
000BC0 3930 C000 0000 move.w   $c00000,d0
000BC6 C030           move.w   d0,(a0)+
000BC8 C951 F6FF      dbf      d1,$bc0
000BCC FA41 2AFE      lea      $9f8(pc),a0
000BD0 4F7C           moveq    #$4f,d6
000BD2 C060           bra.s    $b94
000BD4 0061 D2FC      bsr      $8a8
000BD8 0022           move.l   d0,d1
000BDA 99E1           rol.l    #8,d1
000BDC 99E1           rol.l    #8,d1
000BDE 8102 FF3F 0000 andi.l   #$3fff0000,d1
000BE4 98E0           ror.l    #8,d0
000BE6 98EC           ror.l    #6,d0
000BE8 8002 0000 0300 andi.l   #$3,d0
000BEE 8082           or.l     d0,d1
000BF0 FA41 06FE      lea      $9f8(pc),a0
000BF4 FC33 028F C000 move.w   #$8f02,$c00004
000BFC C123 C000 0400 move.l   d1,$c00004
000C02 0772           moveq    #$7,d1
000C04 3930 C000 0000 move.w   $c00000,d0
000C0A C030           move.w   d0,(a0)+
000C0C C951 F6FF      dbf      d1,$c04
000C10 FA41 E6FD      lea      $9f8(pc),a0
000C14 0F7C           moveq    #$f,d6
000C16 0060 7CFF      bra      $b94
000C1A 0061 A4FC      bsr      $8c0
000C1E 3932 A100 0030 move.w   $a13000,d1
000C24 010C FF00      cmpi.b   #$ff,d1
000C28 F466           bne.s    $c1e
000C2A FA41 12F8      lea      $43e(pc),a0
000C2E 5002 FF7F      andi.w   #$7fff,(a0)
000C32 0060 1A00      bra      $c4e
000C36 0061 88FC      bsr      $8c0
000C3A 3932 A100 0030 move.w   $a13000,d1
000C40 010C FF00      cmpi.b   #$ff,d1
000C44 F466           bne.s    $c3a
000C46 FA41 F6F7      lea      $43e(pc),a0
000C4A 5000 0080      ori.w    #$8000,(a0)
000C4E 7A20 E6F7      movea.l  $436(pc),a0
000C52 604E           move     a0,usp
000C54 FA4F A0F7      lea      $3f6(pc),a7
000C58 1F20           move.l   (a7)+,d0
000C5A 1F22           move.l   (a7)+,d1
000C5C 1F24           move.l   (a7)+,d2
000C5E 1F26           move.l   (a7)+,d3
000C60 1F28           move.l   (a7)+,d4
000C62 1F2A           move.l   (a7)+,d5
000C64 1F2C           move.l   (a7)+,d6
000C66 1F2E           move.l   (a7)+,d7
000C68 5F20           movea.l  (a7)+,a0
000C6A 5F22           movea.l  (a7)+,a1
000C6C 5F24           movea.l  (a7)+,a2
000C6E 5F26           movea.l  (a7)+,a3
000C70 5F28           movea.l  (a7)+,a4
000C72 5F2A           movea.l  (a7)+,a5
000C74 5F2C           movea.l  (a7)+,a6
000C76 7A2E BAF7      movea.l  $432(pc),a7
000C7A 3A2F BEF7      move.l   $43a(pc),-(a7)
000C7E 3A3F BEF7      move.w   $43e(pc),-(a7)
000C82 FC33 FF00 A100 move.w   #$ff,$a13000
000C8A 734E           rte
000C8C 3A28 C2F5      move.l   $250(pc),d4
000C90 9CE0           ror.l    #8,d4
000C92 9CE0           ror.l    #8,d4
000C94 9CE2           ror.l    #1,d4
000C96 017C           moveq    #$1,d6
000C98 1CE8           ror.b    #4,d4
000C9A 0410           move.b   d4,d0
000C9C 0061 CEFA      bsr      $76c
000CA0 1CE9           rol.b    #4,d4
000CA2 0410           move.b   d4,d0
000CA4 CE51 F6FF      dbf      d6,$c9c
000CA8 754E           rts
000CAA 0061 E4FB      bsr      $890
000CAE 0061 F8FB      bsr      $8a8
000CB2 8053           subq.l   #1,d0
000CB4 3C32 0000      move.w   #0,d1
000CB8 0134           move.w   d1,d2
000CBA 1814           move.b   (a0)+,d2
000CBC 42D2           add.w    d2,d1
000CBE C851 FAFF      dbf      d0,$cba
000CC2 0138           move.w   d1,d4
000CC4 0060 D4FD      bra      $a9a
000CC8 0061 1E00      bsr      $ce8
000CCC 0061 C2FB      bsr      $890
000CD0 0061 D6FB      bsr      $8a8
000CD4 48E2           lsr.w    #1,d0
000CD6 4053           subq.w   #1,d0
000CD8 3C32 0000      move.w   #0,d1
000CDC 58D2           add.w    (a0)+,d1
000CDE C851 FCFF      dbf      d0,$cdc
000CE2 0138           move.w   d1,d4
000CE4 0060 B4FD      bra      $a9a
000CE8 FC46 0027      move     #$2700,sr
000CEC B94A A100 0800 tst.l    $a10008
000CF2 0666           bne.s    $cfa
000CF4 794A A100 0C00 tst.w    $a1000c
000CFA 7C66           bne.s    $d78
000CFC FA4B 7C00      lea      $d7a(pc),a5
000D00 9D4C E000      movem.w  (a5)+,d5-d7
000D04 DD4C 001F      movem.l  (a5)+,a0-a4
000D08 2910 01EF      move.b   -$10ff(a1),d0
000D0C 0002 0F00      andi.b   #$f,d0
000D10 0867           beq.s    $d1a
000D12 7C23 4553 4147 move.l   #$53454741,$2f00(a1)
000D1A 1420           move.l   (a4),d0
000D1C 0070           moveq    #0,d0
000D1E 402C           movea.l  d0,a6
000D20 664E           move     a6,usp
000D22 1772           moveq    #$17,d1
000D24 1D1A           move.b   (a5)+,d5
000D26 8538           move.w   d5,(a4)
000D28 87DA           add.l    d7,d5
000D2A C951 F8FF      dbf      d1,$d24
000D2E 9D28           move.l   (a5)+,(a4)
000D30 8026           move.l   d0,(a3)
000D32 8722           move.l   d7,(a1)
000D34 8724           move.l   d7,(a2)
000D36 1101           btst     d0,(a1)
000D38 FC66           bne.s    $d36
000D3A 2574           moveq    #$25,d2
000D3C DD10           move.b   (a5)+,(a0)+
000D3E CA51 FCFF      dbf      d2,$d3c
000D42 8024           move.l   d0,(a2)
000D44 8022           move.l   d0,(a1)
000D46 8724           move.l   d7,(a2)
000D48 2620           move.l   -(a6),d0
000D4A CE51 FCFF      dbf      d6,$d48
000D4E 0070           moveq    #0,d0
000D50 9D28           move.l   (a5)+,(a4)
000D52 9D28           move.l   (a5)+,(a4)
000D54 1F76           moveq    #$1f,d3
000D56 8026           move.l   d0,(a3)
000D58 CB51 FCFF      dbf      d3,$d56
000D5C 9D28           move.l   (a5)+,(a4)
000D5E 1378           moveq    #$13,d4
000D60 8026           move.l   d0,(a3)
000D62 CC51 FCFF      dbf      d4,$d60
000D66 037A           moveq    #$3,d5
000D68 5D17 1100      move.b   (a5)+,$11(a3)
000D6C CD51 FAFF      dbf      d5,$d68
000D70 D64C FF7F      movem.l  (a6),d0-d7/a0-a6
000D74 FC46 0027      move     #$2700,sr
000D78 6C60           bra.s    $de6
000D7A 0080           or.b     d0,d0
000D7C FF3F           move.w   ?,?
000D7E 0001           btst     d0,d0
000D80 A000 0000 A100 ori.l    #$a1,-(a0)
000D86 0011           move.b   d0,-(a0)
000D88 A100 0012 C000 ori.l    #$120000c0,-(a1)
000D8E 0000 C000      ori.b    #$c0,d0
000D92 0400 3404      ori.b    #$34,d4
000D96 3C30 6C07      move.w   #$76c,d0
000D9A 0000 0000      ori.b    #0,d0
000D9E 00FF           dc.w     $ff00
000DA0 3781 0100      or.b     d0,$1(a7,d0.w)
000DA4 0001           btst     d0,d0
000DA6 FF00           dc.w     $00ff
000DA8 00FF           dc.w     $ff00
000DAA 8000 0040 8000 ori.l    #$40000080,d0
000DB0 01AF           dc.w     $af01
000DB2 1FD9           add.b    d4,(a7)+
000DB4 2711           move.b   -(a7),-(a0)
000DB6 2100 0026      ori.b    #0,-(a1)
000DBA 77F9           dc.w     $f977
000DBC B0ED           roxl.l   d6,d0
000DBE E1DD           adda.l   -(a1),a6
000DC0 E1FD           dc.w     $fde1
000DC2 47ED           asl.w    #6,d7
000DC4 4FED           lsl.w    #6,d7
000DC6 E1D1           adda.l   -(a1),a0
000DC8 08F1           dc.w     $f108
000DCA C1D9           adda.l   d1,a4
000DCC E1D1           adda.l   -(a1),a0
000DCE F9F1           dc.w     $f1f9
000DD0 EDF3           dc.w     $f3ed
000DD2 3656 E9E9      addq.b   #3,-$17(a6,a6.l)
000DD6 2481           or.b     d0,-(a4)
000DD8 028F           sbcd     d2,d7
000DDA 00C0           and.b    d0,d0
000DDC 0000 0040      ori.b    #0,d0
000DE0 1000 BF9F      ori.b    #$bf,(a0)
000DE4 FFDF           adda.l   ?,a7
000DE6 0A7C           moveq    #$a,d6
000DE8 0061 5401      bsr      $f3e
000DEC FC33 4481 C000 move.w   #$8144,$c00004
000DF4 FC33 0090 C000 move.w   #$9000,$c00004
000DFC FA41 0202      lea      $1000(pc),a0
000E00 FC23 2040 0000 move.l   #$40200000,$c00004
000E0A 3C20 0000 A005 move.l   #$5a0,d0
000E10 D833 C000 0000 move.w   (a0)+,$c00000
000E16 C851 F8FF      dbf      d0,$e10
000E1A FA41 640D      lea      $1b80(pc),a0
000E1E FC23 00C0 0000 move.l   #$c0000000,$c00004
000E28 0F70           moveq    #$f,d0
000E2A D833 C000 0000 move.w   (a0)+,$c00000
000E30 C851 F8FF      dbf      d0,$e2a
000E34 FC23 5841 0300 move.l   #$41580003,$c00004
000E3E 0C70           moveq    #$c,d0
000E40 8142           clr.l    d1
000E42 C133 C000 0000 move.w   d1,$c00000
000E48 4152           addq.w   #1,d1
000E4A C851 F6FF      dbf      d0,$e42
000E4E FC23 9A41 0300 move.l   #$419a0003,$c00004
000E58 0B70           moveq    #$b,d0
000E5A C133 C000 0000 move.w   d1,$c00000
000E60 4152           addq.w   #1,d1
000E62 C851 F6FF      dbf      d0,$e5a
000E66 FC23 DA41 0300 move.l   #$41da0003,$c00004
000E70 0B70           moveq    #$b,d0
000E72 C133 C000 0000 move.w   d1,$c00000
000E78 4152           addq.w   #1,d1
000E7A C851 F6FF      dbf      d0,$e72
000E7E FC23 1A42 0300 move.l   #$421a0003,$c00004
000E88 0B70           moveq    #$b,d0
000E8A C133 C000 0000 move.w   d1,$c00000
000E90 4152           addq.w   #1,d1
000E92 C851 F6FF      dbf      d0,$e8a
000E96 027E           moveq    #$2,d7
000E98 FA41 1A01      lea      $fb4(pc),a0
000E9C 8142           clr.l    d1
000E9E FA43 B000      lea      $f50(pc),a1
000EA2 D823 C000 0400 move.l   (a0)+,$c00004
000EA8 1812           move.b   (a0)+,d1
000EAA 0067 1800      beq      $ec4
000EAE 4104 2000      subi.w   #$20,d1
000EB2 3110 0010      move.b   0(a1,d1.w),d0
000EB6 8002 0000 FF00 andi.l   #$ff,d0
000EBC C033 C000 0000 move.w   d0,$c00000
000EC2 E460           bra.s    $ea8
000EC4 CF51 DCFF      dbf      d7,$ea2
000EC8 FA41 C600      lea      $f90(pc),a0
000ECC 3A22 82F3      move.l   $250(pc),d1
000ED0 89E0           lsr.l    #8,d1
000ED2 89E0           lsr.l    #8,d1
000ED4 8102 0000 FF00 andi.l   #$ff,d1
000EDA FC23 E843 0300 move.l   #$43e80003,$c00004
000EE4 3010 0010      move.b   0(a0,d1.w),d0
000EE8 8002 0000 FF00 andi.l   #$ff,d0
000EEE C033 C000 0000 move.w   d0,$c00000
000EF4 3010 0110      move.b   $1(a0,d1.w),d0
000EF8 8002 0000 FF00 andi.l   #$ff,d0
000EFE C033 C000 0000 move.w   d0,$c00000
000F04 754E           rts
000F06 002F           move.l   d0,-(a7)
000F08 012F           move.l   d1,-(a7)
000F0A 092F           move.l   a1,-(a7)
000F0C FA43 4200      lea      $f50(pc),a1
000F10 D823 C000 0400 move.l   (a0)+,$c00004
000F16 8042           clr.l    d0
000F18 8142           clr.l    d1
000F1A 1812           move.b   (a0)+,d1
000F1C 0067 1800      beq      $f36
000F20 4104 2000      subi.w   #$20,d1
000F24 3110 0010      move.b   0(a1,d1.w),d0
000F28 8002 0000 FF00 andi.l   #$ff,d0
000F2E C033 C000 0000 move.w   d0,$c00000
000F34 E460           bra.s    $f1a
000F36 5F22           movea.l  (a7)+,a1
000F38 1F22           move.l   (a7)+,d1
000F3A 1F20           move.l   (a7)+,d0
000F3C 754E           rts
000F3E 3C2E 0000 FF0F move.l   #$fff,d7
000F44 714E           nop
000F46 CF51 FCFF      dbf      d7,$f44
000F4A CE51 F2FF      dbf      d6,$f3e
000F4E 754E           rts
