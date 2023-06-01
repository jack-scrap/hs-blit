{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

type Dim = CInt

type Status = CInt

data Res = Res {
	wd :: Dim,
	ht :: Dim
}

res = Res 800 600

inRng :: CInt -> CInt -> CInt -> Bool
inRng n floor roof = n >= floor && n <= roof

solid :: CInt -> Status
solid i = 1

stripe :: CInt -> CInt -> Status
stripe x stride = toEnum $ fromEnum $ mod x (stride * 2) > stride

check :: CInt -> CInt -> CInt -> Status
check x y stride = toEnum $ fromEnum $ xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> Status
rect x y posX posY wd ht = toEnum $ fromEnum $ inRng x posX (posX + wd) && inRng y posY (posY + ht)

border :: CInt -> CInt -> CInt -> CInt -> CInt -> Status
border x y wd ht stroke = toEnum $ fromEnum $ not (inRng x stroke (wd - stroke)) || not (inRng y stroke (ht - stroke))

prime :: CInt -> Status
prime n = toEnum $ fromEnum $ if n > 1
	then null [
		x | x <- [2..n - 1],
		mod n x == 0
	]
	else False

rightTri :: CInt -> CInt -> Status
rightTri x y = toEnum $ fromEnum $ x < y

se :: CInt -> CInt -> CInt -> CInt -> Status
se x y posX posY = toEnum $ fromEnum $ inRng x posX (posX + (2 * sz)) || inRng y posY (posY + (2 * sz))
	where sz = 20

diagStripe :: CInt -> CInt -> CInt -> Status
diagStripe x y stroke = toEnum $ fromEnum $ middle < rad && middle > -rad
	where
		middle = mod (x + y) stroke
		rad = div stroke 2

foreign export ccall solid :: CInt -> Status
foreign export ccall stripe :: CInt -> CInt -> Status
foreign export ccall check :: CInt -> CInt -> CInt -> Status
foreign export ccall rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> Status
foreign export ccall border :: CInt -> CInt -> CInt -> CInt -> CInt -> Status
foreign export ccall prime :: CInt -> Status
foreign export ccall rightTri :: CInt -> CInt -> Status
foreign export ccall se :: CInt -> CInt -> CInt -> CInt -> Status
foreign export ccall diagStripe :: CInt -> CInt -> CInt -> Status
