all:
		patscc -O2 -DATS_MEMALLOC_LIBC main.dats -static --static -o sample -lpthread -fopenmp -lm

debug:
		patscc -g -DATS_MEMALLOC_LIBC -o sample -lm -lpthread main.dats -fopenmp

install:
		cp sample $(out)
