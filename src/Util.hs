module Util (
    palindrome,
    runLength,
    none,
    greatest,
    takeWhileInclude
) where

greatest :: Ord a => [a] -> a
greatest (x:items) = foldl max x items

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