-- Los Nomus son humanos mutados que poseen distintas capacidades físicas, como
-- tener alas, múltiples brazos, cantidad de ojos y el color de piel, además de tener una
-- cantidad de vida y fuerza.

-- Luego se nos pide averiguar si puede ver, es decir, si tiene ojos y su categoría.

data Poder = UnPoder
    { cantCura     :: Int,
      cantDanio    :: Int,
      rangoAtaque  :: Int,
      probaCritico :: Int
    }

data Nomu = UnNomu
    { tieneAlas  :: Bool,
      cantBrazos :: Int,
      color      :: String,
      vida       :: Int,
      fuerza     :: Int,
      cantOjos   :: Int,
      poderes    :: [Poder]
    }

categorizarNomu :: Nomu -> String
categorizarNomu nomu
    | f > 1000 && f < 3000 = "Común"
    | f < 10000 = "Fuerte"
    | f > 10000 = "High-end"
    | otherwise = "Pichi"
  where
    f = fuerza nomu

puedeVer :: Nomu -> Bool
puedeVer nomu = ojos > 0
  where
    ojos = cantOjos nomu

-- Averiguar la probabilidad de daño crítico del último poder que un Nomu consiguió.
probaDanioCriticoUltimoPoder :: Nomu -> Int
probaDanioCriticoUltimoPoder nomu = probaCritico (last (poderes nomu))

-- Saber si un poder es usado cuerpo a cuerpo, esto está definido por su rango de ataque, siendo cuerpo a cuerpo si el rango es menor a 100.
esPoderCuerpoACuerpo :: Poder -> Bool
esPoderCuerpoACuerpo poder = rangoAtaque poder < 100

-- Saber si un poder es solamente de curación(esto pasa cuando no tiene cantidad de daño por uso y si tiene curación por uso)
esPoderSolamenteCuracion :: Poder -> Bool
esPoderSolamenteCuracion poder = cantDanio poder == 0 && cantCura poder > 0
