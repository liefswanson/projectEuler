module Main where

import Data.HashSet (fromList, HashSet, size)

main :: IO ()
main =
    let
        lower = 2
        upper = 100
        range = [2..100]
        bruteForce = [a^b | a <- range,
                            b <- range]
        set = fromList bruteForce :: HashSet Integer
    in
        print $ size set