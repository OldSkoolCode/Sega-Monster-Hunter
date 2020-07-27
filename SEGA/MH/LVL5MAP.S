; $Log: lvl5map.s_v $
;Revision 1.1  1993/07/08  15:28:15  KENH
;Initial revision
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

Level5Map:
		dc.w	0, WALLPANEL+0
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.w	3
		dc.w	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	l5_sprlst1
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	l5_sprlst1
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	l5_sprlst2
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	l5_sprlst1
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	l5_sprlst1
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.w	2
		dc.w	0
		dc.l	AddNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	l5_sprlst1
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+1
		dc.l	0    
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0    
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	l5_sprlst1
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	PowerUpSprLst
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	l5_sprlst2
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	FORWARD
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	PowerUpSprLst
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	l5_sprlst1
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	l5_sprlst1
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	addNumSprites

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	0
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+1
		dc.l	0
		dc.w	WAITTILLCLEAR
		dc.w	0
		dc.w	0, FLOORPANEL+8
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+2
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+9
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+3
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+10
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+4
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+11
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+5
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+12
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+6
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+13
		dc.l	0
		dc.l	0

		dc.w	0, WALLPANEL+0
		dc.l	0
		dc.w	RIGHT
		dc.w	0
		dc.w	0, FLOORPANEL+7
		dc.l	0
		dc.l	0


l5_sprlst1:
		dc.w	4
		dc.l	meteor1Info
		dc.l	meteor2Info
		dc.l	meteor3Info
		dc.l	meteor4Info
		dc.w	0

l5_sprlst2:
		dc.w	2
		dc.l	astroid1Info
		dc.l	astroid2Info
		dc.w	0

meteor1Info:
		dc.w	120, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	meteorFile		; file for monster
		dc.w	60			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter
meteor2Info:
		dc.w	160, 116		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	meteorFile		; file for monster
		dc.w	120			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter

meteor3Info:
		dc.w	140, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	meteorFile		; file for monster
		dc.w	150			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter

meteor4Info:
		dc.w	180, 116			; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$80			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	meteorFile		; file for monster
		dc.w	180			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	%10			; ai/drawing flags
		dc.w	$80
		dc.l	0
		dc.w	0			; current loop counter

astroid1Info:
		dc.w	59, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$e0			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	astroidFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

astroid2Info:
		dc.w	189, 72     		; x, y
		dc.w	1,0	 		; anim, frame
		dc.l	knivesAITable		; move ai table
		dc.l	knivesHitTable		; hit ai table
		dc.w	$100			; starting z depth
		dc.w	CHARPRIORITY		; flags
		dc.l	astroidFile		; file for monster
		dc.w	0			; counter
		dc.w	0			; temp counter
		dc.w	2			; hit points
		dc.w	0			; ai/drawing flags
		dc.w	$d8
		dc.l	0
		dc.w	0			; current loop counter

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


lvl5b2Strip:
		dc.l	WALLL5B2FILE
		dc.w	7			; number of strips
;
;			dest Y/ height/width/source Y/MapA=0-MapB=1/speed
;
		dc.w	18,32,5,0,0,8
		dc.w	17,32,3,11,1,6
		dc.w	13,32,4,5,0,5
		dc.w	13,32,2,14,1,4
		dc.w	11,32,2,9,0,3
		dc.w	11,32,1,16,1,2
		dc.w	4,32,7,17,1,1

		include	globals.i

		end
