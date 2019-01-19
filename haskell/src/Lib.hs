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

calcParallel:: Int-> Double
calcParallel threads = 4.0 * (sum $! parMap rdeepseq (calcPart perThread) ranges)
  where
    perThread = n `div` threads
    ranges = [ i*perThread | i <- [0..(threads-1)]]

calcPart:: Int-> Int-> Double
calcPart (I# perThread) (I# start) = D# (loop 0.0## start)
  where
    I# n' = n
    h:: Double#
    h = 1.0## /## (int2Double# (1# +# n'))
    to = start +# perThread
    loop acc i = case i ==# to of
                     1# -> acc
                     _  -> loop (acc +## h *## (sqrtDouble# (1.0## -## x *## x))) (i +# 1#)
        where
          x = (int2Double# i) *## h

calcAsync:: Int-> IO Double
calcAsync threads = do
  rets <- A.mapConcurrently worker range
  pure $! 4.0 * sum rets
  where
    worker x = do
      let start = x * perThread
      pure $! calcPart perThread start
    perThread = n `div` threads
    range = [0..threads-1]

calcFork:: Int-> IO Double
calcFork workers = do
  results <- replicateM workers newEmptyMVar
  let index_results = zip range results
  foldM (\_ (i,result)-> do
                let start = i * per_worker
                forkIO (worker result start)
                pure ()
              ) () index_results
  ress <- mapM takeMVar results
  pure $! 4.0 * sum ress
  where
    range = [ 0 .. (workers - 1)]
    worker result x = do
      let ret = calcPart per_worker x
      putMVar result ret
    per_worker = n `div` workers

