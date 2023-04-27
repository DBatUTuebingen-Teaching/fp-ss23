-- n!

-- Variante 1: Definition mittels Conditional (bedingtem Ausdruck) if-then-else

{-
fac :: Integer -> Integer
fac n = if n <= 1 then 1 else n * fac (n - 1)
-}

-- Variante 2: Definition mittels Guards (otherwise ≡ True)

fac :: Integer -> Integer
fac n | n <= 1    = 1
      | otherwise = n * fac (n - 1)


main :: IO ()
main = print $ fac 10
