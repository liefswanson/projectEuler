module Main where

import Spiral (asSpiral, getDiagonals)

main :: IO ()
main =
    let
        target = 1001
        spiral = asSpiral [1..target^2]
        diagonals = map getDiagonals spiral
    in
        print $ sum $ concat diagonals