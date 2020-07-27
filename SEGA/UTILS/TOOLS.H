/***
 *	General Tool Header
 *	Copyright 1992 Futurescape Productions
 *	All Rights Reserved
 ***/

typedef unsigned char	UBYTE;
typedef char				BYTE;
typedef unsigned short	UWORD;
typedef short				WORD;
typedef unsigned long	ULONG;
typedef long				LONG;

#define	FALSE		0
#define	TRUE		!FALSE

LONG	Tick_Old;

void
Tick_Init(void)
{
	Tick_Old = 0l;
	fprintf(stderr,"Completed   0%");
}

void
Tick_User(LONG cnt,LONG total)
{
	LONG	new_tick;

	new_tick = cnt*100l/total;
	if (new_tick != Tick_Old) {
		fprintf(stderr,"\010\010\010\010%3d%%",(int)new_tick);
		Tick_Old = new_tick;
	}
}

void
Tick_Exit(void)
{
	Tick_User(100l,100l);
	fprintf(stderr,"\n");
}
