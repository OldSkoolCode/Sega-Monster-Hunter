


		include equates.i
		include macros.i

		xdef	VBlank,HInt,ExtInt
InitSP		equ	$ff8000
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

;		move.w	#$e000,_ScrAAddr
;		SetVdpRegister  02,%00111000   ; screen at $e000
;		SetVdpRegister  01,%01110100   ; Turn on the display
;		SetVdpRegister  16,%00000001   ; Map Size 64x32

		lea	mhdata,a0
		move.w	#14,d0
		bsr	crc16
		nop


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


VBlank:
HInt:
ExtInt:
		rte

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


mhdata:
	dc.w	$80
	dc.l	0
	dc.l	$8426
	dc.w	$a
	dc.w	$a
		incbin	mh.bin

		end
