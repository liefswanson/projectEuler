module Main where

import Primes (primeSequence)
import Data.List (sort, groupBy)
import Counting (combinations)
import Util (concatInts)

hasConstantDelta xs = all (== head deltas) deltas
    where
        deltas = zipWith (-) (tail xs) xs

main :: IO ()
main =
    let
        primes = takeWhile (<10000) $ dropWhile (<1000) primeSequence
        ordered = sort $ map (\a -> ((sort.show) a, a)) primes
        grouped = groupBy (\t s -> fst t == fst s) ordered
        candidates = map (map snd) $ filter (\x -> length x >= 3) grouped
        choose3 = map (combinations 3) candidates
        results = filter hasConstantDelta $ concat choose3
    in
        mapM_ print $ map concatInts results

