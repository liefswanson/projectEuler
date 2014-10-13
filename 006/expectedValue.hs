{-# LANGUAGE ViewPatterns #-}
module ExpectedValue where
import SumOfMultiples

squareSum' :: Integer -> Integer
squareSum' n = (sum [1..n])^2

sumSquares' :: Integer -> Integer
sumSquares' n = sum [x^2 | x <- [1..n]]

squareSum :: Integer -> Integer
squareSum n = (sigma n)^2

-- algebraically incorrect
sumSquares :: Integer -> Integer
sumSquares (fromIntegral -> n)
  = (sigma $ floor $ sqrt n)^2

solution :: Integer -> Integer
solution n = squareSum' n - sumSquares' n

fastestSolution :: Integer -> Integer
fastestSolution n = squareSum n - sumSquares' n
