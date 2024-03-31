
/*
    1. Crea una función que reciba un String y un carácter.
    Esta funcion debe recorrer el String y contar cuantas veces aparece ese carácter. El número resultante lo devuelve.
*/

DELIMITER //
CREATE FUNCTION char_en_cadena(cadena VARCHAR(255), caracter CHAR(1))
RETURNS INT
BEGIN
    DECLARE num_char INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE longitud_cadena INT;

    SET longitud_cadena = LENGTH(cadena);
    WHILE i <= longitud_cadena DO
        IF SUBSTRING(cadena, i, 1) = caracter THEN
            SET num_char = num_char + 1;
        END IF;
        SET i = i + 1;
    END WHILE;
    RETURN num_char;
END //
DELIMITER ;

#Tests
SELECT char_en_cadena('Esta frase tiene muchas es', 'e'); #Ha de devolver 5.
SELECT char_en_cadena('Esta frase tiene pocas us', 'u'); #Ha de devolver 1.
SELECT char_en_cadena('No se que mas poner', 'k'); #Ha de devolver 0.
SELECT char_en_cadena('Realmente espero que funcione', 'e'); #Ha de devolver 7.
SELECT char_en_cadena('Porfavor funciona', 'i'); #Ha de devolver i.



/*
    2. Crea una función que da el promedio de los tres números que le llegan por parámetro. También recibe un cuarto número.
    La función retorna, entre el promedio y el cuarto parámetro, número el más alto de los dos.
*/

DELIMITER //
CREATE FUNCTION promedio_maximo(n1 FLOAT, n2 FLOAT, n3 FLOAT, n4 FLOAT)
RETURNS FLOAT
BEGIN
    DECLARE promedio FLOAT;
    DECLARE num_max FLOAT;

    SET promedio = (n1+n2+n3)/3;
    SET num_max = GREATEST(promedio, n4);
    RETURN num_max;
END //
DELIMITER ;

#Tests
SELECT promedio_maximo(4, 5, 6, 7); #Ha de devolver 7
SELECT promedio_maximo(10, 12, 18, 6); #Ha de devolver 13,333...
SELECT promedio_maximo(1, 1, 1, 0); #Ha de devolver 1
SELECT promedio_maximo(9, 5, 4, 12); #Ha de devolver 12
SELECT promedio_maximo(14, 12, 16, 13); #Ha de devolver 14




/*
    3. Crea una función que recibe por parámetro un string con números separados por comas (ejemplo: '5,2,5,4,7,9') y
    retorna si están ordenados o no (1,0). La función debe recorrer todos los números y mirar si están ordenados.
    Utiliza la función predefinida SUBSTRING_INDEX('5,2,5,4,7,9' , ',' , 1) donde el primer campo es el String, el segundo el campo
    por los que se separan (coma ,) y el último el número de elementos a recuperar. Para que esta función funcione bien tenéis que ir
    quitando elementos al String para con SUBSTRING.
*/

DELIMITER //
CREATE FUNCTION orden_cadena(cadena_numeros VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE current_num INT;
    DECLARE prev_num INT;
    DECLARE rest_cadenda VARCHAR(512);

    SET rest_cadenda = cadena_numeros;
    SET prev_num = CAST(SUBSTRING_INDEX(rest_cadenda, ',', 1) AS UNSIGNED);
    SET rest_cadenda = SUBSTRING(rest_cadenda, LENGTH(prev_num) + 2);

    WHILE LENGTH(rest_cadenda) > 0 DO
        SET current_num = CAST(SUBSTRING_INDEX(rest_cadenda, ',', 1) AS UNSIGNED);
        SET rest_cadenda = SUBSTRING(rest_cadenda, LENGTH(current_num) + 2);
        IF current_num < prev_num THEN
            RETURN 0;
        END IF;
        SET prev_num = current_num;
    END WHILE;

    RETURN 1;
END //
DELIMITER ;

#Tests
SELECT orden_cadena('1,2,3,4,5,6'); #Ha de devolver 1
SELECT orden_cadena('5,2,5,4,7,9'); #Ha de devolver 0
SELECT orden_cadena('12,24,48,96'); #Ha de devolver 1
SELECT orden_cadena('2556,5256,5526,6552,5256'); #Ha de devolver 0
SELECT orden_cadena('1,100000'); #Ha de devolver 1

