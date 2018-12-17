module DynamicProgramming (
    naiveCoins,
    fastCoins,
    addCoin,
    britishCurrency
) where

import Data.Function (fix)

britishCurrency :: [Int]
britishCurrency = [1,2,5, 10,20,50, 100,200]

naiveCoins :: [Int] -> Int -> Int
naiveCoins _ 0 = 1
naiveCoins [] _ = 0
naiveCoins (c:coins) x = sum $ [naiveCoins coins x-(n*c) | n <- [0.. x `div` c]]


fastCoins :: Integral a => [Int] -> [a]
fastCoins coins = foldr addCoin (1 : repeat 0) coins

addCoin :: Integral a => Int -> [a] -> [a]
addCoin c oldCache = newCache
    where newCache = small ++ zipWith (+) newCache toChange
          (small, toChange) = splitAt c oldCache
