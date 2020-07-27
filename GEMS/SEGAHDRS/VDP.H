/*
	File:		VDP.H

	Contains:	This file defines basic register values to be sent
		to the VDP, as well as a couple of useful macros.
		
	NOTE:		The values for the mode 1 and 2 registers already
		have the 0x04 bit added in.  This bit MUST be on for the
		Genesis to function.

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

#ifndef __vdp
#define __vdp 1
#include "hardware.h"

/* VDP register definitions			*/
#define		kRmode1		0x8004
#define		kRmode2		0x8104
/* registers 2-5 and 13 are in memmapx.h	*/
#define		kRbgndcolor	0x8700
#define		kRintHrate	0x8a00
#define		kRmode3		0x8b00
#define		kRmode4		0x8c00
#define		kRautoinc	0x8f00
#define		kRscrollsize	0x9000
#define		kRwindowH	0x9100
#define		kRwindowV	0x9200
#define		kRdmalenlo	0x9300
#define		kRdmalenhi	0x9400
#define		kRdmasrclo	0x9500
#define		kRdmasrcmid	0x9600
#define		kRdmasrchi	0x9700

/* addr2VDP converts a VDP address to a value to write to VDPaddr	*/
#define		addr2VDP(addr)		0x40000000 + \
					((addr & 0x3fff) << 16) + \
					((addr & 0xc000) >> 14)

/* SetVDPaddr converts the addr and writes it to VDPaddr		*/
#define		SetVDPaddr(addr)	VDPaddr = addr2VDP(addr)

#endif __vdp
