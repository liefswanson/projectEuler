module Main where

import Primes (primeSequence)

main :: IO ()
main =
    let
        n = 10001 - 1 -- 0-indexed
    in
        print $ primeSequence !! n