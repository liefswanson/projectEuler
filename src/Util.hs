module Util (
    palindrome,
    runLength,
    none,
    splitOn,
    takeWhileInclude,
    removeCharacters,
    maxPathSum,
    runningTotal,
    removeDuplicates,
    digits,
    digitList,
    digitsToInt,
    partitionBy,
    everyNth,
    rotateInteger,
    enumerateListRotations,
    enumerateIntegralRotations,
    decimalToBinary,
    concatInts,
    isPandigital,
    isPandigital10,
    truncateRight,
    truncateLeft,
    isqrt,
    sortedListDiff,
    iterativelyTake,
    reverseIntegral,
    withinRange,
    asList,
) where

import Data.Set (toList, fromList)
import Data.List (delete, sort, tails, splitAt)
import Data.Char (digitToInt)

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn delim s = splitHelper delim s []

splitHelper :: Eq a => a -> [a] -> [[a]] -> [[a]]
splitHelper _ [] result = reverse result
splitHelper delim s result =
    let
        condition x = x /= delim
        (l, r) = span condition s
        r' = if r == [] then [] else tail r
    in
        splitHelper delim r' $ l:result

everyNth :: Int -> [a] -> [a]
everyNth _ [] = []
everyNth n (x:xs) = x:everyNth n remaining
    where remaining = drop (n-1) xs

partitionBy :: [Int] -> [a] -> [[a]]
partitionBy _  [] = []
partitionBy [] xs = [xs]
partitionBy (size:sizes) xs = grouped:partitionBy sizes remaining
    where (grouped, remaining) = splitAt size xs

digits :: Integral a => a -> Int
digits = length.show.toInteger

digitList :: Integral a => a -> [a]
digitList = (map (fromIntegral.digitToInt)).show.toInteger

digitsToInt :: Integral a => [a] -> a
digitsToInt digs = sum $ zipWith (*) exps $ reverse digs
    where exps = iterate (*10) 1

reverseIntegral :: Integral a => a -> a
reverseIntegral = digitsToInt.reverse.digitList

rotateInteger :: Integral a => a -> a
rotateInteger n = r * 10 ^ (d-1) + q
    where d = (toInteger.digits) n
          (q, r) = n `divMod` 10

enumerateIntegralRotations :: Integral a => a -> [a]
enumerateIntegralRotations n = take d $ iterate rotateInteger n
    where d = digits n

enumerateListRotations :: [a] -> [[a]]
enumerateListRotations xs = map (recombineAt xs) [0..n-1]
    where
        recombineAt ys i = r ++ l
            where
                (l, r) = splitAt i ys
        n = length xs

none :: (a -> Bool) -> [a] -> Bool
none fn = not.(any fn)

decimalToBinary :: Integral a => a -> String
decimalToBinary n = map (\x-> if x then '1' else '0') bits
    where
        powers = reverse $ takeWhile (<=n) $ iterate (*2) 1
        folder (s, results) x = if x <= s
                                then (s-x, True:results)
                                else (s, False:results)
        bits = reverse $ snd $ foldl folder (n,[]) powers

palindrome :: Eq a => [a] -> Bool
palindrome s = s == reverse s

runLength :: (Eq a) => [a] -> [(a,Int)]
runLength [] = []
runLength (x:xs) =
    let
        (match, remaining) = span (== x) xs
        count = length match + 1
    in
        (x, count) : runLength remaining

takeWhileInclude :: (a -> Bool) -> [a] -> [a]
takeWhileInclude fn [] = []
takeWhileInclude fn (x:items) =
    if fn x
    then x:takeWhileInclude fn items
    else [x]

removeCharacters :: String -> String -> String
removeCharacters values str = filter (\c -> not (c `elem` values)) str

maxPathSum :: [[Int]] -> Int
maxPathSum (x:xs) =
    let
        combine acc curr = zipWith (+) curr $ zipWith max acc (tail acc)
    in
        head $ foldl combine x xs

runningTotal :: Num a => [a] -> [a]
runningTotal = scanl1 (+)

removeDuplicates :: Ord a => [a] -> [a]
removeDuplicates = toList.fromList

isPandigital :: Int -> Bool
isPandigital n = n <= 987654321 && d == [1..digs]
    where
        d = sort $ digitList n
        digs = digits n

isPandigital10 :: Int -> Bool
isPandigital10 n = n >= 123456789 &&
                 n <= 987654321 &&
                 d == [1..9]
    where d = sort $ digitList n

concatInts :: Integral a => [a] -> a
concatInts ns = sum parts
    where parts = zipWith (*) ns offsets
          offsets = zipWith (^) (repeat 10) $ reverse $ 0:(init exps)
          exps = runningTotal $ reverse $ map digits ns

truncateRight :: Integer -> Integer
truncateRight n = n `div` 10

truncateLeft :: Integer -> Integer
truncateLeft n = n - delta
        where delta = n `div` d * d
              d = 10^(digits n - 1)

isqrt :: Integral a => a -> a
isqrt = floor.sqrt.fromIntegral

sortedListDiff :: Ord a => [a] -> [a] -> [a]
sortedListDiff xs [] = xs
sortedListDiff [] ys = ys
sortedListDiff (x:xs) (y:ys) = if x == y
                               then sortedListDiff xs ys
                               else if x < y
                                    then x:sortedListDiff xs (y:ys)
                                    else y:sortedListDiff (x:xs) ys

iterativelyTake :: Int -> [a] -> [[a]]
iterativelyTake n xs = map (take n) (tails xs)

withinRange :: Ord a => a -> a -> [a] -> [a]
withinRange low high values = taken
    where
        dropped = dropWhile (<low) values
        taken = takeWhile (<=high) dropped

asList :: a -> [a]
asList a = [a]