module Main where

import Util (withinRange, asList)
import Counting (triangleSequence,
                 squareSequence,
                 pentagonalSequence,
                 hexagonalSequence,
                 heptagonalSequence,
                 octagonalSequence,
                 circularPermutations)


overlapsWith left right = a == b
    where
        a = left `mod` 100
        b = right `div` 100

canJoin left right = a `overlapsWith` b
    where
        a = last left
        b = head right

findValidCombinations xs ys = [x ++ y | x <- xs, y <- ys, canJoin x y ]

buildAnswers (x:xs) = filter (\y -> canJoin y y) candidates
    where
        candidates = foldl findValidCombinations x xs

main :: IO ()
main =
    let
        low = 10^3
        high = 10^4 - 1
        clamp = withinRange low high
        noZeroInTensPosition x = (x `mod` 100) - (x `mod` 10) > 0

        ngonSequences = map clamp [
                                triangleSequence,
                                squareSequence,
                                pentagonalSequence,
                                hexagonalSequence,
                                heptagonalSequence,
                                octagonalSequence
                            ]
        seeds = map (map asList) ngonSequences
        candidates = circularPermutations seeds
        results = map buildAnswers candidates
        result = head.head $ filter (not.null) results
    in
        print $ sum result