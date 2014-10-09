{-# LANGUAGE ViewPatterns #-}
module SumOfMultiples where
--expected answer
--Prelude> let x = 333*334/2 * 3
--Prelude> let y = 200*201/2 * 5
--Prelude> let z = 66*67/2 * 15
--Prelude> floor $ x+y-z
--234168

sigma :: (Integral a) => a -> a
sigma (fromIntegral -> n) = floor $ n*(n+1)/2
          
sigma' :: (Integral a) => a -> a
sigma' n = sum [1..n]

sigmaWithStep :: (Integral a) => a -> a -> a 
sigmaWithStep (fromIntegral -> n) (fromIntegral -> step)
  = floor step * (sigma $ floor $ n/step)

multiplesUntil :: Integral a => a -> a -> [a]
multiplesUntil step bound = [x | x <- [step,step*2..bound-1]]

solution1 :: Integral a => a -> a -> a -> a 
solution1 n m x = sum (multiplesUntil n x) + sum (multiplesUntil m x) - sum (multiplesUntil (n*m) x)

solution2 :: (Integral a) => a -> a -> a -> a
solution2 n m x = sum [i | i <- [1..x-1], mod i n == 0 || mod i m == 0]

solution3 :: (Integral a) => a -> a -> a -> a
solution3 cap first second =
  sigmaWithStep cap first
  + sigmaWithStep cap second
  - sigmaWithStep cap (first * second) 
