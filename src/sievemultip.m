#include <err.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include <dispatch/dispatch.h>
// número de paralelizaciones (12, arbitrario)
#define COUNT 12

int main(int argc, char **argv) {
    if (argc != 2) {
        errx(EXIT_FAILURE, "usage: multicore <nlimit>");	  
    }
	
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    int n = (int) strtol(argv[1], NULL, 10);
    int *arr = calloc(n, sizeof(int));
    int range = sqrt(n + 1);

    int c = (n > COUNT ? COUNT : 1);
    int step = n / c;
    dispatch_apply(c, queue, ^(size_t z) {
        int ini = step * z;
        int end = (z == c - 1 ? n : step * (z + 1));

        for (int i = ini; i < end; i++) {
            arr[i] = 1;            
        }
    });
    
    dispatch_apply(range - 1, queue, ^(size_t z) {
        int i = z + 2;
        for (int j = i*i; j < n; j = j + i) {
            arr[j] = 0;
        }
    });

    int result[c], *resultPtr;
    resultPtr = result;
    dispatch_apply(c, queue, ^(size_t z) {
        int ini = step * z; ini = (ini == 0 ? 2 : ini);
        int end = (z == c - 1 ? n : step * (z + 1));

        int sum = 0;
        for (int i = ini; i < end; i++) {
            if (arr[i] != 0) {
                sum++;
            }
        }
        resultPtr[z] = sum;
    });
    
    int sum = 0;
    for (int i = 0; i < c; i++) {
        sum = sum + result[i];
    }
    
    printf("total primos: %d\n", sum);
    free(arr);
    
    return 0;
}
