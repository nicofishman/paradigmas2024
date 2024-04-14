-- Listas

list = [1,2,3,4,5]

listLength = length list
listHead = head list  -- 1
listTail = tail list  -- [2,3,4,5]
listLast = last list  -- 5
listTake3 = take 3 list  -- [1,2,3]
listReverse = reverse list  -- [5,4,3,2,1]


-- Estructuras

--   Nombres siempre con mayúscula
data MiEstructura = UnaEstructura {
    key1 :: String,
    key2 :: Int
}

-- Ejemplo:
data Botella = UnaBotella {
    color::String,
    capacidad::Int,
    boquilla::Bool
}

miBotella = UnaBotella "Azul" 500 True
otraBotella = UnaBotella {
    color = "Rojo",
    capacidad = 500,
    boquilla = True
}

-- Función
esLinda:: Botella -> Bool
esLinda (UnaBotella col cap boq) = col == "Negro" && not boq