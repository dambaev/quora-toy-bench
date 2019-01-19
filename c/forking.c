#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include <stdio.h>

#include <math.h>

#include <omp.h>

// 50 million
#define N 50000000

double calc_part( int per_thread, int start){
  int to = 0;
  to = start + per_thread;
  // step size
  double h = 1./(N+1);
  double quarterpi = 0.;
  for (int i=start; i<to; i++) {
    double x = i*h;
    quarterpi += h * sqrt(1-x*x);
  }
  return quarterpi;
}

struct myarg
{
	int per_thread;
	int start;
	pthread_t id;
	double result;
};
void* child( void *args){
	struct myarg *state = args;
	state-> result = calc_part( state-> per_thread, state-> start);
	pthread_exit(0);
	return 0;
}

double calc_forking( int workers){
	int threads = 0;
	double ret = 0.0d;
	double * results = 0;
	int per_thread = 0;
	int * reports = 0;
	pthread_attr_t attr;

	per_thread = N / workers;
	struct myarg *states = malloc(workers * sizeof (struct myarg));
	memset( states, 0, workers * sizeof( struct myarg));
	for( int i = 1; i < workers; ++i) {
		states[i]. per_thread = per_thread;
		states[i]. start = i * per_thread;
		pthread_create( &states[i].id, 0, child, &states[i]);
	}
	states[0]. result = calc_part( per_thread, 0);
	int ready = 0;
	for( int i = 1; i < workers; ++i ){
		pthread_join(states[i].id, 0);
	}
	for( int i = 0; i < workers; ++i) {
		ret += states[i].result;
	}
	ret *= 4.0;

	free( states);
	return ret;
}

int main(int argc, char ** argv){
	double ret = 0.0d;
	double times = 0;
	int workers = 1;

	if( argc > 1){
		sscanf( argv[1], "%d", &workers);
	}
	printf( "workers %d\n", workers);
	// start timer
	double t = omp_get_wtime();
	for( times = 0.0d; times < 100; times ++){
		ret = calc_forking( workers);
	}
	// stop timer and report
	t = omp_get_wtime()-t;
	printf( "multi avg %7.5f, %f\n", t / times, ret);
	return 0;
}
