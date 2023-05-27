{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types
import Data.Bits

solid :: CInt -> CInt
solid i = 1

check :: CInt -> CInt -> CInt -> CInt
check x y stride = toEnum $ fromEnum $ xor (mod x (stride * 2) > stride) (mod y (stride * 2) > stride)

foreign export ccall solid :: CInt -> CInt
foreign export ccall check :: CInt -> CInt -> CInt -> CInt
