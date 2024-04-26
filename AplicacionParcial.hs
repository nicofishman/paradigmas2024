doble :: Int -> Int
doble x = x * 2

-- No tengo triple, pero se puede usar `map (3*) [1..10]` para obtener los primeros 10 múltiplos de 3

-- :t (2*) :: Num a => a -> a

losDosPrimeros :: [a] -> [a]
losDosPrimeros = take 2

-- map (take 2) ["hola", "como", "estas"]
-- ["ho", "co", "es"]

-- FUNCIONES LAMBDA
-- Son funciones anónimas que se pueden usar en el momento
-- EJ: map (\x -> x * 2) [1..10]
