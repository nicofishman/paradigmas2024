-- ghci nombreDelArchivo.hs
-- :r Recarga el compilador

resolvente:: Float -> Float -> Float -> (Float, Float)

doble:: Int -> Int
doble x = x + x

triple:: Int -> Int
triple x = x*3

cuadrado :: Float -> Float
cuadrado x = x^2

apellido:: String -> String
apellido "Juan" = "Perez"
apellido "Pedro" = "Gomez"
apellido "Maria" = "Lopez"
apellido alguien = "Desconocido"

esCero :: Int -> Bool
esCero 0 = True 
esCero x = False

-- Se pueden usar funciones al otro lado del igual
funcion:: Int -> Int
funcion x = doble x + triple x


-- funciones de Haskell
primeraLetra:: String -> Char
primeraLetra palabra = head palabra


-- constantes
miPi = 3.14159

superficie:: Float -> Float
superficie radio = miPi * cuadrado radio

resolvente x y z = ( (-y + sqrt(cuadrado y - 4*x*z)) / 2*x, (-y - sqrt(cuadrado y - 4*x*z)) / 2*x)