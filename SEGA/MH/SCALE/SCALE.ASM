

		locals

		.386

datas		segment para public 'FARDATA' use32

sintable	label	dword
		include	sin.asm

datas		ends


tcode		segment	public 'CODE'

		assume cs:tcode, ds:datas


COLOR		equ	0fh

start:
		mov	ax,13h
		int	10h		; into video mode

		mov	ax,0a000h
		mov	ds,ax		; set up destination segment

		mov	ax,199			; start x position
		xor	bx,bx			; start y position
		xor	cx,cx			; starting angle

@@angleLoop:
		push	ax
		push	bx
		push	cx
		call	near ptr rotatept

;		add	ax,160
;		add	bx,100
		xchg	bh,bl
		mov	cx,bx
		shr	bx,1
		shr	bx,1
		add	bx,cx
		add	bx,ax
		mov	byte ptr [bx],COLOR
		pop	cx
		pop	bx
		pop	ax

		inc	cx
		cmp	cx,90
		jne	@@angleLoop

		mov	ah,7
		int	21h

		mov	ax,70			; find distance of point
		mov	bx,80
		xor	cx,cx
		call	near ptr rotatept

		mov	ax,3
		int	10h

		mov	ax,4c00h
		int	21h


;{----------------------------------------------------------------------}
;{ Function:	RotatePt						}
;{ Description:	Rotate a point in 2 dimensions				}
;{ Parameters:	ax = x position						}
;{		bx = y position						}
;{		cx = angle						}
;{ Returns:	ax = X new position					}
;{		bx = y new position					}
;{----------------------------------------------------------------------}
RotatePt	Proc	Near

		push	cx
		push	dx
		push	bp
		push	di
		push	si
		push	ds

		mov	dx,cs
		mov	ds,dx

		shl	ax,1
		shl	bx,1

		push	cx
		neg	cx
		add	cx,90
		and	cx,0ffh
		xchg	ch,cl
		shl	cx,1
		mov	si,cx
		add	si,ax
		mov	di,WORD PTR [si+sintable] 	; in sin table
@@NoXupdate:
		mov	si,cx
		add	si,bx
		mov	bp,WORD PTR [si+sintable]	; get cos(angle) again
		pop	cx
		and	cx,0ffh
		xchg	ch,cl
		shl	cx,1
		mov	si,cx
		add	si,ax
		add	bp,WORD PTR [si+sintable]
		mov	si,cx
		add	si,bx
		add	di,WORD PTR [si+sintable]

		mov	ax,di
		mov	bx,bp

		pop	ds
		pop	si
		pop	di
		pop	bp
		pop	dx
		pop	cx
		ret

RotatePt	Endp

tcode		ends

		end	start
