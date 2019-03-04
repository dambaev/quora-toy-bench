open Printf
open Unix
open Thread


let n = 50000000
let h = 1.0 /. (float_of_int ( 1 + n))


let calcPart perThread index =
  let start = float_of_int (index * perThread) in
  let to_index = start +. float_of_int perThread in
  let rec loop acc i = 
        if i = to_index
        then 4.0 *. acc
        else 
          let x = i *. h in
          loop (acc +. h *. (sqrt (1.0 -. x *. x))) (i +. 1.0)
    in
  loop 0.0 start

let () = 
  let threads_count = 
          if Array.length Sys.argv < 2
          then 1
          else 
            let count_str = Array.get Sys.argv 1 in
            int_of_string count_str in
  let () = printf "threads %i\n%!" threads_count in
  let per_worker = n / threads_count in
  let rec fork_workers acc cnt =
          if cnt = threads_count
          then acc
          else
            let answer = ref 0.0 in
            let thread = Thread.create (fun answer-> answer := calcPart per_worker cnt) answer in
            let () = Thread.yield () in
            fork_workers ((thread,answer)::acc) (cnt + 1) 
    in
  let answers = fork_workers [] 0 in
  let answer = List.fold_left (fun acc (thread,answer)-> let () = Thread.join thread in acc +. !answer) 0.0 answers in
  let () = printf "%f\n" answer in
  ()
