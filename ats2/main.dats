#include "share/atspre_staload.hats" 

staload "prelude/SATS/pointer.sats"
staload "libats/SATS/athread.sats"
staload UN = "prelude/SATS/unsafe.sats"

#include "libats/DATS/athread.dats"
#include "libats/DATS/athread_posix.dats"

%{

#include "unistd.h"
#include "omp.h"

%}

extern fn sqrt( n:double) :<> double = "ext#"
extern fn omp_get_wtime(): double = "ext#"

val n: int = 50000000

fn int2double(x: int):<> double = $UN.cast{double}(x)

val h = 1.0 / (int2double ( 1 + n))

fn
  calcPart
  {start_t: nat} {index_t: nat}
  ( perThread: int start_t
  , index: int index_t
  ):<> double = loop( 0.0, start, to_index) where {
    val start = index * perThread
    val to_index = start + perThread
    fun
      loop
      {start_t: int} {end_t: int | end_t >= start_t}
      .<end_t - start_t>.
      (acc:double, start: int start_t, i:int end_t):<> double =
        if i = start
        then 4.0 * acc
        else loop (acc + h * (sqrt (1.0 - x * x)), start, i - 1) where {
            val x = int2double(i) * h
          }
  }

fn
  pipe_
  (
  ): (int, int) =
    (first, second) where {
      var parr = @[int][2]()
      val _ = $extfcall(int, "pipe", addr@parr)
      val arr = $UN.cast{arrayref(int,2)}(addr@parr)
      val first = arr[0]
      val second = arr[1]
    }
  
fun
  {a:t@ype} {b: t@ype}
  list_vt_fold_left
  {n: nat}
  .<n>.
  ( f: (a,b)-<>a
  , acc: a
  , l: list_vt(b,n)
  ): a =
    case+ l of
    | ~list_vt_cons( first, rest) => list_vt_fold_left( f, f(acc, first), rest)
    | ~list_vt_nil() => acc

fn
  read_channels
  {n: nat}
  ( cs: list_vt(int, n)
  ): list_vt(double, n) =
  loop( cs, list_vt_nil) where {
    fun
      loop
      { m: nat | m <= n} {l: nat | l <= n}
      { m + l == n}
      .<m>.
      ( xs: list_vt(int, m)
      , acc: list_vt(double, l)
      ): list_vt( double, n) =
        case+ xs of
        | ~list_vt_cons( channel, rest) =>
          loop( rest, list_vt_cons( pval, acc)) where {
            var pval:double = 0.0
            val read = $extfcall(int, "read", channel, addr@pval, sizeof<double>)
            val () = $extfcall(void, "close", channel)
          }
        | ~list_vt_nil() => acc
  }

fun
  spawn
  { workers: nat | workers > 0}
  ( workers: int workers): double = sum where {
    val per_thread = n / workers
    fun
      loop
      {l: nat | l < workers}
      .<workers - l>.
      ( worker: int l
      , acc: list_vt (int, l)
      ): (double, list_vt (int, workers-1)) =
        if worker = workers - 1
        then (result, acc) where {
            val result = if per_thread >= 0 then calcPart( per_thread, worker) else 0.0
          }
        else loop( worker + 1, list_vt_cons( read, acc)) where { //alloc 
          val (read,write) = pipe_ ()
          var tid
          val thread = lam (): void =<lincloptr1>
            if per_thread >= 0
            then () where {
                val v = calcPart( per_thread, worker)
                var r = v
                val _ = $extfcall( int, "write", write, addr@r, sizeof<double>)
                val () = $extfcall( void, "close", write)
              }
            else ()
          val _ = athread_create_cloptr( tid, thread) //alloc
          }
    val (init_result, channels) = loop( 0, list_vt_nil)
    val results = read_channels( channels)
    val sum = list_vt_fold_left<double><double>( lam (acc,e) => acc + e, init_result, results) // alloc
  }

fn usage () =
  println!( "./sample <number_of_threads>0>" )

implement main0 (argc, argv) =
  if argc < 2
  then usage ()
  else
    let
      val arg: int = g1ofg0( $extfcall( int, "atoi", argv_get_at(argv, 1)))
    in
      if arg > 0
      then println!("pi = ", result, ", time = ", avg_time, "\n") where { // alloc
          val n = 100
          fun
            loop
            {n: nat} {m:nat | m > 0}
            .<n>.
            ( i: int n
            , workers: int m
            , result: double
            , total_time: double
            ): (double, double) =
              if i = 0
              then (result, total_time / n)
              else loop( i-1, workers, result1, total_time + (time1-time0))
                where {
                  val time0 = omp_get_wtime()
                  val result1 = spawn( workers)
                  val time1 = omp_get_wtime()
                }
          val (result, avg_time) = loop( n, arg, 0.0, 0.0)
        }
      else usage ()
    end
