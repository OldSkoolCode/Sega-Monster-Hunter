/***
 *	FPA (Futurescape Productions Animation) File Dump Utility
 *	Copyright 1993 Futurescape Productions
 *	All Rights Reserved
 *		History:
 *		01/01/93	KLM, Started coding.
 ***/

#define	__EXEFILE__		"DUMPFPA"
#define	__USAGE__		"Display FPA blocks"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include	<ctype.h>
#include <errno.h>
#include <dos.h>
#include "tools.h"

char tempYBuff[255];

char	*arg_infile = NULL;
int arg_display;

struct arg_ident {
	char	*cmd;
	void	*var;
	char	*usage;
} arg_array[] = {
	"d", &arg_display, "Display file in mcga",
	"*",&arg_infile,"Input file",
	"",0,""
};

void
Parse_CmdLine(int cnt,char *cmdline[])
{
	int					i;
	struct arg_ident	*ptr;

	for (i=1; i<cnt; i++) {
		ptr = &arg_array[0];
		if (cmdline[i][0] == '/' || cmdline[i][0] == '-') {
			while (ptr->cmd[0] != '\0') {
				if (ptr->cmd[0] == cmdline[i][1] && ptr->cmd[0] != '*')
					if (ptr->cmd[1] == '#')
						sscanf(&cmdline[i][2],"%ld",(LONG *)ptr->var);
					else
						*(BYTE *)ptr->var = TRUE;
				ptr++;
			}
		} else {
			/* Must be a file name */
			while (ptr->cmd[0] != '\0') {
				if (ptr->cmd[0] == '*' && *(char **)ptr->var == NULL) {
					*(char **)ptr->var = cmdline[i];
					break;
				}
				ptr++;
			}
		}
	}
}

void
Print_Usage(char *errstr)
{
	struct arg_ident	*ptr;
	int					fcnt = 0;

	printf("Error: %s.\n%s [",errstr,__EXEFILE__);
	ptr = &arg_array[0];
	while (ptr->cmd[0] != '\0') {
		if (ptr->cmd[0] == '*')
			if (fcnt) {
				fcnt++;
				printf("filename ");
			} else {
				fcnt++;
				printf(" ] filename ");
			}
		else
			printf(" /%s",ptr->cmd);
		ptr++;
	}
	printf("\nVersion %s %s.\n",__DATE__,__TIME__);
	printf("Copyright 1993 Futurescape Productions, All Rights Reserved.\n");
	printf("  %s.\n",__USAGE__);
	ptr = &arg_array[0];
	while (ptr->cmd[0] != '\0') {
		if (ptr->cmd[0] == '*')
			printf("       %s.\n",ptr->usage);
		else
			printf("  /%-4s%s.\n",ptr->cmd,ptr->usage);
		ptr++;
	}
	exit(1);
}

void
Bomb(char *fmt, ...)
{
	va_list	args;

	va_start(args,fmt);
	fprintf(stderr,"%s: ",__EXEFILE__);
	vfprintf(stderr,fmt,args);
	fprintf(stderr,".\n");
	perror("Error");
	va_end(args);
	exit(1);
}

UWORD
fread_68k_word(FILE *file)
{
	UWORD		wrd;

	wrd = fgetc(file);
	wrd <<= 8;
	wrd |= fgetc(file);
	return (wrd);
}

/****************************************

	Animation Files:
		UWORD	Offset to Palette
		UWORD	Offset to Animation list
		UWORD	Offset to Animation to Frame catalog
		UWORD	Offset to Frame to Sprite catalog
		UWORD	Offset to Hotspot catalog
		UWORD	Offset to Character Definitions
		UWORD flags
				bit 0 = Scaleable sprite format
		???
		Palette:
			WORD	Color Register index
			UWORD	Number of colors
				UWORD	RGB Value (Sega format)
				...
			...Repeat...
			-1		End of list
		Animation list:
			UWORD	Number of frames
			UWORD	Offset to first Animation to Frame offset
			...
		Animation to Frame catalog:
			UWORD	Offset to first Frame to Sprite structure
			...
		Frame to Sprite catalog:
			UWORD	Number of sprites in frame
			UWORD	Hotspot catalog offset
				WORD	Y Position on screen (0..n)
				WORD	H size, V Size, Link
				UWORD	Priority, Palette, VFlip, HFlip, Char number
				WORD	X Position on screen (0..n)
			...
		Hotspot catalog:
			UWORD	Number of X,Y pairs
				WORD	X Position
				WORD	Y Position
				...
			...
		Scalable Frame to Sprite catalog:
			UWORD Number of sprites in frame
			UWORD hotspot catalog offset
				WORD Y Position on screen (0..n)
				WORD H size, V Size, Link
				UWORD Priority, Palette, VFlip, HFlip
				WORD x Position on screen

		???	Insert new blocks here.

		*****	Dependant on flags settings *****		
		Character Definitions:
			UBYTE	32 Bytes per character

		Scaleable sprite Definitions
			UBYTE (w * h)/2 Bytes per character
			 format is stored in Y then X sega format.
			
 ******************************************************/

main(int argc,char *argv[])
{
	FILE		*infile;
	LONG		filelen;
	LONG		curpos;
	BYTE		buf[8];
	LONG		block_size;
	int		i;
	int		skipped;
	int		oldmode;

	/* Offsets */
	UWORD		OPal;
	UWORD		OAnimL;
	UWORD		OAnim2F;
	UWORD		OFrame;
	UWORD		OHotspot;
	UWORD		OChar;
	UWORD		OFlags;
	UWORD		data;			/* Temporary data */
	int		anm2frm;		/* Anim to Frame counter */
	int		frm2spr;		/* Frame to Anim counter */
	int		spr;			/* Sprite counter */
	int		numanms;		/* Number of Animations in file */
	UWORD		numfrms;		/* Number of Frames in current Animation */
	UWORD		numsprs;		/* Number of Sprites in current Frame */
	long		oldpos1;		/* Old file position level 1 */
	long		oldpos2;		/* Old file position level 2 */
	int		width;		/* width of frame */
	int		height;		/* height of frame */
	int		offset;
	int		x,y;
	UBYTE		huge *scrPtr;
	long		temppos;		/* temporary position in file */
	UBYTE		*destPtr;

	Parse_CmdLine(argc,argv);
	if (arg_infile == NULL)
		Print_Usage("Must use an input file");
	if ((infile = fopen(arg_infile,"rb")) == NULL)
		Bomb("Can't open input file '%s'",arg_infile);
	/* Get the length of the input file */
 	fseek(infile,0l,SEEK_END);
	filelen = ftell(infile);
	fseek(infile,0l,SEEK_SET);

	if (arg_display)
		{
		/* get current video mode */
		_AH = 0x0f;
		geninterrupt( 0x10);

		oldmode = _AL;
	
		/* go into mode */
		_AX = 0x13;
		geninterrupt( 0x10);
		}
		
	OPal = fread_68k_word(infile);
	OAnimL = fread_68k_word(infile);
	OAnim2F = fread_68k_word(infile);
	OFrame = fread_68k_word(infile);
	OHotspot = fread_68k_word(infile);
	OChar = fread_68k_word(infile);
	OFlags = fread_68k_word(infile);


	printf("Palette = %d\n",OPal);
	printf("Animation list = %d\n",OAnimL);
	printf("Animation to Frame catalog = %d\n",OAnim2F);
	printf("Frame to Sprite catalog = %d\n",OFrame);
	printf("Hotspot catalog = %d\n",OHotspot);
	printf("Character Definitions = %d\n",OChar);
	printf("Flags = %d\n",OFlags);

	/* Print Palette */
	printf("Sega Palette:\n");
	fseek(infile,(long)OPal,SEEK_SET);
	data = fread_68k_word(infile);
	while ((data != 0xFFFF) && !feof(infile)) {
		printf("\tColor Register Index = $%04X\n",data);
		data = fread_68k_word(infile);
		printf("\tNumber of colors in this packet = $%04X\n",data);
		i = data;
		printf("\tColors:\n");
		while ((i > 0) && !feof(infile)) {
			data = fread_68k_word(infile);
			printf("\t\t$%04X\n",data);
			i--;
		}
		data = fread_68k_word(infile);
	}

	/* Print Animation list */
	printf("Animations:\n");
	fseek(infile,(long)OAnimL,SEEK_SET);
	/* Calc how many animations using the offsets (4 bytes per entry) */
	numanms = (OAnim2F - OAnimL) / 4;
	printf("Total number of Animations = %d.\n",numanms);
	for (anm2frm=0; anm2frm<numanms && !feof(infile); anm2frm++) {
		numfrms = fread_68k_word(infile);
		printf("\tAnimation #%d has %d frames.\n",anm2frm,numfrms);
		data = fread_68k_word(infile);
		printf("\t\tAnimation to Frame offset $%04X.\n",data);
		oldpos1 = ftell(infile);
		fseek(infile,(long)data,SEEK_SET);
		for (frm2spr=0; frm2spr<numfrms && !feof(infile); frm2spr++) {
			data = fread_68k_word(infile);
			printf("\t\t\tFrame to Sprite offset $%04X.\n",data);
			oldpos2 = ftell(infile);
			fseek(infile,(long)data,SEEK_SET);
			numsprs = fread_68k_word(infile);
			data = fread_68k_word(infile);
			printf("\t\t\t\tNumber of Sprites = $%04X.\n",numsprs);
			printf("\t\t\t\tHotspot Offset = $%04X.\n",data);
			for (spr=0; spr<numsprs && !feof(infile); spr++) {
				data = fread_68k_word(infile);
				printf("\t\t\t\t\tY Position on screen = %d.\n",(WORD)data);
				data = fread_68k_word(infile);
				if (OFlags & 1)
					{
					width = data >> 8;
					height = data & 0xff;
					}
				printf("\t\t\t\t\tH size, V Size, Link = $%04X.\n",data);
				data = fread_68k_word(infile);
				offset = data;
				printf("\t\t\t\t\tPriority-Pal-V/HFlip-Char# = $%04X.\n",data);
				data = fread_68k_word(infile);
				printf("\t\t\t\t\tX Position on screen = %d.\n\n",(WORD)data);
				if (arg_display)
					{
					temppos = ftell(infile);
					fseek(infile, ((long)(offset & 0x7ff)*32)+OChar+2, SEEK_SET);

					scrPtr = (void huge *) (0xa0000000 + (50*320)+50);
					for (x=0; x<width/2; x++)
						{
						fread(tempYBuff, height, 1, infile);
						destPtr = tempYBuff;
						for (y=0; y<height; y++)
							{
							*scrPtr++ = *destPtr >> 4;
							*scrPtr++ = *destPtr & 0xf;
							destPtr++;
							scrPtr += 320 -2;
							}
						scrPtr -= (320 * height) - 2;
						}
					getch();
					}
				fseek(infile, temppos, SEEK_SET);
			}		
			fseek(infile,oldpos2,SEEK_SET);
		}
		fseek(infile,oldpos1,SEEK_SET);
	}	
	printf("\t%d Total Sega Characters\n",(int)((filelen-OChar)/32));

	fclose(infile);
	if (arg_display)
		{
		_AX = oldmode;
		geninterrupt( 0x10);
		}

	return 0;
}
