module Main where

import Counting (sumToN)

main :: IO ()
main =
    let
        numbers = [1..100]
        squares = map (^2) numbers
        squareSum  = (sumToN 100)^2
        sumSquares = sum squares
    in
        print $ squareSum - sumSquares