{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

solid :: CInt -> CInt
solid i = 1

stripe :: CInt -> CInt -> CInt
stripe x stride = toEnum $ fromEnum $ mod x (stride * 2) > stride

check :: CInt -> CInt -> CInt -> CInt
check x y stride = toEnum $ fromEnum $ xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> CInt
rect x y posX posY wd ht = toEnum $ fromEnum $ x >= posX && x <= posX + wd && y >= posY && y <= posY + ht

border :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt
border x y wd ht thick = toEnum $ fromEnum $ x < thick || x > wd - thick || y < thick || y > ht - thick

rightTri :: CInt -> CInt -> CInt
rightTri x y = toEnum $ fromEnum $ x < y

foreign export ccall solid :: CInt -> CInt
foreign export ccall stripe :: CInt -> CInt -> CInt
foreign export ccall check :: CInt -> CInt -> CInt -> CInt
foreign export ccall rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> CInt
foreign export ccall border :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt
foreign export ccall rightTri :: CInt -> CInt -> CInt
