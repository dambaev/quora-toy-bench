#include <stdlib.h>

#include <stdio.h>

#include <math.h>

#include <omp.h>

// 50 million
//
#define N 50000000

double calc_multi(){
  // step size
  double h = 1./(N+1);
  // start timer
  double t = omp_get_wtime();
  double quarterpi = 0.;
  #pragma omp parallel for reduction(+:quarterpi)
  for (int i=0; i<N; i++) {
    double x = i*h;
    quarterpi += h * sqrt(1-x*x);
  }
  // stop timer and report
  t = omp_get_wtime()-t;
  return t;
}
double calc_single(){
  // step size
  double h = 1./(N+1);
  // start timer
  double t = omp_get_wtime();
  double quarterpi = 0.;
  for (int i=0; i<N; i++) {
    double x = i*h;
    quarterpi += h * sqrt(1-x*x);
  }
  // stop timer and report
  t = omp_get_wtime()-t;
  return t;
}

int main(){
  double timeacc = 0.0d;
  double times = 0;
//  for( ; times < 100; times ++){
//    timeacc += calc_single();
//  }
//  printf( "single avg %7.5f\n", timeacc / times);
  for( times = 0.0d, timeacc = 0.0d; times < 100; times ++){
    timeacc += calc_multi();
  }
  printf( "multi avg %7.5f\n", timeacc / times);
  return 0;
}
