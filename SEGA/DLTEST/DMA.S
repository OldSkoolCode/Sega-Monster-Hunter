;{----------------------------------------------------------------------}
;{	DMA.S								}
;{	  DMA Routines routines for game				}
;{	  Written BY: Kenneth L. Hurley					}
;{	  Futurescape Productions Inc.					}
;{----------------------------------------------------------------------}
		even

		include	macros.i
		include equates.i


BssGroup	group	Bss

		section	.bss,BssGroup

dmaStart	ds.w	1
dmaEnd		ds.w	1
dmaCurrent	ds.w	1

dmaQueue	ds.b	(SIZEdmaStruct*MAXDMAQUEUE)

LENGTHBSS	equ	*-dmaStart
		inform	0,'length of bss = %d',LENGTHBSS

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	ClearVRAM						}
;{ Description:	Clear video ram with DMA				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
ClearVRAM	Module

		ShadowRegister VDP_MODESET2,d0
		or.b	#M1,d0			;enable DMA
		SetVDPRegisterCode VDP_MODESET2,d0
		ShadowRegister VDP_AUTOINC,d7	;get current autoinc
		AutoIncrement 1			;VRAM is byte wide
		SetVDPRegister VDP_DMALENLO,-1	;\ length = 65535 
		SetVDPRegister VDP_DMALENHI,-1	;/ (byte aligned word)
		SetVDPRegister VDP_DMASRCHI,DMD1 ;VRAM fill (no source)
		move.l	#$40000080,VCTRL	;address 0
		move.w	#0,VDATA		;clear value (lower byte).
		bsr	WaitForDMA		;wait until DMA finished
		ShadowRegister VDP_MODESET2,d0
		and.b	#$FF-M1,d0		;flag slave as DISABLE DMA
		SetVDPRegisterCode VDP_MODESET2,d0
		SetVDPRegisterCode VDP_AUTOINC,d7
		rts

		ModEnd
 
;{----------------------------------------------------------------------}
;{ Function:	ClearVSRAM						}
;{ Description:	Clear vertical scroll ram.				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
ClearVSRAM	Module

		moveq	#0,d0		;start address
		bsr	SetVSRAMWrite	;set VSRAM write
		moveq	#80/4-1,d1	;long words
		lea	VDATA,a0	;point to VDP data port
cv_lp:
		move.l	d0,(a0)		;clear scrolls
		dbra	d1,cv_lp	;clear all
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	MySpriteDMA						}
;{ Description:	My DMA routines for their scaler code			}
;{ Parameters:	d0 = Address in VRAM					}
;{		d2 = Size of DMA (even number of bytes)			}
;{		d3 = Address in 68K memory				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
MySpriteDMA	Module


		movem.l	d1/a0,-(sp)
		move.l	d2,d1
		move.l	d3,a0
		bsr	addDMAQueue
		movem.l	(sp)+,d1/a0
		rts

		ModENd

;{----------------------------------------------------------------------}
;{ Function:	ClearHSRAM						}
;{ Description:	Clear horizonatl scroll ram.				}
;{ Parameters:	d0 = pointer to HScroll Ram				}
;{ returns:	.							}
;{----------------------------------------------------------------------}
ClearHSRAM	Module

		bsr	SetVRAMWrite	;set write to VRAM
		moveq	#0,d0		;clear d0
		move.w	#1024/4-1,d1	;long words
		lea	VDATA,a0	;point to VDP data port
ch_lp:
		move.l	d0,(a0)		;clear scrolls
		dbra	d1,ch_lp	;clear all
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	CopyTOVRAM						}
;{ Description:	DMA block to VRAM.					}
;{ Parameters:	d0 = VRAM address					}
;{		d1 = length of data (bytes)				}
;{		a0 = pointer to data					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
CopyToVRAM	Module

		movem.l	d0-d2/d7,-(sp)

		move.w	sr,-(sp)	; save status
		or.w	#$0700,sr	; disable 68000 interrupts

		move.w	#$100,Z80BUSREQ	; Z80 bus request
		move.w	#$100,Z80RESET	; Z80 reset line high (NORMAL RUN STATE)
.Z80wait1:
		btst.b	#0,Z80BUSREQ	; Z80 bus grant acknowledge?
		bne.s	.Z80wait1		; wait until bus granted

		st	Z80NOROM	; flag ROM accesses NOT permitted

		move.w	#0,Z80BUSREQ	; Z80 bus release/allow Z80 to continue

		move.w	(sp)+,sr	; reset old interrupt status

		ShadowRegister VDP_MODESET2,d2
		or.b	#M1,d2		; enable DMA
		SetVDPRegisterCode VDP_MODESET2,d2
		ShadowRegister VDP_AUTOINC,d7 ; get current autoinc
		AUTOINCREMENT 2		; VRAM is byte wide
		lsr.w	#1,d1		; convert length to words
		move.w	d1,d2
		SetVDPRegisterCode VDP_DMALENLO,d2 ; \
		move.w	d1,-(sp)
		move.b	(sp)+,d1
		SetVDPRegisterCode VDP_DMALENHI,d1 ; /
		move.l	a0,d1		; get address
		lsr.l	#1,d1		; convert to word address
		move.w	d1,d2
		SetVDPRegisterCode VDP_DMASRCLO,d2  ; \
		move.w	d1,d2
		move.w	d2,-(sp)
		move.b	(sp)+,d2
		SetVDPRegisterCode VDP_DMASRCMID,d2 ;  \ source address (byte aligned in VDP slaves)
		swap	d1		    	    ;  /
		and.b	#$7f,d1		    	    ; /  clear DMD1
		SetVDPRegisterCode VDP_DMASRCHI,d1  ;/
		move.w	d0,d2		; get VRAM address again
		and.w	#$FFFF-CD1,d0	; clear CD1
		or.w	#CD0,d0		; set CD0
		lea	VCTRL,a0	; control port pointer
		move.w	d0,(a0)		; set first word of address
		move.w	d2,d0		; get VRAM address again
		move.l	DMATrigger(pc),DMATemp	; move trigger code to work RAM
		rol.w	#2,d0		; move bits 14/15 to bits 0/1
		and.w	#%11,d0		; mask them (clear CD2 and other bits)
		or.w	#$80,d0		; set bit 7
		jsr	DMATemp		; call the trigger (set second word of address)

		ShadowRegister VDP_MODESET2,d2
		and.b	#$FF-M1,d2	; flag DISABLE DMA
		SetVDPRegisterCode VDP_MODESET2,d2
		SetVDPRegisterCode VDP_AUTOINC,d7
		move.w	sr,-(sp)	; save status
		or.w	#$0700,sr	; disable 68000 interrupts
		move.w	#$100,Z80BUSREQ	; Z80 bus request
		move.w	#$100,Z80RESET	; Z80 reset line high (NORMAL RUN STATE)
.Z80wait2:
		btst.b	#0,Z80BUSREQ	; Z80 bus grant acknowledge?
		bne.s	.Z80wait2	; wait until bus granted

		sf	Z80NOROM	; flag ROM accesses permitted

		move.w	#0,Z80BUSREQ	; Z80 bus release/allow Z80 to continue

		move.w	(sp)+,sr	; reset old interrupt status
		movem.l	(sp)+,d0-d2/d7
		rts
DMATrigger:
		move.w	d0,(a0)		;\ this code is moved to and executed in work RAM
		rts			;/
	
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	WaitForDMA						}
;{ Description:	Wait for DMA to finish					}
;{ Parameters:								}
;{ returns:	.							}
;{----------------------------------------------------------------------}
WaitForDMA	Module

		move.w	VCTRL,d0	;get status
		and.w	#DMA,d0		;DMA finished?
		bne.s	WaitForDMA	;loop if not
		rts

		ModEnd


;{----------------------------------------------------------------------}
;{ Function:	SetVRAMWrite						}
;{ Description:	Set Write to VRAM					}
;{ Parameters:	d0 = VRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetVRAMWrite	Module

		move.l	d0,-(sp)
		or.w	#CD0,d0
		swap	d0
		move.w	2(sp),d0
		rol.w	#2,d0
		and.l	#($FFFF-CD1)<<16+%11,d0
		move.l	d0,VCTRL
		move.l	(sp)+,d0
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	AddDMAQueue						}
;{ Description:	Add to the DMA queue					}
;{ Parameters:	d0 = VRAM address					}
;{		d1 = length of data (bytes)				}
;{		a0 = pointer to data					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
addDMAQueue	Module

		movem.l	d2/a1,-(sp)
		move.w	dmaEnd,d2
		cmp.w	#MAXDMAQUEUE-1,d2
		bge	.ADQExit
		lsl.w	#3,d2			; times size of dma queue
		lea	dmaQueue,a1
		adda.w	d2,a1
		move.w	d0,VRAMADDRESS(a1)	; save parameters in queue
		move.w	d1,VRAMLENGTH(a1)
		move.l	a0,SRCADDR(a1)
		add.w	#1,dmaEnd
.ADQExit:
		movem.l	(sp)+,d2/a1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	waitDMAQueue						}
;{ Description:	wait for DMA queue to end				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
waitDMAQueue	Module

		move.w	d1,-(sp)
		move.l	d2,-(sp)
		move.w	dmaEnd,d1
.waitDMA:
		cmp.w	dmaCurrent,d1
		bne.s	.waitDMA		; wait till finished

		move.w	dmaStart,d1
		move.w	d1,dmaEnd
		move.w	d1,dmaCurrent

		move.l	(sp)+,d2
		move.w	(sp)+,d1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	updateDMA						}
;{ Description:	Send as much of DMA as possible. This will split blocks	}
;{		longer than 6k into multiple blocks.  If a new block	}
;{		is started, we check to make sure it can either be sent	}
;{		entirly this frame or we wait until next frame to start	}
;{		the transfer.  This should cause less tearing.		}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
updateDMA	Module

		movem.l	d0-d4/a0-a1,-(sp)

		move.w	#MAXDMAXFERAFRAME,d3
.DMAQueueLoop:
		lea	dmaQueue,a1
		move.w	dmaCurrent,d2
		cmp.w	dmaEnd,d2
		beq	.allDone

		lsl.w	#3,d2
		adda.w	d2,a1			; get to queue address
		clr.l	d1
		move.w	VRAMADDRESS(a1),d0	; save parameters in queue
		move.w	VRAMLENGTH(a1),d1
		move.l	SRCADDR(a1),a0
		cmp.w	d3,d1			; more than max dma in vblank
		ble.s	.DMASizeOk
		move.w	d3,d1
.DMASizeOk:
		cmp.w	VRAMLENGTH(a1),d1	; can do entire block?
		beq.s	.doDMA
		cmp.w	#MAXDMAXFERAFRAME,d3	; first pass of block?
		bne	.allDone		; nope try next vblank
.doDMA:
		move.l	a0,d4			; into temp register
		add.l	d1,d4			; get ending address
		swap	d4
		move.l	a0,d2
		swap	d2
		cmp.w	d2,d4			; still in same 64k block
		beq.s	.Block64Ok		; yes
		move.l	a0,d1			; get starting address
		and.l	#$ffff,d1		; and do up till this 64k block
		neg.w	d1			; number of bytes left in 64k
.Block64Ok:
		add.l	d1,SRCADDR(a1)		; add to source address
		add.w	d1,VRAMADDRESS(a1)	; and vram address
		sub.w	d1,VRAMLENGTH(a1)	; subtract can do entire block?
		bne.s	.BlockNotDone
		add.w	#1,dmaCurrent
.BlockNotDone:
		cmp.w	#20,d1			; should just shove over
		ble.s	.writeDirect
		bsr	copyToVram
		sub.w	d1,d3			; subtract what we sent
		bgt.s	.DMAQueueLoop		; see if more to do
		bra.s	.allDone
.writeDirect:
		AutoIncrement 2
		CalcVramWrtAddrCode d0,d2
		move.l	d2,VCTRL
		move.w	d1,d2
		lsr.w	#1,d2
		subq.w	#1,d2
.moveLoop:
		move.w	(a0)+,VDATA
		dbra	d2,.moveLoop
		sub.w	d1,d3			; subtract what we sent
		bgt	.DMAQueueLoop		; see if more to do

.allDone:
		movem.l	(sp)+,d0-d4/a0-a1
		rts

		Modend


;{----------------------------------------------------------------------}
;{ Function:	SetVRAMRead						}
;{ Description:	Set Read from VRAM					}
;{ Parameters:	d0 = VRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetVRAMRead	Module

		move.l	d0,-(sp)
		swap	d0
		move.w	2(sp),d0
		rol.w	#2,d0
		and.l	#($FFFF-CD1-CD0)<<16+%11,d0
		move.l	d0,VCTRL
		move.l	(sp)+,d0
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	SetCRAMWrite						}
;{ Description:	Set Write to CRAM					}
;{ Parameters:	d0 = CRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetCRAMWrite	Module

		and.w	#$7F,d0
		or.w	#CD1+CD0,d0
		move.w	d0,VCTRL
		move.w	#0,VCTRL
		and.w	#$7F,d0
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	SetCRAMRead						}
;{ Description:	Set Read from CRAM					}
;{ Parameters:	d0 = CRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetCRAMRead	Module

		and.w	#$7F,d0
		move.w	d0,VCTRL
		move.w	#CD3,VCTRL
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	SetVSRAMWrite						}
;{ Description:	Set Write to VSRAM					}
;{ Parameters:	d0 = VSRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetVSRAMWrite	Module

		and.w	#$3f,d0
		or.w	#CD0,d0
		move.w	d0,VCTRL
		move.w	#CD2,VCTRL
		and.w	#$3f,d0
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	SetVSRAMRead						}
;{ Description:	Set Read from VSRAM					}
;{ Parameters:	d0 = VSRAM address					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
SetVSRAMRead	Module

		and.w	#$3f,d0
		move.w	d0,VCTRL
		move.w	#CD2,VCTRL
		rts

		ModEnd

		include	globals.i


		end
