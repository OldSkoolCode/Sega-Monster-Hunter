

		locals

tcode		segment	public 'CODE'

		assume cs:tcode, ds:tcode


COLOR		equ	255

		org	100h


start:
		mov	ax,13h
		int	10h		; into video mode

		mov	ax,0a000h
		mov	ds,ax		; set up destination segment

		mov	ax,50			; start x position
		xor	bx,bx			; start y position
		xor	cx,cx			; starting angle

@@angleLoop:
		push	ax
		push	bx
		push	cx
		call	near ptr rotatept

		add	ax,160
		add	bx,100
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

		mov	si,cx
		mov	cx,bx			; swap to useful registers
		mov	bx,ax

		push	si
		add	si,si
		neg	si
		add	si,180			; for cosign
		mov	ax,[si+sintable]	; in sin table
		mul	bx 
		shl	ax,1
		rcl	dx,1
		shl	ax,1
		rcl	dx,1			; >> 14 into dx
@@NoXupdate:
		mov	di,dx			; save X'
		xor	dx,dx			; assume result is zero
		cmp	cx,0			; is y = 0
		je	@@noYupdate
		mov	ax,[si+sintable]	; get cos(angle) again
		mul	cx
		shl	ax,1
		rcl	dx,1
		shl	ax,1
		rcl	dx,1			; >> 14 into dx
@@noYUpdate:
		mov	bp,dx			; say Y'
		pop	si
		xor	dx,dx
		or	bx,bx
		je	@@NoXupdate2
		add	si,si
		mov	ax,[si+sintable]
		mul	bx
		shl	ax,1
		rcl	dx,1
		shl	ax,1
		rcl	dx,1			; >> 14 into dx
@@NoXupdate2:
		add	bp,dx			; update Y'
		xor	dx,dx
		cmp	cx,0			; is y = 0
		je	@@NoYupdate2		; yep so don't multiply
		mov	ax,[si+sintable]
		mul	cx
		shl	ax,1
		rcl	dx,1
		shl	ax,1
		rcl	dx,1			; >> 14 into dx
@@noYupdate2:
		add	di,dx			; final X'

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

sintable	label	word
		include	sin.asm

tcode		ends

		end	start
