module Main where

import Primes (primeSequence)
import Data.HashSet (HashSet, fromList, member)



main :: IO ()
main =
    let
        n = 10^6
        primes = takeWhile (<n) primeSequence
        nextSum base (_:xs) = takeWhile (<n) $ zipWith (+) xs base
        candidates = takeWhile (not.null) $ iterate (nextSum primes) primes
        results = concat $ map (filter isPrime) candidates
            where
                isPrime n = member n primeSet
                primeSet = fromList primes

    in
        print $ last results