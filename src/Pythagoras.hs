module Pythagoras (
    pythagoreanTriples
) where

pythagoreanTriples :: Integer -> [[Integer]]
pythagoreanTriples maxLength = [3,4,5] : buildPythagoreanTreeFrom maxLength [3,4,5]

buildPythagoreanTreeFrom :: Integer -> [Integer] -> [[Integer]]
buildPythagoreanTreeFrom 0 _ = []
buildPythagoreanTreeFrom maxLength [a,b,c] =
    let
        left  = [  a - 2*b + 2*c,
                 2*a -   b + 2*c,
                 2*a - 2*b + 3*c]

        mid   = [  a + 2*b + 2*c,
                 2*a +   b + 2*c,
                 2*a + 2*b + 3*c]

        right = [ -a + 2*b + 2*c,
                -2*a +   b + 2*c,
                -2*a + 2*b + 3*c]

        sieve       = any (<= maxLength)
        children    = filter sieve [left, mid, right]
        descendants = concat $ map (buildPythagoreanTreeFrom maxLength) children
    in
        children ++ descendants