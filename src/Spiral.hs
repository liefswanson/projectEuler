module Spiral (
    asSpiral,
    getDiagonals
) where

import Util (partitionBy, everyNth)

asSpiral :: [a] -> [[a]]
asSpiral xs =
    let
        sqrs = map (^2) [1,3..] -- only odd numbers because every square is of odd diameter
        partSizes = zipWith (-) sqrs (0:sqrs)
    in
        partitionBy partSizes xs


getDiagonals :: [a] -> [a]
getDiagonals ring = everyNth nth $ reverse ring
    where nth = (length ring) `div` 4