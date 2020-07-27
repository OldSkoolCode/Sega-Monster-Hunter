/*
	File:		SPRITE.H

	Contains:	This file defines several useful macros for controlling
		sprites.

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

#ifndef __sprite
#define __sprite 1
#include "hardware.h"

/* memmapX.h must be included before this file				*/

/* The following constants are added to the character number and	*/
/*  used in the pri_cp_vf_hf_char field of initsprite() to specify	*/
/*  these attributes:							*/
#define sVNormal	0x0000	/* sprite is NOT flipped vertically	*/
#define sVReverse	0x1000	/* sprite IS flipped vertically		*/
#define sHNormal	0x0000	/* sprite is NOT flipped horizontally	*/
#define sHReverse	0x0800	/* sprite IS flipped horizontally	*/
#define sPrioOn		0x8000	/* sprite has priority bit ON		*/
#define sPrioOff	0x0000	/* sprite has priority bit OFF		*/
#define sCPShift	13	/* palette # << this number		*/

/* The following constants are added to the sprite link number to be	*/
/*  used in the size_link field of initsprite() to specify the size	*/
/*  of the sprite:							*/
#define sVSize8		0x0000
#define sVSize16	0x0100
#define sVSize24	0x0200
#define sVSize32	0x0300
#define sHSize8		0x0000
#define sHSize16	0x0400
#define sHSize24	0x0800
#define sHSize32	0x0c00

/* Internal macro to generate the base address of the sprite table	*/
#define spriteVDPaddr 0x40000000 + ((kMspritebase & 0x3fff) << 16) + \
				   ((kMspritebase & 0xcc00) >> 14)

/* This is the most general version of this macro.  It fills all	*/
/*  the fields in the sprite record.					*/
#define initsprite(which, size_link, h, v, pri_cp_vf_hf_char) \
		VDPaddr = spriteVDPaddr + (which << 19); \
		VDPdata = v; \
		VDPdata = size_link; \
		VDPdata = pri_cp_vf_hf_char; \
		VDPdata = h

/* This macro sets the VDP address register to point at a sprite	*/
#define setupsprite(which) \
		VDPaddr = spriteVDPaddr + (which << 19)

/* Only use this macro for the NEXT sprite, right after the last one...	*/
#define initnextsprite(size_link, h, v, pri_cp_vf_hf_char) \
		VDPdata = v; \
		VDPdata = size_link; \
		VDPdata = pri_cp_vf_hf_char; \
		VDPdata = h

#endif __sprite
