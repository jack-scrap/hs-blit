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
rect x y startX startY wd ht = toEnum $ fromEnum $ x >= startX && x <= startX + wd && y >= startY && y <= startY + ht

foreign export ccall solid :: CInt -> CInt
foreign export ccall stripe :: CInt -> CInt -> CInt
foreign export ccall check :: CInt -> CInt -> CInt -> CInt
foreign export ccall rect :: CInt -> CInt -> CInt -> CInt -> CInt -> CInt -> CInt
