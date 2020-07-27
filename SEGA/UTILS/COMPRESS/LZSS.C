/* pages 266-276 of The Data Compression Book */
/* almost no comments are reproduced */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "bitio.h"

#define INDEX_BIT_COUNT			12
#define LENGTH_BIT_COUNT		4
#define WINDOW_SIZE				(1 << INDEX_BIT_COUNT)
#define RAW_LOOK_AHEAD_SIZE	(1 << LENGTH_BIT_COUNT)
#define BREAK_EVEN				((1 + LENGTH_BIT_COUNT + INDEX_BIT_COUNT)/9)
#define LOOK_AHEAD_SIZE			(RAW_LOOK_AHEAD_SIZE + BREAK_EVEN)
#define TREE_ROOT					WINDOW_SIZE
#define END_OF_STREAM			0
#define UNUSED						0
#define MOD_WINDOW(a)			((a) & (WINDOW_SIZE-1))


char *CompressionName = "LZSS Encoder";
char *Usage = "infile outfile ";


unsigned char window[WINDOW_SIZE];

struct {
	int parent;
	int smaller_child;
	int larger_child;
} tree[WINDOW_SIZE + 1];

#ifdef _STDC_

void InitTree(int r);
void ContractNode( int old_node, int new_node);
void ReplaceNode( int old_node, int new_node);
int FindNextNode( int node);
void DeleteString(int p);
int AddString(int new_node, int *match_position);
void CompressFile( FILE *input, BIT_FILE *output, int argc, char *argv[]);
void ExpandFile( BIT_FILE *input, FILE *output, int argc, char *argv[]);

#else

void InitTree();
void ContractNode();
void ReplaceNode();
int FindNextNode();
void DeleteString();
int AddString();
void CompressFile();
void ExpandFile();

#endif


void InitTree(int r)
{
	tree[TREE_ROOT].larger_child = r;
	tree[r].parent = TREE_ROOT;
	tree[r].larger_child = UNUSED;
	tree[r].smaller_child = UNUSED;

}

void ContractNode( int old_node, int new_node)
{
	tree[new_node].parent = tree[old_node].parent;
	if (tree[tree[old_node].parent].larger_child == old_node)
		tree[tree[old_node].parent].larger_child = new_node;
	else
		tree[tree[old_node].parent].smaller_child = new_node;
	tree[old_node].parent = UNUSED;

}

void ReplaceNode( int old_node, int new_node)
{
	int parent;

	parent = tree[old_node].parent;
	if (tree[parent].smaller_child == old_node)
		tree[parent].smaller_child = new_node;
	else
		tree[parent].larger_child = new_node;
	tree[new_node] = tree[old_node];
	tree[tree[new_node].smaller_child].parent = new_node;
	tree[tree[new_node].larger_child].parent = new_node;
	tree[old_node].parent = UNUSED;

}

int FindNextNode( int node)
{
	int next;

	next = tree[node].smaller_child;
	while (tree[next].larger_child != UNUSED)
		next = tree[next].larger_child;
	return(next);
}

void DeleteString(int p)
{
	int replacement;

	if (tree[p].parent == UNUSED)
		return;
	if (tree[p].larger_child == UNUSED)
		ContractNode(p, tree[p].smaller_child);
	else if (tree[p].smaller_child == UNUSED)
		ContractNode(p, tree[p].larger_child);
	else {
		replacement = FindNextNode(p);
		DeleteString(replacement);
		ReplaceNode(p, replacement);
	}


}

int AddString(int new_node, int *match_position)
{
	int i;
	int test_node;
	int delta;
	int match_length;
	int *child;

	if (new_node == END_OF_STREAM)
		return(0);
	test_node = tree[TREE_ROOT].larger_child;
	match_length = 0;
	for ( ; ; ) {
		for (i = 0; i < LOOK_AHEAD_SIZE; i++) {
			delta = window[MOD_WINDOW(new_node + i)] -
					  window[MOD_WINDOW(test_node + i)];
			if (delta != 0)
				break;
		}
		if ( i >= match_length) {
			match_length = i;
			*match_position = test_node;
			if (match_length >= LOOK_AHEAD_SIZE) {
				ReplaceNode( test_node, new_node);
				return(match_length);
			}
		}
		if (delta >= 0)
			child = &tree[test_node].larger_child;
		else
			child = &tree[test_node].smaller_child;

		if ( *child == UNUSED) {
			*child = new_node;
			tree[new_node].parent = test_node;
			tree[new_node].larger_child = UNUSED;
			tree[new_node].smaller_child = UNUSED;
			return(match_length);

		}
		test_node = *child;
	}

}

void CompressFile( FILE *input, BIT_FILE *output, int argc, char *argv[])
{
	int i;
	int c;
	int look_ahead_bytes;
	int current_position;
	int replace_count;
	int match_length;
	int match_position;
	long eof_ftell;

	if (input == NULL)
		eof_ftell = 0L;
	fseek(input, 0L, SEEK_END);
	eof_ftell = ftell(input);
	rewind(input);
	OutputBits(output, (unsigned long) eof_ftell, 32);

	current_position = 1;
	for (i = 0; i < LOOK_AHEAD_SIZE; i++){
		if ((c = getc(input)) == EOF)
			break;
		window[current_position + i] = (unsigned char) c;
	}
	look_ahead_bytes = i;
	InitTree(current_position);
	match_length = 0;
	match_position = 0;
	while ( look_ahead_bytes > 0) {
		if(match_length > look_ahead_bytes)
			match_length = look_ahead_bytes;
		if(match_length <= BREAK_EVEN) {
			replace_count = 1;
			OutputBit(output, 1);
			OutputBits(output, (unsigned long)window[current_position], 8);
		} else {
			OutputBit(output, 0);
			OutputBits(output, (unsigned long) match_position, INDEX_BIT_COUNT);
			OutputBits(output, (unsigned long) (match_length - (BREAK_EVEN + 1)),
				LENGTH_BIT_COUNT);
			replace_count = match_length;
		}
		for (i = 0; i < replace_count; i++) {
			DeleteString(MOD_WINDOW(current_position + LOOK_AHEAD_SIZE));
			if ((c = getc(input)) == EOF)
				look_ahead_bytes--;
			else
				window[MOD_WINDOW(current_position + LOOK_AHEAD_SIZE)]
					= (unsigned char) c;
			current_position = MOD_WINDOW(current_position + 1);
			if (look_ahead_bytes)
				match_length = AddString(current_position, &match_position);
		}

	}
	OutputBit(output, 0);
	OutputBit(output, (unsigned long) END_OF_STREAM, INDEX_BIT_COUNT);
	while (argc-- > 0)
		printf("Unknown argument: %s\n", *argv++);

}

void ExpandFile( BIT_FILE *input, FILE *output, int argc, char *argv[])
{
	int i;
	int c;
	int current_position;
	int match_length;
	int match_position;
	unsigned long file_length;

	file_length = InputBits(input, 32);

	current_position = 1;

	for ( ; ; ) {
		if (InputBit(input)) {
			c = (int) InputBits(input,8);
			putc(c, output);
			window[current_position] = (unsigned char) c;
			current_position = MOD_WINDOW(current_position + 1);
		} else {
			match_position = (int) InputBits( input, INDEX_BIT_COUNT);
			if (match_position == END_OF_STREAM)
				break;
			match_length = (int) InputBits( input, LENGTH_BIT_COUNT);
			match_length += BREAK_EVEN;
			for ( i = 0; i <= match_length; i++) {
				c = window[MOD_WINDOW(match_position + i)];
				putc(c, output);
				window[ current_position ]= (unsigned char) c;
				current_position = MOD_WINDOW(current_position + 1);
			}
		}
	}
	while (argc-- > 0)
		printf("Unknown argument: %s\n", *argv++);

}
