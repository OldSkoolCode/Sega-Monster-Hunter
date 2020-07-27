/* the opening comments for this file
*	are on page 51 of The Data Compression Book */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bitio.h"
#include "errhand.h"
#include "main.h"

#ifdef _STDC_

void usage_exit( char *prog_name);
void Print_ratio(char *input, char *output);
long file_size(char *name);


#else

void usage_exit();
void Print_ratio();
long file_size();

#endif

int main(argc, argv)
int argc;
char *argv[];
{
	BIT_FILE *input;
	FILE *output;

	setbuf(stdout, NULL);
	if (argc < 3)
		usage_exit(argv[0]);
	input = OpenInputBitFile(argv[1]);
	if (input == NULL)
		fatal_error("Error opening %s for input\n", argv[1]);
	output = fopen(argv[2], "wb");
	if (output== NULL)
		fatal_error("Error opening %s for output\n", argv[2]);
	printf("\nDecompressing %s to %s\n", argv[1], argv[2]);
	printf("\nUsing %s\n", CompressionName);
	argc -= 3;
	argv += 3;
	ExpandFile( input, output, argc, argv);
	CloseInputBitFile(input);
	fclose(output);
	return(0);
}



void usage_exit(prog_name)
char *prog_name;
{
	char *short_name;
	char *extension;

	short_name = strrchr(prog_name, '\\');
	if (short_name == NULL)
		short_name = strrchr(prog_name,'/');
	if (short_name == NULL)
		short_name = strrchr(prog_name,':');
	if (short_name != NULL)
		short_name++;
	else
		short_name = prog_name;
	extension = strrchr(short_name, '.');
	if (extension != NULL)
		*extension = '\0';
	printf("\nUsage: %s %s\n", short_name, Usage);
	exit(0);
}

