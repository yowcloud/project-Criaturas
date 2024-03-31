DROP USER IF EXISTS 'superuser'@'localhost';
DROP PROCEDURE IF EXISTS ModifySuperuserPrivileges;


-- Crear el usuario
CREATE USER 'superuser'@'localhost' IDENTIFIED BY '1234';

-- Otorgar privilegios
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.tipos_creaturas TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.mitologias TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.clasificacion_criaturas TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.nivel_riesgo TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.caracteristicas TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.criaturas TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.evidencias TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.testigos TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.testimonios TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.ubicaciones TO 'superuser'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON avistamiento_criaturas.avistamientos TO 'superuser'@'localhost';


DELIMITER //

CREATE PROCEDURE ModifySuperuserPrivileges(IN param INT)
BEGIN
    IF param = 0 THEN
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.tipos_creaturas FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.mitologias FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.clasificacion_criaturas FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.nivel_riesgo FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.caracteristicas FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.criaturas FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.evidencias FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.testigos FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.ubicaciones FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.avistamientos FROM 'superuser'@'localhost';
        REVOKE INSERT, UPDATE ON avistamiento_criaturas.testimonios FROM 'superuser'@'localhost';
    ELSEIF param = 1 THEN
        GRANT INSERT, UPDATE ON avistamiento_criaturas.tipos_creaturas TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.mitologias TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.clasificacion_criaturas TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.nivel_riesgo TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.caracteristicas TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.criaturas TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.evidencias TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.testigos TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.ubicaciones TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.avistamientos TO 'superuser'@'localhost';
        GRANT INSERT, UPDATE ON avistamiento_criaturas.testimonios TO 'superuser'@'localhost';
    END IF;
    FLUSH PRIVILEGES;
END //

DELIMITER ;

SHOW VARIABLES LIKE 'sql_mode';
SET sql_mode = '';


/* tests mas forzar triggers */
-- Revocar privilegios
CALL ModifySuperuserPrivileges(0);

-- Intentar insertar un nuevo registro en la tabla (fail)
INSERT INTO avistamiento_criaturas.tipos_creaturas (nombre_tipo, descripcion) VALUES ('Unicornio', 'Criatura mítica con forma de caballo y un cuerno en la frente, símbolo de pureza y gracia.');

-- Verificación
SHOW WARNINGS;

-- Intentar actualizar un registro en la tabla (fail)
UPDATE avistamiento_criaturas.mitologias SET descripcion = 'Criatura mágica que habita en bosques encantados y sólo puede ser vista por aquellos de corazón puro' WHERE mitologia_id = 1;

-- Verificación
SHOW WARNINGS;

-- Habilitar privilegios
CALL ModifySuperuserPrivileges(1);

-- Insertar un nuevo registro en la tabla (success)
INSERT INTO avistamiento_criaturas.tipos_creaturas (nombre_tipo, descripcion) VALUES ('Unicornio', 'Criatura mítica con forma de caballo y un cuerno en la frente, símbolo de pureza y gracia.');

-- Verificarción
SHOW WARNINGS;

-- Intentar actualizar un registro en la tabla (success)
UPDATE avistamiento_criaturas.mitologias SET descripcion = 'Criatura mágica que habita en bosques encantados y sólo puede ser vista por aquellos de corazón puro' WHERE mitologia_id = 1;

-- Verificacións
SHOW WARNINGS;
