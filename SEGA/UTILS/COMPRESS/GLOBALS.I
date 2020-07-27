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

		global	buildMap, WaitForDMA

		global	curLevelMap, curXPos, curYPos, scrollAdd
		global	BuildSideView

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

		global	theMonsterLists, globalPals, crossHSpr

		global	Level1Map, Level2Map

		global	spiderInfo, endlvl1Build

		global	qroach1AITable, qroach1Info, qroach1AIRtn
		global	rat1AITable, rat1Info, rat1AIRtn
		global	slime1AITable, slime1Info, slime1AIRtn
		global	spiderAIRtn, mtratAIRtn
		global	mtrat1Info, mtrat2Info, mtrat3Info
		global	roachAITable, roach1Info, roachAIRtn
		global	roach2Info, roach3Info, rat2Info, rat3Info

		global	_sortSprites, addNumSprites, levelMaps

		global	adjustZfromX, adjustYfromX, killAllMonsters

		global	xBoundLeft, xBoundRight, _updateFrame
		global	monsterstoKill

		global	_SYS_endsprite1, _SYS_endsprite2, updatecrossHair

		global	mainentry, scaleBuff1, scaleBuff2
		global	scaleBuffPtr1, scaleBuffPtr2

		global	addDMAQueue, dmaStart, dmaCurrent
		global	dmaQueue, updateDMA
		global	waitDMAQueue, dmaEnd, hextodec, hextoasc, tempbuff
		global	hexascii, mapBuff2

		global	firstTimeLR, HScrollBuff

	; begin addition for Display.S TSD
		global	addScore,score1
		global	InitDisplay,UpdateDisplay
		global	IncHealth,DecHealth
		global	Use1Bullet,AddClips,ammoBaseChar
		global	radarBlipChar,radarBlipSpr
	; end addition for Display.S TSD



		global	bit_pointer, buff_pointer, xpnd_total, bit_mask
		global	lz_open, xpnd_buffer,lz_read,lz_seek
