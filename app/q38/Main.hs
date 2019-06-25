module Main where

import Util (digitList, digits, runningTotal, concatInts, isPandigital10)
import Data.List (sort)

possibleNs = [1..9]
candidates = [2..9999]

makePandigital :: Int -> Int
makePandigital num =
    let
        parts = zipWith (*) possibleNs $ repeat num
        digitCounts = map digits parts
        running = runningTotal digitCounts
        validCount = length $ takeWhile (<=9) running
        validParts = take validCount parts
    in
        concatInts validParts

main :: IO ()
main =
    let
        temp = zip (map makePandigital candidates) candidates
        results = filter (isPandigital10.fst) temp
        result = maximum $ map fst results
    in
        print result