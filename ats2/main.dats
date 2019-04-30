#include "share/atspre_staload.hats" 
staload
UN = "prelude/SATS/unsafe.sats"

extern fn sqrt( n:double) : double = "ext#"

val n = 50000000

fn int2double(x: int): double = $UN.cast{double}(x)

val h = 
let 
  val tmp = int2double(1 + n)
in 1.0 / (int2double ( 1 + n))
end


fn calcPart (perThread: int, index: int) : double =
  let
    val index_perThread = index * perThread
    val start = int2double (index_perThread)
    val to_index = start + int2double(perThread)
    fun loop (acc:double,i:double):double = 
          if i = to_index
          then 4.0 * acc
          else 
            let
              val x = i * h
            in  loop (acc + h * (sqrt (1.0 - x * x)), i + 1.0)
            end
  in loop( 0.0, start)
  end

val _ = println! ( "pi = ", calcPart(n,0) )

implement main0 () = ()
