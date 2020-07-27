;{----------------------------------------------------------------------}
;{	DISPLAY.S							}
;{	Monster Hunter:							}
;{	  Player status display routines				}
;{	  Written BY: Thomas S. DeBry and Kenneth L. Hurley		}
;{	  Futurescape Productions Inc.					}
;{	  Copyright (C) 1993 SEGA of America				}
;{----------------------------------------------------------------------}

; $Log: display.s_v $
;Revision 1.6  1993/07/08  15:27:57  KENH
;*** empty log message ***
;
;Revision 1.5  1993/06/14  20:23:14  KENH
;*** empty log message ***
;
;Revision 1.4  1993/06/07  19:54:41  KENH
;*** empty log message ***
;
;Revision 1.3  1993/06/02  07:06:14  KENH
;*** empty log message ***
;
;Revision 1.2  1993/05/13  23:06:49  KENH
;*** empty log message ***
;
;Revision 1.1  1993/04/29  13:48:53  KENH
;Initial revision
;

;	YOU NEED TO CALL THE FOLLOWING ROUTINES IN ORDER TO UTILIZE THE
;	DISPLAY ROUTINES:

;{----------------------------------------------------------------------}
;{ Function:	InitDisplay						}
;{ Description:	Initializes the init routine variables			}
;{		Call at startup when you initialize everything else.	}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	UpdateDisplay						}
;{ Description:	Calls any display routines that need updating		}
;{		Call once each time you reach then end of your main	}
;{		loop.
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	IncHealth						}
;{ Description:	Increments the health value by the amount passed	}
;{ Parameters:	d0 = increment value					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	DecHealth						}
;{ Description:	Decrements the health value by the amount passed	}
;{ Parameters:	d0 = decrement value					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	addScore						}
;{ Description:	Add to the score of player 1				}
;{ Parameters:	d0 = score to add in bcd format				}
;{ returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	AddClips						}
;{ Description:	Increment clip count by passed value			}
;{ Parameters:	d0 = increment value					}
;{ returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	Use1Bullet						}
;{ Description:	Decrement bulletCount by 1, and AmmoCount if nec.	}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}

;{----------------------------------------------------------------------}
;{ Function:	PlotRadarPoint						}
;{ Description:	Plots the point if in valid area of radar		}
;{		Call with the X location and Y distance of a monster	}
;{		Currently set for an X range of 320 and a Y range of	}
;{		320.  These ranges may be modified by changing the	}
;{		equates located with the routine.			}
;{ Parameters:	d0 = X position						}
;{		d1 = Y position						}
;{ returns:	.							}
;{----------------------------------------------------------------------}


	even

	include	macros.i
	include equates.i
	include	globals.i

radarWidth	equ	8		; characters wide
radarHeigth	equ	3		; characters tall

;{----------------------------------------------------------------------}
;{			Variables go here				}
;{----------------------------------------------------------------------}

BssGroup	group	Bss

		section	.bss,BssGroup

;filler		ds.w	400
displayFlag	ds.w	1
healthValue	ds.w	1
radarFrameNo	ds.w	1
clipCount	ds.w	1
bulletCount	ds.w	1
lastRadarAnim	ds.l	1
radarPointList	ds.w	(maxRadarPoints)*3

healthDMAChar	ds.w	8		; DMA buffers
healthDMADef	ds.l	8
scoreDMAChar	ds.w	8
ammoDMADef	ds.l	48
blipsDMASpr	ds.w	maxRadarPoints*4
radarDMAChar	ds.w	radarWidth*radarHeigth

;{----------------------------------------------------------------------}
;{	start of code section						}
;{----------------------------------------------------------------------}

		section	.text

;{----------------------------------------------------------------------}
;{ Function:	InitDisplay						}
;{ Description:	Initializes the init routine variables			}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
initHealthValue	equ	1000		; initial health value
initBulletCount	equ	10		; initial bullet count
initClipCount	equ	12		; initial clip count
initScoreValue	equ	0		; initial score value

updateHealth	equ	$01		; update health bit
updateAmmo	equ	$02		; update ammo bit
updateScore	equ	$04		; update score bit
animRadar	equ	$08		; animate radar bit
updateRadar	equ	$10		; update radar bit

InitDisplay	Module
	; update flag reset
		clr.w	displayFlag

	; health setup
		move.w	#initHealthValue,healthValue
		or.w	#updateHealth,displayFlag

	; ammo setup
		move.w	#initBulletCount,bulletCount
		move.w	#initClipCount,clipCount
		or.w	#updateAmmo,displayFlag

	; score setup
		or.w	#updateScore,displayFlag

	; radar setup
		move.w	#0,radarFrameNo
		move.l	_VCount,d0
		move.l	d0,lastRadarAnim
		or.w	#animRadar,displayFlag

		lea	radarPointList,a1
		move.w	#((maxRadarPoints)*3)-1,d0
.clrPointList:
		clr.w	(a1)+
		dbra	d0,.clrPointList

		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	UpdateDisplay						}
;{ Description:	Calls any display routines that need updating		}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
UpdateDisplay	Module
		move.l	d0,-(sp)	; save used register

;		jsr	checkAnimRadar	; check to see if radar needs anim
		move.w	displayFlag,d0		; get the update flag
.checkHealth
		ror.w	d0
		bcc.s	.checkAmmo
		jsr	ShowHealth
.checkAmmo
		ror.w	d0
		bcc.s	.checkScore
		jsr	ShowAmmo
.checkScore
		ror.w	d0
		bcc.s	.checkRadarAn
		jsr	DisplayScore
.checkRadarAn
		ror.w	d0
;		bcc.s	.checkRadarUd
;		jsr	AnimateRadar
.checkRadarUd
		ror.w	d0
;		bcc.s	.exit
;		jsr	DisplayBlips
.exit
		clr.w	displayFlag	; reset display flag
		move.l	(sp)+,d0	; restore used register
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	IncHealth						}
;{ Description:	Increments the health value by the amount passed	}
;{ Parameters:	d0 = increment value					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
maxHealthValue	equ	1000		; maximum health value

IncHealth	Module
		cmp.w	#maxHealthValue,healthValue	; check for overflow
		beq.s	.exit
		or.w	#updateHealth,displayFlag	; set for update
		add.w	d0,healthValue	; add the value to Health
		cmp.w	#maxHealthValue,healthValue	; check for overflow
		ble.s	.exit
		move.w	#maxHealthValue,healthValue	; set to max
.exit
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	DecHealth						}
;{ Description:	Decrements the health value by the amount passed	}
;{ Parameters:	d0 = decrement value					}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
DecHealth	Module
		cmp.w	#0,healthValue	; check for min
		beq.s	.exit
		or.w	#updateHealth,displayFlag	; set for update
		sub.w	d0,healthValue	; add the value to Health
		bcc.s	.exit		; check for below 0
		move.w	#0,healthValue	; set to min
.exit
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	ShowHealth						}
;{ Description:	Shows the current health value				}
;{ Parameters:	.							}
;{ Returns:	.							}
;{----------------------------------------------------------------------}
healthRange	equ	1000		; max range for health
healthSize	equ	64		; number of pixels for meter
healthDiv	equ	healthRange/healthSize; divisor for number of pixels
						;  to display
healthHiColor	equ	8		; health meter hilight color value
healthBgColor	equ	7		; health meter background color value
healthFullChar	equ	102		; health meter whole character no.
healthPartChar	equ	103		; health meter partial character no.
healthBackChar	equ	104		; health meter background char. no.
healthBarLoc	equ	(24*64+5)*2	; (Yloc * dispWidth + Xloc) * 2
healthPalette	equ	3

ShowHealth	module

		movem.l	d0-d5/a0,-(sp)	; save used registers

	; determine number of whole and pixels in partial health chars
		move.w	healthValue,d0	; get the current health value
		swap	d0		; swap register
		move.w	#0,d0		; set lower word of d0 to 0
		swap	d0		; swap back to correct order
		divu	#healthDiv,d0	; how many health bar pixels
		cmp.w	#healthSize,d0	; check for overflow
		ble.s	.okaySize
		move.w	#healthSize,d0	; set to maximum
.okaySize
		move.w	d0,d1		; make a copy of health value
		move.w	d0,d4		; make a copy of health value
		lsr.w	#3,d1		; divide by 8 to determine
					;  number of whole characters
		move.w	#healthSize,d2	; size of meter in pixels
		lsr.w	#3,d2		; divide by 8 for number of characters
		sub.w	d1,d2		; number of blank chars
		and.w	#$7,d4		; how many pixels for last character

	; send whole health chars
		move.w	_ScrAAddr,d0	; screen address
		add.w	#healthBarLoc,d0	; plus location offset
;		CalcVramWrtAddrCode d3,d4	; calc VRAM addr

;		move.l	d4,VCTRL	; set write address
		lea	healthDMAChar,a0
		move.w	#healthPalette,d3
		move.w	#13,d5
		lsl.w	d5,d3
		move.w	borderChars,d5
		or.w	#$8000,d5		; top priority
		add.w	#healthFullChar,d5
		or.w	d3,d5

		subq.w	#1,d1		; set count value for loop
		bcs.s	.partCharSend	; none if value is < 0
.wholeCharLoop:
;		move.w	d5,VDATA	; send data
		move.w	d5,(a0)+
		dbra	d1,.wholeCharLoop	; loop for all chars

	; send partial character
.partCharSend
		addq.w	#1,d5		; it's the next character
		cmp.w	#0,d4
		beq.s	.bgCharSend
		subq.w	#1,d2		; one less bg char to send
;		move.w	d5,VDATA
		move.w	d5,(a0)+

	; send background characters
.bgCharSend
		addq.w	#1,d5		; it's the next character
		subq.w	#1,d2		; set count value for loop
		blt.s	.extraPixels	; none if value is < 0
.bgCharLoop:
;		move.w	d5,VDATA
		move.w	d5,(a0)+
		dbra	d2,.bgCharLoop	; loop for all bg chars

.extraPixels:
		; add data to DMA list
		move.w	#16,d1		; number of bytes to send
		lea	healthDMAChar,a0
		jsr	AddDMAQueue

	; create partial health char definition
		cmp.w	#0,d4
		beq.s	.exit
		move.w	borderChars,d0
		add.w	#healthPartChar,d0
		lsl.w	#5,d0		; multiply by 32 (bytes/char)
;		CalcVramWrtAddrCode	d5,d4
;		move.l	d4,VCTRL	; set write address
		lea	healthDMADef,a0

		move.w	#8,d1		; number of pixels per char
		sub.w	d4,d1		; number of bg pixels for partial char
		subq.w	#1,d4		; set count value for loop
.partCharLoop1:
		lsl.l	#4,d3		; shift last pixel over
		or.b	#healthHiColor,d3	; one pixel of hilight color
		dbra	d4,.partCharLoop1	; loop for all hilight pixels

		subq.w	#1,d1		; set count value for loop
.partCharLoop2:
		lsl.l	#4,d3		; shift last pixel over
		or.b	#healthBgColor,d3	; one pixel of bg color
		dbra	d1,.partCharLoop2	; loop for all bg pixels

		move.w	#7,d1		; count for # char long words to VRAM
.partCharLoop3:
;		move.l	d3,VDATA
		move.l	d3,(a0)+
		dbra	d1,.partCharLoop3

		; add data to DMA list
		move.w	#32,d1		; number of bytes to send
		lea	healthDMADef,a0
		jsr	AddDMAQueue
.exit

		movem.l	(sp)+,d0-d5/a0	; restore used registers
		rts

		modend

;{----------------------------------------------------------------------}
;{ Function:	DisplayScore						}
;{ Description:	Display the score on the screen				}
;{ Parameters:	.							}
;{ Returns	.							}
;{----------------------------------------------------------------------}
scoreBackChar	equ	104		; health meter background char. no.
scorePalette	equ	3
scoreLoc	equ	(24*64+27)*2	; (Yloc * dispWidth + Xloc) * 2
scoreBaseChar	equ	259		; base character no.

DisplayScore	Module

		movem.l	d0-d3/a0-a2,-(sp)


	; make the string?

		lea	tempbuff,a1
		lea	Score1,a0
		lea	hexAscii,a2
		move.w	#(SCORESIZE*2)-1,d1
		clr.w	d2
		move.w	#4,d3
.ScoreLoop:
		move.b	(a0),d0
		lsr.w	d3,d0
		and.w	#$0f,d0
		move.b	0(a2,d0.w),d0
		cmp.b	#'0',d0
		bne.s	.NotZero
		cmp.w	#0,d1
		beq.s	.NotZero	; make at least one zero
		cmp.w	#0,d2
		beq.s	.NoStore
.NotZero:
		move.w	#1,d2
		move.b	d0,(a1)+
.NoStore:
		eor.w	#4,d3
		beq.s	.NotNextSource
		adda.l	#1,a0
.NotNextSource:
		dbra	d1,.ScoreLoop

		move.b	#0,(a1)+

		lea	tempbuff,a0

	; find number of blank leading characters to write
		move.w	#8,d0		; total possible spaces
.countLeadingLoop:
		subq.w	#1,d0		; decrement space counter
		cmp.b	#0,(a0)+	; check for end of string
		bne.s	.countLeadingLoop

	; send the blank leading characters
		move.w	#scorePalette,d1	; get the palette
		move.w	#13,d2		; palette bits shift value
		lsl.w	d2,d1		; shift palette bits into place
		move.w	borderChars,d2	; this is the offset for the chars
		or.w	#$8000,d2	; top priority
		add.w	#scoreBackChar,d2	; BG char number
		or.w	d1,d2		; OR in the palette bits

		lea	scoreDMAChar,a2
		cmp.w	#0,d0		; check count value for loop
		blt.s	.sendScoreString	; none if value is < 0
.leadingCharLoop:
;		move.w	d2,VDATA	; send data
		move.w	d2,(a2)+
		dbra	d0,.leadingCharLoop	; loop for all chars

.sendScoreString
	; send the numerical string
		move.w	#scorePalette,d1	; get the palette
		move.w	#13,d2		; palette bits shift value
		lsl.w	d2,d1		; shift palette bits into place
		move.w	borderChars,d2	; this is the offset for ASCII chars
		or.w	#$8000,d2	; top priority
		add.w	#scoreBaseChar,d2
		or.w	d1,d2		; OR in the palette bits

		lea	tempbuff,a0	; get the string address
.scoreCharLoop:
		moveq.l	#0,d0		; to clear everything
		move.b	(a0)+,d0	; get the next char
		beq.s	.exit		; if end of string, done
		sub.w	#$30,d0		; get rid of ASCII value
		add.w	d2,d0		; add in palette, offset, priority
;		move.w	d0,VDATA	; send data
		move.w	d0,(a2)+
		bra.s	.scoreCharLoop	; do the whole thing
.exit
		; add data to DMA list
		move.w	_ScrAAddr,d0	; screen address
		add.w	#scoreLoc,d0	; plus location offset
		move.w	#16,d1
		lea	scoreDMAChar,a0
		jsr	AddDMAQueue

		movem.l	(sp)+,d0-d3/a0-a2
		rts

		ModEnd
;{----------------------------------------------------------------------}
;{ Function:	addScore						}
;{ Description:	Add to the score of player 1				}
;{ Parameters:	d0 = score to add in bcd format				}
;{ returns:	.							}
;{----------------------------------------------------------------------}
addScore	Module


		movem.l	d0-d1/a0-a1,-(sp)

		rept	(SCORESIZE-4)/2
		clr.w	tempbuff
		endr
		move.l	d0,tempbuff+(SCORESIZE-4)	; put in memory

		lea	tempbuff+6,a0
		lea	Score1+6,a1
		andi.w	#%11101110,CCR	; clear carry and xtend
		move.w	#SCORESIZE-1,d0
.ScoreLoop:
		abcd	-(a0),-(a1)
		dbra	d0,.ScoreLoop

		or.w	#updateScore,displayFlag
		movem.l	(sp)+,d0-d1/a0-a1
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	ShowAmmo						}
;{ Description:	Display the bullet and clip count sprites		}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
clipBaseChar	equ	158		; base character for clip count
clipCountPal	equ	3		; clip count palette
clipHiColor	equ	$88888888	; hilight color
clipBgColor	equ	$77777777	; background color
clipDvColor	equ	$33333333	; divider color
clipNoColor	equ	$CCCCCCCC	; no bullet color

ShowAmmo	Module
		movem.l	d0-d3/a0,-(sp)	; save used registers

	; show clip count
;		CalcVramWrtAddrCode	d0,d1
;		move.l	d1,VCTRL	; set write address

		lea	ammoDMADef,a0
		
		move.w	clipCount,d0	; clip count
		cmp.w	#8,d0		; test for overflow
		blt.s	.clipValOkay
		move.w	#8,d0		; set to max value
.clipValOkay:
		move.w	#8,d1		; pixels per char
		sub.w	d0,d1		; bg pixel count
		subq.w	#1,d1		; set count value for loop
		bcs.s	.clipHiSend

.clipBGLoop:
		move.l	#clipBgColor,(a0)+
		dbra	d1,.clipBGLoop

.clipHiSend:
		subq.w	#1,d0		; set count value for loop
		bcs.s	.showBullets

.clipHILoop:
		move.l	#clipHiColor,(a0)+
		dbra	d0,.clipHILoop

.showBullets:
		move.w	#9,d0		; 10 bullets to loop through
		move.w	#11,d1
.bulletLoop:
		subq.w	#1,d1
		move.l	#clipDvColor,(a0)+
		move.l	#clipDvColor,(a0)+

		cmp.w	bulletCount,d1	; check for bullet in this position
		bgt.s	.noBullet	; show no bullet
		move.l	#clipHiColor,(a0)+
		move.l	#clipHiColor,(a0)+
		dbra	d0,.bulletLoop
		bra.s	.exit
.noBullet
		move.l	#clipNoColor,(a0)+
		move.l	#clipNoColor,(a0)+
		dbra	d0,.bulletLoop

.exit:
		move.w	StatSprChars+STATICLEFTSIDE,d0
		add.w	#clipBaseChar,d0
		lsl.w	#5,d0		; multiply by 32 (bytes/char)

		move.w	#192,d1
		lea	ammoDMADef,a0
		jsr	AddDMAQueue

		movem.l	(sp)+,d0-d3/a0	; restore used registers
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	AddClips						}
;{ Description:	Increment clip count by passed value			}
;{ Parameters:	d0 = increment value					}
;{ returns:	.							}
;{----------------------------------------------------------------------}
AddClips	Module
		add.w	d0,clipCount
		cmp.w	#0,bulletCount
		bne.s	.exit
		move.w	#10,bulletCount
		subq.w	#1,clipCount
		bge.s	.exit
		clr.w	bulletCount
		clr.w	clipCount
.exit
		or.w	#updateAmmo,displayFlag
		rts
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	Use1Bullet						}
;{ Description:	Decrement bulletCount by 1, and AmmoCount if nec.	}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
Use1Bullet	Module
		cmp.w	#0,bulletCount
		bne.s	.haveAmmo
		cmp.w	#0,clipCount
		beq.w	.exit
.haveAmmo
		or.w	#updateAmmo,displayFlag
		subq.w	#1,bulletCount
		bne.s	.exit
		move.w	#10,bulletCount
		subq.w	#1,clipCount
		bge.s	.exit
		clr.w	bulletCount
		clr.w	clipCount
.exit
		rts
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	CheckAnimRadar						}
;{ Description:	Check for need to animate radar				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
radarDelay	equ	10		; vblanks to delay before next frame
CheckAnimRadar	Module
		movem.l	d0-d1,-(sp)	; save used registers
		move.l	_VCount,d0
		sub.l	lastRadarAnim,d0
		bcc.s	.posVal
		move.l	lastRadarAnim,d0
		move.l	_VCount,d1
		sub.l	d1,d0
.posVal
		cmp.w	#radarDelay,d0
		blt.s	.exit
		move.l	_VCount,d0
		move.l	d0,lastRadarAnim
		or.w	#animRadar,displayFlag
		jsr	DecayRadarPoints	; decay any point on screen
.exit
		movem.l	(sp)+,d0-d1	; restore used registers
		rts

		ModEnd

frame3Table	dc.b	20,20,20,20,20,20,20,20,20,19,19,18,18,17
		dc.b	17,14,14,14,14,13,12,11,10,09,07,06,04,02

frame2Table	dc.b	15,15,15,15,15,14,14,14,13,13,12,11,11,10
		dc.b	09,08,07,05,02,00,00,00,00,00,00,00,00,00

frame1Table	dc.b	09,09,09,08,08,08,07,06,05,04,02,00,00,00
		dc.b	00,00,00,00,00,00,00,00,00,00,00,00,00,00

;{----------------------------------------------------------------------}
;{ Function:	AddRadarPoint						}
;{ Description:	Add a point to the radar point list			}
;{ Parameters:	d0 = X position						}
;{		d1 = Y position						}
;{ returns:	.							}
;{----------------------------------------------------------------------}
AddRadarPoint	Module
		movem.l	d3/a0,-(sp)	; save used registers

	; find first available spot
		move.w	#maxRadarPoints,d3
		subq.w	#1,d3		; set count for loop
		lea	radarPointList,a0
.locateSpotLoop:
		cmp.w	#0,(a0)
		beq.s	.foundSpot
		addq.l	#6,a0
		dbra	d3,.locateSpotLoop
	; no empty spaces
		bra.s	.exit
.foundSpot
	; fill the spot data
		move.w	d0,(a0)+	; X Pos
		move.w	d1,(a0)+	; Y Pos
		move.w	#3,(a0)+	; hilight value - full on

		or.w	#updateRadar,displayFlag
.exit
		movem.l	(sp)+,d3/a0	; restore used registers
		rts
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	DecayRadarPoints					}
;{ Description:	Decay any points on radar by 1				}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
DecayRadarPoints	Module
		movem.l	d3/a0,-(sp)	; save used registers
	; loop through all possible available spots
		move.w	#maxRadarPoints,d3
		subq.w	#1,d3		; set count for loop
		lea	radarPointList,a0
		addq.w	#4,a0		; point to decay value
.decaySpotLoop:
		cmp.w	#0,(a0)
		beq.s	.nextSpot	; spot is empty
		or.w	#updateRadar,displayFlag
		sub.w	#1,(a0)
		bne.s	.nextSpot	; delete spot
		sub.w	#4,a0
		move.w	#0,(a0)+	; X Pos
		move.w	#0,(a0)+	; Y Pos
.nextSpot
		addq.l	#6,a0
		dbra	d3,.decaySpotLoop

		movem.l	(sp)+,d3/a0	; restore used registers
		rts
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	PlotRadarPoint						}
;{ Description:	Plots the point if in valid area of radar		}
;{ Parameters:	d0 = X position						}
;{		d1 = Y position						}
;{ returns:	.							}
;{----------------------------------------------------------------------}
radarPixelWidth		equ	56-2	; pixels wide of radar
radarPixelHeight	equ	20-1	; pixels tall of radar
radarRangeX		equ	320	; X range of monster data
radarRangeY		equ	320	; Y range of monster data
radarXDiv		equ	radarRangeX/radarPixelWidth
radarYDiv		equ	radarRangeY/radarPixelHeight
radarXPos		equ	130
radarYPos		equ	204

PlotRadarPoint	Module
	; check for new point in current frame
		movem.l	d0-d5/a0-a1,-(sp)	; save used registers

	; convert X position to a value between 0 and 19
		swap	d0
		move.w	#0,d0
		swap	d0
		divu	#radarXDiv,d0	; radar pixel location
		cmp.w	#radarPixelWidth,d0	; check for overflow
		ble.s	.XOkay
		move.w	#radarPixelWidth,d0
.XOkay
	; convert Y position to a value between 0 and 19
		swap	d1
		move.w	#0,d1
		swap	d1
		divu	#radarYDiv,d1	; radar pixel location
		cmp.w	#radarPixelHeight,d1	; check for overflow
		ble.s	.YOkay
		move.w	#radarPixelHeight,d1
.YOkay
		add.w	#1,d1		; no 0 values
		move.w	#radarPixelWidth/2,d5		; start on left
	; determine whether X is on left or right of center
		cmp.w	#radarPixelWidth/2,d0
		blt.s	.leftSide
		move.w	d0,d4
		sub.w	#radarPixelWidth/2,d0
		bra.s	.sideFound
.leftSide
		move.w	d0,d4
		sub.w	d0,d5
		move.w	d5,d0
.sideFound


		move.w	radarFrameNo,d3
		beq.s	.exit
		sub.w	#1,d3
		bne.	.not1
		lea	frame1Table,a0	; get the frame table addr.
		bra.s	.gotTable
.not1
		sub.w	#1,d3
		bne.	.not2
		lea	frame2Table,a0	; get the frame table addr.
		lea	frame1Table,a1	; get the frame table addr.
		bra.s	.gotTable
.not2
		lea	frame3Table,a0	; get the frame table addr.
		lea	frame2Table,a1	; get the frame table addr.
	; see that point is less than value in table
.gotTable
		move.b	0(a0,d0.w),d3
;		cmp.b	0(a0,d0.w),d1
		cmp.b	d3,d1
		bgt.s	.exit		; can't plot it
	; see that the point is greater than the previous frame's area
		cmp.w	#1,radarFrameNo	; don't need to check here
		beq.s	.goodPoint
		move.b	0(a1,d0.w),d3
;		cmp.b	0(a1,d0.w),d1
		cmp.b	d3,d1
		ble.s	.exit		; can't plot it
	; point is good, so add it to the list
.goodPoint
	; adjust point for screen location of radar
		move.w	d4,d0		; correct for left/right
		add.w	#radarXPos,d0
		move.w	d1,d4
		move.w	#radarYPos,d1
		sub.w	d4,d1
		jsr	AddRadarPoint
		
.exit
		movem.l	(sp)+,d0-d5/a0-a1	; restore used registers
		rts
		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	DisplayBlips						}
;{ Description:	Writes Radar Blips to sprite list			}
;{ Parameters:	d0 = X position						}
;{		d1 = Y position						}
;{ returns:	.							}
;{----------------------------------------------------------------------}
DisplayBlips	Module
	; display the radar blip sprites
		movem.l	d0-d3/a0-a2,-(sp)	; save used registers

		move.w	StatSprNum+STATICBLIP,d2	; get sprite list address
		lsl.w	#3,d2
		lea	_Work_Sprlist,a0
		adda.w	d2,a0

	; loop through all spots

		move.w	#maxRadarPoints,d2
		subq.w	#1,d2		; set count for loop
		lea	radarPointList,a1
		lea	blipsDMASpr,a2

.dispBlipLoop
		move.w	(a1)+,d0	; X pos
		move.w	(a1)+,d1	; Y pos
		add.w	#$80,d0		; adjust X Pos
		add.w	#$80,d1		; adjust Y Pos
		move.w	d0,SAXPOS(a0)
		move.w	d1,SAYPOS(a0)
		move.w	(a1)+,d0	; decay level
		beq.s	.allgone
		sub.w	#1,d0
.allGone:
		add.w	StatSprChars+STATICBLIP,d0
		or.w	#CHARPRIORITY,d0
		move.w	d0,SAATTRIBUTES(a0)

		move.w	(a0)+,(a2)+
		move.w	(a0)+,(a2)+
		move.w	(a0)+,(a2)+
		move.w	(a0)+,(a2)+
;		move.w	(a0)+,VDATA	; send data
;		move.w	(a0)+,VDATA	; send data
;		move.w	(a0)+,VDATA	; send data
;		move.w	(a0)+,VDATA	; send data
		dbra	d2,.dispBlipLoop	; loop for all points

		move.w	StatSprNum+STATICBLIP,d0	; get sprite list address
		lsl.w	#3,d0
		add.w	_SprAttrAddr,d0
		move.w	#maxRadarPoints*4*2,d1
		lea	blipsDMASpr,a0
		jsr	AddDMAQueue

		movem.l	(sp)+,d0-d3/a0-a2	; restore used registers
		rts

		ModEnd

;{----------------------------------------------------------------------}
;{ Function:	AnimateRadar						}
;{ Description:	Shows the next Radar animation frame			}
;{ Parameters:	.							}
;{ returns:	.							}
;{----------------------------------------------------------------------}
radarFrameCount	equ	4		; number of radar animation frames
radarBaseChar	equ	163		; base char no. of first frame
radarLoc	equ	(23*64+16)*2	; (Yloc * dispWidth + Xloc) * 2
radarPalette	equ	3		; radar palette
radarColOffset	equ	32		; offset to next column of chars

AnimateRadar	Module

		movem.l	d0-d7/a0,-(sp)	; save used registers

		move.w	radarFrameNo,d0	; get last animation frame number
		addq.w	#1,d0		; increment animation frame counter
		cmp.w	#radarFrameCount,d0	; check for wrap
		blt.s	.setFrameNo
		move.w	#0,d0		; reset to first frame
.setFrameNo:
		move.w	d0,radarFrameNo	; save new frame number
		lsl.w	#3,d0		; multiply by 32 to point to 1st char
		add.w	#radarBaseChar,d0	; add radar base char no.
		
	; set VRAM to write the radar

		move.w	#radarWidth,d5
		subq.w	#1,d5
		move.w	#radarHeigth,d6
		subq.w	#1,d6
		lea	radarDMAChar,a0
.writeRadarLoop1:
		move.w	#radarPalette,d3	; get the palette
		move.w	#13,d4		; palette shift value
		lsl.w	d4,d3		; shift the palette bits into place
		move.w	borderChars,d4
		or.w	#$8000,d4		; top priority
		add.w	d0,d4		; add base char number
		or.w	d3,d4		; OR in the palette bits
.writeRadarLoop2:
		move.w	d4,(a0)+
;		move.w	d4,VDATA	; write the data
		addq.w	#1,d4		; next character
		dbra	d5,.writeRadarLoop2	; for entire width of radar

		add.w	#radarColOffset,d0	; point to next line
		move.w	#radarWidth,d5
		subq.w	#1,d5
		dbra	d6,.writeRadarLoop1	; loop for all radar lines

		move.w	_ScrAAddr,d0	; screen address
		add.w	#radarLoc,d0	; plus location offset

		move.w	#radarHeigth,d2
		subq.w	#1,d2
		lea	radarDMAChar,a0
.writeRadarLoop3:
		move.w	#radarWidth*2,d1
		jsr	AddDMAQueue

		add.w	#128,d0		; for next line
		adda.w	#radarWidth*2,a0
		dbra	d2,.writeRadarLoop3	; loop for all radar lines

.exit:
		movem.l	(sp)+,d0-d7/a0	; restore used registers
		rts

		ModEnd
