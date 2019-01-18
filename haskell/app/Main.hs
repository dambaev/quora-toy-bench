{-#LANGUAGE ScopedTypeVariables #-}
module Main where

import Data.IORef
import Lib

main :: IO ()
main = do
  -- print =<< calcMulti 4
  print =<< calcAsync 4
  -- print =<< calcSingle

