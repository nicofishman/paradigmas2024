-- Las funciones de orden superior son funciones que reciben funciones como argumentos y/o devuelven funciones como resultado.
-- Las funciones pueden ser datos

-- Una función que recibe `a` y devuelve `b`, y una lista de `a` y devuelve una lista de `b`
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []

-- Una función que recibe `a` y devuelve `Bool`, y una lista de `a` y devuelve una lista de `a`
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = [] -- Devuelve la lista filtrada

-- Una función que recibe `a` y devuelve `Bool`, y una lista de `a` y devuelve `Bool`
all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True -- Devuelve True si todos los elementos cumplen la condición

-- Una función que recibe `a` y devuelve `Bool`, y una lista de `a` y devuelve `Bool`
any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False -- Devuelve True si algún elemento cumple la condición

-- Una funcion que se fija si un elemento pertenece a una lista
elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False -- Devuelve True si el elemento pertenece a la lista

todosPares :: [Int] -> Bool
todosPares = all even

todosPorTres :: [Int] -> [Int]
todosPorTres = map (*3)

totalCaracteresLista :: [String] -> Int
totalCaracteresLista lista = sum (map length lista)

esPalabraLarga :: String -> Int -> Bool
esPalabraLarga palabra x = length palabra > x

longitudPalabras :: [String] -> [Int]
longitudPalabras = map length

cuantasPalabrasConMasDeXLetras :: [String] -> Int -> Int
cuantasPalabrasConMasDeXLetras lista largo = length (filter (> largo) (longitudPalabras lista))
 -- x representa cada elemento de la lista

cuantasPalabrasConMasDeDiezLetras :: [String] -> Int
cuantasPalabrasConMasDeDiezLetras lista = cuantasPalabrasConMasDeXLetras lista 10


-- Ejemplo funciòn orden superior:
f :: Ord a => (t -> a) -> (t -> a) -> t -> t -> a
f a b c
    | a c > b c = a
    | otherwise = b

g :: Ord a => (t -> a) -> (t -> a) -> t -> t -> a
g a b c x
    | a c > b c = a x 
    | otherwise = b x

doble :: Int -> Int
doble x = x * 2

triple :: Int -> Int
triple x = x * 3

losDosPrimeros :: [a] -> [a]
losDosPrimeros = take 2 
