module Main where

import Collatz (collatzSequenceFrom)
import Util (greatest)

-- would it could be faster to build a collatz tree and create a hashmap to each root
main :: IO ()
main =
    let
        target = 1*10^6
        iter = [1..target-1]
        sequences = map collatzSequenceFrom iter
        lens = map length sequences
        results = zip lens iter

        (len, elem) = greatest results

        output = "length: " ++ (show len)  ++ "\n" ++
                 "start : " ++ (show elem) ++ "\n"
    in
        putStr output