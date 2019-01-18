module Main where

import Data.IORef
import Criterion.Main
import Control.Concurrent

import Lib
import Lib1

main = do
  threads <- getNumCapabilities
  putStrLn $ "threads avaialble: " ++ show threads
  defaultMain
    [ bench "idiomatic single" $ nf (Lib.calcPart 10000000) 0
    , bench ( "idiomatic parallel " ++ show threads) $ nf Lib.calcParallel threads
    , bench ( "idiomatic async " ++ show threads) $ nfIO $ Lib.calcAsync threads
    , bench "ffi single" $ nfIO Lib1.calcSingleFFI
    , bench ("ffi parallel " ++ show threads) $ nf Lib1.calcParallel threads
    , bench ( "ffi async " ++ show threads ) $ nfIO $ Lib1.calcAsync threads
    ]
