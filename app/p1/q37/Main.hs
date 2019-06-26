module Main where

import Primes (primeSequence, prime)
import Util (truncateLeft, truncateRight, digits)

truncatable :: Integer -> Bool
truncatable n = rightTruncatable n && leftTruncatable n

leftTruncatable :: Integer -> Bool
leftTruncatable n = all prime $ takeWhile (>0) $ iterate truncateLeft n

rightTruncatable :: Integer -> Bool
rightTruncatable n = all prime $ takeWhile (>0) $ iterate truncateRight n

main :: IO ()
main =
    let
        truncatables = filter truncatable $ dropWhile (<10) primeSequence
        results = take 11 truncatables
    in
        print $ sum results