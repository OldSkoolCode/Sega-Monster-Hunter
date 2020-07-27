

SNASM		equ	1		; snasm vectors?

INITSP		equ	$ff8000		; initial stack pointer
PORTABITS	equ	$380001		; port 0/a address
PORTBBITS	equ	$380003		; port 1/b address
PORTCBITS	equ	$380005		; port 2/c address
CTRLPORT	equ	$380007		; port Control address

SNDADD          equ     $A04000
SNDDAT          equ     $A04001

CNTLA           equ     $A10008
CNTLB           equ     $A1000A
CNTLC           equ     $A1000C
                                        
CNTLAW          equ     $A10009
CNTLBW          equ     $A1000B
CNTLCW          equ     $A10009
                                        
PPCNTL          equ     $A1000D
PPDATA          equ     $A10007
                                        
BUSREQ          equ     $A11100
BUSRES          equ     $A11200
                                        
Z80RAM          equ     $A00000
                                        
VDATA           equ     $C00000
VCTRL           equ     $C00004

TPOINT          equ     $FF0004

JOY1_CNTRL      equ	$a10009
JOY2_CNTRL      equ	$a1000b


;
; -----	Header packet commands
;
FIRSTCOMMAND	equ	$80
DOWNLOAD	equ	$80		; download into ram
UPLOAD		equ	$81		; upload to parallel port
SET_REGS	equ	$82		; set registers
GET_REGS	equ	$83		; get registers
EXECUTE_PC	equ	$84		; execute with current PC
PRINT_TEXT	equ	$85		; print out text to screen
LASTCOMMAND	equ	$85		; last command


STRBBIT		equ	%01000000
AFEEDBIT	equ	%10000000
BUSYBIT		equ	%00000100
NAKBYTE		equ	$15		; ascii NAK
ACKBYTE		equ	6		; ascii ACK

;
; -----	Structures
;
HEADERPACKET	rsreset

HPCOMMAND	rs.w	1		; command from above table
HPADDRESS	rs.l	1		; address for command
HPLENGTH	rs.l	1		; length of data
HPX		rs.w	1		; x offset if any
HPY		rs.w	1		; y offset if any
HPCRC		rs.w	1		; checksum for packet
HPSIZE		rs.b	0		; size of header packet


