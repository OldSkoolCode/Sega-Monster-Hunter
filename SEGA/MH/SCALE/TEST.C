
//
//
//

#include <stdio.h>
#include	<alloc.h>
#include <float.h>
#include <math.h>
#include	<conio.h>
#include <ctype.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include	<mem.h>
#include	<fcntl.h>
#include	<sys\stat.h>
#include	<io.h>


//
//
//
#define	FALSE		0
#define	TRUE		!FALSE

//
//
//
double sinD(double angle)
{
	return (sin(angle * 0.017453292));
}

double cosD(double angle)
{
	return (cos(angle * 0.017453292));
}
//
//
//
int main(int argc, char **argv)
{

	char tbuff[20];

	double j;
	float k;
	unsigned int i;
	int temp;
	int	cntSrc;

	int	column;
	long	cntwords;
	
	cntwords = 0;
	for (j=0;j<728;j++)
		{
		printf("\nSinTable%d:",(int)j);
		column = 72;
  	  	for (i=0;i<128;i++)
  	 		{
  	 		sprintf(tbuff, "0%xh", (unsigned int) (i*(512*sinD(j/8))));
  	 		column += strlen(tbuff);
  	 		if (column >= 72)
  				{
  				printf("\n\t\tdw\t");
  				column = 24;
  				}
  			else
  				{
  				printf(",");
  				column += 1;
  				}
  			cntwords++;
  			printf("%s", tbuff);
  			}
		printf("\n\t\tdd\t0%lxh", (unsigned long) (128*(512*sinD(j/8))));
		cntwords++;
		cntwords++;
		}
	printf("\n; cntwords = %ld\n", cntwords*2);
	return(0);

}
