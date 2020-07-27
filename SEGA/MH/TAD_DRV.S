*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*;                                                                           ;
*;              Project: TAD Driver                                          ;
*;                                                                           ;
*;               Module: TAD_DRV.S                                           ;
*;                                                                           ;
*; Module Creation Date: March, 1992                                         ;
*;                                                                           ;
*;               Author: J. Fort                                             ;
*;                                                                           ;
*;   Development System: SIERRA C                                            ;
*;                                                                           ;
*;    Copyright (c)1992, Western Technologies                                ;
*;                                                                           ;
*;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*
* TAD Driver - V0.00 (Engineering development)
*
* Functions in the module:
*
*  _TadVbi      TAD Vblank routine, will need to be modified by the user
*               to perform specific non-tad functions in the delay pds.
*               this function should be installed as the vertical blank
*               interrupt handler
*
*  _TadExt      TAD External interrupt routine. This should be installed
*               as the interrupt service routine for the Autovector 2
*               (EXT) interrupt. Also provides 2 level averaging of the
*               TAD position data.
*
*  _TadInit     Initializes the TAD ports and the VDP to generate the
*               interrupts and latch the H,V data. Most users will need
*               to modify this function.
*
*  _TadXYFixup  Adjusts the X,Y data of the tad to compensate for delays,
*               and some "features" of the Genesis hardware. Also fixes up
*               the button data and sets TadPrevButtons.
*
*  _TadCalibrateDriver
*               void TadCalibrateDriver(short Yoffset,short Xoffset,DWORD Multiplier)
*               Call to set new calibration values for the TAD system. The Yoffset
*               and X offset are signed words that define the error in the system.
*               the Multiplier is a 16.16 fixed point value (Hi word is the
*               integer part, lo word is the fractional part) that defines the
*               non-linearities in the system.
*
* Output from the module:
*
*       All output is via global variables. These variables are declared
*       in this module to reside in the .BSS segment. Other assmeblers
*       will need suitable code mods. The output is:
*
*  _TadXpos     WORD    output from TadXYFixup - this is the "cooked"
*                       tad X position
*
*  _TadYpos     WORD    output from TadXYFixup
*
*  _TadButtons  BYTE    Button data received from the TAD. Format:
*                        D7 | D6 | D5 | D4 | D3  | D2 | D1 | D0
*                       xxxx|xxxx|xxxx|xxxx|PAUSE|  C |FIRE|  A
*
*  _TadPrevButtons BYTE Value of previous TAD button read.
*
*
*  _TadOnScreen BYTE    0 if the tad was NOT pointed to the screen, 1 if it was.
*
* Revision History
*
*       3/92    -jf-    Original version.
*       5/92    -jf-    New averager, new calibration stuff added
*

*        opt p=68000

		include	equates.i
		include	macros.i
FAKEIT  EQU     0
* Define this to !0 to enable faked input with a master system gun
* and a joystick. The gun in B the stick in A

* Vdp register settings for TadInit
REG1            EQU     $64
REG11           EQU     $0a
REG0            EQU     $06

DATA_A          EQU     $A10003
DATA_B          EQU     $A10005
CTRL_B          EQU     $A1000B
HV_COUNT        EQU     $C00008

Z80DMABLOCK    EQU  $A01b20             ; Z80 can't read 68k space if set


AVGBUFFER       EQU     8
AVGLOG2         EQU     3

*****
* TSD
*****
joymov	equ	4
Ymin	equ	0+joymov
Ymax	equ	224-joymov
Xmin	equ	0+joymov
Xmax	equ	320-joymov
*****
* TSD
*****

*
* Size of the averaging buffer. Should be 4 or greater. Do NOT set lower
* than 4. Larger average buffers give greater accuracy
*

NORMALY         EQU     -$40
NORMALX         EQU     $4E

BssGroup	group	Bss

	        section .bss,BssGroup

* Publics

_TadXpos        DS.W    1       ; x position
_TadYpos        DS.W    1       ; y position
_TadButtons     DS.B    1       ; raw button data
_TadPrevButtons DS.B    1       ; Previous button data
_TadOnScreen    DS.B    1       ; True if the TAD is on the screen

* Locals
Filler          ds.b    1       ; Filler - keep it even.
LocalOn         DS.B    1
ButtonData      DS.B    1

Yoffset         DS.W    1       ; Y offset for calibration
Xoffset         DS.W    1       ; Previous X calibration point

TadFixupTable   DS.B    256     ; fixup array
AvgArray        DS.W    AVGBUFFER ; Array to store values in to average
AvgPtr          DS.L    1       ; queue pointer for the average

* Avg ptr must be immediately after avg array in memory - it's used to
* test overflow on the array.

LENGTHBSS	equ	*-_TadXpos
		inform	0,'length of bss = %d',LENGTHBSS

        section .text

****************************************************************************
* FUNCTION:    _TadVbi
* DESCRIPTION:  Interrupt handler for the vertical blank interrupt.
* RETURNS:      .
* PARAMETERS:   .
* SIDE EFFECTS:
* REVISIONS:    3/92    -jf-
****************************************************************************

*                                     0.13968 usec / clock cycle
*                                     clock cycles to handle interrupt    44

_TadVbi:
        movem.l d0/a0,-(sp)
        move.b  LocalOn,_TadOnScreen    ;                                 28
        clr.b   LocalOn             ;                                     12

	jsr	Vblank

        move.w    #$100,BUSREQ        	; Z80 bus request on
hzlp    btst.b    #0,BUSREQ      	; spin on bus grant
        bne.s     hzlp

	tst.w	d0			; did some dma?
	bne.s	noTad			; yep don't read tad


        move.w  #161,d0             ;                                      8
t1dlay: dbra    d0,t1dlay           ; loop timing =           10(d0 + 1) + 2
        nop                         ; Just for timing                      4
        move.b  #%11111111,DATA_B   ; Set TR and TL High                  20

*       Long Pulse Starts Here         1722 cc /  240.53 usec from interrupt

        nop                         ; Just for timing                      4
        nop                         ;                                      4
        nop                         ;                                      4
        nop                         ;                                      4
        nop                         ;                                      4
        move.w  #60,d0              ;                                      8
        move.b  #%11011111,DATA_B   ; Set TR low                          20

*       End of Long Pulse (t2)           88 cc /   12.29 usec long
*       Delay Starts Here (t3)

t3dlay: dbra    d0,t3dlay           ; loop timing =           10(d0 + 1) + 2
        move.b  #%11111111,DATA_B   ; Set TR and TL High                  20

*       End of Delay (t3)               632 cc /   88.28 usec
*       Short Pulse Begins Here (t4)

        nop                         ; Just for timing                      4
        move.b  #%11011111,DATA_B   ;                                     20

*       End of Tiny Pulse (t4)           24 cc /    3.35 usec
*       Beginning of Delay Before Button Read (t5)

        move.w  #1068,d0            ;                                       8
t5dlay: dbra    d0,t5dlay           ; loop timing =            10(d0 + 1) + 2
        move.b  DATA_B,d0           ; Get Button Data                      16

*       End of Delay                  10716 cc / 1496.81 usec from tiny pulse
*                                     11460 cc / 1600.73 usec from long pulse
*                                     13182 cc / 1841.26 usec from interrupt

;        not.b   d0                  ; Convert to normally high
        move.b  d0,ButtonData
noTad:
*****
*	Begin Addition for Joystick Support TSD
*****
	cmp.b	#0,_TadOnScreen
	bne	no_JOY		; skip if TAD is available
	; clear button data
	clr.b	_TADButtons
	jsr	ScanJoy1	; get joystick 1 data
	move.b	d0,joy1Data
	; d0 has joystick data
	cmp.b	#$FF,d0		; check for any data at all
	beq	exit_JOY
        addq.b  #1,_TadOnScreen
        move.b  _TadButtons,_TadPrevButtons

				; up - dn - lt - rt - b - c - a - st
	; check for UP
	lsr.b	#1,d0		;check bit
	bcs.s	not_UP		;skip if up
	cmp.w	#Ymin,_TADYpos	; check for boundary
	ble.s	not_up
	subq.w	#joyMov,_TADYpos
not_UP:
	; check for DOWN
	lsr.b	#1,d0
	bcs.s	not_DN
	cmp.w	#Ymax,_TADYpos	; check for boundary
	bge.s	not_DN
	addq.w	#joyMov,_TADYpos
not_DN:
	; check for LEFT
	lsr.b	#1,d0
	bcs.s	not_LT
	cmp.w	#Xmin,_TADXpos	; check for boundary
	ble.s	not_LT
	subq.w	#joyMov,_TADXpos
not_LT:
	; check for RIGHT
	lsr.b	#1,d0
	bcs.s	not_RT
	cmp.w	#Xmax,_TADXpos	; check for boundary
	bge.s	not_RT
	addq.w	#joyMov,_TADXpos
not_RT:
	; check for B button
	lsr.b	#1,d0
	bcs.s	not_B
	or.b	#2,_TADButtons
not_B:
	; check for C button
	lsr.b	#1,d0
	bcs.s	not_C
	or.b	#4,_TADButtons
not_C:
	; check for A button
	lsr.b	#1,d0
	bcs.s	not_A
	or.b	#1,_TADButtons
not_A:
	; check for START button
	lsr.b	#1,d0
	bcs.s	exit_JOY
	or.b	#8,_TADButtons
	bra.s	exit_JOY
no_JOY:
	jsr	_TadXYFixup
*****
*	End Addition for Joystick Support TSD
*****
exit_JOY:
        move.b  #%11111111,DATA_B
        nop
        move.b  #%11001111,DATA_B   ; TR high, then TR and TL low again

	move.b    #0,Z80DMABLOCK	; say dma is fine again
	move.w    #$0,BUSREQ          ; Z80 bus request off

	jsr	updateCrossHair
	if	(SNASM)
	trap	#0
	endif
        movem.l (a7)+,d0/a0
        rte

****************************************************************************
* FUNCTION:    _TadExt
* DESCRIPTION:  Interrupt handler for the external interrupt
* RETURNS:      .
* PARAMETERS:   .
* SIDE EFFECTS:
* REVISIONS:    3/92    -jf-
****************************************************************************
_TadExt:
        cmp.b   #0,LocalOn
        bne     TE_1            ; get out if we've already hit the ext int
        move.w  d0,-(a7)
        move.l  A0,-(a7)
        move.w  HV_COUNT,d0
        move.l  AvgPtr,A0       ; get queue pointer
        move.w  D0,(A0)+        ; save data
        cmp.l   #AvgPtr,A0
        bne     TE_0
        lea     AvgArray,A0     ; update for roll-overs.
TE_0:   move.l  A0,AvgPtr
        addq.b  #1,LocalOn
        move.l  (a7)+,A0
        move.w  (a7)+,d0
TE_1:
        rte

****************************************************************************
* FUNCTION:    _TadInit
* DESCRIPTION:  Initializes the Genesis for use with the TAD
* RETURNS:      .
* PARAMETERS:   .
* SIDE EFFECTS: CHANGES VDP REGISTERS, EXITS WITH SR=$2000
* REVISIONS:    3/92    -jf-
****************************************************************************
_TadInit:
        move.w  #NORMALY,Yoffset
        move.w  #NORMALX,Xoffset
        move.l  #$00012000,-(sp)
        move.l  #0,-(sp)
        move.l  #0,-(sp)
        jsr     _TadCalibrateDriver
        add.l   #12,sp
        move.w  #$2700,SR
        lea     AvgArray,a0
        move.l  a0,AvgPtr
        SetVdpRegister  1,REG1          ; Enable v ints
        SetVdpRegister  11,REG11        ; Enablle Ext Ints
        move.b  #$B0,CTRL_B             ; Port B generates ints, D5 is output
        SetVdpRegister  0,REG0          ; Latch H,V count
	sf	_TadPrevButtons
*****
* TSD
*****
	; init TAD position to middle of screen
	move.w	#Xmax/2,_TADXpos
	move.w	#Ymax/2,_TADYpos
        move.w  #$2000,SR
        rts


*	XDEF	_SelectAccuSight
****************************************************************************
* FUNCTION:    _TadInit
* DESCRIPTION:  Does Tad Calibration & calls TadInit
* RETURNS:      TRUE if cursor requested, FALSE othw
* PARAMETERS:   none
* SIDE EFFECTS: 
* REVISIONS:    7/16 MLV
****************************************************************************
_SelectAccuSight:
	jsr	_TadInit		; initialize tad driver
	moveq	#1,d0			; request accusight hardwired here
	rts

*        xdef    _TadCalibrateDriver
****************************************************************************
*
*       void TadCalibrateDriver(short Yoffset,short Xoffset,DWORD Multiplier)
*
* DESCRIPTION:  Creates the initial fixup table - use for calibration
* RETURNS:      .
* PARAMETERS:   short y offset from the PREVIOUS calibration
*               short x offset from the PREVIOUS calibration
*               dword 16:16 fixed point adder to the pixel position. - Use to
*                correct for non lineraties
* SIDE EFFECTS:
* REVISIONS:    5/92    -jf-
****************************************************************************
_TadCalibrateDriver:
        move.w  6(sp),d0
        add.w   d0,Yoffset              ; Adjust the Y position
* FIll the array with 0's
        clr.l   d2
        lea     TadFixupTable,a0
        move.w  #255,d0
CFT_0:  move.b  d2,(a0,d0)
        dbra    d0,CFT_0

        move.w  Xoffset,d0
        add.w   10(sp),d0
        add.w   d0,Xoffset              ; Set up new X offset start value
        move.l  12(sp),d1               ; get adder off the stack
        move.b  #$ff,-20(a0,d0)         ; flag end of the array. This value may need to be adjusted..

* Fill the table out to the non-linearity at $B6
CFT_1:
        cmp.b   #$B6,d0
        beq     CFT_2                   ; goto CFT_2 when we hit the bad spot
        swap    d2
        move.b  d2,(a0,d0)              ; store the output counter in the array
        swap    d2
        addq.b  #1,d0
        add.l   d1,d2                   ; do the offset stuff
        bra     CFT_1

* We're into the non-linearity - fill it up until we get to E5 - the end of the problem area
CFT_2:
        cmp.b   #$e5,d0
        beq     CFT_3
        swap    d2
        move.b  d2,(a0,d0)
        swap    d2
        addq.b  #1,d0
        bra     CFT_2

* Out of the non-linear spot... keep filling
CFT_3:
        cmp.b   #$ff,(a0,d0)
        beq     CFT_X           ; Get out when we've gone all the way thru
        swap    d2
        cmp.w   #160,d2         ; Is over max Y possible position?
        bhi     CFT_5
CFT_4:  move.b  d2,(a0,d0)
        swap    d2
        addq.b  #1,d0
        add.l   d1,d2                   ; do the offset stuff
        bra     CFT_3
CFT_5:  move.w  #160,d2
        bra     CFT_4

CFT_X:  rts



****************************************************************************
* FUNCTION:    _TadXYFixup
* DESCRIPTION:  Converts the TAD x,y positions to accurate values, performes
*               all averaging here. Also fixes up the button data
* RETURNS:      Places return values in TadXpos TadYpos
* PARAMETERS:   Uses values from the AvgArray
* SIDE EFFECTS:
* REVISIONS:    3/92    -jf-
*               5/92    -jf- New averager
****************************************************************************
_TadXYFixup:
        move.b  _TadButtons,_TadPrevButtons
        move.b  ButtonData,_TadButtons  ; Set up the button data

        tst.b   _TadOnScreen            ; See if the TAD is on screen or not
        beq     TF_NoTad                ; nope, goto TF_NoTad

* Set up the averager
        movem.l  d0-d2/d7/a1,-(sp)
        move.l  AvgPtr,a0               ; A0 is the average pointer
        lea     TadFixupTable,a1        ; A1 points at the x fixup table
        move.w  #(AVGBUFFER-1),D7       ; setup the counter in D7
        clr.l   d0                      ; d0 is X accumulator
        clr.l   d1                      ; d1 is Y accumulator
        clr.l   d2

TF_1:   cmp.l   #AvgArray,a0            ; Are we at the begining of the array?
        bne     TF_2                    ; no, goto TF_2
        lea     AvgPtr,a0               ; Yes, grab the address just past the END of the array
TF_2:
        move.b  -(a0),D2                ; Get X value from the table
        move.b  (a1,d2),d2              ; look up the fixedup value
        add.w   d2,d0                   ; Add it into the accumulator
        move.b  -(a0),D2                ; Get Y value from the table
        add.w   d2,d1                   ; Add it into the accumulator
        dbra    d7,TF_1                 ; loop to add all up
*
* Now we have accumulated the data, let's find the averages
*
        lsr.w   #(AVGLOG2-1),d0         ; d0 = New Averaged X position
        move.w  d0,_TadXpos
        lsr.w   #AVGLOG2,d1             ; d1 = New Averaged Y position
;        add.w   Yoffset,d1
        move.w  d1,_TadYpos

TF_X:   movem.l  (sp)+,d0-d2/d7/a1
        rts

* We'll get here if we have no tad on the screen.
TF_NoTad:
        rts                             ; and get out with same X and Y values


**************************************************************************
**         SCAN JOYSTICK INTERFACE AND GENERATE HIT AND HELD INFO        *
**************************************************************************

ScanJoy1	Module
	movem.l	d1/a0,-(sp)	; save used registers
	lea	DATA_A,a0	;point to hardware

	move.b	#$00,(a0)	;TH=0
	nop
	nop			;wait
	move.b	(a0),d0		;get bits 6..7 (in 4..5)
	lsl.w	#2,d0		;move to 6..7
	move.b	#$40,(a0)	;TH=1
	and.w	#$C0,d0		;mask 6..7
	move.b	(a0),d1		;get 0..5

 	and.w	#$3f,d1		;mask 0..5
	or.w	d1,d0		;combine (top byte of word=0)

	movem.l	(sp)+,d1/a0	; restore used registers
	rts
	MODEnd

	include	globals.i
	end


