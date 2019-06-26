module Main where

main :: IO ()
main = do
    let n = 10
    s <- readFile "data/13.txt"
    let l = lines s
    let nums = map read l :: [Integer]
    let tally = sum nums
    let result = read $ take n $ show tally :: Int

    print result