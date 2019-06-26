module Main where

import DynamicProgramming (fastCoins, britishCurrency)

main :: IO ()
main =
    let
        target = 200
    in
        print $ fastCoins britishCurrency !! target