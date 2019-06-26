module Main where

import Data.List (sort, permutations)

main :: IO ()
main =
    let
        idx = 10^6
        perms = permutations [0..9]
        sorted = sort perms
        target = sorted !! (idx-1)
        asString = concat $ map show target
        result = read asString :: Integer
    in
        print $ result