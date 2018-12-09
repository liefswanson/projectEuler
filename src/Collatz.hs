module Collatz (
    collatzSequenceFrom,
) where

import Util (takeWhileInclude)

collatzSequenceFrom :: Integral a => a -> [a]
collatzSequenceFrom n = takeWhileInclude (/= 1) $ iterate collatz n

collatz n =
    if even n
        then n `div` 2
        else 3*n + 1