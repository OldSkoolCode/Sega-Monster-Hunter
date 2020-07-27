; $Log: lvl2map.s_v $
;Revision 1.7  1993/07/08  15:26:42  KENH
;*** empty log message ***
;
;Revision 1.6  1993/07/08  15:24:27  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/14  20:24:28  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/07  19:56:52  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/02  07:09:09  KENH
;*** empty log message ***
;
;Revision 1.2  1993/05/13  23:06:40  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:48:49  KENH
;Initial revision
;
		include	soundeqs.i

		section	.data

Level2Map:
		dc.w	0,0
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst1
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst2
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst3
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 9
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst4
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst5
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst6
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst5
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst7
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst8
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst14
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 16
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst15
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst16
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst17
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst16
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 28
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst10
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 30
		dc.l	0
		dc.l	0

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 31
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst11
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 33
		dc.l	0
		dc.l	0

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst12
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 10
		dc.l	0
		dc.w	RIGHT
		dc.w	0    
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst10
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites


		dc.w	0, 13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst12
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 24
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 25
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 26
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst11
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 10
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst12
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 16
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst10
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l2_sprlst18
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites


		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	ENDOFLEVEL
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	gotoNextLevel

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 16
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 4
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 9
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0


		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 10
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 14
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 16
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 2
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	0

		dc.w	0, 6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0


l2_sprlst1:
		dc.w	3
		dc.l	icebeat1Info
		dc.l	icebeat2Info
		dc.l	icebeat3Info
		dc.w	4
		dc.l	icebeat4Info
		dc.l	icebeat5Info
		dc.l	icebeat6Info
		dc.l	icebeat7Info
		dc.w	4
		dc.l	icebeat8Info
		dc.l	icebeat9Info
		dc.l	icebeat10Info
		dc.l	icebeat11Info
		dc.w	0

l2_sprlst2:
		dc.w	4
		dc.l	icebeat1Info
		dc.l	icebeat2Info
		dc.l	icebeat3Info
		dc.l	icebeat4Info
		dc.w	3
		dc.l	icebeat5Info
		dc.l	icebeat6Info
		dc.l	icebeat12Info
		dc.w	5
		dc.l	icebeat8Info
		dc.l	icebeat9Info
		dc.l	icebeat10Info
		dc.l	icebeat11Info
		dc.l	icebeat14Info
		dc.w	0


l2_sprlst3:
		dc.w	4
		dc.l	icebeat1Info
		dc.l	icebeat2Info
		dc.l	icebeat10Info
		dc.l	icebeat11Info
		dc.w	4
		dc.l	icebeat5Info
		dc.l	icebeat12Info
		dc.l	icebeat7Info
		dc.l	icebeat8Info
		dc.w	3
		dc.l	icebeat13Info
		dc.l	icebeat7Info
		dc.l	icebeat14Info
		dc.w	0

l2_sprlst4:
		dc.w	2
		dc.l	icebeat6Info
		dc.l	icebeat1Info
		dc.w	5
		dc.l	icebeat12Info
		dc.l	icebeat7Info
		dc.l	icebeat8Info
		dc.l	icebeat9Info
		dc.l	icebeat12Info
		dc.w	3
		dc.l	icebeat2Info
		dc.l	icebeat12Info
		dc.l	icebeat3Info
		dc.w	5
		dc.l	icebeat14Info
		dc.l	icebeat10Info
		dc.l	icebeat6Info
		dc.l	icebeat13Info
		dc.l	icebeat12Info
		dc.w	3
		dc.l	icebeat15Info
		dc.l	icebeat9Info
		dc.l	icebeat12Info
		dc.w	0

l2_sprlst5:
		dc.w	3
		dc.l	yeti1Info
		dc.l	yeti2Info
		dc.l	yeti3Info
		dc.w	4
		dc.l	yeti4Info
		dc.l	yeti5Info
		dc.l	yeti6Info
		dc.l	yeti7Info
		dc.w	4
		dc.l	yeti8Info
		dc.l	yeti9Info
		dc.l	yeti10Info
		dc.l	yeti11Info
		dc.w	0


l2_sprlst6:
		dc.w	4
		dc.l	yeti1Info
		dc.l	yeti2Info
		dc.l	yeti3Info
		dc.l	yeti4Info
		dc.w	3
		dc.l	yeti5Info
		dc.l	yeti6Info
		dc.l	yeti12Info
		dc.w	5
		dc.l	yeti8Info
		dc.l	yeti9Info
		dc.l	yeti10Info
		dc.l	yeti11Info
		dc.l	yeti14Info
		dc.w	0

l2_sprlst7:
		dc.w	4
		dc.l	yeti1Info
		dc.l	yeti2Info
		dc.l	yeti10Info
		dc.l	yeti11Info
		dc.w	4
		dc.l	yeti5Info
		dc.l	yeti12Info
		dc.l	yeti7Info
		dc.l	yeti8Info
		dc.w	3
		dc.l	yeti13Info
		dc.l	yeti7Info
		dc.l	yeti14Info
		dc.w	0

l2_sprlst8:
		dc.w	2
		dc.l	yeti6Info
		dc.l	yeti1Info
		dc.w	5
		dc.l	yeti12Info
		dc.l	yeti7Info
		dc.l	yeti8Info
		dc.l	yeti9Info
		dc.l	yeti12Info
		dc.w	3
		dc.l	yeti2Info
		dc.l	yeti12Info
		dc.l	yeti3Info
		dc.w	5
		dc.l	yeti14Info
		dc.l	yeti10Info
		dc.l	yeti6Info
		dc.l	yeti13Info
		dc.l	yeti12Info
		dc.w	3
		dc.l	yeti15Info
		dc.l	yeti9Info
		dc.l	yeti12Info
		dc.w	0
   
l2_sprlst9:
		dc.w	3
		dc.l	nomad1Info
		dc.l	nomad2Info
		dc.l	nomad3Info
		dc.w	4
		dc.l	nomad8Info
		dc.l	nomad9Info
		dc.l	nomad10Info
		dc.l	nomad11Info
		dc.w	4
		dc.l	nomad5Info
		dc.l	nomad12Info
		dc.l	nomad7Info
		dc.l	nomad8Info
		dc.w	0

l2_sprlst10:
		dc.w	4
		dc.l	nomad1Info
		dc.l	nomad2Info
		dc.l	nomad3Info
		dc.l	nomad4Info
		dc.w	3
		dc.l	nomad5Info
		dc.l	nomad6Info
		dc.l	nomad12Info
		dc.w	4
		dc.l	nomad4Info
		dc.l	nomad5Info
		dc.l	nomad6Info
		dc.l	nomad7Info
		dc.w	0

l2_sprlst11:
		dc.w	4
		dc.l	nomad1Info
		dc.l	nomad2Info
		dc.l	nomad10Info
		dc.l	nomad11Info
		dc.w	5
		dc.l	nomad8Info
		dc.l	nomad9Info
		dc.l	nomad10Info
		dc.l	nomad11Info
		dc.l	nomad14Info
		dc.w	3
		dc.l	nomad2Info
		dc.l	nomad12Info
		dc.l	nomad3Info
		dc.w	0

l2_sprlst12:
		dc.w	2
		dc.l	nomad6Info
		dc.l	nomad1Info
		dc.w	5
		dc.l	nomad12Info
		dc.l	nomad7Info
		dc.l	nomad8Info
		dc.l	nomad9Info
		dc.l	nomad12Info
		dc.w	3
		dc.l	nomad13Info
		dc.l	nomad7Info
		dc.l	nomad14Info
		dc.w	5
		dc.l	nomad14Info
		dc.l	nomad10Info
		dc.l	nomad6Info
		dc.l	nomad13Info
		dc.l	nomad12Info
		dc.w	3
		dc.l	nomad15Info
		dc.l	nomad9Info
		dc.l	nomad12Info
		dc.w	0

l2_sprlst13:
		dc.w	1
		dc.l	iceprjInfo
		dc.w	0

l2_sprlst14:
		dc.w	1
		dc.l	rhino1Info
;		dc.l	rhino2Info
;		dc.l	rhino10Info
;		dc.l	rhino11Info
		dc.w	5
		dc.l	rhino8Info
		dc.l	rhino9Info
		dc.l	rhino10Info
		dc.l	rhino11Info
		dc.l	rhino14Info
		dc.w	3
		dc.l	rhino2Info
		dc.l	rhino12Info
		dc.l	rhino3Info
		dc.w	0


l2_sprlst15:
		dc.w	4
		dc.l	rhino1Info
		dc.l	rhino2Info
		dc.l	rhino3Info
		dc.l	rhino4Info
		dc.w	3
		dc.l	rhino5Info
		dc.l	rhino6Info
		dc.l	rhino12Info
		dc.w	5
		dc.l	rhino8Info
		dc.l	rhino9Info
		dc.l	rhino10Info
		dc.l	rhino11Info
		dc.l	rhino14Info
		dc.w	0


l2_sprlst16:
		dc.w	2
		dc.l	rhino6Info
		dc.l	rhino1Info
		dc.w	5
		dc.l	rhino12Info
		dc.l	rhino7Info
		dc.l	rhino8Info
		dc.l	rhino9Info
		dc.l	rhino12Info
		dc.w	3
		dc.l	rhino13Info
		dc.l	rhino7Info
		dc.l	rhino14Info
		dc.w	5
		dc.l	rhino14Info
		dc.l	rhino10Info
		dc.l	rhino6Info
		dc.l	rhino13Info
		dc.l	rhino12Info
		dc.w	3
		dc.l	rhino15Info
		dc.l	rhino9Info
		dc.l	rhino12Info
		dc.w	0


l2_sprlst17:
		dc.w	4
		dc.l	rhino15Info
		dc.l	rhino1Info
		dc.l	rhino2Info
		dc.l	rhino3Info
		dc.w	4
		dc.l	rhino4Info
		dc.l	rhino5Info
		dc.l	rhino6Info
		dc.l	rhino7Info
		dc.w	4
		dc.l	rhino8Info
		dc.l	rhino9Info
		dc.l	rhino10Info
		dc.l	rhino11Info
		dc.w	0

l2_sprlst18:
		dc.w	1
		dc.l	PenguinInfo
		dc.w	0

l2_sprlst19:
		dc.w	1
		dc.l	KPproj1Info
		dc.w	0

l2_sprlst20:
		dc.w	1
		dc.l	KPproj2Info
		dc.w	0


l2_sprlst21:
		dc.w	1
		dc.l	SnowBallPrjInfo
		dc.w	0


icebeat1Info:
		dc.w	350, 92			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable1		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat2Info:
		dc.w	340, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable2		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat3Info:
		dc.w	360, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable3		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

icebeat4Info:
		dc.w	-50, 92			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable4		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat5Info:
		dc.w	-60, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable5		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat6Info:
		dc.w	-40, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable6		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat7Info:
		dc.w	-45, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable7		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

icebeat8Info:
		dc.w	340, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable8		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat9Info:
		dc.w	350, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable9		; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat10Info:
		dc.w	-40, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable10	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
icebeat11Info:
		dc.w	-45, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable11	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

icebeat12Info:
		dc.w	-45, 128		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable12	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

icebeat13Info:
		dc.w	350, 132		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable13	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

icebeat14Info:
		dc.w	350, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable14	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


icebeat15Info:
		dc.w	-45, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	icebeatAITable15	; move ai table
		dc.l	icebeatHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	icebeatFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter



Yeti1Info:
		dc.w	290, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable1		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti2Info:
		dc.w	275, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable2		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti3Info:
		dc.w	50, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable3		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Yeti4Info:
		dc.w	70, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable4		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti5Info:
		dc.w	100, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable5		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti6Info:
		dc.w	160, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable6		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti7Info:
		dc.w	230, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable7		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Yeti8Info:
		dc.w	65, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable8		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti9Info:
		dc.w	120, 100		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable9		; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti10Info:
		dc.w	250, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable10	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Yeti11Info:
		dc.w	40, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable11	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Yeti12Info:
		dc.w	265, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable12	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Yeti13Info:
		dc.w	80, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable13	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Yeti14Info:
		dc.w	80, 280			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable14	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


Yeti15Info:
		dc.w	220, 280		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	YetiAITable15	; move ai table
		dc.l	YetiHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	YetiFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	dripSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


;
;
;

Nomad1Info:
		dc.w	290, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable1		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad2Info:
		dc.w	275, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable2		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad3Info:
		dc.w	50, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable3		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Nomad4Info:
		dc.w	70, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable4		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad5Info:
		dc.w	100, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable5		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad6Info:
		dc.w	160, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable6		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad7Info:
		dc.w	230, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable7		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Nomad8Info:
		dc.w	65, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable8		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad9Info:
		dc.w	120, 100		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable9		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad10Info:
		dc.w	250, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable10	; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
Nomad11Info:
		dc.w	40, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable11	; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Nomad12Info:
		dc.w	265, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable12	; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Nomad13Info:
		dc.w	80, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable13	; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

Nomad14Info:
		dc.w	80, 280			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable14		; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


Nomad15Info:
		dc.w	220, 280		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	NomadAITable15	; move ai table
		dc.l	NomadHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	NomadFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	NomadSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


iceprjInfo:
		dc.w	0, 0			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	ProjectileAITable	; move ai table
		dc.l	ProjectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	iceprjFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%1000010		; ai/drawing flags
		dc.w	$80 			; lowest scale to back ground
		dc.l	squishSnd		; pointer to sound effect struct
		dc.w	0			; current loop counter



;
; ----- rhino tables
;

rhino1Info:
		dc.w	290, 120		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable1		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino2Info:
		dc.w	275, 124		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable2		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino3Info:
		dc.w	50, 126			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable3		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

rhino4Info:
		dc.w	70, 132			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable4		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino5Info:
		dc.w	100, 120		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable5		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino6Info:
		dc.w	160, 120     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable6		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino7Info:
		dc.w	230, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable7		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

rhino8Info:
		dc.w	65, 120			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable8		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino9Info:
		dc.w	120, 126		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable9		; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino10Info:
		dc.w	250, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable10	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
rhino11Info:
		dc.w	40, 120			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable11	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

rhino12Info:
		dc.w	265, 128		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable12	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

rhino13Info:
		dc.w	80, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable13	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

rhino14Info:
		dc.w	80, 124			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable14	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


rhino15Info:
		dc.w	220, 132		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	rhinoAITable15	; move ai table
		dc.l	rhinoHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	rhinoFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	rhinoSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


PenguinInfo:
		dc.w	350, 108			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	PenguinAIMainTable	; move ai table
		dc.l	PenguinHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	PenguinFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%100000000010		; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter


kpproj1Info:
		dc.w	350, 152			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	projectileAITable	; move ai table
		dc.l	projectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shproj1File		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$180			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter

kpproj2Info:
		dc.w	350, 152			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	projectileAITable	; move ai table
		dc.l	projectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	shproj2File		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$180			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter


snowBallPrjInfo:
		dc.w	350, 152			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	projectileAITable	; move ai table
		dc.l	projectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	snowprjFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%1000010		; ai/drawing flags
		dc.w	$180			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter



icebeatAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0



icebeatAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	70			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0

icebeatAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	90			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0

icebeatAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	200			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0

icebeatAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	210			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0


icebeatAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0


icebeatAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	220			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0


icebeatAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	250			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0


icebeatAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	210			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0


icebeatAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0


icebeatAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	170			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0


icebeatAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	50			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0


icebeatAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	240			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0

icebeatAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	260			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable2
		dc.b	0,0

icebeatAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	icebeatAIMainTable1
		dc.b	0,0


icebeatAIMainTable1:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst13		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	350			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


icebeatAIMainTable2:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst13		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-50			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

icebeatHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$1000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- junk droid's AI lists
;
;


YetiAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable
		dc.b	0,0

YetiAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable
		dc.b	0,0

YetiAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable
		dc.b	0,0

YetiAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable2
		dc.b	0,0

YetiAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable2
		dc.b	0,0


YetiAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable2
		dc.b	0,0


YetiAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable3
		dc.b	0,0


YetiAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable4
		dc.b	0,0


YetiAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable3
		dc.b	0,0


YetiAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable4
		dc.b	0,0


YetiAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable3
		dc.b	0,0


YetiAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable3
		dc.b	0,0


YetiAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable4
		dc.b	0,0

YetiAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler


		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


YetiAITable15:

		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler


YetiAIMainTable15A:
		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	YetiAIMainTable15A
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 1 attack
;

YetiAIMainTable:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	$100			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

;
; ----- 2 attacks
;

YetiAIMainTable2:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

;
; ----- 3 attacks
;
YetiAIMainTable3:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 4 attacks
;
YetiAIMainTable4:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


YetiHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$2000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters



;
; ----- Nomad droid's AI lists
;
;


NomadAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0

NomadAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0

NomadAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0

NomadAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0

NomadAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler


		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


NomadAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	NomadAIMainTable
		dc.b	0,0


;
; ----- 1 attack
;

NomadAIMainTable

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l2_sprlst13		; pointer to monster list
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

NomadHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$4000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


projectileAITable:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$200			; one time
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	-1			; time for attack
		dc.w	150			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

projectileHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$100			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters



;
; ----- rhino's AI lists
;
;


rhinoAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0

rhinoAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0

rhinoAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0

rhinoAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0

rhinoAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0


rhinoAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0


rhinoAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0


rhinoAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0


rhinoAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable1
		dc.b	0,0


rhinoAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	rhinoAIMainTable2
		dc.b	0,0


;
; ----- 1 attack
;

rhinoAIMainTable1:

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	4			; moveto x position
		dc.w	0
		dc.w	25			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD|$80, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; NO damage

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	-4			; moveto x position
		dc.w	-4
		dc.w	2			; 4 pixels at a time

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	-4			; moveto x position
		dc.w	0
		dc.w	23			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; NO damage

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	4			; moveto x position
		dc.w	4
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	4			; moveto x position
		dc.w	0
		dc.w	8			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 1 attack
;

rhinoAIMainTable2:

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	-4			; moveto x position
		dc.w	0
		dc.w	25			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD|$80, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; NO damage

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	4			; moveto x position
		dc.w	4
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	4			; moveto x position
		dc.w	0
		dc.w	21			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; NO damage

		dc.b	AI_SETSTRUCTURE, AISS_OR
		dc.w	MONSTERAIFLAGS
		dc.w	%100			; sorry not killable right now
		dc.b	0,0

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	-4			; moveto x position
		dc.w	4
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEREL, AIMA_ANIMATE
		dc.w	-4			; moveto x position
		dc.w	0
		dc.w	8			; 4 pixels at a time


		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_SETSTRUCTURE, AISS_AND
		dc.w	MONSTERAIFLAGS
		dc.w	~%100			; killable now
		dc.b	0,0

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters



rhinoHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$5000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


PenguinAIMainTable:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


PenguinAttLoop:
		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	150			; damage

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; down to .5 times size
		dc.w	$18			; scale sub value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	260			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	150			; damage

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	100			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_MOVEBACK, AIMB_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$A0			; down to .5 times size
		dc.w	$30			; scale sub value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_GOTO, 0
		dc.l	PenguinAttLoop
		dc.b	0,0


PenguinHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$20000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

dripSnd		dc.l	DRIPPING_SOUND	
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


spitSnd		dc.l	SMOKE_WIFF	
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


NomadSnd	dc.l	BOUNCING_BRAIN
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

squishSnd	dc.l	ALIEN_SQUISH
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

rhinoSnd	dc.l	Pterodactle_Scream
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


lvl2b2Strip:
		dc.l	WALLL2B1FILE
		dc.w	6			; number of strips
;
;			dest Y/ width/height/source Y/MapA=0-MapB=1/speed/priority
;
		dc.w	4,80,8,0,1,1,0
		dc.w	4,80,8,8,0,1,0
		dc.w	12,40,2,16,1,2,0
		dc.w	13,40,2,18,0,4,0
		dc.w	14,40,3,20,1,6,1
		dc.w	15,40,3,23,0,8,1


		include	globals.i

		end
