-- La composición de funciones es una técnica que permite combinar funciones para crear nuevas funciones. En Haskell, la composición de funciones se realiza con el operador . (punto).

-- (.):: (b -> c) -> (a -> b) -> a -> c

-- Ejemplo:
cuadrado:: Int -> Int
cuadrado x = x * x

doble:: Int -> Int
doble x = x*2

sqrt :: Float -> Float
sqrt x = x ** 0.5

dobleCuadrado :: [Int] -> [Int]
dobleCuadrado = map (doble . cuadrado)

a = filter (even . cuadrado)
