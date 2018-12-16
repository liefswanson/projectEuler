module Util (
    palindrome,
    runLength,
    none,
    takeWhileInclude,
    removeCharacters,
    maxPathSum,
    runningTotal,
    removeDuplicates,
    digits,
) where

import Data.Set (toList, fromList)
import Data.List(delete)

digits :: Integral a => a -> Int
digits = length.show.toInteger

none :: (a -> Bool) -> [a] -> Bool
none fn = not.(any fn)

palindrome :: String -> Bool
palindrome s = s == reverse s

runLength :: (Eq a) => [a] -> [(a,Int)]
runLength [] = []
runLength (x:xs) =
    let
        (match, remaining) = span (== x) xs
        count = length match + 1
    in
        (x, count) : runLength remaining

takeWhileInclude :: (a -> Bool) -> [a] -> [a]
takeWhileInclude fn [] = []
takeWhileInclude fn (x:items) =
    if fn x
        then x:takeWhileInclude fn items
        else [x]

removeCharacters :: String -> String -> String
removeCharacters values str = filter (\c -> not (c `elem` values)) str

maxPathSum :: [[Int]] -> Int
maxPathSum (x:xs) =
    let
        combine acc curr = zipWith (+) curr $ zipWith max acc (tail acc)
    in
        head $ foldl combine x xs

runningTotal :: Num a => [a] -> [a]
runningTotal = scanl1 (+)

removeDuplicates :: (Ord a) => [a] -> [a]
removeDuplicates = toList.fromList
