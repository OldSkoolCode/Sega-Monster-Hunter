	xdef	sega_header

        section .text

sega_header:
	dc.b	'SEGA MEGA DRIVE '
	dc.b	'(C)SEGA 1993.OCT'
	dc.b	'MONSTER HUNTER      ',0
	dc.b	'FUTURESCAPE PRODUCTIONS INC'
	dc.b	'PROGRAMMER          ',0
	dc.b	'  KENNETH L. HURLEY        '
	dc.b	'GM 00000000-00'
	dc.w	$0
	dc.b	'J',0
	dc.w	0,0,0,0,0,0,0
	dc.l	$0
	dc.l	$20000
	dc.l	$ff0000
	dc.l	$ffffff
	dc.b	'            '
	dc.b	'            '
	dc.b	0
	dc.w	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	dc.b	'JUE             '
