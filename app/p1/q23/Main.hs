module Main where

import Primes (isAbundant)
import Data.HashSet (HashSet, fromList, member)

main :: IO ()
main =
    let
        upper = 28123
        range = [1..upper]
        abundant = filter isAbundant range
        hashedSet = fromList abundant

        sieve n = not $ isSumOfTwoFrom n abundant hashedSet
        areNotSummation = filter sieve range
    in
        print $ sum areNotSummation


-- this is n^2 and should be fixed
isSumOfTwoFrom :: Integer -> [Integer] -> HashSet Integer -> Bool
isSumOfTwoFrom n listSet hashSet =
    let
        xs = map (n-) listSet
        possibleSums = filter (`member` hashSet) xs
    in
        null possibleSums