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
