
;{----------------------------------------------------------------------}
;{	DOWNA.ASM							}
;{	  Sega Ram Board Downloader support Routines			}
;{	  Copyright (C) 1992 Futurescape Productions Inc.		}
;{	  Written by: Kenneth L. Hurley					}
;{----------------------------------------------------------------------}


		.model	large,c

		locals
		jumps

;{----------------------------------------------------------------------}
;{	macros								}
;{----------------------------------------------------------------------}
;{----------------------------------------------------------------------}
;{	write byte to parallel port					}
;{----------------------------------------------------------------------}
writebyte	macro	source, ErrorExit
		local	BusyLoop1,BusyLoop2,targetRDY1,targetRDY2

		if	("&source" eq "al")
		push	ax
		endif
		mov	dx,es:paraPort		; get address of parallel port
		inc	dx			; dx = $3bd
		mov	bx,es:timeout
		add	bx,es:timerTicks
BusyLoop1:
		in	al,dx
		test	al,BUSYBIT		; wait for target ready
		jne	targetRDY1
		cmp	bx,es:timerTicks
		jge	BusyLoop1
		if	("&source" eq "al")
		pop	ax
		endif
		mov	ax,TIMEOUTERROR
		jmp	&ErrorExit
targetRDY1:
		inc	dx			; dx = $3be
		in	al,dx
		and	al,NOT (STRBBIT OR AFEEDBIT)	; set strobe low
		out	dx,al

		dec	dx			; dx = $3bd
		if	("&source" eq "si")
		lodsb				; get data
		elseif	("&source" eq "al")
		pop	ax
		else
		mov	al,source
		endif

		dec	dx			; dx =$3bc
		out	dx,al			; send data

		inc	dx			; dx = $3bd
		mov	bx,es:timeout
		add	bx,es:timerTicks
BusyLoop2:
		in	al,dx
		test	al,BUSYBIT
		je	targetRDY2
		cmp	bx,es:timerTicks
		jge	BusyLoop2
		mov	ax,TIMEOUTERROR
		jmp	&ErrorExit
targetRDY2:
		inc	dx			; dx = $3be
		in	al,dx
		or	al,STRBBIT
		out	dx,al

		endm

;{----------------------------------------------------------------------}
;{	Read byte from parallel port					}
;{----------------------------------------------------------------------}
readbyte	Macro	dest, ErrorExit
		local	Nextbyte
		local	BusyLoop1,BusyLoop2
		local	targetRDY1, targetRDY2

		mov	cx,2
Nextbyte:
		mov	dx,es:paraPort		; get address of parallel port
		inc	dx			; dx = $3bd
		mov	si,es:timeout
		add	si,es:timerTicks
BusyLoop1:
		in	al,dx
		test	al,BUSYBIT		; wait for target ready
		jne	targetRDY1
		cmp	si,es:timerTicks
		jge	BusyLoop1
		mov	ax,TIMEOUTERROR
		jmp	&ErrorExit
targetRDY1:
		inc	dx
		in	al,dx
;
; set strobe low
;
		and	al,NOT (STRBBIT OR AFEEDBIT)
		out	dx,al
		dec	dx			; dx = $3bd
		mov	si,es:timeout
		add	si,es:timerTicks
BusyLoop2:
		in	al,dx
		test	al,BUSYBIT
		je	targetRDY2
		cmp	si,es:timerTicks
		jge	BusyLoop2
		mov	ax,TIMEOUTERROR
		jmp	&ErrorExit
targetRDY2:
		shl	al,1
		and	al,0f0h
		shr	bl,1
		shr	bl,1
		shr	bl,1
		shr	bl,1
		or	bl,al

		inc	dx			; dx = $3be
		in	al,dx
		or	al,STRBBIT
		out	dx,al
		loop	Nextbyte

		if	("&dest" eq "di")
		stosb				; get data
		elseif	("&dest" ne "bl")
		mov	dest,bl
		endif

		endm


;{----------------------------------------------------------------------}
;{ 	Convert far pointer to huge pointer				}
;{----------------------------------------------------------------------}
fartohuge	macro	reg1,segreg
		mov	ax,reg1
		shr	ax,1
		shr	ax,1
		shr	ax,1
		shr	ax,1
		mov	bx,segreg
		add	ax,bx
		mov	segreg,ax
		and	reg1,0fh
		endM

;{----------------------------------------------------------------------}
;{	equates								}
;{----------------------------------------------------------------------}
DOWNLOAD	equ	80h
UPLOAD		equ	81h
SET_REGS	equ	82h
GET_REGS	equ	83h
EXECUTE_PC	equ	84h
PRINT_TEXT	equ	85h

BUSYBIT		equ	10000000b
ACKBIT		equ	01000000b
POUTBIT		equ	00100000b
SELBIT		equ	00010000b
SELBIT		equ	00010000b
ERRORBIT	equ	00001000b

STRBBIT		equ	00000010b
AFEEDBIT	equ	00000001b


NAKBYTE		equ	15h		; ascii NAK
ACKBYTE		equ	6		; ascii ACK

TIMEOUTERROR	equ	1
FAILEDRETRIES	equ	2		; errors

;{----------------------------------------------------------------------}
;{	structures							}
;{----------------------------------------------------------------------}
headerpacket	struc
HPCOMMAND	dw	?
HPADDRESS	dd	?
HPLENGTH	dd	?
HPX		dw	?
HPY		dw	?

		ends

dseg		segment	private 'FARDATA'

		public	CRC16Tab
CRC16Tab	label word

	dw 00000H, 0C0C1H, 0C181H, 00140H, 0C301H, 003C0H, 00280H, 0C241H
	dw 0C601H, 006C0H, 00780H, 0C741H, 00500H, 0C5C1H, 0C481H, 00440H
	dw 0CC01H, 00CC0H, 00D80H, 0CD41H, 00F00H, 0CFC1H, 0CE81H, 00E40H
	dw 00A00H, 0CAC1H, 0CB81H, 00B40H, 0C901H, 009C0H, 00880H, 0C841H
	dw 0D801H, 018C0H, 01980H, 0D941H, 01B00H, 0DBC1H, 0DA81H, 01A40H
	dw 01E00H, 0DEC1H, 0DF81H, 01F40H, 0DD01H, 01DC0H, 01C80H, 0DC41H
	dw 01400H, 0D4C1H, 0D581H, 01540H, 0D701H, 017C0H, 01680H, 0D641H
	dw 0D201H, 012C0H, 01380H, 0D341H, 01100H, 0D1C1H, 0D081H, 01040H
	dw 0F001H, 030C0H, 03180H, 0F141H, 03300H, 0F3C1H, 0F281H, 03240H
	dw 03600H, 0F6C1H, 0F781H, 03740H, 0F501H, 035C0H, 03480H, 0F441H
	dw 03C00H, 0FCC1H, 0FD81H, 03D40H, 0FF01H, 03FC0H, 03E80H, 0FE41H
	dw 0FA01H, 03AC0H, 03B80H, 0FB41H, 03900H, 0F9C1H, 0F881H, 03840H
	dw 02800H, 0E8C1H, 0E981H, 02940H, 0EB01H, 02BC0H, 02A80H, 0EA41H
	dw 0EE01H, 02EC0H, 02F80H, 0EF41H, 02D00H, 0EDC1H, 0EC81H, 02C40H
	dw 0E401H, 024C0H, 02580H, 0E541H, 02700H, 0E7C1H, 0E681H, 02640H
	dw 02200H, 0E2C1H, 0E381H, 02340H, 0E101H, 021C0H, 02080H, 0E041H
	dw 0A001H, 060C0H, 06180H, 0A141H, 06300H, 0A3C1H, 0A281H, 06240H
	dw 06600H, 0A6C1H, 0A781H, 06740H, 0A501H, 065C0H, 06480H, 0A441H
	dw 06C00H, 0ACC1H, 0AD81H, 06D40H, 0AF01H, 06FC0H, 06E80H, 0AE41H
	dw 0AA01H, 06AC0H, 06B80H, 0AB41H, 06900H, 0A9C1H, 0A881H, 06840H
	dw 07800H, 0B8C1H, 0B981H, 07940H, 0BB01H, 07BC0H, 07A80H, 0BA41H
	dw 0BE01H, 07EC0H, 07F80H, 0BF41H, 07D00H, 0BDC1H, 0BC81H, 07C40H
	dw 0B401H, 074C0H, 07580H, 0B541H, 07700H, 0B7C1H, 0B681H, 07640H
	dw 07200H, 0B2C1H, 0B381H, 07340H, 0B101H, 071C0H, 07080H, 0B041H
	dw 05000H, 090C1H, 09181H, 05140H, 09301H, 053C0H, 05280H, 09241H
	dw 09601H, 056C0H, 05780H, 09741H, 05500H, 095C1H, 09481H, 05440H
	dw 09C01H, 05CC0H, 05D80H, 09D41H, 05F00H, 09FC1H, 09E81H, 05E40H
	dw 05A00H, 09AC1H, 09B81H, 05B40H, 09901H, 059C0H, 05880H, 09841H
	dw 08801H, 048C0H, 04980H, 08941H, 04B00H, 08BC1H, 08A81H, 04A40H
	dw 04E00H, 08EC1H, 08F81H, 04F40H, 08D01H, 04DC0H, 04C80H, 08C41H
	dw 04400H, 084C1H, 08581H, 04540H, 08701H, 047C0H, 04680H, 08641H
	dw 08201H, 042C0H, 04380H, 08341H, 04100H, 081C1H, 08081H, 04040H

tempheader	headerpacket<>

		public	paraPort
paraPort	dw	3bch		; default parallel port
timeout		dw	91		; 5 second timeout
retries		dw	3		; 3 retries
timerTicks	dw	0		; timer ticks

dseg		ends


cseg		segment 'CODE'

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		assume	cs:cseg,ds:dseg,es:dseg
;{----------------------------------------------------------------------}
;{ Function:	InitParaPort()						}
;{ Description:	Initialize parallel port to known state			}
;{ Parameters:	.							}
;{ Returns:	ax = 0 if no error					}
;{		   = TIMEOUTERROR if timed out				}
;{		   = FAILEDRETRIES if maximum retries reached		}
;{----------------------------------------------------------------------}
		public	InitParaPort
InitParaPort	Proc	far

		uses	ds

		mov	ax,seg paraPort
		mov	ds,ax
		mov	dx,paraPort
		inc	dx
		mov	bx,timerTicks
		add	bx,timeout
@@BusyLoop1:
		inc	dx
		in	al,dx
		test	al,AFEEDBIT
		je	@@targetRDY2
		dec	dx
		in	al,dx
		test	al,BUSYBIT		; wait for target ready
		je	@@targetRDY1
		cmp	bx,timerTicks
		jge	@@BusyLoop1
		mov	ax,TIMEOUTERROR
		jmp	@@IPExit
@@targetRDY1:
		inc	dx
		in	al,dx
		and	al,NOT AFEEDBIT
		or	al,STRBBIT
		out	dx,al			; set bfeed and strobe
@@targetRDY2:
		xor	ax,ax
@@IPExit:
		ret

InitParaPort	Endp
		
;{----------------------------------------------------------------------}
;{ Function:	int SendHeaderPacket(int command, long address, 	}
;{				long dlength, int xpos, int ypos);	}
;{ Description:	Download header packet through parallel port		}
;{ Parameters:	command = command for ram board				}
;{		address = address to send data				}
;{		dlength = length of data				}
;{		x = x position if any					}
;{		y = y position if any					}
;{ Returns:	ax = 0 then No Errors					}
;{		   = TIMEOUTERROR if timed out				}
;{		   = FAILEDRETRIES if maximum retries reached		}
;{----------------------------------------------------------------------}
		public	SendHeaderPacket
SendHeaderPacket Proc	far

		uses	si,di,ds,es

		arg	COMMAND:word, ADDRESS:dword, DLENGTH:dword
		arg	XPOS:word, YPOS:word

		mov	di,seg tempheader
		mov	es,di
		mov	ds,di
		mov	di,offset tempheader ; get address of header
		mov	si,di

		mov	ax,COMMAND	; get command
		xchg	ah,al
		stosw
		mov	ax,word ptr ADDRESS+2
		mov	dx,word ptr ADDRESS	; get address parameter
		xchg	ah,al
		xchg	dh,dl		; swap bytes reverse order
		stosw
		mov	ax,dx
		stosw
		mov	ax,word ptr DLENGTH+2
		mov	dx,word ptr DLENGTH	; get data length parameter
		xchg	ah,al
		xchg	dh,dl		; swap bytes reverse order
		stosw
		mov	ax,dx
		stosw
		mov	ax,XPOS		; store x & y positions
		xchg	ah,al
		stosw
		mov	ax,YPOS
		xchg	ah,al
		stosw
		mov	cx,size headerpacket
		call	near ptr OutParaPort

		ret

SendHeaderPacket Endp

;{----------------------------------------------------------------------}
;{ Function:	SendBytes(char far *source, long length)		}
;{ Description:	Send bytes over parallel port to target			}
;{ Parameters:	source = source of byte buffer				}
;{ 		length = length of byte buffer				}
;{ Returns:	ax = 0 then ok						}
;{ 		   = TIMEOUTERROR if timeout occurred			}
;{		   = FAILEDRETRIES if maximum retries encountered	}
;{----------------------------------------------------------------------}
		public	SendBytes
SendBytes	Proc	far

		uses	si,di,es,ds
		arg	source:dword, dlength:dword


		mov	bx,word ptr dlength
		mov	dx,bx
		mov	ax,word ptr dlength+2
		shl	bx,1
		rcl	ax,1
		shl	bx,1
		rcl	ax,1
		shl	bx,1
		rcl	ax,1
		shl	bx,1
		rcl	ax,1
		mov	di,ax
		and	dx,0fffh	; last chunk
		lds	si,source	; get source address
@@Send4kLoop:
		fartohuge si,ds
		or	di,di
		je	@@lastChunk	; any more 4k chunks?
		mov	cx,1000h
		push	dx
		push	di
		call	near ptr OutParaPort ; write chunk w/CRC
		pop	di
		pop	dx
		or	ax,ax
		jne	SBExit
		add	si,1000h
		dec	di
		jmp	@@Send4kLoop
@@lastChunk:
		xor	ax,ax
		or	dx,dx
		je	SBExit		; write odd chunk or not?
		mov	cx,dx
		fartohuge si,ds
		call	near ptr OutParaPort
SBExit:
		ret

SendBytes	Endp

;{----------------------------------------------------------------------}
;{ Function:	OurParaPort						}
;{ Description:	Write data to parallel port with time out and retries	}
;{		if target NAK's						}
;{ Parameters:	cx = length of write					}
;{		ds:si = source bytes					}
;{		timeout = timeout value in 18.2 ticks			}
;{		retries = number of retries for NAK's			}
;{		paraPort						}
;{ Returns:	ax = 0 then ok						}
;{ 		   = TIMEOUTERROR if timeout occurred			}
;{		   = FAILEDRETRIES if maximum retries encountered	}
;{----------------------------------------------------------------------}
OutParaPort	Proc	Near

		mov	ax,seg paraPort
		mov	es,ax

		call	near ptr Crc16
		xchg	ah,al
		mov	bp,ax		; save CRC for later

		mov	bx,es:retries	; number of retries
@@TryAgainLoop:
		push	bx
		push	cx
		push	si
@@NextByte:
		writebyte si,OPExit	; write out bytes
		loop	@@NextByte

		mov	ax,bp
		writebyte al,OPExit
		writebyte ah,OPExit	; write crc-16

		readbyte al,OPExit	; get response

		mov	ah,al
		mov	dx,es:paraPort
		add	dx,2
		in	al,dx
		or	al,1
		out	dx,al

		cmp	ah,ACKBYTE	; received bytes ok?
		jne	@@TryAgain
		xor	ax,ax
		jmp	OPExit
@@TryAgain:
		cmp	ah,NAKBYTE
		jne	@@OutofSync
		
		pop	si
		pop	cx
		pop	bx


		dec	bx
		jne	@@TryAgainLoop	; Try again
		mov	ax,FAILEDRETRIES
		ret
@@OutofSync:
		mov	dx,es:paraPort		; get address of parallel port
		inc	dx			; dx = $3bd
		mov	bx,es:timeout
		add	bx,es:timerTicks
@@BusyLoop1:
		in	al,dx
		test	al,BUSYBIT		; wait for target ready
		jne	@@targetRDY1
		cmp	bx,es:timerTicks
		jge	@@BusyLoop1
		mov	ax,TIMEOUTERROR
		jmp	OPExit
@@targetRDY1:
		inc	dx			; dx = $3be
		in	al,dx
		and	al,NOT STRBBIT		; set strobe low
		out	dx,al

		dec	dx			; dx = $3bd
		mov	bx,es:timeout
		add	bx,es:timerTicks
@@BusyLoop2:
		in	al,dx
		test	al,BUSYBIT
		je	@@targetRDY2
		cmp	bx,es:timerTicks
		jge	@@BusyLoop2
		mov	ax,TIMEOUTERROR
		jmp	OPExit
@@targetRDY2:
		inc	dx			; dx = $3be
		in	al,dx
		or	al,(STRBBIT OR AFEEDBIT)
		out	dx,al
		pop	si
		pop	cx
		pop	bx


		dec	bx
		jne	@@TryAgainLoop	; Try again
		mov	ax,FAILEDRETRIES
		ret
OPExit:
		pop	si
		pop	cx
		pop	bx

		ret

OutParaPort	Endp

;{----------------------------------------------------------------------}
;{ Function:	Crc16							}
;{ Description:	Calculate 16 bit CRC value for buffer			}
;{ Parameters:	cx = length						}
;{ 		ds:si = buffer						}
;{ Returns:	ax = CRC value						}
;{----------------------------------------------------------------------}
Crc16		Proc    Near

	        push    bx
	        push    cx                              
        	push    si
		push	es

		mov	ax,seg CRC16Tab
		mov	es,ax
		xor	ax,ax
@@loop:
		xor	bh,bh
		mov	bl,[si]
		inc	si
		xor	bl,al
		shl	bx,1

		mov	al,ah
		xor	ah,ah
	        xor     ax,es:[bx+CRC16Tab]
	        loop    @@loop                          ; Go until done

		pop	es
	        pop     si
	        pop     cx
	        pop     bx
	        ret 

Crc16   	Endp

		public	oldTimerInt
oldTimerInt	dd	?
;{----------------------------------------------------------------------}
;{ Function:	TimerRoutine						}
;{ Description:	Timer interrupt vector					}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
		public	TimerRoutine
TimerRoutine	Proc	Far

		push	ax
		push	ds

		mov	ax,seg timerTicks
		mov	ds,ax
		inc	timerTicks

		pop	ds
		pop	ax
		jmp	cs:oldTimerInt

TimerRoutine	Endp

cseg		ends

		end

