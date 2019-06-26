module Main where

import Primes (prime')
import Util (truncateRight, digitsToInt)
import Data.List (permutations)

main :: IO ()
main =
    let
        seeds = takeWhile (/= []) $ iterate tail [7,6..1]
        pans = map digitsToInt $ concat $ map permutations seeds
        results = filter prime' pans
    in
        print $ maximum results