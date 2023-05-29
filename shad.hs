{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

type Dim = Int

data Res = Res {
	wd :: Dim,
	ht :: Dim
}

res = Res 800 600

inRng :: CInt -> CInt -> CInt -> Bool
inRng n floor roof = n >= floor && n <= roof

solid :: CInt -> CInt
solid i = 1

stripe :: CInt -> CInt -> CInt
stripe x stride = toEnum $ fromEnum $ mod x (stride * 2) > stride

check :: CInt -> CInt -> CInt -> CInt
check x y stride = toEnum $ fromEnum $ xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> CInt
rect x y posX posY wd ht = toEnum $ fromEnum $ inRng x posX (posX + wd) && inRng y posY (posY + ht)

border :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt
border x y wd ht stroke = toEnum $ fromEnum $ not (inRng x stroke (wd - stroke)) || not (inRng y stroke (ht - stroke))

prime :: CInt -> CInt
prime n = toEnum $ fromEnum $ if n > 1
	then null [
		x | x <- [2..n - 1],
		mod n x == 0
	]
	else False

rightTri :: CInt -> CInt -> CInt
rightTri x y = toEnum $ fromEnum $ x < y

se :: CInt -> CInt -> CInt -> CInt -> CInt
se x y posX posY = toEnum $ fromEnum $ inRng x posX (posX + (2 * sz)) || inRng y posY (posY + (2 * sz))
	where sz = 20

foreign export ccall solid :: CInt -> CInt
foreign export ccall stripe :: CInt -> CInt -> CInt
foreign export ccall check :: CInt -> CInt -> CInt -> CInt
foreign export ccall rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> CInt
foreign export ccall border :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt
foreign export ccall prime :: CInt -> CInt
foreign export ccall rightTri :: CInt -> CInt -> CInt
foreign export ccall se :: CInt -> CInt -> CInt -> CInt -> CInt
