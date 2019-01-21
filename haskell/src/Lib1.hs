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

