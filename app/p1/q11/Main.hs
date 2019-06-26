module Main where

import Data.Vector (Vector, fromList, (!))

main :: IO ()
main = do
    s <- readFile "data/11.txt"
    let seqLen = 4

    let l = lines s
    let w = map words l
    let vals = map (map read) w :: [[Int]]
    let grid = fromList $ map (fromList) vals

    let rows = length vals
    let cols = length (head vals)

    -- down, right, diagonal
    let iter = [(row, col) | row <- [0..rows-seqLen],
                             col <- [0..cols-seqLen]]
    let fn tuple = maxSeq grid tuple seqLen
    let results = concat $ map fn iter

    -- back diagonal
    let iter2 = [(row, col) | row <- [seqLen..rows-1],
                              col <- [0..cols-seqLen]]
    let fn2 tuple = maxSeq2 grid tuple seqLen
    let results2 = map fn2 iter2

    let final = results2 ++ results
    print $ maximum $ map product final

-- back diagonal
maxSeq2 :: Vector(Vector(Int)) -> (Int,Int) -> Int -> [Int]
maxSeq2 grid tuple n =
    let
        access (row, col) = grid ! row ! col
        results = map access $ extendDiagBack tuple n
    in
        results

-- down, right, diagonal
maxSeq :: Vector(Vector(Int)) -> (Int,Int) -> Int -> [[Int]]
maxSeq grid tuple n =
    let
        down  = extendDown  tuple n
        right = extendRight tuple n
        diag  = extendDiag  tuple n

        access (row,col) = grid ! row ! col

        options = [down, right, diag]
        sequences = map (map access) options
    in
        sequences

extend :: (Int, Int) -> (Int, Int) -> Int -> [(Int,Int)]
extend (x,y) (dx,dy) n =
    let
        it = [0..n-1]
        fn i = (x + i*dx, y + i*dy)
    in
        map fn it

extendDown  tuple n = extend tuple (1, 0) n
extendRight tuple n = extend tuple (0, 1) n
extendDiag  tuple n = extend tuple (1, 1) n
-- uses different indexing, and will break if used in conjunction with other 3 methods
extendDiagBack tuple n = extend tuple (-1, 1) n
