{-# LANGUAGE MagicHash #-}
module Lib where

import Control.Concurrent.Async as A
import Control.Parallel.Strategies
import Control.Concurrent
import Control.Concurrent.MVar
import Control.Monad
import GHC.Prim
import GHC.Types

n :: Int
n = 50000000

calcPart:: Int-> Int-> Double
calcPart (I# perThread) (I# index) = D# (loop 0.0## (int2Double# start))
  where
    I# n' = n
    h:: Double#
    start = index *# perThread
    h = 1.0## /## (int2Double# (1# +# n'))
    to = int2Double# (start +# perThread)
    loop acc i = case i ==## to of
                     1# -> 4.0## *## acc
                     _  -> loop (acc +## h *## (sqrtDouble# (1.0## -## x *## x))) (i +## 1.0##)
      where
        x = i *## h

calcParallel:: Int-> Double
calcParallel threads = sum $! parMap rdeepseq (calcPart perThread) ranges
  where
    perThread = n `div` threads
    ranges = [ 0..(threads-1)]

calcAsync:: Int-> IO Double
calcAsync threads = A.mapConcurrently worker range >>= \res-> pure $! sum res
  where
    worker x = pure $! calcPart perThread x
    perThread = n `div` threads
    range = [0..threads-1]

calcFork:: Int-> IO Double
calcFork workers =
  fork_workers [] 0 >>= mapM takeMVar >>= \res-> pure $! sum res
  where
    fork_workers acc n | n == workers = pure acc
    fork_workers acc n = do
      result <- newEmptyMVar
      forkIO (putMVar result $! calcPart per_worker n)
      fork_workers (result:acc) (n+1)
    per_worker = n `div` workers

