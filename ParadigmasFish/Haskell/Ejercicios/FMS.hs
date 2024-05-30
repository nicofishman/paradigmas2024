type Palabra = String
type Verso = String
type Estrofa = [Verso]
type Artista = String -- Solamente interesa el nombre


esVocal :: Char -> Bool
esVocal = flip elem "aeiou"

tieneTilde :: Char -> Bool
tieneTilde = flip elem "áéíóú"

cumplen :: (a -> b) -> (b -> b -> Bool) -> a -> a -> Bool
cumplen f comp v1 v2 = comp (f v1) (f v2)

{-
Existen varias formas de clasificar las rimas, la más sencillas son:
Rima asonante: se cumple cuando las dos últimas vocales de la palabra coinciden. Por ejemplo: parcial - estirar
Rima consonante: se cumple cuando las tres últimas letras de la palabra coinciden. Por ejemplo: función - canción

a) Determinar si dos palabras riman. Es decir, si generan una rima, ya sea asonante o consonante, pero teniendo en cuenta que dos palabras iguales no se consideran una rima.
b) Enumerar todos los casos de test representativos (clases de equivalencia) de la función anterior. No hace falta escribir los tests (serían sólo sus nombres).
-}

rima :: Palabra -> Palabra -> Bool
rima p1 p2
  | p1 == p2 = False
  | otherwise = rimaAsonante p1 p2 || rimaConsonante p1 p2

rimaAsonante :: Palabra -> Palabra -> Bool
rimaAsonante = cumplen (take 2 . reverse . filter esVocal) (==)

rimaConsonante :: Palabra -> Palabra -> Bool
rimaConsonante = cumplen (take 3 . reverse) (==)



{- Conjugaciones
  Por medio de rimas: dos versos se conjugan con rima cuando logran rimar las últimas palabras de cada uno
  Haciendo anadiplosis: dos versos se conjugan con anadiplosis cuando la última palabra del primer verso es igual a la primera del segundo
-}



