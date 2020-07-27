;{----------------------------------------------------------------------}
;{	test.S								}
;{	test sprite routines:						}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}
	even

	include	macros.i
	include equates.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}

BssGroup	group	Bss

		section	.bss,BssGroup

bcolor		ds.w	1
_ScrAAddr	ds.w	1	; address of Scroll A screen
_ScrBAddr	ds.w	1	; address of Scroll B screen
_VCount		ds.l	1
Score1		ds.w	SCORESIZE/2
wallChar	ds.w	1
_SprAttrAddr	ds.w	1
crosshairX	ds.w	1
crosshairY	ds.w	1
crosshairChar	ds.w	1

CrossHairUpdated ds.w	1	; crosshair was updated
DMATemp		ds.l	1

lastLevelMap	ds.l	1
curLevelMap	ds.l	1
curXPos		ds.w	1
curYPos		ds.w	1
oldXPos		ds.w	1
oldYPos		ds.w	1
scrollAdd	ds.w	1		; horizontal scroll add
CellMapCols	ds.w	1
CellMapRows	ds.w	1
wallDirection	ds.w	1		; current wall direction
_saveVCount	ds.l	1
scoreUpdate	ds.w	1

		even
UnpackSrcData	ds.b	(40*72)/2	; size of rectangular wall piece
UnpackSrcData2	ds.b	(40*72)/2	; size of rectangular wall piece
mapBuff		ds.w	(MAPWIDTH*MAPHEIGHT)
mapBuff2	ds.w	(MAPWIDTH*MAPHEIGHT)
HScrollBuff	ds.b	1024
tempbuff	ds.b	12
borderChars	ds.w	1
dmaBuff		ds.l	1
dmaAddr		ds.w	1
dmaSize		ds.w	1
sprAddedFlags	ds.b	10
lastWallOffset	ds.l	1
curWait		ds.w	1
curMovement	ds.w	1

globalPals	ds.l	4
lastPals	ds.l	4
_SYS_sprite1	ds.w	1
_SYS_sprite2	ds.w	1
_SYS_endsprite1	ds.w	1
_SYS_endsprite2	ds.w	1
crossHSpr	ds.w	1
EndFinished	ds.w	1
xBoundLeft	ds.w	1
xBoundRight	ds.w	1
lastWallFlag	ds.w	1

LENGTHBSS	=	*-bcolor
		inform	0,'length of bss = %d',LENGTHBSS

		section	.text

start:
        dc.b   $4A,$B9,$00,$A1,$00,$08,$66,$06,$4A,$79,$00,$A1,$00,$0C,$66,$7C
        dc.b   $4B,$FA,$00,$7C,$4C,$9D,$00,$E0,$4C,$DD,$1F,$00,$10,$29,$EF,$01
        dc.b   $02,$00,$00,$0F,$67,$08,$23,$7C,$53,$45,$47,$41,$2F,$00,$30,$14
        dc.b   $70,$00,$2C,$40,$4E,$66,$72,$17,$1A,$1D,$38,$85,$DA,$47,$51,$C9
        dc.b   $FF,$F8,$28,$9D,$36,$80,$32,$87,$34,$87,$01,$11,$66,$FC,$74,$25
        dc.b   $10,$DD,$51,$CA,$FF,$FC,$34,$80,$32,$80,$34,$87,$2D,$00,$51,$CE
        dc.b   $FF,$FC,$28,$9D,$28,$9D,$76,$1F,$26,$80,$51,$CB,$FF,$FC,$28,$9D
        dc.b   $78,$13,$26,$80,$51,$CC,$FF,$FC,$7A,$03,$17,$5D,$00,$11,$51,$CD
        dc.b   $FF,$FA,$34,$80,$4C,$D6,$7F,$FF,$46,$FC,$27,$00,$60,$6C,$80,$00
        dc.b   $3F,$FF,$01,$00,$00,$A0,$00,$00,$00,$A1,$11,$00,$00,$A1,$12,$00
        dc.b   $00,$C0,$00,$00,$00,$C0,$00,$04,$04,$14,$30,$3C,$07,$6C,$00,$00
        dc.b   $00,$00,$FF,$00,$81,$37,$00,$01,$01,$00,$00,$FF,$FF,$00,$00,$80
        dc.b   $40,$00,$00,$80,$AF,$01,$D9,$1F,$11,$27,$00,$21,$26,$00,$F9,$77
        dc.b   $ED,$B0,$DD,$E1,$FD,$E1,$ED,$47,$ED,$4F,$D1,$E1,$F1,$08,$D9,$C1
        dc.b   $D1,$E1,$F1,$F9,$F3,$ED,$56,$36,$E9,$E9,$81,$04,$8F,$02,$C0,$00
        dc.b   $00,$00,$40,$00,$00,$10,$9F,$BF,$DF,$FF,$4e,$71,$4e,$71,$4e,$71


MainEntry	Module

		move.l	#InitSP,SP

		jsr	ClearVram		; zero screen
		jsr	Init			; initialize game variables
		move.w	#$2000,sr
		jsr 	_SegaLogo

*****************************************************************************
* 			The program main loop starts here
*****************************************************************************


;{----------------------------------------------------------------------}

		lea	TitleScreen,a0
		move.w	BHCHAROFFSET(a0),d0
		add.w	d0,a0
		jsr	DLChars			; put characters in VDP

		lea	TitleScreen,a0
		jsr	SetMapPal

		move.w	d0,d2
		lea	TitleScreen,a0
		clr.w	d0
		clr.w	d1
		lea	MapBuff,a1

		jsr	DrawMap			; draw the map on screen

		lea	MapBuff,a0
		move.w	#$1000,d1
		move.w	_ScrAAddr,d0

		jsr	AddDMAQueue
		jsr	waitDMAqueue

		move.l	_Vcount,d1
		add.l	#180,d1			; 3 seconds
.waitLoop:
		cmp.l	_Vcount,d1
		bge.s	.waitLoop
		

;{----------------------------------------------------------------------}

		move.w	_SYS_LastChar,d0
		move.w	d0,_SYS_Sprite1
		clr.w	d7			; current animation
		clr.w	d6			; current frame
		lea	gatoranim,a0
		jsr	_SendFrameChars
		lea	gatoranim,a0
		jsr	_SetSpritePal
.mainloop:
		move.l	_VCount,d0
		move.l	d0,_SaveVCount

		move.w	d7,d2			; animation
		move.w	d6,d3			; frame
		lea	gatoranim,a0
		move.w	#160,d0
		move.w	#100,d1
		move.w	_SYS_Sprite1,d4
		or.w	#$8000,d4
		jsr	_DispFrame
		
		jsr	_sortSprites
		jsr	_SendSprList


		move.w	d6,d0
		lea	gatoranim,a0
		jsr	_updateFrame
		move.w	d0,d6
		tst.w	d1
		bge.s	.StillOk
		clr.w	d6
		addq.w	#1,d7

		lea	gatoranim,a0
		move.w	AHFLISTOFFSET(a0),d0
		sub.w	AHALISTOFFSET(a0),d0
		lsr.w	#2,d0
		cmp.w	d0,d7
		blt.s	.StillOk
		clr.w	d7
.StillOk:
		jsr	waitDMAQueue

		move.l	_SaveVCount,d0
		add.l	#10,d0
.GameSync:
		cmp.l	_VCount,d0
		bgt.s	.GameSync

		jmp	.mainloop
		

		ModEnd

		move.w	#$2300,sr
__exit:        
		bra     __exit


testCode:
		move.w	400(a0),(a1)+
		move.w	400(a0),(a1)+
		move.w	400(a0),(a1)+
		move.w	400(a0),(a1)+
		lea	28(a1),a1

		move.w	400(a0),1200(a1)
		move.w	400(a0),1200(a1)
		move.w	400(a0),1200(a1)
		move.w	400(a0),1200(a1)
		rts
;; ERROR EXCPTION FUNCTIONS - JUST LET US KNOW WHAT WENT WRONG

IllegalError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow

		lea	IllegalText,a0
		jsr	puts
		move.l	$2(sp),d0
		jsr	hextoasc
IIl1:
	        bra     IIl1

BusError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow
		lea	BusEText1,a0
		jsr	puts
		move.l	$10(sp),d0
		jsr	hextoasc
		lea	BusEText2,a0
		jsr	puts
		move.l	$2(sp),d0
		jsr	hextoasc
BEl1:
	        bra     BEl1

AddressError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow
		lea	AddrEText1,a0
		jsr	puts
		move.l	$10(sp),d0
		jsr	hextoasc
		lea	AddrEText2,a0
		jsr	puts
		move.l	$2(sp),d0
		jsr	hextoasc
AEl1:
	        bra     AEl1


ErrorVect:
	        bra     ErrorVect	; We point all unhandled exceptions here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Enables all interrupts! TEMP FUNCTION -----
; REVISIONS:    11/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_EnableInts:
        move.w  #$2000,SR
        rts


;{----------------------------------------------------------------------}
;{	_waitVBL:							}
;{	  wait for veritical blank to happen				}
;{----------------------------------------------------------------------}
_waitVBL:
		move.l	d0,-(sp)
		move.l	_VCount,d0
wVBLLoop:
		cmp.l	_VCount,d0
		beq.s	wVBLLoop
		move.l	(sp)+,d0
		rts
	


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     Vblank
; DESCRIPTION:  .
; RETURNS:      .
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Vblank:
		jsr	updateDMA
		addq.l	#1,_VCount
		jsr	updatePalettes
		if	(SNASM)
		trap	#0
		endif
	        rte


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     Hint
; DESCRIPTION:  .
; RETURNS:      .
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Hint:
        nop
        rte

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     ExtInt
; DESCRIPTION:  .
; RETURNS:      .
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
ExtInt:
        rte


;{----------------------------------------------------------------------}
;{ Function:	updatePalettes						}
;{ Description:	update global palettes if need be			}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
updatePalettes	Module

		movem.l	d0-d1/a0-a2,-(sp)


		lea	globalPals,a0
		lea	lastPals,a1
		move.w	#4-1,d0
.checkLoop:
		cmp.l	(a0)+,(a1)+
		beq.s	.noUpdate
		move.l	-4(a0),d1
		move.l	d1,-4(a1)
		move.l	a0,-(sp)
		move.l	d1,a0
		jsr	_SetPal
		move.l	(sp)+,a0
.noUpdate:
		dbra	d0,.checkLoop

		movem.l	(sp)+,d0-d1/a0-a2
		rts
	
		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	Init							}
;{ Description:	Initialize game variables				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
Init		Module

		bsr	ResetHardware		; set hardware defaults

		move.w	#1,_SYS_LastChar
		move.w	#0,_SYS_LastSpr

		clr.w	dmaStart
		clr.w	dmaEnd
		clr.w	dmaCurrent

		clr.w	EndFinished

		move.w	#((MAPWIDTH*2)*MAPHEIGHT)/4,d0
		lea	mapBuff,a0
		lea	mapBuff2,a1
.clrMapBuffs:
		clr.l	(a0)+
		clr.l	(a1)+
		dbra	d0,.clrMapBuffs


		move.w	#4-1,d0
		lea	lastPals,a0
		lea	globalPals,a1
.palLoop:
		clr.l	(a0)+
		clr.l	(a1)+
		dbra	d0,.palLoop

	   	clr.l	sprAddedFlags	
	   	clr.w	sprAddedFlags+4

		lea	Score1,a0
		rept	(SCORESIZE/4)
		clr.l	(a0)+			; zero out score
		endr
		rept	((SCORESIZE%4)/2)
		clr.w	(a0)+			; zero out score
		endr

setVScroll:
		moveq	#0,d0		;start address
		and.w	#$3f,d0
		or.w	#CD0,d0
		move.w	d0,VCTRL
		move.w	#CD2,VCTRL
		and.w	#$3f,d0
		moveq	#80/2-1,d1	;long words
		lea	VDATA,a0	;point to VDP data port
.sv_lp:
		move.w	d0,(a0)		; clear scrolls for A
		move.w	#$e0,(a0)	; set b past scroll A
		dbra	d1,.sv_lp	; set all
		rts

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	ResetHardware						}
;{ Description:	Reset Genisis hardware to game defaults			}
;{	This sets up 24 WORDS of work RAM as a 'copy' of the VDP 	}
;{	registers. ICD_BLK4 sets up the hardware in a similar way,	}
;{	without slaving the VDP registers, but THIS code does slave	}
;{	the registers in work RAM as the VDP has write only registers	}
;{	(status excepted). It also enables the display and Vertical	}
;{	interrupts as well as setting up the VRAM addresses in the VDP.	}
;{									}
;{	The following equates give two 4K scrolls (64X32CELLS) at 48K	}
;{	and 56K. The window (which is 4K long) is set to 52K. Since	}
;{	each scroll only requires 4K, there are two 4K gaps above the	}
;{	scrolls. Sprite Attributes and HScroll have been placed in 2K	}
;{	of the upper gap. Note that with the VRAM containing all 0,	}
;{	this means that all the cell maps contain references to cell 0,	}
;{	which in turn consists of 32 bytes containing 0, which is a	}
;{	blank character, so the screen will be background coloured.	}
;{									}
;{	In addition, the HScroll table contains the value 0, so the	}
;{	screen is not scrolled and the first sprite position is 0 and	}
;{	has link data 0, so no sprites are on screen. (Their pattern	}
;{	generator addresses are all space character anyway).		}
;{									}
;{	Any characters placed on Pattern A or B will be visible.	}
;{----------------------------------------------------------------------}
ResetHardware	Module

		jsr	ClearVRAM	;clear vram (scrolls, hscroll, sprites, cells)
		jsr	ClearVSRAM

		move.b	#$00,SCtrl1	; set parallel mode and clear ints (p75)
		move.b	#$00,SCtrl2	; set parallel mode and clear ints (p75)
		move.b	#$00,SCtrl3	; set parallel mode and clear ints (p75)
		move.b	#$40,Ctrl1
		move.b	#$40,Ctrl2
		move.b	#$40,Ctrl3

		lea	InitialVDP,a0 	; point to VDP initialization data
		lea	_VdpShadow,a1	; point to VDP slave register in work RAM
		move.w	#$8000,d0	; register increment
		moveq	#24-1,d1	; count
sl_slave:
		move.b	(a0)+,d2	; get register data
		and.w   #$00ff,d2	; Mask off high part
		move.b  d2,(a1)+	; Save
		or.w    d0,d2
		move.w  d2,VCTRL
		add.w	#$100,d0	; increment register
		dbra	d1,sl_slave	; slave all regs
		move.w	#64,CellMapCols	; set up cell map width
		move.w	#32,CellMapRows	; set up cell map height
		move.w	#ScrollA,_ScrAAddr
		move.w	#ScrollB+((MAPWIDTH*2)*MAPHEIGHT),_ScrBAddr
		move.w	#SpriteAttr, _SprAttrAddr
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	DisplayScore						}
;{ Description:	Display the score on the screen				}
;{ Parameters:	.							}
;{ Returns	.							}
;{----------------------------------------------------------------------}
oldDisplayScore	Module

		movem.l	d0-d3/a0-a2,-(sp)

		move.w	#24,_ScreenRow
		move.w	#18,_ScreenCol
;		lea	ScoreText,a0
;		jsr	puts

		lea	tempbuff,a1
		lea	Score1,a0
		lea	hexAscii,a2
		move.w	#(SCORESIZE*2)-1,d1
		clr.w	d2
		move.w	#4,d3
.ScoreLoop:
		move.b	(a0),d0
		lsr.w	d3,d0
		and.w	#$0f,d0
		move.b	0(a2,d0.w),d0
		cmp.b	#'0',d0
		bne.s	.NotZero
		cmp.w	#0,d1
		beq.s	.NotZero	; make at least one zero
		cmp.w	#0,d2
		beq.s	.NoStore
.NotZero:
		move.w	#1,d2
		move.b	d0,(a1)+
.NoStore:
		eor.w	#4,d3
		beq.s	.NotNextSource
		adda.l	#1,a0
.NotNextSource:
		dbra	d1,.ScoreLoop

		move.b	#0,(a1)+

		lea	tempbuff,a0
		jsr	puts

		movem.l	(sp)+,d0-d3/a0-a2
		rts

		ModEnd
;{----------------------------------------------------------------------}
;{ Function:	addScore						}
;{ Description:	Add to the score of player 1				}
;{ Parameters:	d0 = score to add in bcd format				}
;{ returns:	.							}
;{----------------------------------------------------------------------}
oldaddScore	Module


		movem.l	d0-d1/a0-a1,-(sp)

		rept	(SCORESIZE-4)/2
		clr.w	tempbuff
		endr
		move.l	d0,tempbuff+(SCORESIZE-4)	; put in memory

		lea	tempbuff+6,a0
		lea	Score1+6,a1
		andi.w	#%11101110,CCR	; clear carry and xtend
		move.w	#SCORESIZE-1,d0
.ScoreLoop:
		abcd	-(a0),-(a1)
		dbra	d0,.ScoreLoop

		movem.l	(sp)+,d0-d1/a0-a1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}

		section	.data
		
IllegalText	dc.b	"Illegal Instruction at Address $",0
BusEText1	dc.b	"Bus Error at $",0
BusEText2	dc.b	" accessing $",0
AddrEText1	dc.b	"Address Error at $",0
AddrEText2	dc.b	" accessing $",0
ScoreText	dc.b	"Score: ",0
FPSText		dc.b	"Frames per Second: ",0

InitialVDP
	dc.b	%00000100	; 0 no H interrupt, enable read HV counter
	dc.b	%01100100	; 1 ENABLE display, ENABLE V interrupt, NO DMA, 28CELL HIGH(NTSC)
	dc.b	ScrollA>>10	; 2 Pattern Table A
	dc.b	Window>>10	; 3 Pattern Window
	dc.b	ScrollB>>13	; 4 Pattern Table B
	dc.b	SpriteAttr>>9	; 5 Sprite Attributes
	dc.b	0		; 6 MUST BE 0
	dc.b	%00000000	; 7 Background colour 0 in palette 0
	dc.b	0		; 8 MUST BE 0
	dc.b	0		; 9 MUST BE 0
	dc.b	%11111111	;10 H interrupt divider
	dc.b	%00000010	;11 NO Ext interrupt, FULL V scroll, FULL H scroll
	dc.b	%10000001	;12 40CELL WIDE, NO shadow/hilight, NO interlace
	dc.b	HScroll>>10	;13 H Scroll Table    @62K
	dc.b	0		;14 MUST BE 0
	dc.b	%00000010	;15 Autoinc = 2 (i.e. increment by WORD)
	dc.b	%00010001	;16 Scroll size 64 HIGH by 64 WIDE occupies 64*64*2=4K bytes. NB CellMapCols
	dc.b	0		;17 Window H position = 0  \  => NO window
	dc.b	0		;18 Window V position = 0  /
	dc.b	$ff	;19 \ DMA length count
	dc.b	$ff	;20 /
	dc.b	$00	;21 \
	dc.b	$00	;22  > DMA source address
	dc.b	$80	;23 /


	 	even
gatoranim:
		incbin	gator.fpa

TitleScreen:
		incbin	endlvl1.fpc

		include	globals.i

	 	end




