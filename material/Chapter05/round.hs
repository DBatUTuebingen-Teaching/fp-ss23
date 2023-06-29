import Text.Read (readEither)
-- readEither :: Read a => String -> Either String a

-- Read input and round to nearest n if successful,
-- otherwise yield parse error
--                                        input        error message
--                                          ↓                ↓
readRoundToNearest :: Integral a => a -> String -> Either String a
readRoundToNearest n = fmap toNearest . readEither
  where
    toNearest x = n * round (x / fromIntegral n)

main :: IO ()
main = do
  print $ readRoundToNearest 10 "42"
  print $ readRoundToNearest 10 "BB-8"
