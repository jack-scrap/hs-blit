{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types

solid :: CInt -> CInt
solid i = 1

check :: CInt -> CInt
check i = mod i 2

foreign export ccall solid :: CInt -> CInt
foreign export ccall check :: CInt -> CInt
