module SumOfMultiples where
--expected answer
--Prelude> let x = 333*334/2 * 3
--Prelude> let y = 200*201/2 * 5
--Prelude> let z = 66*67/2 * 15
--Prelude> floor $ x+y-z
--234168

sumUntil :: Fractional a => a -> a
sumUntil n = n*(n+1)/2

--sumUntilStep :: (Num a, Fractional b) => a -> a -> b
sumUntilStep n x = sumUntil  (floor (n/x)) 

--function for generating a list of multiples of a number n
multiples :: Integral a => a -> [a]
multiples n = [x | x <- [n,n*2..]]

multiplesUntil :: Integral a => a -> a -> [a]
multiplesUntil n m = [x | x <- [n,n*2..m-1]]

--combine lists of multiples of 3 and 5, then subtract list of multiples of 15

solution1 n m x = sum (multiplesUntil n x) + sum (multiplesUntil m x) - sum (multiplesUntil (n*m) x)

solution2 :: (Integral a) => a -> a -> a -> a
solution2 n m x = sum [i | i <- [1..x-1], mod i n == 0 || mod i m == 0]

--solution3 :: (RealFrac b) => b -> b -> b -> b
--solution3 n m x = (sumUntilStep n x) + (sumUntilStep m x) - (sumUntilStep (n*m) x)
