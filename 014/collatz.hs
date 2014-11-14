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

import System.Environment
import Data.List

main :: IO()
main = do
  args <- getArgs
  let n = read $ head args :: Int
  let collatzSeqs = maxCollatzSequences n
      
  let len = maximum collatzSeqs
  let index = head $ elemIndices len collatzSeqs

  let val = 2*index+1 -- we only checked odd numbers, so compensate index to appropriate value
  putStrLn $ show (len,val)
  putStrLn $ show $ genCollatz val

--TODO find some way to reduce the distance to the lower bound of the list from n
maxCollatzSequences :: Int -> [Int]
maxCollatzSequences n = map length $ map genCollatz [1,3..n]

genCollatz :: Int -> [Int]
genCollatz 1 = [1]
genCollatz n = n : genCollatz (collatz n) 

collatz :: Int -> Int
collatz n =
  if even n
  then div n 2
  else 3*n+1

