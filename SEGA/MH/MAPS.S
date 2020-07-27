;{----------------------------------------------------------------------}
;{	MAPS.S								}
;{	Monster Hunter:							}
;{	  Map Routines game						}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: maps.s_v $
;Revision 1.7  1993/07/08  15:26:28  KENH
;*** empty log message ***
;
;Revision 1.6  1993/07/08  15:24:13  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/14  20:23:24  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/07  19:55:08  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/02  07:06:40  KENH
;New wall set stuff
;
;Revision 1.2  1993/05/13  23:05:14  KENH
;fixed bug for wallsets
;
;Revision 1.1  1993/04/29  13:49:56  KENH
;Initial revision
;

	even

	include	macros.i
	include equates.i
	include scaler.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}

BssGroup	group	Bss

		section	.bss,BssGroup

theWallLists	ds.b	(WALLLISTSIZE*WALLSONSCREEN)

wallXPos	ds.w	1
wallYPos	ds.w	1
firstTimeLR	ds.b	1
sentScroll	ds.b	1
curPanelNumber	ds.w	1

curScrollPos	ds.w	20

LENGTHBSS	equ	*-theWallLists
		inform	0,'length of bss = %d',LENGTHBSS

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	DrawMap							}
;{ Description:	Draw map to Map A screen				}
;{ Parameters:	d0 = x char in map to draw				}
;{		d1 = y character in map to start at			}
;{		d2 = character # of downloaded characters		}
;{		a0 = pointer to map structure				}
;{		a1 = pointer to buffer					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DrawMap		module

		movem.l	d0-d6/a0-a1,-(sp)
		move.w	BHMAPOFFSET(a0),d4	; get offset to map
		jsr	_WaitVBL
		lea	0(a0,d4.w),a0
		move.w	(a0)+,d4		; get width of map
		move.w	(a0)+,d5
		add.w	d4,d4
		mulu	d4,d1			; into temp reg
		add.w	d1,a0

		add.w	d0,d0			; * 2 for words
		add.w	d0,a0
		sub.w	d0,d4

		lsr.w	#1,d4
		subq.w	#1,d5
		cmp.w	#MAPHEIGHT-1,d5
		ble.s	.YLoop
		move.w	#MAPHEIGHT-1,d5
.YLoop:
		move.w	d4,d6			; number bytes not going to move
		subq.w	#1,d6
.XLoop:
		move.w	(a0)+,d1
		add.w	d2,d1
		move.w	d1,(a1)+
		dbra	d6,.XLoop
		add.w	d0,a0			; update source offset
		add.w	#(MAPWIDTH*2),a1
		sub.w	d4,a1
		sub.w	d4,a1
		dbra	d5,.YLoop
		
		movem.l	(sp)+,d0-d6/a0-a1
		rts

		modend


;{----------------------------------------------------------------------}
;{ Function:	DlChars							}
;{ Description:	Download characters to vram				}
;{ Parameters:	a0 = pointer to charcters structure			}
;{ Returns:	d0 = character # in VRAM				}
;{----------------------------------------------------------------------}
DlChars		module

		movem.l	d1-d3/a0,-(sp)
		sf	VDPAccess
		move.w	_SYS_LastChar,d0	; get last character downloaded
		move.w	d0,d1
		and.l	#$ffff,d1
		lsl.l	#5,d1
		CalcVramWrtAddrCode d1,d2

		move.w	(a0)+,d3
		add.w	d3,_SYS_LastChar
		lsl.w	#4,d3
		AUTOINCREMENT 2
		move.l	d2,VCTRL
		subq.l	#1,d3
.DLLoop:
		move.w	(a0)+,VDATA
		dbra	d3,.DLLoop

		st	VDPAccess
		movem.l	(sp)+,d1-d3/a0
		rts


		modend


;{----------------------------------------------------------------------}
;{ Function:	sendScreen						}
;{ Description:	Send screen buffer redrawing border			}
;{ Parameters:	a0 = pointer to map buffer				}
;{ Returns:	.							}
;{----------------------------------------------------------------------
sendScreen	Module

		movem.l	d0-d3/a0-a2,-(sp)
;		lea	borderMap,a1
;		move.w	BHMAPOFFSET(a1),d0
;		adda.w	d0,a1
;		move.l	a0,a2
;
;		move.w	borderChars,d3
;
;		rept	2
;		rept	40
;		move.w	(a1)+,d0
;		add.w	d3,d0
;		move.w	d0,(a2)+
;		endr
;		adda.w	#48,a2
;		endr
;
;		rept	20
;		rept	4
;		move.w	(a1)+,d0
;		add.w	d3,d0
;		move.w	d0,(a2)+
;		endr
;		adda.w	#64,a1
;		adda.w	#64,a2
;		rept	4
;		move.w	(a1)+,d0
;		add.w	d3,d0
;		move.w	d0,(a2)+
;		adda.w	#48,a2
;		endr
;		endr
;
;		rept	3
;		rept	40
;		move.w	(a1)+,d0
;		add.w	d3,d0
;		move.w	d0,(a2)+
;		endr
;		adda.w	#48,a2
;		endr
		
		jsr	WaitForDMA		; wait until DMA finished
;		jsr	_WaitVBL
		move.w	_ScrAAddr,d0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		movem.l	(sp)+,d0-d3/a0-a2
		rts
		Modend

;{----------------------------------------------------------------------}
;{ Function:	buildSideMap						}
;{ Description:	Build map for screen background				}
;{ Parameters:	d0 = starting character #				}
;{		a0 = source map						}
;{		a1 = pointer to scroll list				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
buildSideMap	module

		movem.l	d0-d7/a0-a5,-(sp)

		move.w	borderChars,d6
		or.w	#CHARPRIORITY,d3
		lea	borderMap,a2
		move.w	BHMAPOFFSET(a2),d1	; get offset to map
		lea	4(a2,d1.w),a2

		lea	mapBuff,a3
		lea	mapBuff2,a4

		move.w	#TOPBORDCHARS-1,d2
.topBordLoop1:
		move.w	#POVXCHARS-1,d1
.topBordLoop2:
		move.w	(a2)+,d3
		add.w	d6,d3
		move.w	d3,(a3)+
		dbra	d1,.topBordLoop2
		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a3
		dbra	d2,.topBordLoop1

		move.w	(a1)+,d7		; get number of strips
		subq.w	#1,d7
		move.w	d0,d3
		lea	CurScrollPos,a3
.stripLoop:
		and.w	#$7fff,d3
		tst.w	PSPRIORITY(a1)
		beq.s	.noPriority
		or.w	#CHARPRIORITY,d3
.noPriority:
		clr.w	(a3)+
		clr.w	d0			; start at 32 over
		bsr	drawStrip

		adda.w	#PSSIZE,a1
		dbra	d7,.stripLoop

		lea	mapBuff+((MAPHEIGHT-BOTTOMBORDCHARS)*2),a3

;		adda.w	#((MAPHEIGHT-(THEWALLYPOS/8)-(WALLHEIGHT/8)-BOTTOMBORDCHARS)*40)*2,a2
;		move.w	#BOTTOMBORDCHARS-1,d2
;.bottomBordLoop1:
;		move.w	#POVXCHARS-1,d1
;.bottomBordLoop2:
;		move.w	(a2)+,d3
;		add.w	d6,d3
;		move.w	d3,(a0)+
;		dbra	d1,.bottomBordLoop2
;		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a0
;		dbra	d2,.bottomBordLoop1


		movem.l	(sp)+,d0-d7/a0-a5
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	DrawStrip						}
;{ Description: Draw a strip of characters to screen			}
;{ Parameters:	d0 = x block inside source				}
;{		d3 = character #					}
;{		a0 = source map pointer					}
;{		a1 = struture of Parallax scroll strip			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DrawStrip	Module

		movem.l	d0-d7/a3-a4,-(sp)
		move.w	d0,d7			; move temp
		clr.w	d6
		move.w	PSHEIGHT(a1),d2		; height
		subq.w	#1,d2
.hLoop:
		move.l	d7,-(sp)
		move.w	PSWIDTH(a1),d4		; width
		lea	mapBuff,a3
		tst.w	PSMAPFLAG(a1)
		beq.s	.isMapA			; is map A!
		lea	mapBuff2,a3
.isMapA:
		move.w	PSSRCY(a1),d0
		add.w	d6,d0			; current strip Y
		move.w	-4(a0),d1
		lsl.w	#1,d1
		mulu	d1,d0
		lea	0(a0,d0.l),a4		; source
		move.w	PSDESTY(a1),d0
		add.w	d6,d0			; current strip Y
		lsl.w	#7,d0
		lea	0(a3,d0.w),a3
		move.w	#MAPWIDTH,d5
.DestLoop:
		movem.l	d4/a4,-(sp)
		adda.w	d7,a4
		adda.w	d7,a4			; * 2 for word map entry
		sub.w	d7,d4
		clr.w	d7			; next time at beginning
		sub.w	d4,d5			; get count to do
		bge.s	.SomeSrcLeft
		add.w	d5,d4			; only do this many words
		clr.w	d5
.SomeSrcLeft:
		subq.w	#1,d4
.widthLoop:		     
		move.w	(a4)+,d0
		add.w	d3,d0
		move.w	d0,(a3)+
		dbra	d4,.widthLoop

		movem.l	(sp)+,d4/a4
		tst.w	d5
		bne	.DestLoop

		move.l	(sp)+,d7
		addq.w	#1,d6			; next strip Y

		dbra	d2,.hLoop

		movem.l	(sp)+,d0-d7/a3-a4
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	BuildSideView						}
;{ Description:	Build the side view for current level map		}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
BuildSideView	Module


		movem.l	d0-d5/a0-a4,-(sp)

		tst.b	firstTimeLR
		beq	.NotFirstTime

		lea	BlackmapPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		lea	mapBuff,a0
		move.w	#((MAPWIDTH*(MAPHEIGHT-BOTTOMBORDCHARS)))-1,d2
.clrLoop:
		clr.l	(a0)+
		dbra	d2,.clrLoop
		
		move.l	#ScaleBuff1,ScaleBuffPtr2
		move.l	#ScaleBuff2,ScaleBuffPtr1

		tst.b	pageOn
		bne.s	.onPageOne
		move.w	floorChars1,d1
		move.w	floorChars2,d0
		move.w	d1,floorChars2
		move.w	d0,floorChars1
		eor.b	#1,pageOn
.onPageOne:
		move.l	sideWallSet,a1
		move.l	(a1)+,a0
		move.w	BHPALOFFSET(a0),d0
		move.l	a0,a2
		adda.w	d0,a2
;		move.l	a2,globalPals
		move.w	BHCHAROFFSET(a0),d0
		move.w	BHMAPOFFSET(a0),d2
		move.l	a0,a2
		add.w	d2,a2
		adda.w	#4,a2			; skip width/height
		adda.w	d0,a0
		move.w	(a0)+,d1
		move.w	d1,d7
		lsl.w	#5,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		jsr	AddDMAQueue

		move.w	mapChars1,d0
		move.l	a2,a0
		jsr	BuildSideMap

		lea	mapBuff,a0
		move.w	_ScrAAddr,d0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		lea	mapBuff2,a0
		move.w	_ScrBAddr,d0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		jsr	WaitDMAQueue
.NotFirstTime:

		move.l	curLevelMap,a2		; get current structure ptr
		moveq.l	#0,d0
		move.w	curXPos,d0
		divu	#40,d0			; get wall offset
		move.l	d0,d7
		if (MAPLEVELSIZE<>24)
		inform	0,'shifts no longer valid for'
		inform	1, mulitiply of MAPLEVELSIZE', MAPLEVELSIZE
		endif
		lsl.w	#3,d0			; * 8
		move.w	d0,wallXPos
		add.w	d0,a2
		add.w	d0,d0			; * 16
		add.w	d0,a2			; get to wall start
		add.w	d0,wallXPos		; wallXPos * 24
		add.w	d0,wallXPos		; wallXPos * 40
		move.w	#THEWALLYPOS,WallYPos

		lea	HScrollBuff,a3		; h scroll buffer
		sf	sentScroll

		move.w	#POVYCHARS-1,d2
		move.w	#TOPBORDCHARS,d3
.topHLoop:
		clr.w	(a3)+
		clr.w	(a3)+
		adda.w	#32-4,a3
		subq.w	#1,d2
		dbra	d3,.topHLoop

		move.l	a2,-(sp)
		move.l	sideWallSet,a1
		move.l	(a1)+,a0
		move.w	BHMAPOFFSET(a0),d0
		adda.w	d0,a0
		adda.w	#4,a0
		move.w	mapChars1,d3
		lea	CurScrollPos,a2

		move.w	(a1)+,d7
		subq.w	#1,d7
.scrollLoop:
		move.w	PSSPEED(a1),d0
		add.w	(a2),d0
		move.w	d0,d1
		lsr.w	#3,d1			; get characters
		cmp.w	PSWIDTH(a1),d1		; over width of characters
		blt.s	.StillinStrip
		sub.w	PSWIDTH(a1),d1
		and.w	#7,d0
.StillinStrip:
		move.w	(a2),d2			; get old value
		move.w	d0,(a2)+		; store back in table
		lsr.w	#3,d2			; and character of old value
		cmp.w	d1,d2			; see if move over chacter bound
		beq.s	.noRedraw		; nope don't redraw just scroll
		movem.l	d0/a0,-(sp)
		move.w	d1,d0			; get character to draw at
		and.w	#$7fff,d3
		tst.w	PSPRIORITY(a1)
		beq.s	.noPriority
		or.w	#CHARPRIORITY,d3
.noPriority:
		bsr	DrawStrip		; draw to memory
		move.w	PSHEIGHT(a1),d1		; get height of strip
		lsl.w	#7,d1
		lea	MapBuff,a0
		move.w	_ScrAAddr,d0
		tst.w	PSMAPFLAG(a1)
		beq.s	.isMapA
		lea	MapBuff2,a0
		move.w	_ScrBaddr,d0
.isMapA:
		move.w	PSDESTY(a1),d2
		lsl.w	#7,d2
		adda.w	d2,a0
		add.w	d2,d0
		jsr	AddDMAQueue
		movem.l	(sp)+,d0/a0
.noRedraw:
		and.w	#7,d0
		neg.w	d0
		lea	HScrollBuff,a3		; h scroll buffer
		move.w	PSDESTY(a1),d2
		lsl.w	#5,d2			; * 32 for each scroll buffer
		lea	0(a3,d2.w),a3
		move.w	PSHEIGHT(a1),d2
		subq.w	#1,d2
		tst.w	PSMAPFLAG(a1)
		bne.s	.isMapB
.hscrLoop1:
		move.w	d0,(a3)+		; overall scrolling
		adda.w	#32-2,a3
		dbra	d2,.hscrLoop1
		bra.s	.notMapB
.isMapB:
		adda.w	#2,a3
		move.w	d0,(a3)+		; overall scrolling
		adda.w	#32-4,a3
		dbra	d2,.isMapB
.notMapB:
		adda.w	#PSSIZE,a1
		dbra	d7,.scrollLoop
		
		move.w	#BOTTOMBORDCHARS-1,d3
		lea	HscrollBuff+((MAPHEIGHT-BOTTOMBORDCHARS)*32),a3
.bottomHLoop:
		clr.w	(a3)+
		clr.w	(a3)+
		adda.w	#32-4,a3
		dbra	d3,.bottomHLoop

		setVDPRegister VDP_MODESET3,$0a
		move.l	(sp)+,a2

.noNewWall:
		swap	d7			; only first time to wall section
		tst.w	d7
		bne.s	.noSprites		; yep
		move.l	SPRITELISTPTR(a2),d2
		beq.s	.noSprites
		movea.l	d2,a1
		move.w	(a1)+,d2
		subq	#1,d2
		move.l	a2,-(sp)
.addSprites:
		move.l	(a1)+,a0
		move.l	a1,lastMonsterList
		move.w	wallXPos,d0
		move.w	wallYPos,d1
		jsr	addMonster		; add monster to ai list
		lea	0,a2
		dbra	d2,.addSprites
		move.l	(sp)+,a2
.noSprites:

		
;		lea	theWallLists,a3
;		lea	sprAddedFlags,a4
;.wallLoop:
;		cmp.l	INFOADDRESS(a3),a2
;		beq	.sameWallSet
;		cmp.w	#LEFT,wallDirection
;		bne.s	.notLeft
;		lea	theWallLists+(WALLLISTSIZE*WALLSONSCREEN),a3
;		lea	theWallLists+(WALLLISTSIZE*WALLSONSCREEN-1),a0
;		move.w	#((WALLLISTSIZE*(WALLSONSCREEN-1))/2)-1,d0
;		move.w	STARTCHAR(a3),d1
;.moveLoop2:
;		move.w	-(a0),-(a3)
;		dbra	d0,.moveLoop2
;		suba.w	#WALLLISTSIZE,a3
;		move.w	d1,STARTCHAR(a3)
;		clr.l	INFOADDRESS(a3)		; flag get new wall
;		bra.s	.doscan
;.notLeft:
;		lea	theWallLists+WALLLISTSIZE,a0
;		move.w	#((WALLLISTSIZE*(WALLSONSCREEN-1))/2)-1,d0
;		move.w	STARTCHAR(a3),d1
;.moveLoop1:
;		move.w	(a0)+,(a3)+
;		dbra	d0,.moveLoop1
;		move.w	d1,STARTCHAR(a3)	; save start character
;		clr.l	INFOADDRESS(a3)		; flag get new wall
;.doscan:
;
;		move.w	#WALLSONSCREEN-1,d4
;		lea	theWallLists,a3
;.scanLoop:
;		move.w	WALLANIM(a2),d2
;		move.w	WALLFRAME(a2),d3
;		move.l	curWallSet,a0
;		cmp.l	INFOADDRESS(a3),a2
;		beq	.noNewWall
;		move.l	a2,INFOADDRESS(a3)
;		jsr	_getFrameInfo		; get frame information
;
;		tst.b	firstTimeLR
;		beq.s	.dontWait1
;		jsr	waitDMAQueue		; make sure dma is flushed
;.dontWait1:
;		move.w	SAHVLINK(a0),d0		; get width and height
;		move.w	d0,d1
;		lsr.w	#8,d0
;		and.w	#$ff,d1
;		movea.l	a1,a0			; source pointer
;		lea	UnpackSrcData,a1
;		move.l	a2,-(sp)
;		lea	UnpackSrcData2,a2
;		move.l	a0,a1
;		clr.w	d0
;		jsr	ShuffleBitmap		; make character from bitmap
;		move.l	(sp)+,a2
;
;		move.w	mapChars1,d0
;		add.w	(a3),d0			; character set for this wall
;		lsl.w	#5,d0
;		move.l	#(5*9)*32,d1
;		lea	UnpackSrcData2,a0
;		jsr	addDMAQueue		; copy character bits
;
;		move.w	FLOORANIM(a2),d2
;		move.w	FLOORFRAME(a2),d3
;		move.l	curWallSet,a0
;
;		jsr	addFloorBitmap
;
;		add.w	#1,curPanelNumber
;
;		tst.b	sentScroll
;		bne.s	.noNewWall
;		st	sentScroll
;		move.w	#HSCROLL,d0
;		move.w	#1024,d1
;		lea	HScrollBuff,a0
;		jsr	addDMAQueue
;		add.w	#40,wallXPos		; next wall x position
;		adda.w	#MAPLEVELSIZE,a2
;		adda.w	#WALLLISTSIZE,a3
;
;		dbra	d4,.scanLoop
;
;		move.w	mapChars1,d0
;		lea	mapBuff,a0
;;		jsr	buildMap
;		
;		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
;		tst.b	firstTimeLR
;;		bne.s	.dontWait2
;		move.w	#(MAPWIDTH*2)*(MAPHEIGHT-(56/8)),d1
;.dontWait2:
;		move.w	_ScrAAddr,d0
;		lea	mapBuff,a0
;		jsr	addDMAQueue
;.sameWallSet:
;		move.l	d7,d0
;		jsr	BuildSideFloor
;
;		lea	scaleBuff1,a0
;		move.w	#((SIDEFLOORWIDTH/8)*(SIDEFLOORHEIGHT/8))*32,d1
;		move.w	floorChars1,d0
;		lsl.w	#5,d0
;		jsr	addDMAQueue
		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	HScrollBuff,a0
		jsr	addDMAQueue
		tst.b	firstTimeLR
		beq.s	.noFadein
		jsr	waitDMAQueue
		move.l	SideWallSet,a1
		move.l	(a1)+,a0
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#9,d0			; black out palette
		jsr	fadetoPalRange
.noFadeIn:
		sf	firstTimeLR
		movem.l	(sp)+,d0-d5/a0-a4
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	AddFloorBitmap						}
;{ Description:	add in floor bitmap to current list			}
;{ Parameters:	a0 = pointer to animation				}
;{		d2 = animation #					}
;{		d3 = frame #						}
;{		d4 = WALLSONSCREEN-(wallNumber+1)			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
AddFloorBitmap	Module

		movem.l	d0-d4/a0-a1,-(sp)
		jsr	_getFrameInfo		; get frame information

		movea.l	a1,a0			; source pointer
		lea	scaleBuff2,a1		; destination pointer start
;		addq.w	#1,d4
;		neg.w	d4
;		add.w	#WALLSONSCREEN,d4
		move.w	curPanelNumber,d4
		addq.w	#1,d4
		and.w	#7,d4
;		add.w	d0,d4
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a1
		add.w	d4,d4
		add.w	d4,d4
		adda.w	d4,a1			; ptr+(wallpos*20)
		lea	160(a1),a1

		move.l	a1,d2			; save for later
		move.w	#WALLHEIGHT-1,d0
.moveLoop1:
		rept	(WALLWIDTH/8)
		move.l	(a0)+,(a1)+
		endr
		lea	(320-(WALLWIDTH/2))(a1),a1
		dbra	d0,.moveLoop1

		move.w	#WALLHEIGHT-1,d0
		move.l	d2,a1
		tst.w	d4
		bne.s	.NoWrap
		lea	-20(a1),a1
		lea	160(a1),a0
		bra.s	.moveLoop2
.NoWrap:
		lea	-20(a1),a0
		lea	-160(a0),a1

.moveLoop2:
		rept	(WALLWIDTH/8)
		move.l	(a0)+,(a1)+
		endr
		lea	(320-(WALLWIDTH/2))(a1),a1
		lea	(320-(WALLWIDTH/2))(a0),a0
		dbra	d0,.moveLoop2


		movem.l	(sp)+,d0-d4/a0-a1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	BuildSideFloor						}
;{ Description:	Build the floor for side view				}
;{ Parameters:	d0 = (x position mod 40)-????				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
BuildSideFloor	Module

		lea	scaleBuff2,a0		; address where to put panels
		move.w	curPanelNumber,d0
		and.w	#7,d0
		add.w	d0,d0			; * 2
		add.w	d0,d0			; * 4
		adda.w	d0,a0
		add.w	d0,d0			; * 8
		add.w	d0,d0			; * 16
		adda.w	d0,a0			; a0 += curpanel * 20 bytes
		swap	d0
		lsr.w	#1,d0
		adda.w	d0,a0
		lea	scaleBuff1,a1
		move.w	#320,d0			; to next y address
;		jsr	XSCALERTNS		; draw floor

		rts

		ModEnd
;{----------------------------------------------------------------------}
;{ Function:	ShuffleBitmap						}
;{ Description:	Shuffle bitmap into character set			}
;{ Parameters:	a0 = source						}
;{		a2 = destination					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
ShuffleBitmap	module


		rept	9
		rept	5
		rept	8
		move.l	(a0)+,(a2)+
		adda.w	#16,a0
		endr
		suba.w	#156,a0
		endr
		adda.w	#140,a0
		endr

		rts

		modEnd

;{----------------------------------------------------------------------}
;{ Function:	quickMove						}
;{ Description:	move wall to ram quickly				}
;{ Parameters:	a0 = source						}
;{		a1 = destination					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
quickMove	module

		movem.l	d0-d7/a0-a2,-(sp)

		rept	45
		movem.l	(a0)+,d0-d6/a2
		movem.l	d0-d6/a2,(a1)
		lea	32(a1),a1
		endr

		movem.l	(sp)+,d0-d7/a0-a2
		rts


		modend

;{----------------------------------------------------------------------}
;{ Function:	makeSideWall						}
;{ Description:	Generate a side wall from a y-stored scalable wall	}
;{ Parameters:	d0 = width of wall					}
;{		d1 = height of wall					}
;{		a0 = pointer to source data				}
;{		a1 = pointer to destination buffer			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
makeSideWall	module


		movem.l	d0-d6/a0-a4,-(sp)

		lea	UnpackTab,a2

		move.w	a0,a3
		move.w	d0,d2
		lsr.w	#1,d2
		add.w	d2,a3
		move.w	d1,d6
		lsr.w	#2,d6			; # blocks wide
		move.l	a1,a4			; save for later
.blockWLoop:
		move.w	d1,d5
		subq	#1,d5
		and.w	#3,d5
.blockLoop:
		move.l	a4,a1
		move.w	d0,d4
		lsr	#1,d4
		subq	#1,d4
.chunk2Loop:
		moveq	#0,d2
		move.b	(a0)+,d2		; get top nibble
		lsl.w	#1,d2
		move.w	(a2,d2.w),d2
		and.w	#$f0f0,d2		; mask nibbles
		moveq	#0,d3
		move.b	(a3)+,d3
		lsl.w	#1,d3
		move.w	(a2,d3.w),d3
		and.w	#$0f0f,d3
		or.w	d3,d2
		move.b	d2,4(a1)
		move.w	d2,-(sp)
		move.b	(sp)+,(a1)
		adda.w	#8,a1
		dbra	d4,.chunk2Loop
		move.w	d0,d2
		lsr	#1,d2
		adda.w	d2,a0
		adda.w	d2,a3
		adda.w	#1,a4
		dbra	d5,.blockLoop
		subq	#4,d1
		suba.w	#3,a1
		move.l	a1,a4
		dbra	d6,.blockWLoop

		movem.l	(sp)+,d0-d6/a0-a4
		rts
		modend

;{----------------------------------------------------------------------}
;{ Function:	addDecorations						}
;{ Description:	add decorations to wall if there			}
;{ Parameters:	d0 = width of wall					}
;{		d1 = height of wall					}
;{		a0 = pointer to source data				}
;{		a2 = pointer to decoration list				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
addDecorations	module


		movem.l	d0-d7/a0-a5,-(sp)

		lea	maskTab,a4

		move.w	(a2)+,d6		; # decorations
		subq	#1,d6
.DecoLoop:
		movem.l	d0/a0-a1,-(sp)
		movea.l	a0,a3
		move.w	YPOS(a2),d2
		lsr	#1,d2
		mulu	d0,d2
		adda.w	d2,a3
		move.w	XPOS(a2),d7
		lsr.w	#1,d7
		adda.w	d7,a3			; a3 = source wall start
		move.l	BITMAPPTR(a2),a0
		move.w	BITMAPANIM(a2),d2
		move.w	BITMAPFRAME(a2),d3
		move.w	d0,-(sp)
		jsr	_getFrameInfo		; get decoration list
		move.w	(sp)+,d0
		move.w	SAHVLINK(a0),d4
		move.w	d4,d5
		lsr.w	#8,d4			; width of decoration
		and.w	#$ff,d5			; height of decoration
		lsr.w	#1,d4
		move.w	d0,d1
		lsr	#1,d1
		sub.w	d4,d1			; add for next line wall
		subq.w	#1,d4
		tst.w	BITMAPSTORE(a2)
		beq.s	.hLoop2
.hLoop1:
		move.w	d4,-(sp)
		moveq.l	#0,d0
.wLoop1:
		move.b	(a1)+,(a3)+
		dbra	d4,.wLoop1
		move.w	(sp)+,d4
		adda.w	d1,a3
		dbra	d5,.hLoop1

		movem.l	(sp)+,d0/a0-a1
		adda.w	#DECOLISTSIZE,a2
		dbra	d6,.DecoLoop
		bra.s	.AllDone
.hLoop2:
		move.w	d4,-(sp)
		moveq.l	#0,d0
.wLoop2:
		move.b	(a1)+,d0
		move.b	(a4,d0.w),d7
		and.b	d7,(a3)
		or.b	d0,(a3)+
		dbra	d4,.wLoop2
		move.w	(sp)+,d4
		adda.w	d1,a3
		dbra	d5,.hLoop2

		movem.l	(sp)+,d0/a0-a1
		adda.w	#DECOLISTSIZE,a2
		dbra	d6,.DecoLoop
.AllDone:
		movem.l	(sp)+,d0-d7/a0-a5
		rts

		modend


;{----------------------------------------------------------------------}
;{ Function:	SetMapPal						}
;{ Description:	Set the palette from Map structure			}
;{ Parameters:	a0 = pointer to map structure				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
SetMapPal	module


		movem.l	d0-d2/a0,-(sp)
		move.w	BHPALOFFSET(a0),d0	; get offset to palette
		lea	0(a0,d0.w),a0
		bra.s	.setPal2

;{----------------------------------------------------------------------}
;{ Function:	_SetPal							}
;{ Description:	Set the palette from RGB structure			}
;{ Parameters:	a0 = pointer to RGB structure				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_SetPal:
		movem.l	d0-d2/a0,-(sp)
.setPal2:
		move.w	BPCOLORINDEX(a0),d0	; get color index
		lsl.w	#1,d0
		move.w	BPNUMCOLORS(a0),d2
		subq.l	#1,d2
		lea	BPRGBVALUES(a0),a0
		CalcCramWrtAddrCode d0,d1	; calculate color ram address

		AutoIncrement 2			; make sure inc's words
		move.l	d1,VCTRL		; send to hardware
.ColorLoop:
		move.w	(a0)+,d0		; get color

		tst.w	d0			; if black
		bne.s	.colorOk
		tst.b	fixPal
		beq.s	.colorOk
		move.w	#$200,d0
.colorOk:
		move.w	d0,VDATA

		dbra	d2,.ColorLoop

		movem.l	(sp)+,d0-d2/a0
		rts

		modend

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}
		section	.data


;		include	xscalexx.s

BlackmapPal:
		dc.w	$0		; offset of palette
		dc.w	$30		; number of palette entries
		rept	$30
		dc.w	0
		endr
maskTab:
.Count		=	0
		rept	256
hinib		=	0
lonib		=	0
		if	(.Count&$f0)
hinib		=	$f0
		endif
		if	(.Count&$f)
lonib		= 	$f
		endif
		dc.b	(hinib!lonib)^$ff

.Count		=	.Count+1
		endr

levelmaps	dc.l	Level3Map, Level1Map, Level2Map, Level2Map
		dc.l	Level2Map, Level2Map, Level2Map, Level2Map

levelWallFiles	dc.l	WALLL3B1FILE, WALLL1B1FILE, WALLL2B1FILE, WALLL2B1FILE
		dc.l	WALLL2B1FILE, WALLL2B1FILE, WALLL2B1FILE, WALLL2B1FILE

sLevelWallFiles	dc.l	lvl3b1Strip,lvl1b1Strip, lvl2b2Strip,  lvl2b2Strip
		dc.l	lvl2b2Strip,lvl2b2Strip,lvl2b2Strip,lvl2b2Strip

borderMap:
		incbin	border.fpc

	 	even

		include	globals.i

	 	end





