CC=clang
N=1000000000

all: sievemultip sievesingle

clean:
	rm -f sievemultip sievesingle

test: all
	@echo single core
	time ./sievesingle $(N)
	@echo multip core
	time ./sievemultip $(N)

