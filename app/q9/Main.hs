module Main where

import Pythagoras (pythagoreanTriples)
import Primes (divides)

main :: IO ()
main =
    let
        target  = 1000
        triples = pythagoreanTriples target
        sieve x = (sum x) `divides` target
        match   = head $filter sieve triples
        factor  = target `div` (sum match)
        result  = map (*factor) match

        triple = show $ result
        summed = show $ sum result
        answer = show $ product result
    in
        putStr $ "triple: " ++ triple ++ "\n" ++
                 "summed: " ++ summed ++ "\n" ++
                 "answer: " ++ answer ++ "\n"


slowTriples n = [[x,y,z] | x <- [1..n],
                           y <- [1..n],
                           z <- [1..n],
                           x^2 + y^2 == z^2]