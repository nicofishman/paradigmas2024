-- Calcular el sueldo de un docente universitario de UTN, dado su cargo, cantidad de horas que trabaja, y su antigüedad en años.
-- El básico depende del cargo que tenga la persona, también tiene un adicional por antigüedad y luego varía proporcionalmente dependiendo de la cantidad de horas que trabaje.

-- Básico: El básico por cargo (Noviembre 2023) es el siguiente:
-- "titular": $ 149000
-- "adjunto": $ 116000
-- "ayudante": $ 66000

-- Antiguedad: El porcentaje de incremento por antigüedad es:
-- Entre 3 y 5 años -> 20% adicional 
-- a partir de 5 años -> 30% adicional
-- a partir de 10 años -> 50% adicional
-- a partir de 24 años (máxima antigüedad) -> 120% adicional


-- Cantidad de horas: La proporcionalidad de horas se calcula asumiendo que el importe por cargo corresponde a 10 horas semanales. Si trabaja 10hs se paga el sueldo base. Si trabaja 30 hs, se paga el sueldo base por 3. El valor se redondea, de manera que si trabaja 22hs se paga el sueldo base por 2, y si trabaja 37 horas se paga el sueldo base por 4. No hay personas que trabajen menos de 5 horas ni más de 50.

basicoEnBaseACargo:: String -> Float
basicoEnBaseACargo cargo
    | cargo == "titular" = 149000
    | cargo == "adjunto" = 116000
    | cargo == "ayudante" = 66000

porcentajePorAntiguedad:: Int -> Float
porcentajePorAntiguedad antiguedad
    | antiguedad < 3 = 1
    | antiguedad < 5 = 1.2
    | antiguedad < 10 = 1.3
    | antiguedad < 24 = 1.5
    | otherwise = 2.2

proporcionalidadDeHoras:: Int -> Float
proporcionalidadDeHoras horas = fromIntegral (round (fromIntegral horas / 10))

calcularSueldo :: String -> Int -> Int -> Float
calcularSueldo cargo antiguedad horas = basicoEnBaseACargo cargo * porcentajePorAntiguedad antiguedad * proporcionalidadDeHoras horas