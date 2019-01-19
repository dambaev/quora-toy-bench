all:
	gcc -O3 ./test.c -o test -lm -fopenmp
	gcc ./test.c -o test_nonopt -lm -fopenmp
	gcc -O3 ./forking.c -o forking -pthread -lpthread -lm -fopenmp
