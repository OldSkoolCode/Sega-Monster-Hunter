;{----------------------------------------------------------------------}
;{	endlvls.S							}
;{	Monster Hunter:							}
;{	  end of level Routines routines for game			}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: endlvls.s_v $
;Revision 1.6  1993/07/08  15:27:44  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/14  20:24:15  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/14  20:22:56  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/07  19:55:27  KENH
;*** empty log message ***
;
;Revision 1.2  1993/06/02  07:08:01  KENH
;Added levels 3 & 4
;
;Revision 1.1  1993/05/13  23:06:30  KENH
;Initial revision
;
		include	macros.i
		include equates.i

		section	.text
		even


gotoNextLevel:
		jsr	killAllMonsters
		move.w	ScrollAdd,d0
		neg.w	d0
		move.w	d0,curXPos
		add.w	#1,curLevelNum
		move.w	curLevelNum,d0
		add.w	d0,d0
		add.w	d0,d0
		lea	levelMaps,a0
		move.l	0(a0,d0.w),curLevelMap
		move.l	32(a0,d0.w),curWallSet
		move.l	64(a0,d0.w),sideWallSet
		clr.w	EndFinished
		st	firstTimeLR	
		rts


		if (DEMO=0)

;{----------------------------------------------------------------------}
;{ Function: 	endlvl1Build						}
;{ Description:	build end level 1 for game				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
endlvl1Build	Module


		movem.l	d0-d4/a0-a2,-(sp)

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
		jsr	killAllMonsters		; no other monsters in list
		jsr	_sendSprList
		jsr	waitDMAQueue
		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in

		move.l	lastSong,d0
		move.l	d0,-(sp)
		jsr	_gemsstopsong
		adda.w	#4,sp

		move.l	#4,-(sp)
		move.l	#4,lastSong
		jsr	_gemsstartsong		; start spider song
		adda.w	#4,sp

		clr.w	d0
		clr.w	d1
		move.w	borderChars,d2
		or.w	#$8000,d2		; top priority
		lea	borderMap,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		lea	mapBuff,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		lea	endlvl1File,a0
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals

		jsr	waitDMAQueue
		lea	HScrollBuff,a1
		move.w	#POVYCHARS-1,d2
.hscrollLoop:
		clr.w	(a1)+
		clr.w	(a1)+
		adda.w	#32-4,a1
		dbra	d2,.hscrollLoop
		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	HScrollBuff,a0
		jsr	addDMAQueue

		lea	endlvl1File,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		move.w	(a0)+,d1
		move.w	d1,d7
		lsl.w	#5,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		jsr	AddDMAQueue
		move.w	mapChars1,d2

		clr.w	d0
		clr.w	d1
		lea	endlvl1File,a0
		lea	mapBuff2,a1
		jsr	drawMap

		move.w	_ScrBAddr,d0
		lea	mapBuff2,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		move.l	#aiXlatAnims,lastMonsterList	; dummy 0 word

		jsr	addPowerUps

		lea	0,a2
		lea	spiderInfo,a0
		move.w	curXPos,d0
		move.w	curYPos,d1
		jsr	addMonster

		move.w	#1,monsterstoKill
		move.w	#1,EndFinished

		clr.w	curXPos
		move.l	levelMaps+4,curLevelMap
		move.l	levelMaps+32+4,curWallSet

		movem.l	(sp)+,d0-d4/a0-a2
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function: 	endlvl2Build						}
;{ Description:	build end level 2 for game				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
endlvl2Build	Module


		movem.l	d0-d4/a0-a2,-(sp)

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
		jsr	killAllMonsters		; no other monsters in list
		jsr	_sendSprList
		jsr	waitDMAQueue
		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in

		clr.w	d0
		clr.w	d1
		move.w	borderChars,d2
		or.w	#$8000,d2		; top priority
		lea	borderMap,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		lea	mapBuff,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		lea	endlvl2File,a0
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals

		jsr	waitDMAQueue
		lea	HScrollBuff,a1
		move.w	#POVYCHARS-1,d2
.hscrollLoop:
		clr.w	(a1)+
		clr.w	(a1)+
		adda.w	#32-4,a1
		dbra	d2,.hscrollLoop
		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	HScrollBuff,a0
		jsr	addDMAQueue

		lea	endlvl2File,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		move.w	(a0)+,d1
		lsl.w	#5,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		jsr	AddDMAQueue
		move.w	mapChars1,d2

		clr.w	d0
		clr.w	d1
		lea	endlvl2File,a0
		lea	mapBuff2,a1
		jsr	drawMap

		move.w	_ScrBAddr,d0
		lea	mapBuff2,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		jsr	waitDMAQueue

		move.l	#aiXlatAnims,lastMonsterList	; dummy 0 word

		jsr	addPowerUps

		lea	0,a2
		lea	madsciInfo,a0
		move.w	curXPos,d0
		move.w	curYPos,d1
		jsr	addMonster

		move.w	#1,monsterstoKill
		move.w	#1,EndFinished

		clr.w	curXPos
		move.l	levelMaps+8,curLevelMap
		move.l	levelMaps+32+8,curWallSet

		movem.l	(sp)+,d0-d4/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function: 	endlvl3Build						}
;{ Description:	build end level 3 for game				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
endlvl3Build	Module


		movem.l	d0-d4/a0-a2,-(sp)

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
		jsr	killAllMonsters		; no other monsters in list
		jsr	_sendSprList
		jsr	waitDMAQueue
		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in

		clr.w	d0
		clr.w	d1
		move.w	borderChars,d2
		or.w	#$8000,d2		; top priority
		lea	borderMap,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		lea	mapBuff,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		lea	endlvl3File,a0
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals

		jsr	waitDMAQueue
		lea	HScrollBuff,a1
		move.w	#POVYCHARS-1,d2
.hscrollLoop:
		clr.w	(a1)+
		clr.w	(a1)+
		adda.w	#32-4,a1
		dbra	d2,.hscrollLoop
		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	HScrollBuff,a0
		jsr	addDMAQueue

		lea	endlvl3File,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		move.w	(a0)+,d1
		lsl.w	#5,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		jsr	AddDMAQueue
		move.w	mapChars1,d2

		clr.w	d0
		clr.w	d1
		lea	endlvl3File,a0
		lea	mapBuff2,a1
		jsr	drawMap

		move.w	_ScrBAddr,d0
		lea	mapBuff2,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		jsr	waitDMAQueue

		move.l	#aiXlatAnims,lastMonsterList	; dummy 0 word

		jsr	addPowerUps

		lea	0,a2
		lea	madsciInfo,a0
		move.w	curXPos,d0
		move.w	curYPos,d1
		jsr	addMonster

		move.w	#1,monsterstoKill
		move.w	#1,EndFinished

		clr.w	curXPos
		move.l	levelMaps+12,curLevelMap
		move.l	levelMaps+32+12,curWallSet

		movem.l	(sp)+,d0-d4/a0-a2
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function: 	endlvl4Build						}
;{ Description:	build end level 4 for game				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
endlvl4Build	Module


		movem.l	d0-d4/a0-a2,-(sp)

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
		jsr	killAllMonsters		; no other monsters in list
		jsr	_sendSprList
		jsr	waitDMAQueue
		move.w	_SYS_FirstSpr,d0
		move.w	d0,_SYS_LastSpr		; zero out sprites.
		move.w	saveLink,d3
		move.l	saveSprPtr,a1
		move.w	d3,SLLINK(a1)		; put link back in

		clr.w	d0
		clr.w	d1
		move.w	borderChars,d2
		or.w	#$8000,d2		; top priority
		lea	borderMap,a0
		lea	mapBuff,a1
		jsr	drawMap

		move.w	_ScrAAddr,d0
		lea	mapBuff,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		lea	endlvl4File,a0
		move.w	BHPALOFFSET(a0),d0
		adda.w	d0,a0
		move.l	a0,globalPals

		jsr	waitDMAQueue
		lea	HScrollBuff,a1
		move.w	#POVYCHARS-1,d2
.hscrollLoop:
		clr.w	(a1)+
		clr.w	(a1)+
		adda.w	#32-4,a1
		dbra	d2,.hscrollLoop
		move.w	#HSCROLL,d0
		move.w	#1024,d1
		lea	HScrollBuff,a0
		jsr	addDMAQueue

		lea	endlvl4File,a0
		move.w	BHCHAROFFSET(a0),d0
		adda.w	d0,a0
		move.w	(a0)+,d1
		lsl.w	#5,d1
		move.w	mapChars1,d0
		lsl.w	#5,d0
		jsr	AddDMAQueue
		move.w	mapChars1,d2

		clr.w	d0
		clr.w	d1
		lea	endlvl4File,a0
		lea	mapBuff2,a1
		jsr	drawMap

		move.w	_ScrBAddr,d0
		lea	mapBuff2,a0
		move.w	#(MAPWIDTH*2)*MAPHEIGHT,d1
		jsr	addDMAQueue

		jsr	waitDMAQueue

		move.l	#aiXlatAnims,lastMonsterList	; dummy 0 word

		jsr	addPowerUps

		lea	0,a2
		lea	znjaInfo,a0
		move.w	curXPos,d0
		move.w	curYPos,d1
		jsr	addMonster

		move.w	#1,monsterstoKill
		move.w	#1,EndFinished

		clr.w	curXPos
		move.l	levelMaps+16,curLevelMap
		move.l	levelMaps+32+16,curWallSet

		movem.l	(sp)+,d0-d4/a0-a2
		rts

		ModEnd

		endif


;
;
;
addPowerUps:
		movem.l	d3/a1-a2,-(sp)
		lea	PowerUpSprLst,a1
		move.w	(a1)+,d3		; get # entries
		subq.w	#1,d3
.AddLoop:
		move.l	(a1)+,a0
		lea	0,a2
		bsr	AddMonster		; add into structures
		dbra	d3,.AddLoop

		movem.l	(sp)+,d3/a1-a2
		rts


		include	globals.i

		end
