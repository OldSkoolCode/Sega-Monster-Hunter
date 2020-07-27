

;{----------------------------------------------------------------------}
;{ MACRO	SetVdpRegister REGISTER,VALUE				}
;{ DESCRIPTION:	Puts a value into one of the Genesis's VDP registers.	}
;{		Keeps a local copy in the VDP_SHADOW array - This 	}
;{		macro only works for CONSTANTS. Use SetVdpRegisterCode	}
;{		for registers or variables.				}
;{ PARAMETERS:	Register #,						}
;{		Value to place into the register			}
;{----------------------------------------------------------------------}
SetVdpRegister  MACRO
		MOVE.W  #$8000|(\1<<8)|\2,VCTRL	; check out the SEGA manual
		MOVE.B  #\2,_VdpShadow+(\1)
		ENDM

;{----------------------------------------------------------------------}
;{ MACRO	SetVdpRegisterCode  REGISTER,VALUE			}
;{ DESCRIPTION:	Same as SetVdpRegister, but works with registers	}
;{		instead of constants for the value. Will generate 	}
;{		slightly more code.					}
;{ PARAMETERS:	Register #						}
;{		CPU register containing the value to place into the	}
;{		register						}
;{----------------------------------------------------------------------}
SetVdpRegisterCode MACRO
		and.w   #$00ff,\2	; Mask off high part
		move.b  \2,_VdpShadow+\1 ; Save
		or.w    #$8000|(\1<<8),\2
		move.w  \2,VCTRL
		ENDM
        
;{----------------------------------------------------------------------}
;{ MACRO	ShadowRegister REGISTER,DESTINATION			}
;{ DESCRIPTION:	Loads a CPU register with the value contained in one of	}
;{		the VDP shadow registers				}
;{ PARAMETERS:	Register #						}
;{		Destination of shadow reg copy				}
;{----------------------------------------------------------------------}
ShadowRegister	MACRO
		move.b  _VdpShadow+(\1),\2
		ENDM


;{----------------------------------------------------------------------}
;{ MACRO	AutoIncrement						}
;{ DESCRIPTION:	Sets the autoincrement register of the VDP - Is 	}
;{		equivalent to a SetVdpRegister call, but dosen't 	}
;{		require the register #					}
;{ PARAMETERS:	.							}
;{----------------------------------------------------------------------}
AutoIncrement	MACRO
        	SetVdpRegister  15,\1
        	ENDM


;{----------------------------------------------------------------------}
;{ MACRO	VramWrtAddr						}
;{ DESCRIPTION:	Sets up the VDP for vram Write, calcs an address for	}
;{		the VRAM write.						}
;{ PARAMETERS:	address of VRAM, Where to store the result - long! 	}
;{		(will typically be VCTRL)				}
;{----------------------------------------------------------------------}
VramWrtAddr	MACRO
		move.l  #$40000000|((\1&$3fff)<<16)|((\1>>14)&3),\2
		ENDM


;{----------------------------------------------------------------------}
;{ MACRO	CramWrtAddr						}
;{ DESCRIPTION:	Sets up the VDP for CRAM Write, sets address		}
;{ PARAMETERS:	address of VRAM, Where to store the result - long!	}
;{		(will typically be VCTRL)				}
;{----------------------------------------------------------------------}
CramWrtAddr	MACRO
		move.l  #$C0000000|((\1&$3fff)<<16)|((\1>>14)&3),\2
		ENDM


;{----------------------------------------------------------------------}
;{ MACRO	CalcVramWrtAddrCode					}
;{ DESCRIPTION:	Generates code to set the VRAM write address. This is	}
;{		Different from VramWrtAddr, in that this macro 		}
;{		generates CODE for the shifts and stuff, and 		}
;{		VramWrtAddr only works with constants.			}
;{ PARAMETERS:	REGISTER containing new address in lower 16 bits.	}
;{		NOTE THAT THIS REGISTER IS CLOBBERED WITH A CALL TO 	}
;{		THIS MACRO! REGISTER to receive sega-ized format in all	}
;{		32 bits							}
;{----------------------------------------------------------------------}
CalcVramWrtAddrCode MACRO
		move.w  \1,\2		; Copy for lower 14 bits
		and.l   #$3fff,\2	; mask
		lsl.l   #8,\2
		lsl.l   #8,\2		; Shift up
		or.l    #$40000000,\2	; Set bit that tells VDP it's a VRAM WRITE
		lsr.l   #8,\1
		lsr.l   #6,\1		; Shift down 14 bits
		and.l   #$3,\1
		or.l    \1,\2		; and combine
		ENDM



;{----------------------------------------------------------------------}
;{ MACRO	global							}
;{ DESCRIPTION:	Takes labels and makes them xdef if defined in the	}
;{		current module, else it makes them xref.  Note that	}
;{		the label must be used before global is called. Best	}
;{		solution is put globals at end of source.		}
;{ PARAMETERS:	1-32 of labels						}
;{----------------------------------------------------------------------}
global		MACRO
		rept	narg
		if def(\1)
		xdef	\1
		else
		if ref(\1)
		xref	\1
		endif
		endif
		shift
		endr
		ENDM


;{----------------------------------------------------------------------}
;{ MACRO	Waitbyte						}
;{ DESCRIPTION:	Wait for byte from parallel port			}
;{ PARAMETERS:	.							}
;{ USES:	d2							}
;{----------------------------------------------------------------------}
Waitbyte	MACRO
		local	wloop1, wloop2, wloop3

wloop1:
		move.b	PORTCBITS,d2	; wait till set
		btst	#STRBBIT,d2
		bne.s	wloop1
wloop2:
		move.b	#~BUSYBIT,PORTBBITS	; set BUSY = FALSE
		move.b	PORTCBITS,d2	; get bits from port
		btst	#STRBBIT,d2	; wait till strobe cleared
		beq.s	wloop2

		move.b	PORTABITS,D0	; and grab data
wloop3:
		move.b	#BUSYBIT,PORTBBITS	; Set Busy = TRUE
		move.b	PORTCBITS,d2	; now wait till set
		btst	#STRBBIT,d2
		bne.s	wloop3


		ENDM

;{----------------------------------------------------------------------}
;{ MACRO	Sendbyte						}
;{ DESCRIPTION:	Send byte to parallel port				}
;{ PARAMETERS:	d0 = byte to send					}
;{		a1 = pointer to 16 byte translate table			}
;{ USES:	d1,d2,d3					 	}
;{----------------------------------------------------------------------}
Sendbyte	MACRO
		local	wloop1, wloop2, nextByte

wloop1:
		move.b	PORTCBITS,d2	; wait till set
		btst	#STRBBIT,d2
		bne.s	wloop1

		moveq.l	#2-1,d3		; number of nibbles to send
nextByte:
		move.b	#~BUSYBIT,PORTBBITS	; set BUSY = FALSE
		move.b	PORTCBITS,d2	; get bits from port
		btst	#STRBBIT,d2		; wait till strobe cleared
		beq.s	nextByte

		move.b	d0,d2
		lsr.w	#4,d0
		and.w	#$0f,d2
		move.b	0(a1,d2.w),d1
		or.w	#BUSYBIT,d1	; set BUSY = FALSE
wloop2:
		move.b	d1,PORTBBITS
		move.b	PORTCBITS,d2	; get bits from port
		btst	#STRBBIT,d2		; wait till strobe cleared
		bne.s	wloop2

		dbra	d3,nextByte

		ENDM



