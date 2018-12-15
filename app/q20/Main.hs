module Main where

import Counting(factorial)
import Data.Char(digitToInt)

main :: IO ()
main =
    let
        fact = factorial 100
        s = show fact
        digits = map digitToInt s
    in
        print $ sum digits