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
    [ bench ( "idiomatic fork " ++ show threads) $ nfIO $ Lib.calcFork threads
    , bench ( "idiomatic async " ++ show threads) $ nfIO $ Lib.calcAsync threads
    , bench ( "idiomatic parallel " ++ show threads) $ nf Lib.calcParallel threads
    , bench "idiomatic single" $ nf (Lib.calcPart Lib.n) 0
    , bench "ffi single" $ nfIO Lib1.calcSingleFFI
    , bench ("ffi parallel " ++ show threads) $ nf Lib1.calcParallel threads
    , bench ( "ffi async " ++ show threads ) $ nfIO $ Lib1.calcAsync threads
    ]
