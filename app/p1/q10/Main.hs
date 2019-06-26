module Main where

import Primes (primeSequence)

main :: IO ()
main =
    let
        upper = 2*10^6
        primes = takeWhile (< upper) primeSequence
    in
        print $ sum primes