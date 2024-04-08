-- En una plantación de pinos, de cada árbol se conoce la altura expresada en metros. El peso de un pino se puede calcular a partir de la altura así:
-- 3 kg por cada centímetro hasta 3 metros,
-- 2 kg por cada centímetro arriba de los 3 metros.

-- Definí la función pesoPino, que recibe la altura de un pino en metros y devuelve su peso.
-- Definí la función esPesoUtil, que recibe un peso en kg y responde si un pino de ese peso le sirve a la fábrica
-- Los pinos se usan para llevarlos a una fábrica de muebles, a la que le sirven árboles de entre 400 y 1000 kilos, un pino fuera de este rango no le sirve a la fábrica.
-- Definí la función sirvePino, que recibe la altura de un pino y responde si un pino de ese peso le sirve a la fábrica. Si ya conocés el concepto de composición, esta función debe definirse usando composición.

pesoPino:: Float -> Float
pesoPino altura
    | altura <= 3 = altura * 100 * 3
    | otherwise = 3*3*100 + (altura - 3) * 2 * 100

esPesoUtil:: Float -> Bool
esPesoUtil peso = peso >= 400 && peso <= 1000

sirvePino:: Float -> Bool
sirvePino = esPesoUtil . pesoPino

-- Una empresa abre una cierta cantidad de sucursales y necesita contratar nuevos empleados. La cantidad de empleados para cada sucursal es la misma, y se calcula según el nombre de la empresa, de la siguiente manera:

-- Si la empresa es "Acme", son 10 empleados.
-- Si el nombre de la empresa termina con una letra menor que la con que empieza, son tantos empleados como letras intermedias (o sea, el nombre sin considerar la primera y la última letra).
-- Por ejemplo "star", contrata 2 empleados por sucursal.
-- Si el nombre es capicúa y tiene cantidad par de letras, los empleados son el doble de la cantidad de letras intermedias.
-- Por ejemplo, "NOXXON", son 8.
-- Si la cantidad de letras del nombre es divisible por 3 o por 7, la cantidad de empleados es la cantidad de copas del mundo ganadas por Argentina.
-- En cualquier otro caso, no se contratan empleados para cada sucursal.

-- El objetivo final es obtener la cantidad total de empleados que va a contratar una empresa

cantEmpleados :: String -> Int
esCapicua :: String -> Bool
esDivisible :: Int -> Int -> Bool
esDivisible anio divisor = anio `mod` divisor == 0

esCapicua nombre = nombre == reverse nombre

cantEmpleados "Acme" = 10
cantEmpleados nombre
    | head nombre > last nombre = length nombre - 2
    | even (length nombre) && esCapicua nombre = (length nombre - 2) * 2
    | esDivisible (length nombre) 3 || esDivisible (length nombre) 7 = 3
    | otherwise = 0


-- Averiguar la cantidad de dias de un año

esBisiesto :: Int -> Bool
esBisiesto anio = esDivisible anio 400 || (esDivisible anio 4 && not (esDivisible anio 100))

diasDelAnio :: Int -> Int
diasDelAnio anio
    | esBisiesto anio = 366
    | otherwise = 365

-- Obtener el factorial de un número
factorial:: Int -> Int

factorial 0 = 1
factorial n = n * factorial (n-1)
