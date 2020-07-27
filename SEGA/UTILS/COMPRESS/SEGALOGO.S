*****************************************************************************
*				Sega Logo Code				    *
*				and character I/O routines		    *		
*****************************************************************************

        include equates.i
	include macros.i

                                        
BssGroup	group	Bss

	section	.bss,BssGroup
_VdpShadow:     ds.b    24      ; Echo's of VDP registers
                                        
_ScreenCol	ds.w	1
_ScreenRow	ds.w	1
_SYS_LastChar	ds.w	1

        section .text
                                        
_SegaLogo:
	if	(SEGALOGO)

	move.w	#$2700,sr
	lea	LogoCycle,a1	; ptr to start of cycle
	move.l  #$c00e0000,$C00004.L ; cram_wrt_addr(e)
	moveq   #8,d0           ; ctr for num of colors
loadPal:
	move.w  (a1)+,VDATA ; cram_wrt_data
	dbra    d0,loadPal

	move.w	#$2000,sr

	lea.l   LogoChars,a0    ; A0 = *LogoChars
	move.w	#$20,d0
	move.w	#48*32,d1
	jsr	addDMAQueue
*
* Here's where we're going to write out the logo map - map A points
* to _ScrAAddr.
*
	lea	mapBuff,a0
	adda.w	#$51c,a0	; add in offset for logo
	moveq.l	#1,d1           ; overall char counter
	moveq.l #3,d3
	move.w	#128-24,d4
newrow:
	moveq.l #11,D0          ; Row counter
wrtrow1:
	move.w	d1,(a0)+        ; write 1st row
	addq.w	#1,d1           ; next char
	dbra	d0,wrtrow1
	adda.w	d4,a0
	dbra	d3,newrow

	lea	mapBuff,a0
	move.w	_ScrAaddr,d0
	move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
	jsr	addDMAQueue
	jsr	waitDMAQueue

                                        
*;;;;;;;;;;;; CYCLE THE LOGO HERE! ;;;;;;;;;;;;;;;;;;;;;;;;;
_cycleLogo:
	lea     LogoCycle,a0    ; a0 = *LogoCycle
	addi    #32,a0          
	move    #16,d1          ; ctr for num of cycles
	move    #$3f,d6         ; delay
;	jsr     delay           
stcycl:
	move    a0,a1           ; ptr to start of cycle
	move.l  #$c00e0000,$C00004.L ; cram_wrt_addr(e)
	moveq   #8,d0           ; ctr for num of colors
	jsr	_waitVBL
cyc:
	move.w  (a1)+,VDATA ; cram_wrt_data
	dbra    d0,cyc          
	move.l  #$08,d6         ; delay
	jsr     delay           
	subq    #2,a0           ; next cycle
	dbra    d1,stcycl       
	endif
	rts                     ; Back again!
delay:
	move.l  #$fff,d7        ; Call with delay value in D6
dt:	nop                     
	dbra    d7,dt           
	dbra    d6,delay
	rts

                                        


*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*; FUNCTION:     putchx  - console I/O function!
*; DESCRIPTION:  Console I/O to the Genesis screen - Assumes that the Genesis
*;               is in a 40 col mode.
*;               MAP A will receive the text, the ASCII font shoud have been
*;               loaded. MAP A should be located at _ScrAAddr
*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_putchx:
	move.w  _ScreenRow,D1
	lsl.w   #6,D1           ; D0=(ScreenRow*64+ScreenCol)*2
	add.w   _ScreenCol,D1   ;
	lsl.w   #1,D1
	add.w   _ScrAAddr,D1	; adjust for address...
	CalcVramWrtAddrCode D1,D2
	move.l  D2,VCTRL        ; Set vram write address
	cmp.b   #10,D0          ; Is linefeed?
	bne     PC_1
	addq.w  #1,_ScreenRow
	bra     PC_3
PC_1:   
	cmp.b   #13,D0          ; is a CR?
	bne     PC_2
	move.w  #0,_ScreenCol
	bra     PC_3
PC_2:   
	sub.w   #32,d0          ; Adjust for our character set
	move.w  d0,VDATA        ; and set the map
	addq.w  #1,_ScreenCol
PC_3:   
	cmp.w   #39,_ScreenCol  ; At last col?
	bls     PC_4
	addq.w  #1,_ScreenRow
	move.w  #0,_ScreenCol   ; If so, go to the next row
PC_4:   
	cmp.w   #26,_ScreenRow  ; At last row?
	bls     PC_5            ; No, go around
*
* Scroll the screen up here
*
	AutoIncrement   1
	ShadowRegister  1,D0    ; Load whatever the prev register value was..
	or.b    #$10,D0         ; Enable DMA
	SetVdpRegisterCode 1,D0
	SetVdpRegister  19,$00
	SetVdpRegister  20,$0D  ; Setup DMA length
	SetVdpRegister  21,$80
	SetVdpRegister  22,$C0  ; DMA source address - $c080
	SetVdpRegister  23,$C0  ; DMA VRAM copy mode...
	MOVE.L  #$000000C3,VCTRL         ;Set DMA destination
** We should be DMA'ing now
PC_4A:  
	MOVE.W  VCTRL,D0
	BTST    #1,D0
	BNE     PC_4A           ; Wait for DMA
	SUBQ.W  #1,_ScreenRow

PC_5:
	rts

*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*; FUNCTION:     puts  - console I/O function!
*; DESCRIPTION:  print the string on the genesis screen - Assumes that the Genesis
*;               is in a 40 col mode.
*;               MAP A will receive the text, the ASCII font shoud have been
*;               loaded. MAP A should be located at _ScrAAddr
*; PARAMETERS:
*;		A0 = address of NULL terminated 'C' string
*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
puts
	moveq.l	#0,d0
.loop
	move.b	(a0)+,d0
	beq	.fini
	movem.l	a0/d0,-(a7)
	jsr	_putchx
	movem.l	(a7)+,a0/d0
	bra.s	.loop
.fini
	rts
	

LogoChars:
*****************************************************************************
*Character Set for the SEGA startup logo
*****************************************************************************
* Char #0
                dc.l    $00000000,$00000111,$00011BBC,$001ABBBB
                dc.l    $01AABBBB,$01AAABBB,$1AAAABB1,$19AAAA1B
* Char #1
                dc.l    $00000000,$11111111,$CCCDDDDE,$CCCCDDDD
                dc.l    $CCCCDDDD,$BCCCCDDD,$11111111,$BBCCCCDD
* Char #2
                dc.l    $00000000,$11111100,$EEEFF100,$EEEEF101
                dc.l    $EEEEF11A,$DEEEE11A,$111111AA,$DDEEE1AA
* Char #3
                dc.l    $00000000,$00111111,$11BBCCCC,$BBBBCCCC
                dc.l    $ABBBBCCC,$ABBBBCCC,$AABBB111,$AABB1BCC
* Char #4
                dc.l    $00000000,$11111111,$DDDDEEEE,$DDDDEEEE
                dc.l    $CDDDDEEE,$CDDDDEEE,$11111111,$CCDDDDEE
* Char #5
                dc.l    $00000000,$11110000,$FFF10011,$FFF101BB
                dc.l    $EFF11ABB,$EFF11ABB,$1111AAAB,$EEF1AAAB
* Char #6
                dc.l    $00000000,$11111111,$BCCCCDDD,$BCCCCDDD
                dc.l    $BBCCCCDD,$BBCCCCDD,$BBB11111,$B11CCCCD
* Char #7
                dc.l    $00000000,$11111111,$DEEEEFFF,$DEEEEFFF
                dc.l    $DDEEEEFF,$DDEEEEFF,$11111111,$DDDEEEEF
* Char #8
                dc.l    $00000000,$11000000,$F1000000,$F1000000
                dc.l    $F1000000,$F1000000,$11000000,$F1000001
* Char #9
                dc.l    $00000000,$00000111,$00011DDD,$001CCDDD
                dc.l    $01CCCDDD,$1BCCCCDD,$1BCCCCDD,$BBBCCC11
* Char #10
                dc.l    $00001111,$10000010,$E1100010,$DEE10010
                dc.l    $DEEE1010,$DDEEE100,$DDEEE100,$DDDEEE10
* Char #11
                dc.l    $10100001,$00110011,$00101101,$00100001
                dc.l    $00100001,$00000000,$00000000,$00000000
* Char #12
                dc.l    $19AAA1BB,$199AA1AB,$199AA1AB,$1999A1AA
                dc.l    $1999A1AA,$199991AA,$199991AA,$1899991A
* Char #13
                dc.l    $BBCCCCDD,$BBBCCCCD,$BBBCCCCD,$BB111111
                dc.l    $BBBBCCCC,$ABBBBCCC,$ABBBBCCC,$AABBBBCC
* Char #14
                dc.l    $DDEEE19A,$DDDEE19A,$DDDEE199,$11111199
                dc.l    $11111199,$CD111199,$CDD11199,$CCDD1199
* Char #15
                dc.l    $AAA1BBBC,$AAA1BBBC,$AAA1BBBB,$AAA1BBB1
                dc.l    $9AA1ABBB,$9AA1ABBB,$99A1AABB,$99A1AABB
* Char #16
                dc.l    $CCCDDDDE,$CCCDDDDE,$CCCCDDDD,$11111111
                dc.l    $BCCCCDDD,$BCCCCDDD,$BBCCCCDD,$BBCCCCDD
* Char #17
                dc.l    $EEE1AAAA,$EEE19AAA,$EEE19AAA,$111199AA
                dc.l    $D11199AA,$D111999A,$D111999A,$D1119999
* Char #18
                dc.l    $1BBBCCCC,$1BBBBCCC,$1BBBBCCC,$1ABBB111
                dc.l    $1ABBB1CC,$1AABB1BC,$1AABB1BC,$1AAAB1BB
* Char #19
                dc.l    $DDDDEEEE,$CDDDEEEE,$CDDDDEEE,$11111111
                dc.l    $CCDDDDEE,$CCCDDDEE,$CCCDDDDE,$CCCCDDDE
* Char #20
                dc.l    $F1000001,$F1000001,$E100001A,$1100001A
                dc.l    $E100001A,$E10001AA,$E10001AA,$E100019A
* Char #21
                dc.l    $BBBCCC11,$BBBBC1CC,$BBBBC1CC,$ABBBB1CC
                dc.l    $ABBB1CCC,$AABB1BCC,$AABB1BCC,$AAA1BBBC
* Char #22
                dc.l    $DDDEEE10,$1DDDEE10,$1DDDEEE1,$1DDDDEE1
                dc.l    $C1DDDEE1,$C1DDDDEE,$C1DDDDEE,$CC1DDDDE
* Char #23
                dc.l    $00000000,$00000000,$00000000,$00000000
                dc.l    $00000000,$10000000,$10000000,$10000000
* Char #24
                dc.l    $019999A1,$0189999A,$0019999A,$00189999
                dc.l    $00011199,$11111111,$18888999,$18888899
* Char #25
                dc.l    $1111111C,$AAABBBB1,$AAABBBBC,$AAAABBBB
                dc.l    $AAAABBBB,$1111ABBB,$9AAAABBB,$99AAAABB
* Char #26
                dc.l    $CCDD1189,$CCCDD189,$1CCDD188,$1CCCD188
                dc.l    $1CCCD188,$1CCCC188,$1CCCC188,$1BCCC188
* Char #27
                dc.l    $99911111,$9991AAAB,$9991AAAA,$9991AAAA
                dc.l    $89919AAA,$89919AA1,$889199AA,$889199AA
* Char #28
                dc.l    $11111111,$BBBCCCCD,$BBBBCCCC,$BBBBCCCC
                dc.l    $ABBBBCCC,$11111111,$AABBBBCC,$AABBBBCC
* Char #29
                dc.l    $11119999,$D1118999,$D1118999,$D1118899
                dc.l    $C1118899,$11118889,$CCD18889,$CCD18888
* Char #30
                dc.l    $1AAAB111,$1AAAA1BB,$1AAAA1BB,$19AAA1BB
                dc.l    $19AAA1BB,$199AA111,$199AAAAB,$1999AAAA
* Char #31
                dc.l    $11111DDD,$BCCC1DDD,$BCCC1DDD,$BBCC1CDD
                dc.l    $BBCC1CDD,$BBBC1CCD,$BBBC1CCD,$BBBB1CCC
* Char #32
                dc.l    $E100199A,$E1001999,$D1001999,$D1018999
                dc.l    $D1018999,$D1018899,$D1188899,$D1188889
* Char #33
                dc.l    $AAA1BBBC,$AAA1BBBB,$AA1ABBBB,$9A1AABBB
                dc.l    $9A1AAB11,$91AAAA11,$91AAAABB,$919AAAAB
* Char #34
                dc.l    $CC1DDDDE,$CC1CDDDD,$CCC1DDDD,$BCC1CDDD
                dc.l    $BCC1CDDD,$BBCC1CDD,$BBCC1CDD,$BBBC1CCD
* Char #35
                dc.l    $E1000000,$E1000000,$E1000000,$DE100000
                dc.l    $DE100000,$DD100000,$DDE10000,$DDD10000
* Char #36
                dc.l    $17888899,$17788889,$11111111,$17778888
                dc.l    $17778888,$17777888,$17777888,$11111111
* Char #37
                dc.l    $99AAAABB,$999AAAA1,$1111111B,$9999AAAA
                dc.l    $9999AAAA,$89999AAA,$89999AAA,$11111111
* Char #38
                dc.l    $1BCCC178,$BBBCC178,$BBBCC177,$BBBB1017
                dc.l    $BBBB1017,$ABB10001,$A1100000,$10000000
* Char #39
                dc.l    $8881999A,$8889199A,$88889111,$88889999
                dc.l    $78888999,$78888999,$11888899,$00111111
* Char #40
                dc.l    $AAABBBBC,$AAABBBBC,$11111111,$AAAABBBB
                dc.l    $9AAAABBB,$9AAAABBB,$99AAAABB,$11111111
* Char #41
                dc.l    $CCC17888,$CCC17888,$11111788,$CCC11788
                dc.l    $BCC11778,$BCC10178,$BBC10011,$11110000
* Char #42
                dc.l    $1999AAAA,$81199AAA,$88911111,$889999AA
                dc.l    $8889999A,$8889999A,$88889999,$11111111
* Char #43
                dc.l    $BBBB1CCC,$ABBB1CCC,$11111BCC,$AABBBBCC
                dc.l    $AAABBBBC,$AAABBBBC,$AAAABBBB,$11111111
* Char #44
                dc.l    $D1788889,$C1778888,$CC778888,$CC777881
                dc.l    $CC777881,$CC777781,$CC777781,$11111111
* Char #45
                dc.l    $199AAAAB,$1999AAAA,$19991111,$89991AAA
                dc.l    $89911AAA,$889119AA,$881119AA,$11111111
* Char #46
                dc.l    $BBBCC1CD,$BBBBC1CC,$111111CC,$ABBBBCCC
                dc.l    $ABBBBCCC,$AABBBBCC,$AABBBBCC,$11111111
* Char #47
                dc.l    $DDD10000,$DDDD1000,$DDDD1000,$CDDD1000
                dc.l    $CDDDD100,$CCDDD100,$CCDDD100,$11111100

*----------------------------------------------------------------------------
*Character Set from textfont.gen - In ASCII Order, starts at char #48, which
* is a space (Add 16 to ascii to get text on the screen
*----------------------------------------------------------------------------
* Char #0
CharSet:
	DC.L	$00000000,$00000000,$00000000,$00000000
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #1
	DC.L	$00110000,$00110000,$00110000,$00110000
	DC.L	$00110000,$00000000,$00110000,$00000000
* Char #2
	DC.L	$01101100,$01101100,$01101100,$00000000
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #3
	DC.L	$01101100,$01101100,$11111110,$01101100
	DC.L	$11111110,$01101100,$01101100,$00000000
* Char #4
	DC.L	$00110000,$01111100,$11000000,$01111000
	DC.L	$00001100,$11111000,$00110000,$00000000
* Char #5
	DC.L	$00000000,$11000110,$11001100,$00011000
	DC.L	$00110000,$01100110,$11000110,$00000000
* Char #6
	DC.L	$00111000,$01101100,$00111000,$01110110
	DC.L	$11011100,$11001100,$01110110,$00000000
* Char #7
	DC.L	$01100000,$01100000,$11000000,$00000000
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #8
	DC.L	$00011000,$00110000,$01100000,$01100000
	DC.L	$01100000,$00110000,$00011000,$00000000
* Char #9
	DC.L	$01100000,$00110000,$00011000,$00011000
	DC.L	$00011000,$00110000,$01100000,$00000000
* Char #10
	DC.L	$00000000,$01100110,$00111100,$11111111
	DC.L	$00111100,$01100110,$00000000,$00000000
* Char #11
	DC.L	$00000000,$00110000,$00110000,$11111100
	DC.L	$00110000,$00110000,$00000000,$00000000
* Char #12
	DC.L	$00000000,$00000000,$00000000,$00000000
	DC.L	$00000000,$00110000,$00110000,$01100000
* Char #13
	DC.L	$00000000,$00000000,$00000000,$11111100
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #14
	DC.L	$00000000,$00000000,$00000000,$00000000
	DC.L	$00000000,$00110000,$00110000,$00000000
* Char #15
	DC.L	$00000110,$00001100,$00011000,$00110000
	DC.L	$01100000,$11000000,$10000000,$00000000
* Char #16
	DC.L	$01111100,$11000110,$11001110,$11011110
	DC.L	$11110110,$11100110,$01111100,$00000000
* Char #17
	DC.L	$00110000,$01110000,$00110000,$00110000
	DC.L	$00110000,$00110000,$01111000,$00000000
* Char #18
	DC.L	$11111000,$00001100,$00001100,$00111000
	DC.L	$01100000,$11000000,$11111100,$00000000
* Char #19
	DC.L	$11111000,$00001100,$00001100,$00111000
	DC.L	$00001100,$00001100,$11111000,$00000000
* Char #20
	DC.L	$00011100,$00111100,$01101100,$11001100
	DC.L	$11111110,$00001100,$00001100,$00000000
* Char #21
	DC.L	$11111100,$11000000,$11111000,$00001100
	DC.L	$00001100,$00001100,$11111000,$00000000
* Char #22
	DC.L	$00111100,$01100000,$11000000,$11111000
	DC.L	$11001100,$11001100,$01111000,$00000000
* Char #23
	DC.L	$11111100,$00001100,$00011000,$00110000
	DC.L	$01100000,$11000000,$11000000,$00000000
* Char #24
	DC.L	$01111000,$11001100,$11001100,$01111000
	DC.L	$11001100,$11001100,$01111000,$00000000
* Char #25
	DC.L	$01111000,$11001100,$11001100,$01111100
	DC.L	$00001100,$00001100,$01111000,$00000000
* Char #26
	DC.L	$00000000,$00110000,$00110000,$00000000
	DC.L	$00000000,$00110000,$00110000,$00000000
* Char #27
	DC.L	$00000000,$00110000,$00110000,$00000000
	DC.L	$00000000,$00110000,$00110000,$01100000
* Char #28
	DC.L	$00011000,$00110000,$01100000,$11000000
	DC.L	$01100000,$00110000,$00011000,$00000000
* Char #29
	DC.L	$00000000,$00000000,$11111100,$00000000
	DC.L	$00000000,$11111100,$00000000,$00000000
* Char #30
	DC.L	$01100000,$00110000,$00011000,$00001100
	DC.L	$00011000,$00110000,$01100000,$00000000
* Char #31
	DC.L	$11111000,$00001100,$00001100,$00111000
	DC.L	$00110000,$00000000,$00110000,$00000000
* Char #32
	DC.L	$01111100,$11000110,$11011110,$11011110
	DC.L	$11011110,$11000000,$01111000,$00000000
* Char #33
	DC.L	$00110000,$01111000,$11001100,$11001100
	DC.L	$11111100,$11001100,$11001100,$00000000
* Char #34
	DC.L	$11111000,$11001100,$11001100,$11111000
	DC.L	$11001100,$11001100,$11111000,$00000000
* Char #35
	DC.L	$01111100,$11000000,$11000000,$11000000
	DC.L	$11000000,$11000000,$01111100,$00000000
* Char #36
	DC.L	$11111000,$11001100,$11001100,$11001100
	DC.L	$11001100,$11001100,$11111000,$00000000
* Char #37
	DC.L	$11111100,$11000000,$11000000,$11111000
	DC.L	$11000000,$11000000,$11111100,$00000000
* Char #38
	DC.L	$11111100,$11000000,$11000000,$11111000
	DC.L	$11000000,$11000000,$11000000,$00000000
* Char #39
	DC.L	$01111100,$11000000,$11000000,$11000000
	DC.L	$11011100,$11001100,$01111100,$00000000
* Char #40
	DC.L	$11001100,$11001100,$11001100,$11111100
	DC.L	$11001100,$11001100,$11001100,$00000000
* Char #41
	DC.L	$01111000,$00110000,$00110000,$00110000
	DC.L	$00110000,$00110000,$01111000,$00000000
* Char #42
	DC.L	$00011110,$00001100,$00001100,$00001100
	DC.L	$00001100,$00001100,$11111000,$00000000
* Char #43
	DC.L	$11000110,$11001100,$11011000,$11110000
	DC.L	$11011000,$11001100,$11000110,$00000000
* Char #44
	DC.L	$11000000,$11000000,$11000000,$11000000
	DC.L	$11000000,$11000000,$11111100,$00000000
* Char #45
	DC.L	$11000110,$11101110,$11111110,$11010110
	DC.L	$11000110,$11000110,$11000110,$00000000
* Char #46
	DC.L	$11000110,$11100110,$11110110,$11011110
	DC.L	$11001110,$11000110,$11000110,$00000000
* Char #47
	DC.L	$01111000,$11001100,$11001100,$11001100
	DC.L	$11001100,$11001100,$01111000,$00000000
* Char #48
	DC.L	$11111000,$11001100,$11001100,$11111000
	DC.L	$11000000,$11000000,$11000000,$00000000
* Char #49
	DC.L	$01111000,$11001100,$11001100,$11001100
	DC.L	$11001100,$11011000,$01101100,$00000000
* Char #50
	DC.L	$11111000,$11001100,$11001100,$11111000
	DC.L	$11110000,$11011000,$11001100,$00000000
* Char #51
	DC.L	$01111100,$11000000,$11000000,$01111000
	DC.L	$00001100,$00001100,$11111000,$00000000
* Char #52
	DC.L	$11111100,$00110000,$00110000,$00110000
	DC.L	$00110000,$00110000,$00110000,$00000000
* Char #53
	DC.L	$11001100,$11001100,$11001100,$11001100
	DC.L	$11001100,$11001100,$01111100,$00000000
* Char #54
	DC.L	$11001100,$11001100,$11001100,$11001100
	DC.L	$11001100,$01111000,$00110000,$00000000
* Char #55
	DC.L	$11000110,$11000110,$11000110,$11010110
	DC.L	$11111110,$11101110,$11000110,$00000000
* Char #56
	DC.L	$11000110,$11000110,$01101100,$00111000
	DC.L	$01101100,$11000110,$11000110,$00000000
* Char #57
	DC.L	$11001100,$11001100,$11001100,$01111000
	DC.L	$00110000,$00110000,$00110000,$00000000
* Char #58
	DC.L	$11111110,$00001100,$00011000,$00110000
	DC.L	$01100000,$11000000,$11111110,$00000000
* Char #59
	DC.L	$01111000,$01100000,$01100000,$01100000
	DC.L	$01100000,$01100000,$01111000,$00000000
* Char #60
	DC.L	$11000000,$01100000,$00110000,$00011000
	DC.L	$00001100,$00000110,$00000010,$00000000
* Char #61
	DC.L	$01111000,$00011000,$00011000,$00011000
	DC.L	$00011000,$00011000,$01111000,$00000000
* Char #62
	DC.L	$00010000,$00111000,$01101100,$11000110
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #63
	DC.L	$00000000,$00000000,$00000000,$00000000
	DC.L	$00000000,$00000000,$00000000,$11111111
* Char #64
	DC.L	$00110000,$00110000,$00011000,$00000000
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #65
	DC.L	$00000000,$00000000,$11111000,$00001100
	DC.L	$01111100,$11001100,$01111100,$00000000
* Char #66
	DC.L	$11000000,$11000000,$11111000,$11001100
	DC.L	$11001100,$11001100,$11111000,$00000000
* Char #67
	DC.L	$00000000,$00000000,$01111100,$11000000
	DC.L	$11000000,$11000000,$01111100,$00000000
* Char #68
	DC.L	$00001100,$00001100,$01111100,$11001100
	DC.L	$11001100,$11001100,$01111100,$00000000
* Char #69
	DC.L	$00000000,$00000000,$01111000,$11001100
	DC.L	$11111100,$11000000,$01111100,$00000000
* Char #70
	DC.L	$00111100,$01100000,$01100000,$11111000
	DC.L	$01100000,$01100000,$01100000,$00000000
* Char #71
	DC.L	$00000000,$00000000,$01111100,$11001100
	DC.L	$11001100,$01111100,$00001100,$11111000
* Char #72
	DC.L	$11000000,$11000000,$11111000,$11001100
	DC.L	$11001100,$11001100,$11001100,$00000000
* Char #73
	DC.L	$00110000,$00000000,$00110000,$00110000
	DC.L	$00110000,$00110000,$00110000,$00000000
* Char #74
	DC.L	$00011000,$00000000,$00011000,$00011000
	DC.L	$00011000,$00011000,$00011000,$11110000
* Char #75
	DC.L	$11000000,$11000000,$11001100,$11011000
	DC.L	$11110000,$11011000,$11001100,$00000000
* Char #76
	DC.L	$01110000,$00110000,$00110000,$00110000
	DC.L	$00110000,$00110000,$00110000,$00000000
* Char #77
	DC.L	$00000000,$00000000,$11000110,$11111110
	DC.L	$11010110,$11000110,$11000110,$00000000
* Char #78
	DC.L	$00000000,$00000000,$11111000,$11001100
	DC.L	$11001100,$11001100,$11001100,$00000000
* Char #79
	DC.L	$00000000,$00000000,$01111000,$11001100
	DC.L	$11001100,$11001100,$01111000,$00000000
* Char #80
	DC.L	$00000000,$00000000,$11111000,$11001100
	DC.L	$11001100,$11001100,$11111000,$11000000
* Char #81
	DC.L	$00000000,$00000000,$01111100,$11001100
	DC.L	$11001100,$11001100,$01111100,$00001100
* Char #82
	DC.L	$00000000,$00000000,$11011100,$11100000
	DC.L	$11000000,$11000000,$11000000,$00000000
* Char #83
	DC.L	$00000000,$00000000,$01111100,$11000000
	DC.L	$01111000,$00001100,$11111000,$00000000
* Char #84
	DC.L	$01100000,$01100000,$11111100,$01100000
	DC.L	$01100000,$01100000,$00111100,$00000000
* Char #85
	DC.L	$00000000,$00000000,$11001100,$11001100
	DC.L	$11001100,$11001100,$01111100,$00000000
* Char #86
	DC.L	$00000000,$00000000,$11001100,$11001100
	DC.L	$11001100,$01111000,$00110000,$00000000
* Char #87
	DC.L	$00000000,$00000000,$11000110,$11000110
	DC.L	$11010110,$11111110,$11000110,$00000000
* Char #88
	DC.L	$00000000,$00000000,$11000110,$01101100
	DC.L	$00111000,$01101100,$11000110,$00000000
* Char #89
	DC.L	$00000000,$00000000,$11001100,$11001100
	DC.L	$11001100,$01111100,$00001100,$11111000
* Char #90
	DC.L	$00000000,$00000000,$11111100,$00011000
	DC.L	$00110000,$01100000,$11111100,$00000000
* Char #91
	DC.L	$00011100,$00110000,$00110000,$11100000
	DC.L	$00110000,$00110000,$00011100,$00000000
* Char #92
	DC.L	$00011000,$00011000,$00011000,$00000000
	DC.L	$00011000,$00011000,$00011000,$00000000
* Char #93
	DC.L	$11100000,$00110000,$00110000,$00011100
	DC.L	$00110000,$00110000,$11100000,$00000000
* Char #94
	DC.L	$01110110,$11011100,$00000000,$00000000
	DC.L	$00000000,$00000000,$00000000,$00000000
* Char #95
	DC.L	$00000000,$00010000,$00111000,$01101100
	DC.L	$11000110,$11000110,$11111110,$00000000

*****************************************************************************
*Palette info.
*****************************************************************************
* Initial palette
LogoPalette:
                dc.w    $111,$EEE,$EEE,$EEE,$EEE,$EEE,$EEE
LogoCycle:
                dc.w    $EA0,$E80,$E60,$E40,$E20,$E00,$C00,$A00,$800
                dc.w    $A00,$C00,$E00,$E20,$E40,$E60,$E80,$EA0,$E80
                dc.w    $E60,$E40,$E20,$E00,$C00,$A00,$800



		include	globals.i

