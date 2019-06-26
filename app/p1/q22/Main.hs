module Main where

import Util (removeCharacters)
import Names (sumAlpha)
import Data.List.Split (splitOn)
import Data.List (sort)

main :: IO ()
main = do
    s <- readFile "data/22.txt"
    let noquote = removeCharacters "\"" s
    let names = splitOn "," noquote
    let sorted = sort names
    let scores = map (fromIntegral.sumAlpha) sorted :: [Integer]
    let scaledScores = zipWith (*) [1..] scores

    -- mapM_ print $ take 1000 $ zip3 [1..] sorted scores
    print $ sum scaledScores