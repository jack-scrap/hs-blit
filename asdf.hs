{-# LANGUAGE ForeignFunctionInterface #-}

module Safe where

import Foreign.C.Types

asdf :: Int -> Int
asdf n = fibs !! n
    where fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

asdf_hs :: CInt -> CInt
asdf_hs = fromIntegral . asdf . fromIntegral

foreign export ccall asdf_hs :: CInt -> CInt
