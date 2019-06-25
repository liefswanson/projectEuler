module Main where

import Data.HashSet (fromList, HashSet)
import Data.List (sort)
import Util (runLength)

main :: IO ()
main =
    let
        target = ['1'..'9']

        oneDigit   = [1..9]
        twoDigit   = [10..99]
        threeDigit = [100..999]
        fourDigit  = [1000..9999]

        results = panDigitalProductsOver oneDigit fourDigit target ++
                  panDigitalProductsOver twoDigit threeDigit target
        prods = fromList $ map head results :: HashSet Integer
    in
        print $ sum prods

panDigitalProductsOver firstRange secondRange target =
    let
        candidates = [[a*b,a,b] | a <- firstRange, b <- secondRange]
        countEachDigit = runLength.sort.concat.map show
        results = map (unzip.countEachDigit) candidates

        sieve (values, counts) = values == target && all (==1) counts
    in
        map fst $ filter (sieve.snd) $ zip candidates results
