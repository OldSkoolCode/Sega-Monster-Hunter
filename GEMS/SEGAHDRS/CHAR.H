/*
	File:		CHAR.H

	Contains:	This file contains macros that set the VDP address
		register to point at a given character location(h, v) in
		one of the scrolls.  You can then write characters to the
		VDP data register and they will appear in the specified
		scroll at location(h, v).

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

#ifndef __char
#define __char 1

/* These macros simply set the VDP address register so that the next	*/
/*  write(s) go to the given h, v position in the correct scroll	*/
/*  scrollwidth is a shift parameter, i.e. 5=32, 6=64, 7=128		*/
#define SetACharPos(h, v, scrollwidth) \
		VDPaddr = addr2VDP(kMscrAbase) + \
				(v << (scrollwidth + 17)) + \
				(h << 17)
#define SetBCharPos(h, v, scrollwidth) \
		VDPaddr = addr2VDP(kMscrBbase) + \
				(v << (scrollwidth + 17)) + \
				(h << 17)

#endif __char
