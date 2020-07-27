


	section	.text

SNASM	equ	1

	include	vectors.s

start:
	lea	start(pc),a0
	move.l	#$ff0000,d0
loop:
	move.b	(a0),d1
	subq.l	#1,d0
	bne.s	loop

	nop
	nop
	rts


ExtInt:
VBlank:
HInt:
	rte


	end
