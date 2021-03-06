module Main where

import Util (enumerateIntegralRotations)
import Primes (primeSequence)
import Data.HashSet (HashSet, fromList, member)


main :: IO ()
main =
    let
        primes = takeWhile (<=1000000) primeSequence
        primeSet = Data.HashSet.fromList primes
        isRotationalPrime :: Integer -> Bool
        isRotationalPrime p = all (`member` primeSet) (enumerateIntegralRotations p)
        results = filter isRotationalPrime primes
    in
        print $ length results
