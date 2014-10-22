module Pytrips where

gentrips :: Integer -> [(Integer,Integer,Integer)]
gentrips n = [(a,b,trunpythag a b) |
              a <- [1..halfn],
              b <- [a+1..halfn],
              (trunpythag a b)^2 == a^2 + b^2,
              a + b + trunpythag a b == n]
  where
    halfnd = fromIntegral(n)/2 :: Double
    halfn = floor(halfnd) :: Integer

trunpythag :: Integer -> Integer -> Integer
trunpythag a b = truncate $ pythag a b

pythag :: Integer -> Integer -> Double
pythag a b = sqrt( fromIntegral (a^2) + fromIntegral (b^2) )

solution :: Integer -> [Integer]
solution n = [a*b*c | (a,b,c) <- gentrips n]
