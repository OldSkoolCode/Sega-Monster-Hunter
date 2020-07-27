#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include "errhand.h"

#ifdef _STDC_
void fatal_error(char *fmt, ...)
#else
#ifdef _UNIX_
void fatal_error(fmt)
char *fmt;
va_dcl
#else
void fatal_error(char *fmt, ...)
#endif
#endif

{
	va_list argptr;

	va_start(argptr,fmt);
	printf("Fatal error:");
	vprintf(fmt, argptr);
	va_end(argptr);
	exit(-1);

}
