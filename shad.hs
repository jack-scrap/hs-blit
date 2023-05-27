{-# LANGUAGE ForeignFunctionInterface #-}

module Shad where

import Foreign.C.Types

solid :: CInt
solid = 1

foreign export ccall solid :: CInt
