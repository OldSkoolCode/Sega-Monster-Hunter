	ifndef	??version
?debug	macro
	endm
publicdll macro	name
	public	name
	endm
$comm	macro	name,dist,size,count
	comm	dist name:BYTE:count*size
	endm
	else
$comm	macro	name,dist,size,count
	comm	dist name[size]:BYTE:count
	endm
	endif
	?debug	V 300h
	?debug	S "shell.c"
	?debug	C E941A07F1A077368656C6C2E63
_TEXT	segment byte public 'CODE'
_TEXT	ends
DGROUP	group	_DATA,_BSS
	assume	cs:_TEXT,ds:DGROUP
_DATA	segment word public 'DATA'
d@	label	byte
d@w	label	word
_DATA	ends
_BSS	segment word public 'BSS'
b@	label	byte
b@w	label	word
_BSS	ends
_TEXT	segment byte public 'CODE'
   ;	
   ;	void shell(int v[], int n)
   ;	
	assume	cs:_TEXT
_shell	proc	near
	push	bp
	mov	bp,sp
	sub	sp,12
	push	si
	push	di
   ;	
   ;	{
   ;		
   ;		register int	gap, i, j, temp;
   ;	
   ;		for (gap = n/2; gap >0; gap /= 2)
   ;	
	mov	ax,word ptr [bp+6]
	cwd	
	sub	ax,dx
	mov	si,ax
	sar	si,1
	jmp	@1@562
@1@58:
   ;	
   ;			for (i=gap; i<n; i++)
   ;	
	mov	di,si
	mov	ax,si
	sub	ax,si
	mov	word ptr [bp-10],ax
	cmp	si,word ptr [bp+6]
	jge	short @1@534
	mov	ax,si
	mov	dx,2
	imul	dx
	mov	word ptr [bp-12],ax
	jmp	short @1@506
@1@170:
   ;	
   ;				for (j=i-gap; j>=0 && v[j]>v[j+gap]; j-=gap)
   ;	
	mov	cx,word ptr [bp-10]
	mov	ax,word ptr [bp+4]
	mov	dx,word ptr [bp-10]
	shl	dx,1
	add	ax,dx
	mov	word ptr [bp-2],ax
	mov	ax,word ptr [bp+4]
	mov	dx,word ptr [bp-10]
	add	dx,si
	shl	dx,1
	add	ax,dx
	mov	word ptr [bp-4],ax
	mov	ax,word ptr [bp-12]
	mov	word ptr [bp-6],ax
	mov	word ptr [bp-8],ax
	jmp	short @1@394
@1@282:
   ;	
   ;					{
   ;						temp = v[j];
   ;	
   ;	
   ;						v[j] = v[j+gap];
   ;	
	mov	bx,word ptr [bp-4]
	mov	ax,word ptr [bx]
	mov	bx,word ptr [bp-2]
	mov	word ptr [bx],ax
   ;	
   ;						v[j+gap] = temp;
   ;	
	mov	bx,word ptr [bp-4]
	mov	word ptr [bx],dx
	mov	ax,word ptr [bp-6]
	sub	word ptr [bp-2],ax
	mov	ax,word ptr [bp-8]
	sub	word ptr [bp-4],ax
	sub	cx,si
@1@394:
	or	cx,cx
	jl	short @1@450
	mov	bx,word ptr [bp-2]
	mov	ax,word ptr [bx]
	mov	dx,ax
	mov	bx,word ptr [bp-4]
	cmp	ax,word ptr [bx]
	jg	short @1@282
@1@450:
	inc	word ptr [bp-10]
	inc	di
@1@506:
	cmp	di,word ptr [bp+6]
	jl	short @1@170
@1@534:
	mov	ax,si
	cwd	
	sub	ax,dx
	mov	si,ax
	sar	si,1
@1@562:
	or	si,si
	jle	@@0
	jmp	@1@58
@@0:
   ;	
   ;					}
   ;	}
   ;	
	pop	di
	pop	si
	mov	sp,bp
	pop	bp
	ret	
_shell	endp
	?debug	C E9
	?debug	C FA1D020000
_TEXT	ends
_DATA	segment word public 'DATA'
s@	label	byte
_DATA	ends
_TEXT	segment byte public 'CODE'
_TEXT	ends
	public	_shell
_s@	equ	s@
	end
