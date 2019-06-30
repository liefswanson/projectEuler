module Counting (
    factorial,
    choose,
    combinations,
    circularPermutations,
    sumToN,
    isPerfectSquare,
    fibonacciSequence,
    triangleSequence,
    squareSequence,
    pentagonalSequence,
    hexagonalSequence,
    heptagonalSequence,
    octagonalSequence,
    isTriangular,
    isPentagonal,
    isHexagonal
) where

import Util (isqrt)
import Data.List (tails, permutations)

factorial :: (Integral a)  => a -> a
factorial n = product [1..n]

choose :: (Integral a) => a -> a -> a
choose n k
    | n < 0     = error "Choose n k, where n < 0 is unimplemented."
    | n == 0    = 0
    | n < k     = 0
    | k < 0     = 0
    | 2*k < n   = choose n (n-k)
    | otherwise = product [k+1 .. n] `div` product [1 .. (n-k)]

combinations :: Int -> [a] -> [[a]]
combinations 0 _  = [ [] ]
combinations n xs = [ y:ys | y:xs' <- tails xs,
                             ys <- combinations (n-1) xs']

circularPermutations:: [a] -> [[a]]
circularPermutations [] = []
circularPermutations (x:xs) = map (x:) $ permutations xs

sumToN :: (Integral a) => a -> a
sumToN n = n*(n+1) `div` 2

isPerfectSquare :: Integral a => a -> Bool
isPerfectSquare n = n == (isqrt n)^2

fibonacciSequence :: [Integer]
fibonacciSequence = 0:1:zipWith (+) fibonacciSequence (tail fibonacciSequence)

triangleSequence :: [Integer]
triangleSequence = ngonSequenceHelper 0 0 (\x -> x+1)

squareSequence :: [Integer]
squareSequence = ngonSequenceHelper 0 0 (\x -> 2*x+1)

pentagonalSequence :: [Integer]
pentagonalSequence = ngonSequenceHelper 0 0 (\x -> 3*x+1)

hexagonalSequence :: [Integer]
hexagonalSequence = ngonSequenceHelper 0 0 (\x -> 4*x+1)

heptagonalSequence :: [Integer]
heptagonalSequence = ngonSequenceHelper 0 0 (\x -> 5*x+1)

octagonalSequence :: [Integer]
octagonalSequence = ngonSequenceHelper 0 0 (\x -> 6*x+1)

ngonSequenceHelper :: Integer -> Integer -> (Integer -> Integer) -> [Integer]
ngonSequenceHelper count idx mapper =
    let
        count' = count + mapper idx
        idx' = idx + 1
    in
        count': ngonSequenceHelper count' idx' mapper

isPentagonal :: Integral a => a -> Bool
isPentagonal x = isNgon x 6 (\n-> 24*n+1)

isTriangular :: Integral a => a -> Bool
isTriangular x = isNgon x 2 (\n-> 8*n+1)

isHexagonal :: Integral a => a -> Bool
isHexagonal x = isNgon x 4 (\n-> 8*n+1)

isNgon :: Integral a => a -> a -> (a -> a) -> Bool
isNgon x d mapper = firstCheck && secondCheck
    where
        underRoot = mapper x
        rooted = isqrt underRoot
        firstCheck = rooted^2 == underRoot
        secondCheck = (rooted+1) `mod` d == 0