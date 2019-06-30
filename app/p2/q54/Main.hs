module Main where

import Cards (stringToCard, makePokerHand, cardToString, shortShow, getTestResults)
import Data.List (sort)


deal (l, r) = (makePokerHand (c0,c1,c2,c3,c4), makePokerHand (c5,c6,c7,c8,c9))
    where
        cards = l ++ r
        [c0,c1,c2,c3,c4,c5,c6,c7,c8,c9] = map stringToCard cards

showDeal (left,right) = (convert left, convert right)
    where
        convert = map cardToString

pretty (left, right) = (shortShow left, compare left right, shortShow right)

main :: IO ()
main =
    do
        s <- readFile "data/54.txt"
        let ls = lines s
        let cards = map ((splitAt 5).words) ls
        let deals = map deal cards
        let results = filter (\((left, right)) -> left > right) deals
        print $ length results