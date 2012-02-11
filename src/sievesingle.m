#include <err.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>


int main(int argc, char **argv) {
    if (argc != 2) {
        errx(EXIT_FAILURE, "usage: singlecore <nlimit>");	  
    }
	
    int n = (int) strtol(argv[1], NULL, 10);
    int *arr = calloc(n, sizeof(int));
    int range = sqrt(n + 1);

    for (int i = 0; i < n; i++) {
        arr[i] = 1;
    }

    for (int i = 2; i <= range; i++) {
        for (int j = i*i; j < n; j = j + i) {
            arr[j] = 0;
        }
    }

    int sum = 0;
    for (int i = 2; i < n; i++) {
        if (arr[i] != 0) {
            sum++;
        }
    }
    
    printf("total primos: %d\n", sum);
    free(arr);
    
    return 0;
}
