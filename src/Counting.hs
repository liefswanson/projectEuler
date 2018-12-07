module Counting (
    factorial,
    choose,
    sumToN,
    fibonacciSequence,
) where

factorial :: (Integral a)  => a -> a
factorial n = product [1..n]

choose :: (Integral a) => a -> a -> a
choose n k
    | n < 0     = error "Choose n k, where n < 0 is unimplemented."
    | n == 0    = 0
    | n < k     = 0
    | k < 0     = 0
    | otherwise = product [k+1 .. n] `div` product [1 .. (n-k)]

sumToN :: (Integral a) => a -> a
sumToN n = n*(n+1) `div` 2

fibonacciSequence :: [Integer]
fibonacciSequence = 0:1:zipWith (+) fibonacciSequence (tail fibonacciSequence)
