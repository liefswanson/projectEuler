module Main where


main :: IO ()
main =
    let
        powers = zipWith (^) [1..] [1..]
        result = sum $ take 1000 powers
    in
        print $ result `mod` 10^10