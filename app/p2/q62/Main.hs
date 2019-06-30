module Main where

import Data.List (groupBy, sort)
import Util (digits)

target = 5

processGroup group = filter (\x -> length x == target) grouped
    where
        grouped = groupBy (\(a,_) (b,_) -> a == b) sorted
        sorted = sort $ map addKey group
        addKey x = (sort (show x), x)

main :: IO ()
main =
    let
        candidates = map (^3) [1..]
        groups = groupBy (\a b -> digits a == digits b) candidates
        gathered = map processGroup groups
        results = map minimum $ concat $ gathered
    in
        print $ snd $ head results