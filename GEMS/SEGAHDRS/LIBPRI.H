/*
	File:		LIBPRI.H

	Contains:	Private interfaces to assembly routines

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

extern	__fillVRAMword(/*data, numwords*/);
extern	__fillVRAMbyte(/*data, numbytes*/);
extern	__copy2VRAM(/*data, numwords*/);
extern	__loadScroll(/*vdpaddr, data, dataH, dataV, scrollwidth*/);
