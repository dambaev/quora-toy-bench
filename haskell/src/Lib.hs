module Lib where

import Control.Concurrent.Async as A
import Control.Parallel.Strategies

n :: Int
n = 10000000
h:: Double
h = 1.0 / (1 + (fromIntegral n))

calcParallel:: Int-> Double
calcParallel threads = 4.0 * (sum $! parMap rdeepseq (calcPart perThread) ranges)
  where
    perThread = n `div` threads
    ranges = [ i*perThread | i <- [0..(threads-1)]]

calcPart:: Int-> Int-> Double
calcPart perThread start = loop 0 start
  where
    to = start + perThread
    loop !acc !i
      | i == to = acc
      | otherwise = loop (acc + h * (sqrt $! 1 - x * x)) (i+1)
        where
          x = (fromIntegral i) * h

calcAsync:: Int-> IO Double
calcAsync threads = (4.0 *) . sum <$> A.mapConcurrently worker ranges
  where
    worker x = pure $! calcPart perThread x
    perThread = n `div` threads
    ranges = [ i*perThread | i <- [0..threads-1]]

