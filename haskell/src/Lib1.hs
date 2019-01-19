{-# LANGUAGE ForeignFunctionInterface #-}
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
foreign import ccall "calc_part" c_calc_part:: CInt-> CInt-> CInt-> Double

-- wrapper over C
calc_part:: Int-> Int-> Int-> Double
calc_part n per_thread start = c_calc_part (fromIntegral n) (fromIntegral per_thread) (fromIntegral start)

n :: Int
n = 50000000

calcSingleFFI:: IO Double
calcSingleFFI = pure $! 4.0 * calc_part n n 0

calcParallel:: Int-> Double
calcParallel threads = 4.0 * (sum $! parMap rdeepseq (calc_part n perThread ) ranges)
  where
    perThread = n `div` threads
    ranges = [ i * perThread | i <- [0..(threads - 1)]]

calcAsync:: Int-> IO Double
calcAsync threads = (4.0 *) . sum <$> A.mapConcurrently worker ranges
  where
    worker x = pure $! calc_part n perThread x
    perThread = n `div` threads
    ranges = [ i*perThread | i <- [0..threads-1]]

