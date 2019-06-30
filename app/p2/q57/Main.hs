module Main where

import Fraction (Fraction(..), simplify)
import Util (digits)


iterator (Fraction n d) = Fraction (n+d+d) (n+d)

main :: IO ()
main = print $ length results
    where
        seive (Fraction n d) = digits n > digits d
        results = filter seive candidates
        candidates = take 1000 $ iterate iterator (Fraction 3 2)