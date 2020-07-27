//======================================================================//
//	Module:			dline.c																//
//	Description:	This is a program to make y offsets for scaled walls	//
// Author:			Kenneth L. Hurley													//
// Company:			Futurescape Productions Inc.									//
//======================================================================//

#define	MAXWIDTH			56
#define	MAXHEIGHT		200	// starting destination width & height

#define	WALLWIDTH		40		// source wall width and height
#define	WALLHEIGHT		72

#define	LOADCODE			1
#define	STORECODE		2
#define	NEXTSOURCECODE	3

#define	CLIPLEFT			32
#define	CLIPRIGHT		288
#define	CLIPTOP			16
#define	CLIPBOTTOM		176

#define	YNEXTLINE		4

#define	STARTX	0
#define	STARTY	200
#define	ENDX		112
#define	ENDY		115

#define	STARTTOPX		112
#define	STARTTOPY		0
#define	ENDTOPX			0
#define	ENDTOPY			81
#define	STARTBOTTOMX	112
#define	STARTBOTTOMY	200
#define	ENDBOTTOMX		0
#define	ENDBOTTOMY		115
#define	SRCWIDTH			200

#include	<stdio.h>
#include	<stdlib.h>
#include <string.h>
#include	<conio.h>
#include <fcntl.h>
#include <io.h>
#include	"sy.h"

char rtnstr[] = "SCALEY";
int	lastcode = 0;
int	nSrcMoves = 0;
int	nDestMoves = 0;
int	nAdds = 0;
int	nDestAdd = 0;
int	nCodes = 0;
int	column;
int	lastRunSize;
int	lastRunCount;
int	srcOffset;
int	destOffset;
int	destHeight;
int	destWidth;
int	yOffset;
int	uniqueChars;

trapForm	wallList[5] = {	{40, 157, 0, 200, 56}, {58, 139, 40, 157, 24},
									{69, 127, 58, 139, 16}, {75, 121, 69, 127, 8},
									{81, 115, 75, 121, 8} };

int saveOffs[500];

int	topX;
int	topY;
DDAVars topDDA;
int	bottomX;
int	bottomY;
DDAVars bottomDDA;
int	widthAdd;
DDAVars widthDDA;
int	curYOffset;

void writeCode(int incode);
void dumpWall(int destWidth, int height, int *saveOffs);

//----------------------------------------------------------------------//
// Function:		main();																//
// Description:	program entry point												//
// Parameters:		.																		//
// Returns:			.																		//
//----------------------------------------------------------------------//
void main()
{

	int i, j;
	int dstSize;
	char tbuff[120];
	int	startSource;
	int	curSource;
	int	offset;
	long	cntRtns;
	trapForm *wallListPtr;
	int	dummy;
	int	destX, destY;
	int	myAddValue, myCurValue;
	int	saveCnt;
	float	temp;
	long	srcCount;

	// set up top starting position
	// initialize bresenham algorithm for top

	topX = STARTTOPX;

	topY = STARTTOPY;
	InitDDA(STARTTOPX, STARTTOPY, ENDTOPX, ENDTOPY, &topDDA);
	// set up bottom starting position
	// initialize bresenham algorithm for bottom
	bottomX = STARTBOTTOMX;
	bottomY = STARTBOTTOMY;
	InitDDA(STARTBOTTOMX, STARTBOTTOMY, ENDBOTTOMX, ENDBOTTOMY, &bottomDDA);

	i = 0;
	srcCount = 0;
	temp = 0;
	cntRtns = 23592L*2;
	column = 76;
		
	while (topDDA.DDAmoves != 0)
		{
		srcOffset = -(WALLWIDTH/2);
		// calculate destination offset from top y offset
		destOffset = topY<<2;
		// now interpolate source height to destination height for each vertical
		// line
		dummy = bottomY-topY;
		temp = ((float)WALLHEIGHT/(float)dummy)*2.27;
		cntRtns = (long)(65536*temp);
		srcCount += cntRtns;
		// adjust destination coordinates for top
		NextDDA(&topX, &topY, &topDDA);
		// adjust destination coordinates for bottom
		NextDDA(&bottomX, &bottomY, &bottomDDA);
		// adjust destination coordinates for top
		NextDDA(&topX, &topY, &topDDA);
		// adjust destination coordinates for bottom
		NextDDA(&bottomX, &bottomY, &bottomDDA);

		for (j=0; j<(srcCount>>16)*2; j++)
			{
			saveOffs[i] = bottomY;
			myAddValue = (bottomY-ENDBOTTOMY);
			saveOffs[i+250] = (myAddValue*4)+(myAddValue/2)+0xc0;
			i++;
			}
		srcCount &= 0xffff;
		}

		column = 76;
		printf("adjustYfromX:\n");
		for (j=0; j<i; j++)
			{
			if (column >= 72)
				{
				printf("\n\t\tdc.w\t");
				column = 25;
				}
			else
				{
				printf(",");
				column += 1;
				}
			sprintf(tbuff, "$%x", saveOffs[j]);
			printf("%s", tbuff);
			column += strlen(tbuff);
			}

		printf("\n\n");
		column = 76;
		printf("adjustZfromX:\n");
		for (j=0; j<i; j++)
			{
			if (column >= 72)
				{
				printf("\n\t\tdc.w\t");
				column = 25;
				}
			else
				{
				printf(",");
				column += 1;
				}
			sprintf(tbuff, "$%x", saveOffs[j+250]);
			printf("%s", tbuff);
			column += strlen(tbuff);
			}



	printf("\n\n; ***** Number of points %d\n", i);
}

//----------------------------------------------------------------------//
// Function:		writeCode(int incode);											//
// Description:	get code and write offset for source or adjust			//
//						destination.														//
//	Parameters:		incode = LOAD or STORE code									//
// Returns:			.																		//
//----------------------------------------------------------------------//
void writeCode(int incode)
{

	switch (incode)
		{
		case LOADCODE:
			srcOffset += WALLWIDTH/2;
			break;

		case STORECODE:
			printf("\t\tmove.b\t%d(a0),%d(a1)\n", srcOffset, destOffset);
			destOffset += 4;
			break;
		}

}

