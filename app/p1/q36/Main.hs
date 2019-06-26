module Main where

import Util (palindrome, decimalToBinary)

main :: IO ()
main =
    let
        check n = palindrome (show n) && palindrome (decimalToBinary n)
        results = filter check [1..1000000]
    in
        print $ sum results