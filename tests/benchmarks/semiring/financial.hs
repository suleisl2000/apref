f :: Integer -> Rational
f 0 = 2000
f n = (1 + 0.005) * f(n-1) + 100