/* a trivial sieve of erasthones */

#include <err.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <omp.h>
//#include <papi.h>

//#include "sampleMT.h"

#define NTHREADS 4 /* default */

static int get_nthreads(void)
{
	char *thr;

	thr = getenv("OMP_NUM_THREADS");

	return thr ? (int) strtol(thr, (char **) NULL, 10) :
		     NTHREADS;
}

int main(int argc, char **argv)
{
	int *arr, n, nthreads, i,j, range, sum = 0;

	if (argc != 2)
		errx(EXIT_FAILURE, "usage: sieve [nlimit]");

//	Sample_Init();

	n = (int) strtol(argv[1], (char **) NULL, 10);
	assert(n > 0);

	/*
	 * We allocate n * 4bytes (sizeof(int)) into contiguous memory.
	 */
	arr = calloc(n, sizeof(int));

	nthreads = get_nthreads();
	printf("threads: %d\n", nthreads);
	range = sqrt(n+1);

	omp_set_num_threads(nthreads);
	
	/* begin parallel region */
#pragma omp parallel shared(arr, n) private(i, j)
	{
		long tid = omp_get_thread_num();
		//Sample_SetCPU(tid);
#pragma omp for schedule(static)
		/* mark each element as potentially prime (1) */
		for (i = 0; i <= n; i++)
			arr[i] = 1;

#pragma omp for schedule(dynamic)
		for (i = 2; i <= range; i++) {
			for (j = i * i; j <= n; j = j + i)
//				if (arr[j] != 0)
					arr[j] = 0;
			
			//Sample_OFF(tid);
		}
	}

	for (i = 2; i <= n; i++)
		if (arr[i] != 0)
			sum++;
	
	printf("total primes %d\n", sum);

	//Sample_End();
	free(arr);
	return 0;
}
