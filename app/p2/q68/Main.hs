module Main where

import Data.List (permutations)
import Util (concatInts)


--           1,2,3,4,5,6,7,8,9,10
buildAnswer [a,b,c,d,e,f,g,h,i,j] = concatInts.concat $ r ++ l
    where
-- if the creation of "items" is generalized properly
-- then this should work for N-gons, not just 5-gons
        items = [
                [a,f,g],
                [b,g,h],
                [c,h,i],
                [d,i,j],
                [e,j,f]
            ]
        mini = minimum items
        (l,r) = span (/= mini) items

check [a,b,c,d,e,f,g,h,i,j] = all (==l) r
    where
        items = [
                [a,f,g],
                [b,g,h],
                [c,h,i],
                [d,i,j],
                [e,j,f]
            ]
        l:r = map sum items

main :: IO ()
main =
    let
        -- we know that the largest numbers are in the outer ring
        -- because the smallest number in the outer ring must come first
        -- therefore, we want to maximize this value
        -- by placing all the largest numbers in the outer ring
        candidates = map (10:) [a ++ b | a <- permutations [6..9],
                                         b <- permutations [1..5]]
        filtered = filter check candidates -- should only be two left at this point
        results = map buildAnswer filtered
    in
        print $ maximum results