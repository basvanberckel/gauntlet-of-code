import System.IO
import Control.Monad
import qualified Data.Set as Set

main = do
    contents <- readFile "cases/input/2"
    print $ solve $ lines contents

readInt :: String -> Int
readInt = read

data Coord = Coord Integer Integer deriving (Show, Eq, Ord)
orig = Coord 0 0
move "U" (Coord x y) = Coord x (y+1)
move "D" (Coord x y) = Coord x (y-1)
move "L" (Coord x y) = Coord (x-1) y
move "R" (Coord x y) = Coord (x+1) y

solve xs = do_solve xs orig (take 9 $ repeat orig) (Set.singleton orig)

do_solve [] _ _ seen = Set.size seen
do_solve (x:xs) h ts seen = do_solve xs h' ts' seen'
    where (h', ts', seen') = steps x h ts seen

steps (d:' ':n) h ts seen = do_steps [d] (read n) h ts seen

do_steps d 0 h ts seen = (h, ts, seen)
do_steps d n h ts seen = do_steps d (n-1) h' ts' seen'
    where (h', ts', seen') = do_step d h ts seen

do_step d h ts seen = let
        h' = move d h
        ts' = follow h' ts
        seen' = Set.insert (last ts') seen
    in (h', ts', seen')

adjacent (Coord ax ay) (Coord bx by) = (abs $ ax - bx) <= 1 && (abs $ ay - by) <= 1

follow _ [] = []
follow h (t:ts) = if adjacent t h then (t:ts) else t' : (follow t' ts)
    where t' = do_follow t h

do_follow (Coord tx ty) (Coord hx hy) = let 
        tx' = tx + (signum $ hx - tx)
        ty' = ty + (signum $ hy - ty)
    in Coord tx' ty'