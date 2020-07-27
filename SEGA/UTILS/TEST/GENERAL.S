;{----------------------------------------------------------------------}
;{	GENERAL.S							}
;{	Monster Hunter:							}
;{	  general Routines routines for game				}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}
		even

		include	macros.i
		include equates.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}
BssGroup	group	Bss

		section	.bss,BssGroup

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	_ptInRect						}
;{ Description:	Check for point in rectangle				}
;{ Parameters:	d0 = x of point						}
;{		d1 = y of point						}
;{		d2 = x of rectangle					}
;{		d3 = y of rectangle					}
;{		d4 = width of rectangle					}
;{		d5 = height of rectangle				}
;{ returns:	d0 = 0 if not in rectangle				}
;{----------------------------------------------------------------------}
_ptInRect	Module

		movem.l	d4-d6,-(sp)

		clr.w	d6

		cmp.w	d2,d0
		blt.s	.allDone
		cmp.w	d3,d1
		blt.s	.allDone
		add.w	d0,d4
		cmp.w	d4,d0
		bge.s	.allDone
		add.w	d1,d5
		cmp	d5,d1
		bge.s	.allDone
		move.w	#1,d6
.allDone:
		move.w	d6,d0
		movem.l	(sp)+,d4-d6
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	hextoasc 						}
;{ Description: Converts hexadecimal to ascii and prints it out.	}
;{ Parameters:	d0 = number						}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
hextoasc:
		movem.l	d0-d2/a0-a1,-(sp)
		lea	tempbuff,a0
		lea	hexascii,a1
		moveq	#7,d2
hexLoop:
		rol.l	#4,d0
		move.w	d0,d1
		and.w	#$f,d1
		move.b	$0(a1,d1.w),(a0)+
		dbra	d2,hexloop
		
		lea	tempbuff,a0
		jsr	puts
		movem.l	(sp)+,d0-d2/a0-a1

		rts

;{----------------------------------------------------------------------}
;{ Function:	hextodec						}
;{ Descprition:	convert hex number to decimal ascii			}
;{ Parameters:	d0.w = number						}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
hextodec	Module

		movem.l	d0-d2/a0-a1,-(sp)

		lea	tempbuff,a0
		lea	decvals-2,a1
		move.b	#'0',(a0)
		clr.b	1(a0)

		move.w	#5-1,d2
.findLowLoop:
		adda.w	#2,a1
		cmp.w	(a1),d0
		bge.s	.CnvtLoop
		dbra	d2,.findLowLoop
		jmp	.h2dExit
.CnvtLoop:
		move.w	(a1)+,d1
		divu	d1,d0
		add.b	#'0',d0
		move.b	d0,(a0)+
		swap	d0
		dbra	d2,.CnvtLoop
		clr.b	(a0)+
.h2dExit:
		lea	tempbuff,a0
		jsr	puts
		movem.l	(sp)+,d0-d2/a0-a1
		rts

		modEnd

		section	.data

decvals		dc.w	10000,1000,100,10,1
hexascii	dc.b	"0123456789ABCDEF"



		include	globals.i

	 	end

