module Main where

import Dates (Day(..), yearToDays)

main :: IO ()
main =
    let
        start = 1900
        end   = 2000
        range = [start+1..end]

        startingYear = reverse $ yearToDays start Monday

        firstOfMonths = foldl iterateOverYears [startingYear] range

        excludeExtraYear = init firstOfMonths
        removeFirstOfNextMonth = map init excludeExtraYear
        sundays = filter (== Sunday) $ concat removeFirstOfNextMonth
    in
        -- mapM_ print $ zip (1900:range) $ reverse $ map reverse firstOfMonths
        -- mapM_ print $ zip range $ reverse $ map reverse excludeExtraYear
        -- mapM_ print $ zip range $ reverse $ map reverse removeFirstOfNextMonth
        print $ length sundays

iterateOverYears previousYears year =
    let
        startDay = head $ head previousYears
        thisYear = reverse $ yearToDays year startDay
    in
        thisYear:previousYears
