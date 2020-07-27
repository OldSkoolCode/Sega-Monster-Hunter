/*
	File:		LIB.H

	Contains:	This file defines several routines and macros that
		we find useful.

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

/****************************************************************/
/*		SEGA Genesis C support library			*/
/****************************************************************/

#ifndef __lib
#define __lib 1

#include "libpri.h"
#include "vdp.h"

/****************************************************************/
/* erasexRAM() puts 0 in ALL xRAM locations			*/
/****************************************************************/
extern eraseVRAM();
extern eraseVSRAM();
extern eraseCRAM();

/****************************************************************/
/* loadchars() puts howmany char pixel definitions from *data	*/
/*  into char #whichchartoload in VDP char definition RAM	*/
/*	data		pointer to your data			*/
/*	whichchartoload	the VDP char# to start loading at	*/
/*	howmany		how many chars to define		*/
/****************************************************************/
#define loadchars(data, whichchartoload, howmany) \
		SetVDPaddr(whichchartoload << 5); \
		__copy2VRAM(data, (howmany << 4))

/****************************************************************/
/* fillScrollx() puts data(word) in all locations of scroll x	*/
/****************************************************************/
#define fillScrollA(data) \
		SetVDPaddr(kMscrAbase); \
		__fillVRAMword(data, kMscrBwords)
#define fillScrollB(data) \
		SetVDPaddr(kMscrBbase); \
		__fillVRAMword(data, kMscrBwords)

/****************************************************************/
/* loadScrollx puts char map data from *data into scroll x	*/
/*  the data is organized as dataH lines of dataV chars,	*/
/*  where the scroll map is in scrollwidth wide mode		*/
/*	data		pointer to your data			*/
/*	dataH		the width of your data			*/
/*	dataV		the height of your data			*/
/*	scrollwidth	the width of the scroll in the current	*/
/*				mode				*/
/****************************************************************/
#define loadScrollA(data, dataH, dataV, scrollwidth) \
		__loadScroll(kMscrAbase, data, dataH, dataV, scrollwidth)
#define loadScrollB(data, dataH, dataV, scrollwidth) \
		__loadScroll(kMscrBbase, data, dataH, dataV, scrollwidth)

/****************************************************************/
/* loadPalette fills up a palette				*/
/****************************************************************/
extern loadPalette(/*char *data, long whichpal*/);

/****************************************************************/
/* readCtrlx reads controller x					*/
/*  1: up							*/
/*  2: down							*/
/*  4: left							*/
/*  8: right							*/
/*  16: B							*/
/*  32: C							*/
/*  64: A							*/
/*  128: start							*/
/****************************************************************/
#define ctrlUP 1
#define ctrlDOWN 2
#define ctrlLEFT 4
#define ctrlRIGHT 8
#define ctrlB 16
#define ctrlC 32
#define ctrlA 64
#define ctrlSTART 128

extern int readCtrlA();
extern int readCtrlB();

#endif __lib
