module Fraction (
    Fraction(..),
    gcd',
    simplify,
    canSillySimplify,
    sillySimplify,
    (*),
    over,
) where

import Util (digitList)
import Data.List (delete, intersect)
import Primes (divides)
data Fraction = Fraction {
    numerator :: Integer,
    denominator :: Integer
} deriving (Show, Eq)

over :: Integer -> Integer -> Fraction
over n d = simplify (Fraction n d)

gcd' :: Integral a => a -> a -> a
gcd' a 0 = a
gcd' a b = if a < b then gcd' b a else gcd' b r
    where r = a `mod` b

simplify :: Fraction -> Fraction
simplify f = Fraction (n `div` divisor) (d `div` divisor)
    where divisor = gcd' n d
          n = numerator f
          d = denominator f

invert :: Fraction -> Fraction
invert (Fraction n d) = (Fraction d n)

sillySimplify :: Fraction -> Fraction
sillySimplify f = Fraction a b
    where a = head $ delete x n
          b = head $ delete x d
          x = head $ intersect d n
          d = digitList $ denominator f
          n = digitList $ numerator f

canSillySimplify :: Fraction -> Bool
canSillySimplify f =
        not (10 `divides` n) &&
        not (10 `divides` d) &&
        0 < length (intersect nl dl)
    where dl = digitList d
          d = denominator f
          nl = digitList n
          n = numerator f

instance Num Fraction where
    (*) (Fraction n1 d1) (Fraction n2 d2) = simplify $ Fraction (n1*n2) (d1*d2)
    (+) (Fraction n1 d1) (Fraction n2 d2) = simplify $ Fraction (n1*d2 + n2*d1) (d1*d2)
    (-) (Fraction n1 d1) (Fraction n2 d2) = simplify $ Fraction (n1*d2 - n2*d1) (d1*d2)
    abs (Fraction n d) = simplify $ Fraction (abs n) (abs d)
    fromInteger k = simplify $ Fraction k 1
    signum (Fraction n d) = if sign >  0 then 1
                       else if sign == 0 then 0
                       else -1
        where sign = n*d

instance Ord Fraction where
    compare left right = compare a b
        where
            (a,b) = compareHelper left right
    (<) left right = a < b
        where
            (a,b) = compareHelper left right
    (>) left right = a > b
        where
            (a,b) = compareHelper left right
    (<=) a b = not $ a > b
    (>=) a b = not $ a < b
    max a b = if a > b then a else b
    min a b = if a < b then a else b

compareHelper (Fraction n1 d1) (Fraction n2 d2) = (n1 * d2, d1 * n2)