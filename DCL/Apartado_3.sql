USE avistamiento_criaturas;

/*Inserts para las Pruebas
INSERT INTO tipos_creaturas (nombre_tipo,descripcion) value  ('hominido','camina a cuatro patas');
INSERT INTO mitologias (nombre_tipo,descripcion) value ('celta', '');*/

# Crear un perfil usuario que tenga privilegios de consulta en todas las tablas sin utilizar el *.

CREATE USER IF NOT EXISTS 'usuario'@'localhost' IDENTIFIED BY 'LaMejorContraseñaDelMundo123';
GRANT SELECT ON tipos_creaturas.* TO Usuario;
GRANT SELECT ON mitologias TO Usuario;
GRANT SELECT ON clasificacion_criaturas TO Usuario;
GRANT SELECT ON nivel_riesgo TO Usuario;
GRANT SELECT ON caracteristicas TO Usuario;
GRANT SELECT ON criaturas TO Usuario;
GRANT SELECT ON evidencias TO Usuario;
GRANT SELECT ON testigos TO Usuario;
GRANT SELECT ON testimonios TO Usuario;
GRANT SELECT ON ubicaciones TO Usuario;
GRANT SELECT ON avistamientos TO Usuario;

/* Crear un procedimiento de almacenado que receive por parámetro un 0 o un 1. Si es 0 se debe eliminar el usuario "usuario"
   mientras que con un 1 se deben volver a crear el usuario "usuario" y darle permisos de lectura .*/

DELIMITER //

CREATE PROCEDURE gestion_Usuarios (IN numero INT)
BEGIN
	IF numero = 0 THEN
		DROP USER IF EXISTS 'usuario'@'localhost';
        SELECT 'usuario fue eliminado';
	ELSE
		CREATE USER IF NOT EXISTS 'usuario'@'localhost';
        GRANT SELECT ON * TO 'usuario'@'localhost';
	END IF;
END//

DELIMITER ;


/* Crear algunas consultas para forzar los triggers del apartado 4 y ver si recoge correctamente el nombre del usuario.
UPDATE tipos_creaturas SET descripcion = 'manos prensiles' WHERE tipo_id = 1;
SELECT * FROM DDBB_CONNECTIONS;

UPDATE mitologias SET descripcion = 'La mitología celta es conocida por una serie de relatos de los celtas durante la Edad del Hierro.' WHERE mitologia_id = 1;
SELECT * FROM DDBB_CONNECTIONS;*/