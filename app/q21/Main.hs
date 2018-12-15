module Main where

import Primes (isAmicable)

main :: IO ()
main = do
    let amicables = filter isAmicable [1..10^4]
    print amicables
    print $ sum amicables