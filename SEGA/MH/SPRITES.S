;{----------------------------------------------------------------------}
;{	SPRITES.S							}
;{	Monster Hunter:							}
;{	  Sprite Routines Module					}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: sprites.s_v $
;Revision 1.6  1993/07/08  15:26:57  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/14  20:23:50  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/07  19:55:38  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/02  07:07:25  KENH
;*** empty log message ***
;
;Revision 1.2  1993/05/13  23:08:11  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:49:13  KENH
;Initial revision
;

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
StatSprNum	ds.w	MAXSTATICSPRITES
StatSprSize	ds.w	MAXSTATICSPRITES

saveLink	ds.w	1
saveSprPtr	ds.l	1


LENGTHBSS	equ	*-_Work_Sprlist
		inform	0,'length of bss = %d',LENGTHBSS

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text


;{----------------------------------------------------------------------}
;{ Function:	getStatWH						}
;{ Description:	get static sprites width and height			}
;{ Parameters:	a0 = pointer to frame information			}
;{ returns:	d2 = width						}
;{ 		d3 = height						}
;{----------------------------------------------------------------------}
getStatWH	Module

		movem.l	d5-d7/a0-a2,-(sp)

		clr.w	d2
		clr.w	d3

		move.w	-SAHEADSIZE(a0),d5 ; get number of sprites in frame
		subq.w	#1,d5		; for dbra
		lea	spriteW2Char,a1	; conversion of bits to # char table
		lea	spriteH2Char,a2	; conversion of bits to # char table
.countLoop:
		move.w	SAHVLINK(a0),d7	; get size of character
		lsr.w	#7,d7		; into low nibble for table access
		and.w	#$1e,d7
		add.w	0(a1,d7.w),d2	; add in character count
		add.w	0(a2,d7.w),d3	; add in character count
		lea	SASIZE(a0),a0	; next sprite of frame
		dbra	d5,.countLoop	; and do entire list

		movem.l	(sp)+,d5-d7/a0-a2
		rts

		ModEnd

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
;[		a0 = Pointer to Sprite Information			}
;{		a1 = Pointer to actual data				}
;{----------------------------------------------------------------------}
_getFrameInfo	Module

		movem.l	d1-d7,-(sp)

		move.l	a0,a1
		move.w	AHALISTOFFSET(a0),d5	; get animation list offset
		lsl.w	#2,d2
		add.w	d2,d5
		lea	0(a0,d5.w),a0
		move.w	(a0)+,d7
		cmp.w	d7,d3		; see if in range
		bge.s	.GFIExit
		move.w	(a0),d5
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
		move.w	d7,d0
.GFIExit:
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
		bge	.DFExit
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
		move.w	(a0)+,d7
		add.w	d2,d7		; make link
		move.w	d7,(a2)+	; save link info
		move.w	(a0)+,d3	; save character pointer.
		add.w	d4,d3		; update character pointer
		move.w	d3,(a2)+
		move.w	(a0)+,d3
		btst.l	#CHARHFBIT,d4	; horizontally flipped?
		beq.s	.noHFlip
		neg.w	d3
		lsr.w	#2,d7
		move.w	d7,-(sp)
		move.b	(sp)+,d7
		and.w	#$3,d7
		addq.w	#1,d7
		add.w	d7,d7
		add.w	d7,d7
		add.w	d7,d7
		sub.w	d7,d3
.noHFlip:
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
;{		d1 = animation						}
;{		a0 = pointer to sprite animation			}
;{ Returns:	d0 = new frame						}
;{		d1 = -1 - wrapped					}
;{----------------------------------------------------------------------}
_updateFrame	Module

		movem.l	d2-d3,-(sp)
		move.w	d1,d2			; animation #
		move.w	d0,d1			; save frame #
		add.w	#1,d1			; update frame #
		clr.w	d3			; get frame 0 info
		jsr	_getFrameInfo		; from routine
		cmp.w	d0,d1			; see if return value > update
		blt	.frameInRange		; yep so ok
		clr.w	d1			; back to frame 0
		move.w	#-1,d0			; flag wrap
.frameInRange:
		exg	d1,d0			; into correct registers
		movem.l	(sp)+,d2-d3		; and return
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	_sortSprites						}
;{ Description:	sort sprite list 					}
;{ Parameters:	.							}
;{ Returns:	d0 = number of monsters					}
;{----------------------------------------------------------------------}
_sortSprites	Module

		movem.l	d1-d2/a0-a3,-(sp)

		clr.w	d0
		lea	monsterListPtrs,a3
		lea	theMonsterLists,a2
		move.w	#MAXNMONSTERS-1,d1
.cntLoop:
		tst.l	MONSTERMOVETAB(a2)
		beq.s	.nextMonster
		addq.w	#1,d0
		move.l	a2,(a3)+
.nextMonster:
		adda.w	#MONSTERLISTSIZE,a2
		dbra	d1,.cntLoop

		move.w	d0,nMonsterLists
		move.w	d0,d2
		beq.s	.noMonsters
		
		move.w	#4,d1			; pointer size
		lea	MonsterListPtrs,a0
		lea	ScaleCompare,a1
		jsr	ShellSort
		
		move.w	d2,d0
		
.noMonsters:
		movem.l	(sp)+,d1-d2/a0-a3
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	ScaleCompare						}
;{ Description:	Compare 2 sprite pointers to see which is less		}
;{ Parameters:	a0 = pointer to pointer to monsterlist			}
;{		a1 = pointer to pointer to monsterlist			}
;{ Returns:	d0 < 0 if a0 > a1					}
;{		d0 = 0 if a0 = a1					}
;{		d0 > 0 if a0 < a1					}
;{----------------------------------------------------------------------}
ScaleCompare	Module

		movem.l	d1/a0-a1,-(sp)
		move.l	(a0),a0
		move.l	(a1),a1

		move.w	MONSTERAIFLAGS(a0),d1
		and.w	#$20,d1
		move.w	MONSTERAIFLAGS(a1),d0	; if goody or background
		and.w	#$20,d0			; then say goody < anything
		sub.w	d1,d0
		bne.s	.scaleDifferent

		move.w	MONSTERAIFLAGS(a0),d0	; now check proirity bit
		and.w	#$80,d0
		move.w	MONSTERAIFLAGS(a1),d1	; is object on top?
		and.w	#$80,d1
		sub.w	d1,d0
		bne.s	.scaleDifferent		; yep so has higher prioity

		move.w	MONSTERSCALE(a0),d0
		sub.w	MONSTERSCALE(a1),d0
		bne.s	.scaleDifferent

		move.w	MONSTERY(a0),d0
		sub.w	MONSTERY(a1),d0
.scaleDifferent:
		neg.w	d0
		movem.l	(sp)+,d1/a0-a1
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

		move.w	#8,d1			; initial size of sprite list
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
;		move.w	_staticSprites,d2
;		beq.s	.NoStaticSprites2	; none so don't bypass 0
;		subq	#1,d2			; need last sprite link changed
;		lsl.w	#3,d2			; size of sprite info (*8)
;		add.w	d2,d0			; don't update static sprite list
;		add.w	d2,a0			; source address
;		sub.w	d2,d1			; # bytes to move is reduced
.NoStaticSprites2:

		move.w	d1,d2			; save last sprite #

		jsr	AddDMAQueue
		jsr	waitDMAQueue

		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	d3,SLLINK(a1)		; put link back in

;		move.w	d3,saveLink
;		move.l	a1,saveSprPtr
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
;{ Function:	SendStaticSprites					}
;{ Description:	Send static sprites to VRAM				}
;{ Paramters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
SendStaticSprites Module

		movem.l	d0-d5/a1,-(sp)

		lea	StatSprChars,a1
		clr.w	_StaticSprites		; sprite

		move.w	_SYS_LastSpr,d0		; get current last sprite
		move.w	d0,(a1)+

		lea	crosshair,a0
		jsr	_SendFrameChars		; send frame characters
		move.w	d0,StatSprChars+STATICCROSSH

		move.w	_SYS_LastSpr,d5
		move.w	d5,StatSprNum+STATICCROSSH
		move.w	crossHairX,d0
		move.w	crossHairY,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICCROSSH,d4
		or.w	#CHARPRIORITY,d4
		lea	crosshair,a0
		jsr	_DispFrame
		sub.w	_SYS_LastSpr,d5
		neg.w	d5
		move.w	d5,StatSprSize+STATICCROSSH

	; begin addition for radar blip TSD
		lea	radarblip,a0
		jsr	_SendFrameChars		; send frame characters
		move.w	d0,StatSprChars+STATICBLIP

		move.w	_SYS_LastSpr,d0
		move.w	d0,StatSprNum+STATICBLIP
	; send max points sprites for blips
		move.w	#maxRadarPoints-1,d5
.radarBlipLoop
		move.w	#-80,d0
		move.w	#-80,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICBLIP,d4
		lea	radarblip,a0
		jsr	_dispFrame
		dbra	d5,.radarBlipLoop
		
	; end addition for radar blip TSD

;
; ----- set up dummy sprites at end of static list to clip out
;	moveable sprites
;
		move.w	#-$7f,d0		; x has to be > zero
		clr.w	d1
		lea	dummy1spr,a0
		jsr	_SendScaledSprite

		move.w	#-$80,d0		; x has to be zero
		clr.w	d1
		lea	dummy1spr,a0
		jsr	_SendScaledSprite

		lea	redcrossFile,a0
		jsr	_SendFrameChars		; send the characters

		move.w	d0,StatSprChars+STATICREDCROSS1
		move.w	d0,StatSprChars+STATICREDCROSS2

		move.w	_SYS_LastSpr,d0
		move.w	d0,StatSprNum+STATICREDCROSS1
		move.w	#1,d0
		move.w	#-20,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICREDCROSS1,d4
		or.w	#CHARPRIORITY,d4
		lea	redcrossFile,a0
		jsr	_DispFrame

		move.w	_SYS_LastSpr,d0
		move.w	d0,StatSprNum+STATICREDCROSS2
		move.w	#1,d0
		move.w	#-20,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICREDCROSS1,d4
		or.w	#CHARPRIORITY,d4
		lea	redcrossFile,a0
		jsr	_DispFrame

		lea	bulletFile,a0
		jsr	_SendFrameChars

		move.w	d0,StatSprChars+STATICAMMOCLIP1
		move.w	d0,StatSprChars+STATICAMMOCLIP2

		move.w	_SYS_LastSpr,d0
		move.w	d0,StatSprNum+STATICAMMOCLIP1
		move.w	#1,d0
		move.w	#-20,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICAMMOCLIP1,d4
		or.w	#CHARPRIORITY,d4
		lea	bulletFile,a0
		jsr	_DispFrame

		move.w	_SYS_LastSpr,d0
		move.w	d0,StatSprNum+STATICAMMOCLIP2
		move.w	#1,d0
		move.w	#-20,d1
		clr.w	d2
		clr.w	d3
		move.w	StatSprChars+STATICAMMOCLIP1,d4
		or.w	#CHARPRIORITY,d4
		lea	bulletFile,a0
		jsr	_DispFrame

;
; ----- Now send all static sprites before setting not to touch them
;
		move.w	_SYS_LastSpr,d0		; make sure don't touch this
		jsr	_SendSprList
		move.w	d0,_StaticSprites	; sprite
		move.w	d0,_SYS_LastSpr
		move.w	d0,_SYS_FirstSpr
		movem.l	(sp)+,d0-d5/a1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}
		section	.data


crosshair:
		incbin	crossh.fpa

	; begin addition for radar TSD
radarblip:
		incbin	radarblp.bin
	; end addition for radar TSD

explosivFile:
		incbin	gunfire.fpa

hboxFile:
		incbin	hbox.bin

aboxFile:
		incbin	abox.bin

bulletFile:
		incbin	bullet.fpa

redCrossFile:
		incbin	redcross.bin

PowerUpSprLst:
		dc.w	4
		dc.l	redCross1Info
		dc.l	redCross2Info
		dc.l	Bullet1Info
		dc.l	Bullet2Info
		dc.w	0
PowerUpListA:
		dc.w	1
		dc.l	redCross1Info
		dc.w	0
PowerUpListB:
		dc.w	1
		dc.l	redCross2Info
		dc.w	0

PowerUpListC:
		dc.w	1
		dc.l	bullet1Info
		dc.w	0
PowerUpListD:
		dc.w	1
		dc.l	bullet2Info
		dc.w	0


redCross1Info:
		dc.w	50, -20			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	redCrossAI1Table	; move ai table
		dc.l	redCrossHitTable1	; hit ai table
		dc.w	STATICREDCROSS1		; static sprite #
		dc.w	CHARPRIORITY		; flags
		dc.l	redCrossFile		; file for monster
		dc.w	2400			; counter
		dc.w	0			; temp counter
		dc.w	1			; hit points
		dc.w	%101000000		; ai flags
		dc.w	STATICREDCROSS1		; static sprite #
		dc.l	0
		dc.w	0			; current loop counter

redCross2Info:
		dc.w	240, -20			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	redCrossAI2Table	; move ai table
		dc.l	redCrossHitTable2	; hit ai table
		dc.w	STATICREDCROSS2		; static sprite #
		dc.w	CHARPRIORITY		; flags
		dc.l	redCrossFile			; file for monster
		dc.w	1320			; counter
		dc.w	0			; temp counter
		dc.w	1			; hit points
		dc.w	%101000000		; ai flags
		dc.w	STATICREDCROSS2		; static sprite #
		dc.l	0
		dc.w	0			; current loop counter

bullet1Info:
		dc.w	80, -20			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	bulletAI1Table		; move ai table
		dc.l	bulletHitTable1		; hit ai table
		dc.w	STATICAMMOCLIP1		; static sprite #
		dc.w	CHARPRIORITY		; flags
		dc.l	BulletFile			; file for monster
		dc.w	600			; counter
		dc.w	0			; temp counter
		dc.w	1			; hit points
		dc.w	%101000000		; ai flags
		dc.w	STATICAMMOCLIP1		; static sprite #
		dc.l	0
		dc.w	0			; current loop counter

bullet2Info:
		dc.w	180, -20			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	bulletAI2Table		; move ai table
		dc.l	bulletHitTable2		; hit ai table
		dc.w	STATICAMMOCLIP2		; static sprite #
		dc.w	CHARPRIORITY		; flags
		dc.l	BulletFile		; file for monster
		dc.w	900			; counter
		dc.w	0			; temp counter
		dc.w	1			; hit points
		dc.w	%101000000		; ai flags
		dc.w	STATICAMMOCLIP1		; static sprite #
		dc.l	0
		dc.w	0			; current loop counter

redCrossAI1Table:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	2400			; every 20 seconds
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-1			
		dc.w	250			; moveto y position
		dc.w	4			; 4 pixels at a time

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListA		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler

redCrossAI2Table:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1320			; every 10 seconds
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-1			
		dc.w	250			; moveto y position
		dc.w	4			; 4 pixels at a time

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListB		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler

redCrossHitTable1:
		dc.b	AI_DIE, AIDI_ADDPLAYERHP; ai type, sub-type
		dc.w	250			; 20 hitpoints per hit
		dc.w	1			; five hits max
		dc.b	0,0			; filler

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListA		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler

redCrossHitTable2:
		dc.b	AI_DIE, AIDI_ADDPLAYERHP; ai type, sub-type
		dc.w	50			; 20 hitpoints per hit
		dc.w	1			; five hits max
		dc.b	0,0			; filler

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListB		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler


bulletAI1Table:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	600			; every 10 seconds
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-1			
		dc.w	250			; moveto y position
		dc.w	4			; 4 pixels at a time

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListC		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler

bulletAI2Table:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	900			; every 15 seconds
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-1			
		dc.w	250			; moveto y position
		dc.w	4			; 4 pixels at a time

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListD		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler

bulletHitTable1:
		dc.b	AI_DIE, AIDI_ADDAMMO	; ai type, sub-type
		dc.w	2			; 20 hitpoints per hit
		dc.w	1			; 1 hit max
		dc.b	0,0			; filler

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListC		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler


bulletHitTable2:
		dc.b	AI_DIE, AIDI_ADDAMMO	; ai type, sub-type
		dc.w	2			; 20 hitpoints per hit
		dc.w	1			; 1 hit max
		dc.b	0,0			; filler

		dc.b	AI_SUMMON, AISU_CALL
		dc.l	PowerUpListD		; pointer to self list
		dc.b	0,0
		
		dc.b	AI_NULL, 0 		; go away
		dc.b	0,0,0,0,0,0		; filler



dummy1spr:
		dc.w	1		; number of sprites
		dc.w	0		; hotspot catalog pointer
		dc.w	0		; vertical position
		dc.w	%0000001100000000	; size/link data
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


spriteW2Char:
		dc.w	8,8,8,8,16,16,16,16,24,24,24,24,32,32,32,32
spriteH2Char:
		dc.w	8,16,24,32,8,16,24,32,8,16,24,32,8,16,24,32


		include	globals.i


		end
