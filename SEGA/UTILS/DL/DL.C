//----------------------------------------------------------------------//
//		DL.C																					//
//			Download program for Sega Genesis Ram Board							//
//																								//
//			Copyright (C) 1992 Futurescape Productions Inc.						//
//			Written by: Kenneth L. Hurley												//
//----------------------------------------------------------------------//



//----------------------------------------------------------------------//
// 		defines																			//
//----------------------------------------------------------------------//
#define	DOWNLOAD		0x80
#define	UPLOAD		0x81
#define	SET_REGS		0x82
#define	GET_REGS		0x83
#define	EXECUTE_PC	0x84
#define	PRINT_TEXT	0x85

//----------------------------------------------------------------------//
// 		Includes																			//
//----------------------------------------------------------------------//
#include	<stdio.h>
#include	<stdlib.h>
#include <dos.h>
#include <fcntl.h>
#include <io.h>
#include <alloc.h>
#include <time.h>

extern unsigned int far paraPort;
extern void interrupt (* far oldTimerInt)(void);
//----------------------------------------------------------------------//
//			Prototypes																		//
//----------------------------------------------------------------------//
extern void far interrupt TimerRoutine(void);
extern int far SendHeaderPacket(int command, long address, long dlength, 
									int xpos, int ypos);

extern int far InitParaPort(void);
extern int far SendBytes(char far *srcptr, long dlength);

//----------------------------------------------------------------------//
//		Global variables																	//
//----------------------------------------------------------------------//
char far *inpBuffer = NULL;

//----------------------------------------------------------------------//
//		usage();																				//
//			tell how to use the program												//
//----------------------------------------------------------------------//
void usage(void)
{

	printf("\nUsage:\n");
	printf("\tdl <name>\n");
	exit(10);

}

//----------------------------------------------------------------------//
//		Exit routine																		//
//----------------------------------------------------------------------//
void killTimer(void)
{
	setvect(8, oldTimerInt);

	if (inpBuffer != NULL)
		farfree(inpBuffer);

}

//----------------------------------------------------------------------//
//			Start of main program code													//
//----------------------------------------------------------------------//
void main(int argc, char **argv)
{


	unsigned int segment;
	unsigned int offset;
	unsigned long fileoff;
	int error;
	int fhand;
	int curSize;
	unsigned long fsize;
	clock_t first, second;

	oldTimerInt = getvect(8);

	setvect(8, TimerRoutine);

	atexit(killTimer);

	error = InitParaPort();
	if (error)
		{
		printf("\nError %d.\n", error);
		exit(error);
		}
	segment = FP_SEG(&paraPort);
	offset = FP_OFF(&paraPort);

	segment -= (_psp-0x10);

	fileoff = (long)segment * 0x10 + offset;


	if (argc < 2)
		usage();


	inpBuffer = (char far *)farmalloc(16384);
	if (inpBuffer == NULL)
		{
		printf("\nError allocating 16384 bytes of memory.\n");
		exit(4);
		}

	argv++;
	first = clock();
	fhand = open(*argv, O_RDONLY | O_BINARY);
	if (fhand == -1)
		{
		printf("\nError Opening->%s\n", *argv);
		exit(3);
		}

	lseek(fhand, 0L, SEEK_END);
	fsize = tell(fhand);
	lseek(fhand, 0L, SEEK_SET);
	error = SendHeaderPacket(DOWNLOAD, 0, fsize, 10, 10);
	if (error)
		{
		printf("\nError %d.\n", error);
		exit(error);
		}

	fsize = 0;
	do {
		curSize = read(fhand, inpBuffer, 16384);
		fsize += curSize;
		printf("\rDownloading bytes: %ld", fsize);
		error = SendBytes(inpBuffer, curSize);
		if (error)
			{
			printf("\nError %d.\n", error);
			exit(error);
			}
		}
	while (curSize == 16384);

	close(fhand);

	second = clock();
	printf("  in %f seconds.\n", (second-first) / CLK_TCK);

}
