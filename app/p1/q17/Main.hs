module Main where

import Data.HashMap.Strict (HashMap, fromList, (!))
import Util (removeCharacters)

main :: IO()
main =
    let
        lines = map toWords [1..1000]
        stripped = map (removeCharacters " ") lines
        lengths = map length stripped
    in
        print $ sum lengths

onesMap :: HashMap Integer String
onesMap = Data.HashMap.Strict.fromList [
    (0, ""),
    (1, "one"),
    (2, "two"),
    (3, "three"),
    (4, "four"),
    (5, "five"),
    (6, "six"),
    (7, "seven"),
    (8, "eight"),
    (9, "nine"),

    (10, "ten"),
    (11, "eleven"),
    (12, "twelve"),
    (13, "thirteen"),
    (14, "fourteen"),
    (15, "fifteen"),
    (16, "sixteen"),
    (17, "seventeen"),
    (18, "eighteen"),
    (19, "nineteen")]

tensMap :: HashMap Integer String
tensMap = Data.HashMap.Strict.fromList [
    (2, "twenty"),
    (3, "thirty"),
    (4, "forty"),
    (5, "fifty"),
    (6, "sixty"),
    (7, "seventy"),
    (8, "eighty"),
    (9, "ninety")]

toWords value
    | value == 1000 = "one thousand"
    | value >= 100 =
        let
            hundreds = value `div` 100
            remain = value `mod` 100
            out = (onesMap ! hundreds) ++ " hundred"
        in
            if remain == 0
                then out
                else out ++ " and " ++ toWords remain
    | value >= 20 =
        let
            tens = value `div` 10
            remain = value `mod` 10
            out = (tensMap ! tens)
        in
            if remain == 0
                then out
                else out ++ " " ++ (onesMap ! remain)
    | otherwise = onesMap ! value