module Dates (
    daysInMonths,
    leapYear,
    yearToDays,
    Day(..),
    Month(..)
) where

import Primes(divides)
import Util(runningTotal)

data Day = Sunday
         | Monday
         | Tuesday
         | Wednesday
         | Thursday
         | Friday
         | Saturday
         deriving (Show, Enum, Bounded, Eq)

daysPerWeek = fromEnum (maxBound::Day) + 1

data Month = January
           | February
           | March
           | April
           | May
           | June
           | July
           | August
           | September
           | October
           | November
           | December
           deriving (Show, Enum, Bounded, Eq)

monthsPerYear = fromEnum (maxBound::Month) + 1

leapYear :: Int -> Bool
leapYear year =
    let
        quart = 4 `divides` year
        century = 100 `divides` year
        quartCentury = 400 `divides` year
    in
        quartCentury || quart && not century

daysIn :: Month -> Int -> Int
daysIn January _   = 31
daysIn February y  = if leapYear y
                        then 29
                        else 28
daysIn March _     = 31
daysIn April _     = 30
daysIn May _       = 31
daysIn June _      = 30
daysIn July _      = 31
daysIn August _    = 31
daysIn September _ = 30
daysIn October _   = 31
daysIn November _  = 30
daysIn December _  = 31

daysInMonths :: Int -> [Int]
daysInMonths year = zipWith3 ($) (repeat daysIn) [(minBound::Month)..] (repeat year)

yearToDays :: Int -> Day -> [Day]
yearToDays year start =
    let
        dayCounts = daysInMonths year
        position = fromEnum start
        running = runningTotal $ position:dayCounts
        weekRing = map (`mod` daysPerWeek) running
    in
        map toEnum weekRing :: [Day]