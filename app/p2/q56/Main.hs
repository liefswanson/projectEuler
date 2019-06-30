module Main where

import Util (digitList)

main :: IO ()
main = print $ maximum [helper a b | a <- [1..100], b <- [1..100]]
    where
        helper x y = sum $ digitList $ x^y