module Main where

import Primes (primeFactors)
import Util (removeDuplicates, iterativelyTake)

n = 5

checkGroup g = (head nums, check1)
    where
        nums = map fst g
        factors = map snd g
        check1 = all (\x-> length x == n) factors

main :: IO ()
main =
    let
        candidates = [2..]
        factorized = zip candidates $ map (removeDuplicates.primeFactors) candidates
        grouped = iterativelyTake n factorized
        results = map checkGroup grouped
        valid = filter snd results
    in
        print.fst.head $ valid