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


isSumOfTwoFrom :: Integer -> [Integer] -> HashSet Integer -> Bool
isSumOfTwoFrom n listSet hashSet =
    let
        xs = zipWith (-) (repeat n) $ listSet
        possibleSums = filter (`member` hashSet) xs
    in
        length possibleSums /= 0