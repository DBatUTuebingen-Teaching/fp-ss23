-- Efficient power computation, basic idea: x^2k = (x^2)^k

power :: Double -> Integer -> Double
power x k | k == 1    = x
          | even k    = power (x * x) (halve k)
          | otherwise = x * power (x * x) (halve k)
  where
    even n  = n `mod` 2 == 0
    halve n = n `div` 2

main :: IO ()
main = print $ power 2 16
