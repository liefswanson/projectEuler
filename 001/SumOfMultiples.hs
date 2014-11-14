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

{-# LANGUAGE ViewPatterns #-}
module SumOfMultiples where
--expected answer
--Prelude> let x = 333*334/2 * 3
--Prelude> let y = 200*201/2 * 5
--Prelude> let z = 66*67/2 * 15
--Prelude> floor $ x+y-z
--234168

sigma :: Integer -> Integer
sigma (fromIntegral -> n) =  n*(n+1) `div` 2
          
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
