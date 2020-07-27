	section	Scaler

True	equ	-1
False	equ	0
	include	scaler.i


SPRITEATTR	=	55*1024
OpenLoop	equ	True
ScaleStart

; Can't do ...
; DFlip and AutoConvert
; AutoSend and OutputType=0

; Main sprite scaler entry point
; Entry :
;   d0 - Service
;        0=Initialise
;        1=Convert
;        2=MakeGrid
;        3=ScaleSprite
;        4=Resume interrupted operation
;   Long word before sprite scaler points to variables area
; Exit :
;   d0 - Result
;        0  =OK (Scaling complete)
;        1  =Scaling paused
;        -ve=Error
SpriteScaler	module
	movem.l	d1-d7/a0-a6,-(a7)
	lea	ScaleStart(pc),a0
; Dispatch to appropriate service
	if	def(MakeBin)
	move.l	-4(a0),a6
	endif
	add.w	d0,d0
	add.w	.Dispatch(pc,d0.w),a0
	jsr	(a0)
	movem.l	(a7)+,d1-d7/a0-a6
	rts
.Dispatch	dc.w	ScaleInit-ScaleStart
	dc.w	Nibble2Byte-ScaleStart
	dc.w	MakeGrid-ScaleStart
	dc.w	ScaleSprite-ScaleStart
	dc.w	Resume-ScaleStart
	modend

; Initialise a few variables
; This service isn't that necessary at the moment but it may be vital
; at a later date.
ScaleInit	module
	st	DestIsRect(a6)
	sf	XFlip(a6)
	sf	YFlip(a6)
	sf	DFlip(a6)
	sf	AutoConvert(a6)
	sf	AutoSend(a6)
	st	OldOutputType(a6)
	st	DestIsRect(a6)
	lea	ScaleDMA(pc),a2
	move.l	a2,DMARoutine(a6)
	st	LinesPerRun(a6)
	move.w	#SVDP_ModeSet2+$54,DMAOn(a6)	; VInt off,DMA on
	move.w	#SVDP_ModeSet2+$64,DMAOff(a6)	; VInt on,DMA off
; Return address of UnpackTab
	lea	UnpackTab(pc),a0
	move.l	a0,d0
	rts
	modend
 
; Nibble2Byte
;-------------
;
; Converts from nibble packed format to byte per pixel
; Input ;
;   SrcDataPtr  - Input data
;   DestDataPtr - Output buffer
;   SrcWidth,
;   SrcHeight   - size of input structure in pixels
Nibble2Byte	module
	move.l	SrcDataPtr(a6),a0
	move.l	DestDataPtr(a6),a1
	move.w	SrcWidth(a6),d0
	mulu	SrcHeight(a6),d0
	lsr.w	#1,d0
	subq.w	#1,d0
	lea	UnpackTab(pc),a2
.EachByte	moveq	#0,d1
	move.b	(a0)+,d1
	add.w	d1,d1
	move.w	0(a2,d1.w),d1
	move.w	d1,(a1)+
	dbra	d0,.EachByte
	rts
	modend

; MakeGrid
;----------
;
; MakeGrid
; Generates data needed to make a grid of sprites
; Interface :
;   DestWidth.w   - overall width of dest structure in characters
;   DestHeight.w  - overall height of dest structure in characters
;   DestDataPtr   - buffer for data
; The output data is of the form :-
;   Number of sprites.w
;   [
;   VPos.w	- Vertical offset in grid
;   Size.w	- lower 4 bits contain hs1,hs0,vs1,vs0
;   Cell.w	- Cell offset in grid
;   HPos.w	- Horizontal offset in grid
;   ]
; Affects :
;   d0-d7/a1-a3
MakeGrid	module
	move.l	DestDataPtr(a6),a2
	move.l	a2,-(a7)
	addq.w	#4,a2	; leave room for count
	lea	SpriteSizeTab(pc),a3
	moveq	#0,d7	; clear sprite count
	move.w	fillXQty(a6),d6	; starting cell accumulator
	move.w	DestHeight(a6),d0
	sub.l	a0,a0	; clear y
.EachY	move.w	d0,d2	; assume current height
	cmp.w	#4,d0
	ble.s	.NotGT4a
	moveq	#4,d2	; fix current height
.NotGT4a
	move.w	d2,d5
	subq.w	#1,d5
	move.w	DestWidth(a6),d1
	sub.l	a1,a1
.EachX	move.w	d1,d3	; assume current width
	cmp.w	#4,d1
	ble.s	.NotGT4b
	moveq	#4,d3
.NotGT4b
; Get and write size word
	move.w	d3,d4
	subq.w	#1,d4
	add.w	d4,d4
	add.w	d4,d4
	add.w	d5,d4
; write Vpos
	move.w	a0,(a2)+
; write Size/link
	lsl.w	#8,d4
	move.w	d4,(a2)+
	lsr.w	#8,d4
; Write cell,flip and palette
	move.w	d6,(a2)+
; Write Hsize
	move.w	a1,(a2)+
; Index size table and adjust cell count
	add.w	d4,d4
	add.w	0(a3,d4.w),d6
	addq.w	#1,d7
; adjust HPos
	move.w	d3,d4
	lsl.w	#3,d4	; *8 to go from cells to pixels
	add.w	d4,a1	; HPos
; Loop
	sub.w	d3,d1
	bne.s	.EachX
; adjust VPos
	move.w	d2,d5
	lsl.w	#3,d5	; *8 to go from cells to pixels
	add.w	d5,a0	; VPos
; loop
	sub.w	d2,d0
	bne.s	.EachY
; Fill in count
	move.l	(a7)+,a0
	move.w	d7,(a0)
.OK	moveq	#0,d0
.Exit	rts
	modend

; This routine is used if the scaler has paused itself.
; It restarts the scaling operation where it left off.
Resume	module
	movem.l	StopRegs(a6),d0-d7/a0-a5
	move.w	LinesPerRun(a6),LinesThisRun(a6)
	move.l	StopPC(a6),-(a7)
	rts
	modend

; ScaleSprite
;-------------
;
; Interface :
;   SrcWidth.w    - overall size of structure src is in (pixels)
;   SrcHeight.w   - overall size of structure src is in (lines)
;   SrcXPos.w     - x position of source in data structure
;   SrcYPos.w     - y position of source in data structure
;   SrcXSize.w    - x size of src rectangle
;   SrcYSize.w    - y size of src rectangle
;   DestWidth.w   - overall width of dest structure in characters
;   DestHeight.w  - overall height of dest structure in characters
;   DestXSize.w   - x size of dest rectangle (pixels)
;   DestYSize.w   - y size of dest rectangle (pixels)
;   FillAction.w  - 0=don't clear destination (If you know buffer is zero'd)
;	      1=clear destination before starting
;	      2=clear whilst scaling (MUST be used for AutoSend)
;   OutputType.w  - 0=vertical character cells
;	      1=sprite grid
;   SrcDataPtr.l  - Pointer to start of input data
;   DestDataPtr.l - Pointer to start of output ptr
; Variables needed for reflections
;   XFlip.b	    - True=reflect in x dimension
;   YFlip.b	    - True=reflect in y dimension
;   DFlip.b	    - True=rotate 90 degrees
; Variables needed for auto-convert feature
;   AutoConvert.b - True=autoconvert data
; Variables needed for auto-send feature
;   Autosend.b    - True=send output to VRAM as it is generated
;                   This only applies when type 1 output is being generated.
;   VRAMAddr.w    - Addr in VRAM to which to send output
;                   This only applies to type 1 output.
;   DMARoutine.l  - Address of routine for the DMA to VRAM
; Multi_pass variables
;   LinesPerRun.w - Number of pixel lines per call of ScaleSprite
; Trapezium variables
;   DestIsRect.b  - True=rectangle mode, False=trapezium mode
;   DestXSize1.w  - x size of top of destination (pixels)
;   DestXSize2.w  - x size of bottom of destination (pixels)
;   DestXPos1.w   - x position of top of destination (pixels)
;   DestXPos2.w   - x position of bottom of destination (pixels)
;
; NOTE:
;   None of the input variables are changed in any way by the scaler so
;   you need not re-initialise any that are constant.
; Affects :
;   Nothing

ScaleSprite	module

; Check how many lines we are doing this run
	move.w	LinesPerRun(a6),LinesThisRun(a6)

; Check if the output object is a rectangle or a trapezium
; A seperate routine is used for the trapezium shape as there isn't a great
; deal of shared code.
	tst.b	DestIsRect(a6)
	beq	ScaleTrapezium

ScaleRectangle
; If Output type has changed we need to regenerate tables
; These optimisations mean that the XAdd and YAdd tables are only
; recreated when necessary
	move.w	OutputType(a6),d0
	cmp.w	OldOutputType(a6),d0
	beq.s	.SameType
	move.w	d0,OldOutputType(a6)
	moveq	#-1,d0
	move.l	d0,OldDestWidth(a6)
	sf	Old4Tab(a6)
.SameType
	move.w	VRAMAddr(a6),DMADest(a6)
; If FillAction is 1 clear the destination
	move.w	FillAction(a6),d0
	beq.s	.NoFill
	subq.w	#1,d0
	bne.s	.NoPreClear

	move.w	DestWidth(a6),d0
	mulu	DestHeight(a6),d0
	moveq	#0,d1
	move.l	d1,d2
	move.l	d1,d3
	move.l	d1,d4
	move.l	d1,a1
	move.l	d1,a2
	move.l	d1,a3
	move.l	d1,a4
	move.l	DestDataPtr(a6),a0
	subq.w	#1,d0
.ClearLoop	movem.l	d1-d4/a1-a4,(a0)
	lea	32(a0),a0
	dbra	d0,.ClearLoop
.NoFill	moveq	#0,d0
	move.w	d0,FillXQty(a6)
	move.w	d0,FillYQty(a6)
	bra.s	.DoneFill

; Must be Clear as go along so work out amounts to fill
.NoPreClear	move.w	DestWidth(a6),d0
	lsl.w	#3,d0	; get pixels
	sub.w	DestXSize(a6),d0	; work out extras
	lsr.w	#1,d0	; go from pixels to bytes
	move.w	d0,FillXQty(a6)
	move.w	DestHeight(a6),d0
	lsl.w	#3,d0	; get pixels
	sub.w	DestYSize(a6),d0	; work out extras
	move.w	d0,FillYQty(a6)
.DoneFill

; Work out SrcBytes - different depending on autoconvert
	move.w	SrcWidth(a6),d0	; get pixels
	tst.b	AutoConvert(a6)
	beq.s	.NoAutoConva
	addq.w	#1,d0
	lsr.w	#1,d0	; now converted to bytes
.NoAutoConva	move.w	d0,SrcBytes(a6)

; Generate the Y offset table
; This table is the amount to add to the Source pointer to move down a line
; in the destination.
	lea	YAddSrc(a6),a4
	lea	XAddSrc(a6),a5
	move.w	DestXSize(a6),d6
	move.w	DestYSize(a6),d7
	tst.b	DFlip(a6)
	beq.s	.NoDFlip
	exg	a4,a5
	exg	d6,d7
.NoDFlip
; Get SrcY/DestY
	moveq	#0,d4
	move.w	SrcYSize(a6),d4
	divu	d7,d4	; Src/Dest
	move.l	d4,d2
	clr.w	d2
	divu	d7,d2	; handle remainder
	swap	d4
	move.w	d2,d4
	moveq	#0,d2	; used to be $8000
	moveq	#0,d3
	move.w	SrcBytes(a6),d0	; width of source in bytes
; Check for Y reflection
	tst.b	YFlip(a6)
	beq.s	.NoYFlipa
	neg.w	d0
.NoYFlipa
	subq.w	#1,d7
.EachLine1	add.l	d4,d2
	move.l	d2,d1
	swap	d1
	muls	d0,d1	; get index into data
	sub.w	d3,d1
	move.w	d1,(a4)+
	add.w	d1,d3
.NextLine1	dbra	d7,.EachLine1

; And then generate the table of offsets to add to the X
	moveq	#0,d5
	move.w	SrcXSize(a6),d5
	divu	d6,d5	; Src/Dest
	move.l	d5,d2
	clr.w	d2
	divu	d6,d2
	swap	d5
	move.w	d2,d5
	moveq	#0,d2	; use to be $8000
	moveq	#0,d3
; Check for X Reflection
	tst.b	XFlip(a6)
	beq.s	.NoXFlipa
	neg.l	d5
	moveq	#-1,d3
.NoXFlipa

	subq.w	#1,d6
.EachLine2	add.l	d5,d2
	move.l	d2,d1
	swap	d1
	sub.w	d3,d1
	move.w	d1,(a5)+
	add.w	d1,d3
.NextLine2	dbra	d6,.EachLine2

; Now generate the Dest tables by calling correct routine.
	pea	.MadeTabs(pc)
	move.w	OutputType(a6),d0
	beq	MakeDestTab_Char
	bra	MakeDestTab_Sprite
.MadeTabs
; Setup misc. constants
	pusho
	opt	w-
	moveq	#$F0,d4
	moveq	#$0F,d5
	popo
; Get src address
	move.w	SrcYPos(a6),d0
; Check for Y relection
	tst.b	YFlip(a6)
	beq.s	.NoYFlipb
	add.w	SrcYSize(a6),d0
	subq.w	#1,d0
.NoYFlipb
	mulu	SrcBytes(a6),d0
	add.w	SrcXPos(a6),d0
; Check for X reflection
	tst.b	XFlip(a6)
	beq.s	.NoXFlipb
	tst.b	AutoConvert(a6)
	bne.s	.NoXFlipB		; taken care of later
	add.w	SrcXSize(a6),d0
	subq.w	#1,d0
.NoXFlipb
	move.w	d0,a0
	add.l	SrcDataPtr(a6),a0

; Now enter the main loops
	lea	YAddDest(a6),a5
	move.w	DestYSize(a6),d7	; DestY-1 as outer count
	lea	YAddSrc(a6),a4
; Get dest address
	move.l	DestDataPtr(a6),a1
; Check if we are autosending
	tst.b	AutoSend(a6)
	beq.s	.NoAuto
; We are autosending so work out how many lines we can do
.DoLines	move.w	d7,d0
	cmp.w	#32,d7
	ble.s	.NotGT32
	moveq	#32,d7
.NotGT32	sub.w	d7,d0
	move.w	d7,LinesDone(a6)
	move.w	d0,LinesLeft(a6)
.NoAuto	subq.w	#1,d7
.EachY	swap	d7
	move.l	a0,d3	; save source pointer
	move.l	a1,d6	; save dest pointer

; Check for auto-convert
	tst.b	AutoConvert(a6)
	beq.s	.NoAutoConvb
; We are auto-converting so unpack data
	lea	SrcBuffer(a6),a2
	lea	UnpackTab(pc),a3
	move.w	SrcBytes(a6),d7
	subq.w	#1,d7
.AutoLoop	moveq	#0,d0
	move.b	(a0)+,d0
	add.w	d0,d0
	move.w	0(a3,d0.w),(a2)+
	dbra	d7,.AutoLoop
	lea	SrcBuffer(a6),a0
	tst.b	XFlip(a6)
	beq.s	.NoAutoConvb
	add.w	SrcXSize(a6),a0
	suba.w	#1,a0
.NoAutoConvb
	lea	XAddSrc(a6),a2

; Get correct XTab (only needed for sprite output)
	subq.w	#1,XAddChange(a6)
	bpl.s	.Tab1
	lea	XAddDest2(a6),a3
	bra.s	.GotTab
.Tab1	lea	XAddDest(a6),a3
.GotTab
	move.w	DestXSize(a6),d7	; (DestX/2)-1 as inner count
	move.w	d7,d2

	lsr.w	#1,d7
	beq	.DoExtra
	if	OpenLoop
	neg.w	d7
	add.w	#160,d7
	add.w	d7,d7
	move.w	d7,d0
	lsl.w	#3,d7
	add.w	d0,d7
	jmp	.Scale(pc,d7.w)

.Scale	rept	160
	move.b	(a0),d0	; Get 1st pixel
	add.w	(a2)+,a0	; advance x
	and.b	d4,d0	; loose bottom nibble

	move.b	(a0),d1	; Get 2nd pixel
	add.w	(a2)+,a0	; advance x
	and.b	d5,d1	; loose top nibble

	or.b	d1,d0
	move.b	d0,(a1)
	add.w	(a3)+,a1	; move output ptr
	endr

	else
	subq.w	#1,d7

.EachX	move.b	(a0),d0	; Get 1st pixel
	add.w	(a2)+,a0	; advance x
	and.b	d4,d0	; loose bottom nibble

	move.b	(a0),d1	; Get 2nd pixel
	add.w	(a2)+,a0	; advance x
	and.b	d5,d1	; loose top nibble

	or.b	d1,d0
	move.b	d0,(a1)
	add.w	(a3)+,a1	; move output ptr

	dbra	d7,.EachX
	endif

; Check for odd pixel
.DoExtra	btst	#0,d2
	beq.s	.NoExtra

	move.b	(a0),d0	; Get pixel
	and.b	d4,d0	; loose bottom nibble
	move.b	d0,(a1)	; store value
	add.w	(a3)+,a1	; move output ptr
.NoExtra
; Check for extra bytes to blank (only for FillAction=2)
	move.w	FillXQty(a6),d7
	beq.s	.NextY
	subq.w	#1,d7
	moveq	#0,d0
.EachXFill	move.b	d0,(a1)
	add.w	(a3)+,a1	; move output ptr
	dbra	d7,.EachXFill

; end of x loop - loop to next line
.NextY	swap	d7	; get counter
	move.l	d3,a0	; start of source line
	add.w	(a4)+,a0	; step to next source line
	move.l	d6,a1	; start of dest line
	add.w	(a5)+,a1	; step to next dest line
; Check to see if we should pause scaling
	subq.w	#1,LinesThisRun(a6)
	beq	.Pause
; This is a second entry point!
ReScale
	dbra	d7,.EachY
; See if we have finished or if it is time to AutoSend
	tst.b	AutoSend(a6)
	beq.s	.Finished
; See if we need to end fill first
	move.w	LinesLeft(a6),d7	; have we finished the sprite?
	bne.s	.MoreLines	; no
	move.w	FillYQty(a6),d7	; yes, so see if any to fill
	beq	.MoveIt
; we now need to check that we aren't going to fill too much!
.MoveMore	move.w	d7,d0
	moveq	#32,d1	; max lines per block
	sub.w	LinesDone(a6),d1	; -number we just did
	cmp.w	d1,d7
	ble.s	.CanDo
	move.w	d1,d7	; amount we can do
.CanDo	sub.w	d7,FillYQty(a6)
	clr.w	LinesDone(a6)
	bsr	EndFill

; move block to VRAM
.MoveIt	move.l	a1,d2	; current pos
	move.l	DestDataPtr(a6),a1	; start
	move.l	a1,d3
	sub.l	d3,d2	; diff. in bytes
	move.w	DMADest(a6),d0
	add.w	d2,DMADest(a6)
; Check which DMA routine to use
	move.l	DMARoutine(a6),a2
	jsr	(a2)
	move.w	FillYQty(a6),d7	; see if any more blocks
	bne.s	.MoveMore
	bra.s	.OK

.MoreLines
; move block to VRAM
	move.l	a1,d2	; current pos
	move.l	DestDataPtr(a6),a1	; start
	move.l	a1,d3
	sub.l	d3,d2	; diff. in bytes
	move.w	DMADest(a6),d0
	add.w	d2,DMADest(a6)
; Check which DMA routine to use
	move.l	DMARoutine(a6),a2
	jsr	(a2)
	bra	.DoLines
	
; Check for extra lines to blank (only for FillAction=2) when no AutoSend
.Finished	move.w	FillYQty(a6),d7
	beq.s	.Filledb
	bsr	EndFill
.Filledb
.OK	moveq	#0,d0
.Exit	rts

.Pause	movem.l	d0-d7/a0-a5,StopRegs(a6)
	lea	ReScale(pc),a0
	move.l	a0,StopPC(a6)
	moveq	#1,d0
	bra.s	.Exit
	modend	; of ScaleSprite

; Handles non-rectangular output objects
ScaleTrapezium module

; Force regeneration of output tables
; The trapezium function will almost always be used with different
; sized output objects between calls
	move.w	d0,OldOutputType(a6)
	moveq	#-1,d0
	move.l	d0,OldDestWidth(a6)
	sf	Old4Tab(a6)

	move.w	VRAMAddr(a6),DMADest(a6)
; If FillAction is 1 clear the destination
	move.w	FillAction(a6),d0
	beq.s	.NoFill
	subq.w	#1,d0
	bne.s	.NoPreClear

	move.w	DestWidth(a6),d0
	mulu	DestHeight(a6),d0
	moveq	#0,d1
	move.l	d1,d2
	move.l	d1,d3
	move.l	d1,d4
	move.l	d1,a1
	move.l	d1,a2
	move.l	d1,a3
	move.l	d1,a4
	move.l	DestDataPtr(a6),a0
	subq.w	#1,d0
.ClearLoop	movem.l	d1-d4/a1-a4,(a0)
	lea	32(a0),a0
	dbra	d0,.ClearLoop
	bra.s	.DoneFill

.NoFill	moveq	#0,d0
	move.w	d0,FillYQty(a6)
	bra.s	.DoneFill

.NoPreClear	move.w	DestHeight(a6),d0
	lsl.w	#3,d0
	sub.w	DestYSize(a6),d0
	move.w	d0,FillYQty(a6)
.DoneFill

; Work out SrcBytes - different depending on autoconvert
	move.w	SrcWidth(a6),d0	; get pixels
	tst.b	AutoConvert(a6)
	beq.s	.NoAutoConva
	addq.w	#1,d0
	lsr.w	#1,d0	; now converted to bytes
.NoAutoConva	move.w	d0,SrcBytes(a6)

; Generate the Y offset table
; This table is the amount to add to the Source pointer to move down a line
; in the destination.

; Now generate the Dest tables by calling correct routine.
; First we must find out the total width of the sprite
	lea	YAddSrc(a6),a4
	move.w	DestYSize(a6),d7
; Get SrcY/DestY
	moveq	#0,d4
	move.w	SrcYSize(a6),d4
	divu	d7,d4	; Src/Dest
	move.l	d4,d2
	clr.w	d2
	divu	d7,d2	; handle remainder
	swap	d4
	move.w	d2,d4
	moveq	#0,d2	; use to be $8000
	moveq	#0,d3
	move.w	SrcBytes(a6),d0	; width of source in bytes
; Check for Y reflection
	tst.b	YFlip(a6)
	beq.s	.NoYFlipa
	neg.w	d0
.NoYFlipa
	subq.w	#1,d7
.EachLine1	add.l	d4,d2
	move.l	d2,d1
	swap	d1
	muls	d0,d1	; get index into data
	sub.w	d3,d1
	move.w	d1,(a4)+
	add.w	d1,d3
.NextLine1	dbra	d7,.EachLine1
	move.w	DestXSize1(a6),d0
	move.w	DestXSize2(a6),d1
	cmp.w	d1,d0
	bgt.s	.GotLargest
	move.w	d1,d0
.GotLargest	move.w	d0,DestXSize\w


	pea	.MadeTabs(pc)
	move.w	OutputType(a6),d0
	beq	MakeDestTab_Char
	bra	MakeDestTab_Sprite
.MadeTabs
; Get src address
	move.w	SrcYPos(a6),d0
; Check for Y relection
	tst.b	YFlip(a6)
	beq.s	.NoYFlipb
	add.w	SrcYSize(a6),d0
	subq.w	#1,d0
.NoYFlipb
	mulu	SrcBytes(a6),d0
	add.w	SrcXPos(a6),d0
; Check for X reflection
	tst.b	XFlip(a6)
	beq.s	.NoXFlipa
	add.w	SrcXSize(a6),d0
	subq.w	#1,d0
.NoXFlipa
	move.w	d0,a0
	add.l	SrcDataPtr(a6),a0

; Now enter the main loops

; Work out error terms
	move.w	DestYSize(a6),d4

	move.w	DestXSize1(a6),d0
	add.w	DestXPos1(a6),d0	; RHS of top
	swap	d0
	clr.w	d0
	move.l	d0,TrapRPos(a6)
	swap	d0
	move.w	DestXSize2(a6),d1
	add.w	DestXPos2(a6),d1 ; RHS of bottom
	sub.w	d1,d0
	bmi.s	.IsNeg1
; Positive
	ext.l	d0
	divu	d4,d0
	move.l	d0,d5
	clr.w	d5
	divu	d4,d5
	swap	d0
	move.w	d5,d0
	neg.l	d0
	bra.s	.GotDDA1

.IsNeg1	neg.w	d0
	ext.l	d0
	divu	d4,d0
	move.l	d0,d5
	clr.w	d5
	divu	d4,d5
	swap	d0
	move.w	d5,d0

.GotDDA1
	move.l	d0,TrapRDelta(a6)

	move.w	DestXPos1(a6),d0
	swap	d0
	clr.w	d0
	move.l	d0,TrapLPos(a6)
	swap	d0
	sub.w	DestXPos2(a6),d0
	bmi.s	.IsNeg2
; Positive
	ext.l	d0
	divu	d4,d0
	move.l	d0,d5
	clr.w	d5
	divu	d4,d5
	swap	d0
	move.w	d5,d0
	neg.l	d0
	bra.s	.GotDDA2

.IsNeg2	neg.w	d0
	ext.l	d0
	divu	d4,d0
	move.l	d0,d5
	clr.w	d5
	divu	d4,d5
	swap	d0
	move.w	d5,d0

.GotDDA2
	move.l	d0,TrapLDelta(a6)

; Setup misc. constants
	pusho
	opt	w-
	moveq	#$F0,d4
	moveq	#$0F,d5
	popo

	lea	YAddDest(a6),a5
	move.w	DestYSize(a6),d7	; DestY-1 as outer count
	lea	YAddSrc(a6),a4
; Get dest address
	move.l	DestDataPtr(a6),a1
; Check if we are autosending
	tst.b	AutoSend(a6)
	beq.s	.NoAuto
; We are autosending so work out how many lines we can do
.DoLines	move.w	d7,d0
	cmp.w	#32,d7
	ble.s	.NotGT32
	moveq	#32,d7
.NotGT32	sub.w	d7,d0
	move.w	d7,LinesDone(a6)
	move.w	d0,LinesLeft(a6)
.NoAuto	subq.w	#1,d7
.EachY	swap	d7
	move.l	a0,TempSrcPtr(a6) ; save source pointer
	move.l	a1,TempDestPtr(a6) ; save dest pointer

; Check for auto-convert
	tst.b	AutoConvert(a6)
	beq.s	.NoAutoConvb
; We are auto-converting so unpack data
	lea	SrcBuffer(a6),a2
	lea	UnpackTab(pc),a3
	move.w	SrcBytes(a6),d7
	subq.w	#1,d7
.AutoLoop	moveq	#0,d0
	move.b	(a0)+,d0
	add.w	d0,d0
	move.w	0(a3,d0.w),(a2)+
	dbra	d7,.AutoLoop
	lea	SrcBuffer(a6),a0
.NoAutoConvb

; Get correct XTab (only needed for sprite output)
	subq.w	#1,XAddChange(a6)
	bpl.s	.Tab1
	lea	XAddDest2(a6),a3
	bra.s	.GotTab
.Tab1	lea	XAddDest(a6),a3
.GotTab

; Run the Position error term
	move.l	TrapLPos(a6),d6
	move.l	d6,d1
	add.l	TrapLDelta(a6),d6
	move.l	d6,TrapLPos(a6)
	swap	d1
; skip any pairs if required
	move.w	d1,d7
	lsr.w	#1,d7
	cmp.w	#2,FillAction(a6)
	bne.s	.NextPair1
	moveq	#0,d6	
	bra.s	.NextPair2
.EachPair1	add.w	(a3)+,a1
.NextPair1	dbra	d7,.EachPair1
	bra.s	.DonePairs
.EachPair2	move.b	d6,(a1)
	add.w	(a3)+,a1
.NextPair2	dbra	d7,.EachPair2
.DonePairs
	move.l	TrapRPos(a6),d6
	move.l	d6,d0
	add.l	TrapRDelta(a6),d6
	move.l	d6,TrapRPos(a6)
	swap	d0
	move.w	d0,a2	; save for later
	sub.w	d1,d0	; get width
	move.w	d0,d7

	moveq	#0,d6
	move.w	SrcXSize(a6),d6
	divu	d0,d6
	move.l	d6,d2
	clr.w	d2
	divu	d0,d2
	swap	d6
	move.w	d2,d6
	moveq	#0,d3	; use to be $8000
; Check for X reflection
	tst.b	XFlip(a6)
	beq.s	.NoXFlipb
	neg.l	d6
	moveq	#-1,d3
.NoXFlipb
	and.w	#1,d1
	add.w	d1,d7
	move.w	d7,d2
	lsr.w	#1,d7
	beq	.DoExtra

.MoreThan1	subq.w	#1,d7
	btst	#0,d1
	beq.s	.FirstPixel
	moveq	#0,d0
	bra.s	.SecondPixel

.FirstPixel
.EachX	move.b	(a0),d0	; Get 1st pixel
	swap	d3
	add.w	d3,a0	; advance x
	clr.w	d3
	swap	d3
	add.l	d6,d3	; add delta
	and.b	d4,d0	; loose bottom nibble

.SecondPixel	move.b	(a0),d1	; Get 2nd pixel
	swap	d3
	add.w	d3,a0	; advance x
	clr.w	d3
	swap	d3
	add.l	d6,d3	; add delta
	and.b	d5,d1	; loose top nibble

	or.b	d1,d0
	move.b	d0,(a1)
	add.w	(a3)+,a1	; move output ptr

	dbra	d7,.EachX

; Check for odd pixel (will always be in left of byte)
.DoExtra	btst	#0,d2
	beq.s	.NoExtra

.IsExtra	move.b	(a0),d0	; Get pixel
	and.b	d4,d0	; loose bottom nibble
	move.b	d0,(a1)	; store value
	add.w	(a3)+,a1	; move output ptr
.NoExtra
; Now fill to the end of the destination structure if FillAction=2
	cmp.w	#2,FillAction(a6)
	bne.s	.NextY
	move.w	DestWidth(a6),d0
	add.w	d0,d0
	add.w	d0,d0
	move.w	a2,d1	; TrapRPos saved earlier
	addq.w	#1,d1
	lsr.w	#1,d1	; RPos/2
	sub.w	d1,d0	; pairs to fill-1
	subq.w	#1,d0
	bmi.s	.NextY
	moveq	#0,d6
.EachPair3	move.b	d6,(a1)
	add.w	(a3)+,a1
	dbra	d0,.EachPair3

; end of x loop - loop to next line
.NextY	swap	d7	; get counter
	move.l	TempSrcPtr(a6),a0 ; start of source line
	add.w	(a4)+,a0	; step to next source line
	move.l	TempDestPtr(a6),a1 ; start of dest line
	add.w	(a5)+,a1	; step to next dest line
; Check to see if we should pause scaling
	subq.w	#1,LinesThisRun(a6)
	beq	.Pause
; This is a second entry point!
ReScale2	dbra	d7,.EachY
; See if we have finished or if it is time to AutoSend
	tst.b	AutoSend(a6)
	beq.s	.Finished
; See if we need to end fill first
	move.w	LinesLeft(a6),d7	; have we finished the sprite?
	bne.s	.MoreLines	; no
	move.w	FillYQty(a6),d7
	beq	.MoveIt
; we now need to check that we aren't going to fill too much!
.MoveMore	move.w	d7,d0
	moveq	#32,d1	; max lines per block
	sub.w	LinesDone(a6),d1	; -number we just did
	cmp.w	d1,d7
	ble.s	.CanDo
	move.w	d1,d7	; amount we can do
.CanDo	sub.w	d7,FillYQty(a6)
	clr.w	LinesDone(a6)
	bsr.s	EndFill

; move block to VRAM
.MoveIt	move.l	a1,d2	; current pos
	move.l	DestDataPtr(a6),a1	; start
	move.l	a1,d3
	sub.l	d3,d2	; diff. in bytes
	move.w	DMADest(a6),d0
	add.w	d2,DMADest(a6)
; Check which DMA routine to use
	move.l	DMARoutine(a6),a2
	jsr	(a2)
	move.w	FillYQty(a6),d7	; see if any more blocks
	bne.s	.MoveMore
	bra.s	.OK

.MoreLines
; move block to VRAM
	move.l	a1,d2	; current pos
	move.l	DestDataPtr(a6),a1	; start
	move.l	a1,d3
	sub.l	d3,d2	; diff. in bytes
	move.w	DMADest(a6),d0
	add.w	d2,DMADest(a6)
; Check which DMA routine to use
	move.l	DMARoutine(a6),a2
	jsr	(a2)
	bra	.DoLines
	
; Check for extra lines to blank (only for FillAction=2) when no AutoSend
.Finished	move.w	FillYQty(a6),d7
	beq.s	.Filledb
	bsr.s	EndFill
.Filledb
.OK	moveq	#0,d0
.Exit	rts

.Pause	movem.l	d0-d7/a0-a5,StopRegs(a6)
	lea	ReScale2(pc),a0
	move.l	a0,StopPC(a6)
	moveq	#1,d0
	bra.s	.Exit
	modend	; of ScaleTrapezium

EndFill	module
; work out which XAddDest to use
	tst.w	XAddChange(a6)
	bgt.s	.Tab1a
	lea	XAddDest2(a6),a3
	bra.s	.GotTaba
.Tab1a	lea	XAddDest(a6),a3
.GotTaba	sub.w	d7,XAddChange(a6)
	subq.w	#1,d7
	bmi.s	.Exit
.EachLine	move.w	6(a3),d1	; 8 pixel skip value
	addq.w	#3,d1	; adjust as we aren't doing the bytes
	move.l	a1,d6	; store line start
	move.w	DestWidth(a6),d5	; long word (8 pixel) count
	subq.w	#1,d5
	moveq	#0,d0	; fill value
.EachLong	move.l	d0,(a1)	; fill it
	add.w	d1,a1	; step to next long
	dbra	d5,.EachLong	; loop
	move.l	d6,a1	; get start of line again
	add.w	(a5)+,a1	; down to next line
	dbra	d7,.EachLine	; and loop
.Exit	rts
	modend

; ScaleDMA
;----------
;
; Scratch to VRAM DMA routine used by the sprite scaler
; Entry :
;   d0 - Address in VRAM
;   d2 - Size of DMA (even number of bytes)
;   d3 - Address in 68K memory
; Affects :
;   d0-d3/a2
ScaleDMA	module

	move.w	d0,d1
	add.w	d2,d1
	cmp.w	#SPRITEATTR,d1		; have to clip sprite
	bge.s	.allDone

	lea	SVDPControl,a2
; enable DMA
	move.w	DMAOn(a6),(a2)
; setup DMA length
	lsr.w	#1,d2
	move.w	#SVDP_DMALenLow,d1
	move.b	d2,d1
	move.w	d1,(a2)
	move.w	d2,-(sp)
	move.w	#SVDP_DMALenHigh,d1
	move.b	(sp)+,d1
	move.w	d1,(a2)
; setup DMA source address
	move.l	d3,d1
	lsr.l	#1,d1
	move.w	d1,d2
	and.w	#$FF,d2
	add.w	#SVDP_DMASrcLow,d2
	move.w	d2,(a2)
	lsr.l	#8,d1
	move.w	d1,d2
	and.w	#$FF,d2
	add.w	#SVDP_DMASrcMid,d2
	move.w	d2,(a2)
	lsr.l	#8,d1
	move.w	d1,d2
	and.w	#$7F,d2
	add.w	#SVDP_DMASrcHigh,d2
	move.w	d2,(a2)

; set destination address
; Copy bits 15 and 14 to bottom of d1
	move.w	d0,d1
	and.w	#$3FFF,d0
	and.w	#$C000,d1
	rol.w	#2,d1
; Set correct bits
	or.w	#$4000,d0
	or.w	#$0080,d1
	move.w	d0,(a2)
; Last word via RAM
	move.w	d1,DMAWord(a6)
	move.w	DMAWord(a6),(a2)
; it's off!
; turn off DMA
	move.w	DMAOff(a6),(a2)
.allDone:
	rts
	modend

; MakeDestTabChar
;-----------------
;
; This is the routine for making character column output.
; It is used for generating backgrounds where the VRAM has been arranged
; with vertical columns of contiguous characters.
MakeDestTab_Char module
	move.l	DestWidth(a6),d7
	cmp.l	OldDestWidth(a6),d7
	beq.s	.Exit
	move.l	d7,OldDestWidth(a6)
; First the YAddDest. This simply adds 4 each time.
	tst.b	Old4Tab(a6)
	bne.s	.Is4Tab
	lea	YAddDest(a6),a5
	moveq	#(200/2)-1,d7
	move.l	#$00040004,d5
.Each4Word	move.l	d5,(a5)+
	dbra	d7,.Each4Word
	st	Old4Tab(a6)
; Now XAddDest. This is 1,1,1,??? repeated lots of times
.Is4Tab	move.w	DestWidth(a6),d7
	subq.w	#1,d7
	lea	XAddDest(a6),a4
	move.l	#$00010001,d5
	move.l	d5,d6
; Work amount to add to get to top of next column
	move.w	DestHeight(a6),d6
	lsl.w	#5,d6
	subq.w	#3,d6
.EachLine2	movem.l	d5-d6,(a4)
	addq.w	#8,a4
	dbra	d7,.EachLine2
.Exit	move.w	#1000,XAddChange(a6) ; don't change
	rts
	modend

; MakeDestTab_Sprite
;--------------------
;
MakeDestTab_Sprite module
; First of all generate YAddDest.
; This will be mostly adds of 4 with values put in to skip rows of sprites.
; Work out how much is in a full row of sprites
	move.l	DestWidth(a6),d7
	cmp.l	OldDestWidth(a6),d7
	beq	.Exit
	move.l	d7,OldDestWidth(a6)

	move.w	DestWidth(a6),d2
	lsl.w	#2+5,d2	; *4 (cells high) *32 (bytes per cell)
	sub.w	#31*4,d2

	lea	YAddDest(a6),a5	; dest ptr
	moveq	#4,d3	; constant
	move.w	DestHeight(a6),d0
.EachRow
	move.w	d0,d1
	cmp.w	#4,d0
	ble.s	.NotGT4a
	moveq	#4,d1
.NotGT4a
; Do up to 4 cells
	move.w	d1,d7	; how many cells high block is
	lsl.w	#3,d7
	subq.w	#2,d7	; don't do last line
.EachLine	move.w	d3,(a5)+
	dbra	d7,.EachLine
; Value to skip to next row
	move.w	d2,(a5)+
; See if we have finished
	sub.w	d1,d0
	bne.s	.EachRow
; Now do the X
	lea	XAddDest(a6),a4
; Work out the Height of first row
	move.l	#$00010001,d0
	move.l	d0,d1
	move.w	DestHeight(a6),d1
	cmp.w	#4,d1
	ble.s	.NotGT4b
	move.w	#4,d1
.NotGT4b	lsl.w	#5,d1	; *32 bytes per cell
	move.w	DestWidth(a6),d7
	subq.w	#1,d7
	subq.w	#3,d1
.EachXa	movem.l	d0-d1,(a4)
	addq.w	#8,a4
	dbra	d7,.EachXa
; See if there needs to be a second table
	move.w	DestHeight(a6),d1
	move.w	d1,d2
	and.w	#3,d1
	bne.s	.SecondTab
; No second table
	move.w	#1000,OldXChange(a6)
	bra.s	.Exit
.SecondTab	and.w	#$FFFC,d2	; how many groups of 4 (*4)
	lsl.w	#3,d2	; *8 to get lines per 4 group
	move.w	d2,OldXChange(a6)
; now do the second table
	lea	XAddDest2(a6),a4
	lsl.w	#5,d1	; * 32 bytes per cell
	move.w	DestWidth(a6),d7
	subq.w	#1,d7
	subq.w	#3,d1
.EachXb	movem.l	d0-d1,(a4)
	addq.w	#8,a4
	dbra	d7,.EachXb

.Exit	move.w	OldXChange(a6),XAddChange(a6)
	rts
	modend

; Converts AB (nibble packed) to AABB
UnpackTab	module
.Count	=	0
	rept	256
	dc.b	(.Count&$F0)!((.Count&$F0)>>4)
	dc.b	(.Count&$0F)!((.Count&$0F)<<4)
.Count	=	.Count+1
	endr
	modend

; Table used to index sprite sizes to cell counts
SpriteSizeTab	module
.Count	=	0
	rept	16
	dc.w	(.Count&3+1)*(.Count>>2+1)
.Count	=	.Count+1
	endr

Author:
	dc.b	"Kenneth L. Hurley",0
	modend

ScaleEnd
	inform	0,'Scaler module is %d bytes',ScaleEnd-ScaleStart

SVDPData	equ	$C00000
SVDPControl	equ	$C00004
SVDPHVCount	equ	$C00008
SVDPReg	equ	$8000

SVDP_ModeSet1	equ	SVDPReg+256*0
SVDP_ModeSet2	equ	SVDPReg+256*1
SVDP_PatTabA	equ	SVDPReg+256*2
SVDP_PatTabWindow equ	SVDPReg+256*3
SVDP_PatTabB	equ	SVDPReg+256*4
SVDP_SprAtrTab	equ	SVDPReg+256*5	; write 0 to 6
SVDP_BackCol	equ	SVDPReg+256*7	; write 0 to 8 and 9
SVDP_HIntReg	equ	SVDPReg+256*10
SVDP_ModeSet3	equ	SVDPReg+256*11
SVDP_ModeSet4	equ	SVDPReg+256*12
SVDP_HScrollTab equ	SVDPReg+256*13	; write 0 to 14
SVDP_AutoIncData equ	SVDPReg+256*15
SVDP_ScrollSize equ	SVDPReg+256*16
SVDP_WindowHPos equ	SVDPReg+256*17
SVDP_WindowVPos equ	SVDPReg+256*18
SVDP_DMALenLow	equ	SVDPReg+256*19
SVDP_DMALenHigh equ	SVDPReg+256*20
SVDP_DMASrcLow	equ	SVDPReg+256*21
SVDP_DMASrcMid	equ	SVDPReg+256*22
SVDP_DmaSrcHigh equ	SVDPReg+256*23


		include	globals.i

		end
