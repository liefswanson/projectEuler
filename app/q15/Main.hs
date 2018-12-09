module Main where

import Counting (choose)

main :: IO ()
main =
    let
        rows = 20
        cols = 20
    in
        print $ (rows+cols) `choose` rows