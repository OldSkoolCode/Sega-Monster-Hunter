;{----------------------------------------------------------------------}
;{ 			Genesis startup code and mainloop	        }
;{----------------------------------------------------------------------}
	even

	include	macros.i
	include equates.i

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}
BssGroup	group	Bss

		section	.bss,BssGroup

		xdef	_ScrAAddr, _VCount

bcolor		ds.w	1
filename	ds.b	16	; test string
_ScrAAddr	ds.w	1	; address of Scroll A screen
_VCount		ds.l	1
tempbuff	ds.b	11

;{----------------------------------------------------------------------}
;{			code section goes here				}
;{----------------------------------------------------------------------}

		section	.text

start:
        dc.b   $4A,$B9,$00,$A1,$00,$08,$66,$06,$4A,$79,$00,$A1,$00,$0C,$66,$7C
        dc.b   $4B,$FA,$00,$7C,$4C,$9D,$00,$E0,$4C,$DD,$1F,$00,$10,$29,$EF,$01
        dc.b   $02,$00,$00,$0F,$67,$08,$23,$7C,$53,$45,$47,$41,$2F,$00,$30,$14
        dc.b   $70,$00,$2C,$40,$4E,$66,$72,$17,$1A,$1D,$38,$85,$DA,$47,$51,$C9
        dc.b   $FF,$F8,$28,$9D,$36,$80,$32,$87,$34,$87,$01,$11,$66,$FC,$74,$25
        dc.b   $10,$DD,$51,$CA,$FF,$FC,$34,$80,$32,$80,$34,$87,$2D,$00,$51,$CE
        dc.b   $FF,$FC,$28,$9D,$28,$9D,$76,$1F,$26,$80,$51,$CB,$FF,$FC,$28,$9D
        dc.b   $78,$13,$26,$80,$51,$CC,$FF,$FC,$7A,$03,$17,$5D,$00,$11,$51,$CD
        dc.b   $FF,$FA,$34,$80,$4C,$D6,$7F,$FF,$46,$FC,$27,$00,$60,$6C,$80,$00
        dc.b   $3F,$FF,$01,$00,$00,$A0,$00,$00,$00,$A1,$11,$00,$00,$A1,$12,$00
        dc.b   $00,$C0,$00,$00,$00,$C0,$00,$04,$04,$14,$30,$3C,$07,$6C,$00,$00
        dc.b   $00,$00,$FF,$00,$81,$37,$00,$01,$01,$00,$00,$FF,$FF,$00,$00,$80
        dc.b   $40,$00,$00,$80,$AF,$01,$D9,$1F,$11,$27,$00,$21,$26,$00,$F9,$77
        dc.b   $ED,$B0,$DD,$E1,$FD,$E1,$ED,$47,$ED,$4F,$D1,$E1,$F1,$08,$D9,$C1
        dc.b   $D1,$E1,$F1,$F9,$F3,$ED,$56,$36,$E9,$E9,$81,$04,$8F,$02,$C0,$00
        dc.b   $00,$00,$40,$00,$00,$10,$9F,$BF,$DF,$FF,$4e,$71,$4e,$71,$4e,$71

MainEntry:
		lea	InitSP,SP
		move.w	#$2700,SR		; disable interrupts

		move.w	#$e000,_ScrAAddr
		SetVdpRegister  02,%00111000   ; screen at $e000
		SetVdpRegister  01,%01110100   ; Turn on the display
		SetVdpRegister  16,%00000001   ; Map Size 64x32
		AutoIncrement 1

		jsr	_writeCharSet

		obj	(*-start)+$300000

		bsr	TestRamCard

*****************************************************************************
* 			The program main loop starts here
*****************************************************************************
.mainloop:
	jmp	.mainloop
		

__exit:        
	bra     __exit


	xdef  _EnableInts
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Enables all interrupts! TEMP FUNCTION -----
; REVISIONS:    11/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_EnableInts:
        move.w  #$2000,SR
        rts


	xdef	_waitVBL
;{----------------------------------------------------------------------}
;{	_waitVBL:							}
;{	  wait for veritical blank to happen				}
;{----------------------------------------------------------------------}
_waitVBL:
	move.l	_VCount,d0
wVBLLoop:
	cmp.l	_VCount,d0
	beq.s	wVBLLoop
	rts
	


	xdef  Vblank
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     Vblank
; DESCRIPTION:  .
; RETURNS:      .
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Vblank:
	move.l	d0,-(sp)
        nop
        nop
;	trap	#0
	move.l	_VCount,d0
	addq.l	#1,d0
	move.l	d0,_VCount
	move.l	(sp)+,d0
	
        rte


	xdef  Hint
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; FUNCTION:     Hint
; DESCRIPTION:  .
; RETURNS:      .
; PARAMETERS:   .
; SIDE EFFECTS: USES
; REVISIONS:    10/91   -jf-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Hint:
        nop
        rte

	xdef  ExtInt
;{----------------------------------------------------------------------}
;{	Function: ExtInt						}
;{									}
;{	Description: 							}
;{									}
;{	Parameters:							}
;{									}
;{	Returns:							}
;{----------------------------------------------------------------------}
ExtInt:
        rte

;; ERROR EXCPTION FUNCTIONS - JUST LET US KNOW WHAT WENT WRONG

IllegalError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow

		lea	IllegalText(pc),a0
		bsr	putsHigh
		move.l	$2(sp),d0
		bsr	hextoasc
IIl1:
	        bra     IIl1

BusError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow
		lea	BusEText1(pc),a0
		bsr	putsHigh
		move.l	$10(sp),d0
		bsr	hextoasc
		lea	BusEText2(pc),a0
		bsr	putsHigh
		move.l	$2(sp),d0
		bsr	hextoasc
BEl1:
	        bra     BEl1

AddressError:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow
		lea	AddrEText1(pc),a0
		bsr	putsHigh
		move.l	$10(sp),d0
		bsr	hextoasc
		lea	AddrEText2(pc),a0
		bsr	putsHigh
		move.l	$2(sp),d0
		bsr	hextoasc
AEl1:
	        bra     AEl1


ErrorVect:
	        bra     ErrorVect	; We point all unhandled exceptions here


;{----------------------------------------------------------------------}
;{									}
;{	Function: TestRamCard						}
;{									}
;{	Description: Tests to see if ram board is present		}
;{									}
;{	Parameters:							}
;{									}
;{	Returns:							}
;{									}
;{----------------------------------------------------------------------}

TestRamCard:
		move.w	#4,_ScreenCol
		move.w	#4,_ScreenRow

		lea	teststring1,a0
		lea	teststring2,a1
		move.w	#testStrLen-1,d0
checkLoop:
		cmp.b	(a0)+,(a1)+
		bne.s	noSignatureFound
		dbra	d0,checkLoop
		lea	signFound,a0
		jsr	puts
		bra.s	signatureFound
noSignatureFound:
		lea	signNotFound,a0
		jsr	puts
		rts
signatureFound:
		jmp	romHighStart

romHighStart:
		move.w	#4,_screenCol
		move.w	#0,$300000		; kick out low rom/in ram

		lea	teststring2,a0
		lea	teststring1,a1
		move.w	#testStrLen-1,d0
checkLoop2:
		cmp.b	(a0)+,(a1)+
		bne.s	RomIsOut
		dbra	d0,checkLoop2
		lea	romFound,a0
		bsr	putsHigh
		bra.s	RomIsIn
romIsOut:
		lea	noRomFound,a0
		bsr	putsHigh

		move.l	#AddressError,AEVect
		move.l	#BusError,BEVect
		move.l	#IllegalError,IEVect
RomIsIn:
;		lea	0,a1
;		move.l	#$180000,d1		
;RamLoop:
;		move.l	a1,d0
;		cmp.w	#0,d0
;		bne.s	NoTestPrint
;		movem.l	d1/a1,-(sp)
;		move.w	#4,_screenCol
;		move.w	#6,_ScreenRow
;		lea	TestingStr1,a0
;		bsr	putsHigh
;
;		move.l	a1,d0
;		bsr	hextoasc
;		lea	TestingStr2,a0
;		bsr	putsHigh
;		move.l	a1,d0
;		add.l	#65535,d0
;		bsr	hextoasc
;		movem.l	(sp)+,d1/a1
;NoTestPrint:
;		
;		move.w	(a1),d0
;		
;		move.w	#$ffff,(a1)
;		cmp.w	#$ffff,(a1)
;		bne.s	EndRam1
;		move.w	#$AAAA,(a1)
;		cmp.w	#$AAAA,(a1)
;		bne.s	EndRam1
;		move.w	d0,(a1)+
;		subq.l	#1,d1
;		bne.s	RamLoop
;
EndRam1:
		move.l	#VBlank,VBLVect

		move.b	#%10011001,CtrlPort
		move.b	#%11111111,PORTBBITS	; Set Busy = TRUE
.InitLoop1:
		bsr	dispPorts
		move.b	PORTCBITS,d2	; wait till set
		btst	#AFEEDBIT,d2
		beq.s	.InitLoop1
PortLoop:
		bsr	dispPorts
		move.b	PortCbits,d0
		move.w	d0,d1
		and.w	#$3,d1
		lsl.w	#2,d1
		lea	ALGjmptable,a0
		move.l	0(a0,d1.w),a0
		jsr	(a0)
		bra.s	PortLoop


;{----------------------------------------------------------------------}
;{	Function: dispPorts						}
;{									}
;{	Description: Displays the 8255 ports				}
;{									}
;{	Parameters:							}
;{									}
;{	Returns:							}
;{----------------------------------------------------------------------}
dispPorts:

		movem.l	d0-d3/a0/a6,-(sp)
		move.w	#4,_ScreenCol
		move.w	#16,_ScreenRow
		lea	portAbitStr,a0
		bsr	putsHigh
		move.b	PortAbits,d0
		bsr	hextobin
		move.w	#4,_ScreenCol
		move.w	#17,_ScreenRow
		lea	portBbitStr,a0
		bsr	putsHigh
		move.b	PortBbits,d0
		bsr	hextobin
		move.w	#4,_ScreenCol
		move.w	#18,_ScreenRow
		lea	portCbitStr,a0
		bsr	putsHigh
		move.b	PortCbits,d0
NoPortChange:
		bsr	hextobin
		movem.l	(sp)+,d0-d3/a0/a6
		rts

;{----------------------------------------------------------------------}
;{ Function: 	RecPacket						}
;{ Description:	Receive header packet from port and verify 		}
;{		CRC							}
;{ Parameters:	.							}
;{ Returns:	d0 = Command						}
;{		d1 = x position						}
;{		d2 = y position						}
;{		d3 = length						}
;{		a0 = address in packet					}
;{									}
;{----------------------------------------------------------------------}
RecPacket	Module

		link	a6,#-HPSIZE		; alloc stack space

.PackLoop:
;		move.w	#0,_screenCol
;		move.w	#20,_ScreenRow
;		lea	readStr,a0
;		bsr	putsHigh

		
		move.w	#HPSIZE-1,d1		; size to receive
		movea.l	sp,a0
.RecLoop:
	 	Waitbyte			; get byte from port
		btst	#AFEEDBIT,d2
		beq.s	.PackLoop		; init received start over
		move.b	d0,(a0)+
;		bsr	hextoasc
		dbra	d1,.RecLoop		; do all bytes

		movea.l	sp,a0
		move.w	#HPSIZE-2,d0
		bsr	crc16
.PackOk:
		move.w	#NAKBYTE,d4		; assume Not Acknowledge
		cmp.w	HPCRC(a0),d0
		bne.s	.NotGoodPacket
		move.w	#ACKBYTE,d4		; was good send acknowledge
.NotGoodPacket:
;		move.l	d0,-(sp)
;		move.w	#0,_screenCol
;		move.w	#20,_ScreenRow
;		lea	writeStr,a0
;		bsr	putsHigh
;		move.l	(sp)+,d0
;		bsr	hextoasc
;		move.w	HPCRC(sp),d0
;		bsr	hextoasc

		movea.l	sp,a0
		move.w	d4,d0
		lea	nibXlatTable,a1
		SendByte
		btst	#AFEEDBIT,d2
		beq	.PackLoop		; init received start over
		cmp.w	#ACKBYTE,d4		; try again
		bne	.PackLoop

		move.w	HPCOMMAND(a0),d0
		move.w	HPX(a0),d1
		move.w	HPY(a0),d2		; grab all the data
		move.l	HPLENGTH(a0),d3
		move.l	HPADDRESS(a0),a0

		unlk	a6			; unalloc stack space
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function: 	crc16							}
;{ Description:	Generate CRC 16 from range of bytes			}
;{ Parameters:	d0 = length of data					}
;{		a0 = pointer to data					}
;{ Returns:								}
;{		d0.w = 16 bit CRC					}
;{----------------------------------------------------------------------}
crc16		module
		movem.l	d1-d2/a0-a1,-(sp)

		lea	CRC16Tab,a1
		subq.l	#1,d0
		moveq.l	#0,d1
.Crcloop:
		move.b	(a0)+,d2
		eor.w	d1,d2
		and.w	#$ff,d2
		lsl.w	#1,d2
		lsr.w	#8,d1
		move.w	(a1,d2.w),d2
		eor.w	d2,d1
		dbra	d0,.CrcLoop

		move.l	d1,d0

		movem.l	(sp)+,d1-d2/a0-a1
		rts
		modend


;{----------------------------------------------------------------------}
;{ Function:	DownLoadData						}
;{ Description:	Down load data into previously specified area		}
;{ Parameters:	d3 = length						}
;{		a0 = address						}
;{ Returns:	.							}
;{----------------------------------------------------------------------}		
DownloadData	Module


		movem.l	d3/d5/a0,-(sp)

		move.l	d3,d5
		lsr.l	#8,d3		; get # 4k blocks
		lsr.l	#4,d3		; get # 4k blocks
		cmp.l	#0,d3
		beq.s	.No4kBlocks
		subq.l	#1,d3		; for dbra
.Loop4K:
		move.l	#4096,d0
		bsr	GetData
		add.l	#4096,a0
		dbra	d3,.Loop4K

.No4kBlocks:
		and.l	#$fff,d5
		beq.s	.DLExit
		move.l	d5,d0
		bsr	GetData
.DLExit:
		movem.l	(sp)+,d3/d5/a0
		rts

		modEnd
		
;{----------------------------------------------------------------------}
;{ Function:	GetData							}
;{ Description:	Get data from parallel port				}
;{ Parameters:	d0 = length 						}
;{ 		a0 = Buffer						}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
GetData		Module

		movem.l	d0-d4/d7/a0-a2,-(sp)
		subq.l	#1,d0
		move.l	a0,a2
		move.l	d0,d4
.RestartLoop:
;		move.w	#0,_screenCol
;		move.w	#20,_ScreenRow
;		lea	DLStr,a0
;		bsr	putsHigh
		move.l	a2,a0			; save for later
		move.w	d4,d1			; size to receive
.GetLoop:
	 	Waitbyte			; get byte from port
		btst	#AFEEDBIT,d2
		beq.s	.RestartLoop		; init received start over
		move.b	d0,(a0)+
;		cmp.b	-1(a0),d0
;		bne	.BadRam
		dbra	d1,.GetLoop		; do all bytes

	 	Waitbyte			; get byte from port
		btst	#AFEEDBIT,d2
		beq	.RestartLoop		; init received start over
		move.b	d0,d3
	 	Waitbyte			; get byte from port
		btst	#AFEEDBIT,d2
		beq	.RestartLoop		; init received start over
		lsl.w	#8,d3
		move.b	d0,d3

;		move.w	#0,_screenCol
;		move.w	#20,_ScreenRow
		move.w	d4,d0
		addq.l	#1,d0
		move.l	a2,a0
		bsr	crc16
;		lea	NAKStr,a0
		move.w	#NAKBYTE,d7		; assume Not Acknowledge
		cmp.w	d3,d0
		bne.s	.NotGoodPacket
;		lea	ACKStr,a0
		move.w	#ACKBYTE,d7		; was good send acknowledge
.NotGoodPacket:
;		move.l	d0,-(sp)
;		bsr	putsHigh
;		move.l	(sp)+,d0
;		bsr	hextoasc
;		move.l	d3,d0
;		bsr	hextoasc
		move.w	d7,d0
		lea	nibXlatTable,a1
		SendByte
		btst	#AFEEDBIT,d2
		beq	.RestartLoop		; init received start over
		cmp.w	#ACKBYTE,d7		; try again
		bne	.RestartLoop

		movem.l	(sp)+,d0-d4/d7/a0-a2
		rts

.badRam:
;		and.l	#$ff,d0
;		move.l	a0,-(sp)
;		move.l	d0,-(sp)
;		move.w	#0,_screenCol
;		move.w	#21,_ScreenRow
;		lea	rambadStr,a0
;		bsr	putsHigh
;		move.l	(sp)+,d0
;		bsr	hextoasc
;		move.l	(sp)+,a0
;		move.b	-1(a0),d0
;		bsr	hextoasc
;		
;		movem.l	(sp)+,d0-d4/d7/a0-a2
;		rts
		ModEnd

;{----------------------------------------------------------------------}
;{	Function: hextobin						}
;{									}
;{	Description: convert hexadecimal value to binary ascii and	}
;{		     prints it out					}
;{									}
;{	Parameters: d0 = 8 bit hex number->binary			}
;{									}
;{	Returns:							}
;{----------------------------------------------------------------------}
hextobin:
		lea	tempbuff,a0

		lsl.w	#8,d0
		move.w	#7,d2
binloop:
		move.b	#'0',d1
		lsl.w	#1,d0
		bcc.s	NotSet
		move.b	#'1',d1
NotSet:
		move.b	d1,(a0)+
		dbra	d2,binloop

		move.b	#0,(a0)+

		lea	tempbuff,a0
		bsr	putsHigh

		rts

;{----------------------------------------------------------------------}
;{	Function: hextoasc						}
;{									}
;{	Description: Converts hexadecimal to ascii and prints it out.	}
;{									}
;{	Parameters:							}
;{									}
;{	Returns:							}
;{----------------------------------------------------------------------}
hextoasc:
		movem.l	d0-d2/a0-a1,-(sp)
		lea	tempbuff,a0
		lea	hexascii(pc),a1
		moveq	#7,d2
hexLoop:
		rol.l	#4,d0
		move.w	d0,d1
		and.w	#$f,d1
		move.b	$0(a1,d1.w),(a0)+
		dbra	d2,hexloop
		
		lea	tempbuff,a0
		bsr	putsHigh
		movem.l	(sp)+,d0-d2/a0-a1

		rts
;
;
;
Algorithm8:
Algorithm7:
Algorithm6:
Algorithm5:
Algorithm4:
Algorithm3:
Algorithm2:
UploadData:
SetRegs:
GetRegs:
ExecutePC:
PrintText:
		rts

Algorithm1:
		move.w	#0,_screenCol
		move.w	#6,_ScreenRow
		lea	PacketStr,a0
		bsr	putsHigh
		bsr	RecPacket

		movem.l	d0-d4/a0,-(sp)
		move.w	#13,_ScreenCol
		move.w	#6,_ScreenRow
		and.l	#$ffff,d0
		bsr	hextoasc
		move.w	#13,_ScreenCol
		move.w	#7,_ScreenRow
		move.l	a0,d0
		bsr	hextoasc
		move.w	#13,_ScreenCol
		move.w	#8,_ScreenRow
		move.l	d3,d0
		bsr	hextoasc
		move.w	#13,_ScreenCol
		move.w	#9,_ScreenRow
		move.w	d1,d0
		and.l	#$ffff,d0
		bsr	hextoasc
		move.w	d2,d0
		and.l	#$ffff,d0
		move.w	#13,_ScreenCol
		move.w	#10,_ScreenRow
		bsr	hextoasc
		movem.l	(sp)+,d0-d4/a0

		cmp.w	#FIRSTCOMMAND,d0
		blt	Algorithm1
		cmp.w	#LASTCOMMAND,d0
		bgt	Algorithm1

		and.w	#$7f,d0
		lsl.w	#2,d0
		lea	CMDjmptable,a1
		move.l	0(a1,d0.w),a1
		jsr	(a1)

		rts


		even
ALGjmptable	dc.l	Algorithm4
		dc.l	Algorithm3
		dc.l	Algorithm2
		dc.l	Algorithm1

CMDjmptable	dc.l	DownloadData
		dc.l	UploadData
		dc.l	SetRegs
		dc.l	GetRegs
		dc.l	ExecutePC
		dc.l	PrintText

;{----------------------------------------------------------------------}
;{			data goes here					}
;{----------------------------------------------------------------------}


hexascii	dc.b	"0123456789ABCDEF"
TestingStr1	dc.b	"Testing from Address $",0
TestingStr2	dc.b	"          to Address $",0
IllegalText	dc.b	"Illegal Instruction at Address $",0
BusEText1	dc.b	"Bus Error at $",0
BusEText2	dc.b	" accessing $",0
AddrEText1	dc.b	"Address Error at $",0
AddrEText2	dc.b	" accessing $",0

		objend


signFound	dc.b	"Signature was found!",$d,$a,0
signNotFound	dc.b	"No signature was found!",$d,$a,0

testString1	equ	*

		obj	(*-start)+$300000
		
testString2	dc.b	"Julie Rottiers"
testStrLen	equ	*-testString2
ramavail	dc.b	"Ram was found!",$d,$a,0
noramavail	dc.b	"No ram detected!",$d,$a,0
romFound	dc.b	"Rom still in low address",$d,$a,0
noRomFound	dc.b	"Rom kicked out ok.",$d,$a,0
portAbitStr	dc.b	"Port A: ",0
portBbitStr	dc.b	"Port B: ", 0
portCbitStr	dc.b	"Port C: ", 0
readStr		dc.b	"    Reading Data    ",0
writeStr	dc.b	"    Writing Data    ",0
DLStr		dc.b	"    Downloading Data",0
NAKStr		dc.b	"    NACK Data       ",0
ACKStr		dc.b	"    ACK Data        ",0
rambadStr	dc.b	" Ram seems to be bad ",0
						      
nibXlatTable	dc.b	%10100101, %11100101, %10110101, %11110101
		dc.b	%10101101, %11101101, %10111101, %11111101
		dc.b	%10100111, %11100111, %10110111, %11110111
		dc.b	%10101111, %11101111, %10111111, %11111111


refreshStr1	dc.b	"Writing ram and waiting 30 Seconds.",0
refreshStr2	dc.b	"Done with wait.",0
refreshOKStr	dc.b	"Ram still valid refresh alive!!!",0
ramDiedStr	dc.b	"Ram dies refresh didn't happen.",0

PacketStr	dc.b	"    Command: ",$d,$a
		dc.b	"    Address: ",$d,$a
		dc.b	"    Length : ",$d,$a
		dc.b	"    X      : ",$d,$a
		dc.b	"    Y      : ",$d,$a,0

		even
CRC16Tab:
	dc.w $0000, $C0C1, $C181, $0140, $C301, $03C0, $0280, $C241
	dc.w $C601, $06C0, $0780, $C741, $0500, $C5C1, $C481, $0440
	dc.w $CC01, $0CC0, $0D80, $CD41, $0F00, $CFC1, $CE81, $0E40
	dc.w $0A00, $CAC1, $CB81, $0B40, $C901, $09C0, $0880, $C841
	dc.w $D801, $18C0, $1980, $D941, $1B00, $DBC1, $DA81, $1A40
	dc.w $1E00, $DEC1, $DF81, $1F40, $DD01, $1DC0, $1C80, $DC41
	dc.w $1400, $D4C1, $D581, $1540, $D701, $17C0, $1680, $D641
	dc.w $D201, $12C0, $1380, $D341, $1100, $D1C1, $D081, $1040
	dc.w $F001, $30C0, $3180, $F141, $3300, $F3C1, $F281, $3240
	dc.w $3600, $F6C1, $F781, $3740, $F501, $35C0, $3480, $F441
	dc.w $3C00, $FCC1, $FD81, $3D40, $FF01, $3FC0, $3E80, $FE41
	dc.w $FA01, $3AC0, $3B80, $FB41, $3900, $F9C1, $F881, $3840
	dc.w $2800, $E8C1, $E981, $2940, $EB01, $2BC0, $2A80, $EA41
	dc.w $EE01, $2EC0, $2F80, $EF41, $2D00, $EDC1, $EC81, $2C40
	dc.w $E401, $24C0, $2580, $E541, $2700, $E7C1, $E681, $2640
	dc.w $2200, $E2C1, $E381, $2340, $E101, $21C0, $2080, $E041
	dc.w $A001, $60C0, $6180, $A141, $6300, $A3C1, $A281, $6240
	dc.w $6600, $A6C1, $A781, $6740, $A501, $65C0, $6480, $A441
	dc.w $6C00, $ACC1, $AD81, $6D40, $AF01, $6FC0, $6E80, $AE41
	dc.w $AA01, $6AC0, $6B80, $AB41, $6900, $A9C1, $A881, $6840
	dc.w $7800, $B8C1, $B981, $7940, $BB01, $7BC0, $7A80, $BA41
	dc.w $BE01, $7EC0, $7F80, $BF41, $7D00, $BDC1, $BC81, $7C40
	dc.w $B401, $74C0, $7580, $B541, $7700, $B7C1, $B681, $7640
	dc.w $7200, $B2C1, $B381, $7340, $B101, $71C0, $7080, $B041
	dc.w $5000, $90C1, $9181, $5140, $9301, $53C0, $5280, $9241
	dc.w $9601, $56C0, $5780, $9741, $5500, $95C1, $9481, $5440
	dc.w $9C01, $5CC0, $5D80, $9D41, $5F00, $9FC1, $9E81, $5E40
	dc.w $5A00, $9AC1, $9B81, $5B40, $9901, $59C0, $5880, $9841
	dc.w $8801, $48C0, $4980, $8941, $4B00, $8BC1, $8A81, $4A40
	dc.w $4E00, $8EC1, $8F81, $4F40, $8D01, $4DC0, $4C80, $8C41
	dc.w $4400, $84C1, $8581, $4540, $8701, $47C0, $4680, $8641
	dc.w $8201, $42C0, $4380, $8341, $4100, $81C1, $8081, $4040

		objend

	 	even

		include	globals.i

	 	end




