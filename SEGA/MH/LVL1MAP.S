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

Level1Map:
		dc.w	0,0
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l1_sprlst1
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

		dc.w	0, 4
		dc.l	l1_sprlst2
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 21
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

		dc.w	0, 7
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 8
		dc.l	l1_sprlst3
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 9
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 1
		dc.l	l1_sprlst3
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
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
		dc.l	l1_sprlst4
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

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

		dc.w	0, 5
		dc.l	l1_sprlst5
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 10
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 11
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst6
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

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

		dc.w	0, 5
		dc.l	l1_sprlst7
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 10
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

		dc.w	0, 5
		dc.l	l1_sprlst8
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

		dc.w	0, 5
		dc.l	l1_sprlst6
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 16
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst9
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites


		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst10
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites


		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst11
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

		dc.w	0, 5
		dc.l	l1_sprlst12
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

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 29
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst14
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 31
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 32
		dc.l	0
		dc.l	0

		dc.w	0, 5
		dc.l	l1_sprlst15
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

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

		dc.w	0, 10
		dc.l	0
		dc.w	RIGHT
		dc.w	0    
		dc.w	0, 17
		dc.l	0
		dc.l	0

		dc.w	0, 12
		dc.l	l1_sprlst16
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 12
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 19
		dc.l	0
		dc.l	0

		dc.w	0, 13
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	l1_sprlst17
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 15
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 22
		dc.l	0
		dc.l	0

		dc.w	0, 24
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 23
		dc.l	0
		dc.l	0

		dc.w	0, 15
		dc.l	l1_sprlst14
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

		dc.w	0, 26
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
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

		dc.w	0, 15
		dc.l	l1_sprlst18
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 18
		dc.l	0
		dc.l	AddNumSprites

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

		dc.w	0, 0
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, 20
		dc.l	0
		dc.l	0

		dc.w	0, 6
		dc.l	0
		dc.w	ENDOFLEVEL
		dc.w	0
		dc.w	0, 21
		dc.l	0
		dc.l	gotoNextLevel

		dc.w	0, 2
		dc.l	0
		dc.w	RIGHT
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

		dc.w	0, 10
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, 22
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

		dc.w	0, 0
		dc.l	0
		dc.w	ENDOFLEVEL
		dc.w	0
		dc.w	0, 20
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

l1_sprlst1:
		dc.w	3
		dc.l	junkdog1Info
		dc.l	junkdog2Info
		dc.l	junkdog3Info
		dc.w	4
		dc.l	junkdog4Info
		dc.l	junkdog5Info
		dc.l	junkdog6Info
		dc.l	junkdog7Info
		dc.w	4
		dc.l	junkdog8Info
		dc.l	junkdog9Info
		dc.l	junkdog10Info
		dc.l	junkdog11Info
		dc.w	0

l1_sprlst2:
		dc.w	4
		dc.l	junkdog1Info
		dc.l	junkdog2Info
		dc.l	junkdog3Info
		dc.l	junkdog4Info
		dc.w	3
		dc.l	junkdog5Info
		dc.l	junkdog6Info
		dc.l	junkdog12Info
		dc.w	5
		dc.l	junkdog8Info
		dc.l	junkdog9Info
		dc.l	junkdog10Info
		dc.l	junkdog11Info
		dc.l	junkdog14Info
		dc.w	0


l1_sprlst3:
		dc.w	4
		dc.l	junkdog1Info
		dc.l	junkdog2Info
		dc.l	junkdog10Info
		dc.l	junkdog11Info
		dc.w	4
		dc.l	junkdog5Info
		dc.l	junkdog12Info
		dc.l	junkdog7Info
		dc.l	junkdog8Info
		dc.w	3
		dc.l	junkdog13Info
		dc.l	junkdog7Info
		dc.l	junkdog14Info
		dc.w	0

l1_sprlst4:
		dc.w	2
		dc.l	junkdog6Info
		dc.l	junkdog1Info
		dc.w	5
		dc.l	junkdog12Info
		dc.l	junkdog7Info
		dc.l	junkdog8Info
		dc.l	junkdog9Info
		dc.l	junkdog12Info
		dc.w	3
		dc.l	junkdog2Info
		dc.l	junkdog12Info
		dc.l	junkdog3Info
		dc.w	5
		dc.l	junkdog14Info
		dc.l	junkdog10Info
		dc.l	junkdog6Info
		dc.l	junkdog13Info
		dc.l	junkdog12Info
		dc.w	3
		dc.l	junkdog15Info
		dc.l	junkdog9Info
		dc.l	junkdog12Info
		dc.w	0

l1_sprlst5:
		dc.w	4
		dc.l	junkdroid15Info
		dc.l	junkdroid1Info
		dc.l	junkdroid2Info
		dc.l	junkdroid3Info
		dc.w	4
		dc.l	junkdroid4Info
		dc.l	junkdroid5Info
		dc.l	junkdroid6Info
		dc.l	junkdroid7Info
		dc.w	4
		dc.l	junkdroid8Info
		dc.l	junkdroid9Info
		dc.l	junkdroid10Info
		dc.l	junkdroid11Info
		dc.w	0


l1_sprlst6:
		dc.w	4
		dc.l	junkdroid1Info
		dc.l	junkdroid2Info
		dc.l	junkdroid3Info
		dc.l	junkdroid4Info
		dc.w	3
		dc.l	junkdroid5Info
		dc.l	junkdroid6Info
		dc.l	junkdroid12Info
		dc.w	5
		dc.l	junkdroid8Info
		dc.l	junkdroid9Info
		dc.l	junkdroid10Info
		dc.l	junkdroid11Info
		dc.l	junkdroid14Info
		dc.w	0

l1_sprlst7:
		dc.w	4
		dc.l	junkdroid1Info
		dc.l	junkdroid2Info
		dc.l	junkdroid10Info
		dc.l	junkdroid11Info
		dc.w	4
		dc.l	junkdroid5Info
		dc.l	junkdroid12Info
		dc.l	junkdroid7Info
		dc.l	junkdroid8Info
		dc.w	3
		dc.l	junkdroid13Info
		dc.l	junkdroid7Info
		dc.l	junkdroid14Info
		dc.w	0

l1_sprlst8:
		dc.w	2
		dc.l	junkdroid6Info
		dc.l	junkdroid1Info
		dc.w	5
		dc.l	junkdroid12Info
		dc.l	junkdroid7Info
		dc.l	junkdroid8Info
		dc.l	junkdroid9Info
		dc.l	junkdroid12Info
		dc.w	3
		dc.l	junkdroid2Info
		dc.l	junkdroid12Info
		dc.l	junkdroid3Info
		dc.w	5
		dc.l	junkdroid14Info
		dc.l	junkdroid10Info
		dc.l	junkdroid6Info
		dc.l	junkdroid13Info
		dc.l	junkdroid12Info
		dc.w	3
		dc.l	junkdroid15Info
		dc.l	junkdroid9Info
		dc.l	junkdroid12Info
		dc.w	0

l1_sprlst9:
		dc.w	3
		dc.l	sludge1Info
		dc.l	sludge2Info
		dc.l	sludge3Info
		dc.w	4
		dc.l	sludge8Info
		dc.l	sludge9Info
		dc.l	sludge10Info
		dc.l	sludge11Info
		dc.w	4
		dc.l	sludge5Info
		dc.l	sludge12Info
		dc.l	sludge7Info
		dc.l	sludge8Info
		dc.w	0

l1_sprlst10:
		dc.w	4
		dc.l	sludge1Info
		dc.l	sludge2Info
		dc.l	sludge3Info
		dc.l	sludge4Info
		dc.w	3
		dc.l	sludge5Info
		dc.l	sludge6Info
		dc.l	sludge12Info
		dc.w	4
		dc.l	sludge4Info
		dc.l	sludge5Info
		dc.l	sludge6Info
		dc.l	sludge7Info
		dc.w	0

l1_sprlst11:
		dc.w	4
		dc.l	sludge1Info
		dc.l	sludge2Info
		dc.l	sludge10Info
		dc.l	sludge11Info
		dc.w	5
		dc.l	sludge8Info
		dc.l	sludge9Info
		dc.l	sludge10Info
		dc.l	sludge11Info
		dc.l	sludge14Info
		dc.w	3
		dc.l	sludge2Info
		dc.l	sludge12Info
		dc.l	sludge3Info
		dc.w	0

l1_sprlst12:
		dc.w	2
		dc.l	sludge6Info
		dc.l	sludge1Info
		dc.w	5
		dc.l	sludge12Info
		dc.l	sludge7Info
		dc.l	sludge8Info
		dc.l	sludge9Info
		dc.l	sludge12Info
		dc.w	3
		dc.l	sludge13Info
		dc.l	sludge7Info
		dc.l	sludge14Info
		dc.w	5
		dc.l	sludge14Info
		dc.l	sludge10Info
		dc.l	sludge6Info
		dc.l	sludge13Info
		dc.l	sludge12Info
		dc.w	3
		dc.l	sludge15Info
		dc.l	sludge9Info
		dc.l	sludge12Info
		dc.w	0

l1_sprlst13:
		dc.w	1
		dc.l	sludgeprjInfo
		dc.w	0

l1_sprlst14:
		dc.w	4
		dc.l	Vulture1Info
		dc.l	Vulture2Info
		dc.l	Vulture10Info
		dc.l	Vulture11Info
		dc.w	5
		dc.l	Vulture8Info
		dc.l	Vulture9Info
		dc.l	Vulture10Info
		dc.l	Vulture11Info
		dc.l	Vulture14Info
		dc.w	3
		dc.l	Vulture2Info
		dc.l	Vulture12Info
		dc.l	Vulture3Info
		dc.w	0


l1_sprlst15:
		dc.w	4
		dc.l	Vulture1Info
		dc.l	Vulture2Info
		dc.l	Vulture3Info
		dc.l	Vulture4Info
		dc.w	3
		dc.l	Vulture5Info
		dc.l	Vulture6Info
		dc.l	Vulture12Info
		dc.w	5
		dc.l	Vulture8Info
		dc.l	Vulture9Info
		dc.l	Vulture10Info
		dc.l	Vulture11Info
		dc.l	Vulture14Info
		dc.w	0


l1_sprlst16:
		dc.w	2
		dc.l	vulture6Info
		dc.l	vulture1Info
		dc.w	5
		dc.l	vulture12Info
		dc.l	vulture7Info
		dc.l	vulture8Info
		dc.l	vulture9Info
		dc.l	vulture12Info
		dc.w	3
		dc.l	vulture13Info
		dc.l	vulture7Info
		dc.l	vulture14Info
		dc.w	5
		dc.l	vulture14Info
		dc.l	vulture10Info
		dc.l	vulture6Info
		dc.l	vulture13Info
		dc.l	vulture12Info
		dc.w	3
		dc.l	vulture15Info
		dc.l	vulture9Info
		dc.l	vulture12Info
		dc.w	0


l1_sprlst17:
		dc.w	4
		dc.l	vulture15Info
		dc.l	vulture1Info
		dc.l	vulture2Info
		dc.l	vulture3Info
		dc.w	4
		dc.l	vulture4Info
		dc.l	vulture5Info
		dc.l	vulture6Info
		dc.l	vulture7Info
		dc.w	4
		dc.l	vulture8Info
		dc.l	vulture9Info
		dc.l	vulture10Info
		dc.l	vulture11Info
		dc.w	0

l1_sprlst18:
		dc.w	1
		dc.l	stnkHeapInfo
		dc.w	0


l1_sprlst19:
		dc.w	1
		dc.l	shproj1Info
		dc.w	0

l1_sprlst20:
		dc.w	1
		dc.l	shproj2Info
		dc.w	0

junkdog1Info:
		dc.w	350, 108		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable1		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog2Info:
		dc.w	340, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable2		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog3Info:
		dc.w	360, 108		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable3		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdog4Info:
		dc.w	-50, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable4		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog5Info:
		dc.w	-60, 108		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable5		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog6Info:
		dc.w	-40, 112     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable6		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog7Info:
		dc.w	-45, 108		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable7		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdog8Info:
		dc.w	340, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable8		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog9Info:
		dc.w	350, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable9		; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog10Info:
		dc.w	-40, 112     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable10	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdog11Info:
		dc.w	-45, 112		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable11	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$a0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdog12Info:
		dc.w	-45, 128		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable12	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdog13Info:
		dc.w	350, 132		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable13	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdog14Info:
		dc.w	350, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable14	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


junkdog15Info:
		dc.w	-45, 140		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdogAITable15	; move ai table
		dc.l	junkdogHitTable		; hit ai table
		dc.w	$120			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkDogFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$60			; lowest scale to back ground
		dc.l	RoarSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter



junkdroid1Info:
		dc.w	290, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable1		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid2Info:
		dc.w	275, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable2		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid3Info:
		dc.w	50, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable3		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdroid4Info:
		dc.w	70, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable4		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid5Info:
		dc.w	100, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable5		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid6Info:
		dc.w	160, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable6		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid7Info:
		dc.w	230, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable7		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdroid8Info:
		dc.w	65, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable8		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid9Info:
		dc.w	120, 100		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable9		; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid10Info:
		dc.w	250, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable10	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
junkdroid11Info:
		dc.w	40, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable11	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdroid12Info:
		dc.w	265, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable12	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdroid13Info:
		dc.w	80, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable13	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

junkdroid14Info:
		dc.w	80, 280			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable14	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


junkdroid15Info:
		dc.w	220, 280		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	junkdroidAITable15	; move ai table
		dc.l	junkdroidHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	jnkdroidFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	MachineSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


;
;
;

sludge1Info:
		dc.w	290, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable1		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge2Info:
		dc.w	275, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable2		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge3Info:
		dc.w	50, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable3		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sludge4Info:
		dc.w	70, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable4		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge5Info:
		dc.w	100, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable5		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge6Info:
		dc.w	160, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable6		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge7Info:
		dc.w	230, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable7		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sludge8Info:
		dc.w	65, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable8		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge9Info:
		dc.w	120, 100		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable9		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge10Info:
		dc.w	250, 100     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable10	; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
sludge11Info:
		dc.w	40, 104			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable11	; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sludge12Info:
		dc.w	265, 104		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable12	; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sludge13Info:
		dc.w	80, 100			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable13	; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

sludge14Info:
		dc.w	80, 280			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable14		; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


sludge15Info:
		dc.w	220, 280		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	sludgeAITable15	; move ai table
		dc.l	sludgeHitTable		; hit ai table
		dc.w	$200			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80			; lowest scale to back ground
		dc.l	sludgeSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


sludgeprjInfo:
		dc.w	0, 0			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	ProjectileAITable	; move ai table
		dc.l	ProjectileHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	sludgeprFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%1000010		; ai/drawing flags
		dc.w	$80 			; lowest scale to back ground
		dc.l	squishSnd		; pointer to sound effect struct
		dc.w	0			; current loop counter



;
; ----- vulture tables
;

vulture1Info:
		dc.w	290, 40			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable1		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture2Info:
		dc.w	275, 50			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable2		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture3Info:
		dc.w	50, 40			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable3		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

vulture4Info:
		dc.w	70, 55			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable4		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture5Info:
		dc.w	100, 40			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable5		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture6Info:
		dc.w	160, 36     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable6		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture7Info:
		dc.w	230, 40			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable7		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

vulture8Info:
		dc.w	65, 45			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable8		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture9Info:
		dc.w	120, 36			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable9		; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture10Info:
		dc.w	250, 50     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable10	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter
vulture11Info:
		dc.w	40, 52			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable11	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

vulture12Info:
		dc.w	265, 48			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable12	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

vulture13Info:
		dc.w	80, 44			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable13	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter

vulture14Info:
		dc.w	80, 36			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable14	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


vulture15Info:
		dc.w	220, 52			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	vultureAITable15	; move ai table
		dc.l	vultureHitTable		; hit ai table
		dc.w	$20			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	vultureFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	vultureSnd			; pointer to sound effect struct
		dc.w	0			; current loop counter


stnkheapInfo:
		dc.w	350, 108			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	stnkheapAIMainTable	; move ai table
		dc.l	stnkheapHitTable	; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	stnkheapFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	50			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$20			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter


shproj1Info:
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
		dc.w	%1000010		; ai/drawing flags
		dc.w	$180			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter

shproj2Info:
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
		dc.w	%1000010		; ai/drawing flags
		dc.w	$180			; lowest scale to back ground
		dc.l	0			; pointer to sound effect struct
		dc.w	0			; current loop counter



junkdogAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable
		dc.b	0,0



junkdogAITable2:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0

junkdogAITable3:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0

junkdogAITable4:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0

junkdogAITable5:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable6:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable7:
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
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	250			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	210			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	190			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	170			; moveto x position
		dc.w	-1
		dc.w	4			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable
		dc.b	0,0


junkdogAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	50			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable2
		dc.b	0,0


junkdogAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	240			; moveto x position
		dc.w	-1
		dc.w	8			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable2
		dc.b	0,0

junkdogAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	260			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable3
		dc.b	0,0

junkdogAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_MOVEABS, AIMA_ANIMATE
		dc.w	80			; moveto x position
		dc.w	-1
		dc.w	12			; 4 pixels at a time

		dc.b	AI_GOTO, 0
		dc.l	junkDogAIMainTable3
		dc.b	0,0





junkDogAIMainTable:

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-4			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; up to 2.00 times size
		dc.w	$30			; scale add value


		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-8			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-8			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	10			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$150			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; up to 2.00 times size
		dc.w	$30			; scale add value


		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

junkDogAIMainTable2:
		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-8			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-12			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	10			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$150			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; up to 2.00 times size
		dc.w	$30			; scale add value


		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

junkDogAIMainTable3:
		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	-12			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$150			; up to 2.00 times size
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_STATIC	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; up to 2.00 times size
		dc.w	$30			; scale add value


		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


junkdogHitTable:
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


junkdroidAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable
		dc.b	0,0



junkdroidAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable
		dc.b	0,0

junkdroidAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable
		dc.b	0,0

junkdroidAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable2
		dc.b	0,0

junkdroidAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable2
		dc.b	0,0


junkdroidAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable2
		dc.b	0,0


junkdroidAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable3
		dc.b	0,0


junkdroidAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable4
		dc.b	0,0


junkdroidAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable3
		dc.b	0,0


junkdroidAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable4
		dc.b	0,0


junkdroidAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable3
		dc.b	0,0


junkdroidAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable3
		dc.b	0,0


junkdroidAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable4
		dc.b	0,0

junkdroidAITable14:
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

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	0			; x movement
		dc.w	16			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	1			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


junkdroidAITable15:

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


junkdroidAIMainTable15A:
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_GOTO, 0
		dc.l	junkdroidAIMainTable15A
		dc.b	0,0


		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 1 attack
;

junkDroidAIMainTable:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

;
; ----- 2 attacks
;

junkDroidAIMainTable2:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	100			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

;
; ----- 3 attacks
;
junkDroidAIMainTable3:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	100			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 4 attacks
;
junkDroidAIMainTable4:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	50			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	100			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	200			; damage

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


junkDroidHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 2 loops
		dc.l	$2000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters



;
; ----- sludge droid's AI lists
;
;


sludgeAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0

sludgeAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0

sludgeAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0

sludgeAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0

sludgeAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler


		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


sludgeAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	sludgeAIMainTable
		dc.b	0,0


;
; ----- 1 attack
;

sludgeAIMainTable

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l1_sprlst13		; pointer to monster list
		dc.b	0,0

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

sludgeHitTable:
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
; ----- vulture droid's AI lists
;
;


vultureAITable1:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0

vultureAITable2:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0

vultureAITable3:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0

vultureAITable4:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0

vultureAITable5:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	120			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0


vultureAITable6:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	0			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable7:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	180			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0


vultureAITable8:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable9:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable10:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	30			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0


vultureAITable11:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	45			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable12:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler


		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0


vultureAITable13:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable14:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	90			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable1
		dc.b	0,0


vultureAITable15:
		dc.b	AI_WAIT|$80, AIWAIT_STOPPED	; ai type, sub-type
		dc.b	0,0,0,0,0,0		; filler

		dc.b	AI_WAIT, AIWAIT_HIDDEN	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	vultureAIMainTable2
		dc.b	0,0


;
; ----- 1 attack
;

vultureAIMainTable1:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	4			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	4			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	8			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	8			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	16			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


;
; ----- 1 attack
;

vultureAIMainTable2:

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$60			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	-4			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$90			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	-4			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$c0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	-8			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$f0			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	-8			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$120			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_MOVEREL|$80, AIMR_STATIC
		dc.w	-16			; x movement
		dc.w	0			; y movement
		dc.w	1			; 1 iteration

		dc.b	AI_MOVEFORWARD, AIMF_ANIMATE	; ai type, sub-type
		dc.w	2			; 30 frames a second
		dc.w	$180			; to scale value
		dc.w	$30			; scale add value

		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	250			; damage

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters

vultureHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$5000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters


stnkheapAIMainTable:
		dc.b	AI_STATIC, AIST_FIXEDST
		dc.b	0,0,0,0,0,0

		dc.b	AI_IF, $fe
		dc.w	MOVEMENTVAR
		dc.l	stnkheapAttLoop

		dc.b	AI_GOTO, 0
		dc.l	stnkheapAIMainTable
		dc.b	0,0


stnkHeapAttLoop:
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l1_sprlst19		; pointer to monster list
		dc.b	0,0

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_ATTACK2, AIATT_ANIMATE ; ai type, sub-type
		dc.w	1			; loops for attack
		dc.w	0			; time for attack
		dc.w	0			; damage

		dc.b	AI_SUMMON, AISU_RELATIVE
		dc.l	l1_sprlst20		; pointer to monster list
		dc.b	0,0

		dc.b	AI_WAIT, AIWAIT_STATIC	; ai type, sub-type
		dc.w	60			; wait before next ai type
		dc.b	0,0,0,0			; filler

		dc.b	AI_GOTO, 0
		dc.l	stnkHeapAttLoop
		dc.b	0,0


stnkheapHitTable:
		dc.b	AI_DIE, AIDI_REDUCEHP	; ai type, sub-type
		dc.w	1			; 1 hitpoint per frame
		dc.b	0,0,0,0			; filler

		dc.b	AI_DIE, AIDI_ANIMATE	; ai type, sub-type
		dc.w	1			; 1 loops
		dc.l	$10000			; score (bcd) format

		dc.b	AI_NULL, 0		; ai type, sub-type
		dc.b	0,0,0,0,0,0		; no parameters




MachineSnd	dc.l	MACHINERY_WHIRRING
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


RoarSnd		dc.l	T_REX_ROAR
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type


sludgeSnd	dc.l	BOUNCING_BRAIN
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

squishSnd	dc.l	ALIEN_SQUISH
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

VultureSnd	dc.l	Pterodactle_Scream
		dc.w	ATTACKING
		dc.w	0
		dc.b	AI_ATTACK, AIATT_ANIMATE ; ai type, sub-type

lvl1b1Strip:
		dc.l	WALLL1B1FILE
		dc.w	9			; number of strips
;
;			dest Y/ width/height/source Y/MapA=0-MapB=1/speed/priority
;
		dc.w	4,40,8,0,1,1,0
		dc.w	4,40,8,8,0,1,0
		dc.w	12,40,2,16,1,2,0
		dc.w	13,40,2,18,0,2,0
		dc.w	14,40,3,20,1,4,1
		dc.w	15,40,3,23,0,4,1
		dc.w	17,40,3,26,0,6,1
		dc.w	19,40,3,29,0,8,1
		dc.w	21,40,3,32,0,8,1

		include	globals.i

		end
