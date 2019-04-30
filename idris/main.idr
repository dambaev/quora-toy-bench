n : Int
n = 50000000

calcPart: Int-> Int-> Double
calcPart perThread index = loop 0.0 (cast start)
  where
    start : Int
    start = index * perThread
    h : Double
    h = 1.0 / (cast (1 + n))
    to : Double
    to = cast (start + perThread)
    loop : Double-> Double-> Double
    loop acc i = 
      if i == to 
        then 4.0 * acc
        else loop (acc + h * (sqrt (1.0 - x * x))) (i + 1.0)
      where
        x = i * h

main : IO ()
main = putStrLn (show (calcPart n 0))
