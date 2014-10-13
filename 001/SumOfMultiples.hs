{-# LANGUAGE ViewPatterns #-}
module SumOfMultiples where
--expected answer
--Prelude> let x = 333*334/2 * 3
--Prelude> let y = 200*201/2 * 5
--Prelude> let z = 66*67/2 * 15
--Prelude> floor $ x+y-z
--234168

sigma :: Integer -> Integer
sigma (fromIntegral -> n) = floor $ n*(n+1)/2
          
sigma' :: Integer -> Integer
sigma' n = sum [1..n]

sigmaWithStep :: Integer -> Integer -> Integer
sigmaWithStep (fromIntegral -> n) (fromIntegral -> step)
  = (floor step) * (sigma $ floor $ n/step)

multiplesUntil ::Integer -> Integer -> [Integer]
multiplesUntil step bound = [x | x <- [step,step*2..bound-1]]

solution1 :: Integer -> Integer -> Integer -> Integer
solution1 n m x = sum (multiplesUntil n x) + sum (multiplesUntil m x) - sum (multiplesUntil (n*m) x)

solution2 :: Integer -> Integer -> Integer -> Integer
solution2 n m x = sum [i | i <- [1..x-1], mod i n == 0 || mod i m == 0]

solution3 :: Integer -> Integer -> Integer -> Integer
solution3 cap first second =
  sigmaWithStep cap first
  + sigmaWithStep cap second
  - sigmaWithStep cap (first * second) 
