module Main where

import Counting (isPentagonal, hexagonalSequence)

main :: IO ()
main = brute

brute =
    let
        results = filter isPentagonal hexagonalSequence -- all hexagonal are triangular
    in
        print $ head $ dropWhile (<= 40755) results