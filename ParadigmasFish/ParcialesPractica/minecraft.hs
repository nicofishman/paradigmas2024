{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use infix" #-}
{-# HLINT ignore "Avoid lambda using `infix`" #-}
data Personaje = UnPersonaje {
  nombre:: String,
  puntaje:: Int,
  inventario:: [Material]
} deriving (Show, Eq)

type Material = String

data Receta = UnaReceta {
  materiales:: [Material],
  resultado:: Material,
  tiempo:: Int
} deriving (Show, Eq)

jugadorEjemplo::Personaje
jugadorEjemplo = UnPersonaje "Steve" 1000 ["Sueter", "Fogata", "Pollo", "Pollo", "Madera", "Fósforo"]

fogata::Receta
fogata = UnaReceta ["Madera", "Fósforo"] "Fogata" 10

polloAsado::Receta
polloAsado = UnaReceta ["Pollo", "Fogata"] "Pollo Asado" 300

sueter::Receta
sueter = UnaReceta ["Lana", "Aguja", "Tintura"] "Sueter" 600

{--
Punto 1: Hacer las funciones necesarias para que un jugador craftee un nuevo objeto
El jugador debe quedar con el nuevo objeto en su inventario
El jugador debe quedar sin los materiales usados para craftear
La cantidad de puntos del jugador se incrementa a razón de 10 puntos por segundo utilizado en el crafteo.
El objeto se craftea sólo si se cuenta con todos los materiales requeridos antes de comenzar la tarea. En caso contrario, no se altera el inventario, pero se pierden 100 puntos.
--}

tieneMateriales::Receta->Personaje->Bool
tieneMateriales receta personaje = all (\material -> elem material (inventario personaje)) (materiales receta)

sacarMateriales :: [Material] -> Personaje -> Personaje
sacarMateriales materiales jugador = jugador {
  inventario = foldr sacarUnaAparicion (inventario jugador) materiales
}

sacarUnaAparicion::Material->[Material]->[Material]
sacarUnaAparicion _ [] = []
sacarUnaAparicion material (x:xs)
  | material == x = xs
  | otherwise = x : sacarUnaAparicion material xs

agregarMaterial::Material->Personaje->Personaje
agregarMaterial material jugador = jugador {inventario = material : inventario jugador}

sumarPuntaje::Int->Personaje->Personaje
sumarPuntaje tiempo jugador = jugador {puntaje = puntaje jugador + tiempo `div` 10}

craftear::Receta->Personaje->Personaje
craftear receta personaje
  | tieneMateriales receta personaje = (sacarMateriales (materiales receta) . agregarMaterial (resultado receta) . sumarPuntaje (tiempo receta)) personaje
  | otherwise = personaje {puntaje = puntaje personaje - 100}

{-- PUNTO 2
Dado un personaje y una lista de recetas: 
Encontrar los objetos que podría craftear un jugador y que le permitirían como mínimo duplicar su puntaje. 
Hacer que un personaje craftee sucesivamente todos los objetos indicados en la lista de recetas. 
Averiguar si logra quedar con más puntos en caso de craftearlos a todos sucesivamente en el orden indicado o al revés.
--}

listaDeRecetas::[Receta]
listaDeRecetas = [fogata, polloAsado, sueter]

objetosQueDuplicanPuntaje::Personaje->[Receta]->[Material]
objetosQueDuplicanPuntaje personaje recetas = filter (\resultado -> puntaje (craftear (buscarReceta resultado recetas) personaje) >= puntaje personaje * 2) (map resultado recetas)

buscarReceta::Material->[Receta]->Receta
buscarReceta material recetas = head (filter (\receta -> resultado receta == material) recetas)

craftearSucesivamente::Personaje->[Receta]->Personaje
craftearSucesivamente personaje recetas = foldl (flip craftear) personaje recetas

puntajeFinal::Personaje->[Receta]->Int
puntajeFinal personaje recetas = puntaje (craftearSucesivamente personaje recetas)

puntajeFinalAlReves::Personaje->[Receta]->Int
puntajeFinalAlReves personaje recetas = puntaje (craftearSucesivamente personaje (reverse recetas))

quedaConMasPuntos::Personaje->[Receta]->Bool
quedaConMasPuntos personaje recetas = puntajeFinal personaje recetas > puntajeFinalAlReves personaje recetas


-- MINE https://docs.google.com/document/d/1i9rB5AzRswz_0Z4T1v5IgRhC3UT-d_Ib1K7LUeq5sa0/edit