module Primes (
    primeSequence,
    primeFactors,
    prime,
    divides,
    mergeFactorLists,
    multiplyFactorList,
    countDivisors,
) where

import Util (none, runLength)

divides :: Integral a => a -> a -> Bool
divides a b = b `mod` a == 0

prime :: Integer -> Bool
prime n =
    let
        upper          = floor.sqrt $ fromIntegral n
        smallPrimes    = takeWhile (<= upper) primeSequence
    in
        none (`divides` n) smallPrimes

primeSequence :: [Integer]
primeSequence = 2:filter prime [3,5 ..]

primeFactors :: Integer -> [Integer]
primeFactors n
    | n == 0 = []
    | n < 0  = -1:primeFactors(-n)
    | otherwise = primeFactorsHelper [2..] n


primeFactorsHelper :: [Integer] -> Integer -> [Integer]
primeFactorsHelper _ 1 = []
primeFactorsHelper candidates n =
    let
        divisor   = head $ filter (`divides` n) candidates
        remaining = n `div` divisor
    in
        divisor : primeFactorsHelper [divisor..] remaining

mergeFactorLists :: [(Integer, Int)] -> [(Integer, Int)] -> [(Integer,Int)]
mergeFactorLists as [] = as
mergeFactorLists [] bs = bs
mergeFactorLists ((a, ax):as) ((b, bx):bs)
    | a == b    = (a, max ax bx) : mergeFactorLists as bs
    | a < b     = (a, ax) : mergeFactorLists as ((b,bx):bs)
    | otherwise = (b, bx) : mergeFactorLists ((a,ax):as) bs

multiplyFactorList :: [(Integer, Int)] -> Integer
multiplyFactorList items =
    let
        accumulator tally (base,exp) = tally * base^exp
    in
        foldl accumulator 1 items

countDivisors :: Integer -> Integer
countDivisors n =
    let
        factorize = runLength.primeFactors
        exps = map snd $ factorize n
        choices = map (+1) exps
    in
        product $ map fromIntegral choices