-- https://docs.google.com/document/d/1g2Gc81R62_xAIiGF0H663ypAz1vxJybr5LDo1sj9tAU/edit

data Auto = UnAuto {
  color :: Color,
  velocidad :: Int,
  distancia :: Int
} deriving (Show, Eq)

type Carrera = [Auto]
type Color = String

-- 1a Saber si un auto está cerca de otro auto, que se cumple si son autos distintos y la distancia que hay entre ellos (en valor absoluto) es menor a 10.
estaCerca::Auto->Auto->Bool
estaCerca a1 a2
  | color a1 == color a2 = False
  | otherwise = abs (distancia a1 - distancia a2) < 10

-- 1b Saber si un auto va tranquilo en una carrera, que se cumple si no tiene ningún auto cerca y les va ganando a todos (por haber recorrido más distancia que los otros).
vaTranquilo::Carrera->Auto->Bool
vaTranquilo carrera auto = all (\a2 -> not (estaCerca auto a2) && distancia auto > distancia a2) carrera

-- 1c Conocer en qué puesto está un auto en una carrera, que es 1 + la cantidad de autos de la carrera que le van ganando.
puesto::Carrera->Auto->Int
puesto carrera auto = 1 + length (filter (\a2 -> distancia auto < distancia a2) carrera)

-- 2a Hacer que un auto corra durante un determinado tiempo. Luego de correr la cantidad de tiempo indicada, la distancia recorrida por el auto debería ser equivalente a la distancia que llevaba recorrida + ese tiempo * la velocidad a la que estaba yendo.
correr::Int->Auto->Auto
correr tiempo auto = auto {distancia = distancia auto + tiempo * velocidad auto}

-- 2bi A partir de un modificador de tipo Int -> Int, queremos poder alterar la velocidad de un auto de modo que su velocidad final sea la resultante de usar dicho modificador con su velocidad actual.
type Modificador = Int -> Int

aplicarModificador::Modificador->Auto->Auto
aplicarModificador modificador auto = auto {velocidad = modificador (velocidad auto)}

-- 2bii Usar la función del punto anterior para bajar la velocidad de un auto en una cantidad indicada de modo que se le reste a la velocidad actual la cantidad indicada, y como mínimo quede en 0, ya que no es válido que un auto quede con velocidad negativa.
frenar::Int->Auto->Auto
frenar cantidad = aplicarModificador (\vel -> max 0 (vel - cantidad))

-- 3
afectarALosQueCumplen :: (a -> Bool) -> (a -> a) -> [a] -> [a]
afectarALosQueCumplen criterio efecto lista
  = (map efecto . filter criterio) lista ++ filter (not.criterio) lista

-- 3a. PowerUp terremoto: luego de usar este poder, los autos que están cerca del que gatilló el power up bajan su velocidad en 50.
terremoto::PowerUp
terremoto auto = afectarALosQueCumplen (estaCerca auto) (frenar 50)

-- 3b. PowerUp miguelitos: este poder debe permitir configurarse con una cantidad que indica en cuánto deberán bajar la velocidad los autos que se vean afectados por su uso. Los autos a afectar son aquellos a los cuales el auto que gatilló el power up les vaya ganando.
miguelitos::Int->PowerUp
miguelitos cantidad auto = afectarALosQueCumplen (\a2 -> distancia auto > distancia a2) (frenar cantidad)

-- 3c. PowerUp jet pack: este poder debe afectar, dentro de la carrera, solamente al auto que gatilló el poder. El jet pack tiene un impacto que dura una cantidad limitada de tiempo, el cual se espera poder configurar.
-- Cuando se activa el poder del jet pack, el auto afectado duplica su velocidad actual, luego corre durante el tiempo indicado y finalmente su velocidad vuelve al valor que tenía antes de que se active el poder.
-- Por simplicidad, no se espera que los demás autos que participan de la carrera también avancen en ese tiempo.
esElAuto::Auto->Auto->Bool
esElAuto a1 a2 = color a1 == color a2

aplicarModificadorSoloAlAuto::Modificador->Auto->Auto->Auto
aplicarModificadorSoloAlAuto modificador auto autoAfectado
  | esElAuto auto autoAfectado  = aplicarModificador modificador auto
  | otherwise = auto

jetPack::Int->PowerUp
jetPack tiempo auto = afectarALosQueCumplen (esElAuto auto) (aplicarModificadorSoloAlAuto (* 2) auto . correr tiempo . aplicarModificadorSoloAlAuto (`div` 2) auto)

-- 4 A partir de todo lo construido hasta ahora queremos finalmente simular una carrera, para lo cual se provee una lista de eventos, que son funciones que permiten ir de un estado de la carrera al siguiente, y el estado inicial de la carrera a partir del cual se producen dichos eventos. Con esta información buscamos generar una “tabla de posiciones”, que incluye la información de en qué puesto quedó cada auto asociado al color del auto en cuestión.

type Evento = Carrera -> Carrera

-- 4a. simularCarrera :: Carrera -> [Carrera -> Carrera] -> [(Int, Color)] que permita obtener la tabla de posiciones a partir del estado final de la carrera, el cual se obtiene produciendo cada evento uno detrás del otro, partiendo del estado de la carrera recibido.

simularCarrera :: Carrera -> [Evento] -> [(Int, Color)]
simularCarrera carrera ev = zip [1..] (map color (foldl (\c e -> e c) carrera ev))

-- 4b. Desarrollar las siguientes funciones de modo que puedan usarse para generar los eventos que se dan en una carrera:
-- 4bi correnTodos: que hace que todos los autos que están participando de la carrera corran durante un tiempo indicado. 
correnTodos::Int->Carrera->Carrera
correnTodos tiempo = map (correr tiempo)

--4bii usaPowerUp: que a partir de un power up y del color del auto que gatilló el poder en cuestión, encuentre el auto correspondiente dentro del estado actual de la carrera para usarlo y produzca los efectos esperados para ese power up.
encontrarAuto::Color->Carrera->Auto
encontrarAuto colorAuto carrera = head (filter (\auto -> color auto == colorAuto) carrera)

type PowerUp = Auto->Carrera->Carrera

usaPowerUp::PowerUp->Color->Carrera->Carrera
usaPowerUp powerUp colorAuto carrera = powerUp (encontrarAuto colorAuto carrera) carrera

{-
4c.
Mostrar un ejemplo de uso de la función simularCarrera con autos de colores rojo, blanco, azul y negro que vayan inicialmente a velocidad 120 y su distancia recorrida sea 0, de modo que ocurran los siguientes eventos:
- todos los autos corren durante 30 segundos
- el azul usa el power up de jet pack por 3 segundos
- el blanco usa el power up de terremoto
- todos los autos corren durante 40 segundos
- el blanco usa el power up de miguelitos que reducen la velocidad en 20
- el negro usa el power up de jet pack por 6 segundos
- todos los autos corren durante 10 segundos
-}

azul::Auto
azul = UnAuto "azul" 120 0

rojo::Auto
rojo = UnAuto "rojo" 120 0

blanco::Auto
blanco = UnAuto "blanco" 120 0

negro::Auto
negro = UnAuto "negro" 120 0

carrera1 :: [Auto]
carrera1 = [azul,rojo,blanco,negro]

eventos1 :: [Carrera -> Carrera]
eventos1 = [correnTodos 30,usaPowerUp (jetPack 3) "azul",usaPowerUp terremoto "blanco",correnTodos 40,
            usaPowerUp (miguelitos 20) "blanco",usaPowerUp (jetPack 6) "negro",correnTodos 10]


