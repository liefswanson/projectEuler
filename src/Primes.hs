module Primes (
    primeSequence,
    primeFactors,
    prime,
    prime',
    divides,
    mergeFactorLists,
    multiplyFactorList,
    countDivisors,
    listDivisorsSlow,
    listDivisorsBrute,
    listDivisors,
    isAmicable,
    isPerfect,
    isAbundant,
    isDeficient,

) where

import Util (none, runLength, removeDuplicates, digits)
import Sets (powerset)
import Data.List (sort)

divides :: Integral a => a -> a -> Bool
divides a b = b `mod` a == 0

prime' :: Integral a => a -> Bool
prime' n = n > 1 && primeCheck
    where
        primeCheck = none (`divides` n) $ 2:[3,5..upper]
        upper = floor.sqrt $ fromIntegral n

prime :: Integer -> Bool
prime n =
    let
        upper          = floor.sqrt $ fromIntegral n
        smallPrimes    = takeWhile (<= upper) primeSequence
    in
        n > 1 && none (`divides` n) smallPrimes

primeSequence :: [Integer]
primeSequence = 2:filter prime [3,5 ..]

primeFactors :: Integral a => a -> [a]
primeFactors n
    | n == 0 = []
    | n < 0  = -1:primeFactors (-n)
    | otherwise = primeFactorsHelper (map fromIntegral [2..]) n

primeFactorsHelper :: Integral a => [a] -> a -> [a]
primeFactorsHelper _ 1 = []
primeFactorsHelper (p:primes) n =
    if p*p > n
    then [n]
    else if p `divides` n
        then p:primeFactorsHelper (p:primes) (n `div` p)
        else primeFactorsHelper primes n

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

listDivisorsSlow :: Integer -> [Integer]
listDivisorsSlow n =
    let
        primes = primeFactors n
        possible = map product $ powerset primes
    in
        removeDuplicates possible

listDivisors :: Integer -> [Integer]
listDivisors n =
    let
        primes = runLength $ primeFactors n
        divisorOptions = map (map (\(base,exp) -> base^exp)) $ map options primes
        divisors = sequence divisorOptions
    in
        map product divisors

-- can be MUCH faster in some cases
listDivisorsBrute :: Integer -> [Integer]
listDivisorsBrute n =
    let
        sqn = floor.sqrt $ fromIntegral n
        smaller = filter (`divides` n) [1..sqn]
        toMirror = if (sqn^2 == n)
                   then init smaller
                   else smaller
        larger = reverse $ map (n `div`) toMirror
    in
        smaller ++ larger

options :: (Integer, Int) -> [(Integer, Int)]
options (base, exp) = [(base, x) | x <- [0..exp]]

divisorSum :: Integer -> Integer
divisorSum = sum.init.sort.listDivisorsBrute

isAmicable :: Integer -> Bool
isAmicable n = n /= dual && n == dualDual
        where
            dual = divisorSum n
            dualDual = divisorSum dual

isPerfect :: Integer -> Bool
isPerfect n = divisorSum n == n

isAbundant :: Integer -> Bool
isAbundant n = divisorSum n > n

isDeficient :: Integer -> Bool
isDeficient n = divisorSum n < n