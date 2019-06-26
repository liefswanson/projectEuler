module Main where

import Counting (triangleSequence)
import Util (splitOn)
import Data.Char (ord, toLower, isAlpha)
import Data.HashSet (HashSet, fromList, member)


encode n =
    let
        lower = ord 'a' - 1
        ascii = map ord $ map toLower n
        positions = map (\x -> x - lower) ascii
    in
        sum positions

clean n = filter isAlpha n

main :: IO ()
main = do
    s <- readFile "data/42.txt"
    let w = map clean $ splitOn ',' s
    let encodings = map encode w
    let upper = maximum encodings
    let tris = fromList $ takeWhile (<=upper) $ map fromIntegral triangleSequence
    print $ length $ filter (\(a,b) -> b `member` tris) $ zip w encodings
