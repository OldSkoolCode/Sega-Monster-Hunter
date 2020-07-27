;{----------------------------------------------------------------------}
;{	SPRITES.S							}
;{	Monster Hunter:							}
;{	  Sprite Routines Module					}
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

_Work_Sprlist	ds.w	(SPRLISTSIZE/2)*MAXSPRITES
_SYS_LastSpr	ds.w	1
_SYS_FirstSpr	ds.w	1
_StaticSprites	ds.w	1
StatSprChars	ds.w	MAXSTATICSPRITES

LENGTHBSS	equ	*-_Work_Sprlist
		inform	0,'length of bss = %d',LENGTHBSS

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text


;{----------------------------------------------------------------------}
;{ Function:	_SendFrameChars						}
;{ Description:	Send frames character set over to VRAM			}
;{ Parameters:	a0 = pointer to animation structure			}
;{ Returns:	d0 = character loaded into				}
;{----------------------------------------------------------------------}
_SendFrameChars	Module

		move.w	AHCHAROFFSET(a0),d0
		lea	0(a0,d0.w),a0
		jsr	DLChars		; download character set
		rts

		modEnd


;{----------------------------------------------------------------------}
;{ Function:	_getFrameInfo						}
;{ Description: get Frames information and return it			}
;{ Parameters:	d2 = animation #					}
;{		d3 = frame #						}
;{		a0 = Pointer to Animation Header			}
;{ Returns:	d0 = maximum frames					}
;{		d1 = maximum animations in file				}
;{		a0 = Pointer to Sprite Information			}
;{		a1 = Pointer to actual data				}
;{----------------------------------------------------------------------}
_getFrameInfo	Module

		movem.l	d1-d7,-(sp)

		move.l	a0,a1
		move.w	AHALISTOFFSET(a0),d5	; get animation list offset
		lsl.w	#2,d2
		add.w	d2,d5
		lea	0(a0,d5.w),a0
		move.w	(a0)+,d7	; number of frames in animations
		cmp.w	d7,d3		; see if in range
		bge.s	.GFIExit
		move.w	(a0),d5		; anim to frame offset
		lsl.w	#1,d3
		add.w	d3,d5
		lea	0(a1,d5.w),a0	; get to framelists
		move.w	(a0),d5		; get offset to sprite info
		lea	0(a1,d5.w),a0
		add	#4,a0		; skip # sprites and hotspot offset
		clr.l	d0
		move.w	SAATTRIBUTES(a0),d0	; get character number
		btst.b	#2,AHFLAGS+1(a1)
		bne.s	.isBitMap
		and.l	#$7ff,d0
.isBitMap:
		lsl.l	#5,d0		; * 32 bytes per character
		clr.l	d1
		move.w	AHCHAROFFSET(a1),d1
		add.l	d1,d0
		add.l	#2,d0
		add.l	d0,a1
.GFIExit:
		move.w	d7,d0
		movem.l	(sp)+,d1-d7
		rts

		modEnd

;{----------------------------------------------------------------------}
;{ Function:	_DispScaledSprite					}
;{ Description:	Put Scaled sprite list in sprite list structure		}
;{ Parameters:	d0 = x position on screen				}
;{		d1 = y position on screen				}
;{		D4 = character # loaded into				}
;{		a0 = pointer to scaled list				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_SendScaledSprite module

		movem.l	d0-d7/a0-a2,-(sp)
		bra.s	SendSpriteFrames

		modend

;{----------------------------------------------------------------------}
;{ Function:	_DispFrame						}
;{ Description: Put Frame is Display list structure			}
;{ Parameters:	d0 = x position						}
;{ 		d1 = y position						}
;{		d2 = animation #					}
;{		d3 = frame #						}
;{		d4 = char # for start of sprite data			}
;{		a0 = Pointer to Animation Header			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_DispFrame	Module

		movem.l	d0-d7/a0-a2,-(sp)

		move.l	a0,a1
		move.w	AHALISTOFFSET(a0),d5	; get animation list offset
		lsl.w	#2,d2
		add.w	d2,d5
		lea	0(a0,d5.w),a0
		cmp.w	(a0)+,d3	; see if in range
		bge.s	.DFExit
		move.w	(a0),d5
		lsl.w	#1,d3
		add.w	d3,d5
		lea	0(a1,d5.w),a0	; get to framelists
		move.w	(a0),d5		; get offset to sprite info
		lea	0(a1,d5.w),a0
SendSpriteFrames:
		move.w	(a0)+,d5	; # of sprites in frame
		add.l	#2,a0		; bypass hotspot pointer
		lea	_Work_SprList,a2
		move.w	_SYS_LastSpr,d6
		move.w	d6,d2		; save system last sprite for later
		lsl.w	#3,d6
		lea	0(a2,d6.w),a2	; pointer to sprite lists
		move.w	d2,d6
		add.w	d5,d6
		cmp.w	#MAXSPRITES,d6
		bgt.s	.DFExit		; to many sprites
		subq.l	#1,d5
.SpriteLoop:
		move.w	(a0)+,d3
		add.w	d1,d3		; add in y position
		add.w	#$80,d3
		move.w	d3,(a2)+	; save it
		add.w	#1,d2		; next system last sprite
		move.w	(a0)+,d3
		add.w	d2,d3		; make link
		move.w	d3,(a2)+	; save link info
		move.w	(a0)+,d3	; save character pointer.
		add.w	d4,d3		; update character pointer
		move.w	d3,(a2)+
		move.w	(a0)+,d3
		add.w	d0,d3		; make x position
		add.w	#$80,d3
		move.w	d3,(a2)+	; and store it
		dbra	d5,.SpriteLoop

		move.w	d2,_SYS_LastSpr
		
.DFExit:
		movem.l	(sp)+,d0-d7/a0-a2
		rts

		modEnd

;{----------------------------------------------------------------------}
;{ Function:	_updateFrame						}
;{ Description:	update frame for sprite and make sure still in range	}
;{ Parameters:	d0 = frame						}
;{		d2 = animation number					}
;{		a0 = pointer to sprite animation			}
;{ Returns:	d0 = new frame						}
;{		d1 = -1 - wrapped					}
;{----------------------------------------------------------------------}
_updateFrame	Module

		movem.l	d2-d3,-(sp)
		move.w	d0,d1
		add.w	#1,d1
		clr.w	d3
		jsr	_getFrameInfo
		cmp.w	d0,d1
		blt	.frameInRange
		clr.w	d1
		move.w	#-1,d0
.frameInRange:
		exg	d1,d0
		movem.l	(sp)+,d2-d3
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	_sortSprites						}
;{ Description:	sort sprite list 					}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_sortSprites	Module

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	_SendSprList						}
;{ Description:	Send sprite list to VRAM				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_SendSprList	Module

		movem.l	d0-d3/a0-a1,-(sp)

		lea	_Work_SprList,a0
		move.w	_SYS_LastSpr,d2
		cmp.w	_staticSprites,d2
		bne.s	.NotOnlyStatic
		move.w	_staticSprites,d2
.NotOnlyStatic:
		tst.w	d2
		beq.s	.StaticSpritesOnly
		lsl.w	#3,d2
		move.w	d2,d1
		sub.w	#8,d2
.StaticSpritesOnly:
		lea	0(a0,d2.w),a1		; get to last sprite in list
		move.w	SLLINK(a1),d3
		and.w	#$0f00,SLLINK(a1)	; make last in list
		move.w	_SprAttrAddr,d0
		lea	_Work_SprList,a0
		move.w	_staticSprites,d2
		beq.s	.NoStaticSprites2	; none so don't bypass 0
		subq	#1,d2			; need last sprite link changed
		lsl.w	#3,d2			; size of sprite info (*8)
		add.w	d2,d0			; don't update static sprite list
		add.w	d2,a0			; source address
		sub.w	d2,d1			; # bytes to move is reduced
.NoStaticSprites2:

		move.w	d1,d2			; save last sprite #

		jsr	AddDMAQueue
		jsr	waitDMAQueue

		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	d3,SLLINK(a1)		; put link back in
.SLExit:
		movem.l	(sp)+,d0-d3/a0-a1
		rts
		modEnd

;{----------------------------------------------------------------------}
;{ Function:	SetSpritePal						}
;{ Description:	Set the palette from Sprite structure			}
;{ Parameters:	a0 = pointer to sprite structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_SetSpritePal	Module


		move.w	(a0),d0		; get palette offset
		lea	0(a0,d0.w),a0
		jsr	_SetPal
		rts

		Modend

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}
		section	.data


crosshair:
sidespr:
radarblip:

dummy1spr:
		dc.w	1		; number of sprites
		dc.w	0		; hotspot catalog pointer
		dc.w	0		; vertical position
		dc.w	%0000000100000000	; size/link data
		dc.w	%1000000000000000	; info
		dc.w	0		; horizontal position

dummy2spr:
		dc.w	2		; number of sprites
		dc.w	0		; hotspot catalog pointer

		dc.w	0		; vertical position
		dc.w	%0000001100000000	; size/link data
		dc.w	%1000000000000000	; info
		dc.w	0		; horizontal position

		dc.w	32		; vertical position
		dc.w	%0000001100000000	; size/link data
		dc.w	%1000000000000000	; info
		dc.w	0		; horizontal position


dummyBlocks:
		dc.w	4
		dc.l	-1,-1,-1,-1,-1,-1,-1,-1
		dc.l	-1,-1,-1,-1,-1,-1,-1,-1
		dc.l	-1,-1,-1,-1,-1,-1,-1,-1
		dc.l	-1,-1,-1,-1,-1,-1,-1,-1

		include	globals.i


		end
