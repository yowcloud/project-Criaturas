/* Índices ordinarios */


-- columna nombre_criatura de la tabla criaturas
CREATE INDEX idx_nombre_criatura ON criaturas(nombre_criatura);

--  columna nombre_localizacion de la tabla ubicaciones
CREATE INDEX idx_nombre_localizacion ON ubicaciones(nombre_localizacion);

-- columna fecha de la tabla testimonios
CREATE INDEX idx_fecha ON testimonios(fecha);

-- columna ubicacion de la tabla ubicaciones
CREATE INDEX idx_ubicacion_descripcion ON ubicaciones(descripcion);


/* TESTS */
/*
SELECT * FROM criaturas WHERE nombre_criatura = 'Nombre de la criatura';


SELECT * FROM ubicaciones WHERE nombre_localizacion = 'Nombre de la ubicación';


SELECT * FROM testimonios WHERE fecha = '2024-03-11';


SELECT * FROM ubicaciones WHERE descripcion LIKE '%Descripción%';

*/