module Spiral (
    asSpiral,
    getDiagonals,
    getCornerIndexes
) where

import Util (partitionBy, everyNth, runningTotal)

asSpiral :: [a] -> [[a]]
asSpiral xs =
    let
        sqrs = map (^2) [1,3..] -- only odd numbers because every square is of odd diameter
        partSizes = zipWith (-) sqrs $ 0:sqrs
    in
        partitionBy partSizes xs


getDiagonals :: [a] -> [a]
getDiagonals ring = everyNth nth $ reverse ring
    where nth = (length ring) `div` 4


getCornerIndexes :: [[Integer]]
getCornerIndexes = [1]:zipWith make4 sqrs idxs
    where
        sqrs = map (^2) [1,3..]
        idxs = [2,4..]
        make4 start step = take 4 [start+step, start+step+step ..]