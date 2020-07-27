;{----------------------------------------------------------------------}
;{	SCALE.S								}
;{	Monster Hunter:							}
;{	  SCALE Routines 						}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: scale.s_v $
;Revision 1.9  1993/07/08  15:26:54  KENH
;*** empty log message ***
;
;Revision 1.8  1993/07/08  15:26:23  KENH
;*** empty log message ***
;
;Revision 1.7  1993/07/08  15:24:09  KENH
;*** empty log message ***
;
;Revision 1.6  1993/06/14  20:24:40  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/07  19:57:11  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/02  07:09:36  KENH
;New routines for wall sets
;
;Revision 1.3  1993/05/13  23:07:17  KENH
;*** empty log message ***
;
;Revision 1.2  1993/04/29  13:49:28  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:48:42  KENH
;Initial revision
;
	even

	include	macros.i
	include equates.i

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text


;{----------------------------------------------------------------------}
;{ Function:	_ScaleBuffer						}
;{ Description:	Build Scaled data from data				}
;{ Parameters:	d0 = width of data					}
;{		d1 = height of data					}
;{		d2 = destination width of data				}
;{		d3 = destination height of data				}
;{		a0 = source buffer					}
;{		a1 = destination buffer					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_ScaleBuffer	Module

		movem.l	d0-d7/a0-a1,-(sp)

;
; -----	Scale up width
;
		cmp.w	d2,d0		; destination
;		bgt.s	.WSmaller
		add.w	d0,d0
		move.w	d0,d4		; d4 = (src*2)
		sub.w	d2,d0		; (src*2)-dest
		move.w	d0,d5		; d5 = (src*2)-dest
		sub.w	d2,d0		; (src*2)-(dest*2)
;
; -----	Scale height
;
		cmp.w	d1,d3


		movem.l	(sp)+,d0-d5/a0-a1
		rts

		modend


;{----------------------------------------------------------------------}
;{ Function:	BuildPOVMap						}
;{ Description:	Build POV character map data				}
;{ Parameters:	d0 = starting character					}
;{		a0 = pointer to map buffer				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
BuildPOVMap	module

		movem.l	d0-d6/a0-a1,-(sp)

		move.w	borderChars,d6
		or.w	#$8000,d6		; top priority
		lea	borderMap,a1
		move.w	BHMAPOFFSET(a1),d1	; get offset to map
		lea	4(a1,d1.w),a1

		move.w	#TOPBORDCHARS-1,d2
.topBordLoop1:
		move.w	#POVXCHARS-1,d1
.topBordLoop2:
		move.w	(a1)+,d3
		add.w	d6,d3
		move.w	d3,(a0)+
		dbra	d1,.topBordLoop2
		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a0
		dbra	d2,.topBordLoop1
;
; skip top border in characters
;
		add.w	#TOPBORDCHARS,d0
;
; height to build
;
		move.w	#(POVYCHARS-(TOPBORDCHARS+BOTTOMBORDCHARS))-1,d3
.heightLoop:
		move.w	#LEFTBORDCHARS-1,d1
.leftBordLoop:
		move.w	(a1)+,d2
		add.w	d6,d2
		move.w	d2,(a0)+
		dbra	d1,.leftBordLoop

		adda.w	#(VISIBLEMAPWIDTH-(LEFTBORDCHARS+RIGHTBORDCHARS))*2,a1

		move.w	#(MAXPOVWIDTH/8)-1,d1
		move.w	d0,d2
.leftLoop:
		move.w	d2,(a0)+
		add.w	#(MAXPOVHEIGHT)/8,d2
		dbra	d1,.leftLoop
		
		move.w	#POVCENTERCHARS-1,d1
		move.w	#$8000,d2
		cmp.w	#6,d3
		blt.s	.centerLoop
		cmp.w	#11,d3
		bge.s	.centerLoop
		clr.w	d2
.centerLoop:
		move.w	d2,(a0)+			; zero out
		dbra	d1,.centerLoop

		move.w	d0,d2
		add.w	#((MAXPOVWIDTH/8)-1)*(MAXPOVHEIGHT/8),d2
		or.w	#%0000100000000000,d2	; h-flip bit
		move.w	#(MAXPOVWIDTH/8)-1,d1
.rightLoop:
		move.w	d2,(a0)+
		sub.w	#(MAXPOVHEIGHT/8),d2
		dbra	d1,.rightLoop		; output right hand characters

		move.w	#RIGHTBORDCHARS-1,d1
.rightBordLoop:
		move.w	(a1)+,d2
		add.w	d6,d2
		move.w	d2,(a0)+
		dbra	d1,.rightBordLoop

		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a0
		addq.w	#1,d0

		dbra	d3,.heightLoop

		move.w	#BOTTOMBORDCHARS-1,d2
.bottomBordLoop1:
		move.w	#POVXCHARS-1,d1
.bottomBordLoop2:
		move.w	(a1)+,d3
		add.w	d6,d3
		move.w	d3,(a0)+
		dbra	d1,.bottomBordLoop2
		adda.w	#(MAPWIDTH-VISIBLEMAPWIDTH)*2,a0
		dbra	d2,.bottomBordLoop1

		movem.l	(sp)+,d0-d6/a0-a1
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	BuildPOVFloorMap					}
;{ Description:	Build floor character map data				}
;{ Parameters:	d0 = starting character					}
;{		a0 = pointer to map buffer				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
BuildPOVFloorMap module

		movem.l	d0-d3/a1,-(sp)

		move.w	#(FLOORYCHAR*MAPWIDTH)-1,d1
.mapBTopclrLoop:
		clr.w	(a0)+
		dbra	d1,.mapBTopclrLoop

		lea	FLOORVISIBLE*2(a0),a1
		move.w	FloorChars1,d0
		move.w	FloorChars2,d3
		or.w	#CHARVF,d0
		or.w	#CHARVF,d3
		add.w	#(FLOORHCHAR-1)*FLOORWIDTH,d0
		add.w	#(FLOORHCHAR-1)*FLOORWIDTH,d3

		move.w	#FLOORHCHAR-1,d2
.mapBHeight:
		move.w	#((FLOORVISIBLE-FLOORWIDTH)/2)-1,d1
.mapBLeftLoop:
		clr.w	(a0)+
		clr.w	(a1)+
		dbra	d1,.mapBLeftLoop

		move.w	#FLOORWIDTH-1,d1
.mapBCentLoop:
		move.w	d0,(a0)+
		move.w	d3,(a1)+
		addq.w	#1,d0
		addq.w	#1,d3
		dbra	d1,.mapBCentLoop

		sub.w	#FLOORWIDTH*2,d0
		sub.w	#FLOORWIDTH*2,d3
		
;
; ----- plus one if odd
;
		move.w	#(((FLOORVISIBLE-FLOORWIDTH)+1)/2)-1,d1
.mapBRightLoop:
		clr.w	(a0)+
		clr.w	(a1)+
		dbra	d1,.mapBRightLoop

		adda.w	#FLOORVISIBLE*2,a0
		adda.w	#FLOORVISIBLE*2,a1

		dbra	d2,.mapBHeight

		move.w	#((MAPHEIGHT-(FLOORYCHAR+FLOORHCHAR))*MAPWIDTH)-1,d1
.mapBBotLoop:
		clr.w	(a0)+
		dbra	d1,.mapBBotLoop


		movem.l	(sp)+,d0-d3/a1
		rts

		modEnd

;{----------------------------------------------------------------------}
;{ Function:	DoPOVScroll						}
;{ Description:	Scales wall in POV					}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DoPOVScroll	module

		movem.l	d0-d7/a0-a6,-(sp)

		lea	sprAddedFlags,a6

		tst.b	firstTimePOV
		beq	.NotFirstTime
		
		lea	BlackmapPal,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange

		move.l	#ScaleBuff1,ScaleBuffPtr1
		move.l	#ScaleBuff2,ScaleBuffPtr2

		move.b	#1,pageOn

		setVdpRegister VDP_MODESET3,8	; full scroll for screen

		lea	mapBuff,a0
		lea	mapBuff2,a1
		move.w	#((MAPWIDTH*MAPHEIGHT)/4)-1,d0
.clrLoop1:
		clr.l	(a0)+
		clr.l	(a1)+
		dbra	d0,.clrLoop1

		move.l	scaleBuffPtr1,a0
		move.l	scaleBuffPtr2,a1
		move.w	#((((MAXPOVWIDTH+7)&$fff8)*MAXPOVHEIGHT)/8)-1,d0
.clrLoop2:
		clr.l	(a0)+
		clr.l	(a1)+
		dbra	d0,.clrLoop2

		move.w	mapChars1,d0
		or.w	#$8000,d0
		lea	mapBuff,a0
		jsr	BuildPOVMap

		lea	mapBuff,a0
		jsr	sendScreen
		jsr	waitDMAQueue

		lea	mapBuff2,a0
		move.w	floorChars1,d0
		jsr	buildPOVFloorMap

		lea	mapBuff2,a0
		move.w	_ScrBAddr,d0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

.NotFirstTime:
		move.l	ScaleBuffPtr1,a0
		move.w	#(((((MAXPOVWIDTH+7)&$fff8)*MAXPOVHEIGHT)/2)/4)-1,d0
.clrLoop:
		clr.l	(a0)+
		dbra	d0,.clrLoop
		
		move.w	floorChars1,d0
		move.w	floorChars2,d1
		move.w	d0,floorChars2
		move.w	d1,floorChars1
		eor.b	#1,pageOn

		move.l	curLevelMap,a2		; get current structure pointer

		moveq.l	#0,d0
		move.w	curXPos,d0
		divu	#40,d0			; get wall offset
		move.l	d0,d5
		if (MAPLEVELSIZE<>24)
		inform	0,'shifts no longer valid for'
		inform	1, mulitiply of MAPLEVELSIZE', MAPLEVELSIZE
		endif
		lsl.w	#3,d0			; * 8
		move.w	d0,wallXPos
		add.w	d0,a2
		add.w	d0,d0			; * 16
		add.w	d0,a2			; get to wall start
		add.w	d0,wallXPos		; wallXPos * 40
		add.w	d0,wallXPos
		move.w	#56,WallYPos
		move.l	scaleBuffPtr2,a5
;
; ----- Magic Numbers NOT!!!!
;
;	fixed point ratio adds for scaling walls from 5x40 pixels source
;	to 112 pixels wide destination.
;
		movem.l	d5/a2,-(sp)
		clr.w	d7
		clr.l	d6			; what to add to source
		clr.w	d4			; initial destination x
		move.l	scaleBuffPtr2,a5
		lea	XSCALERTNS,a3		; initial entry into scale rtns
		adda.w	#FLOORANIM,a2		; now do floor
		jsr	BuildPOVFloor

		movem.l	(sp)+,d5/a2
.POVSDump:
		move.w	#(FLOORHCHAR*FLOORWIDTH)*32,d1
		move.w	floorChars2,d0
		lsl.w	#5,d0
		move.l	scaleBuffPtr2,a0
		jsr	addDMAQueue
;		jsr	waitDMAQueue
;		unlk	a6
;		move.l	(sp)+,a6

		clr.l	d6			; what to add to source
		clr.w	d4			; initial destination x
		move.l	scaleBuffPtr1,a5
		lea	YSCALERTNS,a3		; initial entry into scale rtns
		jsr	BuildPOVWall

;
;
;
		move.w	#(((MAXPOVWIDTH+7)&$fff8)/2)*MAXPOVHEIGHT,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		move.l	scaleBuffPtr1,a0
		jsr	addDMAQueue

		move.b	pageOn,d1
		and.w	#$ff,d1
		add.w	d1,d1
		add.w	d1,d1
		lea	HPovScroll,a0
		adda.w	d1,a0
		move.w	#HSCROLL,d0
		move.w	#4,d1
		jsr	addDMAQueue

		tst.b	firstTimePOV
		beq.s	.noFadein
		jsr	waitDMAQueue
		move.l	curLevelMap,a0
		move.l	curWallSet,a0
		move.w	AHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.w	#8,d0			; black out palette
		jsr	fadetoPalRange
.noFadeIn:
		jsr	waitDMAQueue
		sf	firstTimePOV
		movem.l	(sp)+,d0-d7/a0-a6
		rts

		modEnd


;{----------------------------------------------------------------------}
;{ Function:	buildPOVWall						}
;{ Description:	Scales wall in POV					}
;{ Parameters:	d7 = 1 if wall 0 if floor or ceiling			}
;{		a2 = pointer to first map level structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
buildPOVWall	Module

		move.w	#(MAXPOVWIDTH/2),d2
		move.l	a2,-(sp)
		bra	.addNewSprites
.wallLoop:
		move.w	d2,-(sp)
		move.l	curWallSet,a0
		move.w	WALLANIM(a2),d2
		move.w	WALLFRAME(a2),d3
		jsr	_GetFrameInfo
 
		move.w	(sp)+,d2
		move.w	SAHVLINK(a0),d0
		move.w	d0,d1
		lsr.w	#8,d0
		and.w	#$ff,d1
		movea.l	a1,a0
		lea	UnpackSrcData,a1
		move.l	a2,-(sp)

		move.l	a0,a4
		adda.w	#WALLWIDTH/2,a4		; next y line
		swap	d5			; get x offset
		move.w	d5,d0
		swap	d5
		lsr.w	#1,d0
		add.w	d0,a0			; add to start address
		
.scaleLoop:
		move.l	a5,a1			; destination
		move.l	(a3)+,a2
		jsr	(a2)
;
; -----	Debugging Purposes.
;
;		movem.l	d0-d7/a0-a6,-(sp)
;		move.w	#(MAXPOVWIDTH/2)*MAXPOVHEIGHT,d1
;		move.w	mapChars1,d0
;		lsl.w	#5,d0
;		move.l	scaleBuffPtr1,a0
;		jsr	addDMAQueue
;		jsr	waitDMAQueue
;		movem.l	(sp)+,d0-d7/a0-a6

		addq.w	#1,d4
		and.w	#$3,d4
		tst.w	d4
		beq.s	.NextChar		; haven't overflowed next char
		add.w	#1,a5
		bra.s	.NotNextChar
.NextChar:
 		add.w	#(MAXPOVHEIGHT*4)-3,a5	; next destination x
.NotNextChar:
		add.w	d0,a0
		cmp.l	a0,a4			; time for new wall?
		ble.s	.NewSource		; yep
.NextYScale:
		dbra	d2,.scaleLoop
		addq.w	#1,d2
.NewSource:
		suba.l	a4,a0
		swap	d5
		move.w	a0,d5
		add.w	d5,d5
		swap	d5
		move.l	(sp)+,a2
		adda.w	#MAPLEVELSIZE,a2
		move.l	a2,-(sp)
		add.w	#40,wallXPos		; next wall x position
.AddNewSprites:
		move.w	d2,-(sp)
		tst.b	(a6)+			; already added?
		bne.s	.noSprites		; yep
		st	-1(a6)
		move.l	SPRITELISTPTR(a2),d2
		beq.s	.noSprites
		movea.l	d2,a1
		move.w	(a1)+,d2
		subq	#1,d2
.addSprites:
		move.l	(a1)+,a0
		move.l	a1,lastMonsterList
		move.w	wallXPos,d0
		move.w	wallYPos,d1
		jsr	addMonster		; add monster to ai list
		lea	0,a2
		dbra	d2,.addSprites
.noSprites:
		move.w	(sp)+,d2
		move.l	(sp)+,a2

		dbra	d2,.wallLoop
.BPOVExit:
		rts


		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	buildPOVFloor						}
;{ Description:	Scales floor in POV					}
;{ Parameters:	d7 = 1 if wall 0 if floor or ceiling			}
;{		a2 = pointer to first map level structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
buildPOVFloor	Module

		move.w	#FLOORHEIGHT-1,d2
		swap	d5
		mulu	#WALLHEIGHT/2,d5
		swap	d5
.floorLoop:
		move.w	d2,-(sp)
		move.l	curWallSet,a0
		move.w	WALLANIM(a2),d2
		move.w	WALLFRAME(a2),d3
		jsr	_GetFrameInfo
 
		move.w	(sp)+,d2
		move.w	SAHVLINK(a0),d0
		move.w	d0,d1
		lsr.w	#8,d0
		and.w	#$ff,d1
		movea.l	a1,a0
		lea	UnpackSrcData,a1
		move.l	a2,-(sp)

		move.l	a0,a4
		adda.w	#(WALLHEIGHT/2)*WALLWIDTH,a4 ; end of wall section
		swap	d5			; get x offset
		move.w	d5,d0
		swap	d5
		add.w	d0,a0			; add to start address
		
.scaleLoop:
		move.l	a5,a1			; destination
		move.l	(a3)+,a2
		jsr	(a2)
;
; -----	Debugging Purposes.
;
;		movem.l	d0-d7/a0-a6,-(sp)
;		move.w	#(MAXPOVWIDTH/2)*MAXPOVHEIGHT,d1
;		move.w	floorChars2,d0
;		lsl.w	#5,d0
;		move.l	scaleBuffPtr2,a0
;		jsr	addDMAQueue
;		jsr	waitDMAQueue
;		movem.l	(sp)+,d0-d7/a0-a6

		addq.w	#1,d4			; next y count
		and.w	#7,d4
		beq.s	.NextChar		; haven't overflowed next char
		add.w	#4,a5			; next y line
		bra.s	.NotNextChar
.NextChar:
		add.w	#(FLOORWIDTH*32)-28,a5	; next destination x
.NotNextChar:
		add.w	d0,a0
		cmp.l	a0,a4			; time for new wall?
		ble.s	.NewSource		; yep
.NextYScale:
		dbra	d2,.scaleLoop
		addq.w	#1,d2
.NewSource:
		suba.l	a4,a0			; get # overflow
		swap	d5
		move.w	a0,d5			; save in d5 for later
;		add.w	d5,d5
		swap	d5
		move.l	(sp)+,a2
		adda.w	#MAPLEVELSIZE,a2
		add.w	#40,wallXPos		; next wall x position

		dbra	d2,.floorLoop
.BPOVExit:
		rts


		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	diagflipWall						}
;{ Description:	diagonally flip scaled wall				}
;{ Parameters:	a0 = source pointer to wall				}
;{		a1 = destination pointer				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
diagflipWall	Module

		movem.l	d0-d6/a0-a6,-(sp)

		move.w	#48-1,d0	; source width

		clr.w	d1
		clr.w	d2
		move.w	#$ff,d5
		lea	expandNib1,a5
		lea	expandNib2,a6
		move.l	a1,a2
		adda.w	#4,a2
.DFWLoop1:
.count		= 0
		rept	MAXPOVHEIGHT/2

		move.b	.count(a0),d3
		move.b	.count+4(a0),d4
		and.w	d5,d3
		and.w	d5,d4
		add.w	d3,d3
		add.w	d4,d4
		move.w	0(a5,d3.w),d3
		move.w	0(a6,d4.w),d4
		or.w	d4,d3
		move.b	d3,(a1)+
		move.w	d3,-(sp)
		move.b	(sp)+,(a2)+

.count		= .count+8
		if ((.count&$1f)=0)
		adda.w	#32-4,a1
		adda.w	#32-4,a2
		endif
		endr
		adda.w	#1,a0
.NotNextByte:
		suba.w	#(((MAXPOVHEIGHT/8))*32)-8,a1
		suba.w	#(((MAXPOVHEIGHT/8))*32)-8,a2
		addq.w	#1,d1
		and.w	#3,d1
		bne.s	.NotNextChar
		adda.w	#(((MAXPOVHEIGHT/8)-1)*32),a1
		adda.w	#(((MAXPOVHEIGHT/8)-1)*32),a2
 		add.w	#(MAXPOVHEIGHT*4)-4,a0	; next source x
.NotNextChar:
		dbra	d0,.DFWLoop1

		movem.l	(sp)+,d0-d6/a0-a6
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	UnpackWall						}
;{ Description:	Unpack wall into buffer					}
;{ Parameters:	d0 = x position inside of 40 x 72 wall			}
;{		a0 = pointer to 1st 40 x 72 wallset			}
;{		a1 = pointer to 2nd 40 x 72 wallset			}
;{		a2 = buffer to unpack into				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
UnpackWall	Module


		movem.l	d0-d5/a0-a3,-(sp)

		lea	UnpackTab,a3
		move.w	#(WALLHEIGHT*2)-1,d2
		lsr.w	#1,d0
		move.w	d0,d1
		move.w	d0,d5
		neg.w	d0
		add.w	#WALLWIDTH/2,d0
		move.w	d0,d4
		mulu	#instructSize,d0
		mulu	#instructSize,d1
		add.w	d5,a0
.HLoop:
		jmp	.wLoop(pc,d1.w)
.wLoop:
		rept	WALLWIDTH/2
		move.b	(a0)+,d3
		and.w	#$ff,d3
		add.w	d3,d3
		move.w	0(a3,d3.w),d3
		move.w	d3,(a2)+
		endr
instructSize	equ	(*-.wLoop)/(WALLWIDTH/2)

		adda.w	d5,a0
		exg	d4,d5
		exg	a0,a1
		exg	d0,d1
		dbra	d2,.HLoop

		movem.l	(sp)+,d0-d5/a0-a3
		rts

		modEnd


;{----------------------------------------------------------------------}
;{ Function:	CopyRightToLeft						}
;{ Description:	Copy right hand side of visible screen to left hand	}
;{ Parameters:	a0 = pointer to buffer					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
CopyRightToLeft	Module


		movem.l	d0/a1,-(sp)
		move.l	a0,a1
		add.w	#VISIBLEMAPWIDTH*2,a1

		rept	MAPHEIGHT
		rept	VISIBLEMAPWIDTH/2
		move.w	-(a1),d0
		or.l	#$0800,d0
		move.w	d0,(a0)+
		endr
		adda.w	#(MAPWIDTH*2)-VISIBLEMAPWIDTH,a0
		adda.w	#(MAPWIDTH*2)+VISIBLEMAPWIDTH,a1
		endr

		movem.l	(sp)+,d0/a1
		rts


		modEnd

dummyPov:
		addq	#1,d5
		rts

;{----------------------------------------------------------------------}
;{ Function:	ScaleYY							}
;{ Description:	Scales strip into buffer				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
		include	scaleyy.s

;{----------------------------------------------------------------------}
;{ Function:	ScaleXX							}
;{ Description:	Scales strip into buffer				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
		include	scalexx.s

expandNib1:
.count		= 0
		rept	256
		dc.w	(.count&$f0)!((.count<<12)&$f000)
.count		= .count+1
		endr

expandNib2:
.count		= 0
		rept	256
		dc.w	(.count>>4)!((.count<<8)&$0f00)
.count		= .count+1
		endr

;
; ----- Odd characters wide so center with scroll of 4
;
HPovScroll	dc.w	0, 36		; when right buffer
		dc.w	0, 292		; when left buffer

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}

BssGroup	group	Bss

		section	.bss,BssGroup

scaleBuff1	ds.b	(((MAXPOVWIDTH+7)&$fff8)*MAXPOVHEIGHT)/2
scaleBuff2	ds.b	(((MAXPOVWIDTH+7)&$fff8)*MAXPOVHEIGHT)/2
LENGTHSCALEBUFF2 equ	*-scaleBuff2
		ds.b	(SCREENWIDTH*WALLHEIGHT)-LENGTHSCALEBUFF2
mapChars1	ds.w	1
floorChars1	ds.w	1
floorChars2	ds.w	1
scaleBuffPtr1	ds.l	1
scaleBuffPtr2	ds.l	1
firstTimePOV	ds.b	1
pageOn		ds.b	1

LENGTHBSS	equ	*-scaleBuff1
		inform	0,'length of bss = %d',LENGTHBSS

		include	globals.i

		end
