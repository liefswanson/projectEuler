module SmallestMultiple where

-- This was found by taking the prime factors of every numbre from [1..20]
-- then taking the union of the sets with only as many repetitions as required to make each non-prime
expectedValue :: Integer
expectedValue = product [2,2,2,2,3,3,5,7,11,13,17,19]
