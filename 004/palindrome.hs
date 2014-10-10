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
