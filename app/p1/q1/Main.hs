module Main where

import Counting (sumToN)

main :: IO ()
main =
    let
        upper    = 1000-1
        threes   = sumToN $ upper `div` 3
        fives    = sumToN $ upper `div` 5
        fifteens = sumToN $ upper `div` (lcm 3 5)
    in
        print $ 3*threes + 5*fives - (lcm 3 5)*fifteens