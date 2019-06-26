module Main where

import Util (digitList)
import Counting (factorial)

main :: IO ()
main =
    let
        nums = [10..factorial 10]
        digitFactorial = sum.(map factorial).digitList
        candidates = [(y-x, x) | x <- nums, let y = digitFactorial x]
        results = filter (\(a,_) -> a == 0) candidates
    in
        print $ sum $ map snd results
