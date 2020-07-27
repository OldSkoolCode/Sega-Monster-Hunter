;{----------------------------------------------------------------------}
;{	MH.S								}
;{	Monster Hunter:							}
;{	  Main loop routines for game					}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: mh.s_v $
;Revision 1.7  1993/07/08  15:27:16  KENH
;*** empty log message ***
;
;Revision 1.6  1993/06/14  20:23:18  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/07  19:56:06  KENH
;added title screen stuff
;
;Revision 1.4  1993/06/02  07:06:20  KENH
;Added levels 3 & 4
;
;Revision 1.3  1993/05/13  23:07:23  KENH
;New die stuff
;
;Revision 1.2  1993/04/29  13:49:00  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:28:07  KENH
;Initial revision
;
;
	even

	include	macros.i
	include equates.i
	include	scaler.i
	include	sound.i

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

crocX		ds.w	1	; current x position
crocY		ds.w	1
crocChar	ds.w	1
crocFrame	ds.w	1
_CrocVC		ds.l	1
CrossHairUpdated ds.w	1	; crosshair was updated
DMATemp		ds.l	1

lastLevelMap	ds.l	1
curLevelMap	ds.l	1
curWallSet	ds.l	1
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
lastSong	ds.l	1
sideWallSet	ds.l	1

ScaleVars	ds.b	SizeOf_ScaleVars

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
flashPals	ds.b	4
_SYS_sprite1	ds.w	1
_SYS_sprite2	ds.w	1
_SYS_endsprite1	ds.w	1
_SYS_endsprite2	ds.w	1
crossHSpr	ds.w	1
EndFinished	ds.w	1
xBoundLeft	ds.w	1
xBoundRight	ds.w	1
lastWallFlag	ds.w	1
_sfxQueue	ds.l	1
shootDelay	ds.l	1
lastShotDelay	ds.l	1
curLevelNum	ds.w	1
displayCrossHair ds.w	1

AutoFire	ds.b	1
_CurrentButtons	ds.b	1
_PrevButtons	ds.b	1
updateButton	ds.b	1
joy1Data	ds.b	1
oldjoy1Data	ds.b	1
VDPAccess	ds.b	1
fixPal		ds.b	1

		even

LENGTHBSS	=	*-bcolor
		inform	0,'length of bss = %d',LENGTHBSS

		section	.text

		include	icd_blk4.s

MainEntry	Module

		move.w	#($10000/16)-1,d0
		lea	$ff0000,a0
.clrLoop:
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		clr.l	(a0)+
		dbra	d0,.clrLoop

		clr.w	dmaStart
		clr.w	dmaEnd
		clr.w	dmaCurrent
		st	VDPAccess
		move.l	#InitSP,SP

		bsr	ResetHardware		; set hardware defaults
		jsr	ClearVram		; zero screen
		jsr	_sfxinit
		move.w	#$2000,sr

*****************************************************************************
* 			The program main loop starts here
*****************************************************************************

		if	(TAD)
		jsr	_TadInit
		endif

		lea	ScaleVars,a6
		moveq	#SSC_Init,d0
		jsr	SpriteScaler		; initialize sprite scaler

		sf	fixPal

		jsr 	_SegaLogo
		jsr	_gemsstopall
Main:
		jsr	waitforDMA
		jsr	waitDMAQueue
		jsr	Init			; initialize game variables
		jsr	InitDisplay

		clr.w	curLevelNum
		clr.l	lastSong
		clr.l	-(sp)
		jsr	_gemsstartsong
		adda.w	#4,sp

		jsr	waitDMAQueue
		move.w	_SYS_LastChar,d7
		lea	TitleFile,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		jsr	DLChars

		move.w	d7,_SYS_LastChar
		clr.w	d0
		clr.w	d1
		move.w	d7,d2
		or.w	#$8000,d2		; top priority
		lea	TitleFile,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		move.w	#$e00,d1
		lea	mapBuff,a0
		jsr	addDMAQueue
		jsr	waitDMAQueue

		lea	TitleFile,a0		; palette color
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#16,d0
		jsr	fadetoPalRange

		move.l	_VCount,d7
		add.l	#1800,d7
.waitStart:
		cmp.l	_VCount,d7
		blt.s	.TitleTimeOut
		move.b	joy1Data,d0
		btst	#7,d0
		bne.s	.waitStart
.TitleTimeOut:
		move.b	d0,oldjoy1Data

		jsr	DoOpening

		st	fixPal

;		if	(SNASM)
;		jsr	chooseLevel		; choose level
;		endif

		move.w	_SYS_LastChar,d0
		move.w	d0,borderChars

		lea	borderMap,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		jsr	DLChars

		st	firstTimePOV
		st	firstTimeLR

		jsr	sendStaticSprites

		clr.w	crossHairX

		move.w	_SYS_LastChar,d0
		move.w	d0,mapChars1
		add.w	#420,d0
		move.w	d0,floorChars1
		add.w	#161,d0
		move.w	d0,floorChars2
		add.w	#161,d0
		move.w	d0,_SYS_sprite1
		move.w	#(HSCROLL-16)/32,d1
		sub.w	d0,d1
		lsr.w	#1,d1
		add.w	d1,d0
		move.w	d0,_SYS_sprite2
		move.w	d0,_SYS_endsprite1
		add.w	d1,d0
		move.w	d0,_SYS_LastChar
		move.w	d0,_SYS_endsprite2

		moveq.l	#0,d0
		moveq.l	#1,d3
		moveq.l	#0,d4
		move.w	#1,scoreUpdate
mainloop:
		move.w	_SYS_sprite1,d0
		move.w	_SYS_sprite2,d1
		move.w	d0,_SYS_sprite2
		move.w	d1,_SYS_sprite1

		move.w	d0,_SYS_scaledChar

		move.w	_SYS_endsprite1,d0
		move.w	_SYS_endsprite2,d1
		move.w	d0,_SYS_endsprite2
		move.w	d1,_SYS_endsprite1

		move.l	_VCount,d0
		move.l	d0,_SaveVCount

		move.l	curLevelMap,a0
		cmp.l	lastLevelMap,a0
		beq	.NoNewLevel
		tst.w	EndFinished
		bne	.doGameSync
		move.l	a0,lastLevelMap
		move.l	curWallSet,a0
		move.w	AHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals
		move.l	lastSong,d0
		move.l	d0,-(sp)
		jsr	_gemsstopsong
		adda.w	#4,sp
		move.w	curLevelNum,d0
		sf	fixpal
		jsr	talkaboutLevel
		st	fixpal

		clr.w	d0
		clr.w	d1
		move.w	borderChars,d2
		or.w	#$8000,d2		; top priority
		lea	borderMap,a0
		lea	mapBuff,a1
		jsr	drawMap

		lea	borderMap,a0		; palette color
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals+12

		move.w	_ScrAAddr,d0
		move.w	#$e00,d1
		lea	mapBuff,a0
		jsr	addDMAQueue
		jsr	waitDMAQueue

.NoNewLevel:
		move.w	scrollAdd,d0
		cmp.w	#LEFT,curMovement
		bne.s	.NotLeft1
		neg.w	d0
.NotLeft1:
		tst.w	curMovement
		bge.s	.NotStopped
		clr.w	d0
.NotStopped:
		add.w	d0,curXPos

		move.l	curLevelMap,a0
		moveq.l	#0,d0
		move.w	curXPos,d0
		divu	#40,d0			; get wall offset
		if (MAPLEVELSIZE<>24)
		inform	0,'shifts no longer valid for'
		inform	1, mulitiply of MAPLEVELSIZE', MAPLEVELSIZE
		endif
		lsl.w	#3,d0
		add.w	d0,a0			; * 8
		add.w	d0,d0
		add.w	d0,a0			; + * $10
		cmp.l	lastWallOffset,a0
		beq	.NoNewWallOffset
		move.l	a0,lastWallOffset
		lea	sprAddedFlags,a1
		move.w	lastWallFlag,d0
		sf	0(a1,d0.w)
		move.l	a0,a2			; gems uses a0
		tst.w	MUSICNUM(a2)		; see if music change
		beq.s	.noNewMusic
		move.l	lastSong,d0
		move.l	d0,-(sp)
		jsr	_gemsstopsong
		adda.w	#4,sp
		move.w	MUSICNUM(a2),d0
		and.l	#$ffff,d0
		move.l	d0,lastSong
		move.l	d0,-(sp)
		jsr	_gemsstartsong
		adda.w	#4,sp
		move.l	a2,a0			; gems uses a0
.noNewMusic:
		move.w	MAPWAIT(a0),d0
		move.w	d0,curWait		; set wait time
		move.w	MOVEMENT(a0),d1
		blt.s	.NoNewMovement		; movement wanted <0
		cmp.w	curMovement,d1		; see if still same movement
		beq.s	.NoNewMovement		; yep so do nothing
		move.w	d1,wallDirection	; else set new direction
		jsr	killAllMonsters
	   	clr.l	sprAddedFlags	
	   	clr.l	sprAddedFlags+4
		clr.w	monsterstokill
.NoNewMovement:
		move.w	d1,curMovement
		move.b	d1,aiVariables+MOVEMENTVAR
.NoNewWallOffset:
		move.w	wallDirection,d1
		tst.w	curWait
		bne	.doGameSync
		move.w	ScrollAdd,d0
		cmp.w	#RIGHT,d1		; moving right
		bne.s	.NotRight
		move.w	#$f000,xBoundLeft
		move.w	#512,xBoundRight
		st	firstTimePOV
		move.w	#6,lastWallflag
		bra.s	.goBuildPOV
.NotRight:
		cmp.w	#LEFT,d1
		bne.s	.NotLeft2
		move.w	#$f000,xBoundLeft
		move.w	#512,xBoundRight
		st	firstTimePOV
		move.w	#6,lastWallflag
.goBuildPOV:
		move.w	curXPos,d0
		move.w	curYPos,d1
		cmp.w	oldXPos,d0
		bne.s	.goBuildPOV2
		cmp.w	oldYPos,d1
		beq	.doGameSync
.goBuildPOV2:
		jsr	BuildSideView		; build side view
		bra	.doGameSync
.NotLeft2:
		cmp.w	#FORWARD,d1
		bne	.doGameSync
		st	firstTimeLR
		move.w	#(SRCPOVWIDTH/WALLWIDTH),lastWallflag
		move.w	#$f000,xBoundLeft
		move.w	#512,xBoundRight
		move.w	curXPos,d0
		move.w	curYPos,d1
		cmp.w	oldXPos,d0
		bne.s	.goPovScroll
		cmp.w	oldYPos,d1
		beq	.doGameSync
.goPovScroll:
		jsr	doPovScroll
testFC:
.doGameSync:
		cmp.w	#ENDOFLEVEL,curMovement		; end of level
		bne.s	.notEndLevel
		tst.w	EndFinished
		bne.s	.notEndLevel
		move.l	SETUPPTR(a0),a1
		move.w	#1,EndFinished
		jsr	(a1)
.notEndLevel:
		jsr	testHitEnemy

		jsr	MonsterAI
		jsr	AddMonsterQueue
		
;		jsr	UpdateDisplay
		jsr	_SendSprList

		move.w	curXPos,oldXPos
		move.w	curYPos,oldYPos
		cmp.l	#-1,_sfxQueue		; play sound effect?
		beq.s	.noneLoaded
		move.l	_sfxQueue,d0
		move.l	#-1,_sfxQueue
		jsr	_sfxstartsound
.noneLoaded:
		jsr	testHitEnemy
		tst.w	curWait
		beq.s	.notWaiting
		move.l	_VCount,d0
		sub.l	_saveVCount,d0
		neg.w	d0
		add.w	curWait,d0
		bge.s	.waitOK
		clr.w	d0
.waitOK:
		move.w	d0,curWait
.notWaiting:
		cmp.w	#WAITTILLCLEAR,curMovement
		bne.s	.NoReset
		tst.w	monsterstoKill
		bne.s	.NoReset
		move.w	wallDirection,d1
		move.w	d1,curMovement
.NoReset:
		move.w	#1,_ScreenRow
		move.w	#0,_ScreenCol
		lea	FPSText,a0
;		jsr	puts

;		move.l	#60,d0
;		move.l	_VCount,d1
;		sub.l	_saveVCount,d1
;		divu	d1,d0
;		jsr	hextodec
		

;		cmp.w	#0,healthValue
;		bne.s	.notDead

;		jsr	waitDMAQueue
;		jsr	_gemsstopall

;		lea	redOutPal,a0
;		move.w	#32,d0
;		jsr	fadetoPalRange
;		jmp	main

.notDead
	   	move.l	#5,shootDelay		; 1/2 second shoot delay
		cmp.w	#0,bulletCount
		bne.s	.StillBullets
		move.l	#10,shootDelay
.StillBullets:
		jsr	waitDMAQueue

		move.l	_saveVCount,d0
		add.l	#5,d0
.LoopGameSync:
		cmp.l	_VCount,d0
		bgt.s	.LoopGameSync


		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in

		jmp	mainloop
		

		ModEnd

		move.w	#$2300,sr
__exit:        
		bra     __exit


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
	


;{----------------------------------------------------------------------}
;{
chooseLevel	Module

		movem.l	d0-d2/a0-a2,-(sp)

		move.l	#CharPalette,globalPals

		lea	mapBuff,a0
		move.w	_ScrAAddr,d0
		jsr	clearMapBuff

		move.w	_ScrAAddr,d0
		lea	mapBuff,a0
		move.w	#((MAPWIDTH*2)*MAPHEIGHT),d1
		jsr	addDMAQueue

		lea	levelText,a0
		lea	LevelMaps,a1
.LevelLoop:
		move.w	#10,_screenCol
		move.w	#10,_screenRow
		move.l	a0,-(sp)
		jsr	puts
		move.l	(sp)+,a0
.waitLoop:
		move.b	joy1Data,d0

		cmp.b	oldjoy1Data,d0
		beq.s	.notDown

		move.b	d0,oldjoy1Data
		btst	#7,d0
		beq.s	.goStart

		btst	#0,d0
		bne.s	.notUp

		cmpa.l	#LevelMaps,a1
		beq.s	.notUP
		suba.w	#4,a1
		suba.w	#8,a0
.notUP:
		btst	#1,d0
		bne.s	.notDown
		cmpa.l	#LevelMaps+12,a1
		bge.s	.notDown
		adda.w	#4,a1
		adda.w	#8,a0
.notDown:
		bra	.LevelLoop
.goStart:
		move.l	(a1),curLevelMap
		move.l	32(a1),curWallSet
		move.l	64(a1),sideWallSet
		movem.l	(sp)+,d0-d2/a0-a2

		rts
		ModEnd

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     Vblank
; DESCRIPTION:  .
; RETURNS:      d0 = 0 if no dma done
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Vblank:
		move.l	d1,-(sp)
		addq.l	#1,_VCount
		clr.l	d1			; didn't DMA
		tst.b	VDPAccess
		beq.s	.noVDPAccess		; can't access VDP?
		move.w	dmaCurrent,d0		; see if dma left to do
		cmp.w	dmaEnd,d0		; in queue
		beq	.noDMAthisTime		; nope none left
		jsr	_gemsdmastart		; hold z80 from dma
		jsr	updateDMA
		moveq.l	#-1,d1			; did DMA
.NoDMAthisTime:
		tst.b	updateButton
		beq.s	.noUpdateButtons
		move.b	_TadButtons,d0
		move.b	d0,_CurrentButtons
		sf	updateButton
.noUpdateButtons:
		jsr	updatePalettes
.noVDPAccess:
		move.l	d1,d0
		move.l	(sp)+,d1
	        rts


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
		lea	flashPals,a2
		move.w	#4-1,d0
.checkLoop:
		tst.b	(a2)+
		beq.s	.noFlashPal
		sub.b	#1,-1(a2)
		move.l	(a1)+,d1
		adda.w	#4,a0
		bra.s	.setPal
.noFlashPal:
		cmp.l	(a0)+,(a1)+
		beq.s	.noUpdate
		move.l	-4(a0),d1
		move.l	d1,-4(a1)
		beq.s	.noUpdate		; null palette
.setPal:
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

BlackOut:
		sf	VDPAccess
		move.w	#CD1+CD0,VCTRL		; cram write
		move.w	#0,VCTRL
		moveq.l	#0,d0
	
		moveq	#64*2/4-1,d1		; long words less 1
.clrCRAMLoop:
		move.l	d0,VDATA		; clear 2 entries
		dbra	d1,.clrCRAMLoop		; until all clear

		move.w	#1,_SYS_LastChar
		clr.w	_SYS_LastSpr
		clr.w	_SYS_FirstSpr
		clr.w	_StaticSprites		; clear all sprites
		move.w	#1,CrossHairUpdated
		move.w	#160,crossHairX
		move.w	#114,crossHairY		; where to put sprite
		move.w	#4,ScrollAdd
		move.w	ScrollAdd,d0
		neg.w	d0
		move.w	d0,curXPos
		add.w	d0,d0
		move.w	d0,oldXPos
		clr.w	curYPos			; set middle of screen
		move.w	#-1,oldYPos			; set middle of screen
		move.l	LevelMaps,curLevelMap	; pointer to map structures
		move.l	LevelMaps+32,curWallSet
		move.l	LevelMaps+64,SideWallSet
		move.l	#-1,lastLevelMap	; no last level
		clr.w	wallDirection
		move.l	#-1,lastWallOffset	; no last walloffset
		clr.w	curWait			; no waiting yet
		clr.w	curMovement

		clr.w	dmaStart
		clr.w	dmaEnd
		clr.w	dmaCurrent
		clr.b	oldJoy1Data

		move.l	#-1,_sfxQueue
	   	move.l	#5,shootDelay		; 1/2 second shoot delay
		move.l	_VCount,d0
	   	move.l	d0,lastShotDelay

		clr.l	lastMonsterList
		sf	AutoFire
		st	_PrevButtons
		st	_CurrentButtons
		st	pageOn
		st	VDPAccess
		st	updateButton
		move.b	#$0f,joy1Data

		move.l	#scaleBuff1,scaleBuffPtr1
		move.l	#scaleBuff2,scaleBuffPtr2
		clr.w	nMonsterLists		; no monsters currently
		clr.w	EndFinished
		lea	theMonsterLists,a0
		move.w	#MAXNMONSTERS-1,d0
.monLoop:
		rept	MONSTERLISTSIZE/4
		clr.l	(a0)+
		endr
		rept	(MONSTERLISTSIZE%4)/2
		clr.w	(a0)+
		endr
		dbra	d0,.monLoop

		move.w	#((SPRLISTSIZE/2)*MAXSPRITES)-1,d0
		lea	_Work_Sprlist,a0
.spriteClr:
		clr.w	(a0)+
		dbra	d0,.spriteClr

		lea	mapBuff,a0
		move.w	_ScrAAddr,d0
		jsr	clearMapBuff

		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	mapBuff,a0
		jsr	addDMAQueue		; zap horizontal scroll

		move.w	#SpriteAttr,d0
		move.w	#1024,d1
		lea	mapBuff,a0
		jsr	addDMAQueue		; zap horizontal scroll

		lea	mapBuff2,a0
		move.w	_ScrBAddr,d0
		jsr	clearMapBuff

		clr.w	monstersToKill		; monsters already killed
		move.w	#4-1,d0
		lea	lastPals,a0
		lea	globalPals,a1
		clr.l	flashPals
.palLoop:
		clr.l	(a0)+
		clr.l	(a1)+
		dbra	d0,.palLoop

	   	clr.l	sprAddedFlags	
	   	clr.l	sprAddedFlags+4

		jsr	_sendSprList
		jsr	waitDMAQueue
		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in


		move.w	#WALLSONSCREEN-1,d2
		clr.w	d0
		lea	theWallLists,a0
.wallLoop:
		move.w	d0,(a0)			; init wall character #
		clr.l	INFOADDRESS(a0)
		add.w	#(9*5),d0
		adda.w	#WALLLISTSIZE,a0	; next structure
		dbra	d2,.wallLoop

		lea	Score1,a0
		rept	(SCORESIZE/4)
		clr.l	(a0)+			; zero out score
		endr
		rept	((SCORESIZE%4)/2)
		clr.w	(a0)+			; zero out score
		endr

setVScroll:
		sf	VDPAccess
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
		st	VDPAccess
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
;{ Function:	TestHitEnemy						}
;{ Description:	See if cross hair is hitting enemy and button down	}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
TestHitEnemy	Module

		movem.l	d0-d3,-(sp)
		move.w	crosshairX,d0
		move.w	crosshairY,d1
		add.w	#8,d1			; make center of cross hair
		move.b	_CurrentButtons,d2
		move.b	d2,_PrevButtons
		btst	#1,d2
		bne.s	.Fire
		move.l	_Vcount,d3
		move.l	d3,lastShotDelay
		bra.s	.noFire
.Fire:
		move.l	lastShotDelay,d3
		cmp.l	_VCount,d3
		bgt.s	.NoFire
		move.l	_VCount,d3
		add.l	shootDelay,d3
		move.l	d3,lastShotDelay
.AutoEnabled:
		move.l	d0,-(sp)
		move.l	#Machine_Gun,d0
		jsr	_sfxstartsound
		move.l	(sp)+,d0

		jsr	ShootEnemy		; see if shot enemy
.noFire:
		st	updateButton
		movem.l	(sp)+,d0-d3
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	updateCrossHair						}
;{ Description:	updates CrossHair sprite on screen			}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
updateCrossHair	Module

		movem.l	d0-d4/a0-a1,-(sp)

		tst.b	VDPAccess		; unable to access VDP
		beq	.NoChange

		move.w	_TADXpos,d0
		move.w	_TADYpos,d1
		tst.b	displayCrossHair
		bne.s	.StillDisplay
		move.w	#-($80-$10)-1,d0
		clr.w	d1
.StillDisplay:
		cmp.w	crossHairX,d0
		bne.s	.redrawCrossHair
		cmp.w	crossHairY,d1
		beq	.NoChange
.redrawCrossHair:
		move.w	#1,CrossHairUpdated

		move.w	d0,crossHairX
		move.w	d1,CrossHairY

		add.w	#$80-$10,d0
		add.w	#$80-$10,d1
		move.w	statSprNum+STATICCROSSH,d2
		lsl.w	#3,d2
		lea	_Work_Sprlist,a0
		adda.w	d2,a0
		move.w	StatSprSize+STATICCROSSH,d4
		subq.w	#1,d4
		bmi.s	.NoChange
		sub.w	SAXPOS(a0),d0
		sub.w	SAYPOS(a0),d1
		movem.l	d4/a0,-(sp)
.updateLoop:
		add.w	d0,SAXPOS(a0)
		add.w	d1,SAYPOS(a0)
		adda.w	#SPRLISTSIZE,a0
		dbra	d4,.updateLoop

		movem.l	(sp)+,d4/a0

		add.w	_SprAttrAddr,d2
		CalcVramWrtAddrCode d2,d3

		move.l	d3,VCTRL	; write address
.SpriteLoop:
		move.w	(a0)+,VDATA	; send data
		move.w	(a0)+,VDATA	; send data
		move.w	(a0)+,VDATA	; send data
		move.w	(a0)+,VDATA	; send data
		dbra	d4,.SpriteLoop
.NoChange:
		movem.l	(sp)+,d0-d4/a0-a1
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

MenuText:
;		dc.b	"Difficulty Level",0
;		dc.l	diffMenu
;		dc.b	"Sound",0
;		dc.l	MusicToggle
;		dc.b	"Debug Level",0
;		dc.l	chooseLevel
;		dc.l	"High Scores",0

LevelText	dc.b	"Level 1", 0
		dc.b	"Level 2", 0
		dc.b	"Level 3", 0
		dc.b	"Level 4", 0

InitialVDP
	dc.b	%00000100	; 0 no H interrupt, enable read HV counter
	dc.b	%01110100	; 1 ENABLE display, ENABLE V interrupt, NO DMA, 28CELL HIGH(NTSC)
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
charPalette:
		dc.w	0
		dc.w	$10
		dc.w	$0000,$0EEE,$0EC0,$0EA0
		dc.w	$0E80,$0E60,$0E40,$0E20
		dc.w	$0E00,$0C00,$0A00,$0800
		dc.w	$0600,$0EEE,$0EEE,$0EEE
redOutPal:
		dc.w	0
		dc.w	$30
		rept	$30
		dc.w	$0c
		endr

	 	even
TitleFile:
		incbin	title.fpc

		include	globals.i

	 	end




