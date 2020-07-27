/***
 *	Sega Animation (from .RAW files) Generator
 *	Copyright 1992 Futurescape Productions
 *	All Rights Reserved
 *		History:
 *		09/25/92	KLM, Started coding.
 ***/

#define	__EXEFILE__		"MAKEANM"
#define	__USAGE__		"Convert .RAW files into a .ANM Sega Sprite file"

#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include	<ctype.h>
#include <errno.h>
#include "tools.h"

char	*arg_infile = NULL;
char	*arg_outfile = NULL;
LONG	arg_numfiles = 0l;

struct arg_ident {
	char	*cmd;
	void	*var;
	char	*usage;
} arg_array[] = {
	"n#",&arg_numfiles,"Set number of files to #",
	"*",&arg_infile,"Input file",
	"*",&arg_outfile,"Output file",
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

/******************************************************
		Futurescape Productions Sega File Formats

	Background Maps:
		UWORD	Offset to Palette
		UWORD	Offset to Map
		UWORD	Offset to Character Definitions
		???
		Palette:
			WORD	Color Register index
			UWORD	Number of colors
				UWORD	RGB Value (Sega format)
				...
			...Repeat...
			-1		End of list
		Map:
			UWORD	Width of Map
			UWORD	Height of Map
			UWORD	Map[][]
		???	Insert new blocks here.
		Character Definitions:
			BYTE	32 Bytes per character

	Animation Files:
		UWORD	Offset to Palette
		UWORD	Offset to Animation list
		UWORD	Offset to Animation to Frame catalog
		UWORD	Offset to Frame to Sprite catalog
		UWORD	Offset to Hotspot catalog
		UWORD	Offset to Character Definitions
		???
		Palette:
			WORD	Color Register index
			UWORD	Number of colors
				UWORD	RGB Value (Sega format)
				...
			...Repeat...
			-1		End of list
		Animation list:
			UWORD	Number of frames
			UWORD	Offset to first Animation to Frame offset
			...
		Animation to Frame catalog:
			UWORD	Offset to first Frame to Sprite structure
			...
		Frame to Sprite catalog:
			UWORD	Number of sprites in frame
			UWORD	Hotspot catalog offset
				WORD	Y Position on screen (0..n)
				WORD	H size, V Size, Link
				UWORD	Priority, Palette, VFlip, HFlip, Char number
				WORD	X Position on screen (0..n)
			...
		Hotspot catalog:
			UWORD	Number of X,Y pairs
				WORD	X Position
				WORD	Y Position
				...
			...
		???	Insert new blocks here.
		Character Definitions:
			BYTE	32 Bytes per character
			
 ******************************************************/

BYTE		*anm_buf;
int		total_anims;
int		total_frames;
int		total_chrs;
int		frame_size;
long		anim_pos;
long		frame_pos;
long		sprite_pos;
BYTE		palette[3][64];

main(int argc,char *argv[])
{
	FILE		*infile;
	FILE		*outfile;
	LONG		filelen;
	LONG		curpos;
	LONG		block_size;
	int		i,j,k,l;
	int		x,y;
	int		anim_cnt,frm_cnt;
	BYTE		*ptr;
	BYTE		*end_ptr;
	BYTE		found;
	UWORD		*wptr;
	UWORD		color;
	int		chr_cnt;
	int		scrn_x,scrn_y;
	BYTE		*chr_ptr;

	Parse_CmdLine(argc,argv);
	if (arg_infile == NULL)
		Print_Usage("Must use an input file");
	if (arg_outfile == NULL)
		Print_Usage("Must use an output file");
	if (arg_numfiles == 0)
		Print_Usage("Must have at least 1 file (see -n# option)");

	if ((outfile = fopen(arg_outfile,"wb")) == NULL)
		Bomb("Can't open output file '%s'",arg_outfile);

	/* Write out Futurescape Productions type file */
	total_anims = 1;
	total_frames = arg_numfiles;
	fwrite_68k_word(12,outfile);	/* Offset to palette */
	fwrite_68k_word(12+38,outfile);	/* Offset to animation list */
	i = 12 + 2 + (total_anims * 4);
	fwrite_68k_word(i,outfile);	/* Offset to anim to frame catalog */
	i += (total_frames * 2);
	fwrite_68k_word(i,outfile);	/* Offset to frame to sprite cat */
	fwrite_68k_word(0,outfile);	/* Offset to hotspots */
	fwrite_68k_word(0,outfile);	/* Offset to characters */
	/* Write palette */
	fwrite_68k_word(0xFFFF,outfile);
	/* Write blank animation list */
	anim_pos = ftell(outfile);
	block_size = 0l;
	fwrite(&block_size,4,1,outfile);
	/* Write blank frame list */
	frame_pos = ftell(outfile);
	for (i=0; i<total_frames; i++)
		fwrite(&block_size,2,1,outfile);
	/* Write blank sprite sprite list */
	sprite_pos = ftell(outfile);
	for (i=0; i<frame_size; i++)
		fwrite(&block_size,1,1,outfile);
	fwrite_68k_word(total_chrs,outfile);
	/* Update all blank lists */
	ptr = anm_buf;
	end_ptr = ptr + num_anims;
	anim_cnt = chr_cnt = 0;
	color = arg_pal << 13;
	while (ptr < end_ptr) {
		/* k = total frames for this anim */
		k = *ptr++;
		frm_ptr = ptr;
		if (anim_cnt < total_anims) {
			/* Update animation pointer */
			curpos = ftell(outfile);





	for (i=0; i<arg_numfiles; i++) {
		if ((infile = fopen(arg_infile,"rb")) == NULL)
			Bomb("Can't open input file '%s'",arg_infile);
		/* Get the length of the input file */
		fseek(infile,0l,SEEK_END);
		filelen = ftell(infile);
		fseek(infile,0l,SEEK_SET);
		chr_buf = NULL;

	/* Write out Futurescape Productions type file */
		total_anims = 1;
		total_frames = arg_numfiles;
		fwrite_68k_word(12,outfile);	/* Offset to palette */
		fwrite_68k_word(12+38,outfile);	/* Offset to animation list */
		i = 12 + 38 + (total_anims * 4);
		fwrite_68k_word(i,outfile);	/* Offset to anim to frame catalog */
		i += (total_frames * 2);
		fwrite_68k_word(i,outfile);	/* Offset to frame to sprite cat */
		fwrite_68k_word(0,outfile);	/* Offset to hotspots */
		i += frame_size;
		fwrite_68k_word(i,outfile);	/* Offset to characters */
		/* Write palette */
		fwrite_68k_word(arg_pal*16,outfile);
		fwrite_68k_word(16,outfile);
		ptr = palette;
		for (i=0; i<16; i++) {
			color = (*ptr++ >> 2) & 0xE;
			color |= (*ptr++ << 2) & 0xE0;
			color |= (*ptr++ << 6) & 0xE00;
			fwrite_68k_word(color,outfile);
		}
		fwrite_68k_word(0xFFFF,outfile);
		/* Write blank animation list */
		anim_pos = ftell(outfile);
		block_size = 0l;
		for (i=0; i<total_anims; i++)
			fwrite(&block_size,4,1,outfile);
		/* Write blank frame list */
		frame_pos = ftell(outfile);
		for (i=0; i<total_frames; i++)
			fwrite(&block_size,2,1,outfile);
		/* Write blank sprite sprite list */
		sprite_pos = ftell(outfile);
		for (i=0; i<frame_size; i++)
			fwrite(&block_size,1,1,outfile);
		fwrite_68k_word(total_chrs,outfile);
		/* Update all blank lists */
		ptr = anm_buf;
		end_ptr = ptr + num_anims;
		anim_cnt = chr_cnt = 0;
		color = arg_pal << 13;
		while (ptr < end_ptr) {
			/* k = total frames for this anim */
			k = *ptr++;
			frm_ptr = ptr;
			if (anim_cnt < total_anims) {
				/* Update animation pointer */
				curpos = ftell(outfile);
				fseek(outfile,anim_pos,SEEK_SET);
				fwrite_68k_word(k,outfile);
				fwrite_68k_word(frame_pos,outfile);
				anim_pos += 4;
				fseek(outfile,curpos,SEEK_SET);
			}
			for (frm_cnt=0; frm_cnt<k; frm_cnt++) {
				/* Update frame offset */
				curpos = ftell(outfile);
				fseek(outfile,frame_pos,SEEK_SET);
				fwrite_68k_word(sprite_pos,outfile);
				frame_pos += 2;
				fseek(outfile,curpos,SEEK_SET);
				/* Find associated "sprite" */
				spr_ptr = spr_buf;
				found = FALSE;
				for (i=0; i<num_sprites; i++) {
					if (frm_ptr->x_loc == spr_ptr->x &&
						frm_ptr->y_loc == spr_ptr->y) {
						found = TRUE;
						break;
					}
					spr_ptr++;
				}
				if (found) {
					int	big_x,big_y;
					int	rem_x,rem_y;
					int	x,y;
					int	xs,ys;
					int	xp,yp;
					int	num_sprs;

					if (frm_cnt == 0) {
						/* Set origin (at middle bottom of first frame) */
						scrn_x = frm_ptr->x + (spr_ptr->width * 4);
						scrn_y = frm_ptr->y + (spr_ptr->height * 8);
					}
					/* Generate optimal Genesis sprites */
					big_x = spr_ptr->width >> 2;
					big_y = spr_ptr->height >> 2;
					rem_x = spr_ptr->width & 3;
					rem_y = spr_ptr->height & 3;
					num_sprs = (big_x + (rem_x?1:0)) * (big_y + (rem_y?1:0));
					curpos = ftell(outfile);
					fseek(outfile,sprite_pos,SEEK_SET);
					fwrite_68k_word(num_sprs,outfile);
					fwrite_68k_word(0,outfile);
					sprite_pos += 4;
					fseek(outfile,curpos,SEEK_SET);
					x = big_x;
					yp = spr_ptr->y;
					ys = 0;
					while (big_y) {
						xp = spr_ptr->x;
						xs = 0;
						while (big_x) {
							/* Generate 4x4 sprite */
							curpos = ftell(outfile);
							fseek(outfile,sprite_pos,SEEK_SET);
							fwrite_68k_word(frm_ptr->y - scrn_y + ys,outfile);
							fwrite_68k_word(0x0F00,outfile);
							fwrite_68k_word(chr_cnt | color,outfile);
							fwrite_68k_word(frm_ptr->x - scrn_x + xs,outfile);
							sprite_pos += 8;
							fseek(outfile,curpos,SEEK_SET);
							for (x=0; x<4; x++) {
								wptr = map_buf;
								wptr += (yp * map_width) + (xp+x);
								for (y=0; y<4; y++) {
									chr_ptr = chr_buf + (*wptr * 32 );
									fwrite(chr_ptr,32,1,outfile);
									wptr += map_width;
								}
							}
							big_x--;
							xp += 4;
							xs += 4*8;
							chr_cnt += 16;
						}
						if (rem_x) {
							/* Generate Nx4 sprite */
							curpos = ftell(outfile);
							fseek(outfile,sprite_pos,SEEK_SET);
							fwrite_68k_word(frm_ptr->y - scrn_y + ys,outfile);
							fwrite_68k_word( (((rem_x-1) << 2) + 3) << 8 ,outfile);
							fwrite_68k_word(chr_cnt | color,outfile);
							fwrite_68k_word(frm_ptr->x - scrn_x + xs,outfile);
							sprite_pos += 8;
							fseek(outfile,curpos,SEEK_SET);
							for (x=0; x<rem_x; x++) {
								wptr = map_buf;
								wptr += (yp * map_width) + (xp+x);
								for (y=0; y<4; y++) {
									chr_ptr = chr_buf + (*wptr * 32 );
									fwrite(chr_ptr,32,1,outfile);
									wptr += map_width;
								}
							}
							chr_cnt += 4 * rem_x;
						}
						big_x = spr_ptr->width >> 2;
						big_y--;
						yp += 4;
						ys += 4*8;
					}
					if (rem_y) {
						xp = spr_ptr->x;
						xs = 0;
						while (big_x) {
							/* Generate 4xN sprite */
							curpos = ftell(outfile);
							fseek(outfile,sprite_pos,SEEK_SET);
							fwrite_68k_word(frm_ptr->y - scrn_y + ys,outfile);
							fwrite_68k_word(((rem_y-1) + 0xC) << 8,outfile);
							fwrite_68k_word(chr_cnt | color,outfile);
							fwrite_68k_word(frm_ptr->x - scrn_x + xs,outfile);
							sprite_pos += 8;
							fseek(outfile,curpos,SEEK_SET);
							for (x=0; x<4; x++) {
								wptr = map_buf;
								wptr += (yp * map_width) + (xp+x);
								for (y=0; y<rem_y; y++) {
									chr_ptr = chr_buf + (*wptr * 32 );
									fwrite(chr_ptr,32,1,outfile);
									wptr += map_width;
								}
							}
							chr_cnt += 4 * rem_y;
							big_x--;
							xp += 4;
							xs += 4*8;
						}
						if (rem_x) {
							/* Generate NxN sprite */
							curpos = ftell(outfile);
							fseek(outfile,sprite_pos,SEEK_SET);
							fwrite_68k_word(frm_ptr->y - scrn_y + ys,outfile);
							fwrite_68k_word((((rem_x-1) << 2) | rem_y-1) << 8,outfile);
							fwrite_68k_word(chr_cnt | color,outfile);
							fwrite_68k_word(frm_ptr->x - scrn_x + xs,outfile);
							sprite_pos += 8;
							fseek(outfile,curpos,SEEK_SET);
							for (x=0; x<rem_x; x++) {
								wptr = map_buf;
								wptr += (yp * map_width) + (xp+x);
								for (y=0; y<rem_y; y++) {
									chr_ptr = chr_buf + (*wptr * 32 );
									fwrite(chr_ptr,32,1,outfile);
									wptr += map_width;
								}
							}
							chr_cnt += rem_x * rem_y;
						}
					}
				} else
					Bomb("Sprite not found (anim%d, frame%d)!\n",
						anim_cnt,frm_cnt);
				frm_ptr++;
			}
			ptr = frm_ptr;
			anim_cnt++;
		}
	}

	if (chr_buf != NULL)
		free(chr_buf);
	if (map_buf != NULL)
		free(map_buf);
	if (spr_buf != NULL)
		free(spr_buf);
	if (anm_buf != NULL)
		free(anm_buf);

	fclose(outfile);
	return 0;
}
