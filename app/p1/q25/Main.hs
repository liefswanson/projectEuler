module Main where

import Counting (fibonacciSequence)
import Util (digits)

-- my fib sequence is 0 indexed... but also starts with a 0 where theirs does not
main :: IO ()
main =
    let
        target = 1000
        fibs = fibonacciSequence
        sieve n = target > digits n
    in
        print $ length $ takeWhile sieve fibs