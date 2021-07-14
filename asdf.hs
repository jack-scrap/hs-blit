{-# LANGUAGE ForeignFunctionInterface #-}

module Safe where

import Foreign.C.Types

asdf :: Int -> Int
asdf n = 3

asdf_hs :: CInt -> CInt
asdf_hs = fromIntegral . asdf . fromIntegral

foreign export ccall asdf_hs :: CInt -> CInt
