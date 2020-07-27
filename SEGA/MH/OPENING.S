;{----------------------------------------------------------------------}
;{	opening.s							}
;{	Monster Hunter:							}
;{	  opening sequence Routines routines for game			}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log$
		include	macros.i
		include equates.i


BILL1XPOS	equ	89
BILL2XPOS	equ	265
BILL1YPOS	equ	250
BILL2YPOS	equ	250

MARGE1XPOS	equ	185
MARGE1YPOS	equ	216
MARGE2XPOS	equ	107
MARGE2YPOS	equ	216

MARGEHANDXPOS	equ	185
MARGEHANDYPOS	equ	256


PLANETXPOS	equ	280
PLANETYPOS	equ	100

BssGroup	group	Bss

		section	.bss,BssGroup

charCnt		ds.w	1
tempPal1	ds.b	36
cycleCount	ds.w	1
margeChars	ds.w	1
billChars	ds.w	1
planetChars	ds.w	1
planetFrame	ds.w	1
planetPtr	ds.l	1


		section	.text
		even


;{----------------------------------------------------------------------}
;{ Function: 	DoOpening						}
;{ Description:	Do Opening Sequence for game				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DoOpening	Module

		move.l	lastSong,d0
		move.l	d0,-(sp)
		jsr	_gemsstopsong
		adda.w	#4,sp

		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		move.w	_SYS_LastChar,d7

		jsr	displayBill

		lea	cockpitAFile,a0		; palette color
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#8,d0
		jsr	fadetoPalRange

		lea	Marge1Text,a0
		lea	cycleBillPalette,a2
		clr.w	cycleCount
		jsr	DisplayDelayedText
		cmp.l	#-1,d0
		beq	.exit

		move.w	d7,_SYS_LastChar
		jsr	clearVDPText

		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		jsr	displayMarge

		lea	MargeFile,a0
		move.w	AHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#8,d0
		jsr	fadetoPalRange

		move.l	#CharPalette,globalPals

		lea	Marge2Text,a0
		clr.w	cycleCount
		lea	updateMarge,a2
		jsr	DisplayDelayedText
		cmp.l	#-1,d0
		beq	.exit

		lea	mapBuff,a0
		move.w	_ScrAAddr,d0
		jsr	clearMapBuff

		lea	Marge3Text,a0
		lea	updateMarge,a2
		jsr	DisplayDelayedText
		cmp.l	#-1,d0
		beq	.exit

		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		move.w	d7,_SYS_LastChar
		jsr	clearVDPText

		jsr	displayBill

		lea	cockpitAFile,a0		; palette color
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#8,d0
		jsr	fadetoPalRange

		lea	Bill1Text,a0
		lea	cycleBillPalette,a2
		clr.w	cycleCount
		jsr	DisplayDelayedText

.exit:
		move.w	d7,_SYS_LastChar
		jsr	clearVDPText

		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange


; 		move.w	_SYS_LastChar,d2
; 		or.w	#$8000,d2
; 		move.w	_ScrAAddr,d3
; 		lea	cockpitAFile,a0
; 		lea	tempPal1,a2
; 		jsr	DisplayCompressMap
; 
; 		add.w	d0,d2
; 		and.w	#$7fff,d2
; 		move.w	_ScrBAddr,d3
; 
; 		lea	cockpitBFile,a0
; 		lea	tempPal1,a2
;		jsr	DisplayCompressMap
; 
; 		lea	tempPal1,a0
; 		move.w	#8,d0			; black out palette
;		jsr	fadetoPalRange


		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function: 	TalkaboutLevel						}
;{ Description:	marge talks about level to player			}
;{ Paramters:	d0 = level #						}
;{ returns	.							}
;{----------------------------------------------------------------------}
talkaboutLevel:


		sf	displayCrossHair

		move.w	d0,d2
		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange
		move.w	_SYS_lastChar,d7

		move.w	mapChars1,_SYS_LastChar

		add.w	d2,d2
		add.w	d2,d2
		add.w	d2,d2
		lea	leveltalkList,a2
		adda.w	d2,a2

		move.l	(a2),a3
		move.l	a3,a0
		jsr	_SendFrameChars
		move.w	d0,d4
		or.w	#CHARPRIORITY,D4
		move.w	d4,planetChars

		move.l	a3,a0
		move.w	AHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals+8

		move.w	#PLANETXPOS,d0
		move.w	#PLANETYPOS,d1
		clr.w	d2
		clr.w	d3
		move.l	a3,a0
		jsr	_DispFrame
		move.l	a3,planetPtr
		clr.w	planetFrame

		jsr	displayMarge

		lea	MargeFile,a0
		move.w	AHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#8,d0
		jsr	fadetoPalRange

		move.l	#CharPalette,globalPals

		move.l	4(a2),a0
		clr.w	cycleCount
		lea	updatePlanet,a2
		jsr	DisplayDelayedText

		move.w	d7,_SYS_LastChar
		jsr	clearVDPText

		lea	BlackFullPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		jsr	_SendSprList

		st	displayCrossHair
		rts


cycleBillPalette Module
		move.b	joy1Data,d0
		btst	#7,d0
		bne.s	.dontExit
		move.b	d0,oldjoy1Data
		move.l	#-1,d0
.dontExit:
		rts

		ModEnd

;
;
;
updatePlanet	Module

		movem.l	d1-d5/a0,-(sp)
		move.w	planetFrame,d3
		move.w	cycleCount,d0
		addq.w	#1,d0
		and.w	#3,d0
		bne.s	.noupdate

		move.w	d3,d0
		clr.w	d1
		move.l	planetPtr,a0
		jsr	_updateFrame
		move.w	d0,d3
		move.w	d0,planetFrame
.noUpdate:
		move.w	planetChars,d4
		move.w	#PLANETXPOS,d0
		move.w	#PLANETYPOS,d1
		clr.w	d2
		move.l	planetPtr,a0
		jsr	_DispFrame


		jmp	updateMarge2

;
;
;
;
updateMarge	Module
		
		movem.l	d1-d5/a0,-(sp)
updateMarge2:
		add.w	#1,cycleCount
		move.w	cycleCount,d5		; wait 8 vertical blanks
		lsr.w	#3,d5
		and.w	#$0f,d5			; and mask animation
		add.w	d5,d5			; for word table

		move.w	#MARGE1XPOS,d0
		move.w	#MARGE1YPOS,d1
		clr.w	d2
		lea	margeRightAnims,a0
		move.w	margeChars,d4
		move.w	0(a0,d5.w),d3
		lea	MargeFile,a0
		jsr	_DispFrame

		move.w	#MARGE2XPOS,d0
		move.w	#MARGE2YPOS,d1
		or.w	#CHARHF,d4
		clr.w	d2
		lea	margeLeftAnims,a0
		move.w	0(a0,d5.w),d3
		lea	MargeFile,a0
		jsr	_DispFrame

		jsr	_sendSprList

		move.b	joy1Data,d0
		btst	#7,d0
		bne.s	.dontExit
		move.b	d0,oldjoy1Data
		move.l	#-1,d0

.dontExit:
		movem.l	(sp)+,d1-d5/a0
		rts
		
		ModEnd
		ModEnd

;
;
;

displayBill:
		lea	cockpitAFile,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		jsr	DLChars

		move.w	d0,d2
		or.w	#$8000,d2		; top priority
		clr.w	d0
		clr.w	d1
		lea	cockpitAFile,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		move.w	#$e00,d1
		lea	mapBuff,a0
		jsr	addDMAQueue

		lea	cockpitBFile,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		jsr	DLChars

		move.w	d0,d2
		clr.w	d0
		clr.w	d1
		lea	cockpitBFile,a0
		lea	mapBuff2,a1
		jsr	drawMap

		move.w	_ScrBAddr,d0
		move.w	#$e00,d1
		lea	mapBuff2,a0
		jsr	addDMAQueue

		jsr	waitDMAQueue

		lea	BillFile,a0
		jsr	_SendFrameChars

		move.w	d0,d4
		or.w	#CHARPRIORITY,d4
		move.w	#BILL1XPOS,d0
		move.w	#BILL1YPOS,d1
		clr.w	d2
		clr.w	d3
		lea	BillFile,a0
		jsr	_DispFrame

		move.w	#BILL2XPOS,d0
		move.w	#BILL2YPOS,d1
		clr.w	d2
		move.w	#1,d3
		lea	BillFile,a0
		jsr	_DispFrame

		jsr	_sendSprList


		rts


displayMarge:

		lea	mapBuff,a0
		move.w	_ScrAAddr,d0
		jsr	clearMapBuff

		lea	mapBuff2,a0
		move.w	_ScrBAddr,d0
		jsr	clearMapBuff

		lea	MargeFile,a0
		jsr	_SendFrameChars

		move.w	d0,d4
		or.w	#CHARPRIORITY,d4
		move.w	d4,margeChars

		move.w	#MARGE1XPOS,d0
		move.w	#MARGE1YPOS,d1
		clr.w	d2
		clr.w	d3
		lea	MargeFile,a0
		jsr	_DispFrame

		move.w	#MARGE2XPOS,d0
		move.w	#MARGE2YPOS,d1
		or.w	#CHARHF,d4
		clr.w	d2
		clr.w	d3
		lea	MargeFile,a0
		jsr	_DispFrame

		jsr	_sendSprList


		rts
		


;{----------------------------------------------------------------------}
;{ Function: 	DisplayDelayedText		 			}
;{ Description:	display text and delay between each			}
;{ Parameters:	a0 = text pointer					}
;{		a2 = routine to call every vblank			}
;{ Returns:	d0.l = -1 if start pressed.				}
;{----------------------------------------------------------------------}
DisplayDelayedText Module


		movem.l	d1-d2/d7,-(sp)
		move.w	(a0)+,d7		; get # text items 
		subq.w	#1,d7
.displayLoop:
		move.w	(a0)+,_ScreenCol
		move.w	(a0)+,_ScreenRow
		jsr	puts
		clr.l	d2
		move.w	(a0)+,d2
		subq.w	#1,d2
		bmi.s	.noWait
.waitLoop1:
		move.l	_VCount,d0
.waitLoop2:
		cmp.l	_Vcount,d0
		beq.s	.waitLoop2
		jsr	(a2)
		cmp.l	#-1,d0
		beq.s	.exit
		dbra	d2,.waitLoop1
.noWait:
		dbra	d7,.displayLoop
.exit:
		movem.l	(sp)+,d1-d2/d7
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function: 	DisplayCompressMap		 			}
;{ Description:	Do Opening Sequence for game	 			}
;{ Parameters:	d2 = character to download to				}
;{		d3 = address to send to					}
;{		a0 = pointer to compress map file.			}
;{ Returns:	d0 = number of characters sent				}
;{----------------------------------------------------------------------}
DisplayCompressMap Module

		movem.l	d1-d7/a0-a2,-(sp)

		lea	ScaleBuff1,a1
		jsr	lz_Open			; open up compressed file

		lea	ScaleBuff2,a0
		move.w	#6,d0
		jsr	lz_Read

		move.w	BHPALOFFSET(a0),d0	; seek to palette
		jsr	lz_seek

		move.l	a2,a0
		move.w	#132,d0
		jsr	lz_Read

		move.w	ScaleBuff2+BHMAPOFFSET,d0
		jsr	lz_seek

		lea	ScaleBuff2+44,a0	
		move.w	#(VISIBLEMAPWIDTH*2)*MAPHEIGHT+4,d0
		jsr	lz_Read			; read in map

		move.w	#((VISIBLEMAPWIDTH)*MAPHEIGHT)-1,d0
		lea	ScaleBuff2+48,a0
		lea	mapBuff,a1
		clr.w	d5
.setLoop:
		move.w	(a0)+,d1
		add.w	d2,d1			; update character number
		move.w	d1,(a1)+
		addq.w	#1,d5
		cmp.w	#VISIBLEMAPWIDTH,d5
		bne.s	.noDestUpdate
		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a1
		clr.w	d5
.noDestUpdate:
		dbra	d0,.setLoop

		move.w	ScaleBuff2+BHCHAROFFSET,d0
		jsr	lz_seek

		move.w	#2,d0
		lea	CharCnt,a0
		jsr	lz_Read			; read in character count

		move.w	CharCnt,d4
		move.w	d4,d7			; save for later
.loadLoop:
		move.w	#128,d5
		cmp.w	#128,d4
		bge.s	.tooMuch
		move.w	d4,d5
.tooMuch:
		move.w	d5,d0
		lsl.w	#5,d0
		lea	ScaleBuff1+4352,a0	; bypass ring buffer+256 bytes
		jsr	lz_read			; read in bytes

		move.w	d5,d1			; set size in chars
		lsl.w	#5,d1			; and make size in bytes
		move.w	d2,d0			; and destination character
		and.w	#$7ff,d0
		lsl.w	#5,d0			; address

		jsr	addDMAQueue		; put in VDP
		jsr	waitDMAqueue		; wait till finished
		
		add.w	d5,d2			; next character set
		sub.w	d5,d4			; and subtract from characters left
		bgt.s	.loadLoop

		lea	mapBuff,a0
		move.w	d3,d0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue
		jsr	waitDMAQueue		; wait for map to be sent

		move.w	d7,d0
		
		movem.l	(sp)+,d1-d7/a0-a2
		rts

		modEnd


		section	.data

		even
cockpitAFile:
		incbin	cockpita.fpc
		even
cockpitBFile:
		incbin	cockpitb.fpc
		even
BillFile:
		incbin	Bill.fpa

MargeFile:
		incbin	marge.fpa


planet1file:
		incbin	planet1b.fpa

planet2file:
		incbin	planet2b.fpa

planet3file:
		incbin	planet3b.fpa

planet4file:
		incbin	planet4b.fpa

planet5file:
		incbin	planet5b.fpa


leveltalkList:
		dc.l	planet1File
		dc.l	level1Talk

		dc.l	planet2File
		dc.l	level2Talk

		dc.l	planet3File
		dc.l	level3Talk

		dc.l	planet4File
		dc.l	level4Talk

		dc.l	planet5File
		dc.l	level5Talk


		even
BlackFullPal:
		dc.w	$0		; offset of palette
		dc.w	$40		; number of palette entries
		rept	$40
		dc.w	0
		endr

marge1Text:
		dc.w	3

		dc.w	10,5
		dc.b	"Bill?...Bill?",0
		dc.w	120
		dc.w	10,6
		dc.b	"I know you're there... ",0
		dc.w	120
		dc.w	10,7
		dc.b	"Answer me Bill...",0
		dc.w	240

marge2Text	
		dc.w	6
		dc.w	4,2
  		dc.b	"Listen, We've got collection ",0
		dc.w	0
		dc.w	4,3
		dc.b	"agencies calling us every five ",0
		dc.w	0
		dc.w	4,4
  		dc.b	"minutes, I'm up to my eye balls",0
		dc.w	0
		dc.w	4,5
		dc.b	"in bills.  And you know I",0
		dc.w	0
		dc.w	4,6
		dc.b	"haven't been paid in over a",0
		dc.w	0
		dc.w	4,7
		dc.b	"month. ",0
		dc.w	600

marge3Text:
		dc.w	3

		dc.w	4,2
		dc.b	"So, I got a whole bunch of jobs",0
		dc.w	0
		dc.w	4,3
		dc.b	"for us, and i'm not gonna let you",0
		dc.w	0
		dc.w	4,4
		dc.b	"turn them down!",0
		dc.w	400
bill1Text:
		dc.w	2

		dc.w	10,5
		dc.b	"Okay Marge, You got me ",0
		dc.w	0
		dc.w	10,6
		dc.b	"..shoot..  ",0
		dc.w	320


level4Talk:
level5Talk:
level1Talk:
		dc.w	4
		dc.w	4,2
		dc.b	"This is the Intergalactic",0
		dc.w	0
		dc.w	4,3
		dc.b	"Dumping Station 7.  Massive",0
		dc.w	0
		dc.w	4,4
		dc.b	"nuclear waste dumping has",0
		dc.w	0
		dc.w	4,5
		dc.b	"mutated the creatures. ",0
		dc.w	600


level2Talk:
		dc.w	4
		dc.w	4,2
		dc.b	"This is the Frozen ",0
		dc.w	0
		dc.w	4,3
		dc.b	"Tundra.  A vast frozen ",0
		dc.w	0
		dc.w	4,4
		dc.b	"wasteland. Blah.. Blah ",0
		dc.w	0
		dc.w	4,5
		dc.b	"Blah... Blah...  ",0
		dc.w	600


level3Talk:
		dc.w	4
		dc.w	4,2
		dc.b	"This is the Solarous ",0
		dc.w	0
		dc.w	4,3
		dc.b	"the Sand Moon.  Lot's o' ",0
		dc.w	0
		dc.w	4,4
		dc.b	"critters. in the sand. ",0
		dc.w	0
		dc.w	4,5
		dc.b	"Blah... Blah...  ",0
		dc.w	600



margeLeftAnims:
		dc.w	0,1,2,1,2,1,2,0,0,1,2,1,2,1,2,0
margeRightAnims:
		dc.w	0,1,2,1,2,1,0,1,2,3,4,4,4,4,4,4

margeHandMove:
		dc.w	16,-16
		dc.w	16,-16
		dc.w	-4,4
		dc.w	4,-4
		dc.w	-16,16
		dc.w	-16,16


		include	globals.i

		end
