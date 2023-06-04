{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

data Axis = X | Y
	deriving Enum

type Idx = CInt

data Coord = Coord {
	x :: Idx,
	y :: Idx
}

type Status = CInt

data Res = Res {
	wd :: Idx,
	ht :: Idx
}

res = Res 800 600

inRng :: Idx -> Idx -> Idx -> Bool
inRng n floor roof = n >= floor && n <= roof

idxToCoord :: Idx -> Coord
idxToCoord i = Coord (i `mod` wd res) (i `div` ht res)

coordToIdx :: Coord -> Idx
coordToIdx st = (y st * wd res) + (x st)

boolToStatus :: Bool -> Status
boolToStatus = toEnum . fromEnum

statusToBool :: Status -> Bool
statusToBool = toEnum . fromIntegral

solid :: Bool
solid = True

stripe :: Idx -> Idx -> Bool
stripe x stride = mod x (stride * 2) > stride

check :: Idx -> Idx -> Idx -> Bool
check x y stride = xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

rect :: Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Bool
rect x y posX posY wd ht = inRng x posX (posX + wd) && inRng y posY (posY + ht)

border :: Idx -> Idx -> Idx -> Idx -> Idx -> Bool
border x y wd ht stroke = not (inRng x stroke (wd - stroke)) || not (inRng y stroke (ht - stroke))

prime :: Idx -> Bool
prime n = if n > 1
	then null [
		x | x <- [2..n - 1],
		mod n x == 0
	]
	else False

brick :: CInt -> CInt -> Bool
brick x y = xLocal > margin && xLocal < wd - margin && yLocal > margin && yLocal < ht - margin
	where
		wd = 20
		ht = 10

		xLocal = mod x wd
		yLocal = mod y ht

		margin = 1

rightTri :: Idx -> Idx -> Bool
rightTri x y = x < y

se :: Idx -> Idx -> Idx -> Idx -> Bool
se x y posX posY = inRng x posX (posX + (2 * sz)) || inRng y posY (posY + (2 * sz))
	where sz = 20

diagStripe :: Idx -> Idx -> Idx -> Bool
diagStripe x y stroke = inRng mid (-rad) rad
	where
		mid = mod (x + y) stroke
		rad = stroke `div` 2

cornerFold :: Idx -> Idx -> Bool
cornerFold x y = (((fromIntegral y) / (fromIntegral (ht res)))) < ((fromIntegral x) * (1 / (fromIntegral (wd res))))

flanel :: Idx -> Idx -> Bool
flanel x y = (check x y 50) `xor` (check x y 30)

clip :: Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Bool
clip x y posX posY wd ht status = (rect x y posX posY wd ht) && (statusToBool status)

patch :: Idx -> Status
patch i = boolToStatus solid
	where
		coord = idxToCoord i

foreign export ccall patch :: Idx -> Status
