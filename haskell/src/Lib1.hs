{-# LANGUAGE MagicHash #-}
{-# LANGUAGE ForeignFunctionInterface #-}
{-# LANGUAGE UnliftedFFITypes #-}
module Lib1 where

import Control.Concurrent.Async as A
import Control.Concurrent.MVar
import Control.Concurrent
import Control.Parallel.Strategies
import Control.Monad
import GHC.Prim
import GHC.Types
import Foreign.C.Types
import Data.IORef

-- import C stub
foreign import ccall unsafe "math.h sqrt" c_sqrt:: Double# -> Double#

n :: Int
n = 50000000

calcSingleFFI:: IO Double
calcSingleFFI = pure $! calcPart n 0

calcParallel:: Int-> Double
calcParallel threads = 4.0 * (sum $! parMap rdeepseq (calcPart perThread) ranges)
  where
    perThread = n `div` threads
    ranges = [ 0..(threads-1)]

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
                     _  -> loop (acc +## h *## (c_sqrt (1.0## -## x *## x))) (i +## 1.0##)
      where
        x = i *## h

calcAsync:: Int-> IO Double
calcAsync threads = do
  rets <- A.mapConcurrently worker range
  pure $! 4.0 * sum rets
  where
    worker x = do
      pure $! calcPart perThread x
    perThread = n `div` threads
    range = [0..threads-1]

calcFork:: Int-> IO Double
calcFork workers = do
  results <- replicateM workers newEmptyMVar
  foldM_ (\i result-> do
                forkIO (worker result i)
                pure (i + 1)
              ) 0 results
  sum <$> mapM takeMVar results
  where
    worker result i = do
      let ret = calcPart per_worker i
      putMVar result ret
    per_worker = n `div` workers

