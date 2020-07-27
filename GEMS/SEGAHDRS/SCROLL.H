/*
	File:		SCROLL.H

	Contains:	This file contains useful macros for controlling the
		scrolling backgrounds.
	
	NOTE:		These scroll routines assume you are in full scroll
		mode for both horizontal and vertical.

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

#ifndef __scroll
#define __scroll 1
#include "hardware.h"

/* This file supports only the full scroll mode in both directions	*/

/* memmapX.h must be included before this file				*/

/* This macro can be used as an lvalue for the H scroll value		*/
/*  For example, you can write:		oldColor = HscrollA;		*/
/*			    or:		HscrollA = oldColor;		*/
#define HscrollA \
	(VDPaddr = 0x40000000 + ((kMhorizbase & 0x3fff) << 16) + \
				((kMhorizbase & 0xc000) >> 14), \
	VDPdata)
#define HscrollB \
	(VDPaddr = 0x40020000 + ((kMhorizbase & 0x3fff) << 16) + \
				((kMhorizbase & 0xc000) >> 14), \
	VDPdata)

/* This macro can be used as an lvalue for the V scroll value		*/
#define VscrollA 	(VDPaddr = 0x40000010, VDPdata)
#define VscrollB	(VDPaddr = 0x40020010, VDPdata)

/* This macro scrolls H to scrollval					*/
#define SetHscrollA(scrollval) \
	(VDPaddr = 0x40000000 + ((kMhorizbase & 0x3fff) << 16) + \
				((kMhorizbase & 0xc000) >> 14), \
	VDPdata = scrollval)
#define SetHscrollB(scrollval) \
	(VDPaddr = 0x40020000 + ((kMhorizbase & 0x3fff) << 16) + \
				((kMhorizbase & 0xc000) >> 14), \
	VDPdata = scrollval)

/* This macro scrolls V to scrollval					*/
#define SetVscrollA(scrollval)	VDPaddr = 0x40000010; VDPdata = scrollval
#define SetVscrollB(scrollval)	VDPaddr = 0x40020010; VDPdata = scrollval

#endif __scroll
