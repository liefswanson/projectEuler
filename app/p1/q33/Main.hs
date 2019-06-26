module Main where

import Fraction

main :: IO ()
main =
    let
        fractions = [Fraction a b | a <- [11..99], b <- [11..99], a < b]
        filtered = filter canSillySimplify fractions
        naiveFraction x = simplify x == simplify (sillySimplify x)
        naives = filter naiveFraction filtered
    in
        print $ foldl (*) (head naives) (tail naives)