module Main where

import Primes (primeFactors)

main :: IO ()
main =
    let
        n = 600851475143
        output = primeFactors n
    in
        print $ last output