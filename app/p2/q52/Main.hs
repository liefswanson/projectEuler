module Main where

import Data.List (sort)
import Util (digitList)

main :: IO ()
main = print brute

brute =
    let
        candidates = [1..]
        check x = all (==h) t
            where
                (h:t) = map (sort.digitList) mults
                mults = zipWith (*) [1..6] $ repeat x
    in
        head $ filter check candidates