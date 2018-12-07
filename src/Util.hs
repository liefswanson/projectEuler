module Util (
    palindrome,
    runLength,
    none
) where


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
