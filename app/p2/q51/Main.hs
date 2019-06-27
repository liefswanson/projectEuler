module Main where

import Primes (primeSequence, prime)
import Binary (buildIsolationMask)
import Data.List (groupBy, maximumBy)
import Util (digits, digitList, removeDuplicates, digitsToInt)

familySize = 8

-- processGroup :: HashSet Integer -> HashSet Integer -> [Integer] -> [(Integer, Integer)] --, [[Integer]])]
findFamiliesOf x = (y, x, filtered)
    where
        y = fromIntegral.maximum $ map length filtered

        digs = digitList x
        digitsToMask = [0..10 - familySize]
        masks = zipWith buildIsolationMask digitsToMask $ repeat digs

        digitsToCheck = [0..9]

        results = map (replaceAll digitsToCheck digs) masks

        asNums = map (map (fromIntegral.digitsToInt)) results

        filters n = n >= x && prime n
        filtered = map ((filter filters).removeDuplicates) asNums

replacer a b t = if t then a else b
replace a bs ts = zipWith (replacer a) bs ts
replaceAll as d mask = zipWith3 replace as (repeat d) (repeat mask)

main :: IO ()
main =
    let
        processed = map findFamiliesOf primeSequence

        families = filter (\(a,_,_) -> a >= familySize) processed
        stripDebugInfo = map (\(_,b,_) -> b) families

        firstResult = head stripDebugInfo
    in
        print firstResult