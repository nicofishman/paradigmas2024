f::Integer -> Integer
f 0 = 1
f n = n * f (n-1) -- Recursividad factorial
-- f n = ((n*).f.(+) (-1)) n -- Lo mismo con composicion

g::Integer -> [Integer]
g 0 = []
g n = n : g (n-1) -- Crea una lista con los numeros desde n hasta el 0

h::Float -> Float -> Float
h 0 x = 0
h y 0 = y
h y x = x + y
{-
Difiere la evaluación de los argumentos de la llamada a la función.
Primero evalua la función y después los argmentos.

Ejemplo:
(take 2) g 50 -- [50,49]
Solo computa g para los primeros 2 elementos, ya quje son los unicos que van a necesitar.
-}



ff a b [] = b
ff a b (x:xs) = ff a (a b x) xs
-- Esta funcion es equivalente a foldl

ff2 a b [] = b
ff2 a b (x:xs) = a x (ff2 a b xs)

data Persona = UnaPersona {
  cansancio :: Float,
  nombre :: String
} deriving Show

trabajar :: Persona -> Float -> Persona
trabajar alguien trabajo = alguien { cansancio = cansancio alguien + trabajo }

trabajar2 :: Float -> Persona -> Persona
trabajar2 trabajo alguien = trabajar alguien trabajo

jose::Persona
jose = UnaPersona 0 "Jose"

juan::Persona
juan = UnaPersona 80 "Juan"