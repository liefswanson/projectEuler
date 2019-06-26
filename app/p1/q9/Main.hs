module Main where

import Pythagoras (Triple(..), pythagoreanTripleSequence, perimeter)
import Primes (divides)

main :: IO ()
main =
    let
        target  = 1000
        sieve trip = (perimeter trip) `divides` target
        match   = head $ filter sieve pythagoreanTripleSequence
        factor  = target `div` (perimeter match)
        asList (Triple a b c) = map (*factor) [a, b, c]
        result = asList match

        triple = show $ result
        summed = show $ sum result
        answer = show $ product result
    in
        putStr $ "triple: " ++ triple ++ "\n" ++
                 "summed: " ++ summed ++ "\n" ++
                 "answer: " ++ answer ++ "\n"


-- brute force, unused
slowTriples n = [[x,y,z] | x <- [1..n],
                           y <- [1..n],
                           z <- [1..n],
                           x^2 + y^2 == z^2]