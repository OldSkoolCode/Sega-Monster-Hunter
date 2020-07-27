/*
	File:		START.H

	Contains:	This file contains shellmain() and initVDP().
		shellmain() is called by [INT]SHELL.A, and then calls
		initVDP() and then your main().

	Written by:	Burt Sloane & Randel B. Reiss of Technopop

	Copyright:	c 1990 by Sega of America, Inc., all rights reserved.

	Change History:

	To Do:
*/

/* basic 40cell startup file */

/* Initialize the VDP to a standard state, based on memmapx.h		*/
initVDP()
{
  VDPcontrol = kRmode1;
  VDPcontrol = kRmode2 + 0x40;		/* display enable */
  VDPcontrol = kRscrAbase;
  VDPcontrol = kRwindowbase;
  VDPcontrol = kRscrBbase;
  VDPcontrol = kRspritebase;
  VDPcontrol = kRbgndcolor;
  VDPcontrol = kRintHrate;
  VDPcontrol = kRmode3;
  VDPcontrol = kRmode4 + 0x81;		/* 40 cell mode */
  VDPcontrol = kRhorizbase;
  VDPcontrol = kRautoinc + 2;		/* 2 bytes inc per write */
  VDPcontrol = kRscrollsize + 0x11;	/* 64x64 */
  VDPcontrol = kRwindowH;
  VDPcontrol = kRwindowV;
  VDPcontrol = kRdmalenlo + 2;
  VDPcontrol = kRdmalenhi;
  VDPcontrol = kRdmasrclo;
  VDPcontrol = kRdmasrcmid;
  VDPcontrol = kRdmasrchi;
}

/* Called by shell.a to initialize the machine, then calls your main()	*/
shellmain()
{
  initVDP();
  main();
}
