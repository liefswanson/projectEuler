module Main where

import Data.Char (digitToInt)

main :: IO ()
main =
    let
        target = 1000 :: Integer
        power  = 2^target
        digits = show power
        values = map digitToInt digits
    in
        print $ sum values