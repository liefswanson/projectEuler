module Main where

import Counting (fibonacciSequence)

main :: IO ()
main =
    let
        upper = 4*10^6
        fibs  = takeWhile (<= upper) fibonacciSequence
        evens = filter even fibs
    in
        putStrLn $ show $ sum evens