module Main where

import Pythagoras (pythagoreanTripleSequence, perimeter, Triple(..))
import Primes (divides)
import Data.List (sort)

main:: IO ()
main =
    let
        cap = 1000
        condition (Triple a b c) = a <= cap || b <= cap || c <= cap
        trips = takeWhile condition pythagoreanTripleSequence
        perimeters = map perimeter trips
        candidates = [1..cap]
        possibleTriples x = length $ filter (`divides` x) perimeters
        results = map possibleTriples candidates
    in
        mapM_ print $ sort $ filter ((0<).fst) $ zip results candidates