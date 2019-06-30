module Main where

import Util (reverseIntegral, palindrome, digitList, takeWhileInclude)

cutoff = 53
n = 10^4

lychrelIteration n = n + (reverseIntegral n)


isNotLychrel n = any (palindrome.digitList) $ lychrelHelper n

lychrelHelper n = take cutoff $ tail $ iterate lychrelIteration n

lychrelDebug n = takeWhileInclude (not.palindrome.digitList) $ lychrelHelper n

main :: IO ()
main =
    let
        candidates = [1..n]
        results = filter (not.isNotLychrel) candidates
    in
        print $ length results