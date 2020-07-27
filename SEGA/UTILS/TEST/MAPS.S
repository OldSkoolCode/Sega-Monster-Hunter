;{----------------------------------------------------------------------}
;{	MAPS.S								}
;{	Monster Hunter:							}
;{	  Map Routines game						}
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

theWallLists	ds.b	(WALLLISTSIZE*WALLSONSCREEN)

wallXPos	ds.w	1
wallYPos	ds.w	1
firstTimeLR	ds.b	1
sentScroll	ds.b	1
curPanelNumber	ds.w	1

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
		cmp.w	#32,d5
		ble.s	.YLoop
		move.w	#32,d5
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
		move.w	#$2700,sr
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

		move.w	#$2000,sr
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
		move.w	(a0)+,VDATA
		dbra	d2,.ColorLoop

		movem.l	(sp)+,d0-d2/a0
		rts

		modend

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}
		section	.data


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

	 	even

		include	globals.i

	 	end





