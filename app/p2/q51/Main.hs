module Main where

import Primes (primeSequence, prime, prime')
import Binary (stringsOfLength, buildIsolationMask)
import Data.HashSet (HashSet, fromList, member, union, toList)
import Data.List (groupBy, maximumBy)
import Util (digits, digitList, removeDuplicates, digitsToInt)

familySize = 8

-- processGroup :: HashSet Integer -> HashSet Integer -> [Integer] -> [(Integer, Integer)] --, [[Integer]])]
processItem primeSet x = (y, x, filtered)
    where
        y = fromIntegral.maximum $ map length filtered

        digs = digitList x
        bitMasks = zipWith buildIsolationMask [0..10 - familySize] $ repeat digs

        digitsToCheck = [0..9]

        results = map (replaceAll digitsToCheck digs) bitMasks

        asNums = map (map (fromIntegral.digitsToInt)) results

        filters n = n >= x && n `member` primeSet
        filtered = map ((filter filters).removeDuplicates) asNums

replacer a b t = if t then a else b
replace a bs ts = zipWith (replacer a) bs ts
replaceAll as d mask = zipWith3 replace as (repeat d) (repeat mask)

main :: IO ()
main =
    let
        n = 6
        upper = 10^n
        candidates = map fromIntegral $ takeWhile (<upper) primeSequence
        primeSet = fromList candidates :: HashSet Integer

        groups = groupBy (\a b -> digits a == digits b) $ dropWhile (<10) candidates
        processed = map (map (processItem primeSet)) groups

        families = map (filter (\(a,_,_) -> a >= familySize )) processed
        stripEmpty = filter (not.null) families
        stripDebugInfo = map (map (\(_,b,_) -> b)) stripEmpty

        firstResult = head $ concat stripDebugInfo
    in
        print firstResult