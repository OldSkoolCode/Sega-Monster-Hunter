/*
	File:		HARDWARE.H

	Contains:	This file contains C macros that aid in telling the
		hardware what to do.

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

#ifndef __hardware
#define __hardware 1

/* VDP equates					*/
#define		VDPcontrol	*(short *)0xc00004
#define		VDPaddr		*(long *)0xc00004
#define		VDPdata		*(short *)0xc00000
#define		VDPvcntr	*(char *)0xc00008
#define		VDPhcntr	*(char *)0xc00009

#define		wait4VBLon	while ((VDPcontrol & 0x0008) != 0) ;
#define		wait4VBLoff	while ((VDPcontrol & 0x0008) == 0) ;

/* I/O area					*/
#define		IOversion	*(char *)0xa10001
#define		IOP1data	*(char *)0xa10003
#define		IOP2data	*(char *)0xa10005
#define		IOP3data	*(char *)0xa10007
#define		IOP1ctrl	*(char *)0xa10009
#define		IOP2ctrl	*(char *)0xa1000b
#define		IOP3ctrl	*(char *)0xa1000d
#define		IOP1txdata	*(char *)0xa1000f
#define		IOP1rxdata	*(char *)0xa10011
#define		IOP1sermode	*(char *)0xa10013
#define		IOP2txdata	*(char *)0xa10015
#define		IOP2rxdata	*(char *)0xa10017
#define		IOP2sermode	*(char *)0xa10019
#define		IOP3txdata	*(char *)0xa1001b
#define		IOP3rxdata	*(char *)0xa1001d
#define		IOP3sermode	*(char *)0xa1001f
/* z80 equates					*/
#define		z80soundrambase	*(char *)0xa00000
#define		z80bankreg	*(char *)0xa06000
/* z80 macros					*/
#define 	z80BusReq	*(short *)0xa11100 = 0x0100
#define 	z80BusFree	*(short *)0xa11100 = 0x0000
#define 	z80Reset	*(short *)0xa11200 = 0x0000
#define 	z80ResetOff	*(short *)0xa11200 = 0x0100

/* sound chip equates				*/
#define		PSGcontrol	*(char *)0xc00011
#define		FMstatus	*(char *)0xa04000
#define		FMcontrol	*(short *)0xa04000
#define		FMcontrol13	*(short *)0xa04000
#define		FMcontrol46	*(short *)0xa04002

#endif __hardware
