module Cards (
    Suit(..),
    Face(..),
    Card(..),
    PokerHand,
    cardToString,
    makePokerHand,
    faceGroups,
    getTestResults,
    stringToCard,
    stringToPokerHand,
    isFlush,
    isStraight,
    isStraightFlush,
    isRoyalFlush,
    isFourOfAKind,
    isThreeOfAKind,
    isFullHouse,
    isTwoPair,
    isOnePair,
    shortShow,
) where

import Data.List (sort, all)
import Util (runLength)
import Data.Map (fromList, (!))
import Data.Char (toUpper)

-- alphabetical ordering for convenience
-- otherwise can't make ordered maps
suitOrderString = "CDHS"
data Suit = Clubs
          | Diamonds
          | Hearts
          | Spades
          deriving (Show, Enum, Bounded, Eq, Ord)

faceOrderString = "23456789TJQKA"
data Face = Two   | Three | Four
          | Five  | Six   | Seven
          | Eight | Nine  | Ten
          | Jack  | Queen | King | Ace
          deriving (Show, Enum, Bounded, Eq, Ord)


stringToCard :: String -> Card
stringToCard [face,suit] = Card f s
    where
        f = charToFace $ toUpper face
        s = charToSuit $ toUpper suit

cardToString :: Card -> String
cardToString (Card face suit) = [f, s]
    where
        f = reverseFaceMap ! face
        s = reverseSuitMap ! suit
reverseFaceMap = fromList $ zip [Two ..] faceOrderString
reverseSuitMap = fromList $ zip [Clubs ..] suitOrderString

charToFace :: Char -> Face
charToFace f = faceMap ! f
faceMap = fromList $ zip faceOrderString [Two ..]

charToSuit :: Char -> Suit
charToSuit s = suitMap ! s
suitMap = fromList $ zip suitOrderString [Clubs ..]

data Card = Card {
    face :: Face,
    suit :: Suit
} deriving (Show, Eq)

instance Ord Card where
    compare (Card a _) (Card b _) =
        if a > b
            then GT
        else if a < b
            then LT
            else EQ
    (<)  (Card a _) (Card b _) = a < b
    (>)  (Card a _) (Card b _) = a > b
    (<=) (Card a _) (Card b _) = a <= b
    (>=) (Card a _) (Card b _) = a >= b
    max a b = if a > b then a else b
    min a b = if a < b then a else b

stringToPokerHand :: String -> PokerHand
stringToPokerHand s = makePokerHand (a,b,c,d,e)
    where
        cardStrings = words s
        [a,b,c,d,e] = map stringToCard cardStrings

-- Should not be used to create a new PokerHand, only for matching
-- All expected properties are enforced by the makePokerHand function
data PokerHand = PokerHand {
    cards :: [Card]
} deriving (Show, Eq)

shortShow :: PokerHand -> String
shortShow (PokerHand cards) = unwords $ map cardToString cards

makePokerHand :: (Card,Card,Card,Card,Card) -> PokerHand
makePokerHand (a,b,c,d,e) = PokerHand $ sort [a,b,c,d,e]

faceGroups :: PokerHand -> [(Int, Face)]
faceGroups (PokerHand cards) = reverse $ sort counts
    where
        faces = map face cards
        counts = map (\(a,b) -> (b,a)) $ runLength faces

highCard :: PokerHand -> Face
highCard (PokerHand cards) = maximum $ map face cards

isRoyalFlush :: PokerHand -> Bool
isRoyalFlush hand = face lowest == Ten &&
                    isStraightFlush hand
    where
        lowest = head cards
        (PokerHand cards) = hand

isStraightFlush :: PokerHand -> Bool
isStraightFlush hand = isFlush hand &&
                       isStraight hand

isFlush :: PokerHand -> Bool
isFlush (PokerHand cards) = all (== a) suits
    where
        a = head suits
        suits = map suit cards

isStraight :: PokerHand -> Bool
isStraight (PokerHand cards) = all id $ zipWith (==) faces expected
    where
        a = head cards
        expected = [face a ..]
        faces = map face cards

countHelper :: PokerHand -> [Int] -> Bool
countHelper hand expected = counts == expected
    where
        counts = map fst groups
        groups = faceGroups hand

isFourOfAKind :: PokerHand -> Bool
isFourOfAKind hand = countHelper hand [4,1]

isFullHouse :: PokerHand -> Bool
isFullHouse hand = countHelper hand [3,2]

isThreeOfAKind :: PokerHand -> Bool
isThreeOfAKind hand = countHelper hand [3,1,1]

isTwoPair :: PokerHand -> Bool
isTwoPair hand = countHelper hand [2,2,1]

isOnePair :: PokerHand -> Bool
isOnePair hand = countHelper hand [2,1,1,1]

isHighCard :: PokerHand -> Bool
isHighCard hand = countHelper hand [1,1,1,1,1]

instance Ord PokerHand where
    compare a b = comparePhase1 a b
    (<)  a b = compare a b == LT
    (>)  a b = compare a b == GT
    (<=) a b = compare a b /= GT
    (>=) a b = compare a b /= LT
    max a b = if a > b then a else b
    min a b = if a < b then a else b

data CompareDebug = StraightFlush
                  | FourOfAKind
                  | FullHouse
                  | Flush
                  | Straight
                  | ThreeOfAKind
                  | TwoPair
                  | OnePair
                  | HighCard
                  deriving (Show, Enum, Bounded, Eq, Ord)

getTestResults a = (faceGroups a, head readable)
    where
        readable = map fst (filter snd (zip [StraightFlush ..] tests))
        tests =  map ($ a) [isStraightFlush,
                            isFourOfAKind,
                            isFullHouse,
                            isFlush,
                            isStraight,
                            isThreeOfAKind,
                            isTwoPair,
                            isOnePair,
                            isHighCard]
-- 1 - Straight flushes
comparePhase1 left right =
    if l || r
        then compare (l, highL) (r, highR)
        else comparePhase2 left right
    where
        hands = [left, right]
        [highL, highR] = map highCard hands
        [l,r] = map isStraightFlush hands

-- 2 - Four Of A Kind && Full House
comparePhase2 left right =
    if l || r
        then compare (l, lHand) (r, rHand)
        else comparePhase3 left right
    where
        hands = [left, right]
        [lHand, rHand] = map comparableGroups hands
        four = map isFourOfAKind hands
        house = map isFullHouse hands
        [l,r] = zipWith (||) four house

-- 3 - Flushes
comparePhase3 left right =
    if l || r
        then compare (l, highL) (r, highR)
        else comparePhase4 left right
    where
        hands = [left, right]
        [highL, highR] = map highCard hands
        [l,r] = map isFlush hands

-- 4 - Straights
comparePhase4 left right =
    if l || r
        then compare (l, highL) (r, highR)
        else comparePhase5 left right
    where
        hands = [left, right]
        [highL, highR] = map highCard hands
        [l,r] = map isStraight hands

-- 5 - The rest
comparePhase5 left right = compare lHand rHand
    where
        hands = [left, right]
        [lHand, rHand] = map comparableGroups hands

comparableGroups = unzip.faceGroups