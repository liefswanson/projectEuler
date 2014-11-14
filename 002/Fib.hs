--Copyright (C) 2014 Lief Swanson

--This program is free software; you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation; either version 2 of the License, or
--(at your option) any later version.

--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--GNU General Public License for more details.

--You should have received a copy of the GNU General Public License
--along with this program; if not, write to the Free Software
--Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

--Author: Lief Swanson
--URL: https://github.com/liefswanson


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

