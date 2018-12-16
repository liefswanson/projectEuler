module Polynomials (
    intPoly
) where

intPoly :: [Int] -> Int -> Int
intPoly poly x =
    let
        largest = length poly - 1
        exps = [largest,largest-1 .. 0]
        xs = zipWith (^) (repeat x) exps
        terms = zipWith (*) poly xs
    in
        sum terms