module Main where

import Primes (primeSequence, prime')
import Counting (isPerfectSquare)
import Data.HashSet (fromList, member)
import Util (none, sortedListDiff)

check n = none isPerfectSquare results
    where
        differences = zipWith (-) (repeat n) primeSequence
        candidates = takeWhile (>0) $ differences
        results = map (`div` 2) candidates

main :: IO ()
main =
    let
        candidates = sortedListDiff (2:[3,5..]) primeSequence
    in
        print $ head $ filter check candidates
