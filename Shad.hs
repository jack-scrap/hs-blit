{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

data Axis = X | Y
	deriving Enum

type Idx = CInt
type Coord = (Idx, Idx)

type Status = CInt

data Res = Res {
	wd :: Idx,
	ht :: Idx
}

res = Res 800 600

inRng :: Idx -> Idx -> Idx -> Bool
inRng n floor roof = n >= floor && n <= roof

idxToCoord :: Idx -> Coord
idxToCoord i = (i `mod` 800, i `div` 600)

coordToIdx :: Coord -> Idx
coordToIdx st = ((fst st) * 800) + (snd st)

boolToStatus :: Bool -> Status
boolToStatus = toEnum . fromEnum

statusToBool :: Status -> Bool
statusToBool = toEnum . fromIntegral

solid :: Idx -> Status
solid n = 1

stripe :: Idx -> Idx -> Status
stripe x stride = toEnum $ fromEnum $ mod x (stride * 2) > stride

check :: Idx -> Idx -> Idx -> Status
check x y stride = boolToStatus $ xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

rect :: Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Status
rect x y posX posY wd ht = boolToStatus $ inRng x posX (posX + wd) && inRng y posY (posY + ht)

border :: Idx -> Idx -> Idx -> Idx -> Idx -> Status
border x y wd ht stroke = boolToStatus $ not (inRng x stroke (wd - stroke)) || not (inRng y stroke (ht - stroke))

prime :: Idx -> Status
prime n = boolToStatus $ if n > 1
	then null [
		x | x <- [2..n - 1],
		mod n x == 0
	]
	else False

brick :: CInt -> CInt -> CInt
brick x y = boolToStatus $ xLocal > margin && xLocal < wd - margin && yLocal > margin && yLocal < ht - margin
	where
		wd = 20
		ht = 10

		xLocal = mod x wd
		yLocal = mod y ht

		margin = 1

rightTri :: Idx -> Idx -> Status
rightTri x y = boolToStatus $ x < y

se :: Idx -> Idx -> Idx -> Idx -> Status
se x y posX posY = boolToStatus $ inRng x posX (posX + (2 * sz)) || inRng y posY (posY + (2 * sz))
	where sz = 20

diagStripe :: Idx -> Idx -> Idx -> Status
diagStripe x y stroke = boolToStatus $ inRng mid (-rad) rad
	where
		mid = mod (x + y) stroke
		rad = stroke `div` 2

cornerFold :: Idx -> Idx -> Status
cornerFold x y = boolToStatus $ (((fromIntegral y) / 600)) < ((fromIntegral x) * (1 / 800))

flanel :: Idx -> Idx -> Status
flanel x y = (check x y 50) `xor` (check x y 30)

clip :: Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Idx -> Status
clip x y posX posY wd ht status = boolToStatus $ (statusToBool (rect x y posX posY wd ht)) && (statusToBool status)

patch :: Idx -> Status
patch i = solid i
	where
		coord = idxToCoord i

foreign export ccall patch :: Idx -> Status
