{-# LANGUAGE ForeignFunctionInterface #-}

module Safe where

import Foreign.C.Types

asdf :: Int -> Int
asdf asdf = 3

asdf_hs :: CInt -> CInt
asdf_hs = fromIntegral . asdf . fromIntegral

foreign export ccall asdf_hs :: CInt -> CInt
