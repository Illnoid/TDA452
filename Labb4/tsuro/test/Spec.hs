module Main where
import Tsuro

import Data.List

import Test.QuickCheck hiding (Result)
import Test.Hspec
import Test.Hspec.QuickCheck
import Test.QuickCheck.Assertions
import Test.QuickCheck.Property
import System.Random

main :: IO ()
main = hspec $ describe "tsuro" $ do
--    prop "updateTile"   $ prop_updateTile
    prop "newTile     : conn" $ prop_newTile_conn
    prop "adjacentPos : dist" $ prop_adjacentPos_distance
    prop "adjacentPos : uniq" $ prop_adjacentPos_uniqueness
    prop "mapLinks          " $ prop_mapLinks

instance Arbitrary Tile where
     arbitrary = do
        n <- arbitrarySizedNatural
        let sd = mkStdGen n
        return (fst (newTile sd))

tile :: Gen Tile
tile = arbitrary

--prop_updateTile :: [[Maybe Tile]] -> Pos ->  Tile -> Property
--prop_updateTile ts (x,y) t =
--    (length ts < y && length (ts !! y) < x) ==>
--    (new_tiles !! y) !! x ?== Just t
--    where new_tiles = updateTile ts (x,y) t

prop_newTile_conn :: Tile -> Result
prop_newTile_conn t = fromConns ?== [0..7]
    where 
        fromConns = sort $ foldr f [] (conn t) 
        f (a,b) ls = a:b:ls

prop_mapLinks :: Int -> Result
prop_mapLinks 0 = mapLinks 0 ?== 5
prop_mapLinks 1 = mapLinks 1 ?== 4
prop_mapLinks 2 = mapLinks 2 ?== 7
prop_mapLinks 3 = mapLinks 3 ?== 6
prop_mapLinks 4 = mapLinks 4 ?== 1
prop_mapLinks 5 = mapLinks 5 ?== 0
prop_mapLinks 6 = mapLinks 6 ?== 3
prop_mapLinks 7 = mapLinks 7 ?== 2
prop_mapLinks n = prop_mapLinks (abs n `mod` 8)

prop_adjacentPos_distance :: Pos -> Result
prop_adjacentPos_distance p = True ?== all f (adjacentPos p)
    where f x = x >-< p == 1

prop_adjacentPos_uniqueness :: Pos -> Result
prop_adjacentPos_uniqueness p = nub res ?== res
    where res = adjacentPos p
    
-- Manhattan distance
(>-<) :: Pos -> Pos -> Int
(>-<) (a,b) (c,d) = abs (a-c) + abs (b-d)