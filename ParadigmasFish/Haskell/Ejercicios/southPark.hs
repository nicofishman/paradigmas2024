{-
Parte 1:
Actividades de los personajes

En el pueblo de South Park, hay varios personajes conocidos. De cada uno se conoce su nombre, la cantidad de dinero que posee y su nivel de felicidad (que puede ser mayor o igual a cero, pero nunca negativo).

Los personajes pueden realizar diversas actividades que los afectan de la siguiente manera:
Ir a la escuela primaria de South Park: resta 20 de felicidad al personaje, a excepción de Butters, quien aumenta su felicidad en la misma cantidad.
Comer una cierta cantidad de Cheesy Poofs: aumenta 10 de felicidad y resta 10$ por cada Cheesy Poof consumido.
Ir a trabajar: ganan una cantidad de dinero dependiendo del trabajo. Si es en el "Restaurante de City Wok", ganan 23$ porque tiene 23 caracteres.
Hacer doble turno: implica ir a trabajar el doble de tiempo y restar tanta felicidad como caracteres tenga el trabajo.
Jugar World of Warcraft: por cada amigo con el que juega cada hora aumenta 10 de felicidad, y por cada hora pierde $10. A partir de las 5 horas no aumenta más la felicidad, pero el dinero sigue disminuyendo.
Por ejemplo, si Stan juega con 3 amigos por 8 horas aumenta en 150 su felicidad y pierde $80.
Realizar una actividad inventada que modifique al personaje de alguna manera.

Modelar algunos personajes, implementar las acciones mencionadas y mostrar ejemplos de invocación y respuesta:
Cartman come una docena de Cheesy Poofs.
Stan hace doble turno barriendo la nieve.
Butters va a la escuela y luego realiza la actividad inventada.
-}
data Personaje =
  UnPersonaje { nombre :: String, dinero :: Float, felicidad :: Float }
  deriving (Show)

irALaEscuelaPrimaria :: Personaje -> Personaje
irALaEscuelaPrimaria personaje
  | nombre personaje == "Butters" =
    personaje { felicidad = felicidad personaje + 20 }
  | otherwise = personaje { felicidad = felicidad personaje - 20 }

comerCheesyPoofs :: Personaje -> Int -> Personaje
comerCheesyPoofs personaje cantidad =
  personaje { dinero = dinero personaje - (10 * fromIntegral cantidad)
            , felicidad = felicidad personaje + 10 * fromIntegral cantidad
            }

irATrabajar :: Personaje -> String -> Personaje
irATrabajar personaje trabajo =
  personaje { dinero = dinero personaje + fromIntegral (length trabajo) }

trabajarXTurnos :: Personaje -> String -> Int -> Personaje
trabajarXTurnos personaje trabajo turnos =
  personaje { dinero = dinero personaje + fromIntegral (length trabajo) * fromIntegral turnos }

hacerDobleTurno :: Personaje -> String -> Personaje
hacerDobleTurno personaje trabajo = (trabajarXTurnos personaje trabajo 2) { felicidad = felicidad personaje - fromIntegral (length trabajo) * 2 }

-- Jugar World of Warcraft: por cada amigo con el que juega cada hora aumenta 10 de felicidad, y por cada hora pierde $10. A partir de las 5 horas no aumenta más la felicidad, pero el dinero sigue disminuyendo. 
jugarWOW :: Personaje -> [Personaje] -> Int -> Personaje
jugarWOW personaje amigos horas = personaje {
  felicidad = felicidad personaje + 10 * fromIntegral (length amigos) * fromIntegral (min 5 horas),
  dinero = dinero personaje - 10 * fromIntegral horas
}

-- Realizar una actividad inventada que modifique al personaje de alguna manera.
cocinarCeviche :: Personaje -> Personaje
cocinarCeviche personaje = personaje { felicidad = felicidad personaje + 50 }