module Names (
    sumAlpha
) where

valueOf :: Char -> Int
valueOf c
    | c >= 'A' && c <= 'Z' = fromEnum c - fromEnum 'A' + 1
    | c >= 'a' && c <= 'z' = fromEnum c - fromEnum 'a' + 1
    | otherwise = error "valueOf called on non-alpha"

sumAlpha :: String -> Int
sumAlpha = sum.(map valueOf)