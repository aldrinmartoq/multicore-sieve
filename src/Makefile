CC=clang
N=1000000000

all: sievemultip sievesingle sieveopenmp

sieveopenmp:
	gcc -fopenmp sieveopenmp.c -o sieveopenmp

clean:
	rm -f sievemultip sievesingle sieveopenmp

test: all
	@echo
	time ./sievesingle $(N)
	@echo
	time ./sieveopenmp $(N)
	@echo
	time ./sievemultip $(N)

