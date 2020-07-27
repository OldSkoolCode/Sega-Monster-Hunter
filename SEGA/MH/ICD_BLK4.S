*
*
*		MEGA DRIVE hard initial program
*
*				1990 6/6
*			R/D 5 
*
*	++++++++++++++++++++++++++++++++++++++++++++++++++
*	+	status of MEGA_DRIVE on program_finished +
*	++++++++++++++++++++++++++++++++++++++++++++++++++
*
*	****************** 68000 *******************
*	--------- CAUTION -----------
*	When program end
*	* 68000  set RESET to Z80 ($A11100=0,$A11200=$000)
*	* Z80 wait [ JP  (HL)  ] command ( HL=0000 )
*
*   *************************************************************
*   *								*
*   *	ICD_END is GAME_PROGRAM start_address			*
*   *  	ICD_END = START+$100					*
*   *	this program size is just 256 byte.			*
*   *								*
*   *************************************************************

;program start
START:
		tst.l	$a10008		; power on check cntl_A,cntl_B
		bne.s	h_s		; reset hot_start
		tst.w	$a1000c		; power on check cntl_C
h_s:		bne.s	hot_start	; reset hot_start

cold_start:				; power on (cold_start)
		lea.l	reg_set(pc),a5	;register set table
		movem.w (a5)+,d5-d7	; d5/d6/d7
		movem.l (a5)+,a0-a4	; a0-a5

security:				; ** a1=$a11100 **
		move.b	-$10ff(a1),d0	;-$1101(a1)=$a10000
		andi.b	#$000f,d0	;Ver.No check
		beq.s	japan
		move.l	#'SEGA',$2f00(a1)
					;security part move "SEGA"
japan:					; $2F00(A1)=$A14000
reg_ini:
		move	(a4),d0		;VDP STATUS DUMMY READ (D5=$8000)
		moveq	#0,d0		; D0 set   0
		move.l	d0,a6		; A6 $00000000
		move.l	a6,usp		; User Stack Pointer
		moveq	#23,d1		; D1 count VDP_command
r_ini1:
		move.b	(a5)+,d5	;REG 0-23 SET (DMA FILL SET)
		move.w	d5,(a4)		;
		add	d7,d5		; d7=$100
		dbra	d1,r_ini1

dma_fill:				;already set REG#18,19,23
		move.l	(a5)+,(a4)	;dma fill(VDP_VRAM CLEAR)
		move	d0,(a3)		;fill data set $0,$C00000

z80_clr:				;Z80 self_initial
		move	d7,(a1)		; Z80_BUSREQ ON
		move	d7,(a2)		; Z80_RESET  OFF
z801:		btst	d0,(a1)		; Z80_BGACK  CHECK ?
		bne.s	z801
		moveq	#37,d2		; D2 is Z80_program's size
z802:		move.b	(a5)+,(a0)+	; move.B (z80_prg)+,($a00000)+
		dbra	d2,z802
		move	d0,(a2)		; Z80_RESET  ON
		move	d0,(a1)		; Z80_BUSREQ OFF
		move	d7,(a2)		; Z80_RESET  OFF(Z80 start)

clr_wk:					;A6=$0 D0=$0 D6=$3FFF
c_wk1:		move.l	d0,-(a6)	;wrok ram clear
		dbra 	d6,c_wk1	;

clr_col		move.l	(a5)+,(a4)	;VDP REG#1=04,#15=02
		move.l	(a5)+,(a4)	;a3=$c00000 a4=$c00004 d0=$0
		moveq	#$1f,d3		; d3 is color_ram's size/2(WORD)
c_col1:		move.l	d0,(a3)		;vdp_color clear
		dbra	d3,c_col1

clr_vsc:	move.l	(a5)+,(a4)	;a3=$c00000 a4=$c00004 d0=$0
		moveq	#19,d4		; d4 count Vscroll_ram
c_vsc1:		move.l	d0,(a3)		;vdp_vscroll clear
		dbra	d4,c_vsc1

clr_psg:	moveq	#3,d5		; d5 is byte_size of PSG init_DATA
c_psg1:		move.b	(a5)+,$11(a3)	;PSG_SOUND clear
		dbra	d5,c_psg1

		move	d0,(a2)		;Z80 RESET
		movem.l	(a6),d0-d7/a0-a6	;register all initial
		move	#$2700,sr	;68000 register initial 
hot_start:
		bra.s	chk_vdp		;
init_end:

reg_set:
	dc.w	$008000,$003fff,$000100			;d5/d6/d7
	dc.l	$a00000,$a11100,$a11200,$c00000		;a0-a3
	dc.l	$c00004					;a4

vreg_dt:
	dc.b	$04,$14,$30,$3c,$07,$6c,$00,$00		;VDP REG #0-7
	dc.b	$00,$00,$ff,$00,$81,$37,$00,$01		;VDP_REG #8-15
	dc.b	$01,$00,$00,$ff,$ff,$00,$00,$80		;VDP_REG #16-23
dma_fill_data:
	dc.l	$40000080		;dma fill(VDP_VRAM clear)

z80_prg:
	DC.B	$AF			;XOR	A
	DC.B	$01,$D9,$1F		;LD	BC,1FD9H
	DC.B	$11,$27,$00		;LD	DE,0027H
	DC.B	$21,$26,$00		;LD	HL,0026H
	DC.B	$F9			;LD	SP,HL
	DC.B	$77			;LD	(HL),A
	DC.B	$ED,$B0			;LDIR
	DC.B	$DD,$E1			;POP	IX
	DC.B	$FD,$E1			;POP	IY
	DC.B	$ED,$47			;LD	I,A
	DC.B	$ED,$4F			;LD	R,A
	DC.B	$D1			;POP	DE
	DC.B	$E1			;POP	HL
	DC.B	$F1			;POP	AF
	DC.B	$08			;EX	AF,AF'
	DC.B	$D9			;EXX
	DC.B	$C1			;POP	BC
	DC.B	$D1			;POP	DE
	DC.B	$E1			;POP	HL
	DC.B	$F1			;POP	AF
	DC.B	$F9			;LD	SP,HL
	DC.B	$F3			;DI
	DC.B	$ED,$56			;IM1
	DC.B	$36,$E9			;LD	(HL),$E9='JP (HL)'
	DC.B	$E9			;JP	(HL)
new_reg_data:
	dc.l	$81048f02		;VDP REG#1=04,#15=02
clr_col_data:
	dc.l	$c0000000		;color_ram address data
clr_vsc_data:
	dc.l	$40000010		;v_scroll ram address data

psg_dat:
	DC.B	$9F,$BF,$DF,$FF		;PSG initial data

chk_vdp:
	tst	$c00004
ICD_END:

