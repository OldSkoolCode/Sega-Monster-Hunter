;{----------------------------------------------------------------------}
;{	GENERAL.S							}
;{	  general Routines routines for game				}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{----------------------------------------------------------------------}
		even

		include	macros.i
		include equates.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}
BssGroup	group	Bss

		section	.bss,BssGroup

temppal1	ds.w	64
temppal2	ds.w	64
temppal3	ds.w	64+2
z80Started	ds.w	1

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	_ScanJoy1						}
;{ Description:	scan joystick 1 and return bits 			}
;{ Parameters:	.							}
;{ Returns	d0 = button bits					}
;{----------------------------------------------------------------------}
ScanJoy1	Module

		movem.l	d1/a0,-(sp)
		lea	Data1,a0	;point to hardware
		tst.w	z80Started
		beq.s	.noZ80Trouble
		move.w	#$100,BUSREQ    ; Z80 bus request on
.wait_z80:
		btst.b	#0,Z80BusReq	;Z80 bus grant acknowledge?
		bne.s	.wait_z80	;wait until bus granted
.noZ80Trouble:
		move.b	#$00,(a0)	;TH=0
		nop
		nop			;wait
		move.b	(a0),d0		;get bits 6..7 (in 4..5)
		lsl.w	#2,d0		;move to 6..7
		move.b	#$40,(a0)	;TH=1
		and.w	#$C0,d0		;mask 6..7
		move.b	(a0),d1		;get 0..5
		tst.w	z80Started
		beq.s	.dontrestartZ80
		move.w	#0,Z80BusReq	;Z80 bus release
.dontrestartZ80:
		and.w	#$3f,d1		;mask 0..5
		or.w	d1,d0		;combine (top byte of word=0)

		movem.l	(sp)+,d1/a0
		rts

		ModEnd

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
;		jsr	puts
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
;		jsr	puts
		movem.l	(sp)+,d0-d2/a0-a1
		rts

		modEnd

;{----------------------------------------------------------------------}
;{ Function:	fadetoPalRange						}
;{ Description:	take range of colors and fade from current palette	}
;{		to them not disturbing outside of range			}
;{ Parameters:	d0 = # steps to fade					}
;{		a0 = source palette					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
fadetoPalRange	Module

		movem.l	d0-d5/a0-a2,-(sp)

		lea	temppal1,a1
		lea	temppal2,a2
		sf	VDPAccess		; disable VDP accesses

		AutoIncrement 2
		move.w	#0,VCTRL		; address zero
		move.w	#CD3,VCTRL		; and read cram
		move.w	#64-1,d2
.rdLoop:
		move.w	VDATA,d1
		move.w	d1,(a1)+
		move.w	d1,(a2)+
		dbra	d2,.rdLoop

		st	VDPAccess		; enable VDP accesses

		lea	-128(a2),a2

		move.w	(a0)+,d1
		add.w	d1,d1
		adda.w	d1,a2			; destination offset
		move.w	(a0)+,d2		; count
		subq.w	#1,d2			; for dbra
.moveLoop:
		move.w	(a0)+,(a2)+
		dbra	d2,.moveLoop		; move in new colors

		lea	temppal1,a0
		lea	temppal2,a1
		bra.s	fadetoFullPal2

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	fadetoFullPal						}
;{ Description:	Fade from one palette to another			}
;{ Parameters:	d0 = # steps to fade					}
;{		a0 = source palette					}
;{		a1 = destination palette				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
fadetoFullPal	Module

		movem.l	d0-d5/a0-a2,-(sp)

fadetoFullPal2:
		move.w	d0,d3
		move.w	#1,d2
.f_fade:
		lea	temppal3,a2
		clr.w	(a2)+		; color register index
		move.w	#$40,(a2)+	; number of colors

		moveq	#64-1,d5	; every color
.f_set:
		move.b	(a0)+,d0	; 1st byte of data
		and.w	#$f,d0		; get nibble
		move.w	d0,d4		; save off source
		move.b	(a1)+,d1
		and.w	#$f,d1
		sub.w	d1,d0
		muls	d2,d0
		divs	d3,d0		; scale for current frame
		sub.w	d0,d4
		and.w	#$e,d4		; discard bottom bit
		move.b	d4,(a2)+

		move.b	(a0),d0		; 2nd byte of data/1st nibble
		lsr.w	#4,d0
		and.w	#$f,d0		; get nibble
		move.w	d0,d4		; save off source
		move.b	(a1),d1
		lsr.w	#4,d1
		and.w	#$f,d1
		sub.w	d1,d0
		muls	d2,d0
		divs	d3,d0		; scale for current frame
		sub.w	d0,d4
		and.w	#$e,d4		; discard bottom bit
		lsl.w	#4,d4
		move.b	d4,(a2)

		move.b	(a0)+,d0	; 1st byte of data
		and.w	#$f,d0		; get nibble
		move.w	d0,d4		; save off source
		move.b	(a1)+,d1
		and.w	#$f,d1
		sub.w	d1,d0
		muls	d2,d0
		divs	d3,d0		; scale for current frame
		sub.w	d0,d4
		and.w	#$e,d4		; discard bottom bit
		or.b	d4,(a2)+

		dbra	d5,.f_set	; do all colours
		lea	-128(a0),a0	; point to buffer again
		lea	-128(a1),a1	; point to buffer again
		lea	temppal3,a2
		move.l	a2,globalPals	; say update palette
		clr.l	lastPals
		clr.l	globalPals+4	; say update palette
		clr.l	globalPals+8	; say update palette
		clr.l	globalPals+12	; say update palette
.waitPal:
		cmp.l	#0,lastPals	; wait for palette update
		beq.s	.waitPal

		addq.w	#1,d2
		cmp.w	d2,d3
		bge	.f_fade

		movem.l	(sp)+,d0-d5/a0-a2

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	StartZ80						}
;{ Description:	start z80 running					}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
Startz80	Module

		move.w	sr,-(SP)
		or.w	#$0700,sr      ; disable ints

		move.w  #$0,BUSRES          ; Z80 bus reset on (assumes buss rquest on)
		move.l  #15,d0              ; a loop > 26 uS
szlp:
		subq.l  #1,d0
		bne.s   szlp
		move.w  #$0,BUSREQ          ; Z80 bus request off
		move.w  #$100,BUSRES        ; Z80 bus reset off

		move.w	#1,z80Started

		move.w  (sp)+,sr
		rts

		ModEnd

		section	.data

decvals		dc.w	10000,1000,100,10,1
hexascii	dc.b	"0123456789ABCDEF"



		include	globals.i

	 	end

