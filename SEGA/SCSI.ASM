
		locals

SCSICONNECT	equ	1
SENDCOMMAND	equ	2
SCSIGETERROR	equ	4
SCSITERM	equ	8
SCSIDRIVER	equ	7dh

SCSISENDMEM	equ	32
SCSIRECEIVEMEM	equ	33


parmBlk		struc

szCmdBlk	dd	?
cmdBlkOff	dw	?
cmdBlkSeg	dw	?
szBuff		dd	?
buffOff		dw	?
buffSeg		dw	?

parmBlk		Ends

cmdBlk		struc

command		db	?
modifier	db	?
lenField	dd	?
addrField	dd	?

cmdBlk		Ends

;
;
;
;
		.model	large,c

		.data

tempParms	parmBlk	<>
tempBlk		cmdBlk	<>


		.code
		
		public	sendBlock, receiveBlock, selectSCSI, termSCSI


;
;
;
selectSCSI	Proc

		arg	device

		mov	cx,3

@@ScsiLoop:
		mov	ax,device
		mov	ah,SCSICONNECT
		int	SCSIDRIVER
		jnc	@@NoScsiError

		xor	ah,ah
		int	SCSIDRIVER
		loop	@@ScsiLoop
		test	al,al
		jne	@@InitiatorError
		mov	al,ah
@@InitiatorError:
		mov	ah,SCSIGETERROR
		int	SCSIDRIVER

		mov	ax,bx
		mov	dx,es			; return error string
		ret
@@NoScsiError:
		xor	ax,ax
		xor	dx,dx
		ret


selectSCSI	Endp

;
;
;
termSCSI	proc

		mov	ah,SCSITERM
		int	SCSIDRIVER
		ret

termSCSI	endp

;{----------------------------------------------------------------------}
;{									}
;{									}
;{----------------------------------------------------------------------}
sendBlock	Proc

		uses	di,si,es,ds
		arg	srcAddr:dword, destAddr:dword, len:dword

		mov	ax,seg tempBlk
		mov	ds,ax
		mov	es,ax
		mov	si,offset tempBlk

		mov	[si].command,SCSIRECEIVEMEM

		mov	ax,word ptr len+2
		xchg	ah,al
		mov	word ptr [si].lenField,ax
		mov	ax,word ptr len
		xchg	ah,al
		mov	word ptr [si].lenField+2,ax

		mov	ax,word ptr destAddr+2
		xchg	ah,al
		mov	word ptr [si].addrField,ax
		mov	ax,word ptr destAddr
		xchg	ah,al
		mov	word ptr [si].addrField+2,ax

		mov	bx,offset tempParms

		mov	word ptr [bx].szCmdBlk,size cmdBlk
		mov	word ptr [bx].szCmdBlk+2,0
		mov	[bx].cmdBlkOff,offset tempBlk
		mov	[bx].cmdBlkSeg,seg tempBlk
		mov	ax,word ptr len
		mov	word ptr [bx].szBuff,ax
		mov	ax,word ptr len+2
		mov	word ptr [bx].szBuff+2,ax

		mov	ax,word ptr srcAddr
		mov	[bx].buffOff,ax
		mov	ax,word ptr srcAddr+2
		mov	[bx].buffSeg,ax

		mov	ah,SENDCOMMAND
		int	SCSIDRIVER

		jnc	@@NoScsiError

		test	al,al
		jne	@@InitiatorError
		mov	al,ah
@@InitiatorError:
		mov	ah,SCSIGETERROR
		int	SCSIDRIVER
		mov	ax,bx
		mov	dx,es
		ret
@@NoScsiError:
		xor	ax,ax
		xor	dx,dx

		ret


sendBlock	Endp





receiveBlock	Proc

		uses	di,si,es,ds
		arg	destAddr:dword, srcAddr:dword, len:dword




		ret





receiveBlock	Endp

		end
