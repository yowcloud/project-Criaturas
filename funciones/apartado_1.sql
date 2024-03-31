/*
    La función valida si un correo electrónico es válido según ciertas reglas:
    - Debe contener letras o números (sin espacios) seguido de un @
    - Seguido de más letras (sin espacios y minúsculas),
    - Seguido de un punto
    - Seguido de más letras.
    Esta función devuelve un booleano con true o false en función de si es correcto o no.
*/

DELIMITER //
CREATE FUNCTION validarEmail(email VARCHAR(255))
RETURNS BOOLEAN
BEGIN
   DECLARE valido BOOLEAN;

    IF email REGEXP '^[a-zA-Z0-9]+@[a-z]+\\.[a-z]{2,}$' THEN
       SET valido = TRUE;
    ELSE
        SET valido = FALSE;
    END IF;

    RETURN valido;
END //
DELIMITER ;



 /*
    La función recibe dos números y un booleano.
    Si el booleano es true devuelve el más grande y si es false el más pequeño.
 */

DELIMITER //
CREATE FUNCTION numeroMax(numb1 INT, numb2 INT, mayor BOOLEAN)
RETURNS INT
BEGIN
    DECLARE maxNumb INT;

    IF mayor THEN
        SET maxNumb = GREATEST(numb1, numb2);
    ELSE
        SET maxNumb = LEAST(numb1, numb2);
    END IF;

    RETURN maxNumb;
END //
DELIMITER ;

/*
    Función que recibe un número y un carácter.
    La función tiene que devolver un String con tantos carácteres recibidos por parámetro como el número que recibe.
*/

DELIMITER //
CREATE FUNCTION generarString(longitud INT, caracter CHAR(1)) RETURNS VARCHAR(255)
BEGIN
    DECLARE resultado VARCHAR(255);
    SET resultado = REPEAT(caracter, longitud);
    RETURN resultado;
END //
DELIMITER ;
/*
-- Pruebas para la función validarEmail
SELECT validarEmail('usuario@example.com') AS correo_valido_0;        -- Debería devolver 1 (TRUE)
SELECT validarEmail('usuario12@example.com') AS correo_valido_1;        -- Debería devolver 1 (TRUE)
SELECT validarEmail('nombre.apellido@dominio.com') AS correo_valido_2; -- Debería devolver 0 (FALSE)
SELECT validarEmail('usuario@.com') AS correo_invalido_1;             -- Debería devolver 0 (FALSE)
SELECT validarEmail('usuario@dominio') AS correo_invalido_2;          -- Debería devolver 0 (FALSE)
SELECT validarEmail('@dominio.com') AS correo_invalido_3;              -- Debería devolver 0 (FALSE)
SELECT validarEmail('usuario@dominio.') AS correo_invalido_4;         -- Debería devolver 0 (FALSE)
SELECT validarEmail('usuario@dominio..com') AS correo_invalido_5;     -- Debería devolver 0 (FALSE)
SELECT validarEmail('usuario@dominio.com.') AS correo_invalido_6;     -- Debería devolver 0 (FALSE)


-- Pruebas para la función numeroMax
SELECT numeroMax(10, 20, TRUE) AS mayor_1;  -- Debería devolver 20
SELECT numeroMax(100, 50, TRUE) AS mayor_2;  -- Debería devolver 100
SELECT numeroMax(10, 20, FALSE) AS menor_1;  -- Debería devolver 10
SELECT numeroMax(100, 50, FALSE) AS menor_2;  -- Debería devolver 50
SELECT numeroMax(-20, 30, FALSE) AS menor_3; -- Debería devolver -20

-- Pruebas para la función generarString
SELECT generarString(5, '*') AS cadena_asteriscos;  -- Debería devolver '*****'
SELECT generarString(3, 'X') AS cadena_X;  -- Debería devolver 'XXX'
SELECT generarString(10, '123') AS cadena_numeros;  -- Debería devolver '1231231231'
SELECT generarString(5, '@') AS cadena_arroba;  -- Debería devolver '@@@@@'
SELECT generarString(8, '#$%') AS cadena_especial;  -- Debería devolver '#$%#$%#$%#$%'
*/
