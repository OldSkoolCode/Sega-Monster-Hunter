;{----------------------------------------------------------------------}
;{	AI.S								}
;{	Monster Hunter:							}
;{	  AI Routines routines for game					}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: ai.s_v $
;Revision 1.9  1993/07/08  15:26:32  KENH
;*** empty log message ***
;
;Revision 1.8  1993/07/08  15:24:17  KENH
;*** empty log message ***
;
;Revision 1.7  1993/07/08  15:24:01  KENH
;*** empty log message ***
;
;Revision 1.6  1993/06/14  20:22:59  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/07  19:54:47  KENH
;fixed bugs in ai and added some new routines
;
;Revision 1.4  1993/06/02  07:08:20  KENH
;fixed bug of monsterstokill holding up game
;
;Revision 1.3  1993/05/13  23:07:32  KENH
;New ai for Power-Ups/Ammuniton boxes
;
;Revision 1.2  1993/04/29  19:40:10  KENH
;Fixed Alignment problem for sprites
;
;Revision 1.1  1993/04/29  13:49:58  KENH
;Initial revision
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

MonsterBuffOffset ds.w	1
nMonsterLists	ds.w	1
theMonsterLists	ds.b	MONSTERLISTSIZE*MAXNMONSTERS
MonsterListPtrs	ds.l	MAXNMONSTERS
lastMonster1	ds.l	1		; last monster for palette 1
lastMonster2	ds.l	1		; last monster for palette 2
_SYS_scaledChar ds.w	1
monstersToKill	ds.w	1
lastMonsterList	ds.l	1
tSpriteGrid	ds.b	1024		; max size for sprite grids
tempSprList	ds.b	MONSTERLISTSIZE
aiVariables	ds.b	16

LENGTHBSS	equ	*-nMonsterLists
		inform	0,'length of bss = %d',LENGTHBSS
		section	.text

;{----------------------------------------------------------------------}
;{ Function:	MonsterAI						}
;{ Description:	Come here for monster ai routines			}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
monsterAI	Module

		movem.l	d0-d7/a0-a5,-(sp)

		move.w	#MAXNMONSTERS-1,d6
		lea	theMonsterLists,a0	; get address of active monsters
		clr.w	d0			; not first time to ai
		lea	0,a3
.aiLoop:
		move.l	MONSTERMOVETAB(a0),a1	; current ai pointer
		cmpa.l	#0,a1
		beq	.noMonster1
		btst.b	#2,MONSTERAIFLAGS+1(a0)
		bne.s	.notkillable
		adda.w	#1,a3
.notkillable:
		move.l	a1,a2			; save for later in case changes
		move.b	AI_TYPE(a1),d1
		and.w	#$7f,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for pointers
		lea	aiRtnPtrs,a5		; and table of routines
		move.l	0(a5,d1.w),a5		; get pointer
		jsr	(a5)			; call their AI routine
		tst.w	d0			; update move table?
		bpl.s	.noMonster1		; nope
		move.l	MONSTERMOVETAB(a0),a1
		or.w	#(%10<<8),MONSTERAIFLAGS(a0)
		adda.w	#AI_PARMS_SIZE,a1	; next ai entry
		move.l	a1,MONSTERMOVETAB(a0)	; update table entry

		cmp.b	#AI_SETANIM,AI_TYPE(a2)
		beq.s	.noClearFrame
		move.b	AI_TYPE(a1),d5		; get new ai type
		and.w	#$7f,d5			; mask to word
		add.w	d5,d5			; for word table
		lea	aiXlatAnims,a5		; get new anim #
		move.w	0(a5,d5.w),d5		; from table
		btst.b	#7,AI_TYPE(a1)		; is this a command
		bne.s	.noClearFrame		; then don't update animation
		move.w	d5,MONSTERANIM(a0)	; and set up animation #
		cmp.w	#-2,d0
		beq.s	.noClearFrame
		clr.w	MONSTERFRAME(a0)
		clr.w	MONSTERTCOUNTER(a0)
.noClearFrame:
		move.w	#-1,d0
		btst.b	#7,AI_TYPE(a2)		; see if last was command?
		bne	.aiLoop			; yes then go back to same monster
.noMonster1:
		clr.w	d0			; not first time thru ai
		adda.w	#MONSTERLISTSIZE,a0	; next monster
		dbra	d6,.aiLoop

		cmpa.l	#0,a3
		bne	.someMonsters
;		clr.w	monstersToKill
;		clr.w	EndFinished
.someMonsters:
		jsr	_sortSprites		; sort by zdepth then y
		move.w	d0,d7
		beq.s	.allDone
		jsr	waitDMAQueue
		subq.w	#1,d7
		lea	MonsterListPtrs,a4
		clr.w	MonsterBuffOffset
		move.w	_SYS_scaledChar,-(sp)
.drawLoop:
		move.l	(a4)+,a0
		cmp.w	#0,MONSTERANIM(a0)
		beq.s	.noMonster3
		bsr	drawMonster		; draw them
		move.l	MONSTERSFXPTR(a0),a1
		move.w	MONSTERANIM(a0),d0
		move.w	MONSTERFRAME(a0),d1
		cmp.w	SFXANIM(a1),d0
		bne.s	.noMonster3
		cmp.w	SFXFRAME(a1),d1
		bne.s	.noMonster3
		move.l	MONSTERMOVETAB(a0),a2
		move.w	AI_TYPE(a2),d0
		cmp.w	SFXAITYPE(a1),d0
		bne.s	.noMOnster3
		move.l	SFXNUMBER(a1),d0
		move.l	d0,_sfxQueue
.noMonster3:
		dbra	d7,.drawLoop
		move.w	(sp)+,d0
		move.w	MonsterBuffOffset,d1
		beq.s	.AllDone
		lsl.w	#5,d0			; get vram address
		lea	scaleBuff1,a0
		jsr	addDMAQueue
.AllDone:
		movem.l	(sp)+,d0-d7/a0-a5
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	AddMonsterQueue						}
;{ Description:	Come here to add monster in structures if any left	}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
AddMonsterQueue	Module

		movem.l	d0-d3/a0-a2,-(sp)

		move.l	lastMonsterList,a1
		cmpa.l	#0,a1
		beq	.AllDone

		tst.w	monstersToKill
		bne	.AllDone

		move.w	(a1)+,d3		; get # entries
		beq	.AllDone
		move.w	d3,monstersToKill
		subq.w	#1,d3
.AddLoop:
		move.l	(a1)+,a0
		lea	0,a2
		bsr	AddMonster		; add into structures
		cmp.l	#-1,d0
		bne.s	.MonsterOk
		sub.w	#1,monstersToKIll
.MonsterOk:
		dbra	d3,.AddLoop
		move.l	a1,lastMonsterList
.AllDone:
		movem.l	(sp)+,d0-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	AddMonster						}
;{ Description:	Come here to add monster in structures			}
;{ Parameters:	d0 = base x position					}
;{		d1 = base y position					}
;{		a0 = pointer to monster list structure source		}
;{		a2 = pointer to wall structure				}
;{ returns:	d0 = -1 if can't add him				}
;{----------------------------------------------------------------------}
AddMonster	Module

		movem.l	d2-d3/d5/a0-a2/a5,-(sp)

		cmpa.l	#0,a2
		beq.s	.noSetup
		move.l	SETUPPTR(a2),a1
		cmpa.l	#0,a1
		beq.s	.noSetup
		jsr	(a1)
.noSetup:
		move.l	MONSTERFILEPTR(a0),a1
		move.w	AHPALOFFSET(a1),d2
		adda.w	d2,a1
		move.w	(a1),d2
		move.w	d2,d3
		lsr.w	#2,d3
		lea	globalPals,a2
		move.l	a1,0(a2,d3.w)
		lsl.w	#1,d2

		lea	theMonsterLists,a1
		move.w	#MAXNMONSTERS-1,d3
.findEmpty:
		move.l	MONSTERMOVETAB(a1),a2	; current ai pointer
		cmpa.l	#0,a2
		beq.s	.FoundEmpty
;		tst.b	AI_TYPE(a2)		; get current type
;		beq.s	.FoundEmpty
		adda.w	#MONSTERLISTSIZE,a1
		dbra	d3,.findEmpty
		move.l	#-1,d0
		bra	.AllDone
.FoundEmpty:
		move.l	a1,-(sp)		; save for later
		move.w	#(MONSTERLISTSIZE/2)-1,d3
.amLoop:
		move.w	(a0)+,(a1)+
		dbra	d3,.amLoop

		move.l	(sp)+,a1

		move.l	MONSTERMOVETAB(a1),a0

		move.b	AI_TYPE(a0),d5		; get new ai type
		and.w	#$7f,d5			; mask to word
		add.w	d5,d5			; for word table
		lea	aiXlatAnims,a5		; get new anim #
		move.w	0(a5,d5.w),d5		; from table
		move.w	d5,MONSTERANIM(a1)	; and set up animation #
		clr.w	MONSTERFRAME(a1)

		or.b	d2,MONSTERFLAGS(a1)
		move.w	_Vcount+2,d0
		add.w	MONSTERCOUNTER(a1),d0
		move.w	d0,MONSTERTCOUNTER(a1)
		clr.w	MONSTERLOOPCNT(a1)
		or.w	#(%10<<8),MONSTERAIFLAGS(a1)
		move.l	a1,d0
.AllDone:
		movem.l	(sp)+,d2-d3/d5/a0-a2/a5
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	killAllMonsters						}
;{ Description:	Come here to kill all monsters 				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
killAllMonsters	Module

		movem.l	d0/a0,-(sp)
		lea	theMonsterLists,a0
		move.w	#MAXNMONSTERS-1,d0
.makeEmpty:
		clr.w	MONSTERANIM(a0)
		clr.l	MONSTERMOVETAB(a0)	; current ai pointer
		adda.w	#MONSTERLISTSIZE,a0
		dbra	d0,.makeEmpty
		movem.l	(sp)+,d0/a0
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	drawMonster						}
;{ Description:	Come here to draw monster 				}
;{ Parameters:	a0 = pointer to monster list structure			}
;{ returns:	.							}
;{----------------------------------------------------------------------}
drawMonster	Module

		movem.l	d0-d6/a0-a2,-(sp)

		lea	scaleVars,a6

		move.l	a0,a2
		and.w	#$7fff,MONSTERFLAGS(a2)
		move.w	MONSTERSCALE(a2),d6
		sub.w	MONSTERINISCALE(a2),d6
		cmp.w	#$a0,d6
		blt.s	.notPriority
		or.w	#CHARPRIORITY,MONSTERFLAGS(a2)
.notPriority:

		btst.b	#8-8,MONSTERAIFLAGS(a2)	; see if static sprite
		beq.s	.nostatic
		move.w	MONSTERSCALE(a2),d0	; get sprite equate
		lea	StatSprNum,a0
		move.w	0(a0,d0.w),d0		; get sprite number in list
		lsl.w	#3,d0			; * 8
		lea	_Work_Sprlist,a0
		add.w	d0,a0
		move.w	MONSTERX(a2),d0
		move.w	MONSTERY(a2),d1
		add.w	#$80,d0
		add.w	#$80,d1
		move.w	d0,SAXPOS(a0)		; just update x & y
		move.w	d1,SAYPOS(a0)
		bra	.alldone		; that's all we need to do

.nostatic:
		move.l	MONSTERFILEPTR(a2),a0	; get pointer to tables
		move.w	MONSTERANIM(a2),d2
		beq	.allDone
		btst.b	#3,MONSTERAIFLAGS+1(a2) ; is monster hidden?
		bne	.allDone		; yep can't draw.
		subq.w	#1,d2
		move.w	MONSTERFRAME(a2),d3
		jsr	_getFrameInfo		; get frame information

		move.w	MONSTERX(a2),d0
		move.w	MONSTERY(a2),d1

		move.l	a1,SrcDataPtr(a6)
		move.w	SAHVLINK(a0),d0		; get width and height

		move.w	MONSTERFLAGS(a2),d2
		and.w	#%1111100000000000,d2
		move.w	d2,fillXQty(a6)
		move.w	d0,d1
		lsr.w	#8,d0
		move.w	d0,SrcXSize(a6)
		move.w	d0,SrcWidth(a6)
		and.w	#$ff,d1
		move.w	d1,SrcYSize(a6)
		move.w	d1,SrcHeight(a6)
		clr.w	SrcXpos(a6)
		clr.w	SrcYpos(a6)

		sf	XFlip(a6)
		btst.b	#5,MONSTERAIFLAGS+1(a2)
		beq.s	.noXFlip
		st	XFlip(a6)
.noXFlip:

		move.w	MONSTERSCALE(a2),d2	; get scale percentage
		lsl.w	#8,d0
		lsl.w	#8,d1
		mulu	d2,d0
		mulu	d2,d1
		swap	d0
		swap	d1
		tst.w	d0
		beq	.allDone
		tst.w	d1
		beq	.allDone
		move.w	d0,DestXSize(a6)
		move.w	d1,DestYSize(a6)
		add.w	#7,d0
		lsr.w	#3,d0
		move.w	d0,DestWidth(a6)
		add.w	#7,d1
		lsr.w	#3,d1
		move.w	d1,DestHeight(a6)
		mulu	d1,d0
		move.w	d0,d6			; number of characteers
		add.w	_SYS_scaledChar,d0
		cmp.w	_SYS_endsprite2,d0
		bge	.alldone		; clipped out of sprites
		move.w	#2,FillAction(a6)
		move.w	#1,OutputType(a6)
		st	AutoConvert(a6)
		sf	Autosend(a6)
		move.w	_SYS_scaledChar,d0
		lsl.w	#5,d0
		move.w	d0,VRAMAddr(a6)

		move.l	#tSpriteGrid,DestDataPtr(a6)
		
		moveq	#SSC_MAKEGRID,d0
		jsr	SpriteScaler

		move.w	MONSTERX(a2),d0
		move.w	MONSTERY(a2),d1
		bsr	makeZXY
		and.w	#~%1000000,MONSTERAIFLAGS(a2)
.MonsterOk:
		move.w	_SYS_scaledChar,d4
		add.w	d6,_SYS_scaledChar
		lsl.w	#5,d6			; * 32 bytes per character
		lea	scaleBuff1,a1
		adda.w	MonsterBuffOffset,a1
		add.w	d6,MonsterBuffOffset
		move.l	a1,DestDataPtr(a6)
		lea	tSpriteGrid,a0

		jsr	_SendScaledSprite

testScale:	moveq	#SSC_Scale,d0		; do scaling
		jsr	SpriteScaler
.allDone:
		movem.l	(sp)+,d0-d6/a0-a2
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	scalerDMA						}
;{ Description:	come here when scaler wants some dma to be done		}
;{ Parameters:	d0 - Address in VRAM					}
;{		d2 - Size of DMA (even number of bytes)			}
;{		d3 - Address in 68K memory				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
scalerDMA	Module


		modEnd

;{----------------------------------------------------------------------}
;{ Function:	makeZXY							}
;{ Description:	make new x,y position based on scale factor		}
;{ Parameters:	d0 = current x position					}
;{ 		d1 = current y position					}
;{		d2 = scale factor					}
;{		a0 = pointer to frame animation	info			}
;{		a2 = pointer to monster structure			}
;{ Returns:	d0 = new x position					}
;{ 		d1 = new y position					}
;{----------------------------------------------------------------------}
makeZXY		Module

		movem.l	d2-d5/a0,-(sp)

		move.w	SAXPOS(a0),d3
		btst.b	#5,MONSTERAIFLAGS+1(a2)
		beq.s	.noXFlip
		move.w	SAHVLINK(a0),d4		; get width
		lsr.w	#8,d4
		add.w	d4,d3			; width+xoffset
		neg.w	d3			; -(width+xoffset)
.noXFlip:		
		move.w	SAYPOS(a0),d4
		ext.l	d3
		move.l	d3,d5
		swap	d5
		eor.w	d5,d3
		sub.w	d5,d3
		lsl.w	#8,d3
		mulu	d2,d3
		swap	d3
		add.w	d5,d3
		eor.w	d5,d3
		ext.l	d4
		move.l	d4,d5
		swap	d5
		eor.w	d5,d4
		sub.w	d5,d4
		lsl.w	#8,d4
		mulu	d2,d4
		swap	d4
		add.w	d5,d4
		eor.w	d5,d4
		add.w	d4,d1
		add.w	d3,d0

		tst.w	d2
		beq.s	.MZXYExit
		sub.w	MONSTERINISCALE(a2),d2
		cmp.w	#$280,d2
		ble.s	.InRange
		move.w	#$280,d2
.InRange:
		lea	zlate,a0
		add.w	d2,d2
		add.w	0(a0,d2.w),d1
.MZXYExit:
		movem.l	(sp)+,d2-d5/a0

		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	shootEnemy						}
;{ Description:	Come here for shots fired at enemies			}
;{ Parameters:	d0 = x position of crosshair				}
;{		d1 = y position of crosshair				}
;{ returns:	.							}
;{----------------------------------------------------------------------}
shootEnemy	module

		movem.l	d0-d7/a0-a3,-(sp)

		jsr	use1Bullet		; use a bullet.

		move.w	nMonsterLists,d6
		beq	.allDone
		subq.w	#1,d6
		lea	monsterListPtrs,a3
.checkLoop1:
		move.l	(a3)+,a2
		move.w	MONSTERANIM(a2),d2
		beq	.nextMonster1
		btst.b	#7,MONSTERAIFLAGS+1(a2)
		bne	.nextMonster1
		subq	#1,d2
		move.l	MONSTERFILEPTR(a2),a0
		move.w	MONSTERFRAME(a2),d3
		movem.l	d0-d1,-(sp)
		jsr	_getFrameInfo

		move.w	MONSTERX(a2),d0
		move.w	MONSTERY(a2),d1

		btst.b	#8-8,MONSTERAIFLAGS(a2)	; see if static sprite
		beq.s	.notstatic1

		jsr	getStatWH
		move.w	d2,d4
		move.w	d3,d5
		bra.s	.isStatic1
.notStatic1:
		move.w	MONSTERSCALE(a2),d7
		move.w	SAHVLINK(a0),d4		; get width and height
		move.w	d4,d5
		lsr.w	#8,d4
		and.w	#$ff,d5

		move.w	MONSTERSCALE(a2),d2
		bsr	makeZXY	

		lsl.w	#8,d4
		lsl.w	#8,d5
		mulu	d7,d4
		mulu	d7,d5
		swap	d4
		swap	d5
.isStatic1:
		move.w	d0,d2
		move.w	d1,d3
		movem.l	(sp)+,d0-d1

		move.l	d0,-(sp)
		jsr	_ptInRect
		move.w	d0,d5
		move.l	(sp)+,d0
		tst.w	d5
		beq.s	.nextMonster1
		btst.b	#2,MONSTERAIFLAGS+1(a2)	
		bne.s	.nextMonster1		; can't hit this one

		move.l	MONSTERHITTAB(a2),d0	; goto getting hit
		move.l	MONSTERMOVETAB(a2),d1
		move.l	d0,MONSTERMOVETAB(a2)
		move.l	d1,MONSTERHITTAB(a2)

;		move.l	d1,a1			; update table entry
;		move.b	AI_TYPE(a1),d0		; get new ai type
;		and.w	#$7f,d0			; mask to word
;		add.w	d0,d0			; for word table
;		lea	aiXlatAnims,a1		; get new anim #
;		move.w	0(a1,d0.w),d0		; from table
;		move.w	d0,MONSTERANIM(a2)	; and set up animation #
;		clr.w	MONSTERTCOUNTER(a2)
		bra	.allDone
.nextMonster1:
		dbra	d6,.checkLoop1

		move.w	nMonsterLists,d6
		subq.w	#1,d6
		lea	monsterListPtrs,a3
.checkLoop:
		move.l	(a3)+,a2
		move.w	MONSTERANIM(a2),d2
		beq	.nextMonster
		btst.b	#7,MONSTERAIFLAGS+1(a2)
		bne	.nextMonster
		subq	#1,d2
		move.l	MONSTERFILEPTR(a2),a0
		move.w	MONSTERFRAME(a2),d3
		move.l	d0,-(sp)
		jsr	_getFrameInfo
		move.l	(sp)+,d0
		btst.b	#8-8,MONSTERAIFLAGS(a2)
		beq.s	.notStatic2
		jsr	getStatWH
		move.w	d2,d4
		move.w	d3,d5
		bra.s	.isStatic2
.notStatic2:
		move.w	SAHVLINK(a0),d4		; get width and height
		move.w	d4,d5
		lsr.w	#8,d4
		and.w	#$ff,d5
		move.w	MONSTERSCALE(a2),d7

		move.w	d4,d2
		move.w	d5,d3			; save source for later
		lsl.w	#8,d4
		lsl.w	#8,d5
		mulu	d7,d4
		mulu	d7,d5
		swap	d4
		swap	d5

.isStatic2:
		sub.w	d4,d2
		sub.w	d5,d3
		asr.w	#1,d2
		asr.w	#1,d3
		move.w	MONSTERAIFLAGS(a2),d7	; get ai/draw flags
		btst	#0,d7
		beq.s	.isCenteredX
		clr.w	d2
.isCenteredX:
		btst	#1,d7
		beq.s	.isCenteredY
		clr.w	d3
.isCenteredY:
		add.w	MONSTERX(a2),d2
		add.w	SAXPOS(a0),d2
		add.w	MONSTERY(a2),d3
		add.w	SAYPOS(a0),d3
		move.l	d0,-(sp)
		jsr	_ptInRect
		move.w	d0,d5
		move.l	(sp)+,d0
		tst.w	d5
		beq.s	.nextMonster
		btst.b	#2,MONSTERAIFLAGS+1(a2)	
		bne.s	.nextMonster		; can't hit this one

		move.l	MONSTERHITTAB(a2),d0	; goto getting hit
		move.l	MONSTERMOVETAB(a2),d1
		move.l	d0,MONSTERMOVETAB(a2)
		move.l	d1,MONSTERHITTAB(a2)

		move.l	d1,a1			; update table entry
		move.b	AI_TYPE(a1),d0		; get new ai type
		and.w	#$7f,d0			; mask to word
		add.w	d0,d0			; for word table
		lea	aiXlatAnims,a1		; get new anim #
		move.w	0(a1,d0.w),d0		; from table
		move.w	d0,MONSTERANIM(a2)	; and set up animation #
		clr.w	MONSTERTCOUNTER(a2)
		bra.s	.allDone
.nextMonster:
		dbra	d6,.checkLoop
.allDone:
		movem.l	(sp)+,d0-d7/a0-a3
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	addNumSprites						}
;{ Description:	add in number of sprites for this section to be 	}
;{		killed off before advancing				}
;{ Parameters:	a2 = wall pointer info					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
addNumSprites	Module

		movem.l	d0/a0,-(sp)
		move.l	SPRITELISTPTR(a2),a0
		move.w	(a0)+,d0
		add.w	d0,monstersToKill
		movem.l	(sp)+,d0/a0
		rts

		ModEnd
;{----------------------------------------------------------------------}
;{ Function:	aiWaitRtn						}
;{ Description:	Come here when monster is in list but is waiting	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{		d0 = -1 if first time through				}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiWaitRtn	Module

		movem.l	d1-d3/a0-a2,-(sp)

		btst.b	#(9-8),MONSTERAIFLAGS(a0)
		beq.s	.notFirstTime
		and.w	#~(%10<<8),MONSTERAIFLAGS(a0)
		move.w	AIWAIT_LENGTH(a1),d1
		move.w	d1,MONSTERCOUNTER(a0)
		add.w	_Vcount+2,d1
		move.w	d1,MONSTERTCOUNTER(a0)
.notFirstTime:
		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiWaitSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there
aiWaitStaticSub:
		clr.w	d0			; assume no update of ai list
		move.w	#1,MONSTERANIM(a0)
		clr.w	MONSTERFRAME(a0)	; set first frame 
		move.w	_Vcount+2,d1
		cmp.w	MONSTERTCOUNTER(a0),d1	; see if time to update
		bls	.aiWaitExit		; nope
		add.w	MONSTERCOUNTER(a0),d1
		move.w	d1,MONSTERTCOUNTER(a0)	; reset counter
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit		; and exit
aiWaitAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		move.w	d0,MONSTERFRAME(a0)	; save new frame
		clr.w	d0
		move.w	_Vcount+2,d1		; get current vcount
		cmp.w	MONSTERTCOUNTER(a0),d1	; and see if time to update
		bls	.aiWaitExit		; nope
		add.w	MONSTERCOUNTER(a0),d1
		move.w	d1,MONSTERTCOUNTER(a0)	; reset counter
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit		; and exit

aiWaitHiddenSub:
		clr.w	d0			; assume no update of ai list
		clr.w	MONSTERANIM(a0)		; no animation yet
		clr.w	MONSTERFRAME(a0)	; set first frame 
		move.w	_Vcount+2,d1
		cmp.w	MONSTERTCOUNTER(a0),d1	; see if time to update
		bls	.aiWaitExit		; nope
		add.w	MONSTERCOUNTER(a0),d1
		move.w	d1,MONSTERTCOUNTER(a0)	; reset counter
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit		; and exit
aiWaitTillClearSub:
		clr.w	d0			; assume no update of ai list
		clr.w	MONSTERANIM(a0)		; no animation yet
		clr.w	MONSTERFRAME(a0)	; set first frame
		tst.w	monstersToKill
		bne	.aiWaitExit
		move.w	_Vcount+2,d1
		add.w	MONSTERCOUNTER(a0),d1
		move.w	d1,MONSTERTCOUNTER(a0)	; reset counter
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit		; and exit
aiWaitForNumSub:
		clr.w	d0			; assume no update of ai list
		clr.w	MONSTERANIM(a0)		; no animation yet
		clr.w	MONSTERFRAME(a0)	; set first frame
		move.w	AIWAIT_LENGTH(a1),d1
		cmp.w	monsterstoKill,d1
		bne	.aiWaitExit
		move.w	_Vcount+2,d1
		add.w	MONSTERCOUNTER(a0),d1
		move.w	d1,MONSTERTCOUNTER(a0)	; reset counter
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit
aiWaitExpose:
		or.w	#%100,MONSTERAIFLAGS(a0) ; can't hit this one again
		and.w	#~%1000,MONSTERAIFLAGS(a0)	; expose
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		move.w	d0,MONSTERFRAME(a0)	; save new frame
		clr.w	d0
		cmp.w	#-1,d1			; still animating?
		bne.s	.aiWaitExit
		move.l	AIWAIT_LENGTH(a1),d0
		move.l	d0,MONSTERFILEPTR(a0)
		move.l	MONSTERHITTAB(a0),d0	; goto getting hit
		sub.l	#AI_PARMS_SIZE,d0	; so will update anim #
		move.l	MONSTERMOVETAB(a0),d1
		move.l	d0,MONSTERMOVETAB(a0)	; swap back routines
		add.l	#AI_PARMS_SIZE,d1	; don't expose again
		move.l	d1,MONSTERHITTAB(a0)
		and.w	#~%100,MONSTERAIFLAGS(a0)	; hit this one again
		or.w	#(%10<<8),MONSTERAIFLAGS(a0)
		move.w	#-1,d0
		bra.s	.aiWaitExit

aiWaitStoppedSub:
		clr.w	d0			; assume no update of ai list
		clr.w	MONSTERANIM(a0)		; no animation yet
		clr.w	MONSTERFRAME(a0)	; set first frame 
		tst.w	curMovement
		bgt.s	.aiWaitExit
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit
aiWaitCount:
		clr.w	d0			; assume no update of ai list
		clr.w	MONSTERANIM(a0)		; no animation yet
		clr.w	MONSTERFRAME(a0)	; set first frame 
		add.w	#1,MONSTERTCOUNTER(a0)
		move.w	MONSTERTCOUNTER(a0),d1
		cmp.w	AIWAIT_LENGTH(a1),d1	; see if time to update
		bls	.aiWaitExit		; nope
		move.w	#-1,d0			; return to update ai list ptr
		bra	.aiWaitExit		; and exit
.aiWaitExit:
		movem.l	(sp)+,d1-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiMoveForwardRtn					}
;{ Description:	Come here when monster is in list to move forward	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiMoveForwardRtn Module

		movem.l	d1-d3/a0-a2,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiMoveFSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiMoveFStaticSub:
		clr.w	d0
		move.w	AIMF_SCALEADD(a1),d1
		add.w	MONSTERSCALE(a0),d1
		move.w	d1,MONSTERSCALE(a0)
		cmp.w	#-1,AIMF_TOSCALE(a1)
		beq.s	.aimoveFUpdate
		cmp.w	AIMF_TOSCALE(a1),d1
		blo.s	.aiMoveFExit
		move.w	AIMF_TOSCALE(a1),d1
		move.w	d1,MONSTERSCALE(a0)
.aimoveFUpdate:
		move.w	#-1,d0
		bra.s	.aiMoveFExit
aiMoveFAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		cmp.w	#-1,d1
		bne.s	.saveFrame
		btst.b	#11-8,MONSTERAIFLAGS(a0)
		bne.s	.onlytoEnd
.saveFrame:
		move.w	d0,MONSTERFRAME(a0)	; save new frame
.onlytoEnd:
		clr.w	d0
		move.w	AIMF_SCALEADD(a1),d1
		add.w	MONSTERSCALE(a0),d1
		move.w	d1,MONSTERSCALE(a0)
		cmp.w	#-1,AIMF_TOSCALE(a1)
		beq.s	.aimoveFUpdate2
		cmp.w	AIMF_TOSCALE(a1),d1
		blo.s	.aiMoveFExit
		move.w	AIMF_TOSCALE(a1),d1
		move.w	d1,MONSTERSCALE(a0)
.aimoveFUpdate2:
		move.w	#-1,d0
		bra	.aiMoveFExit
.aiMoveFExit:
		movem.l	(sp)+,d1-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiAttackRtn						}
;{ Description:	Come here when monster is in list to attack		}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiAttackRtn	Module

		movem.l	d1-d3/a0-a2,-(sp)

		move.w	#-1,d3
		btst.b	#9-8,MONSTERAIFLAGS(a0)
		beq.s	.notFirstTime
		and.w	#~(%10<<8),MONSTERAIFLAGS(a0)
		cmp.w	#-1,AIAT_LOOPS(a1)	; see if want time or counter
		bne.s	.notFirstTime		; might want time
		move.w	AIAT_TIME(a1),d1	; then set up time start
		move.w	d1,MONSTERCOUNTER(a0)
		add.w	_Vcount+2,d1
		move.w	d1,MONSTERTCOUNTER(a0)	; in counter
		move.w	#-2,d3
.notFirstTime:
		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiAttSubRtns,a2		; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there
aiAttAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		move.w	d0,MONSTERFRAME(a0)	; save new frame
		cmp.w	#-1,AIAT_LOOPS(a1)
		bne.s	.noTiming
	  	move.w	_VCount+2,d2
		clr.w	d0
		cmp.w	MONSTERTCOUNTER(a0),d2	; see if time to update
		bls	.aiAttExit		; nope
		bra.s	aiAttStaticSub
.noTiming:
		clr.w	d0
		cmp.w	#-1,d1			; still animating?
		bne.s	.aiAttExit
aiAttStaticSub:
		move.w	AIAT_DAMAGE(a1),d0
		beq.s	.noDamage
		jsr	DecHealth
		sf	VDPAccess
		move.l	#redOutPal,lastPals
		move.l	#redOutPal,lastPals+4
		move.l	#redOutPal,lastPals+8	; flash red for hit
		move.b	#1,FlashPals
		move.b	#1,FlashPals+1
		move.b	#1,FlashPals+2
		st	VDPAccess

		clr.w	d0
.noDamage:
		cmp.w	#-1,AIAT_LOOPS(a1)
		bne.s	.maybeLoops
		move.w	d3,d0
		bra.s	.aiAttExit
.maybeLoops:
		add.w	#1,MONSTERTCOUNTER(a0)	; update counter
		move.w	MONSTERTCOUNTER(a0),d1
		cmp.w	AIAT_LOOPS(a1),d1
		blt.s	.aiAttExit
		move.w	d3,d0
.aiAttExit:
		movem.l	(sp)+,d1-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiDieRtn						}
;{ Description:	Come here when monster is in list to die		}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiDieRtn	Module

		movem.l	d1-d3/a0-a3,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiDieSubRtns,a2		; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiDieLoseHPSub:
		move.l	a0,a3
		lea	tempSprList,a2
		move.w	#(MONSTERLISTSIZE/2)-1,d0
.CopyLoop:
		move.w	(a3)+,(a2)+
		dbra	d0,.CopyLoop

		lea	tempSprList,a2
		clr.w	MONSTERFRAME(a2)
		move.w	#1,MONSTERANIM(a2)
		move.l	#explosAITable,MONSTERMOVETAB(a2)
		move.l	#explosivFile,MONSTERFILEPTR(a2)
		move.w	crosshairX,MONSTERX(a2)
		move.w	crosshairY,d0
		add.w	#8,d0
		move.w	d0,MONSTERY(a2)
		move.w	MONSTERSCALE(a2),d2
		move.w	d2,MONSTERSCALE(a2)
		move.w	d2,MONSTERINISCALE(a2)

		or.w	#%10000100,MONSTERAIFLAGS(a2)	; can't hit this one

		lea	0,a2
		move.l	a0,a3
		lea	tempSprList,a0
		bsr	addMonster		; actually explosion

		move.l	a3,a0
		or.w	#%100,MONSTERAIFLAGS(a0)	; can't hit this one again
		move.w	#-1,d0
		move.w	AIDI_HPSUB(a1),d1
		sub.w	d1,MONSTERHP(a0)	; update monster's hitpoints
		ble	.aiDieExit		; he's dead jim
		and.w	#~%100,MONSTERAIFLAGS(a0)	; can hit this one
		move.l	MONSTERHITTAB(a0),d0	; goto getting hit
		sub.l	#AI_PARMS_SIZE,d0	; so will update anim #
		move.l	MONSTERMOVETAB(a0),d1
		move.l	d0,MONSTERMOVETAB(a0)	; swap back routines
		move.l	d1,MONSTERHITTAB(a0)
		clr.w	MONSTERTCOUNTER(a0)	; but do clear monster tcounter
		move.w	#-2,d0			; don't clear frame #
		bra	.aiDieExit
aiDieAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		move.w	d0,MONSTERFRAME(a0)	; save new frame
		clr.w	d0
		cmp.w	#-1,d1			; still animating?
		bne	.aiDieExit
		add.w	#1,MONSTERTCOUNTER(a0)	; update counter
		move.w	MONSTERTCOUNTER(a0),d1
		cmp.w	AIDI_HPSUB(a1),d1	; counter
		blt	.aiDieExit
		move.l	AIDI_SCORE(a1),d0
		jsr	addScore
		move.w	#-1,d0
		btst.b	#6,MONSTERAIFLAGS+1(a0)	; goody?
		bne	.aiDieExit		; then not monster
		tst.w	monstersToKill
		beq	.aiDieExit
		sub.w	#1,monstersToKill	; monster got kilt
		bne	.aiDieExit
		clr.w	EndFinished
		bra	.aiDieExit
aiDieRetreat:
		move.l	a0,a3
		lea	tempSprList,a2
		move.w	#(MONSTERLISTSIZE/2)-1,d0
.CopyLoop2:
		move.w	(a3)+,(a2)+
		dbra	d0,.CopyLoop2

		lea	tempSprList,a2
		clr.w	MONSTERFRAME(a2)
		move.w	#1,MONSTERANIM(a2)
		move.l	#explosAITable,MONSTERMOVETAB(a2)
		move.l	#explosivFile,MONSTERFILEPTR(a2)
		move.w	crosshairX,MONSTERX(a2)
		move.w	crosshairY,d0
		add.w	#8,d0
		move.w	d0,MONSTERY(a2)

		or.w	#%10000100,MONSTERAIFLAGS(a2)	; can't hit this one

		lea	0,a2
		move.l	a0,a3
		lea	tempSprList,a0
		bsr	addMonster		; actually explosion

		move.l	a3,a0
		or.w	#%100,MONSTERAIFLAGS(a0)	; can't hit this one
		move.w	#-1,d0
		move.w	AIDI_HPSUB(a1),d1
		sub.w	d1,MONSTERHP(a0)	; update monster's hitpoints
		ble	.aiDieExit		; he's dead jim
		and.w	#~%100,MONSTERAIFLAGS(a0)	; can hit this one
		move.l	MONSTERHITTAB(a0),d0	; goto getting hit
		move.l	MONSTERMOVETAB(a0),d1	; and get old hit table
		move.l	AIDI_SCORE(a1),a2	; get pointer to retreat table
		move.w	(a2)+,d3
		subq.w	#1,d3
.boundLoop:
		move.l	AIRT_LOWBOUND(a2),d2	; get lower bound
		cmp.l	d2,d0			; see if current < lower bound
		blt.s	.dontRetreat		; yep so dont retreat
	     	move.l	AIRT_HIGHBOUND(a2),d2	; now get upper bound
		cmp.l	d2,d0			; current > upper bound
		bge.s	.dontRetreat		; yep then don't retreat
		move.l	AIRT_GOTO(a2),d2	; else get retreat entry point
		move.w	#-2,d0			; don't clear frame #
		bra.s	.foundBoundary
.dontRetreat:
		adda.w	#AIRT_SIZE,a2
		dbra	d3,.boundLoop
		move.l	d0,d2
.foundBoundary:
		sub.l	#AI_PARMS_SIZE,d2	; so will update anim #
		move.l	d2,MONSTERMOVETAB(a0)	; swap back routines
		move.l	d1,MONSTERHITTAB(a0)
		move.w	#-2,d0			; don't clear frame
		bra	.aiDieExit
aiDieAddPlayerHP:
		tst.w	MONSTERLOOPCNT(a0)	; see if first time through loop
		bne.s	.notFirstTime1		; nope
		move.w	AIDI_SCORE(a1),d0	; else get initial value
		move.w	d0,MONSTERLOOPCNT(a0)
.notFirstTime1:
		or.w	#%100,MONSTERAIFLAGS(a0)	; can't hit this one
		move.w	AIDI_HPSUB(a1),d0
		jsr	IncHealth		; add health to player
		move.w	#-1,d0
		sub.w	#1,MONSTERLOOPCNT(a0)
		beq.s	.aiDieExit
		and.w	#~%100,MONSTERAIFLAGS(a0)	; can hit this one
		move.l	MONSTERHITTAB(a0),d0	; goto getting hit
		sub.l	#AI_PARMS_SIZE,d0	; so will update anim #
		move.l	MONSTERMOVETAB(a0),d1
		move.l	d0,MONSTERMOVETAB(a0)	; swap back routines
		move.l	d1,MONSTERHITTAB(a0)
		move.w	#-2,d0			; don't clear frame #
		bra	.aiDieExit
aiDieAddAmmo:
		tst.w	MONSTERLOOPCNT(a0)	; see if first time through loop
		bne.s	.notFirstTime2		; nope
		move.w	AIDI_SCORE(a1),d0	; else get initial value
		move.w	d0,MONSTERLOOPCNT(a0)
.notFirstTime2:
		or.w	#%100,MONSTERAIFLAGS(a0)	; can't hit this one
		move.w	AIDI_HPSUB(a1),d0
		jsr	AddClips		; add health to player
		move.w	#-1,d0
		sub.w	#1,MONSTERLOOPCNT(a0)
		beq.s	.aiDieExit
		and.w	#~%100,MONSTERAIFLAGS(a0)	; can hit this one
		move.l	MONSTERHITTAB(a0),d0	; goto getting hit
		sub.l	#AI_PARMS_SIZE,d0	; so will update anim #
		move.l	MONSTERMOVETAB(a0),d1
		move.l	d0,MONSTERMOVETAB(a0)	; swap back routines
		move.l	d1,MONSTERHITTAB(a0)
		move.w	#-2,d0			; don't clear frame #
.aiDieExit:
		movem.l	(sp)+,d1-d3/a0-a3
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiGotoRtn						}
;{ Description:	Come here when monster is in list to goto ai		}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiGotoRtn	Module

		move.l	AIGO_PTR(a1),d0
		sub.l	#AI_PARMS_SIZE,d0
		move.l	d0,MONSTERMOVETAB(a0)	; goto next ai table entry
		move.w	#-1,d0

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiLoopRtn						}
;{ Description:	Come here when monster is in list to loop ai		}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiLoopRtn	Module

		movem.l	d1-d3/a0-a3,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiLoopSubRtns,a2 	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiLoopStart:
		move.w	AILP_CNT(a1),d0
		move.w	d0,MONSTERLOOPCNT(a0)	; set up loop counter
		move.w	#-2,d0			; don't clear frames
		bra.s	aiLoopExit

aiLoopEnd:
		move.l	AILP_PTR(a1),d1
		sub.w	#1,MONSTERLOOPCNT(a0)
		bne.s	.LoopExit
		move.w	#-2,d0
		bra	aiLoopExit
.LoopExit:
		move.l	d1,MONSTERMOVETAB(a0)	; goto next ai table entry
		clr.w	d0
aiLoopExit:
		movem.l	(sp)+,d1-d3/a0-a3
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	aiStaticRtn						}
;{ Description:	Come here when monster is in list is static		}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiStaticRtn	Module

		movem.l	d1-d3/a0-a2,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiStatSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there
aiStatAnimSub:
		cmp.w	#-1,AIST_TOFRAME(a1)
		beq.s	.infiniteFrame
		move.w	AIST_ATSCALE(a1),d2
		move.w	d2,MONSTERSCALE(a0)
.infiniteFrame:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		cmp.w	AIST_TOFRAME(a1),d0
		bne.s	.notEnd
		clr.w	d0
		move.w	#-1,d1
.notEnd:
		move.w	d0,MONSTERFRAME(a0)	; save new frame
		clr.w	d0
		cmp.w	#-1,d1			; still animating?
		bne.s	.aiStatExit
		move.w	#-1,d0
		bra.s	.aiStatExit
aiStatFixAnimSub:
aiStatFixStatSub:
		clr.w	d1
		move.w	curXPos,d0
		sub.w	oldXPos,d0
		cmp.w	#FORWARD,wallDirection	; going forward
		bne.s	.notForward
		nop
.notForward:
		sub.w	d0,MONSTERX(a0)
		sub.w	d1,MONSTERY(a0)
		cmp.w	#-64,MONSTERX(a0)
		bge	.notOutOfRange
		clr.l	MONSTERMOVETAB(a0)
		clr.w	MONSTERANIM(a0)
.notOutOfRange:
		move.w	#-1,d0
		bra	.aiStatExit
aiStatWaitNumSub:
		and.w	#~%100,MONSTERAIFLAGS(a0)
		move.w	#-1,d0
		move.w	AIWAIT_LENGTH(a1),d1
		cmp.w	monsterstoKill,d1
		beq	.aiStatExit
		or.w	#%100,MONSTERAIFLAGS(a0)
aiStatStatSub:
		clr.w	d0
.aiStatExit:
		movem.l	(sp)+,d1-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aimoveBackRtn						}
;{ Description:	Come here when monster is in list to move forward	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aimoveBackRtn 	Module

		movem.l	d1-d3/a0-a2,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiMoveBSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiMoveBStaticSub:
		clr.w	d0
		move.w	AIMF_SCALEADD(a1),d1
		neg.w	d1
		add.w	MONSTERSCALE(a0),d1
		move.w	d1,MONSTERSCALE(a0)
		cmp.w	AIMF_TOSCALE(a1),d1
		bhi.s	.aiMoveBExit
		move.w	AIMF_TOSCALE(a1),d1
		move.w	d1,MONSTERSCALE(a0)
		move.w	#-1,d0
		bra.s	.aiMoveBExit
aiMoveBAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		cmp.w	#-1,d1
		bne.s	.saveFrame
		btst.b	#11-8,MONSTERAIFLAGS(a0)
		bne.s	.onlytoEnd
.saveFrame:
		move.w	d0,MONSTERFRAME(a0)	; save new frame
.onlytoEnd:
		clr.w	d0
		move.w	AIMF_SCALEADD(a1),d1
		neg.w	d1
		add.w	MONSTERSCALE(a0),d1
		move.w	d1,MONSTERSCALE(a0)
		cmp.w	AIMF_TOSCALE(a1),d1
		bhi.s	.aiMoveBExit
		move.w	AIMF_TOSCALE(a1),d1
		move.w	d1,MONSTERSCALE(a0)
		move.w	#-1,d0
		bra	.aiMoveBExit
.aiMoveBExit:
		movem.l	(sp)+,d1-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aimoveRELRtn						}
;{ Description:	Come here when monster is in list to move relative	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiMoveRelRtn	Module

		movem.l	d1-d4/a0-a2,-(sp)

		move.w	#-1,d3
		btst.b	#9,MONSTERAIFLAGS(a0)
		beq.s	.notFirstTime
		and.w	#~(%10<<8),MONSTERAIFLAGS(a0)
		move.w	AIMA_SPEED(a1),d1
		move.w	d1,MONSTERTCOUNTER(a0)
		move.w	#-2,d3
.notFirstTime:
		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiMoveRELSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there
aiMoveRELAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		cmp.w	#-1,d1
		bne.s	.saveFrame
		btst.b	#11-8,MONSTERAIFLAGS(a0)
		bne.s	.onlytoEnd
.saveFrame:
		move.w	d0,MONSTERFRAME(a0)	; save new frame
.onlytoEnd:
aiMoveRELStaticSub:
		or.w	#%00100000,MONSTERAIFLAGS(a0)
		move.w	AIMA_XPOS(a1),d1
		add.w	d1,MONSTERX(a0)		; see if move left or right
		tst.w	d1
		bge.s	.isRight
		and.w	#~%00100000,MONSTERAIFLAGS(a0)
.isRight:
		move.w	AIMA_YPOS(a1),d1
		add.w	d1,MONSTERY(a0)
		clr.w	d0			; say not done yet
		sub.w	#1,MONSTERTCOUNTER(a0)
		bne.s	.aiMoveRelExit
		move.w	d3,d0			; don't clear frames
.aiMoveRELExit:

		movem.l	(sp)+,d1-d4/a0-a2
		rts


		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aimoveABSRtn						}
;{ Description:	Come here when monster is in list to move absolute	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiMoveABSRtn	Module

		movem.l	d1-d4/a0-a2,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiMoveABSSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiMoveABSAnimSub:
		movem.l	a0-a1,-(sp)
		move.w	MONSTERANIM(a0),d1	; get monster animation
		subq.w	#1,d1
		move.w	MONSTERFRAME(a0),d0	; and monster current frame
		move.l	MONSTERFILEPTR(a0),a0	; pointer to tables
		jsr	_updateFrame		; get new frame if possible
		movem.l	(sp)+,a0-a1
		cmp.w	#-1,d1
		bne.s	.saveFrame
		btst.b	#11-8,MONSTERAIFLAGS(a0)
		bne.s	aiMoveABSStaticSub
.saveFrame:
		move.w	d0,MONSTERFRAME(a0)	; save new frame
aiMoveABSStaticSub:
		clr.w	d4
		move.w	AIMA_XPOS(a1),d1
		cmp.w	#-1,d1
		beq.s	.NoUpdateX1
		move.w	AIMA_SPEED(a1),d0	; get pixels to move
		cmp.w	MONSTERX(a0),d1		; see if move left or right
		bge.s	.moveRight
		or.w	#%00100000,MONSTERAIFLAGS(a0)
		sub.w	d0,MONSTERX(a0)
		cmp.w	MONSTERX(a0),d1
		blt	.NoUpdateX1
		move.w	d1,MONSTERX(a0)		; kill any overrun
		move.w	#-1,d4
		bra	.noUpdateX1
.moveRight:
		and.w	#~%00100000,MONSTERAIFLAGS(a0)
		add.w	d0,MONSTERX(a0)
		cmp.w	MONSTERX(a0),d1
		bgt	.NoUpdateX1
		move.w	d1,MONSTERX(a0)		; kill any overrun
		move.w	#-1,d4
		bra	.NoUpdateX1
.NoUpdateX1:
		move.w	AIMA_YPOS(a1),d1
		cmp.w	#-1,d1
		beq.s	.NoUpdateY1
		move.w	AIMA_SPEED(a1),d0	; get pixels to move
		cmp.w	MONSTERY(a0),d1		; see if move left or right
		bge.s	.moveDown
		sub.w	d0,MONSTERY(a0)
		cmp.w	MONSTERY(a0),d1
		blt	.NoUpdateY1
		move.w	d1,MONSTERY(a0)		; kill any overrun
		move.w	#-1,d4
		bra	.noUpdateY1
.moveDown:
		add.w	d0,MONSTERY(a0)
		cmp.w	MONSTERY(a0),d1
		bgt	.NoUpdateY1
		move.w	d1,MONSTERY(a0)		; kill any overrun
		move.w	#-1,d4
		bra	.NoUpdateY1
.NoUpdateY1:
		move.w	d4,d0
.aiMoveABSExit:

		movem.l	(sp)+,d1-d4/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aisummonRtn						}
;{ Description:	Come here when monster is in list summon other monsters	}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiSummonRtn	Module

		movem.l	d1-d4/a0-a4,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiSummonSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there
aiSumAddSubRtn:
		move.l	AISU_LISTPTR(a1),a3
		move.w	(a3)+,d3		; get # entries
		beq	.AllDone
		add.w	d3,monstersToKill
		subq.w	#1,d3
.AddLoop:
		move.l	(a3)+,a0
		lea	0,a2
		bsr	AddMonster		; add into structures
		cmp.l	#-1,d0
		bne.s	.MonsterOk
		sub.w	#1,monstersToKIll
.MonsterOk:
		dbra	d3,.AddLoop
		bra.s	.AllDone

aiSumCallSubRtn:
		move.l	a0,a4
		move.l	AISU_LISTPTR(a1),a3
		move.w	(a3)+,d3		; get # entries
		beq	.AllDone
		subq.w	#1,d3
.AddLoop2:
		move.l	(a3)+,a0
		lea	0,a2
		bsr	AddMonster		; add into structures
		move.l	d0,a2
		cmp.l	#-1,d0			; couldn't add
		beq.s	.AllDone
		dbra	d3,.AddLoop2

		bra.s	.AllDone

aiSumRelativeSubRtn:
		move.l	a0,a4
		move.l	AISU_LISTPTR(a1),a3
		move.w	(a3)+,d3		; get # entries
		beq	.AllDone
		subq.w	#1,d3
.AddLoop3:
		move.l	(a3)+,a0
		lea	0,a2
		bsr	AddMonster		; add into structures
		move.l	d0,a2
		cmp.l	#-1,d0			; couldn't add
		beq.s	.AllDone
		add.w	#1,monstersToKill
		move.w	MONSTERX(a4),d0
		move.w	d0,MONSTERX(a2)
		move.w	MONSTERY(a4),d0
		move.w	d0,MONSTERY(a2)
		move.w	MONSTERSCALE(a4),d0
		move.w	d0,MONSTERSCALE(a2)
		move.w	MONSTERINISCALE(a4),d0
		move.w	d0,MONSTERINISCALE(a2)
		dbra	d3,.AddLoop3
		
.AllDone:
		move.w	#-1,d0
		movem.l	(sp)+,d1-d4/a0-a4
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiSetAnimRtn						}
;{ Description:	Come here to monster animation/frame #			}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiSetAnimRtn	Module

		movem.l	d1-d4/a0-a3,-(sp)

		move.w	AISA_ANIM(a1),d0
		move.w	d0,MONSTERANIM(a0)
		move.w	AISA_FRAME(a1),d0
		move.w	d0,MONSTERFRAME(a0)
		move.w	#-1,d0
		movem.l	(sp)+,d1-d4/a0-a3
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiIfRtn							}
;{ Description:	Come here to check and if statement			}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiIfRtn		Module

		movem.l	d1-d4/a0-a3,-(sp)

		move.w	AIIF_VARNUM(a1),d1
		lea	aiVariables,a3
		move.b	0(a3,d1.w),d1
		cmp.b	AI_SUBTYPE(a1),d1
		bne.s	.noVariableSet
		move.l	AIIF_GOTO(a1),d0
		sub.l	#AI_PARMS_SIZE,d0
		move.l	d0,MONSTERMOVETAB(a0)	; goto next ai table entry
.noVariableSet:
		move.w	#-1,d0			; say update to next ai

		movem.l	(sp)+,d1-d4/a0-a3
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	aiSetStructRtn						}
;{ Description:	Come here to set structure variable			}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiSetStructRtn	Module

		movem.l	d1-d4/a0-a3,-(sp)

		move.b	AI_SUBTYPE(a1),d1	; get sub-ai type
		and.w	#$ff,d1			; mask to word
		add.w	d1,d1
		add.w	d1,d1			; *4 for long words
		lea	aiStructSubRtns,a2	; routines table
		move.l	0(a2,d1.w),a2		; get routine address
		jmp	(a2)			; and go there

aiStructStoreSubRtn:
		move.w	AISS_STRUCTOFF(a1),d0
		move.w	AISS_VALUE(a1),d1
		move.w	d1,0(a0,d0.w)
		bra.s	.Exit
aiStructOrSubRtn:
		move.w	AISS_STRUCTOFF(a1),d0
		move.w	AISS_VALUE(a1),d1
		or.w	d1,0(a0,d0.w)
		bra.s	.Exit
aiStructAndSubRtn:
		move.w	AISS_STRUCTOFF(a1),d0
		move.w	AISS_VALUE(a1),d1
		and.w	d1,0(a0,d0.w)
.Exit:
		move.w	#-1,d0			; say update to next ai
		movem.l	(sp)+,d1-d4/a0-a3
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	aiSetVarRtn						}
;{ Description:	Come here to set variable				}
;{ Parameters:	a0 = pointer to monster list structure			}
;{		a1 = pointer to ai list structure			}
;{ Returns:	d0 = -1 for next ai list structure			}
;{----------------------------------------------------------------------}
aiSetVarRtn	Module

		movem.l	d1-d4/a0-a3,-(sp)

		move.w	AIIF_VARNUM(a1),d2
		lea	aiVariables,a3
		move.b	AI_SUBTYPE(a1),d1
		move.b	d1,0(a3,d2.w)
		move.w	#-1,d0			; say update to next ai

		movem.l	(sp)+,d1-d4/a0-a3
		rts

		ModEnd

aiSpecialRtn:
		move.w	#-1,d0
		rts
aiNullRtn:
		clr.w	d0			; no more updates
		clr.w	MONSTERANIM(a0)		; no more animation
		clr.l	MONSTERMOVETAB(a0)	; no more animation
		btst.b	#2,MONSTERAIFLAGS+1(a0)	; not killable
		bne.s	.aiNullExit
		btst.b	#6,MONSTERAIFLAGS+1(a0)	; goody?
		bne.s	.aiNullExit		; then not monster
		tst.w	monstersToKill
		beq.s	.aiNullExit
		sub.w	#1,monstersToKill	; monster got away
		bne.s	.aiNullExit
		clr.w	EndFinished
.aiNullExit:
		rts

		section	.data

aiRtnPtrs	dc.l	aiNullRtn
		dc.l	aiWaitRtn
		dc.l	aiMoveForwardRtn
		dc.l	aiMoveRelRtn
		dc.l	aiMoveBackRtn
		dc.l	aiMoveABSRtn
		dc.l	aiAttackRtn
		dc.l	aiDieRtn
		dc.l	aiSpecialRtn
		dc.l	aiGotoRtn
		dc.l	aiStaticRtn
		dc.l	aiSummonRtn
		dc.l	aiAttackRtn
		dc.l	aiLoopRtn
		dc.l	aiSetAnimRtn
		dc.l	aiIfRtn
		dc.l	aiSetVarRtn
		dc.l	aiSetStructRtn

aiWaitSubRtns:
		dc.l	aiWaitStaticSub
		dc.l	aiWaitAnimSub
		dc.l	aiWaitHiddenSub
		dc.l	aiWaitTillClearSub
		dc.l	aiWaitForNumSub
		dc.l	aiWaitExpose
		dc.l	aiWaitStoppedSub
		dc.l	aiWaitCount

aiMoveFSubRtns:
		dc.l	aiMoveFStaticSub
		dc.l	aiMoveFAnimSub

aiMoveBSubRtns:
		dc.l	aiMoveBStaticSub
		dc.l	aiMoveBAnimSub

aiMoveABSSubRtns:
		dc.l	aiMoveABSStaticSub
		dc.l	aiMoveABSAnimSub

aiMoveRELSubRtns:
		dc.l	aiMoveRELStaticSub
		dc.l	aiMoveRELAnimSub

aiDieSubRtns:
		dc.l	aiDieAnimSub
		dc.l	aiDieLoseHPSub
		dc.l	aiDieRetreat
		dc.l	aiDieAddPlayerHP
		dc.l	aiDieAddAmmo
aiAttSubRtns:
		dc.l	aiAttStaticSub
		dc.l	aiAttAnimSub

aiStatSubRtns:
		dc.l	aiStatStatSub
		dc.l	aiStatAnimSub
		dc.l	aiStatFixStatSub
		dc.l	aiStatFixAnimSub
		dc.l	aiStatWaitNumSub

aiSummonSubRtns:
		dc.l	aiSumAddSubRtn
		dc.l	aiSumCallSubRtn
		dc.l	aiSumRelativeSubRtn

aiLoopSubRtns:
		dc.l	aiLoopStart
		dc.l	aiLoopEnd


aiStructSubRtns:
		dc.l	aiStructStoreSubRtn
		dc.l	aiStructOrSubRtn
		dc.l	aiStructAndSubRtn

aiXlatAnims	dc.w	0,1,1,5,2,5,3,4,0,0,1,1,6,0,0,0,0


explosAITable:
		dc.b	AI_STATIC, AIST_ANIMATE	; ai type, sub-type
		dc.w	-1			; 1 loop
		dc.b	0,0,0,0			; filler

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0 		; filler

zlate:
		include	zlate.s



		include	globals.i

	 	end

