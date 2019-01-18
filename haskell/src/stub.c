#include "math.h" 

double calc_part(int n, int per_thread, int start){
  double h = 1./(n+1);
  int to = start + per_thread;
  double quarterpi = 0.;
  for (int i=start; i<to; i++) {
    double x = i*h;
    quarterpi += h * sqrt(1-x*x);
  }
  return quarterpi;
}

