module Main where

import Util (digitList)

main :: IO ()
main =
    let
        cap = 1000000
        digs = take cap $ concat $ map digitList [1..]
        targets = takeWhile (<cap) $ map (\x -> x-1) $ iterate (*10) 1
        results = map (digs!!) targets
    in
        print $ product results