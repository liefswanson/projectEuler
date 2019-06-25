module Main where

import Counting (isPentagonal, pentagonalSequence)

checkPair x y = (check, d)
    where
        check = isPentagonal z && isPentagonal d
        z = x-y
        d = abs (y-z)

checkFor x candidates = zipWith checkPair (repeat x) $ takeWhile (<= (x`div`2)) candidates

brute =
    let
        candidates = concat $ zipWith checkFor pentagonalSequence $ repeat pentagonalSequence
        result = head $ filter fst candidates
    in
        print $ snd result

main :: IO ()
main = brute
