;{----------------------------------------------------------------------}
;{	AI.S								}
;{	Rainbow Warrior:						}
;{	  artificial Intelligence Module				}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 Futurescape Productions Inc.		}
;{----------------------------------------------------------------------}
	even

	include	macros.i
	include equates.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}

BssGroup	group	Bss
		section	.bss,BssGroup
pdelsx		ds.w	1
pdelsy		ds.w	1
pdelse		ds.w	1
pdeldx		ds.w	1
pdeldy		ds.w	1
pdelde		ds.w	1
destX		ds.w	1
destY		ds.w	1
jmpTablePtr	ds.l	1

enemyCount	ds.w	1
enemyList	ds.b	MAXENEMIES*ENEMYSIZE
RainBowShoots	ds.w	1

;{----------------------------------------------------------------------}
;{	start of data section						}
;{----------------------------------------------------------------------}
		section	.data
JumpAddXTable1:
	      	dc.w	0, 4, 4, 4, 8, 8, 8, 8, 4, 4, 4, 4
jmpTabSize	equ	(*-JumpAddXTable1)/2
JumpAddYTable1:
		dc.w	-4, -8, -16, -20, -8, -4, 0, 4, 8, 20, 16, 8, 4

JumpAddXTable2:
	      	dc.w	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
JumpAddYTable2:
		dc.w	-4, -8, -16, -20, -8, -4, 0, 4, 8, 20, 16, 8, 4

fireBalls	dc.w	5			; number of enemies

		dc.w	137*8, (17*8)-1		; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	$800			; current flags
		dc.l	fireBallFile		; file pointer
		dc.l	moveFireBall		; ai pointer

		dc.w	37*8, (129*8)-1		; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	$800			; current flags
		dc.l	fireBallFile		; file pointer
		dc.l	moveFireBall		; ai pointer

		dc.w	70*8, (121*8)-1		; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	0			; current flags
		dc.l	fireBallFile		; file pointer
		dc.l	moveFireBall		; ai pointer

		dc.w	20*8, (116*8)-1		; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	$800			; current flags
		dc.l	fireBallFile		; file pointer
		dc.l	moveFireBall		; ai pointer

		dc.w	8*8, (161*8)-1		; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	$800			; current flags
		dc.l	fireBallFile		; file pointer
		dc.l	moveFireBall		; ai pointer

RainBowStruct	dc.w	0, 0			; x,y
		dc.w	1			; current movement (anim)
		dc.w	0			; current frame
		dc.w	0			; current counter
		dc.w	$800			; current flags
		dc.l	RainBowFile		; file pointer
		dc.l	moveRainBow		; ai pointer


;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	disablePlayer						}
;{ Description:	disable player after dead				}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
disablePlayer	Module

		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	fadeInPlayer						}
;{ Description:	disable player after dead				}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
FadeInPlayer	Module

		movem.l	d0-d2/a0-a2,-(sp)

		move.l	a0,a2
		move.l	PLRFILEPTR(a2),a0	; get file pointer
		move.w	PLRMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	PLRFRAME(a2),d0		; and current frame #
		jsr	_updateFrame		; update to next frame
		move.w	d0,PLRFRAME(a2)		; put new frame # back
		cmp.w	#-1,d1			; see if wrapped
		bne.s	.keepFading
		move.w	#WAITING,PLRMOVEMENT(a2) ; set as waiting for action	
.keepFading:
		movem.l	(sp)+,d0-d2/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	PlayerWait						}
;{ Description:	Wait for Player interaction to move			}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
PlayerWait	Module

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	WalkPlayer						}
;{ Description:	Walk Player if interaction to move			}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
WalkPlayer	Module

		movem.l	d0-d2/a0-a2,-(sp)
		move.w	#4,d0
		move.w	PLRFLAGS(a0),d1		; get bits of direction
		and.w	#$800,d1
		bne.s	.notRight
		move.w	#-4,d0
.notRight:
		move.w	PLRYPOS(a0),d1
		add.w	PLRXPOS(a0),d0
		bsr	checkPlayerBounds
		tst.w	d2
		bne.s	.updateWalk
		move.w	d0,PLRXPOS(a0)
.updatewalk:
		move.l	a0,a2
		move.l	PLRFILEPTR(a2),a0	; get file pointer
		move.w	PLRMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	PLRFRAME(a2),d0		; and current frame #
		jsr	_updateFrame		; update to next frame
		move.w	d0,PLRFRAME(a2)		; put new frame # back
;		add.w	#1,PLRCOUNTER(a2)
;		cmp.w	#10,PLRCOUNTER(a2)
;		blt.s	.NewMovement
;		move.w	#RUNNING,PLRMOVEMENT(a2)
;		clr.w	PLRFRAME(a2)
;		clr.w	PLRCOUNTER(a2)

.NewMovement:
		movem.l	(sp)+,d0-d2/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	CheckPlayerBounds					}
;{ Description:	Check to see if player is in boundaries of map		}
;{ Parameters:	d0 = x position						}
;{		d1 = y position						}
;{ returns:	d2 = 0 if player in boundaries of map			}
;{----------------------------------------------------------------------}
checkPlayerBounds Module

		movem.l	d6-d7/a0-a1,-(sp)

		clr.w	d2
		cmp.w	maxXpos,d0
		blt.s	.xMaxGood
		move.w	#1,d2			; assume not in map
		move.w	maxXpos,d0
.xMaxGood:
		tst.w	d0
		bpl.s	.xMinGood
		move.w	#1,d2			; assume not in map
		clr.w	d0
.xMinGood:
		cmp.w	maxYpos,d1
		blt.s	.yMaxGood
		move.w	#1,d2			; assume not in map
		move.w	maxYpos,d1
.yMaxGood:
		tst.w	d1
		bpl.s	.yMinGood
		move.w	#1,d2			; assume not in map
		clr.w	d1
.yMinGood:
		tst.w	d2
		bne.s	.noGood
		move.w	d0,d2
		movem.w	d0-d1,-(sp)
		movea.l	curLevelMap,a0
		move.l	#"OBST",d0
		jsr	findIffHeader		; find obstacle map

		move.w	d2,d0
		lsr.w	#3,d1
		lsr.w	#3,d0
		move.w	(a0)+,d7
		rol.w	#8,d7
		adda.w	#2,a0
		movea.l	a0,a1
		move.w	#4-1,d6
.checkLoop:
		sub.w	#1,d1
		movea.l	a1,a0
		move.w	d1,d2
		mulu	d7,d2
		add.l	d2,a0
		move.b	0(a0,d0.w),d2
		and.w	#$0f,d2
		cmp.w	#FLOOROBSTACLE,d2
		beq.s	.noGood1
		cmp.w	#WALLOBSTACLE,d2
		beq.s	.noGood1
		dbra	d6,.checkLoop

		clr.w	d2

.noGood1:
		movem.w	(sp)+,d0-d1
.noGood:
		movem.l	(sp)+,d6-d7/a0-a1
		rts

		ModEnd
		

;{----------------------------------------------------------------------}
;{ Function:	CheckPlayerBounds					}
;{ Description:	Check to see if player is in boundaries of map		}
;{ Parameters:	d0 = x position						}
;{		d1 = y position						}
;{ returns:	d2 = 0 if player in boundaries of map			}
;{----------------------------------------------------------------------}
checkChar 	Module

		movem.l	d6-d7/a0-a1,-(sp)

		move.w	d0,d2
		movem.w	d0-d1,-(sp)
		movea.l	curLevelMap,a0
		move.l	#"OBST",d0
		jsr	findIffHeader		; find obstacle map

		move.w	d2,d0
		lsr.w	#3,d1
		lsr.w	#3,d0
		move.w	(a0)+,d7
		rol.w	#8,d7
		adda.w	#2,a0
		movea.l	a0,a1
.checkLoop:
		sub.w	#1,d1
		movea.l	a1,a0
		move.w	d1,d2
		mulu	d7,d2
		add.l	d2,a0
		move.b	0(a0,d0.w),d2
		and.w	#$0f,d2
		movem.w	(sp)+,d0-d1
.noGood:
		movem.l	(sp)+,d6-d7/a0-a1
		rts

		ModEnd
		


;{----------------------------------------------------------------------}
;{ Function:	Playerfalling						}
;{ Description:	Player is falling so see if should stop or not		}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
Playerfalling	Module

		movem.l	d0-d2/a0-a2,-(sp)

		movea.l	curLevelMap,a1
		move.w	PLRXPOS(a0),d0
		move.w	PLRYPOS(a0),d1
		add.w	#8,d1
		bsr	checkFall
		move.w	d0,PLRXPOS(a0)
		move.w	d1,PLRYPOS(a0)
		tst.w	d2
		beq.s	.FallExit
		move.w	#WAITING,PLRMOVEMENT(a0)
		clr.w	PLRFRAME(a0)
		and.w	#~USERDISABLED,PLRFLAGS(a0) ; user able to interact
.FallExit:
		movem.l	(sp)+,d0-d2/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	PlayerJumping						}
;{ Description:	Player is jumping so see if should stop or not		}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
PlayerJumping	Module

		movem.l	d0-d3/a0-a2,-(sp)

		move.w	#FALLING,d3
		clr.w	d0
		clr.w	d1
		move.w	PLRCOUNTER(a0),d2
		addq.w	#1,d2
		move.w	d2,PLRCOUNTER(a0)
		cmp.w	#jmpTabSize,d2
		beq.s	.noHflip
		move.w	#JUMPING,d3
		add.w	d2,d2			; for word table index
		move.l	jmpTablePtr,a1
		lea	(jmpTabSize*2)(a1),a2
		move.w	0(a2,d2.w),d1
		move.w	0(a1,d2.w),d0
		move.w	PLRFLAGS(a0),d2
		btst	#CHARHFBIT,d2
		bne.s	.noHFlip
		neg.w	d0
.noHflip:
		add.w	PLRXPOS(a0),d0
		add.w	PLRYPOS(a0),d1
		bsr	checkPlayerBounds	; see if still in bounds
		movea.l	curLevelMap,a1
		bsr	checkfall
		move.w	d0,PLRXPOS(a0)
		move.w	d1,PLRYPOS(a0)
		tst.w	d2
		bne.s	.notFalling
		move.w	d3,PLRMOVEMENT(a0) 	; could be falling
		cmp.w	#JUMPING,d3
		beq.s	.updateFrame
		clr.w	PLRFRAME(a0)
		or.w	#USERDISABLED,PLRFLAGS(a0) ; user unable to interact
		bra.s	.JumpExit
.notFalling:
		move.w	#WAITING,PLRMOVEMENT(a0)
		clr.w	PLRFRAME(a0)
		and.w	#~USERDISABLED,PLRFLAGS(a0) ; user able to interact
.updateFrame:
		move.l	a0,a2
		move.l	PLRFILEPTR(a2),a0	; get file pointer
		move.w	PLRMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	PLRFRAME(a2),d0		; and current frame #
		jsr	_updateFrame		; update to next frame
		cmp.w	#-1,d1			; last frame stay on it
		beq.s	.JumpExit
		move.w	d0,PLRFRAME(a2)		; put new frame # back
.JumpExit:
		movem.l	(sp)+,d0-d3/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	runPlayer						}
;{ Description:	run Player if interaction to move			}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
runPlayer	Module

		movem.l	d0-d2/a0-a2,-(sp)
		move.w	#8,d0
		move.w	PLRFLAGS(a0),d1		; get bits of direction
		and.w	#$800,d1
		bne.s	.notRight
		move.w	#-8,d0
.notRight:
		add.w	PLRXPOS(a0),d0
		move.w	PLRYPOS(a0),d1
		bsr	checkPlayerBounds
		tst.w	d2
		bne.s	.updateRun
		move.w	d0,PLRXPOS(a0)
.updateRun:
		move.l	a0,a2
		move.l	PLRFILEPTR(a2),a0	; get file pointer
		move.w	PLRMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	PLRFRAME(a2),d0		; and current frame #
		jsr	_updateFrame		; update to next frame
		move.w	d0,PLRFRAME(a2)		; put new frame # back
		add.w	#1,PLRCOUNTER(a2)
.NewMovement:
		movem.l	(sp)+,d0-d2/a0-a2
		rts

		ModEnd

KillPlayer:
		rts


;{----------------------------------------------------------------------}
;{ Function:	PlayerAttack						}
;{ Description:	run Player if interaction to shoot			}
;{ Parameters:	a0 = pointer to player structure			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
PlayerAttack	Module

		movem.l	d0-d2/a0-a2,-(sp)

		tst.w	PLRCOUNTER(a0)
		bne.s	.CantShoot
		cmp.w	#3,RainBowShoots
		beq.s	.ExitShoot
		move.w	#11,PLRCOUNTER(a0)	; wait before next shot
		move.l	a0,a2
		lea	RainBowStruct,a0
		bsr	AddEnemy		; not really enemy
		move.w	PLRXPOS(a2),d0
		move.w	d0,ENMYXPOS(a0)
		move.w	PLRYPOS(a2),d0
		sub.w	#20,d0
		move.w	d0,ENMYYPOS(a0)
		move.w	PLRFLAGS(a2),d0
		move.w	d0,ENMYFLAGS(a0)
		move.w	#15,ENMYCOUNTER(a0)
		add.w	#1,RainBowShoots
		move.l	a2,a0
.CantShoot:
		sub.w	#1,PLRCOUNTER(a0)
.ExitShoot:
		movem.l	(sp)+,d0-d2/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	checkFall						}
;{ Description:	check to see if player should fall or not		}
;{ Parameters:	a0 = player pointer					}
;{		a1 = pointer to map structure				}
;{ Returns:	d0 = x position						}
;{		d1 = y position						}
;{		d2 = 0 if not						}
;{----------------------------------------------------------------------}
checkFall	Module

		movem.l	d3-d7/a0-a2,-(sp)


		clr.w	d2
;		cmp.w	PLRYPOS(a0),d1
;		blt	.CFExit

		move.w	d0,d3
		move.w	d1,d4			; going to position
		move.l	a0,a2
		move.l	a1,a0
		move.l	#"OBST",d0
		jsr	findIffHeader		; find obstacle map

;
; -----	linear interpolate between points to get every block we
;	could land on.
;

		and.w	#$fff8,d3
		and.w	#$fff8,d4
		move.w	d3,destX
		move.w	d4,destY		; save destination x & y
		move.w	#1,d0			; starting postive for update
		move.w	#1,d1			; starting y postive for update
		move.w	PLRYPOS(a2),d7
		and.w	#$fff8,d7
		sub.w	d7,d4			; subtract y1 from y2
		bge.s	storey			; skip if y2-y1 is nonnegative
		neg.w	d1			; negative y direction
		neg.w	d4			; absolute value of y2-y1
storey:
		move.w	d1,pdeldy		; store y for diagonal moves
		move.w	PLRXPOS(a2),d7
		and.w	#$fff8,d7
		sub.w	d7,d3			; subtract x1
		bge.s	storex			; skip if x2-x1 is postive
		neg.w	d0			; make negative x direction
		neg.w	d3			; absolute value of y
storex:
		move.w	d0,pdeldx		; save x direction
		cmp.w	d4,d3			; compare dels with delp
		bge.s	setdiag			; skip if straight move in x direction
		clr.w	d0			; zap x update
		exg	d4,d3			; exchange differences
		bra.s	storedelsxy
setdiag:
		clr.w	d1
storedelsxy:
		move.w	d0,pdelsx		; x update in straight direction
		move.w	d1,pdelsy		; y update in straight direction

		add.w	d4,d4			; get delp and * 2
		move.w	d4,pdelse		; change if straight move
		sub.w	d3,d4			; 2*delp-dels
		move.w	d4,d6			; initial value
		sub.w	d3,d4
		move.w	d4,pdelde
		lsr.w	#3,d3

		move.w	PLRXPOS(a2),d0
		move.w	PLRYPOS(a2),d1
		lsr.w	#3,d0
		lsr.w	#3,d1

		move.w	(a0)+,d7
		rol.w	#8,d7
		adda.w	#2,a0
		move.l	a0,a2
.checkLoop:
		move.l	a2,a0
		move.w	d1,d2
		mulu	d7,d2
		add.l	d2,a0
		move.b	0(a0,d0.w),d2
		and.w	#$0f,d2			; something there?
		bne.s	.somethingThere

		tst.w	d6			; determine straight or diagonal
		bge	.diagonal
.straight:
		add.w	pdelsx,d0		;update x
		add.w	pdelsy,d1		;update y
		add.w	pdelse,d6		;update error term
		bra.s	.nextBlock			;all finished
.diagonal:
		add.w	pdeldx,d0		;update x
		add.w	pdeldy,d1		;update y
		add.w	pdelde,d6		;update error term
.nextBlock:
		dbra	d3,.checkLoop
		move.w	destX,d0
		move.w	destY,d1
		clr.w	d2
		bra.s	.CFExit
.somethingThere:
		move.w	destX,d0
		lsl.w	#3,d1
.CFExit:
		movem.l	(sp)+,a0-a2/d3-d7
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	PlayerClimbDown						}
;{ Description:	check for user climbing down stairs			}
;{ Parameters:	a0 = player pointer					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
PlayerClimbDown	Module

		
		movem.l	a0-a2/d3-d7,-(sp)

		move.l	a0,a2
		movea.l	curLevelMap,a1
		move.w	PLRXPOS(a2),d0
		move.w	PLRYPOS(a2),d1
		add.w	#8,d1
		bsr	checkFall
		cmp.w	#STAIROBSTACLE,d2
		beq.s	.noFall
		btst.b	#1,PLRFLAGS+1(a2)	; see if already hit stairs
		beq.s	.Fall			; nope so fall
		tst.w	d2			; else see if floor
		beq.s	.Fall
		move.w	#WAITING,PLRMOVEMENT(a2)
		clr.w	PLRFRAME(a2)
		and.w	#~USERDISABLED,PLRFLAGS(a2) ; user able to interact
		bra.s	.PCDExit
.Fall:
		add.w	#4,PLRYPOS(a2)
		bra.s	.PCDExit
.noFall:
		or.w	#USERONSTAIRS,PLRFLAGS(a2)
		move.w	Joy1Bits,d0		; get joystick bits
		btst	#DNBUTTON,d0
		bne.s	.notDown		; don't update
		move.w	#CLIMBDOWN-1,d2
		move.w	PLRFRAME(a2),d0
		move.l	PLRFILEPTR(a2),a0
		jsr	_updateFrame
		move.w	d0,PLRFRAME(a2)
		move.w	#4,d0
		btst.b	#11-8,PLRFLAGS(a2)	; see if facing right
		bne.s	.isRight
		move.w	#-4,d0
.isRight:
		add.w	d0,PLRXPOS(a2)		; update x position
		bra.s	.PCDExit
.notDown:
		btst	#UPBUTTON,d0
		bne.s	.PCDExit
		eor.w	#$800,PLRFLAGS(a2)
		move.w	#CLIMBUP,PLRMOVEMENT(a2)
.PCDExit:
		movem.l	(sp)+,a0-a2/d3-d7
		rts


		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	PlayerClimbUp						}
;{ Description:	check for user climbing down stairs			}
;{ Parameters:	a0 = player pointer					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
PlayerClimbUp	Module

		
		movem.l	a0-a2/d3-d7,-(sp)

		move.l	a0,a2

		movea.l	curLevelMap,a1
		move.w	Joy1Bits,d0		; get joystick bits
		btst	#UPBUTTON,d0
		bne.s	.notUp			; don't update
		move.w	#CLIMBUP-1,d2
		move.w	PLRFRAME(a2),d0
		move.l	PLRFILEPTR(a2),a0
		jsr	_updateFrame
		move.w	d0,PLRFRAME(a2)
		move.w	#4,d0
		btst.b	#11-8,PLRFLAGS(a2)	; see if facing right
		bne.s	.isRight
		move.w	#-4,d0
.isRight:
		add.w	d0,PLRXPOS(a2)		; update x position
		move.w	PLRXPOS(a2),d0
		move.w	PLRYPOS(a2),d1
		sub.w	#8,d1
		move.l	a2,a0
		movea.l	curLevelMap,a1
		bsr	checkChar
		cmp.w	#STAIROBSTACLE,d2
		beq.s	.isStairs
		cmp.w	#RIGHTSTAIRDOWN,d2
		beq.s	.isStairs
		cmp.w	#LEFTSTAIRDOWN,d2
		beq.s	.isStairs
		tst.w	d2
		beq.s	.PCDExit
		sub.w	#8,PLRYPOS(a2)
		move.w	#WAITING,PLRMOVEMENT(a2)
		clr.w	PLRFRAME(a2)
		and.w	#~USERDISABLED,PLRFLAGS(a2) ; user able to interact
		bra.s	.PCDExit
.isStairs:
		or.w	#USERONSTAIRS,PLRFLAGS(a2)
		sub.w	#8,PLRYPOS(a2)
		bra.s	.PCDExit
.notUp:
		btst	#DNBUTTON,d0
		bne.s	.PCDExit
		eor.w	#$800,PLRFLAGS(a2)
		move.w	#CLIMBDOWN,PLRMOVEMENT(a2)
.PCDExit:
		movem.l	(sp)+,a0-a2/d3-d7
		rts



		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	UserInterAct						}
;{ Description:	check for user interaction to player			}
;{ Parameters:	a0 = player pointer					}
;{ Returns:	d0 = 0 if not						}
;{----------------------------------------------------------------------}
UserInterAct	Module

		movem.l	d1-d2/a0-a2,-(sp)

		movea.l	curLevelMap,a1
		cmp.w	#FALLING,PLRMOVEMENT(a0)
		beq	.UserActExit
		move.w	PLRFLAGS(a0),d1
		and.w	#USERDISABLED,d1	; user not able to interact
		bne	.UserActExit
.isFalling:
		move.w	PLRXPOS(a0),d0
		move.w	PLRYPOS(a0),d1
		jsr	checkfall
		tst.w	d2
		bne.s	.NotFalling
		move.w	#FALLING,PLRMOVEMENT(a0)
		clr.w	PLRFRAME(a0)
		or.w	#USERDISABLED,PLRFLAGS(a0) ; user not able to interact
		bra	.UserActExit
.NotFalling:		
		move.w	Joy1Bits,d7
		btst	#A_BUTTON,d7		; a button pressed?
		bne.s	.NotButtonA
		move.w	PLRFLAGS(a0),d1
		and.w	#USERDISABLED,d1	; user not able to interact
		bne	.UserActExit
.isJumping:
;		or.w	#USERDISABLED,PLRFLAGS(a0)
;		move.l	#JumpAddXTable1,jmpTablePtr
;		cmp.w	#WAITING,PLRMOVEMENT(a0)
;		bne.s	.isntStanding
;		move.l	#JumpAddXTable2,jmpTablePtr
;.isntStanding:
;		move.w	#JUMPING,PLRMOVEMENT(a0)
;		clr.w	PLRFRAME(a0)
;		clr.w	PLRCOUNTER(a0)
;		bra	.UserActExit
.NotButtonA:
		btst	#C_BUTTON,d7
		bne.s	.NotButtonC
		move.w	PLRFLAGS(a0),d1
		and.w	#USERDISABLED,d1	; user not able to interact
		bne	.UserActExit
		move.w	#ATTACKING,PLRMOVEMENT(a0)
		clr.w	PLRFRAME(a0)
		bra	.UserActExit
.NotButtonC:
		btst	#RTBUTTON,d7
		bne.s	.notRight
		or.w	#$800,PLRFLAGS(a0)
		cmp.w	#WALKING,PLRMOVEMENT(a0)
		beq	.UserActExit
		cmp.w	#RUNNING,PLRMOVEMENT(a0)
		beq	.UserActExit
		move.w	#WALKING,PLRMOVEMENT(a0) ; start walking
		clr.w	PLRFRAME(a0)
		clr.w	PLRCOUNTER(a0)
		bra	.notLeft		; can't be both
.notRight:
		btst	#LFBUTTON,d7
		bne.s	.notLeft
		and.w	#~$800,PLRFLAGS(a0)
		cmp.w	#WALKING,PLRMOVEMENT(a0)
		beq	.UserActExit
		cmp.w	#RUNNING,PLRMOVEMENT(a0)
		beq	.UserActExit
		move.w	#WALKING,PLRMOVEMENT(a0) ; start walking
		clr.w	PLRFRAME(a0)
		clr.w	PLRCOUNTER(a0)
.notLeft:
		btst	#DNBUTTON,d7
		bne.s	.notDown
		move.w	PLRXPOS(a0),d0
		move.w	PLRYPOS(a0),d1
		add.w	#8,d1
		movea.l	curLevelMap,a1
		jsr	CheckFall		; get character below us
		or.w	#$800,PLRFLAGS(a0)	; assume we go right
		cmp.w	#RIGHTSTAIRDOWN,d2
		beq.s	.foundDown
		and.w	#~$800,PLRFLAGS(a0)	; now assume we go left
		cmp.w	#LEFTSTAIRDOWN,d2
		bne	.UserActExit
.foundDown:
		or.w	#USERDISABLED,PLRFLAGS(a0) ; user not able to interact
		or.w	d0,PLRFLAGS(a0)
		move.w	#CLIMBDOWN,PLRMOVEMENT(a0) ; start walking
		and.w	#~USERONSTAIRS,PLRFLAGS(a0)	; haven't hit stairs yet
		clr.w	PLRFRAME(a0)
		clr.w	PLRCOUNTER(a0)
		bra	.UserActExit
.notDown:
		btst	#UPBUTTON,d7
		bne	.NotUp
		move.w	PLRXPOS(a0),d0
		move.w	PLRYPOS(a0),d1
		add.w	#8,d1
		movea.l	curLevelMap,a1
		jsr	CheckFall		; get character below us
		or.w	#$800,PLRFLAGS(a0)	; assume we go right
		cmp.w	#RIGHTSTAIRUP,d2
		beq.s	.foundUp
		and.w	#~$800,PLRFLAGS(a0)	; now assume we go left
		cmp.w	#LEFTSTAIRUP,d2
		bne.s	.UserActExit
.foundUp:
		or.w	#USERDISABLED,PLRFLAGS(a0) ; user not able to interact
		move.w	#CLIMBUP,PLRMOVEMENT(a0) ; start walking
		and.w	#~USERONSTAIRS,PLRFLAGS(a0)	; haven't hit stairs yet
		clr.w	PLRFRAME(a0)
		clr.w	PLRCOUNTER(a0)
		bra	.UserActExit
.NotUp:
		and.w	#$ff,d7
		cmp.w	#$ff,d7
		bne.s	.UserActExit
		move.w	#WAITING,PLRMOVEMENT(a0)
		clr.w	PLRFRAME(a0)
		clr.w	PLRCOUNTER(a0)
		and.w	#~USERDISABLED,PLRFLAGS(a0) ; user not able to interact
.UserActExit:
		movem.l	(sp)+,d1-d2/a0-a2
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	InitEnemies						}
;{ Description:	Initialize enemy structures				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
InitEnemies	Module


		lea	enemyList,a1
		lea	FireBalls,a0
		move.w	(a0)+,d2
		move.w	d2,enemyCount
		subq.w	#1,d2
.InitLoop:
		move.w	#(ENEMYSIZE/2)-1,d0
.moveLoop:
		move.w	(a0)+,(a1)+
		dbra	d0,.moveLoop
		dbra	d2,.InitLoop
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	AddEnemy						}
;{ Description:	Initialize enemy structures				}
;{ Parameters:	a0 = pointer to structure				}
;{ Returns:	a0 = pointer to new structure				}
;{----------------------------------------------------------------------}
AddEnemy	Module

		
		movem.l	a1-a2,-(sp)
		lea	enemyList,a1
		move.w	enemyCount,d0
		cmp.w	#MAXENEMIES,d0
		beq.s	.allDone
		mulu	#ENEMYSIZE,d0
		adda.w	d0,a1
		move.l	a1,a2
		move.w	#(ENEMYSIZE/2)-1,d0
.moveLoop:
		move.w	(a0)+,(a1)+
		dbra	d0,.moveLoop
		add.w	#1,enemyCount
.allDone:
		move.l	a2,a0
		movem.l	(sp)+,a1-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	DeleteEnemy						}
;{ Description:	kill enemy structures					}
;{ Parameters:	d0 = enemy #						}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DeleteEnemy	Module

		lea	enemyList,a1
		move.w	EnemyCount,d1
		sub.w	d0,d1
		subq.w	#1,d1			; # enemy structures to move
		blt.s	.Alldone
.moveLoop1:
		mulu	#ENEMYSIZE,d0
		adda.w	d0,a1
		lea	ENEMYSIZE(a1),a0
.structLoop:
		move.w	#(ENEMYSIZE/2)-1,d0
.moveLoop2:
		move.w	(a0)+,(a1)+
		dbra	d0,.moveLoop2
		dbra	d1,.structLoop
.AllDone:
		sub.w	#1,enemyCount
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	UpdateEnemies						}
;{ Description:	update enemies sprites					}
;{ Parameters:	.							}							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
UpdateEnemies	Module


		lea	enemyList,a2
		move.w	enemyCount,d7
		subq.w	#1,d7
.updateLoop:
		move.l	ENMYAIPTR(a2),a1
		jsr	(a1)
		adda.w	#ENEMYSIZE,a2
		dbra	d7,.updateLoop
.AllDone:
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	_DrawEnemies						}
;{ Description:	draw enemies sprites					}
;{ Parameters:	.							}							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
_DrawEnemies	Module


		lea	enemyList,a2
		move.w	enemyCount,d7
		subq.w	#1,d7
.updateLoop:
		move.w	PLRXPOS(a2),d0
		sub.w	_MapX,d0
		add.w	#160,d0
		move.w	PLRYPOS(a2),d1
		sub.w	_MapY,d1
		add.w	#137,d1
		cmp.w	#-128,d0
		blt.s	.notShowing
		cmp.w	#448,d0
		bge.s	.notShowing
		cmp.w	#-128,d1
		blt.s	.notShowing
		cmp.w	#352,d1
		bge.s	.notShowing
		move.w	_SYS_EnemySprite,d4
		move.w	PLRFLAGS(a2),d2
		and.w	#CHARHF,d2
		or.w	d2,d4
		move.w	PLRMOVEMENT(a2),d2
		beq.s	.notShowing
		subq.w	#1,d2
		move.w	PLRFRAME(a2),d3
		move.l	PLRFILEPTR(a2),a0
		jsr	_Disp1AnimFrame
		add.w	d0,_SYS_EnemySprite
.notShowing:
		adda.w	#ENEMYSIZE,a2
		dbra	d7,.updateLoop
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	MoveFireBall						}
;{ Description:	Move fire ball left/right till end of platform		}
;{ Parameters:	a2 = fireball Structure					}							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
MoveFireBall	Module

		move.w	#4,d3
		btst.b	#11-8,ENMYFLAGS(a2)	; right or left
		bne.s	.isRight
		move.w	#-4,d3
.isRight:
		add.w	ENMYXPOS(a2),d3
		move.w	ENMYXPOS(a2),d0
		and.w	#$fff8,d0
		move.w	d3,d1
		and.w	#$fff8,d1
		cmp.w	d0,d1
		beq.s	.NotoutofBounds		; still in same character
		move.w	d3,d0
		move.w	ENMYYPOS(a2),d1
		add.w	#8,d1
		movea.l	curLevelMap,a1
		move.l	a2,a0
		bsr	checkfall
		tst.w	d2
		bne.s	.noFall
		eor.w	#$800,ENMYFLAGS(a2)	; other way now
		move.w	ENMYXPOS(a2),d3
		bra.s	.NotoutofBounds
.noFall:
		move.l	a2,a0
		bsr	checkPlayerBounds
		cmp.w	#1,d2
		bne.s	.NotoutofBOunds
		eor.w	#$800,ENMYFLAGS(a2)	; other way now
		move.w	ENMYXPOS(a2),d3
.NotoutofBounds:
		move.w	d3,ENMYXPOS(a2)		; update x position
		move.l	ENMYFILEPTR(a2),a0	; get file pointer
		move.w	ENMYMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	ENMYFRAME(a2),d0	; and current frame #
		jsr	_updateFrame		; update to next frame
		move.w	d0,ENMYFRAME(a2)	; put new frame # back
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	MoveRainBow						}
;{ Description:	Move rainBow left/right till end of count		}
;{ Parameters:	a2 = rainbow Structure					}							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
MoveRainBow	Module

		move.w	#11,d0
		btst.b	#11-8,ENMYFLAGS(a2)	; right or left
		bne.s	.isRight
		move.w	#-11,d0
.isRight:
		add.w	d0,ENMYXPOS(a2)
		sub.w	#1,ENMYCOUNTER(a2)
		bne	.notoutofBounds
		clr.w	ENMYMOVEMENT(a2)
		move.w	d7,d0
		addq.w	#1,d0
		neg.w	d0
		add.w	EnemyCount,d0
		bsr	DeleteEnemy
		sub.w	#1,RainBowShoots
		suba.w	#ENEMYSIZE,a2
		bra.s	.AllDone
.NotoutofBounds:
		move.l	ENMYFILEPTR(a2),a0	; get file pointer
		move.w	ENMYMOVEMENT(a2),d2	; and current movement
		subq.w	#1,d2			; -1 for animation #
		move.w	ENMYFRAME(a2),d0	; and current frame #
		jsr	_updateFrame		; update to next frame
		move.w	d0,ENMYFRAME(a2)	; put new frame # back
.AllDone:
		rts

		ModEnd


		include	globals.i

		end
