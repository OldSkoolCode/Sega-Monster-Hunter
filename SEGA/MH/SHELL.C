
/* $Header */


/*
* $Log: shell.c_v $
 * Revision 1.1  1993/04/29  01:11:25  KENH
 * Initial revision
 *

*/




void shell(int v[], int n)
{
	
	register int	gap, i, j, temp;

	for (gap = n/2; gap >0; gap /= 2)
		for (i=gap; i<n; i++)
			for (j=i-gap; j>=0 && v[j]>v[j+gap]; j-=gap)
				{
					temp = v[j];
					v[j] = v[j+gap];
					v[j+gap] = temp;
				}
}
