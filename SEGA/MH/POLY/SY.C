//======================================================================//
//	Module:			sy.c																	//
//	Description:	This is the main program to make a 68000 program		//
//						to make a scaled trapazoid from a rectangular object.	//
// Author:			Kenneth L. Hurley													//
// Modified by:	Matthew L. Hubbard												//
// Company:			Futurescape Productions Inc.									//
//======================================================================//

#define	MAXWIDTH			256	// pixels wide
#define	MAXHEIGHT		152	// starting destination width & height

#define	WALLWIDTH		40		// source wall width and height
#define	WALLHEIGHT		72

#define	LOADCODE			1
#define	STORECODE		2
#define	NEXTSOURCECODE	3

#define	CLIPLEFT			32
#define	CLIPRIGHT		288
#define	CLIPTOP			16
#define	CLIPBOTTOM		168

#define	YNEXTLINE		4

#define	STARTTOPX		112
#define	STARTTOPY		0
#define	ENDTOPX			0
#define	ENDTOPY			81
#define	STARTBOTTOMX	112
#define	STARTBOTTOMY	200
#define	ENDBOTTOMX		0
#define	ENDBOTTOMY		115
#define	SRCWIDTH			200
#define  PI					3.141592654
#define	PANELWIDTH		120

#include	<stdio.h>
#include	<stdlib.h>
#include <string.h>
#include	<conio.h>
#include <fcntl.h>
#include <io.h>
#include <math.h>
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

int saveOffs[MAXHEIGHT*(MAXWIDTH/2)];

char grafBuff[WALLWIDTH*WALLHEIGHT];

char palBuff[256*3];

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
	float	temp, temp2;
	long	srcCount;

	int gwidth1 = 320;
	int gmy = 232;
	int gDestWidth = 112;
	float cosYaw = cos(77);
	float sinYaw = sin(77);
	float tanYaw;
	float start_angle;
	float	start_x;
	float	start_y;
	float end_angle;
	float	end_x;
	float	end_y;
	float width_angle;
	float width_slice;
	float temp_angle;
	float	slope;
	float temp_x;
	float temp_y;
	float dist_width;
	float dist;
	int offsets[256];			// which source columns will be displayed


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

	// filling the offsets table

	start_x = (float)-gwidth1 * cosYaw * .5;
	start_y = (float)gmy - (gwidth1 * sinYaw* .5);
	start_angle = atan2 (start_y,start_x);
	if (start_angle < 0)
		start_angle += PI * 2;
	tanYaw = sinYaw/cosYaw;
	end_x = gwidth1 * cosYaw * .5;
	end_y = gmy + (gwidth1 * sinYaw * .5);
	end_angle = atan2 (end_y,end_x);
	width_angle = start_angle - end_angle;
	width_slice = width_angle/(float)(gDestWidth/2);
	dist_width = gwidth1;
		
	temp_angle = start_angle;

	printf("\n;\t\t");

	for (i = 0; i < gDestWidth/2; i++)
		{
		temp_angle -= width_slice;
		slope = tan(temp_angle);
		temp_x = (float)gmy / (slope - tanYaw);
		temp_y = slope * temp_x;
		dist = (start_x - temp_x) * (start_x - temp_x);
		dist += (start_y - temp_y) * (start_y - temp_y);
		dist = sqrt(dist);
		dist = dist/dist_width;
		offsets[i] = (int) (PANELWIDTH/2 * dist);
		printf("%d, ", offsets[i]);
		if ((i & 7) == 7)
			printf("\n;\t\t");
		}
		offsets[i] = PANELWIDTH/2;
		offsets[i+1] = PANELWIDTH/2;

	printf("YSCALERTNS:\n");
	for (i=0; i<((topDDA.DDAmoves+1)/2); i++)
		printf("\t\tdc.l\tYSCALE_%d\n",i+1);
	printf("\n");

	i = 1;
	srcCount = 0;
	temp = 0;
	temp2 = 0;
	cntRtns = 0;
	while (topDDA.DDAmoves != 0)
		{
		srcOffset = -(WALLWIDTH/2);
		// calculate destination offset from top y offset
		destOffset = topY<<2;
		// now interpolate source height to destination height for each vertical
		// line
		printf("YSCALE_%d:\n", i);
		dummy = bottomY-topY;
//		temp = ((float)WALLHEIGHT/(float)dummy)*2.31;
		temp = offsets[i] - offsets[i-1];
		cntRtns = (long)temp;

		printf("\t\tmove.l\t#%ld,d0\n", cntRtns);
		srcCount += cntRtns;
		interpolate(WALLHEIGHT, dummy);
		printf("\t\trts\n");
		// adjust destination coordinates for top
		NextDDA(&topX, &topY, &topDDA);
		// adjust destination coordinates for bottom
		NextDDA(&bottomX, &bottomY, &bottomDDA);
		// adjust destination coordinates for top
		NextDDA(&topX, &topY, &topDDA);
		// adjust destination coordinates for bottom
		NextDDA(&bottomX, &bottomY, &bottomDDA);
		i++;
		}

	printf("\n; source bytes counted %d\n", (int)(srcCount >> 16)*2);
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

//----------------------------------------------------------------------//
// Function:		dumpWall(int width, int height, int *saveOffs);			//
//	Description:	dump wall into 68000 assembler code							//
//						68000 code assumes:												//
//							d4 = next line offset for map								//
//							d5 = starting character for map							//
//							a0 = source pointer to 40x72 wall section				//
//							a1 = destination buffer pointer							//
//							a2 = pointer to character map								//
//												 												//
// Paramters:		width = width of wall											//
//						height = height of wall											//
//						saveOffs = pointer to list of offsets for wall			//
// Returns:			.																		//
//----------------------------------------------------------------------//
void dumpWall(int width, int height, int *saveOffs)
{

	
	int	i, j, k, l;
	int	runlength;
	int	lastcode;
	int	temp;
	int	charcount;
	int	curCharX;
	int	curCharY;

	lastcode = -2;
	runlength = 0;
	charcount = 0;
	curCharX = 0;
	curCharY = 0;

	for (i=0; i<(height/8); i++)
		{
		for (j=0; j<(width/8); j++)
			{
			for (k=0; k<8; k++)
				{
				for (l=0; l<8; l++)
					{
					if ((*saveOffs != lastcode) || ((k == 7) && (l == 7)))
						{
						if ((runlength > 1) && (runlength < 63))
							{
							if (lastcode == -1)		// clear code?
								{
								// number of long clears
								for (temp=0; (temp < (runlength/8)); temp++)
									printf("\t\tclr.l\t(a1)+\n");
								// number of word clears
								for (temp=0; (temp < ((runlength%8)/4)); temp++)
									printf("\t\tclr.w\t(a1)+\n");
								// number of byte clears
								for (temp=0; (temp < (runlength%4)/2); temp++)
									printf("\t\tclr.b\t(a1)+\n");
								runlength &= 1;
								}
							else if (runlength > 3)
								{
								printf("\t\tmove.b\t%d(a0),d0\n", lastcode);
								for (temp=0; temp<(runlength/2); temp++)
									printf("\t\tmove.b\td0,(a1)+\n");
								runlength &= 1;
								}
							else
								{
								printf("\t\tmove.b\t%d(a0),(a1)+\n", lastcode);
								runlength &= 1;
								}

							if (!runlength)
								lastcode = *saveOffs;

							}

						if ((lastcode == -1) && (*saveOffs != -1))
							{
							printf("\t\tmove.b\t%d(a0),d0\n", *saveOffs);
							printf("\t\tand.w\td3,d0\n");
							printf("\t\tmove.b\td0,(a1)+\n");
							runlength = 0;
							lastcode = -2;
							}
						else if (runlength == 1)
							{
							if (*saveOffs == -1)
								{
								printf("\t\tmove.b\t%d(a0),d0\n", lastcode);
								printf("\t\tand.w\td2,d0\n");
								printf("\t\tmove.b\td0,(a1)+\n");
								}
							else
								{
								printf("\t\tmove.b\t%d(a0),d0\n", lastcode);
								printf("\t\tand.w\td2,d0\n");
								printf("\t\tmove.b\t%d(a0),d1\n", *saveOffs);
								printf("\t\tand.w\td3,d1\n");
								printf("\t\tor.b\td1,d0\n");
								printf("\t\tmove.b\td0,(a1)+\n");
								}
							runlength = 0;
							lastcode = -2;
							}
						else if ((k != 7) || (l != 7))
							{
							runlength = 1;
							lastcode = *saveOffs;
							}
						else
							runlength++;
						}
					else
						runlength++;
					saveOffs++;					// Next x in character
					}
				saveOffs += width-8;			// Next y in character
				}

				if ((lastcode == -1) && (runlength == 64))	// zeroth character
					{
					runlength = 0;
					lastcode = -2;
//					if ((curCharX >= CLIPLEFT) && (curCharX < CLIPRIGHT) &&
//						(curCharY >= CLIPTOP) && (curCharY < CLIPBOTTOM))
						printf("\n\t\tclr.w\t(a2)+\n");
					}
				else
					{
					uniqueChars++;
//					if ((curCharX >= CLIPLEFT) && (curCharX < CLIPRIGHT) &&
//						(curCharY >= CLIPTOP) && (curCharY < CLIPBOTTOM))
//						{
						printf("\n\t\tmove.w\td5,(a2)+\n");
						printf("\t\taddq\t#1,d5\n");
//						}
					}

			saveOffs -= ((width<<3)-8);	// next x character
			curCharX++;
			}
		curCharX = 0;
		curCharY++;
		printf("\n\t\tsub.w\t#%d,a2\n",(width>>2));
		printf("\t\tadda.w\td4,a2\n");
		saveOffs += ((width<<3)-width);	// next x character
		}
	printf("\t\trts\n");
}

