module Main where

import Primes (
    primeFactors,
    mergeFactorLists,
    multiplyFactorList)
import Util (runLength)

main :: IO ()
main =
    let
        numbers = [1..20]
        factorLists = map (runLength.primeFactors) numbers
        merged = foldl mergeFactorLists [] factorLists
        result = multiplyFactorList merged
    in
        print result