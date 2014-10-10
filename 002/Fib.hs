--module Fib where

main :: IO ()
main = print (take 40 fibs)

-- bad example of a function which generates fibonacci numbers
-- a really bad example
dumdFib :: Integer -> Integer
dumdFib 0 = 0
dumdFib 1 = 1
dumdFib n = dumdFib(n-1) + dumdFib(n-2)


-- Binet's formula for fibonacci numbers
fib :: Integer -> Integer
fib n = round $ phi ** fromIntegral n / sq5
  where
    sq5 = sqrt 5 :: Double
    phi = (1+sq5) / 2  

-- generates an infinite list of primes
fibs :: [Integer]
fibs = 1 : 2 : zipWith (+) fibs (tail fibs)

-- generates an infinite list of primes... much faster, like much faster
fibs' :: [Integer]
fibs' = map fst $ iterate (\(a,b) -> (b,a+b)) (1,2)

-- might be a smarter way to pull the correct number of places from fibs'?
solution :: Integer -> Integer
solution n = sum . filter even . takeWhile (< n) $ fibs'

