module Main where

import Util(maxPathSum)

main :: IO ()
main = do
    s <- readFile "data/18.txt"
    let l = lines s
    let w = map words l
    let nums = map (map read) w :: [[Int]]
    let reversed = reverse nums
    print $ maxPathSum reversed