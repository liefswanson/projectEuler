module Fib where

-- bad example of a function which generates fibonacci numbers
-- a really bad example
dumdFib :: Integral a => a -> a
dumdFib 0 = 0
dumdFib 1 = 1
dumdFib n = dumdFib(n-1) + dumdFib(n-2)


-- Binet's formula for fibonacci numbers
fib :: Integral a => a -> a
fib n = round $ phi ** fromIntegral n / sq5
  where
    sq5 = sqrt 5 :: Double
    phi = (1+sq5) / 2  

-- generates an infinite list of primes
fibs :: Integral a => [a]
fibs = 1 : 2 : zipWith (+) fibs (tail fibs)

-- generates an infinite list of primes... much faster, like much faster
fibs' :: Integral a => [a]
fibs' = map fst $ iterate (\(a,b) -> (b,a+b)) (1,2)

-- might be a smarter way to pull the correct number of places from fibs'?
solution :: Integral a => a -> a
solution n = sum . filter even . takeWhile (< n) $ fibs'
