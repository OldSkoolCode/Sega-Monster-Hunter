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

Level3Map:
		dc.w	0,0
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l3_sprlst1
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
		dc.l	l3_sprlst2
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
		dc.l	l3_sprlst3
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
		dc.l	l3_sprlst4
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
		dc.l	l3_sprlst14
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
		dc.l	l3_sprlst15
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
		dc.l	l3_sprlst16
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
		dc.l	l3_sprlst17
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
		dc.l	l3_sprlst16
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
		dc.l	l3_sprlst10
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
		dc.l	l3_sprlst11
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
		dc.l	l3_sprlst12
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
		dc.l	l3_sprlst10
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
		dc.l	l3_sprlst12
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
		dc.l	l3_sprlst11
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
		dc.l	l3_sprlst12
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
		dc.l	l3_sprlst10
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
		dc.l	l3_sprlst18
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


l3_sprlst1:
		dc.w	3
		dc.l	crab1Info
		dc.l	crab2Info
		dc.l	crab3Info
		dc.w	4
		dc.l	crab4Info
		dc.l	crab5Info
		dc.l	crab6Info
		dc.l	crab7Info
		dc.w	4
		dc.l	crab8Info
		dc.l	crab9Info
		dc.l	crab10Info
		dc.l	crab11Info
		dc.w	0

l3_sprlst2:
		dc.w	4
		dc.l	crab1Info
		dc.l	crab2Info
		dc.l	crab3Info
		dc.l	crab4Info
		dc.w	3
		dc.l	crab5Info
		dc.l	crab6Info
		dc.l	crab12Info
		dc.w	5
		dc.l	crab8Info
		dc.l	crab9Info
		dc.l	crab10Info
		dc.l	crab11Info
		dc.l	crab14Info
		dc.w	0


l3_sprlst3:
		dc.w	4
		dc.l	crab1Info
		dc.l	crab2Info
		dc.l	crab10Info
		dc.l	crab11Info
		dc.w	4
		dc.l	crab5Info
		dc.l	crab12Info
		dc.l	crab7Info
		dc.l	crab8Info
		dc.w	3
		dc.l	crab13Info
		dc.l	crab7Info
		dc.l	crab14Info
		dc.w	0

l3_sprlst4:
		dc.w	2
		dc.l	crab6Info
		dc.l	crab1Info
		dc.w	5
		dc.l	crab12Info
		dc.l	crab7Info
		dc.l	crab8Info
		dc.l	crab9Info
		dc.l	crab12Info
		dc.w	3
		dc.l	crab2Info
		dc.l	crab12Info
		dc.l	crab3Info
		dc.w	5
		dc.l	crab14Info
		dc.l	crab10Info
		dc.l	crab6Info
		dc.l	crab13Info
		dc.l	crab12Info
		dc.w	3
		dc.l	crab15Info
		dc.l	crab9Info
		dc.l	crab12Info
		dc.w	0

l3_sprlst9:
		dc.w	3
		dc.l	golem1Info
		dc.l	golem2Info
		dc.l	golem3Info
		dc.w	4
		dc.l	golem8Info
		dc.l	golem9Info
		dc.l	golem10Info
		dc.l	golem11Info
		dc.w	4
		dc.l	golem5Info
		dc.l	golem12Info
		dc.l	golem7Info
		dc.l	golem8Info
		dc.w	0

l3_sprlst10:
		dc.w	4
		dc.l	golem1Info
		dc.l	golem2Info
		dc.l	golem3Info
		dc.l	golem4Info
		dc.w	3
		dc.l	golem5Info
		dc.l	golem6Info
		dc.l	golem12Info
		dc.w	4
		dc.l	golem4Info
		dc.l	golem5Info
		dc.l	golem6Info
		dc.l	golem7Info
		dc.w	0

l3_sprlst11:
		dc.w	4
		dc.l	golem1Info
		dc.l	golem2Info
		dc.l	golem10Info
		dc.l	golem11Info
		dc.w	5
		dc.l	golem8Info
		dc.l	golem9Info
		dc.l	golem10Info
		dc.l	golem11Info
		dc.l	golem14Info
		dc.w	3
		dc.l	golem2Info
		dc.l	golem12Info
		dc.l	golem3Info
		dc.w	0

l3_sprlst12:
		dc.w	2
		dc.l	golem6Info
		dc.l	golem1Info
		dc.w	5
		dc.l	golem12Info
		dc.l	golem7Info
		dc.l	golem8Info
		dc.l	golem9Info
		dc.l	golem12Info
		dc.w	3
		dc.l	golem13Info
		dc.l	golem7Info
		dc.l	golem14Info
		dc.w	5
		dc.l	golem14Info
		dc.l	golem10Info
		dc.l	golem6Info
		dc.l	golem13Info
		dc.l	golem12Info
		dc.w	3
		dc.l	golem15Info
		dc.l	golem9Info
		dc.l	golem12Info
		dc.w	0

l3_sprlst13:
		dc.w	1
		dc.l	sandprjInfo
		dc.w	0

l3_sprlst14:
		dc.w	4
		dc.l	sands1Info
		dc.l	sands2Info
		dc.l	sands10Info
		dc.l	sands11Info
		dc.w	5
		dc.l	sands8Info
		dc.l	sands9Info
		dc.l	sands10Info
		dc.l	sands11Info
		dc.l	sands14Info
		dc.w	3
		dc.l	sands2Info
		dc.l	sands12Info
		dc.l	sands3Info
		dc.w	0


l3_sprlst15:
		dc.w	4
		dc.l	sands1Info
		dc.l	sands2Info
		dc.l	sands3Info
		dc.l	sands4Info
		dc.w	3
		dc.l	sands5Info
		dc.l	sands6Info
		dc.l	sands12Info
		dc.w	5
		dc.l	sands8Info
		dc.l	sands9Info
		dc.l	sands10Info
		dc.l	sands11Info
		dc.l	sands14Info
		dc.w	0


l3_sprlst16:
		dc.w	2
		dc.l	sands6Info
		dc.l	sands1Info
		dc.w	5
		dc.l	sands12Info
		dc.l	sands7Info
		dc.l	sands8Info
		dc.l	sands9Info
		dc.l	sands12Info
		dc.w	3
		dc.l	sands13Info
		dc.l	sands7Info
		dc.l	sands14Info
		dc.w	5
		dc.l	sands14Info
		dc.l	sands10Info
		dc.l	sands6Info
		dc.l	sands13Info
		dc.l	sands12Info
		dc.w	3
		dc.l	sands15Info
		dc.l	sands9Info
		dc.l	sands12Info
		dc.w	0


l3_sprlst17:
		dc.w	4
		dc.l	sands15Info
		dc.l	sands1Info
		dc.l	sands2Info
		dc.l	sands3Info
		dc.w	4
		dc.l	sands4Info
		dc.l	sands5Info
		dc.l	sands6Info
		dc.l	sands7Info
		dc.w	4
		dc.l	sands8Info
		dc.l	sands9Info
		dc.l	sands10Info
		dc.l	sands11Info
		dc.w	0

l3_sprlst18:
		dc.w	1
		dc.l	scorpionInfo
		dc.w	0

l3_sprlst21:
		dc.w	1
		dc.l	crabprjInfo
		dc.w	0


crab1Info:
		dc.w	350, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable1		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab2Info:
		dc.w	340, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable2		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab3Info:
		dc.w	360, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable3		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

crab4Info:
		dc.w	-50, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable4		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab5Info:
		dc.w	-60, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable5		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab6Info:
		dc.w	-40, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable6		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab7Info:
		dc.w	-45, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable7		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

crab8Info:
		dc.w	340, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable8		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab9Info:
		dc.w	350, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable9		; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab10Info:
		dc.w	-40, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable10	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
crab11Info:
		dc.w	-45, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable11	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

crab12Info:
		dc.w	-45, 128		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable12	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

crab13Info:
		dc.w	350, 132		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable13	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

crab14Info:
		dc.w	350, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable14	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


crab15Info:
		dc.w	-45, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	crabAITable15	; move ai table
		dc.l	crabHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	spitSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter



;
;
;

golem1Info:
		dc.w	290, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable1		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem2Info:
		dc.w	275, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable2		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem3Info:
		dc.w	50, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable3		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

golem4Info:
		dc.w	70, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable4		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem5Info:
		dc.w	100, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable5		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem6Info:
		dc.w	160, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable6		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem7Info:
		dc.w	230, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable7		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

golem8Info:
		dc.w	65, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable8		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem9Info:
		dc.w	120, 100		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable9		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem10Info:
		dc.w	250, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable10	; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
golem11Info:
		dc.w	40, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable11	; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

golem12Info:
		dc.w	265, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable12	; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

golem13Info:
		dc.w	80, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable13	; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

golem14Info:
		dc.w	80, 280			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable14		; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


golem15Info:
		dc.w	220, 280		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	golemAITable15	; move ai table
		dc.l	golemHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	golemFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	golemSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


crabprjInfo:
		dc.w	0, 0			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	ProjectileAITable	; move ai table
		dc.l	ProjectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	crabprjFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%1000010		; ai/drawing flags
		dc.w	$80 			; lowest scale to back ground
		dc.l	squishSnd		; pointer to sound effect struct
		dc.w	0			; current loop counter


sandprjInfo:
		dc.w	0, 0			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	ProjectileAITable	; move ai table
		dc.l	ProjectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandprjFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%1000010		; ai/drawing flags
		dc.w	$80 			; lowest scale to back ground
		dc.l	squishSnd		; pointer to sound effect struct
		dc.w	0			; current loop counter




;
; ----- sands tables
;

sands1Info:
		dc.w	290, 120		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable1		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands2Info:
		dc.w	275, 124		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable2		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands3Info:
		dc.w	50, 126			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable3		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sands4Info:
		dc.w	70, 132			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable4		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands5Info:
		dc.w	100, 120		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable5		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands6Info:
		dc.w	160, 120     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable6		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands7Info:
		dc.w	230, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable7		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sands8Info:
		dc.w	65, 120			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable8		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands9Info:
		dc.w	120, 126		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable9		; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands10Info:
		dc.w	250, 116     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable10	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sands11Info:
		dc.w	40, 120			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable11	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sands12Info:
		dc.w	265, 128		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable12	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sands13Info:
		dc.w	80, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable13	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sands14Info:
		dc.w	80, 124			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable14	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


sands15Info:
		dc.w	220, 132		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sandsAITable15	; move ai table
		dc.l	sandsHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sandsFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sandsSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


scorpionInfo:
		dc.w	350, 108			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	scorpionAIMainTable	; move ai table
		dc.l	scorpionHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	scorpionFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
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



crabAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable2
		dc.b	0,0



crabAITable2:
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
		dc.l	crabAIMainTable1
		dc.b	0,0

crabAITable3:
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
		dc.l	crabAIMainTable1
		dc.b	0,0

crabAITable4:
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
		dc.l	crabAIMainTable1
		dc.b	0,0

crabAITable5:
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
		dc.l	crabAIMainTable2
		dc.b	0,0


crabAITable6:
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
		dc.l	crabAIMainTable1
		dc.b	0,0


crabAITable7:
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
		dc.l	crabAIMainTable2
		dc.b	0,0


crabAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	250			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable1
		dc.b	0,0


crabAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	210			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable1
		dc.b	0,0


crabAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable2
		dc.b	0,0


crabAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	170			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable1
		dc.b	0,0


crabAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	50			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable2
		dc.b	0,0


crabAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	240			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable1
		dc.b	0,0

crabAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	260			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable2
		dc.b	0,0

crabAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	crabAIMainTable1
		dc.b	0,0


crabAIMainTable1:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l3_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	350			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


crabAIMainTable2:

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l3_sprlst21		; pointer to monster list
		dc.b	0,0

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	-50			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

crabHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$1000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- golem droid's AI lists
;
;


golemAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0

golemAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0

golemAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0

golemAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0

golemAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler


		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


golemAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	golemAIMainTable
		dc.b	0,0


;
; ----- 1 attack
;

golemAIMainTable

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l3_sprlst13		; pointer to monster list
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

golemHitTable:
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
; ----- sands's AI lists
;
;


sandsAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0

sandsAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0

sandsAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0

sandsAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0

sandsAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0


sandsAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0


sandsAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0


sandsAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0


sandsAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable1
		dc.b	0,0


sandsAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sandsAIMainTable2
		dc.b	0,0


;
; ----- 1 attack
;

sandsAIMainTable1:

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

sandsAIMainTable2:

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



sandsHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$5000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


scorpionAIMainTable:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


scorpionAttLoop:
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
		dc.l	scorpionAttLoop
		dc.b	0,0


scorpionHitTable:
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


golemSnd	dc.l	BOUNCING_BRAIN
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

squishSnd	dc.l	ALIEN_SQUISH
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

sandsSnd	dc.l	Pterodactle_Scream
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


lvl3b1Strip:
		dc.l	WALLL3B1FILE
		dc.w	10			; number of strips
;
;			dest Y/ width/height/source Y/MapA=0-MapB=1/speed/priority
;
		dc.w	4,40,4,0,1,1,0
		dc.w	10,40,3,4,1,2,0
		dc.w	6,40,7,7,0,2,0
		dc.w	12,40,2,14,1,3,0
		dc.w	13,40,2,16,0,3,0
		dc.w	15,40,1,17,0,3,0
		dc.w	14,40,4,18,1,4,1
		dc.w	16,40,5,22,0,6,1
		dc.w	19,40,4,27,1,7,1
		dc.w	22,40,4,31,0,8,1

		include	globals.i

		end
