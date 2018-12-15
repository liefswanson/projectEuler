module Pythagoras (
    pythagoreanTripleSequence,
    Triple(..),
    perimeter
) where

data Triple = Triple {
    a :: Integer,
    b :: Integer,
    c :: Integer
} deriving (Show)

perimeter :: Triple -> Integer
perimeter (Triple a b c) = a + b + c

pythagoreanTripleSequence :: [Triple]
pythagoreanTripleSequence =
    let
        topLayer = [Triple 3 4 5]
        trips = topLayer:pythagoreanTriplesHelper topLayer
    in
        concat trips

pythagoreanTriplesHelper :: [Triple] -> [[Triple]]
pythagoreanTriplesHelper previousLayer =
    let
        left  (Triple a b c) = Triple (   a - 2*b + 2*c)
                                      ( 2*a -   b + 2*c)
                                      ( 2*a - 2*b + 3*c)

        mid   (Triple a b c) = Triple (   a + 2*b + 2*c)
                                      ( 2*a +   b + 2*c)
                                      ( 2*a + 2*b + 3*c)

        right (Triple a b c) = Triple (  -a + 2*b + 2*c)
                                      (-2*a +   b + 2*c)
                                      (-2*a + 2*b + 3*c)

        lefts  = map left  previousLayer
        mids   = map mid   previousLayer
        rights = map right previousLayer

        newLayer = concat [lefts, mids, rights]
    in
        newLayer:pythagoreanTriplesHelper newLayer