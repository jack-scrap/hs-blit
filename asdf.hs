{-# LANGUAGE ForeignFunctionInterface #-}

module Asdf where

import Foreign.C.Types

asdf :: CInt -> CInt
asdf asdf = 3

foreign export ccall asdf :: CInt -> CInt
