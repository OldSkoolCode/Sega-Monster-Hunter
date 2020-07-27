
; $Log: globals.i_v $
;Revision 1.4  1993/06/14  20:25:12  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/07  19:57:35  KENH
;*** empty log message ***
;
;Revision 1.2  1993/05/13  23:09:15  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:50:13  KENH
;Initial revision
;

;
; -----	External symbols go here
;

		if	~def(global)
		include	equates.i
		include	macros.i
		endif

		global	segamap, segacolor, titletext, asccg, _vdpshadow
		global	_ScreenRow, _ScreenCol, puts, putsHigh, _WriteCharSet
		global	BEVect, AEVect, IEVect, VBLVect, LineAVect, _SegaLogo
		global	start,BusError, AddressError, IllegalError, ErrorVect
		global	_ScrAAddr, ExtInt, VBlank, HInt, _waitVBL, _cycleLogo
		global	_SYS_LastChar, wallBM1, DrawMap, DLChars, SetMapPal
		global	_VCount

		global	_TadVbi,_TadExt,_TadInit,_TadXYFixup,_TadXpos,_TadYpos
		global	_TadButtons,_TadPrevButtons,_TadOnScreen, crosshair
		global	_SendFrameChars, _SYS_LastSpr, _Work_Sprlist
		global	_SprAttrAddr, _DispFrame, _SendSprList, _SYS_FirstSpr

		global	_SetPal,_SetSpritePal, crocanim

		global	DoPOVScroll, mapChars1, _getFrameInfo

		global	SpriteScaler, DMATemp, floorChars1, floorChars2

		global	ClearVRAM, ClearVSRAM, ClearHSRAM, CopyToVRAM

		global	buildMap, WaitForDMA, clearVDPText

		global	curLevelMap, curXPos, curYPos, scrollAdd
		global	BuildSideView, curWallSet

		global	scaleVars, oldXPos, DestData, UnpackTab

		global	wallDirection, theWallLists, UnpackSrcData

		global	gatorWalkAnim, gatorAttAnim, gatorDieAnim
		global	_SendScaledSprite, _SYS_scaledChar, spriteList
		global	MonsterAI, endLevel1

		global	nMonsterLists, gator1AIRtn

		global	gator1Info, AddMonster, wallXPos, wallYPos
		global	gator2Info, gator3Info, gator4Info

		global	ShootEnemy, _ptInRect, scoreUpdate

		global	wallBM2, borderMap, sendScreen, borderChars
		global	_ScrBAddr, unpackWall, UnpackSrcData2

		global	addDecorations, quickMove, firstTimePOV, mapBuff

		global	dmaBuff, dmaAddr, dmaSize, SendStaticSprites

		global	_staticSprites, crosshairX, crosshairY, crosshairChar	
		global	sprAddedFlags, curMovement

		global	StatSprChars, StatSprNum, StatSprSize
		global	theMonsterLists, globalPals, crossHSpr

		global	Level1Map, Level2Map
		global	Level3Map, Level4Map
		global	Level5Map

		include	lvl1pubs.i
		include	lvl2pubs.i
		include	lvl3pubs.i
		include	lvl4pubs.i
		include	lvl5pubs.i

		global	spiderInfo, endlvl1Build, endlvl2Build

		global	qroach1AITable, qroach1Info, qroach1AIRtn
		global	rat1AITable, rat1Info, rat1AIRtn
		global	slime1AITable, slime1Info, slime1AIRtn
		global	spiderAIRtn, mtratAIRtn
		global	mtrat1Info, mtrat2Info, mtrat3Info
		global	roachAITable, roach1Info, roachAIRtn
		global	roach2Info, roach3Info, rat2Info, rat3Info

		global	_sortSprites, addNumSprites, levelMaps

		global	adjustYfromScale, killAllMonsters

		global	xBoundLeft, xBoundRight, _updateFrame
		global	monsterstoKill

		global	_SYS_endsprite1, _SYS_endsprite2, updatecrossHair

		global	mainentry, scaleBuff1, scaleBuff2
		global	scaleBuffPtr1, scaleBuffPtr2

		global	addDMAQueue, dmaQueue, updateDMA
		global	waitDMAQueue, hextodec, hextoasc, tempbuff
		global	hexascii, mapBuff2

		global	firstTimeLR, HScrollBuff, AddMonsterQueue
		global	lastMonsterList, explosivFile, pageOn
		global	EndFinished

		global	_sfxQueue
		global	CharSet, scanJoy1, joy1Data

		global	clearMapBuff, aiXlatAnims, madSciInfo

		global	fadetoPalRange, fadetoFullPal
		global	VDPAccess, lastPals, BlackmapPal
		global	redOutPal, flashPals

		global	hboxFile, aBoxFile, shellSort
		global	explosionSnd, MonsterListPtrs
		global	lastSong

		global	znjaInfo
		global	endlvl3Build, endlvl4Build
		global	redCrossFile, bulletFile
		global	PowerUpSprLst

		global	saveLink, dmaStart, dmaEnd, dmaCurrent
		global	saveSprPtr
		global	sideWallSet

		global	lvl5b2Strip, lvl2b2Strip
		global	lvl1b1Strip, lvl3b1Strip

	; begin addition for Display.S TSD
		global	addScore,score1
		global	InitDisplay,UpdateDisplay
		global	IncHealth,DecHealth
		global	Use1Bullet,AddClips,ammoBaseChar
		global	radarBlipChar,radarBlipSpr
		global	healthValue
		global	bulletCount
	; end addition for Display.S TSD

		global _gemsdmastart
		global _gemsdmaend
		global _gemsholdz80
		global _gemsreleasez80
		global _gemsloadz80
		global _gemsstartz80
		global _gemsputcbyte
		global _gemsputptr
		global _gemsinit
		global _gemsstartsong
		global _gemsstopsong
		global _gemssettempo
		global _gemspauseall
		global _gemsresumeall
		global _gemsstopall
		global _gemslockchannel
		global _gemsunlockchannel
		global _gemsprogchange
		global _gemsnoteon
		global _gemsnoteoff
		global _gemssetprio
		global _gemspitchbend
		global _gemssetenv
		global _gemsretrigenv
		global _gemssustain
		global _gemsmute
		global _gemsstorembox
		global _gemsreadmbox
		global _gemssamprate

		global _patchbank
		global _envbank
		global _seqbank
		global _sampbank

		global	bit_pointer, buff_pointer, xpnd_total, bit_mask
		global	lz_open, xpnd_buffer,lz_read,lz_seek

;
;
;
		global	DoOpening,oldjoy1Data,fixpal, CharPalette
		global	talkaboutLevel, displayCrossHair
		global	aiVariables, gotoNextLevel, curLevelNum
		global	getStatWH
