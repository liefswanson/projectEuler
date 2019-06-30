module Main where

import Primes (primeSequence, prime)
import Util (concatInts, asList, removeDuplicates)
import Data.List (elem, sort, groupBy)

primePair a b = prime x && prime y
    where
        x = concatInts [a,b]
        y = concatInts [b,a]

primesUntil step = takeWhile (\x -> x <= step) primeSequence

getPairs xs = map (prefix++) $ results
    where
        prefix = init $ head xs
        ys = map last xs
        results = [[a,b] | a <- ys,
                           b <- takeWhile (<a) ys,
                           primePair a b]


target = 5
grouping a b = init a == init b

performPass n groups = groupBy grouping $ concat results
    where
        sieve n group = length group >= target - n
        filtered = filter (sieve n) groups
        results = map getPairs groups

main :: IO ()
main =
    let
        upper = sum [8389,6733,5701,5197,13, -3, -7, -11, -13]
        -- upper = 10000
        primes = map asList $ primesUntil upper

        pairs = getPairs primes
        grouped = groupBy grouping pairs

        chewAway groups = foldl (\x n -> performPass n x) groups passes
            where
                passes = [1..target-2] -- 2 = size of a pair, which we started with

        results = chewAway grouped
        format = minimum.(map sum).concat
    in
        print $ format results