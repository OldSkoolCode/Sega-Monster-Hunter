/***
 *	DPaint Animate to Futurescape Productions Sega Sprites (FPA) Converter
 *	Copyright 1993 Futurescape Productions
 *	All Rights Reserved
 *		History:
 *		09/06/92	KLM, Started coding.
 *		12/31/92	KLM, Added Kens DPaint Animate reading code to CVTSCE.
 ***/

#define	__EXEFILE__		"ANM2FPA"
#define	__USAGE__		"Convert DPaint Animate to Sega Sprites"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include	<ctype.h>
#include <errno.h>
#include "tools.h"

char	*arg_infile = NULL;
char	*arg_outfile = NULL;
int	arg_list = FALSE;
int	arg_oneoffset = FALSE;
LONG	arg_pal = -1l;
int	arg_scaled = FALSE;
int	arg_bitmap = FALSE;
int	arg_noinfo = FALSE;

/*	multiple input file variables	*/
char	inFile[30][30];						/*	30 input file names	*/

struct arg_ident {
	char	*cmd;
	void	*var;
	char	*usage;
} arg_array[] = {
	"l",&arg_list,"Input file is text list of multiple anims",
	"o",&arg_oneoffset,"Use anim position from first file only",
	"p#",&arg_pal,"Set palette to #",
	"s", &arg_scaled, "Set scaled Output file",
	"b", &arg_bitmap, "Set bitmap Output file",
	"x", &arg_noinfo, "Exclude flip/color information",
	"*",&arg_infile,"Input file",
	"*",&arg_outfile,"Output file",
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
						*(UBYTE *)ptr->var = TRUE;
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

/******************************************************
		Futurescape Productions Sega File Formats

	Background Maps:
		UWORD	Offset to Palette
		UWORD	Offset to Map
		UWORD	Offset to Character Definitions
		???
		Palette:
			WORD	Color Register index
			UWORD	Number of colors
				UWORD	RGB Value (Sega format)
				...
			...Repeat...
			-1		End of list
		Map:
			UWORD	Width of Map
			UWORD	Height of Map
			UWORD	Map[][]
		???	Insert new blocks here.
		Character Definitions:
			UBYTE	32 Bytes per character

	Animation Files:
		UWORD	Offset to Palette
		UWORD	Offset to Animation list
		UWORD	Offset to Animation to Frame catalog
		UWORD	Offset to Frame to Sprite catalog
		UWORD	Offset to Hotspot catalog
		UWORD	Offset to Character Definitions
		UWORD flags
				bit 0 = Scaleable sprite format
				bit 1 = bitmap sprite format
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

		Bitmap Frame to Sprite catalog:
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

void
fwrite_68k_word(UWORD wrd,FILE *file)
{
	fputc(wrd >> 8,file);
	fputc(wrd & 0xFF,file);
}

int		total_anims;
int		total_frames[30];
int		total_sprites[30];
int		total_chrs[30];
int		frame_size[30];
long		anim_pos;
long		frame_pos[30];
long		sprite_pos[30];
UWORD		sega_palette[256];

/**************************************************************************
 *		Code to read DPaint Animate files
 **************************************************************************/

#include <malloc.h>
#include "anmfile.h"					/* contains structures for large page files */

FILE				*anm_file;			/* DPaint Animate file */
lpfileheader	lpheader;			/* file header will be loaded into this structure */
lp_descriptor	LpArray[256];		/* arrays of large page structs used to find frames */
UBYTE				lppalette[769];	/* anim file palette is loaded here */
UWORD				curlpnum=0xFFFF;	/* initialize to an invalid Large page number */
lp_descriptor	curlp;				/* header of large page currently in memory */
UWORD				*thepage;			/* pointer to the buffer where current large page is loaded */
UBYTE huge		*outbuf;				/* pointer to the output buffer where data is rendered */
UBYTE				backcolor;			/* Background color */

/* given a frame number return the large page number it resides in */
UWORD
findpage(UWORD framenumber)
{
	UWORD i;

	for (i=0; i<lpheader.nLps; i++) {
		if (LpArray[i].baseRecord <= framenumber && LpArray[i].baseRecord + LpArray[i].nRecords > framenumber)
			return(i);
	}
	return (i-1);
}

/* seek out and load in the large page specified */
void
loadpage(UWORD pagenumber, UWORD *pagepointer)
{
	if(curlpnum!=pagenumber)
	{
		curlpnum=pagenumber;
		fseek(anm_file, 0x0B00l+(LONG)pagenumber * 0x10000l,SEEK_SET);
		fread(&curlp, sizeof(lp_descriptor), 1, anm_file);
		getw(anm_file);	/* skip empty word */
		fread(pagepointer, curlp.nBytes+(curlp.nRecords*2), 1, anm_file);
	}
}

/* This version of the decompressor is here for portability to non PC's */
void
CPlayRunSkipDump(UBYTE *srcP,UBYTE *dstP)
{
	BYTE		cnt;
	UWORD		wordCnt;
	UBYTE		pixel;
	int		i;

nextOp:
		cnt = (signed char) *srcP++;
		if (cnt > 0)
			goto dump;
		if (cnt == 0)
			goto run;
		cnt -= 0x80;
		if (cnt == 0)
			goto longOp;
/* shortSkip */
		dstP += cnt;			/* adding 7-bit count to 32-bit pointer */
		goto nextOp;
dump:
		i = (int)cnt;
		do
		{
			*dstP++ = *srcP++;
		} while (--i);
		goto nextOp;
run:
		wordCnt = (UBYTE)*srcP++;		/* 8-bit unsigned count */
		pixel = *srcP++;
		do
		{
			*dstP++ = pixel;
		} while (--wordCnt);

		dstP += wordCnt;
		goto nextOp;
longOp:
		wordCnt = *((UWORD far *)srcP)++;
		if ((WORD)wordCnt <= 0)
			goto notLongSkip;	/* Do SIGNED test. */

/* longSkip. */
		dstP += wordCnt;
		goto nextOp;

notLongSkip:
		if (wordCnt == 0)
			goto stop;
		wordCnt -= 0x8000;		/* Remove sign bit. */
		if (wordCnt >= 0x4000)
			goto longRun;

/* longDump. */
		do 
		{  
			*dstP++ = *srcP++;  
		} while (--wordCnt);

		dstP += wordCnt;
		srcP += wordCnt;
		goto nextOp;

longRun:
		wordCnt -= 0x4000;		/* Clear "longRun" bit. */
		pixel = *srcP++;
		do 
		{  
			*dstP++ = pixel; 
		} while (--wordCnt);

		dstP += wordCnt;
		goto nextOp;

stop:	/* all done */
	;
}

/* draw the frame sepcified from the large page in the buffer pointed to */
void
renderframe(UWORD framenumber, UWORD *pagepointer)
{
	UWORD offset=0;
	UWORD i;
	UWORD destframe;
	UBYTE *ppointer;
	UWORD lastsize;

	destframe = framenumber - curlp.baseRecord;
	for (i = 0; i <= destframe; i++) {
		offset += pagepointer[i];
		if (pagepointer[i])
			lastsize = pagepointer[i];
	}
	offset -= lastsize;
	ppointer = (UBYTE *)pagepointer;
	ppointer+=curlp.nRecords*2+offset;
	if (ppointer[1]) {
		ppointer += (4 + (((UWORD *)ppointer)[1] + (((UWORD *)ppointer)[1] & 1)));
	} else {
		ppointer+=4;
	}
	CPlayRunSkipDump((UBYTE *)ppointer, (UBYTE *)outbuf);
	if (framenumber == 0)
		backcolor = *outbuf;
	
}

/* finds the sallest rectangle that will enclose the frame of data */
void
FindEdges(int *LeftEdge, int *TopEdge, int *RightEdge, int *BottomEdge)
{
	UWORD x,y;
	UWORD	foundflag;

	foundflag = FALSE;
	for (x = 0; x < 320 && !foundflag; x++) {
		for (y = 0; y < 200; y++) {
			if (outbuf[(y * 320) + x] != backcolor) {
				foundflag = TRUE;
				break;
			}
		}
	}
	/* x will be incremented before foundflag check */
	*LeftEdge = x-1;
	foundflag = FALSE;
	/* for unsigned words wait till wraps above 319 hack hack hack */
	for (x = 319; x <= 319 && !foundflag; x--) {
		for (y = 0; y < 200; y++) {
			if (outbuf[(y * 320) + x] != backcolor) {
				foundflag = TRUE;
				break;
			}
		}
	}
	/* x will be incremented before foundflag check so 320-(x+1)*/
	*RightEdge = x+1;
	foundflag = FALSE;
	for (y = 0; y < 200 && !foundflag; y++) {
		for (x = 0; x < 320; x++) {
			if (outbuf[(y * 320) + x] != backcolor) {
				foundflag = TRUE;
				break;
			}
		}
	}
	*TopEdge = y-1;
	foundflag = FALSE;
	/* for unsigned words wait till wraps above 199 hack hack hack */
	for (y = 199; y <= 199 && !foundflag; y--) {
		for (x = 0; x < 320; x++) {
			if (outbuf[(y * 320) + x] != backcolor) {
				foundflag = TRUE;
				break;
			}
		}
	}
	*BottomEdge = y+1;
}

/***
 *			High level routines
 *			Only support for one ANM file at a time
 ***/

void
ANM_Open(char *fname)
{
	long			i;
	UBYTE			tpal;
	UBYTE huge	*buff;

	/* had to use "halloc" because I had to allocate a buffer exactly 64k long */
	if (!thepage)
		thepage = (UWORD *)halloc(0x10000l,1); /* allocate page buffer */
	if (!outbuf)
		outbuf = (UBYTE *)halloc(0x10000l,1);	/* allocate output buffer */
	if((anm_file = fopen(fname,"rb")) == NULL)
		Bomb("Unable to open %s!\n", fname);
	/* read the anim file header */
	if((fread(&lpheader,sizeof(lpfileheader),1,anm_file)) == 0)
		Bomb("Error reading file header!\n");
	if (strncmp(lpheader.contentType,"ANIM", 4)) {
		fclose(anm_file);
		Bomb("File Doesn't seem to be Deluxe Animate File!\n");
	}
	fseek(anm_file, 128L, SEEK_CUR);	/* skip color cycling structures */
	/* read in the color palette */
	for (i=0; i<768; i+=3) {
		tpal = (UBYTE)getc(anm_file);
		lppalette[i+2] = tpal >> 2;		/* read red */
		tpal = (UBYTE)getc(anm_file);
		lppalette[i+1] = tpal >> 2;		/* read green */
		tpal = (UBYTE)getc(anm_file);
		lppalette[i] = tpal >> 2;			/* read blue */
		tpal = (UBYTE)getc(anm_file);		/* skip over the extra pad byte */
	}
	/* read in large page descriptors */
	fread(LpArray,sizeof(lp_descriptor),256,anm_file);
	/* the file pointer now points to the first large page structure */
	/*
	Remember, the last frame in the file is a delta back to the first frame.
	You should only draw the first frame once and then use the last frame to 
	redraw the first frame.
	*/
	buff = outbuf;
	for(i = 0; i < 64000; i++)
		*(buff++) = 0;
}

void
ANM_Render(UWORD frame)
{
	loadpage(findpage(frame), thepage);
	renderframe(frame, thepage);
}

void
ANM_Close(void )
{
	/*
	hfree(thepage);
	hfree(outbuf);
	*/
	fclose(anm_file);
}

/**************************************************************************
 *		End DPaint Animate reader
 **************************************************************************/

/***
 *		Walk through the DPaint Animate file and get totals for everything
 ***/

void
Get_Sizes(void)
{
	int		anm_fcnt;			/* Frame counter of ANM file */
	int		ax1,ay1,ax2,ay2;	/* Returned coordinates from FindEdges */
	int		width;				/* Width of Frame in Characters */
	int		height;				/* Height of Frame in Characters */
	int		big_x,big_y;		/* Large sprite variables */
	int		rem_x,rem_y;		/* Remainder sprite variables */
	int		ssize;				/* Number of sprites in current frame */
	int		curInFile;			/*	current input file counter	*/

	/*	total_anims = 1;	*/		/*	now set in SetFileNames	*/
	for (curInFile = 0; curInFile < total_anims; curInFile++)
		{
		/*	open the current anim	*/
		total_chrs[curInFile] = 0;
		total_sprites[curInFile] = 0;
		frame_size[curInFile] = 0;

		ANM_Open(inFile[curInFile]);

		total_frames[curInFile] = lpheader.nFrames - 1;

		for (anm_fcnt=0; anm_fcnt<total_frames[curInFile]; anm_fcnt++)
			{
			frame_size[curInFile] += 4;		/* 2 Words for every Frame */
			ANM_Render(anm_fcnt);
			FindEdges(&ax1,&ay1,&ax2,&ay2);
			width = ((ax2-ax1+7)>>3);
			height = ((ay2-ay1+7)>>3);
			/* Generate optimal Genesis sprites */
			big_x = width >> 2;	/* How many 4xN sprites? */
			big_y = height >> 2;	/* How many Nx4 sprites? */
			rem_x = width & 3;	/* Remaining sprite size... */
			rem_y = height & 3;
			ssize = (big_x + (rem_x?1:0)) * (big_y + (rem_y?1:0));
			/* 4 Words for every sprite... */
			total_sprites[curInFile] += ssize;
			frame_size[curInFile] += ssize * 8;
			total_chrs[curInFile] += width * height;
			}
		/*	close the anim file	*/
		ANM_Close();
		}
}

/***
 *		Grab a Sega 8x8 character from the buffer in the proper palette
 ***/

UBYTE		Cur_Char[255];		/* Character generated or Y scan*/

void
Get_Char(int scrn_x, int scrn_y)
{
	int			x,y;
	UBYTE huge	*ptr;
	UBYTE			*bptr;

	/* Grab each pixel (currently a BYTE), munge it into a NYBBLE and store
		it in the Cur_Char buffer to be written out. */
	ptr = outbuf;
	ptr += ((long)scrn_y * 320) + (long)scrn_x;
	bptr = Cur_Char;
	for (y=0; y<8; y++) {
		for (x=0; x<4; x++) {
			*bptr = ((*ptr++ - backcolor) & 0x0F) << 4;
			*bptr |= (*ptr++ - backcolor) & 0x0F;
			bptr++;
		}
		ptr += 320 - 8;
	}
}

/*
***
*/
void
Get_BMYLine(int scrn_x, int scrn_y, int height)
{
	int			y;
	UBYTE huge	*ptr;
	UBYTE			*bptr;
	UBYTE tbyte1, tbyte2;

	/* Grab each pixel (currently a BYTE), munge it into a NYBBLE and store
		it in the Cur_Char buffer to be written out. */
	ptr = outbuf;
	ptr += ((long)scrn_y * 320) + (long)scrn_x;
	bptr = Cur_Char;
	for (y=0; y<height/2; y++, bptr++) {

		tbyte1 = *ptr;
		if (tbyte1 == backcolor)
			tbyte1 = 0;
		tbyte2 = *(ptr+320);
		if (tbyte2 == backcolor)
			tbyte2 = 0;
		*bptr = ((tbyte1 & 0x0F) << 4) | (tbyte2 & 0x0F);
		ptr += 640;
	}
}

/*
***
*/
void
Get_BMXLine(int scrn_x, int scrn_y, int width)
{
	int			x;
	UBYTE huge	*ptr;
	UBYTE			*bptr;
	UBYTE tbyte1, tbyte2;

	/* Grab each pixel (currently a BYTE), munge it into a NYBBLE and store
		it in the Cur_Char buffer to be written out. */
	ptr = outbuf;
	ptr += ((long)scrn_y * 320) + (long)scrn_x;
	bptr = Cur_Char;
	for (x=0; x<width/2; x++) {
			tbyte1 = *ptr++;
			tbyte2= *ptr++;
			if (tbyte1 == backcolor)
				tbyte1 = 0;
			if (tbyte2== backcolor)
				tbyte2= 0;
			*bptr++ = ((tbyte1 & 0x0F) << 4) | (tbyte2& 0x0F);
	}
}


/***
 *		Write out NxN Sega Characters from the buffer
 ***/

void
Write_Chars(FILE *file, int sx, int sy, int width, int height)
{
	int	x,y;

	/* Write characters out in Sega Sprite format, Y then X */
	for (x=0; x<width; x++)
		for (y=0; y<height; y++) {
			Get_Char(sx+(x*8),sy+(y*8));
			fwrite(Cur_Char,32,1,file);
		}
}


void
Write_Scaled(FILE *file, int sx, int sy, int width, int height)
{
	int	x;

	/* Write characters out in Sega Scalable format, Y then X */
	for (x=0; x<width; x++) {
		Get_BMYLine(sx+x,sy, height);
		fwrite(Cur_Char,height/2,1,file);
		}
}

void
Write_Bitmaps(FILE *file, int sx, int sy, int width, int height)
{
	int	y;

	/* Write characters out in Futurescape Scalable format, X then Y */
	for (y=0; y<height; y++) {
		Get_BMXLine(sx, sy+y, width);
		fwrite(Cur_Char,width/2,1,file);
		}
}

void	SetFileNames(void)
{
FILE	*listFile;

	if (arg_list)
		{
		/*	input file is a text file of anims	*/
		/*	open the file	*/
		if ((listFile = fopen(arg_infile,"r")) == NULL)
			Bomb("Can't open input file '%s'",arg_infile);

		/*	reset file name counter	*/
		total_anims = 0;
		/*	loop through the file until EOF	*/
		while (!feof(listFile))
			{
			/*	read a line of text	*/
			if (fgets(inFile[total_anims],30,listFile))
				{
				inFile[total_anims][strcspn(inFile[total_anims],"\n")] = 0;
				if (strlen(inFile[total_anims]))
					total_anims++;
				}
			}
		}
	else
		{
		/*	input file is only anim	*/
		total_anims = 1;
		strcpy(inFile[0],arg_infile);
		}
}

/***
 *		Main Routine
 ***/

main(int argc,char *argv[])
{
	FILE		*outfile;
	LONG		filelen;
	LONG		curpos;
	LONG		block_size;
	int		i,i2,j,k,l;
	int		x,y;
	int		anim_cnt,frm_cnt;
	UBYTE		*ptr;
	UBYTE		*end_ptr;
	UBYTE		found;
	UWORD		*wptr;
	UWORD		color;
	int		chr_cnt;
	int		scrn_x,scrn_y;
	UBYTE		*chr_ptr;
	UWORD		temp;

	int		ax1,ay1,ax2,ay2;
	int		anm_fcnt;			/* Frame counter of ANM file */

	thepage = 0l;
	outbuf = 0l;
	
	Parse_CmdLine(argc,argv);

	if (arg_infile == NULL)
		Print_Usage("Must use an input file");

	if (arg_outfile == NULL)
		Print_Usage("Must use an output file");

	printf("Calculating Final Sizes...\n");

	/*	set up for multiple file names	*/
	SetFileNames();

	/*	open the first anim file	*/
	ANM_Open(inFile[0]);

	/* Convert ANM palette into Sega colors, only first 64 */
	ptr = lppalette;
	for (i=0; i<64; i++) {
		color = (*ptr++ >> 2) & 0xE;
		color |= (*ptr++ << 2) & 0xE0;
		color |= (*ptr++ << 6) & 0xE00;
		sega_palette[i] = color;
		printf("Color %2d = $%04X\n",i,color);
	}

	/*	close the anim since Get_Sizes will reopen	*/
	ANM_Close();

	Get_Sizes();

	/*	open the first anim file	*/
	ANM_Open(inFile[0]);

	printf("backcolor = %d\n",backcolor);
	printf("total_anims = %d\n",total_anims);
	printf("total_frames = %d\n",total_frames[0]);
	printf("total_sprites = %d\n",total_sprites[0]);
	printf("total_chrs = %d\n",total_chrs[0]);
	/* Write out Futurescape Productions type file */
	if (arg_scaled)
		printf("Generating FPS file...\n");
	else if (arg_bitmap)
		printf("Generating FPB file...\n");
	else
		printf("Generating FPA file...\n");

	if ((outfile = fopen(arg_outfile,"wb")) == NULL)
		Bomb("Can't open output file '%s'",arg_outfile);
	printf("%d Total 8x8 Characters.\n",total_chrs[0]);
	if (total_anims == 1)
		printf("%d Animation, with %d frames.\n",total_anims,total_frames[0]);
	else
		printf("%d Animations, with %d frames.\n",total_anims,total_frames[0]);
	printf("%d Total Sega Sprites.\n",total_sprites[0]);
	fwrite_68k_word(14,outfile);	/* Offset to palette */
	fwrite_68k_word(14+38,outfile);	/* Offset to animation list */
	i = 14 + 38 + (total_anims * 4);
	fwrite_68k_word(i,outfile);	/* Offset to anim to frame catalog */
	i += (total_frames[0] * 2);
	fwrite_68k_word(i,outfile);	/* Offset to frame to sprite cat */
	fwrite_68k_word(0,outfile);	/* Offset to hotspots */
	i += frame_size[0];
	fwrite_68k_word(i,outfile);	/* Offset to characters */
	i = 0;
	if (arg_scaled)
		i |= 1;
	if (arg_bitmap)
		i |= 2;							/* flags = bitmap */
	if (arg_noinfo)
		i |= 4;

	fwrite_68k_word(i,outfile);	/* flags = not scaled */
		
	/* Write palette */
	if (arg_pal == -1)
		arg_pal = backcolor / 16;
	k = arg_pal*16;
	fwrite_68k_word(k,outfile);
	fwrite_68k_word(16,outfile);
	k = backcolor & 0xfff0;
	for (i=k; i<(k+16); i++)
		fwrite_68k_word(sega_palette[i],outfile);
	fwrite_68k_word(0xFFFF,outfile);

	/* Write blank animation list */
	anim_pos = ftell(outfile);
	block_size = 0l;
	for (i=0; i<total_anims; i++)
		fwrite(&block_size,4,1,outfile);

	for (i = 0; i < total_anims; i++)
		{
		/* Write blank frame list */
		frame_pos[i] = ftell(outfile);
		for (i2=0; i2<total_frames[i]; i2++)
			fwrite(&block_size,2,1,outfile);

		/* Write blank sprite sprite list */
		sprite_pos[i] = ftell(outfile);
		for (i2=0; i2<frame_size[i]; i2++)
			fwrite(&block_size,1,1,outfile);
		fwrite_68k_word(total_chrs[i],outfile);
		}

	/* Update all blank lists */
	anim_cnt = chr_cnt = 0;
	color = arg_pal << 13;		/* Use as a mask for setting Chars Palette # */
	ANM_Close();
	for (anim_cnt=0; anim_cnt<total_anims; anim_cnt++) {
		/*	open this animation	*/
		ANM_Open(inFile[anim_cnt]);

		k = total_frames[anim_cnt];		/* k = total frames for this anim */
		/* Update animation pointer */
		curpos = ftell(outfile);
		fseek(outfile,anim_pos,SEEK_SET);
		fwrite_68k_word(k,outfile);
		fwrite_68k_word(frame_pos[anim_cnt],outfile);
		anim_pos += 4;
		fseek(outfile,curpos,SEEK_SET);
		printf("Creating Animation #%d.\n",anim_cnt);
		Tick_Init();
		for (frm_cnt=0; frm_cnt<k; frm_cnt++) {
			int	big_x,big_y;		/* Large sprite variables */
			int	rem_x,rem_y;		/* Remainder sprite variables */
			int	x,y;
			int	xs,ys;				/* X,Y position of the current screen chr */
			int	ax1,ay1,ax2,ay2;	/* Box around current frame */
			int	width;				/* Width in characters of frame */
			int	height;				/* Height in characters of frame */
			int	num_sprs;			/* Number of sprites for this frame */

			ANM_Render(frm_cnt);
			FindEdges(&ax1,&ay1,&ax2,&ay2);

			width = ((ax2-ax1+7)>>3);
			height = ((ay2-ay1+7)>>3);
			/* Update frame offset */
			curpos = ftell(outfile);
			fseek(outfile,frame_pos[anim_cnt],SEEK_SET);	/* seek to anim to frame offsets */
			fwrite_68k_word(sprite_pos[anim_cnt],outfile);	/* write offset */
			frame_pos[anim_cnt] += 2;							/* update frame position */
			fseek(outfile,curpos,SEEK_SET);
			/* Write out Sprites */
			if (frm_cnt == 0) {
				if (((anim_cnt != 0) && (arg_oneoffset == FALSE)) ||
						(anim_cnt == 0))
					{
					/* Set origin (at middle bottom of first frame) */
					scrn_x = ax1 + (width * 4);
					scrn_y = ay1 + (height * 8);
					}
			}
			if (arg_scaled) {
				curpos = ftell(outfile);
				fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
				fwrite_68k_word(1,outfile); 		/* number of sprites in frame */
				fwrite_68k_word(0,outfile);		/* hotspot catalog offset */
				fwrite_68k_word(ay1 - scrn_y,outfile);		// write y Position
				width = ((ax2-ax1+1) & 0xfffe);		// align to byte
				height = ((ay2-ay1+1) & 0xfffe);
				temp = (((UWORD)(height) << 8) | (width & 0xff));
				fwrite_68k_word(temp,outfile);				// and h&v size
				fwrite_68k_word(chr_cnt | color,outfile);
				fwrite_68k_word(ax1 - scrn_x,outfile);
				sprite_pos[anim_cnt] += 12;
				fseek(outfile,curpos,SEEK_SET);
				Write_Scaled(outfile,ax1,ay1,width,height);
				big_x = (((ax2-ax1+7) & 0xfff8)>>3) * 
									(((ay2-ay1+7) & 0xfff8) >>3);
				chr_cnt += big_x;
				rem_x = (width>>1)*height;
				big_x = big_x<<5;
				if (rem_x < big_x)
					fwrite(Cur_Char,(big_x-rem_x),1,outfile);
			}
			else if (arg_bitmap) {
				curpos = ftell(outfile);
				fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
				fwrite_68k_word(1,outfile); 		/* number of sprites in frame */
				fwrite_68k_word(0,outfile);		/* hotspot catalog offset */
				fwrite_68k_word(ay1 - scrn_y,outfile);		// write y Position
				width = ((ax2-ax1+1) & 0xfffe);		// align to character
				height = ((ay2-ay1+1) & 0xfffe);
				temp = (((UWORD)(width) << 8) | (height & 0xff));
				fwrite_68k_word(temp,outfile);				// and h&v size
				fwrite_68k_word(chr_cnt | color,outfile);
				fwrite_68k_word(ax1 - scrn_x,outfile);
				sprite_pos[anim_cnt] += 12;
				fseek(outfile,curpos,SEEK_SET);
				Write_Bitmaps(outfile,ax1,ay1,width,height);
				big_x = (((ax2-ax1+7) & 0xfff8)>>3) * 
									(((ay2-ay1+7) & 0xfff8) >>3);
				chr_cnt += big_x;
				rem_x = (width>>1)*height;
				big_x = big_x<<5;
				if (rem_x < big_x)
					fwrite(Cur_Char,(big_x-rem_x),1,outfile);
			}
			else	{
				/* Generate optimal Genesis sprites */
				big_x = width >> 2;
				big_y = height >> 2;
				rem_x = width & 3;
				rem_y = height & 3;
				num_sprs = (big_x + (rem_x?1:0)) * (big_y + (rem_y?1:0));
				curpos = ftell(outfile);
				fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
				fwrite_68k_word(num_sprs,outfile); 	/* number of sprites in frame */
				fwrite_68k_word(0,outfile);			/* hotspot catalog offset */
				sprite_pos[anim_cnt] += 4;
				fseek(outfile,curpos,SEEK_SET);
				ys = 0;
				while (big_y) {
					xs = 0;
					while (big_x) {
						/* Generate 4x4 sprite */
						curpos = ftell(outfile);
						fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
						fwrite_68k_word(ay1 - scrn_y + ys,outfile);	// write y Position
						fwrite_68k_word(0x0F00,outfile);					// and h&v size
						fwrite_68k_word(chr_cnt | color,outfile);
						fwrite_68k_word(ax1 - scrn_x + xs,outfile);
						sprite_pos[anim_cnt] += 8;
						fseek(outfile,curpos,SEEK_SET);
						Write_Chars(outfile,ax1+xs,ay1+ys,4,4);
						big_x--;
						xs += 4*8;
						chr_cnt += 16;
					}
					if (rem_x) {
						/* Generate Nx4 sprite */
						curpos = ftell(outfile);
						fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
						fwrite_68k_word(ay1 - scrn_y + ys,outfile);
						fwrite_68k_word( (((rem_x-1) << 2) + 3) << 8 ,outfile);
						fwrite_68k_word(chr_cnt | color,outfile);
						fwrite_68k_word(ax1 - scrn_x + xs,outfile);
						sprite_pos[anim_cnt] += 8;
						fseek(outfile,curpos,SEEK_SET);
						Write_Chars(outfile,ax1+xs,ay1+ys,rem_x,4);
						chr_cnt += 4 * rem_x;
					}
					big_x = width >> 2;
					big_y--;
					ys += 4*8;
				}
				if (rem_y) {
					xs = 0;
					while (big_x) {
						/* Generate 4xN sprite */
						curpos = ftell(outfile);
						fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
						fwrite_68k_word(ay1 - scrn_y + ys,outfile);
						fwrite_68k_word(((rem_y-1) + 0xC) << 8,outfile);
						fwrite_68k_word(chr_cnt | color,outfile);
						fwrite_68k_word(ax1 - scrn_x + xs,outfile);
						sprite_pos[anim_cnt] += 8;
						fseek(outfile,curpos,SEEK_SET);
						Write_Chars(outfile,ax1+xs,ay1+ys,4,rem_y);
						chr_cnt += 4 * rem_y;
						big_x--;
						xs += 4*8;
					}
					if (rem_x) {
						/* Generate NxN sprite */
						curpos = ftell(outfile);
						fseek(outfile,sprite_pos[anim_cnt],SEEK_SET);
						fwrite_68k_word(ay1 - scrn_y + ys,outfile);
						fwrite_68k_word((((rem_x-1) << 2) | rem_y-1) << 8,outfile);
						fwrite_68k_word(chr_cnt | color,outfile);
						fwrite_68k_word(ax1 - scrn_x + xs,outfile);
						sprite_pos[anim_cnt] += 8;
						fseek(outfile,curpos,SEEK_SET);
						Write_Chars(outfile,ax1+xs,ay1+ys,rem_x,rem_y);
						chr_cnt += rem_x * rem_y;
					}
				}
			}
			Tick_User((long)frm_cnt,(long)k);
		}
		/*	close the current animation	*/
		ANM_Close();
		Tick_Exit();
	}
	fclose(outfile);
/*	ANM_Close();	*/
	hfree(thepage);
	hfree(outbuf);
	return 0;
}

