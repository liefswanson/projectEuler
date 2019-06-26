module Main where

import Counting (triangleSequence)
import Primes (countDivisors)

main :: IO ()
main =
    let
        n = 500
        sieve i = countDivisors i >= n
    in
        print $ head $ filter sieve triangleSequence