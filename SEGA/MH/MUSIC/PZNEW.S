 LIST B,CASE,E
 INCLUDE ZMAC.MAC

COM equ 0
LEV equ 4
ATK equ 8
DKY equ 12
SLV equ 16
RRT equ 20
MODE equ 24
DTL equ 28
DTH equ 32
ALV equ 36
FLG equ 40

*****************************************************************************
* set stack, enable vertical interrupt and loop

			org     0

			ld      HL,1F00H        ; set stack
			ld      SP,HL
			di                      ; disable interrupts
			im      1               ; set interrupt mode
			ei                      ; enable interrupts
pause:      jp      pause           ; forever


*****************************************************************************
*** vertical interrupt routine (sound interpreter code part 2 of 2)

			org     38H

vblint:     push    AF              ; save registers
			push    BC
			push    DE
			push    HL
			push    IX
			push    IY
			ex      AF,AF'          ; swap registers
			exx                     ; swap registers
			push    AF              ; save registers
			push    BC
			push    DE
			push    HL
			ex      AF,AF'          ; swap registers
			exx                     ; swap registers

*** channel/melody prioritizer

			ld      IY,meltab       ; load melody control block pointer
			ld      A,(melnum)      ; load loop counter
			ld      E,A             ; copy loop counter into E
ploop:      xor     A               ; clear A
			ld      B,A             ; clear B
			cp      (IY+4)          ; test low byte of melody pointer
			jr      NZ,pgo          ; melody is active
			cp      (IY+5)          ; test high byte of melody pointer
			jr      Z,pedlp         ; melody is inactive
pgo:        ld      A,(IY+0CH)      ; load channel number
			sla     A               ; * 2 for word offset
			ld      C,A             ; copy into C
			ld      IX,chpri        ; load channel priority table
			add     IX,BC           ; add channel offset
			ld      D,(IY+0DH)      ; load melody's priority
			ld      B,(IX+1)        ; load channel's melody pointer.high
			ld      C,(IX+0)        ; load channel's melody pointer.low
			xor     A               ; clear A
			cp      B               ; test channel's melody pointer.high
			jr      NZ,chkpri       ; melody running, have to check priority
			cp      C               ; test channel's melody pointer.low
			jr      Z,givep1        ; channel is clear, melody gets priority
chkpri:     ld      H,B             ; HL <- BC
			ld      L,C
			ld      B,0             ; BC <- 0D
			ld      C,0DH
			add     HL,BC           ; HL += 0D
			ld      A,(HL)          ; load channel's melody's priority
			cp      D               ; compare with melody's priority
			jr      C,givep         ; give this melody priority
			ld      (IY+13H),0      ; this melody does not have priority
			ld      C,6             ; BC <- 06
			add     HL,BC           ; point to channel's melody's flag
			ld      (HL),1          ; give it priority
			jr      pedlp           ; next melody
givep:      ld      C,6             ; BC <- 06
			add     HL,BC           ; point to channel's melody's flag
			ld      (HL),0          ; kill it's priority
givep1:     ld      (IY+13H),1      ; this melody has priority
			push    IY              ; save IY (current melody pointer) on stack
			pop     BC              ; load BC from stack
			ld      (IX+1),B        ; save pointer to melody
			ld      (IX+0),C        ; save pointer to melody
pedlp:      ld      BC,MELBLK       ; load size of melody control block
			add     IY,BC           ; point to next melody control block
			dec     E               ; decrement counter
			jr      NZ,ploop        ; until done

*** melody stream processor

			ld      IY,meltab       ; load melody control block pointer
			ld      A,(melnum)      ; load loop counter
			ld      E,A             ; loop counter in E
mloop:      ld      H,(IY+5)        ; load melody pointer.high
			ld      L,(IY+4)        ; load melody pointer.low
			xor     A               ; clear A
			cp      H               ; check melody pointer.high
			jr      NZ,running      ; melody is running
			cp      L               ; check melody pointer.low
			jp      Z,medlp         ; melody is not running

* E loop counter
* HL *melody stream
* IY *melody control block

running:    ld      A,(IY+0FH)      ; load delay counter
			cp      0               ; test delay counter
			jp      NZ,mdelay       ; delay is in progress

iload:      ld      A,(HL)          ; load instruction word
			inc     HL              ; increment instruction pointer

testdel:    cp      80H             ; test for delay instruction
			jp      NC,newdel       ; delay instruction encountered

test0:      cp      0               ; test for stop instruction
			jr      NZ,test1        ; not stop

istop:      ld      A,(IY+13H)      ; load playing flag
			cp      0               ; test for note playing
			jr      Z,keystp        ; note is not playing, issue a stop
			ld      A,(IY+0CH)      ; load channel number
			ld      C,A             ; copy into C
			sla     C               ; c*2 for offset
			ld      B,0             ; B=0
			ld      IX,chpri        ; load channel priority table
			add     IX,BC           ; add channel offset * 2
			ld      (IX+0),0        ; clear channel reference.high
			ld      (IX+1),0        ; clear channel reference.low
			call    KEYOFF          ; key off channel A
keystp:     ld      (IY+4),0        ; clear melody stream pointer.high
			ld      (IY+5),0        ; clear melody stream pointer.low
			ld      (IY+8),0        ; clear user vector.high
			ld      (IY+9),0        ; clear user vector.low
			ld      (IY+12H),0      ; indicate note is off
			ld      (IY+13H),0      ; clear melody's priority
			jp      medlp           ; stop instruction processed

test1:      cp      1               ; test for key on instruction
			jr      NZ,test2        ; nope...

keyon:      push    DE              ; save loop counter
			ld      D,(HL)          ; load frequency msb
			inc     HL              ; next instruction word
			ld      E,(HL)          ; load frequency lsb
			inc     HL              ; next instruction word
			ld      (IY+10H),D      ; save frequency msb
			ld      (IY+11H),E      ; save frequency lsb
			ld      (IY+12H),1      ; indicate note is on
			xor     A               ; A <- 0
			cp      (IY+13H)        ; test channel's priority
			jr      Z,kodone        ; no priority, don't key on
			ld      A,(IY+0CH)      ; load channel number
			ld      C,(IY+0EH)      ; load instrument number
			call    KEYON           ; key on
kodone:     pop     DE              ; restore loop counter
			jp      idone           ; key on processed

test2:      cp      2               ; check for key off command
			jr      NZ,test3        ; nope...

keyoff:     xor     A               ; A <- 0
			cp      (IY+13H)        ; test for note playing
			jr      Z,keykil        ; note is not playing
			ld      A,(IY+0CH)      ; load channel number
			call    KEYOFF          ; key off
keykil:     ld      (IY+12H),0      ; indicate note is off
			jp      idone           ; done

test3:      cp      3               ; pitch bend command?
			jr      NZ,test4        ; nope...

pbend:      push    DE              ; save E
			ld      D,(HL)          ; load new pitch msb
			inc     HL              ; next instruction word
			ld      E,(HL)          ; load new pitch lsb
			inc     HL              ; next instruction word
			ld      (IY+10H),D      ; save frequency msb
			ld      (IY+11H),E      ; save frequency lsb
			xor     A               ; A <- 0
			cp      (IY+13H)        ; test for note playing
			jr      Z,pbdone        ; note is not playing
			ld      A,(IY+0CH)      ; load channel number
			call    PBEND           ; pitch bend
pbdone:     pop     DE              ; restore E
			jp      idone           ; done

test4:      cp      4               ; instrument change?
			jr      NZ,test5        ; nope...

ichng:      ld      A,(HL)          ; load new instrument number
			inc     HL              ; next instruction word
			ld      (IY+0EH),A      ; write new instrument number
			jr      idone           ; done

test5:      cp      5               ; loop instruction?
			jr      NZ,test6        ; nope...

iloop:      ld      C,(IY+20)       ; load loop index
			ld      D,C             ; save in D
			sla     C               ; *2 for word offset
			ld      B,0             ; clear B
			ld      A,22            ; loop counters offset
			add     A,C               ; BC+=A
			ld      C,A             ; ...
			push    IY              ; IY on stack
			pop     IX              ; IX off stack
			add     IX,BC           ; index to loop counter
			ld      A,(HL)          ; load loop count high
			inc     HL              ; next instruction word
			ld      (IX+0),A        ; save loop count high
			ld      A,(HL)          ; load loop count low
			inc     HL              ; next instruction word
			ld      (IX+1),A        ; save loop count low
			inc     D               ; increment loop counter index
			ld      (IY+20),D       ; save loop counter index
			jr      idone           ; done

test6:      cp      6               ; test for endloop instruction
			jr      NZ,test7        ; nope...

iedlp:      ld      C,(IY+20)       ; load loop counter index
			sla     C               ; *2 for word offset
			ld      B,0             ; B=0
			ld      A,20            ; load loop counter index offset
			add     A,C               ; C+=loop counter index offset
			ld      C,A             ; ...
			push    IY              ; push mcb
			pop     IX              ; pop mcb
			add     IX,BC           ; point to loop counter
			push    DE              ; save E
			ld      D,(IX+0)        ; load loop counter msb
			ld      E,(IX+1)        ; load loop counter lsb
			dec     DE              ; decrement loop counter

			ld 	A,D		;BURT FIX
			OR 	E		;BURT FIX


			jr      Z,lpdone        ; loop finished...
			ld      (IX+0),D        ; save loop counter msb
			ld      (IX+1),E        ; save loop counter lsb
			ld      B,(HL)          ; load relative offset msb
			inc     HL              ; next instruction word
			ld      C,(HL)          ; load relative offset lsb
			inc     HL              ; next instruction word
			add     HL,BC           ; branch (almost)
			inc     HL              ; skip over loop instruction...
			inc     HL
			inc     HL
			pop     DE              ; restore E
			jr      idone           ; done
lpdone:     inc     HL              ; skip over relative branch
			inc     HL
			pop     DE              ; restore E

			DEC	(IY+20)		;BURT FIX

			jr      idone           ; done


test7:      cp      7               ; test for install user vector instruction
			jr      NZ,test8        ; nope...

insusr:     ld      A,(HL)          ; load user vector msb
			inc     HL              ; next instruction word
			ld      (IY+8),A        ; save user vector msb
			ld      A,(HL)          ; load user vector lsb
			inc     HL              ; next instruction word
			ld      (IY+9),A        ; save user vector lsb
			jr      idone           ; done

test8:      cp      8               ; test for relative branch instruction
			jr      NZ,idone        ; nope...

ibrch:      ld      B,(HL)          ; load relative offset msb
			inc     HL              ; next instruction word
			ld      C,(HL)          ; load relative offset lsb
			inc     HL              ; next instruction word
			add     HL,BC           ; branch

idone:      ld      (IY+5),H        ; save melody instruction address msb
			ld      (IY+4),L        ; save melody instruction address lsb
			jp      iload           ; process next instruction

newdel:     and     7FH             ; fix delay amount
			ld      (IY+0FH),A      ; save it
			ld      (IY+5),H        ; save melody instruction address msb
			ld      (IY+4),L        ; save melody instruction address lsb

mdelay:     dec     (IY+0FH)        ; decrement delay counter

muser:      ld      H,(IY+8)        ; load user vector msb
			ld      L,(IY+9)        ; load user vector lsb
			xor     A               ; clear A
			cp      H               ; msb?
			jp      NZ,douser       ; execute user vector
			cp      L               ; lsb?
			jr      Z,medlp         ; empty vector, don't call
douser:     push    IY              ; save regs
			push    DE
			ld      (stupid+1),HL   ; write user vector
stupid:     call    muser           ; execute user vector
			pop     DE              ; restore regs
			pop     IY

medlp:      ld      BC,MELBLK       ; load melody control block size
			add     IY,BC           ; point to next mcb
			dec     E               ; decrement count
			jp      NZ,mloop        ; until done

*** psg command processor/envelope emulator

			ld      IY,psgcom       ; load psg pseudo registers
			ld      HL,7F11H        ; load hardware register address
			ld      D,80H           ; load command mask
			ld      E,4             ; load loop counter

vloop:      ld      C,(IY+COM)      ; load command bits
			ld      (IY+COM),0      ; clear command bits

stop:       bit     2,C             ; test bit 2
			jr      Z,ckof          ; nope...
			ld      (IY+LEV),0FFH   ; reset output level
			ld      (IY+FLG),1      ; flag hardware update
			ld      (IY+MODE),0     ; shut off envelope processing

ckof:       bit     1,C             ; test bit 1
			jr      Z,ckon          ; nope...
			ld      A,(IY+MODE)     ; load envelope mode
			cp      0               ; check for key on
			jr      Z,ckon          ; nope...
			ld      (IY+FLG),1      ; flag hardware update
			ld      (IY+MODE),4     ; switch to envelope release phase

ckon:       bit     0,C             ; test bit 0
			jr      Z,envproc       ; nope...
			ld      (IY+LEV),0FFH   ; reset level
			ld      A,(IY+DTL)      ; load tone lsb
			or      D               ; mix with command stuff
			ld      (HL),A          ; write tone lsb or noise data

;			xor     A               ; reset A BURT FIX
			ld 	A,1		;BURT FIX

			cp      E               ; check for last channel
			jr      Z,nskip         ; skip msb set (noise channel)
			ld      A,(IY+DTH)      ; load tone msb
			ld      (HL),A          ; write tone msb
nskip:      ld      (IY+FLG),1      ; flag hardware update
			ld      (IY+MODE),1     ; initiate envelope processing (attack phase)

envproc:    ld      A,(IY+MODE)     ; load envelope phase
			cp      0               ; test for on/off
			jr      Z,vedlp         ; off.
			cp      1               ; attack mode?
			jr      NZ,chk2         ; nope...

mode1:      ld      (IY+FLG),1      ; flag hardware update
			ld      A,(IY+LEV)      ; load level
			ld      B,(IY+ALV)      ; load attack level
			sub     (IY+ATK)        ; subtract attack rate
			jr      C,atkend        ; attack finished
			jr      Z,atkend        ; attack finished
			cp      B               ; test level
			jr      C,atkend        ; attack finished
			jr      Z,atkend        ; attack finished
			ld      (IY+LEV),A      ; save new level
			jr      vedlp           ; done
atkend:     ld      (IY+LEV),B      ; save attack level as new level
			ld      (IY+MODE),2     ; switch to decay mode
			jr      vedlp           ; done

chk2:       cp      2               ; decay mode?
			jp      NZ,chk4         ; nope...

mode2:      ld      (IY+FLG),1      ; flag hardware update
			ld      A,(IY+LEV)      ; load level
			ld      B,(IY+SLV)      ; load sustain level
			cp      B               ; compare levels
			jr      C,dkadd         ; add to decay
			jr      Z,dkyend        ; decay finished
			sub     (IY+DKY)        ; subtract decay rate
			cp      B               ; compare levels
			jr      C,dkyend        ; decay finished
			jr      dksav           ; save decay
dkadd:      add     A,(IY+DKY)      ; add decay rate
			cp      B               ; compare levels
			jr      NC,dkyend       ; decay finished
dksav:      ld      (IY+LEV),A      ; save level
			jr      vedlp           ; done
dkyend:     ld      (IY+LEV),B      ; save sustain level
			ld      (IY+MODE),3     ; set sustain mode
			jr      vedlp           ; done

chk4:       cp      4               ; check for sustain phase
			jr      NZ,vedlp        ; nope
mode4:      ld      (IY+FLG),1      ; flag hardware update
			ld      A,(IY+LEV)      ; load level
			add     A,(IY+RRT)      ; add release rate
			jr      C,killenv       ; release finished
			ld      (IY+LEV),A      ; save new level
			jr      vedlp           ; done
killenv:    ld      (IY+LEV),0FFH   ; reset level
			ld      (IY+MODE),0     ; reset envelope mode

vedlp:      inc     IY              ; point to next channel registers
			ld      A,20H           ; for tone command byte fixup
			add     A,D             ; add tone command byte
			ld      D,A             ; move back into D
			dec     E               ; decrement counter

			jp      NZ,vloop        ; until done BURT FIX

			ld      IY,psgcom       ; reset psg envelope pointer

uch1:       bit     0,(IY+FLG)      ; test update flag
			jr      Z,uch2          ; next channel
			ld      (IY+FLG),0      ; clear update flag
			ld      A,(IY+LEV)      ; load level
			srl     A
			srl     A
			srl     A
			srl     A
			or      90H             ; set command bits
			ld      (HL),A          ; write new level

uch2:       bit     0,(IY+FLG+1)    ; test update flag
			jr      Z,uch3          ; next channel
			ld      (IY+FLG+1),0    ; clear update flag
			ld      A,(IY+LEV+1)    ; load level
			srl     A
			srl     A
			srl     A
			srl     A
			or      0B0H            ; set command bits
			ld      (HL),A          ; write new level

uch3:       bit     0,(IY+FLG+2)    ; test update flag
			jr      Z,uch4          ; next channel
			ld      (IY+FLG+2),0    ; clear update flag
			ld      A,(IY+LEV+2)    ; load level
			srl     A
			srl     A
			srl     A
			srl     A
			or      0D0H            ; set command bits
			ld      (HL),A          ; write new level

uch4:       bit     0,(IY+FLG+3)    ; test update flag
			jr      Z,vquit         ; next channel
			ld      (IY+FLG+3),0    ; clear update flag
			ld      A,(IY+LEV+3)    ; load level
			srl     A
			srl     A
			srl     A
			srl     A
			or      0F0H            ; set command bits
			ld      (HL),A          ; write new level

vquit:      ex      AF,AF'          ; restore registers
			exx
			pop     HL
			pop     DE
			pop     BC
			pop     AF
			ex      AF,AF'
			exx
			pop     IY
			pop     IX
			pop     HL
			pop     DE
			pop     BC
			pop     AF
			ei                      ; re-enable interrupts
			reti                    ; return from interrupt

*****************************************************************************
*** hardware write routines (sound interpreter code part 1 of 2)

	; parameters channel(A), insnum(C), freqh(D), freql(E)
	; preserves IY,HL
KEYON:      push    IY              ; save IY
			push    HL              ; save HL
			cp      6               ; (channel-6)
			jp      NC,psgon        ; psg channel...
	fmon:   mul38                   ; calculate instrument offset (into HL)
			ld      B,H             ; BC <- HL
			ld      C,L             ; ...
			ld      IX,fminst       ; load fm instrument table into IX
			add     IX,BC           ; point to correct instrument (in IX)
			ld      IY,chsust       ; load channel sustain table into IY
			ld      C,A             ; C <- channel number
			ld      B,0             ; B <- 0
			add     IY,BC           ; point to sustain byte (IY)
			ld      B,(IX+25H)      ; load sustain byte
			ld      (IY+0),B        ; write sustain byte in table
			ld      H,0             ; clear channel 3 mode
			cp      3               ; check for > channel 3
			jr      NC,fmchc        ; channel 3-5
			cp      2               ; check for channel 3
			jr      NZ,fmnorm       ; normal channel (not 3)
			ld      H,(IX+1H)       ; load channel 3 mode (on or off)
fmnorm:     ld      IY,4000H        ; load channels 0-2 register select
			ld      C,A             ; load key on code
			jr      fminsw          ; go write instrument data
fmchc:      ld      IY,4002H        ; load channels 3-5 register select
			ld      C,A             ; C = A channel number
			inc     C               ; C += 1 for key on code
			sub     3               ; A -= 3 for channel select code
fminsw:     ld      B,A             ; copy channel select code into B
			ld      L,27H           ; register to write in L
			FMwrgl                  ; write channel 3 mode
			ld      H,(IX+0)        ; load lfo data
			ld      L,22H           ; load register number
			FMwrgl                  ; write lfo register

* Register usage
*   B channel select code
*   C key on code
*   D freqH
*   E freqL
*   IX *instrument
*   IY *fmchip register

			FMWrch  0B0H,B,(IX+2)   ; set feedback, algorithm
			FMWrch  0B4H,B,(IX+3)   ; set output, ams, fms
			FMWrch  30H,B,(IX+4)    ; set detune, mult
			FMWrch  40H,B,(IX+5)    ; set total level
			FMWrch  50H,B,(IX+6)    ; set rate scaling, attack rate
			FMWrch  60H,B,(IX+7)    ; set am enable, decay rate
			FMWrch  70H,B,(IX+8)    ; set sustain decay rate
			FMWrch  80H,B,(IX+9)    ; set sustain level, release rate
			FMWrch  90H,B,0         ; set proprietary register
			FMWrch  34H,B,(IX+10)   ; set detune, mult
			FMWrch  44H,B,(IX+11)   ; set total level
			FMWrch  54H,B,(IX+12)   ; set rate scaling, attack rate
			FMWrch  64H,B,(IX+13)   ; set am enable, decay rate
			FMWrch  74H,B,(IX+14)   ; set sustain decay rate
			FMWrch  84H,B,(IX+15)   ; set sustain level, release rate
			FMWrch  94H,B,0         ; set proprietary register
			FMWrch  38H,B,(IX+16)   ; set detune, mult
			FMWrch  48H,B,(IX+17)   ; set total level
			FMWrch  58H,B,(IX+18)   ; set rate scaling, attack rate
			FMWrch  68H,B,(IX+19)   ; set am enable, decay rate
			FMWrch  78H,B,(IX+20)   ; set sustain decay rate
			FMWrch  88H,B,(IX+21)   ; set sustain level, release rate
			FMWrch  98H,B,0         ; set proprietary register
			FMWrch  3CH,B,(IX+22)   ; set detune, mult
			FMWrch  4CH,B,(IX+23)   ; set total level
			FMWrch  5CH,B,(IX+24)   ; set rate scaling, attack rate
			FMWrch  6CH,B,(IX+25)   ; set am enable, decay rate
			FMWrch  7CH,B,(IX+26)   ; set sustain decay rate
			FMWrch  8CH,B,(IX+27)   ; set sustain level, release rate
			FMWrch  9CH,B,0         ; set proprietary register
			bit     6,(IX+1)        ; check channel 3 mode
			jr      NZ,fmc3on       ; go set channel 3 frequency
			FMWrch  0A4H,B,D        ; set frequency msb
			FMWrch  0A0H,B,E        ; set frequency lsb
			jp      fmkon           ; go key on
fmc3on:     FMWrite 0A6H,(IX+28)    ; ch3 op1 msb
			FMWrite 0A2H,(IX+29)    ; ch3 op1 lsb
			FMWrite 0ACH,(IX+30)    ; ch3 op2 msb
			FMWrite 0A8H,(IX+31)    ; ch3 op2 lsb
			FMWrite 0ADH,(IX+32)    ; ch3 op3 msb
			FMWrite 0A9H,(IX+33)    ; ch3 op3 lsb
			FMWrite 0AEH,(IX+34)    ; ch3 op4 msb
			FMWrite 0AAH,(IX+35)    ; ch3 op4 lsb
fmkon:      ld      A,(IX+36)       ; load operator on mask
			sla     A               ; fix significance
			sla     A
			sla     A
			sla     A
			or      C               ; mix with channel code
			ld      IY,4000H        ; global fm register
			FMWrite 28H,A           ; key on
			pop     HL              ; restore HL
			pop     IY              ; restore IY
			ret                     ; done
psgon:      mul6                    ; calculate instrument offset (into HL)
			ld      B,H             ; BC <- HL
			ld      C,L             ; ...
			ld      IX,psginst      ; load psg instrument table into IX
			add     IX,BC           ; point to correct instrument (in IX)
	; parameters channel(A), insnum(C), freqh(D), freql(E)
psgkeyon:   sub     6               ; channel -= 6
			ld      IY,psgcom       ; load psg pseudo register base
			ld      C,A             ; BC <- 0A
			ld      B,0
			add     IY,BC           ; add channel offset to psg register base
			cp      3               ; check for noise channel
			jr      Z,psgnoi        ; noise channel...
			ld      A,E             ; get tone lsb
			and     0FH             ; bottom 4 bits
			ld      (IY+DTL),A      ; write tone lsb
			srl     D               ; DE >>= 4
			rr      E
			srl     D
			rr      E
			srl     E
			srl     E
			ld      (IY+DTH),E      ; write tone msb
			jr      pskon           ; skip over noise setting
psgnoi:     ld      A,(IX+0)        ; load noise data
			ld      (IY+DTL),A      ; write noise data
pskon:      ld      A,(IX+1)        ; load attack rate
			ld      (IY+ATK),A      ; write attack rate
			ld      A,(IX+2)        ; load sustain level
			sla     A               ; fix significance (<<4)
			sla     A
			sla     A
			sla     A
			ld      (IY+SLV),A      ; write sustain level
			ld      A,(IX+3)        ; load attack level
			sla     A               ; fix significance (<<4)
			sla     A
			sla     A
			sla     A
			ld      (IY+ALV),A      ; write attack level
			ld      A,(IX+4)        ; load decay rate
			ld      (IY+DKY),A      ; write decay rate
			ld      A,(IX+5)        ; load release rate
			ld      (IY+RRT),A      ; write release rate
			set     0,(IY+COM)      ; key on command
			pop     HL              ; restore HL
			pop     IY              ; restore IY
			ret                     ; done

*****************************************************************************
	; parameters channel(A)
KEYOFF:     push    IY              ; preserve IY
			cp      6               ; check for psg channel
			jp      NC,psgoff       ; psg channel...
fmoff:      ld      IX,chsust       ; load channel sustain table into IX
			ld      C,A             ; C <- channel number
			ld      B,0             ; B <- 0
			add     IX,BC           ; point to sustain byte (IX)
			ld      C,(IX+0)        ; load sustain mask
			cp      3               ; check for channels 3-5
			jr      C,foff1         ; channels 0-2
			inc     A               ; +1 (0,1,2,4,5,6)
foff1:      sla     C               ; fix significance of sustain byte
			sla     C
			sla     C
			sla     C
			or      C               ; mix with channel code
			ld      IY,4000H        ; load fm register address
			FMWrite 28H,A           ; key off
			pop     IY              ; restore IY
			ret                     ; done
psgoff:     sub     6               ; calculate psg channel
			ld      IX,psgcom       ; load psg register table
			ld      C,A             ; BC <- 0A
			ld      B,0
			add     IX,BC           ; point to correct register
			set     1,(IX+0)        ; set key off command
			pop     IY              ; restore IY
			ret                     ; done
*****************************************************************************
	; parameters channel(A), freqh(D), freql(E)
	; preserves IY

PBEND:      push    IY              ; save IY
			cp      6               ; check for psg channel
			jr      NC,psgpb        ; psg pitch bend
			ld      IY,4000H        ; load fm register address
			cp      3               ; check for channels 3-5
			jr      NC,pb02         ; yep...
			inc     IY              ; point to 4002H
			inc     IY
			sub     3               ; channel - 3 for channel index
pb02:       FMWrch  0A4H,A,D        ; set frequency msb
			FMWrch  0A0H,A,D        ; set frequency lsb
			pop     IY              ; restore IY
			ret                     ; done
psgpb:      ld      IY,7F11H        ; load psg register address
			sub     6               ; channel - 6
			sla     A
			sla     A
			sla     A
			sla     A
			sla     A
			or      80H             ; mix control bits
			ld      C,A             ; copy into C
			ld      A,E             ; get tone lsb
			and     0FH             ; bottom 4 bits
			or      C               ; mix instruction
			ld      (IY+0),A        ; write first word
			srl     D               ; DE >>= 4
			rr      E
			srl     D
			rr      E
			srl     E
			srl     E
			ld      A,E             ; get tone lsb
			or      C               ; mix instruction
			ld      (IY+0),A        ; write second word
			pop     IY              ; restore IY
			ret                     ; done


*****************************************************************************
*** read/write data area

chpri:      ds  20
chsust:     ds  6
melnum:     ds  1
psgcom:     ds  4
psglev:     ds  4
psgatk:     ds  4
psgdec:     ds  4
psgslv:     ds  4
psgrrt:     ds  4
psgenv:     ds  4
psgdtl:     ds  4
psgdth:     ds  4
psgalv:     ds  4
whdflg:     ds  4

FMBLK equ 38                        ; 38 bytes per fm instrument
PSGBLK equ 6                        ; 6 bytes per psg instrument
MELBLK equ 26H                      ; melody header block size

fminst:     ds  FMBLK*16
psginst:    ds  PSGBLK*16
meltab:     ds  MELBLK*16
melody:

