module Pytrips where

gentrips :: Integer -> [(Integer,Integer,Integer)]
gentrips n = [(a,b,fpythag a b) |
              a <- [1..halfn],
              b <- [a+1..halfn],
              fpythag a b == cpythag a b,
              a + b + fpythag a b == n]
  where
    halfnf = fromIntegral(n)/2 :: Double
    halfn = floor(halfnf) :: Integer

fpythag :: Integer -> Integer -> Integer
fpythag a b = floor $ pythag a b

cpythag :: Integer -> Integer -> Integer
cpythag a b = ceiling $ pythag a b

`pythag :: Integer -> Integer -> Double
pythag a b = sqrt( fromIntegral (a^2) + fromIntegral (b^2) )
