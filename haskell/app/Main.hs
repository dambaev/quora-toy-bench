module Main where

import Data.IORef
import Control.Monad
import System.Clock
import Control.Concurrent
import Lib

main :: IO ()
main = do
  let n = 100
  threads <- getNumCapabilities
  start <- getTime MonotonicRaw
  ret <- foldM (\_ _-> calcFork threads) 0.0 [1 .. n]
  end <- getTime MonotonicRaw
  let diff = fromIntegral $! toNanoSecs $! diffTimeSpec end start
  print $! "ns = " ++ (show $! diff `div` n)
  case ret of { _-> pure ()}

