/***
 *	IFF (Interchange File Format) File Dump Utility
 *	Copyright 1992 Futurescape Productions
 *	All Rights Reserved
 *		History:
 *		09/06/92	KLM, Started coding.
 ***/

#define	__EXEFILE__		"DUMPIFF"
#define	__USAGE__		"Display IFF blocks"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include	<ctype.h>
#include <errno.h>
#include "tools.h"

char	*arg_infile = NULL;

struct arg_ident {
	char	*cmd;
	void	*var;
	char	*usage;
} arg_array[] = {
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
				printf("] filename ");
			}
		else
			printf(" /%s ",ptr->cmd);
		ptr++;
	}
	printf("\nVersion %s %s.\n",__DATE__,__TIME__);
	printf("Copyright 1992 Futurescape Productions, All Rights Reserved.\n");
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

main(int argc,char *argv[])
{
	FILE		*infile;
	LONG		filelen;
	LONG		curpos;
	BYTE		buf[8];
	LONG		block_size;
	int		i;
	int		skipped;

	Parse_CmdLine(argc,argv);
	if (arg_infile == NULL)
		Print_Usage("Must use an input file");
	if ((infile = fopen(arg_infile,"rb")) == NULL)
		Bomb("Can't open input file '%s'",arg_infile);
	/* Get the length of the input file */
	fseek(infile,0l,SEEK_END);
	filelen = ftell(infile);
	/* Dump IFF */
	fseek(infile,0l,SEEK_SET);
	buf[4] = '\0';
	printf("IFF Dump of '%s' (len=%ld)\n",arg_infile,filelen);
	curpos = 0l;
	do {
		skipped = 0;
		i = 0;
		while (i<4 && !ferror(infile) && !feof(infile)) {
			buf[i] = fgetc(infile);
			if (isupper(buf[i]) || isdigit(buf[i]))
				i++;
			else {
				skipped++;
				i = 0;
			}
		}
		if (skipped)
			printf("Skipped %d bytes for a valid name.\n",skipped);
		block_size = fgetc(infile);
		block_size <<= 8;
		block_size |= fgetc(infile);
		block_size <<= 8;
		block_size |= fgetc(infile);
		block_size <<= 8;
		block_size |= fgetc(infile);
		printf("Block name '%s', size = %ld (pos=%ld)\n",buf,block_size,curpos);
		fseek(infile,block_size,SEEK_CUR);
		curpos += 8 + block_size + skipped;
	} while (curpos < filelen);
	fclose(infile);
	return 0;
}
