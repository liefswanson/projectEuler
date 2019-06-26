module Main where

import Util (palindrome)
import Data.List (sort)

main :: IO ()
main =
    let
        products = [x*y | x <- [100..999],
                          y <- [100..999]]
        palindromeNum n = palindrome $ show n
        palindromes = filter palindromeNum products
        largest = last $ sort palindromes
    in
        print largest
