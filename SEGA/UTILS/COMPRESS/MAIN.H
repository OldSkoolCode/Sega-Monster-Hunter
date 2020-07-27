#ifndef _MAIN_H
#define _MAIN_H

#ifdef _STDC_

void CompressFile ( FILE *input, BIT_FILE *output, int argc, char *argv[]);
void ExpandFile ( BIT_FILE *input, FILE *output, int argc, char *argv[]);

#else

void CompressFile ();
void ExpandFile ();

#endif

extern char *Usage;
extern char *CompressionName;

#endif
