/***
 *			PDQ Sprite Scaler for Nuclear Rush
 *				Copyright 1993, Futurescape Productions
 *				All Rights Reserved
 *				History:
 *					03/15/93:	Started, KLM.
 ***/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sega.h"

#define	XMAX	256

struct SPRLIST {
	WORD	y;
	UWORD	link;
	UWORD	chr;
	WORD	x;
};

extern BYTE		SEND_LEFT;
extern struct SPRLIST RIGHT_SPRLIST[80],LEFT_SPRLIST[80],WORK_SPRLIST[80];
extern WORD		SYS_LASTSPR;
extern UWORD	SYS_LASTCHR;
extern UWORD	SYS_BASECHR;
extern UWORD	WORK_CHRLIST[16528];	/*	Maximum number of characters at a time	*/

WORD	XOffsets[XMAX];		/* Destination sprite can be no more than XMAX */
UWORD	ScaleCode1[XMAX*4];	/* Code to generate a scanline of scaled image */
UWORD	ScaleCode2[XMAX*4];	/* Code to generate a scanline of scaled image */
WORD	DestOffs[XMAX];
UWORD	*PDQS_SourceAddr;
UWORD	*PDQS_DestAddr;
WORD	DBlockSize;				/* Destination sprite block size in bytes */
WORD	DExtra;					/* Extra bytes to skip in dest per scanline */
WORD	DEnd;						/* Left over scanline count */

/**********************************************************
 Scale enlarges or diminishes a source rectangle of
 a bitmap to a destination rectangle.

 Entry:
	swidth  - Width in pixels of the source bitmap
	sheight - Height in pixels of the source bitmap
	dwidth  - Width in pixels of the destination bitmap
	dheight - Height in pixels of the destination bitmap
**********************************************************/

/***
	This code generates assembly code to be called every scanline that is
	needed to be scaled.  This code moves pixels from the proper offsets
	into a data buffer with the proper offsets.

	Optimisations could be done when pixels need to be replicated (the
	sprite got larger than the source), but this code is a first pass.

	Code is also added to the end to clear the rest of the sprite buffer.
	This cleans up the extra pixels added to each scanline by characterizing
	the data.

		Pixel transfer functions:
		SOFFS = Source X data offset
		DOFFS = Destination X data offset

		SOFFS	=	$0AAA
		DOFFS	=	$0555
                
48E7 00C0       	MOVEM.L	A0-A1,-(SP)			; Save used registers

207C 1234 5678  	MOVEA.L	#$12345678,A0		; Load address into A0
227C 1234 5678  	MOVEA.L	#$12345678,A1		; Load address into A1

1028 0AAA       	MOVE.B	SOFFS(A0),D0		; Left pixel to Left pixel
0200 00F0       	ANDI.B	#$F0,D0
1340 0555       	MOVE.B	D0,DOFFS(A1)
                
1028 0AAA       	MOVE.B	SOFFS(A0),D0		; Right pixel to Left pixel
E908            	LSL.B		#4,D0
1340 0555       	MOVE.B	D0,DOFFS(A1)
                
1028 0AAA       	MOVE.B	SOFFS(A0),D0		; Left pixel to Right pixel
E808            	LSR.B		#4,D0
8129 0555       	OR.B		D0,DOFFS(A1)
                
1028 0AAA       	MOVE.B	SOFFS(A0),D0		; Right pixel to Right pixel
0200 000F       	ANDI.B	#$0F,D0
8129 0555       	OR.B		D0,DOFFS(A1)
                
* Byte scaling routine, for twice as fast but less accurate scaling:
                
1368 0AAA 0555  	MOVE.B	SOFFS(A0),DOFFS(A1)
                
* Pixel clearing code:

02A9 FFF0 0000  	ANDI.L	#$FFF00000,DOFFS(A1)
0555 
42A9 0555       	CLR.L		DOFFS(A1)
                
4CDF 0300       	MOVEM.L	(SP)+,A0-A1		; Restore used registers
4E75            	RTS

***/

static void
Scale(short swidth,short sheight,register short dwidth,register short dheight)
{
	register short		e;
	register short		d;
	register short		sd;
	register short		y;
	register UWORD		*code_ptr;
	register WORD		*offs_ptr;
	register BYTE		**SAddr;
	register BYTE		**DAddr;

	/* Build a rendering table for X offsets to source pixels */
	code_ptr = ScaleCode1;
	/* MOVEM.L	A0-A1,-(SP)			; Save used registers */
	*code_ptr++ = 0x48E7;
	*code_ptr++ = 0x00C0;
	/* MOVEA.L	#$12345678,A0		; Load address into A0 */
	*code_ptr++ = 0x207C;
	SAddr = (BYTE **)code_ptr;
	*SAddr = (BYTE *)PDQS_SourceAddr;
	code_ptr += 2;
	/* MOVEA.L	#$12345678,A1		; Load address into A1 */
	*code_ptr++ = 0x227C;
	DAddr = (BYTE **)code_ptr;
	*DAddr = (BYTE *)PDQS_DestAddr;
	code_ptr += 2;

	swidth <<= 1;
	y = 0;
	e = swidth-dwidth;
	offs_ptr = DestOffs;
	for (d=0; d < (dwidth >> 1); d++) {
		/* MOVE.B	SOFFS(A0),DOFFS(A1) */
		*code_ptr++ = 0x1368;
		*code_ptr++ = y;					/* Source offset */
		*code_ptr++ = *offs_ptr++;		/* Destination offset */
		while (e >= 0) {
			y++;
			e -= dwidth << 1;
		}
		e += swidth;
	}
	/* Clear remaining bytes of destination data */
	switch (DExtra) {
		case 1:
			/* CLR.B	DOFFS(A1) */
			*code_ptr++ = 0x4229;
			*code_ptr++ = *offs_ptr++;		/* Destination offset */
			break;
		case 2:
			/* CLR.W	DOFFS(A1) */
			*code_ptr++ = 0x4269;
			*code_ptr++ = *offs_ptr++;		/* Destination offset */
			break;
		case 3:
			/* CLR.B	DOFFS(A1) */
			*code_ptr++ = 0x4229;
			*code_ptr++ = *offs_ptr++;		/* Destination offset */
			/* CLR.W	DOFFS(A1) */
			*code_ptr++ = 0x4269;
			*code_ptr++ = *offs_ptr++;		/* Destination offset */
			break;
	}
	/* MOVEM.L	(SP)+,A0-A1		; Restore used registers */
	*code_ptr++ = 0x4CDF;
	*code_ptr++ = 0x0300;
	/* RTS */
	*code_ptr++ = 0x4E75;

	sheight <<= 1;
	swidth >>= 2;
	e = sheight-dheight;
	for (d=0; d < dheight; ) {
		/* JSR to code that reads selected pixels and writes them out */
		asm("\tjsr\t_ScaleCode1");
		while (e >= 0) {
			/* Bump source address to the next scanline */
			*SAddr += swidth;
			e -= dheight << 1;
		}
		/* Bump destination address to the next scanline */
		d++;
		if ((d & 31) == 0)
			*DAddr += DBlockSize;
		else
			*DAddr += 4;
		e += sheight;
	}
	/* Build a routine to clear the leftover destination data */
	SAddr = *DAddr;					/* Save the last scanline address */
	code_ptr = ScaleCode1;
	/* MOVE.L	A1,-(SP)				; Save used register */
	*code_ptr++ = 0x2F09;
	/* MOVEA.L	#$12345678,A1		; Load address into A1 */
	*code_ptr++ = 0x227C;
	DAddr = (BYTE **)code_ptr;
	*DAddr = SAddr;
	code_ptr += 2;
	offs_ptr = DestOffs;
	for (d=(dwidth >> 1) + DExtra; d > 0; d--) {
		/* CLR.B	DOFFS(A1) */
		*code_ptr++ = 0x4229;
		*code_ptr++ = *offs_ptr++;		/* Destination offset */
	}
	/* MOVE.L	(SP)+,A1			; Restore used register */
	*code_ptr++ = 0x225F;
	/* RTS */
	*code_ptr++ = 0x4E75;
	for (d=DEnd; d > 0; d--) {
		/* JSR to code that clears one scanline */
		asm("\tjsr\t_ScaleCode1");
		*DAddr += 4;
	}
}

/***
 *		PDQS_Scale:	PrettyDamnQuickScaler Scale function
 *
 *		Input:
 *			anm_file:	Pointer to animation data (FPA scale format)
 *			anm:			Animation number in file
 *			frm:			Frame number in the animation
 *			xp:			X screen position
 *			yp:			Y screen position
 *			sf:			Scale factor
 *								(256 is 1:1, 1 is the smallest 65535 is the largest)
 ***/

void
PDQS_Scale(UWORD *anm_file, WORD anm, WORD frm, WORD xp, WORD yp, UWORD sf)
{
	WORD	big_x,big_y;		/* Large sprite variables */
	WORD	rem_x,rem_y; 		/* Remainder sprite variables */
	WORD	xs,ys;				/* X,Y position of the current screen chr */
	WORD	width;				/* Width in characters of frame */
	WORD	height;				/* Height in characters of frame */
	WORD	i,j;
	WORD	*Offs_Ptr;			/* Pointer into the Destination Offset list */
	WORD	Offset;				/* Offset into source data counter */
	struct SPRLIST	*SListPtr;	/* Pointer to work sprite list */
	
	UWORD		*anim_ptr;		/* Pointer to animation */
	UWORD		*wptr;			/* Temporary pointer */ 
	UWORD		size,offset;
	UWORD		workIndex;
	UWORD		actualOffset,actualSize;
	WORD		FrameX,FrameY;
	WORD		FrameWidth,FrameHeight;
	WORD		DestWidth,DestHeight;
	UWORD		FrameColor;

	wptr = anm_file;							/*	Base of animation file	*/
	wptr++;										/*	Skip palette offset	*/
	/*	Add animation list offset	*/
	anim_ptr = (UWORD *)((BYTE *)anm_file + *wptr);
	/*	Point to requested animation	*/
	anim_ptr += anm * 2;
	/*	If valid frame number requested	*/
	if (frm >= *anim_ptr++)
		return;
	/*	Add animation frame pointer offset	*/
	wptr = (UWORD *)((BYTE *)anm_file + *anim_ptr);
	/*	Add animation frame data offset	*/
	wptr = (UWORD *)((BYTE *)anm_file + *(wptr + frm));
	wptr++;			/*	Skip number of sprites in frame	*/
	wptr++;			/*	Skip hotspot offset	*/
	/*	Add to list to DMA	*/
	SListPtr = &WORK_SPRLIST[SYS_LASTSPR];
	/*	Skip Sprite Y position	*/
	*wptr++;
	/*	Next sprite to link	*/
	FrameWidth = *(BYTE *)wptr;
	FrameHeight = *(((BYTE *)wptr)+1);
	wptr++;
	/*	Sprite's first catalog character : Add base character value	*/
	offset = *wptr++;
	/*	Only get the character data for left display	*/
	if (SEND_LEFT) {
		actualOffset = 16 * (offset & 0x07FF);	/*	Word offset to char	*/
		/*	Get address of Character definitions */
		PDQS_SourceAddr = anm_file;			/*	Base of animation file	*/
		PDQS_SourceAddr = (UWORD *) ((BYTE *)anm_file +
			*(PDQS_SourceAddr + 5));
		PDQS_SourceAddr++;						/*	Catalog count, don't need	*/
		PDQS_SourceAddr += actualOffset;		/*	Point to the first character	*/
		workIndex = 16 * (SYS_LASTCHR - SYS_BASECHR); /* Gives character number	*/
		PDQS_DestAddr = &WORK_CHRLIST[workIndex];
	}
	/*	Skip Sprite X position	*/
	*wptr++;
	/* Calculate the destinations width and height */
	DestWidth = (long)FrameWidth * sf >> 8;
	DestHeight = (long)FrameHeight * sf >> 8;
	/* Hotspot is at Lower Middle of sprite */
	FrameX = xp - DestWidth / 2 + 0x80;
	FrameY = yp - DestHeight + 0x80;

	if (!DestWidth || !DestHeight)
		/* Don't scale anything that is too tiny */
		return;
	/* Calculate width and height in characters */
	width = (DestWidth - 1 + 7) >> 3;
	height = (DestHeight - 1 + 7) >> 3;
	/* Calculate how many extra bytes are left per destination scanline */
	DExtra = (width << 2) - (DestWidth >> 1);
	Offs_Ptr = DestOffs;
	/* Generate optimal Genesis sprites for the scaler */
	big_x = width >> 2;
	big_y = height >> 2;
	rem_x = width & 3;
	rem_y = height & 3;
	if (big_y && rem_y) {
		big_y++;
		rem_y = 0;
	}
	/* Compute how many scanlines are left over after scaling */
	if (big_y)
		DEnd = (big_y << 5) - DestHeight;
	else
		DEnd = (rem_y << 3) - DestHeight;
	/* Compute offset for skipping to the next sprite block... */
	DBlockSize = ((((big_x << 2) + rem_x) - 1) << 7) + 4;
	ys = 0;
	Offset = 0;
	while (big_y) {
		xs = 0;
		while (big_x) {
			/* Generate 4x4 sprite */
			SListPtr->y = FrameY + ys;
			SListPtr->link = 0x0F00 + SYS_LASTSPR + 1;
			if (SEND_LEFT)
				SListPtr->chr = SYS_LASTCHR + (offset & 0xF800);
			else
				SListPtr->chr = LEFT_SPRLIST[SYS_LASTSPR].chr;
			SListPtr->x = FrameX + xs;
			SListPtr++;
			big_x--;
			xs += 4*8;
			if (SEND_LEFT)
				SYS_LASTCHR += 16;
			SYS_LASTSPR++;
			if (big_y==1)
				/* Generate 16 offsets for the DestOffs table */
				for (i=0; i<16; i++) {
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					Offset += 128-4;
				}
		}
		if (rem_x) {
			/* Generate Nx4 sprite */
			SListPtr->y = FrameY + ys;
			SListPtr->link = ((((rem_x-1) << 2) + 3) << 8) + SYS_LASTSPR + 1;
			if (SEND_LEFT)
				SListPtr->chr = SYS_LASTCHR + (offset & 0xF800);
			else
				SListPtr->chr = LEFT_SPRLIST[SYS_LASTSPR].chr;
			SListPtr->x = FrameX + xs;
			SListPtr++;
			if (SEND_LEFT)
				SYS_LASTCHR += rem_x * 4;
			SYS_LASTSPR++;
			if (big_y==1)
				/* Generate Nx4 offsets for the DestOffs table */
				for (i=0; i < (rem_x * 4); i++) {
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					*Offs_Ptr++ = Offset++;
					Offset += 128-4;
				}
		}
		big_x = width >> 2;
		big_y--;
		ys += 4*8;
	}
	/* Do sprites for objects less than Nx4 */
	if (rem_y) {
		xs = 0;
		while (big_x) {
			/* Generate 4xN sprite */
			SListPtr->y = FrameY + ys;
			SListPtr->link = (((rem_y-1) + 0xC) << 8) + SYS_LASTSPR + 1;
			if (SEND_LEFT)
				SListPtr->chr = SYS_LASTCHR + (offset & 0xF800);
			else
				SListPtr->chr = LEFT_SPRLIST[SYS_LASTSPR].chr;
			SListPtr->x = FrameX + xs;
			SListPtr++;
			if (SEND_LEFT)
				SYS_LASTCHR += 4 * rem_y;
			big_x--;
			xs += 4*8;
			SYS_LASTSPR++;
			/* Generate 16 offsets for the DestOffs table */
			for (i=0; i<16; i++) {
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				Offset += rem_y * 32 - 4;
			}
		}
		if (rem_x) {
			/* Generate NxN sprite */
			SListPtr->y = FrameY + ys;
			SListPtr->link = ((((rem_x-1) << 2) | rem_y-1) << 8) +
				SYS_LASTSPR + 1;
			if (SEND_LEFT)
				SListPtr->chr = SYS_LASTCHR + (offset & 0xF800);
			else
				SListPtr->chr = LEFT_SPRLIST[SYS_LASTSPR].chr;
			SListPtr->x = FrameX + xs;
			SListPtr++;
			if (SEND_LEFT)
				SYS_LASTCHR += rem_x * rem_y;
			SYS_LASTSPR++;
			/* Generate Nx4 offsets for the DestOffs table */
			for (i=0; i < (rem_x * 4); i++) {
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				*Offs_Ptr++ = Offset++;
				Offset += rem_y * 32 - 4;
			}
		}
	}
	/* Do scale, if left frame */
	if (SEND_LEFT)
		Scale(FrameWidth,FrameHeight,DestWidth,DestHeight);
}
