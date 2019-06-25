module Main where

import Data.List (permutations)
import Primes (divides)
import Util (digitsToInt, removeDuplicates)
import Data.Char (digitToInt)



main :: IO ()
main = reverseSearch

-- 1
-- p1 != 0
--   2 3 4
-- 2 divides p4
--     3 4 5
-- 3 divides (p3 + p4 + p5)
--       4 5 6
-- p6 == 0 or 5
--         5 6 7
--           6 7 8
--             7 8 9
--               8 9 10

prepend0 s = if l < 3 then prep ++ s else s
    where
        l = length s
        prep = take (3 - l) $ repeat '0'

noDuplicates n = a == b
    where
        a = length n
        b = length $ removeDuplicates n

overlaps x y =  all id zipped
    where
        zipped = zipWith (==) (tail x) (init y)

tryToConcat x ys = map (\(a:_,b) -> a:b) valid
    where
        candidates = zip (repeat x) ys
        valid = filter (\(a,b) -> overlaps a b) candidates

combine xs ys = filter noDuplicates results
        where
            results = concat $ zipWith tryToConcat xs $ repeat ys

applyOptions ops applyTo = filter noDuplicates $ concat results
    where
        helper options xs = zipWith (:) options $ repeat xs
        results = zipWith helper (repeat ops) applyTo


reverseSearch :: IO ()
reverseSearch =
    let
        multsOf n = [n, n*2 .. 999]
        convert = prepend0.show
        [d7,d11,d13,d17] = map (filter noDuplicates) candidates
            where
                candidates = map convertAll $ map multsOf [7,11,13,17]
                convertAll = map convert

        divs5 x = x == '5' || x == '0'
        d7' = filter (\[_,x,_] -> divs5 x) d7
        d11' = filter (\[x,_,_] -> divs5 x) d11

        combined = foldr combine d17 [d7',d11',d13]

        d2 = applyOptions "02468" combined

        divs3 xs = divides 3 top3
            where
                top3 = sum $ take 3 xs'
                xs' = map digitToInt xs

        d3 = filter divs3 $ applyOptions ['0' .. '9'] d2
        temp = applyOptions ['0' .. '9'] d3
        candidates = applyOptions ['1' .. '9'] temp -- can't start with 0
        results = map read candidates :: [Integer]
    in
        print $ sum results

--    1 2 3 4 5 6 7 8 9 10
check [z,_,a,b,c,d,e,f,g,h] =
    let
        check0 = z /= 0
        check2 = even b
        check3 = 3 `divides` (a + b + c)
        check5 = d == 5 || d == 0
        partsToCheck = map digitsToInt [
                        [c,d,e],
                        [d,e,f],
                        [e,f,g],
                        [f,g,h]
                    ]
        checks = zipWith divides [7, 11, 13, 17] partsToCheck
    in
        all id $ check0:check2:check3:check5:checks

brute :: IO ()
brute =
    let
        candidates = permutations [0..9]
        valid = filter check candidates
        results = map digitsToInt valid
    in
        print $ sum results