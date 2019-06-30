module Main where

import Primes (prime)
import Spiral (getCornerIndexes)
import Util (runningTotal)

main :: IO ()
main =
    let
        diagonals = getCornerIndexes
        primes = map (filter prime) diagonals
        primeCount = runningTotal $ map (fromIntegral.length) primes :: [Integer]
        totalCount = map (\x-> x*4+1) [0..]
        results = zipWith (\n d -> d > n*10) primeCount totalCount
        indexed = zip [1,3..] results
    in
        print.fst.head.tail $ filter snd indexed