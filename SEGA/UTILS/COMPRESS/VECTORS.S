*****************************************************************************
*			68000 Vectors                                       *
*****************************************************************************
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; All exception vectors go here!
;
;
		include	macros.i
		include	equates.i

BssGroup	group	Bss
	section	.bss,BssGroup

	section .text

; Initial SSP and PC
	dc.l	InitSP
	dc.l	start

	if	SNASM
SCSITrap	equ	$208008
SCSIExcept	equ	$20800C

BEVect:
	dc.l	$02<<24+SCSIExcept
AEVect:
	dc.l	$03<<24+SCSIExcept
IEVect:
	dc.l	$04<<24+SCSIExcept
	dc.l	$05<<24+SCSIExcept
	dc.l	$06<<24+SCSIExcept
	dc.l	$07<<24+SCSIExcept
	dc.l	$08<<24+SCSIExcept
	dc.l	$09<<24+SCSIExcept

	else
BEVect:
	dc.l	BusError		; Bus Error
AEVect:
	dc.l	AddressError		; Address Error
IEVect:
	dc.l	IllegalError		; Illegal Instruction
	dc.l	ErrorVect		; Zero Divide
	dc.l	ErrorVect		; Chk instruction
	dc.l	ErrorVect		; trapv instruction
	dc.l	ErrorVect		; privilege violation
	dc.l	ErrorVect		; trace

	endif

LineAVect:
	dc.l	0			; line A
	dc.l	0			; line F
; Reserved by motorola
	dcb.l	12,0
; Hardware interrupts
	dc.l	0			; Spurious Interrupt
	dc.l	0
	if	(TAD)
	dc.l	_TadExt			; level 2
	else
	dc.l	ExtInt
	endif
	dc.l	0			; level 3
	dc.l	HInt			; level 4
	dc.l	0			; level 5
VBLVect:
	if	(TAD)
	dc.l	_TadVbi			; level 6
	else
	dc.l	Vblank
	endif
	dc.l	0			; level 7

	if	SNASM
	dc.l	$20<<24+SCSITrap
	dc.l	$21<<24+SCSIExcept
	dc.l	$22<<24+SCSIExcept
	dc.l	$23<<24+SCSIExcept
	dc.l	$24<<24+SCSIExcept
	dc.l	$25<<24+SCSIExcept
	dc.l	$26<<24+SCSIExcept
	dc.l	$27<<24+SCSIExcept
	dc.l	$28<<24+SCSIExcept
	dc.l	$29<<24+SCSIExcept
	dc.l	$2A<<24+SCSIExcept
	dc.l	$2B<<24+SCSIExcept
	dc.l	$2C<<24+SCSIExcept
	dc.l	$2D<<24+SCSIExcept
	dc.l	$2E<<24+SCSIExcept
	dc.l	$2F<<24+SCSIExcept

	else

	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 
	dc.l	ErrorVect		; trap 

	endif

; Reserved by motorola
	dcb.l	16,0
; End of vectors

	include	globals.i
	end
