module Main where

import Data.List.Split (splitOn)
import Data.Char (ord, chr)
import Data.Bits (xor)

decode encoded password = map chr $ zipWith xor mask encoded
    where mask = concat $ repeat password

isValid decoding = "the" `elem` toCheck
    where
        toCheck = words decoding

answersummation text = sum $ map ord text

main :: IO ()
main = do
    s <- readFile "data/59.txt"
    let ascii = splitOn "," s
    let encoded = map read ascii :: [Int]
    let alpha = ['a'..'z']
    let passwords = [[a,b,c] | a <- alpha, b <- alpha, c <- alpha]
    let attempts = map (decode encoded) $ map (map ord) passwords
    let candidates = filter isValid attempts
    print $ answersummation $ head candidates