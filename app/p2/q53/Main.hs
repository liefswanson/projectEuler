module Main where

import Counting (choose)

main :: IO ()
main = print brute


allChoices x = map (x `choose`) [0..x]

brute =
    let
        n = 10^6
        range = [1..100]
        candidates = map allChoices range
        results = filter (>n) $ concat candidates
    in
        length results