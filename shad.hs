{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types

solid :: CInt -> CInt
solid i = 1

foreign export ccall solid :: CInt -> CInt
