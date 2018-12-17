module Main where

import Data.HashSet (member, insert, HashSet, empty)
import Util (takeWhileInclude)


main :: IO ()
main =
    let
        upper = 1000 - 1
        range = [1..upper]
        results = map (longDivideUntilRepeat 10 1) range
        lengths = map length results
        indexed = zip lengths range
        (_, longest) = maximum indexed
    in
        print longest


longDivideUntilRepeat :: Int -> Int -> Int -> [(Int, Int)]
longDivideUntilRepeat base top bottom = longDivideUntilRepeatHelper base empty [] top bottom

longDivideUntilRepeatHelper :: Int -> HashSet (Int, Int) -> [(Int, Int)] -> Int -> Int -> [(Int, Int)]
longDivideUntilRepeatHelper base hashes history top bottom =
    let
        pair = (top*base) `divMod` bottom
        r = snd pair
        cycleDetected = pair `member` hashes
        hashes' = insert pair hashes
        history' = pair:history
    in
        if cycleDetected
            then reverse $ takeWhileInclude (/=pair) history
            else longDivideUntilRepeatHelper base hashes' history' r bottom
