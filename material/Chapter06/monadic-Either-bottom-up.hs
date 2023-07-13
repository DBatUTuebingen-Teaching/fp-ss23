import Data.Maybe (maybe)
import Data.Char (ord)

-- Exc a is either an exception (Exc err) or a value (Val y)
data Exc a =
    Exc Error
  | Val a
  deriving (Show)

type Error = String

-- Instantiate the Functor-Applicative-Monad tower
--
--   class Functor m => Applicative m where...
--   class Applicative m => Monad m where ...
--
-- in the standard bottom-up fashion:

instance Functor Exc where
  fmap f (Exc err) = Exc err
  fmap f (Val x)   = Val (f x)


instance Applicative Exc where
  pure x = Val x

  Exc err <*> _       = Exc err
  _       <*> Exc err = Exc err
  Val f   <*> Val x   = Val (f x)


instance Monad Exc where
  return = pure

  Exc err >>= _ = Exc err
  Val x   >>= g = g x


-- A safe variant of (!!)
at :: Int -> [a] -> Exc a
at i xs | 0 <= i && i < length xs = Val (xs !! i)
        | otherwise               = Exc "list index out of bound"


numeralToDigit :: String -> Exc Char
numeralToDigit w = maybe (Exc "unknown numeral")
                         Val
                         (lookup w digits)
  where
    digits = [("null",  '0'),
              ("zero",  '0'),
              ("one",   '1'),
              ("two",   '2'),
              ("three", '3'),
              ("four",  '4'),
              ("five",  '5'),
              ("six",   '6'),
              ("seven", '7'),
              ("eight", '8'),
              ("nine",  '9')]

digitToVal :: Char -> Exc Int
digitToVal d | d `elem` ['0'..'9'] = Val (ord d - ord '0')
             | otherwise           = Exc "non-digit has no value"

chineseNumeral :: Int -> Exc Char
chineseNumeral n = at n "零一二三四五六七八九"


-- Translate English numeral n into a Chinese digit,
-- *if possible* (return an error message otherwise)
chinese' :: String -> Exc Char
chinese' n = numeralToDigit n >>= digitToVal >>= chineseNumeral

main :: IO ()
main = do
  print $ chinese' "five"
