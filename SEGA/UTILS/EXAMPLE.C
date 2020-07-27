struct {
	WORD	y;
	UWORD	link;
	UWORD	chr;
	WORD	x;
} RIGHT_SPRLIST[80],LEFT_SPRLIST[80],WORK_SPRLIST[80];

UWORD		SYS_SENDSPRS;

/****
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
			BYTE	32 Bytes per character
 ***/

UWORD		SYS_LASTCHR;

DispMap(UWORD *map_file)
{
	UWORD		*pal;
	UWORD		*map;
	UWORD		*chrs;
	UWORD		*wptr;
	int		i,x,y;
	int		w,h;
	int		numchrs;

	wptr = map_file;
	pal = (UWORD *)((BYTE *)map_file + *wptr++);
	map = (UWORD *)((BYTE *)map_file + *wptr++);
	chrs = (UWORD *)((BYTE *)map_file + *wptr);
	SYS_SetPalette(pal);
	/* Dump characters */
	SYS_SetVAddr(SYS_LASTCHR*32);
	numchrs = *chrs++;
	for (i=0; i<numchrs; i++)
		for (y=0; y<16; y++)
			VDATA = *chrs++;
	/* Dump map */
	SYS_SetVAddr(SYS_LASTCHR*32);
	w = *map++;
	h = *map++;
	i = 0;
	for (y=0; y<h; y++) {
		SYS_SetVAddr(0xC000+i);
		for (x=0; x<w; x++)
			VDATA = *map++ + SYS_LASTCHR;
		i += 128;
	}
	SYS_LASTCHR += numchrs;
}

/******************************************************
	Animation Files:
		UWORD	Offset to Palette
		UWORD	Offset to Animation list
		UWORD	Offset to Animation to Frame catalog
		UWORD	Offset to Frame to Sprite catalog
		UWORD	Offset to Hotspot catalog
		UWORD	Offset to Character Definitions
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
		???	Insert new blocks here.
		Character Definitions:
			BYTE	32 Bytes per character
 ******************************************************/

SendFrameChrs(UWORD *anim_file)
{
	UWORD		*wptr;
	int		i,x,y;

	wptr = anim_file;
	SYS_SetPalette((UWORD *)((BYTE *)anim_file + *wptr));
	wptr = (UWORD *)((BYTE *)anim_file + *(wptr + 5));
	/* Dump characters */
	SYS_SetVAddr(SYS_LASTCHR*32);
	x = *wptr++;
	for (i=0; i<x; i++)
		for (y=0; y<16; y++)
			VDATA = *wptr++;
	SYS_LASTCHR += x;
}

void
DispFrame(UWORD *anim_file, UWORD chr, WORD anim, WORD frame, WORD xp, WORD yp)
{
	UWORD		*anim_ptr;
	UWORD		*wptr;
	int		i,x,y,numsprs;

	wptr = anim_file;
	wptr++;
	anim_ptr = (UWORD *)((BYTE *)anim_file + *wptr);
	anim_ptr += anim * 2;
	if (frame < *anim_ptr++) {
		wptr = (UWORD *)((BYTE *)anim_file + *anim_ptr);
		wptr = (UWORD *)((BYTE *)anim_file + *(wptr + frame));
		numsprs = *wptr++;
		wptr++;
		for (i=0; i<numsprs; i++) {
			WORK_SPRLIST[SYS_LASTSPR].y = *wptr++ + yp + 0x80;
			WORK_SPRLIST[SYS_LASTSPR].link = *wptr++ + (SYS_LASTSPR+1);
			WORK_SPRLIST[SYS_LASTSPR].chr = *wptr++ + chr;
			WORK_SPRLIST[SYS_LASTSPR].x = *wptr++ + xp + 0x80;
			SYS_LASTSPR++;
		}
	}
}

void
SendSprList()
{
	int	i;
	UWORD	*ptr;

	WORK_SPRLIST[SYS_LASTSPR-1].link &= 0x0F00;
	SYS_SetVAddr(60*1024);
	ptr = (UWORD *)&WORK_SPRLIST[0];
	for (i=0; i<SYS_LASTSPR; i++) {
		VDATA = *ptr++;
		VDATA = *ptr++;
		VDATA = *ptr++;
		VDATA = *ptr++;
	}
	SYS_LASTSPR = 0;
}

