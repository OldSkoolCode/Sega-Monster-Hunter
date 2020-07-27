
//-------------------------------------------------------------------//
//	-----	Download or Upload .CPE files or .BIN files to SCSI target	//
//																							//
//																							//
//-------------------------------------------------------------------//


#include <stdio.h>
#include <fcntl.h>
#include <malloc.h>
#include <io.h>
#include <stdlib.h>
#include <ctype.h>

#define	BUFFSIZE 16*1024
#define	FALSE 	0
#define	TRUE		1

char far *selectSCSI(int device);
void far termSCSI(void);
char far *sendBlock(char huge *srcaddr, char huge *destaddr, long size);
char far *receiveBlock(char huge *destaddr, char huge *srcaddr, long size);
void	usage(void);


void main(int argc, char **argv)
{

	int	i;
	int	dl;
	char	huge *srcaddr;
	char	huge *destaddr;
	int	fh;
	long	fsize;
	char 	*fname;
	int	execute;
	char	far *errorStr;

	if (argc < 2)
		usage();

	dl = TRUE;
	execute = FALSE;

	argv++;
	argc--;

	i = (int)**argv;
	while ((i == '-') || (i == '/'))
		{
		i = toupper((int)*(*argv+1));
		switch (i)
			{
			case 'U':
				dl = FALSE;
				break;
			case 'D':
				dl = TRUE;
				break;
			case 'X':
				execute = TRUE;
				break;
			default:
				printf("Unknown switch %s.\n", **argv);
				usage();
			}
		argv++;
		argc--;
		i = (int)**argv;
		}

	srcaddr = farmalloc(BUFFSIZE);
	fname = *argv++;
	argc--;
	if (argc)
		destaddr = (char huge *)atol(*argv);
	else
		destaddr = 0;

	errorStr = selectSCSI(7);
	if (errorStr)
		{
		printf("SCSI Error: %s\n", errorStr);
		termSCSI();
		exit(1);
		}

	if (dl)
		{
		fh = open(fname, O_BINARY | O_RDWR);
		if (fh == -1)
			{
			farfree(srcaddr);
			printf("Unable to open file %s.\n", fname);
			termSCSI();
			exit(2);
			}

		do {
			fsize = read(fh, srcaddr, BUFFSIZE);
			if (fsize == -1)
				{
				farfree(srcaddr);
				printf("Unable to read from file %s.\n", fname);
				termSCSI();
				exit(3);
				}
			errorStr = sendBlock(srcaddr, destaddr, BUFFSIZE);
			if (errorStr)
				{
				printf("SCSI Error: %s\n", errorStr);
				termSCSI();
				exit(1);
				}

			}
		while (fsize == BUFFSIZE);

		close(fh);

		}

	farfree(srcaddr);
	termSCSI();
}

void	usage()
{

	printf("Usage: dl [-ud] [-x] filename.ext address [length]\n");
	printf(" -u = upload file\n");
	printf(" -d = download file\n");
	printf(" -x = execute at start address\n");
	exit(0);

}
