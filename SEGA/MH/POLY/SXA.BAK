;{----------------------------------------------------------------------}
;{	SYA.ASM								}
;{	  This program creates code to take a wall of 			}
;{	  WALLWIDTH*WALLHEIGHT and generates code for 2 1/2 D 		}
;{	  perspective drawing						}
;{	  Copyright (C) 1993 Futurescape Productions Inc.		}
;{	  Written by: Kenneth L. Hurley					}
;{----------------------------------------------------------------------}
		locals
		jumps

		.model	large,c

		extrn	writeCode:far
		public	interpolate, InitDDA, NextDDA, vidMode
		public	displayWall, InitInterLoop, InterLoop

		.code

;
; -----	DDA Variable structures
;
DDAVars		struc
DDAinitval	dw	?
DDAmoves	dw	?
DDAdelsx	dw	?
DDAdelsy	dw	?
DDAdeldx	dw	?
DDAdeldy	dw	?
DDAdelse	dw	?
DDAdelde	dw	?
		ends


;
; ----- codes for shearing effect of wall
;
LOADCODE	equ	1
STORECODE	equ	2
NEXTSOURCECODE	equ	3

;{----------------------------------------------------------------------}
;{ Function:	interpolate(srcSize, dstSize);				}
;{				DDAVars far *DDAVarsPtr);		}
;{ Description:	Fills in DDAVars structure with pertinent data to	}
;{		start DDA routine.					}
;{ Parameters:	x1 = x starting point					}
;{		y1 = y starting point					}
;{		x2 = x ending point					}
;{		y2 = y ending point					}
;{		DDAVarsPtr = far pointer to DDAVars structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
interpolate	Proc	Far

		uses	si,di
		arg	srcSize:word, dstSize:word

		mov	cx,dstSize
		mov	dx,srcSize

		cmp	cx,dx
		jle	@@Smaller
		shl	dx,1
		mov	bp,dx
		sub	dx,cx
		mov	bx,dx
		sub	dx,cx
@@NextMoveloop1:
		push	bx
		push	cx
		push	dx
		mov	ax,LOADCODE
		push	ax
		call	far ptr writeCode
		pop	ax
		mov	ax,STORECODE
		push	ax
		call	far ptr writeCode
		pop	ax
		pop	dx
		pop	cx
		pop	bx
		dec	cx
		je	@@exit
		add	bx,dx
		jge	@@NextMoveloop1
@@NextDestloop:
		push	bx
		push	cx
		push	dx
		mov	ax,STORECODE
		push	ax
		call	far ptr writeCode
		pop	ax
		pop	dx
		pop	cx
		pop	bx
		dec	cx
		je	@@exit
		add	bx,bp
		jl	@@NextDestloop
		jmp	@@NextMoveloop1


@@Smaller:
		xchg	cx,dx
		shl	dx,1
		mov	bp,dx
		sub	dx,cx
		mov	bx,dx
		sub	dx,cx

@@NextMoveloop2:
		push	bx
		push	cx
		push	dx
		mov	ax,LOADCODE
		push	ax
		call	far ptr writeCode
		pop	ax
		mov	ax,STORECODE
		push	ax
		call	far ptr writeCode
		pop	ax
		pop	dx
		pop	cx
		pop	bx
		dec	cx
		je	@@exit
		add	bx,dx
		jge	@@NextMoveloop2
@@NextSrcloop:
		push	bx
		push	cx
		push	dx
		mov	ax,LOADCODE
		push	ax
		call	far ptr writeCode
		pop	ax
		pop	dx
		pop	cx
		pop	bx
		dec	cx
		je	@@exit
		add	bx,bp
		jl	@@NextSrcloop
		jmp	@@NextMoveloop2

@@exit:
		ret		

interpolate	Endp

;{----------------------------------------------------------------------}
;{ Function:	initInterLoop(int srcSize, int dstSize, 		}
;{				DDAVars *DDAVarsPtr);			}
;{ Description:	Initialize interpolate loop variables			}
;{ Parameters:	srcSize = size of source				}
;{		destSize = size of destination				}
;{		DDAVarsPtr = pointer to DDA variable structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
InitInterLoop	Proc	Far

		uses	si,di,ds,es

		arg	srcSize:word, dstSize:word, DDAVarsPtr:dword

		mov	cx,dstSize
		mov	dx,srcSize

		lds	si,DDAVarsPtr
		mov	[si].DDAdelsx,1
		mov	[si].DDAdelsy,1
		mov	[si].DDAdeldx,0
		mov	[si].DDAdeldy,1
		cmp	cx,dx
		jg	@@Greater
		xchg	dx,cx
		mov	[si].DDAdeldx,1
		mov	[si].DDAdeldy,0
@@Greater:
		shl	dx,1
		mov	di,dx
		sub	dx,cx
		mov	bx,dx
		sub	dx,cx
		add	bx,dx
		mov	[si].DDAmoves,cx
		mov	[si].DDAinitval,bx
		mov	[si].DDAdelse,dx
		mov	[si].DDAdelde,di
		ret		

InitInterLoop	Endp

;{----------------------------------------------------------------------}
;{ Function:	InterLoop(int srcSize, int dstSize,			}
;{				DDAVars *DDAVarsPtr);			}
;{ Description:	Do an iteration of DDA loop				}
;{ Parameters:	srcOffset = current offset of source			}
;{		destOffset = current offset of destination		}
;{		DDAVarsPtr = pointer to DDA variable structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
InterLoop	Proc	Far

		uses	si,di,ds,es

		arg	srcOffset:dword, dstOffset:dword, DDAVarsPtr:dword

		lds	si,srcOffset
		mov	ax,[si]
		lds	si,dstOffset
		mov	bx,[si]

		lds	si,DDAVarsPtr

@@NextDestination:
		mov	dx,[si].DDAinitval
		or	dx,dx
		jge	@@NextMoveLoop1
		add	dx,[si].DDAdelde
		add	ax,[si].DDAdeldx
		add	bx,[si].DDAdeldy
		mov	[si].DDAinitval,dx
		mov	cx,[si].DDAdeldy
		or	cx,cx
		je	@@NextDestination
		jmp	@@DoneLoop
@@NextMoveLoop1:
		add	ax,[si].DDAdelsx
		add	bx,[si].DDAdelsy
		add	dx,[si].DDAdelse
@@DoneLoop:
		mov	[si].DDAinitval,dx
		lds	si,srcOffset
		mov	[si],ax
		lds	si,dstOffset
		mov	[si],bx
@@exit:
		ret

InterLoop	Endp

tx1		dw	?
ty1		dw	?
;{----------------------------------------------------------------------}
;{ Function:	InitDDA(int x1, int y1, int x2, int y2, 		}
;{				DDAVars far *DDAVarsPtr);		}
;{ Description:	Fills in DDAVars structure with pertinent data to	}
;{		start DDA routine.					}
;{ Parameters:	x1 = x starting point					}
;{		y1 = y starting point					}
;{		x2 = x ending point					}
;{		y2 = y ending point					}
;{		DDAVarsPtr = far pointer to DDAVars structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
InitDDA		Proc	Far

		uses	si,di,ds,es

		arg	x1:word, y1:word, x2:word, y2:word
		arg	DDAVarsPtr:dword

		lds	si,DDAVarsPtr		; set pointer to DDAVarsPtr

		mov	ax,x1
		mov	bx,y1
		mov	cx,x2
		mov	dx,y2

		mov	tx1,ax
		mov	ty1,bx
		mov	ax,1			; starting postive for update
		mov	bx,1			; starting y postive for update
		sub	dx,ty1			; subtract y1 from y2
		jge	storey			; skip if y2-y1 is nonnegative
		neg	bx			; negative y direction
		neg	dx			; absolute value of y2-y1
storey:
		mov	[si].DDAdeldy,bx	; store y for diagonal moves
		sub	cx,tx1			; subtract x1
		jge	storex			; skip if x2-x1 is postive
		neg	ax			; make negative x direction
		neg	cx			; absolute value of cx
storex:
		mov	[si].DDAdeldx,ax	; save x direction
		cmp	cx,dx			; compare dels with delp
		jge	setdiag			; skip if straight move in x direction
		xor	ax,ax			; zap x update
		xchg	cx,dx			; exchange differences
		jmp	storedelsxy
setdiag:
		xor	bx,bx			; zap y update
storedelsxy:
		mov	[si].DDAdelsx,ax	; x update in straight direction
		mov	[si].DDAdelsy,bx	; y update in straight direction

		shl	dx,1			; get delp and * 2
		mov	[si].DDAdelse,dx	; change if straight move
		sub	dx,cx			; 2*delp-dels
		mov	di,dx			; initial value
		sub	dx,cx
		mov	[si].DDAdelde,dx
		inc	cx			; increment count

		mov	[si].DDAinitval,di	; initial value
		mov	[si].DDAmoves,cx	; save number

		ret

InitDDA		Endp

;{----------------------------------------------------------------------}
;{ Function:	NextDDA(int *x, int *y, DDAVars far *DDAVarsPtr);	}
;{ Description:	update x, y with new values from DDA structure		}
;{ Parameters:	x = pointer to int containing current x position	}
;{		y = pointer to int containing current y position	}
;{		DDAVarsPtr = pointer to DDAVars structure		}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
NextDDA		Proc	Far

		uses	si,di,ds,es
		arg	xPtr:dword, yPtr:dword, DDAVarsPtr:dword

		lds	si,xPtr
		mov	ax,[si]
		lds	si,yPtr
		mov	bx,[si]

		lds	si,DDAVarsPtr

		mov	di,[si].DDAinitval	; get initial or current value
@@1:
		cmp	[si].DDAmoves,0		; are were all done...
		je	neddexit		; yes so exit
		cmp	di,0			; determine straight or diagonal
		jge	@@diagonal
@@straight:
		add	ax,[si].DDAdelsx	;update x
		add	bx,[si].DDAdelsy	;update y
		add	di,[si].DDAdelse	;update error term
		cmp	[si].DDAdelse,0
		jmp	@@2			;all finished
@@diagonal:
		add	ax,[si].DDAdeldx	;update x
		add	bx,[si].DDAdeldy	;update y
		add	di,[si].DDAdelde	;update error term
@@2:
		mov	[si].DDAinitval,di
		dec	[si].DDAmoves		; go down one ball move
		lds	si,xPtr
		mov	[si],ax
		lds	si,yPtr
		mov	[si],bx
neddexit:
		ret

NextDDA		Endp

;{----------------------------------------------------------------------}
;{ Function:	vidMode(inOrOut, palPtr);				}
;{ Description:	go into or out of graphics mode				}
;{ Parameters:	inOrOut = 1 - go into graphics mode			}
;{			  0 - go out of graphics mode			}
;{		palPtr = pointer to palette				}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
vidMode		Proc	Far


		uses	si,di,es
		arg	inOrOut:word, palPtr:dword

		mov	ax,13h
		mov	cx,inOrOut
		or	cx,cx
		jne	@@InMode
		mov	ax,3
@@InMode:
		int	10h
		les	dx,palPtr
		mov	ax,es
		or	ax,dx
		je	@@NoPal
		mov	ax,1012h
		xor	bx,bx
		mov	cx,256
		int	10h
@@NoPal:
		
		ret

vidMode		Endp

;{----------------------------------------------------------------------}
;{ Function:	displayWall(int x, int y, int destWidth, int destHeight,}
;{				char far *srcptr, char far *bufPtr);	}
;{ Description:	draw a polygonized bitmap raster			}
;{ Parameters:	x = x position to draw to				}
;{		y = y position to draw to				}
;{		destWidth = destination width for bitmap		}
;{		destHeight = destination height for bitmap		}
;{		srcptr = pointer to buffer containing offsets into	}
;{			 source of bitmap				}
;{		bufPtr = the actual bitmap to draw			}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
displayWall	Proc	Far

		uses	si,di,ds,es
		arg	xPos:word, yPos:word, dWidth:word, dHeight:word
		arg	srcPtr:dword, bufPtr:dword

		mov	ax,yPos
		mov	cx,320
		mul	cx
		add	ax,xPos
		mov	di,ax
		mov	ax,0a000h
		mov	es,ax

		lds	si,bufPtr
		mov	bx,word ptr srcPtr	; should have same DS as bufPtr
@@HLoop:
		mov	cx,dWidth		; destination width
		push	di
@@WidthLoop:
		mov	dx,[bx]			; get offset
		add	bx,2			; next x position
		xor	al,al
		cmp	dx,-1
		je	@@NextByte
		xchg	bx,dx			; save srcOffset ptr
		mov	al,[si+bx]		; get source offset byte
		mov	bx,dx			; restore srcOffset ptr
@@NextByte:
		stosb				; put pixel on screen
		loop	@@WidthLoop		; do width of destination
		pop	di
		add	di,320			; next y destination
		dec	dHeight			; and do height
		jne	@@HLoop

		ret

displayWall	Endp


		end

