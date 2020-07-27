
	.model	tiny

	.data

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

hexascii	db	"0123456789ABCDEF"
tempstr	db	10 dup(?)
crcstr	db	0dh, 0ah, "Crc = $"



	.code

	org	100h

start:
	mov	si,0f000h
	mov	ds,si
	xor	si,si
	mov	cx,-1
	call	near ptr Crc16
	call	near ptr OutCRC

	mov	ax,4c00h
	int	21h

;
;
;
OutCrc	Proc	Near

	push	ax
	mov	dx,cs
	mov	ds,dx
	mov	es,dx
	mov	dx,offset crcstr
	mov	ah,9
	int	21h
	pop	dx
	mov	cx,4
	mov	di,offset tempstr
CLoop:
	rol	dx,1
	rol	dx,1
	rol	dx,1
	rol	dx,1
	mov	bx,dx
	and	bx,0fh
	mov	al,[bx+hexascii]
	stosb
	loop	CLoop
	mov	al,'$'
	stosb
	mov	dx,offset tempstr
	mov	ah,9
	int	21h

	ret

OutCrc	Endp



;
; -----
;
;	cx = length
;	ds:si = buffer
;

Crc16	Proc    Near
        Push    BX                              ; Save entry work registers
        Push    CX                              
        Push    SI
	Push	ES

	xor	ax,ax
__loop:
;	tmp=crc^c;
;	crc=(crc>>8)^crc16tab[tmp & 0xff];
;	return crc;
	xor	bh,bh
	mov	bl,[si]
	inc	si
	xor	bl,al
	shl	bx,1

	mov	al,ah
	xor	ah,ah
        xor     ax,cs:[bx+CRC16Tab]
        Loop    __loop                          ; Go until done

;Restore work registers
	Pop	ES
        Pop     SI
        Pop     CX
        Pop     BX
        Ret                                     ; Return with CRC-32 in DX:AX

Crc16   Endp

	end	start

