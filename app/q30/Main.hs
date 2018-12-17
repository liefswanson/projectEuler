module Main where

import Data.Char (digitToInt)

main :: IO ()
main =
    let
        pow = 5
        upper = (pow+1) * 9^pow
        range = [2..upper]
        sieve x = x == powerSum pow x
        results = filter sieve range
    in
        -- mapM_ print results
        print $ sum results

powerSum :: Int -> Int -> Int
powerSum x = sum.map (^x).map digitToInt.show
