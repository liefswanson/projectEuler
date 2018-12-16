module Main where

import Data.Foldable (maximumBy)
import Polynomials (intPoly)
import Primes (primeSequence, prime)

main :: IO ()
main =
    let
        primes = map fromIntegral $ takeWhile (<= 1000) primeSequence
        rawPolys = [[1, a, b] | a <- [-999,-997 .. 999],
                                b <- primes]
        polys = zipWith (map.intPoly) rawPolys (repeat [0..])
        sieve = prime.fromIntegral
        results = map (takeWhile sieve) polys
        zipped = zip (map length results) rawPolys
        (len, bestPrimePoly) = maximum zipped

        answer = (len, bestPrimePoly, product bestPrimePoly)
    in
        print answer
