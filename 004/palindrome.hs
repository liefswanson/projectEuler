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

module Palindrome where
import Data.List

palindrome :: String -> Bool
palindrome x = x == reverse x

compositePalindrome :: (Integer,Integer) -> Integer
compositePalindrome (left,right)
  | isPalindrome = composite
  | not isPalindrome = -1
  where
        isPalindrome = palindrome (show composite)
        composite = left*right
        
palindromes :: Integer -> [((Integer, Integer), Integer)]
palindromes x = [((left,right), compositePalindrome(left,right)) | left <- [x,x-1 .. ninetyPercentX], right <- [x,x-1 .. ninetyPercentX], compositePalindrome(left,right) /= -1]
  where
    ninetyPercentX = floor (fromIntegral x*9/10) 
    
ordering (_, a) (_, b)
  | a < b = LT
  | otherwise = GT
                
orderedPalindromes :: Integer -> [((Integer, Integer), Integer)]
orderedPalindromes x = sortBy ordering $! palindromes x

-- attempt to find the answer faster, does not work currently
-- this would only work if the number in question was a palindromic square
-- as of now it is unsatisfactory
largestPalindromeWIP :: (Integer,Integer) -> ((Integer, Integer), Integer)
largestPalindromeWIP (x,y)
  | composite /= -1 = ((x,y), composite)
  | otherwise = largestPalindromeWIP (y-1,x)
  where
    composite = compositePalindrome (x,y) 
