; $Log: lvl4map.s_v $
;Revision 1.4  1993/07/08  15:27:22  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/14  20:24:04  KENH
;*** empty log message ***
;
;Revision 1.2  1993/06/07  19:56:31  KENH
;*** empty log message ***
;
;Revision 1.1  1993/06/02  07:09:03  KENH
;Initial revision
;
		include	soundeqs.i

		section	.data

FLOORPANEL	equ	0
WALLPANEL	equ	0

Level4Map:
		dc.w	0, WALLPANEL+0
		dc.l	PowerUpSprLst
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.w	3
		dc.w	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst1
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst1
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+8
		dc.l	l2_sprlst2
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+9
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst3
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst3
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.w	2
		dc.w	0
		dc.l	AddNumSprites

		dc.w	0, WALLPANEL+15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	l2_sprlst11
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0    
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0    
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst11
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	PowerUpSprLst
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	l2_sprlst6
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+19
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+16
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+17
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst4
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+9
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l2_sprlst11
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	ENDOFLEVEL
		dc.w	0
		dc.w	0, FLOORPANEL+20
		dc.l	0
		dc.l	endLvl4Build

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+21
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+18
		dc.l	0
		dc.l	0


l2_sprlst1:
		dc.w	4
		dc.l	gargoyle1Info
		dc.l	gargoyle2Info
		dc.l	gargoyle3Info
		dc.l	gargoyle4Info
		dc.w	4
		dc.l	gargoyle4Info
		dc.l	gargoyle5Info
		dc.l	gargoyle6Info
		dc.l	gargoyle7Info
		dc.w	4
		dc.l	gargoyle1Info
		dc.l	gargoyle2Info
		dc.l	gargoyle3Info
		dc.l	gargoyle4Info
		dc.w	0

l2_sprlst2:
		dc.w	4
		dc.l	sami8Info
		dc.l	sami9Info
		dc.l	sami10Info
		dc.l	sami11Info
		dc.w	0

l2_sprlst2a:
		dc.w	1
		dc.l	sami11Info
		dc.w	0

l2_sprlst3:
		dc.w	3
		dc.l	lion1Info
		dc.l	lion2Info
		dc.l	lion3Info
		dc.w	3
		dc.l	lion1Info
		dc.l	lion2Info
		dc.l	lion3Info
		dc.w	3
		dc.l	lion4Info
		dc.l	lion5Info
		dc.l	lion6Info
		dc.w	3
		dc.l	lion5Info
		dc.l	lion6Info
		dc.l	lion4Info
		dc.w	0
l2_sprlst4:
		dc.w	1
		dc.l	hydra1Info
		dc.w	0

l2_sprlst4a:
		dc.w	2
		dc.l	lion5Info
		dc.l	lion6Info
		dc.w	0

l2_sprlst5:
		dc.w	2
		dc.l	wyvern1Info
l2_sprlst6:
		dc.w	3
		dc.l	sami1Info
		dc.l	sami2Info
		dc.l	sami3Info
		dc.w	4
		dc.l	sami4Info
		dc.l	sami5Info
		dc.l	sami6Info
		dc.l	sami7Info
		dc.w	4
		dc.l	sami4Info
		dc.l	sami2Info
		dc.l	sami3Info
		dc.l	sami7Info
		dc.w	0
l2_sprlst7:
		dc.w	1
		dc.l	znjaInfo
l2_sprlst7a:
		dc.w	1
		dc.l	knives1Info
		dc.w	0
l2_sprlst7b:
		dc.w	1
		dc.l	knives2Info
		dc.w	0
l2_sprlst7c:
		dc.w	1
		dc.l	knives3Info
		dc.w	0
l2_sprlst7d:
		dc.w	1
		dc.l	knives4Info
		dc.w	0
l2_sprlst7e:
		dc.w	1
		dc.l	knives5Info
		dc.w	0

l2_sprlst8:
		dc.w	1
		dc.l	sami4Info
		dc.w	0
l2_sprlst9:
		dc.w	1
		dc.l	sami1Info
		dc.w	0

l2_sprlst10:
		dc.w	3
		dc.l	lion1Info
		dc.l	lion2Info
		dc.l	lion3Info
		dc.w	3
		dc.l	lion1Info
		dc.l	lion2Info
		dc.l	lion3Info
		dc.w	0

l2_sprlst11:
		dc.w	1
		dc.l	ninja1Info
		dc.w	0
		dc.l	ninja2Info
		dc.l	ninja3Info
		dc.w	0

l4_sprlst11a:
		dc.w	1
		dc.l	shuriken1Info
		dc.w	0

l4_sprlst11b:
		dc.w	1
		dc.l	shuriken2Info
		dc.w	0

l4_sprlst11c:
		dc.w	1
		dc.l	shuriken3Info
		dc.w	0

l4_sprlst11d:
		dc.w	1
		dc.l	shuriken4Info
		dc.w	0

l4_sprlst11e:
		dc.w	1
		dc.l	shuriken5Info
		dc.w	0

l4_sprlst11f:
		dc.w	1
		dc.l	shuriken6Info
		dc.w	0

gargoyle1Info:
		dc.w	120, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable1		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter
gargoyle2Info:
		dc.w	160, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable2		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	120			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter

gargoyle3Info:
		dc.w	140, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable3		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	150			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter

gargoyle4Info:
		dc.w	180, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable1		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter
gargoyle5Info:
		dc.w	145, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable1		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter
gargoyle6Info:
		dc.w	175, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable2		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter

gargoyle7Info:
		dc.w	160, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	gargoyleAITable3		; move ai table
		dc.l	gargoyleHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	gargoyleFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	ChompSnd
		dc.w	0			; current loop counter

lion1Info:
		dc.w	-50, 96  		; x, y 
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable1		; move ai table
		dc.l	lionHitTable1		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter
lion2Info:
		dc.w	360, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable2		; move ai table
		dc.l	lionHitTable2		; hit ai table
		dc.w	$f0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter
lion3Info:
		dc.w	140, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable3		; move ai table
		dc.l	lionHitTable3		; hit ai table
		dc.w	$f0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter
lion4Info:
		dc.w	-20, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable1		; move ai table
		dc.l	lionHitTable1		; hit ai table
		dc.w	$f0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter
lion5Info:
		dc.w	350, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable2		; move ai table
		dc.l	lionHitTable2		; hit ai table
		dc.w	$f0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter
lion6Info:
		dc.w	-40, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	lionAITable3		; move ai table
		dc.l	lionHitTable3		; hit ai table
		dc.w	$f0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	lionFile			; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	RoarSnd
		dc.w	0			; current loop counter

hydra1Info:
		dc.w	80, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	hydraAITable		; move ai table
		dc.l	hydraHitTable		; hit ai table
		dc.w	$e0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	hydraFile		; file for monster
		dc.w	120			; counter
		dc.w	0			; temp counter
		dc.w	200			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter
ninja1Info:
		dc.w	140, 72     		; x, y
		dc.w	0,0	 		; anim, frame
		dc.l	ninjaAITable1		; move ai table
		dc.l	ninjaHitTable		; hit ai table
		dc.w	$e0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	ninjaFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	100			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

ninja2Info:
		dc.w	75, 72			; x, y
		dc.w	0,0	 		; anim, frame
		dc.l	ninjaAITable2		; move ai table
		dc.l	ninjaHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	ninjaFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	100			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

ninja3Info:
		dc.w	200, 72			; x, y
		dc.w	0,0	 		; anim, frame
		dc.l	ninjaAITable3		; move ai table
		dc.l	ninjaHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	ninjaFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	100			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

shuriken1Info:
		dc.w	59, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$e0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

shuriken2Info:
		dc.w	189, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

shuriken3Info:
		dc.w	140, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter

shuriken4Info:
		dc.w	140, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter


shuriken5Info:
		dc.w	140, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter

shuriken6Info:
		dc.w	140, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shurikenFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter


knives1Info:
		dc.w	133, 87			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	knivesFile			; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter
knives2Info:
		dc.w	213, 87			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	knivesFile			; file for monster
		dc.w	40			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter
knives3Info:
		dc.w	173, 87			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	knivesFile			; file for monster
		dc.w	40			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter
knives4Info:
		dc.w	93, 87			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	knivesFile			; file for monster
		dc.w	40			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter

knives5Info:
		dc.w	53, 87			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	knivesFile			; file for monster
		dc.w	40			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$b0
		dc.l	0
		dc.w	0			; current loop counter

wyvern1Info:
		dc.w	150,100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	wyvernAIMainTable1	; move ai table
		dc.l	wyvernHitTable1		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	wyvernFile		; file for monster
		dc.w	40			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

znjaInfo:
		dc.w	150, 140			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	znjaAITable1		; move ai table
		dc.l	znjaHitTable1		; hit ai table
		dc.w	$d0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	znjaFile		; file for monster
		dc.w	50			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$d0
		dc.l	0
		dc.w	0			; current loop counter
wyvern2Info:
		dc.w	110, 150		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	wyvernAITable2		; move ai table
		dc.l	wyvernHitTable2		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	wyvernFile		; file for monster
		dc.w	50			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

wyvern3Info:
		dc.w	190, 150		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	wyvernAITable3		; move ai table
		dc.l	wyvernHitTable3		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	wyvernFile		; file for monster
		dc.w	70			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

sami1Info:
		dc.w	160, 112		; x, y relative to screen
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable1		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	120			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

sami2Info:
		dc.w	180, 112  		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable2		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; VDP flags
		dc.l	samiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

sami3Info:
		dc.w	130, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable2		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; VDP flags
		dc.l	samiFile		; file for monster
		dc.w	190			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

sami4Info:
		dc.w	170, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable1		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter

sami5Info:
		dc.w	200, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable1		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter
sami6Info:
		dc.w	190, 120		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable2		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	80			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter
sami7Info:
		dc.w	175, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAIMainTable	; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$40			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	120			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai flags
		dc.w	$40
		dc.l	0
		dc.w	0			; current loop counter
sami8Info:
		dc.w	-50, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable8		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$90			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	20			; hit points
		dc.w	0			; ai flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter
sami9Info:
		dc.w	350, 96			; x, y
		dc.w	0,0	 		; anim, frame
		dc.l	samiAITable9		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$c0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	60			; counter
		dc.w	60			; temp counter
		dc.w	20			; hit points
		dc.w	0			; ai flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter
sami10Info:
		dc.w	350, 96			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	samiAITable10		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	20			; hit points
		dc.w	0			; ai flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter

sami11Info:
		dc.w	-50, 96			; x, y
		dc.w	0,0	 		; anim, frame
		dc.l	samiAITable11		; move ai table
		dc.l	samiHitTable		; hit ai table
		dc.w	$b0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	samiFile		; file for monster
		dc.w	80			; counter
		dc.w	80			; temp counter
		dc.w	20			; hit points
		dc.w	0			; ai flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter

samiAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	samiAIMainTable
		dc.b	0,0

samiAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	samiAIMainTable
		dc.b	0,0

samiAIMainTable:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	20			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

samiAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

samiAITableLoop8:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$18			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; down to .5 times size
		dc.w	$18			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	200			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$18			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; down to .5 times size
		dc.w	$18			; scale sub value

		dc.b	AI_GOTO, 0
		dc.l	samiAITableLoop8
		dc.b	0,0

samiAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

samiAITableLoop9:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	60			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$10			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; down to .5 times size
		dc.w	$10			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	160			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$10			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; down to .5 times size
		dc.w	$10			; scale sub value

		dc.b	AI_GOTO, 0
		dc.l	samiAITableLoop9
		dc.b	0,0

samiAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

samiAITableLoop10:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	240			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	100			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_GOTO, 0
		dc.l	samiAITableLoop10
		dc.b	0,0

samiAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

samiAITableLoop11:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	240			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; up to 2.00 times size
		dc.w	$0c			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst2a		; pointer to monster list
		dc.b	0,0

		dc.b	AI_NULL, 0
		dc.b	0,0,0,0,0,0		; filler

samiHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

ninjaAITable1:
ninjaAITable2:
ninjaAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

ninjaAITableLoop1:
		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$e4			; up to 2.00 times size
		dc.w	$200			; scale add value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	1000			; 1000 pixels at a time

		dc.b	AI_MOVEBACK|$80, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$e0			; down 
		dc.w	$1			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	-1			; loops for attack
		dc.w	60			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l4_sprlst11a		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEBACK|$80, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$DC			; down 
		dc.w	$1			; scale add value

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$104			; up to 2.00 times size
		dc.w	$200			; scale add value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	220			; moveto x position
		dc.w	-1
		dc.w	1000			; 1000 pixels at a time

		dc.b	AI_MOVEBACK|$80, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$100			; down 
		dc.w	$1			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	-1			; loops for attack
		dc.w	60			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l4_sprlst11b		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEBACK, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$FC			; down 
		dc.w	$1			; scale add value

		dc.b	AI_GOTO, 0
		dc.l	ninjaAITableLoop1
		dc.b	0,0

ninjahitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$10000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

hydraAITable:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

hydraAIMainTable:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$160			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	20			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$e0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$160			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	40			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$e0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	220			; moveto x position
		dc.w	-1
		dc.w	6			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$160			; up to 2.00 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	20			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$e0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	150			; moveto x position
		dc.w	-1
		dc.w	6			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	hydraAIMainTable
		dc.b	0,0

hydrahitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$100000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


lionAITable1:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	20			; wait before next ai type
		dc.b	0,0,0,0			; filler

lionAIMainTable1:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	70			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$280			; up to 1.50 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE
		dc.w	2
		dc.w	$f0
		dc.w	$15
		
		dc.b	AI_GOTO, 0
		dc.l	lionAITable1
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

lionHitTable1:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$2500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


lionAITable2:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	40			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	250			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; up to times size
		dc.w	$10			; scale add value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$190			; up to times size
		dc.w	$10			; scale add value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	120			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$280			; up to times size
		dc.w	$10			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE
		dc.w	2
		dc.w	$f0
		dc.w	$15

		dc.b	AI_GOTO, 0
		dc.l	lionAITable2
		dc.b	0,0
		
		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

lionHitTable2:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$2500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


lionAITable3:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	20			; wait before next ai type
		dc.b	0,0,0,0			; filler

lionAIMainTable3:
		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	120			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; up to times size
		dc.w	$10			; scale add value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	270			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$280			; up to 1.50 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE
		dc.w	2
		dc.w	$f0
		dc.w	$15

		dc.b	AI_GOTO, 0
		dc.l	lionAITable3
		dc.b	0,0
		
		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

lionHitTable3:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$2500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters



wyvernAITable1:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	20			; wait before next ai type
		dc.b	0,0,0,0			; filler

wyvernAIMainTable1:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

		dc.b	AI_STATIC, AIST_FORNUM
		dc.w	1			; wait 'till 1 monster
		dc.b	0,0,0,0			; filler

wyvernAIAttackLoop:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$80			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_GOTO, 0
		dc.l	wyvernAIAttackLoop
		dc.b	0,0

wyvernHitTable1:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$7500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


wyvernAITable2:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	40			; wait before next ai type
		dc.b	0,0,0,0			; filler

wyvernAIMainTable2:
wyvern2LowBound1:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

wyvern2HighBound1:
wyvern2RetreatTable1:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	2			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	250			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

wyvern2LowBound2:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

wyvern2HighBound2:
wyvern2RetreatTable2:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	wyvernAIMainTable2
		dc.b	0,0

wyvernHitTable2:
		dc.b	AI_DIE, AIDI_RETREAT	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.l	wyvern2RetreatBounds

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$7500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

wyvernAITable3:
		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

wyvernAIMainTable3:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

wyvern3LowBound1:
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	2			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage
wyvern3HighBound1:

wyvern3RetreatTable1:
		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	60			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	1			; 30 frames a second
		dc.w	$140			; up to 1.50 times size
		dc.w	$20			; scale add value

wyvern3LowBound2:
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage
wyvern3HighBound2:

wyvern3RetreatTable2:
		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$a0			; down to .5 times size
		dc.w	$20			; scale sub value

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	200			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	wyvernAIMainTable3
		dc.b	0,0

wyvernHitTable3:
		dc.b	AI_DIE, AIDI_RETREAT	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.l	wyvern3RetreatBounds

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$7500			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


gargoyleAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	20			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	gargoyleAIMainTable1
		dc.b	0,0

gargoyleAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	gargoyleAIMainTable2
		dc.b	0,0

gargoyleAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	80			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	gargoyleAIMainTable2
		dc.b	0,0

gargoyleAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	100			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	gargoyleAIMainTable1
		dc.b	0,0

gargoyleAIMainTable1:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$240			; up to 2.00 times size
		dc.w	$10			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

gargoyleAIMainTable2:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$240			; up to 2.00 times size
		dc.w	$20			; scale add value little slower

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

gargoyleHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$1000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

knivesAITable:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$280			; one time
		dc.w	$28			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	-1			; loops for attack
		dc.w	60			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

knivesHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$100			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

znjaAITable1:
		dc.b	AI_WAIT, AIWAIT_STATIC
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

znjaAttackTable1:
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7a		; pointer to monster list
		dc.b	0,0

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7c		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	230			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7b		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7c		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	150			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7a		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	110			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7d		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	70			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7e		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	110			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, 0
		dc.l	l2_sprlst7d		; pointer to monster list
		dc.b	0,0


		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	150			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	znjaAttackTable1
		dc.b	0,0

znjaHitTable1:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$50000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

aboxMainAITable1:
		dc.b	AI_STATIC, AIST_FIXEDST	; stay fixed to wall position
		dc.b	0,0,0,0,0,0		; filler

aboxHitAITable1:
		dc.b	AI_WAIT, AIWAIT_EXPOSE	; expose
		dc.l	aboxFile		; what to expose
		dc.b	0,0			; filler

		dc.b	AI_DIE, AIDI_ADDAMMO	; ai type, sub-type
		dc.w	1			; 1 clip per hit
		dc.w	2			; two hits max
		dc.b	0,0			; filler

		dc.b	AI_SETANIM, 0
		dc.w	3			; animation #
		dc.w	0			; frame #
		dc.b	0,0

		dc.b	AI_STATIC, AIST_FIXEDST	; stay fixed to wall position
		dc.b	0,0,0,0,0,0		; filler



wyvern2RetreatBounds:
		dc.w	2			; number of bounds
		dc.l	wyvern2RetreatTable1	; if in bounds go here
		dc.l	wyvern2LowBound1
		dc.l	wyvern2HighBound1	; must be in range to retreat
		dc.l	wyvern2RetreatTable2	; if in bounds go here
		dc.l	wyvern2LowBound2
		dc.l	wyvern2HighBound2	; must be in range to retreat

wyvern3RetreatBounds:
		dc.w	2			; number of bounds
		dc.l	wyvern3RetreatTable1	; if in bounds go here
		dc.l	wyvern3LowBound1
		dc.l	wyvern3HighBound1	; must be in range to retreat
		dc.l	wyvern3RetreatTable2	; if in bounds go here
		dc.l	wyvern3LowBound2
		dc.l	wyvern3HighBound2	; must be in range to retreat

ChompSnd	dc.l	Pterodactile_Scream
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

RoarSnd		dc.l	Lion_Roar			
		dc.w	ATTACKING		; animation #
		dc.w	0			; frame #
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type



		include	globals.i

		end
