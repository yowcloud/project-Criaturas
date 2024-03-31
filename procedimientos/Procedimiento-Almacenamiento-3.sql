USE avistamiento_criaturas;
USE avistamiento_criaturas_backup;
USE vistas_backup;

DROP PROCEDURE IF EXISTS vista_backup_tipos_creaturas;
DROP PROCEDURE IF EXISTS vista_backup_mitologias;
DROP PROCEDURE IF EXISTS vista_y_backup_nivel_riesgo;
DROP PROCEDURE IF EXISTS vista_backup_caracteristicas;

SHOW TABLES LIKE 'tipos_creaturas_backup';



DELIMITER //

CREATE PROCEDURE vista_backup_tipos_creaturas(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_nombre_tipo VARCHAR(50);
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT tipo_id, nombre_tipo, descripcion, fecha_backup, usuario
        FROM view_tipos_creaturas_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    # Crear tabla temporal
    CREATE TEMPORARY TABLE IF NOT EXISTS tmp_backup
    (
        tipo_id INT PRIMARY KEY AUTO_INCREMENT,
        nombre_tipo VARCHAR(50) NOT NULL,
        descripcion VARCHAR(512) NOT NULL,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    # Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_backup (nombre_tipo, descripcion, fecha_backup, usuario)
    SELECT nombre_tipo, descripcion, fecha_backup, usuario
    FROM tipos_creaturas_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_id, v_nombre_tipo, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_backup
            WHERE nombre_tipo = v_nombre_tipo
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    # Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;


CALL vista_backup_tipos_creaturas(1);
SELECT @mensaje_tipos_creaturas;

#CALL vista_backup_tipos_creaturas (@mensage_tipos_creaturas);
#SELECT @mensage_tipos_creaturas;


DELIMITER //

CREATE PROCEDURE vista_backup_mitologias(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_nombre_tipo VARCHAR(50);
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT mitologia_id, nombre_tipo, descripcion, fecha_backup, usuario
        FROM view_mitologias_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_backup
    (
        mitologia_id INT PRIMARY KEY AUTO_INCREMENT,
        nombre_tipo VARCHAR(50) NOT NULL,
        descripcion VARCHAR(512) NOT NULL,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de la tabla backup en la tabla temporal
    INSERT INTO tmp_backup (nombre_tipo, descripcion, fecha_backup, usuario)
    SELECT nombre_tipo, descripcion, fecha_backup, usuario
    FROM mitologias_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_id, v_nombre_tipo, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_backup
            WHERE nombre_tipo = v_nombre_tipo
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_mitologias (@mensage_mitologias);
#SELECT @mensage_mitologias;

DELIMITER //

CREATE PROCEDURE vista_backup_clasificacion(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_nombre_clasificacion_id CHAR(12);
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_tipo_creatura_id INT;
    DECLARE v_mitologia_id INT;
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id, fecha_backup, usuario
        FROM view_clasificacion_criaturas_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_clasificacion_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre_clasificacion_id CHAR(12) NOT NULL,
        descripcion VARCHAR(512) NOT NULL,
        tipo_creatura_id INT NOT NULL,
        mitologia_id INT NOT NULL,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_clasificacion_backup (nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id, fecha_backup, usuario)
    SELECT nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id, fecha_backup, usuario
    FROM clasificacion_criaturas_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_nombre_clasificacion_id, v_descripcion, v_tipo_creatura_id, v_mitologia_id, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_clasificacion_backup
            WHERE nombre_clasificacion_id = v_nombre_clasificacion_id
            AND descripcion = v_descripcion
            AND tipo_creatura_id = v_tipo_creatura_id
            AND mitologia_id = v_mitologia_id
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_clasificacion_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_clasificacion_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_clasificacion (@mensage_clasificacion);
#SELECT @mensage_clasificacion;

DELIMITER //

CREATE PROCEDURE vista_y_backup_nivel_riesgo(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_riesgo_id INT;
    DECLARE v_nivel_riesgo ENUM('Alto','Medio','Bajo');
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT riesgo_id, nivel_riesgo, descripcion, fecha_backup, usuario
        FROM view_nivel_riesgo_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_nivel_riesgo_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        riesgo_id INT,
        nivel_riesgo ENUM('Alto','Medio','Bajo') NOT NULL,
        descripcion VARCHAR(512) NOT NULL CHECK (LENGTH(descripcion) >= 10),
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_nivel_riesgo_backup (riesgo_id, nivel_riesgo, descripcion, fecha_backup, usuario)
    SELECT riesgo_id, nivel_riesgo, descripcion, fecha_backup, usuario
    FROM nivel_riesgo_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_riesgo_id, v_nivel_riesgo, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_nivel_riesgo_backup
            WHERE riesgo_id = v_riesgo_id
            AND nivel_riesgo = v_nivel_riesgo
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_nivel_riesgo_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_nivel_riesgo_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_y_backup_nivel_riesgo (@mensage_nivel_riesgo);
#SELECT @mensage_nivel_riesgo;

DELIMITER //

CREATE PROCEDURE vista_backup_caracteristicas(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_caracteristicas_id INT;
    DECLARE v_riesgo_id INT;
    DECLARE v_ubicacion VARCHAR(70);
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT caracteristicas_id, riesgo_id, ubicacion, descripcion, fecha_backup, usuario
        FROM view_caracteristicas_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_caracteristicas_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        caracteristicas_id INT,
        riesgo_id INT,
        ubicacion VARCHAR(70) NOT NULL,
        descripcion VARCHAR(512) NOT NULL,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_caracteristicas_backup (caracteristicas_id, riesgo_id, ubicacion, descripcion, fecha_backup, usuario)
    SELECT caracteristicas_id, riesgo_id, ubicacion, descripcion, fecha_backup, usuario
    FROM caracteristicas_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_caracteristicas_id, v_riesgo_id, v_ubicacion, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_caracteristicas_backup
            WHERE caracteristicas_id = v_caracteristicas_id
            AND riesgo_id = v_riesgo_id
            AND ubicacion = v_ubicacion
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_caracteristicas_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_caracteristicas_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_caracteristicas (@mensage_caracteristicas);
#SELECT @mensage_caracteristicas;

DELIMITER //

CREATE PROCEDURE vista_backup_criaturas(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_criatura_id INT;
    DECLARE v_nombre_criatura VARCHAR(75);
    DECLARE v_caracteristicas_id INT;
    DECLARE v_descripcion_id VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT criatura_id, nombre_criatura, caracteristicas_id, descripcion_id, fecha_backup, usuario
        FROM view_criaturas_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_criaturas_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        criatura_id INT,
        nombre_criatura VARCHAR(75) NOT NULL,
        caracteristicas_id INT,
        descripcion_id VARCHAR(512),
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_criaturas_backup (criatura_id, nombre_criatura, caracteristicas_id, descripcion_id, fecha_backup, usuario)
    SELECT criatura_id, nombre_criatura, caracteristicas_id, descripcion_id, fecha_backup, usuario
    FROM criaturas_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_criatura_id, v_nombre_criatura, v_caracteristicas_id, v_descripcion_id, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_criaturas_backup
            WHERE criatura_id = v_criatura_id
            AND nombre_criatura = v_nombre_criatura
            AND caracteristicas_id = v_caracteristicas_id
            AND descripcion_id = v_descripcion_id
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_criaturas_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_criaturas_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_criaturas (@mensage_criaturas);
#SELECT @mensage_criaturas;

DELIMITER //

CREATE PROCEDURE vista_backup_evidencias(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_evidencia_id INT;
    DECLARE v_tipo_evidencia CHAR(5);
    DECLARE v_url_tipo_evidencia VARCHAR(2048);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT evidencia_id, tipo_evidencia, url_tipo_evidencia, fecha_backup, usuario
        FROM evidencias_vista;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_evidencias_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        evidencia_id INT,
        tipo_evidencia CHAR(5) NOT NULL,
        url_tipo_evidencia VARCHAR(2048),
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_evidencias_backup (evidencia_id, tipo_evidencia, url_tipo_evidencia, fecha_backup, usuario)
    SELECT evidencia_id, tipo_evidencia, url_tipo_evidencia, fecha_backup, usuario
    FROM view_evidencias_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_evidencia_id, v_tipo_evidencia, v_url_tipo_evidencia, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_evidencias_backup
            WHERE evidencia_id = v_evidencia_id
            AND tipo_evidencia = v_tipo_evidencia
            AND url_tipo_evidencia = v_url_tipo_evidencia
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_evidencias_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_evidencias_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_evidencias (@mensage_evidencias);
#SELECT @mensage_evidencias;

DELIMITER //

CREATE PROCEDURE vista_backup_testigos(
    OUT mensaje VARCHAR(255)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_testigo_id INT;
    DECLARE v_nombre_testigo VARCHAR(50);
    DECLARE v_edad INT;
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);
    DECLARE v_genero ENUM('masculino', 'femenino', 'otro');
    DECLARE v_numero_contacto CHAR(9);

    DECLARE cur_vista CURSOR FOR
        SELECT testigo_id, nombre_testigo, edad, fecha_backup, usuario, genero, numero_contacto
        FROM view_testigos_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_testigos_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        testigo_id INT,
        nombre_testigo VARCHAR(50) NOT NULL,
        edad INT,
        fecha_backup DATETIME,
        usuario VARCHAR(255),
        genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
        numero_contacto CHAR(9) UNIQUE NOT NULL
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_testigos_backup (testigo_id, nombre_testigo, edad, fecha_backup, usuario, genero, numero_contacto)
    SELECT testigo_id, nombre_testigo, edad, fecha_backup, usuario, genero, numero_contacto
    FROM testigos_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_testigo_id, v_nombre_testigo, v_edad, v_fecha_backup, v_usuario, v_genero, v_numero_contacto;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_testigos_backup
            WHERE testigo_id = v_testigo_id
            AND nombre_testigo = v_nombre_testigo
            AND edad = v_edad
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
            AND genero = v_genero
            AND numero_contacto = v_numero_contacto
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_testigos_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_testigos_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_testigos (@mensage_testigos);
#SELECT @mensage_testigos;

DELIMITER //

CREATE PROCEDURE vista_backup_testimonios(
    OUT mensaje VARCHAR(255)
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_evidencias_id INT;
    DECLARE v_testigo_id INT;
    DECLARE v_avistamientos_id INT;
    DECLARE v_fecha DATE;
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    DECLARE cur_vista CURSOR FOR
        SELECT evidencias_id, testigo_id, avistamientos_id, fecha, descripcion, fecha_backup, usuario
        FROM view_testimonios_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_testimonios_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        evidencias_id INT,
        testigo_id INT,
        avistamientos_id INT,
        fecha DATE NOT NULL,
        descripcion VARCHAR(512) NOT NULL,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_testimonios_backup (evidencias_id, testigo_id, avistamientos_id, fecha, descripcion, fecha_backup, usuario)
    SELECT evidencias_id, testigo_id, avistamientos_id, fecha, descripcion, fecha_backup, usuario
    FROM testimonios_backup;

    OPEN cur_vista;

    read_loop: LOOP
        FETCH cur_vista INTO v_evidencias_id, v_testigo_id, v_avistamientos_id, v_fecha, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_testimonios_backup
            WHERE evidencias_id = v_evidencias_id
            AND testigo_id = v_testigo_id
            AND avistamientos_id = v_avistamientos_id
            AND fecha = v_fecha
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_testimonios_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_testimonios_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_testimonios (@mensage_testimonios);
#SELECT @mensage_testimonios;

DELIMITER //

CREATE PROCEDURE vista_backup_ubicaciones(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_ubicacion_id INT;
    DECLARE v_nombre_localizacion VARCHAR(60);
    DECLARE v_descripcion VARCHAR(512);
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    -- Cursor para la vista
    DECLARE cur_vista CURSOR FOR
        SELECT ubicacion_id, nombre_localizacion, descripcion, fecha_backup, usuario
        FROM view_ubicaciones_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_ubicaciones_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        ubicacion_id INT,
        nombre_localizacion VARCHAR(60) NOT NULL,
        descripcion VARCHAR(512),
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_ubicaciones_backup (ubicacion_id, nombre_localizacion, descripcion, fecha_backup, usuario)
    SELECT ubicacion_id, nombre_localizacion, descripcion, fecha_backup, usuario
    FROM ubicaciones_backup;

    OPEN cur_vista;

    -- Recorrer la vista y comparar con la tabla temporal
    read_loop: LOOP
        FETCH cur_vista INTO v_ubicacion_id, v_nombre_localizacion, v_descripcion, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_ubicaciones_backup
            WHERE ubicacion_id = v_ubicacion_id
            AND nombre_localizacion = v_nombre_localizacion
            AND descripcion = v_descripcion
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_ubicaciones_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_ubicaciones_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;

#CALL vista_backup_ubicaciones (@mensage_ubicaciones);
#SELECT @mensage_ubicaciones;

DELIMITER //

CREATE PROCEDURE vista_backup_avistamientos(OUT mensaje VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_avistamientos_id INT;
    DECLARE v_criatura_id INT;
    DECLARE v_ubicacion_id INT;
    DECLARE v_fecha_backup DATETIME;
    DECLARE v_usuario VARCHAR(255);

    -- Cursor para la vista
    DECLARE cur_vista CURSOR FOR
        SELECT avistamientos_id, criatura_id, ubicacion_id, fecha_backup, usuario
        FROM view_avistamientos_backup;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Crear tabla temporal
    CREATE TEMPORARY TABLE tmp_avistamientos_backup
    (
        id INT PRIMARY KEY AUTO_INCREMENT,
        avistamientos_id INT,
        criatura_id INT,
        ubicacion_id INT,
        fecha_backup DATETIME,
        usuario VARCHAR(255)
    );

    -- Insertar datos de todas las tablas backup en la tabla temporal
    INSERT INTO tmp_avistamientos_backup (avistamientos_id, criatura_id, ubicacion_id, fecha_backup, usuario)
    SELECT avistamientos_id, criatura_id, ubicacion_id, fecha_backup, usuario
    FROM avistamientos_backup;

    OPEN cur_vista;

    -- Recorrer la vista y comparar con la tabla temporal
    read_loop: LOOP
        FETCH cur_vista INTO v_avistamientos_id, v_criatura_id, v_ubicacion_id, v_fecha_backup, v_usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Comprobar que el resultado de la vista es igual al resultado de la tabla temporal registro a registro
        IF NOT EXISTS (
            SELECT * FROM tmp_avistamientos_backup
            WHERE avistamientos_id = v_avistamientos_id
            AND criatura_id = v_criatura_id
            AND ubicacion_id = v_ubicacion_id
            AND fecha_backup = v_fecha_backup
            AND usuario = v_usuario
        ) THEN
            SET mensaje = 'KO: La vista y la tabla backup no coinciden.';
            CLOSE cur_vista;
            DROP TEMPORARY TABLE IF EXISTS tmp_avistamientos_backup;
            LEAVE read_loop;
        END IF;
    END LOOP;

    CLOSE cur_vista;

    -- Eliminar la tabla temporal
    DROP TEMPORARY TABLE IF EXISTS tmp_avistamientos_backup;

    SET mensaje = 'OK: La vista y la tabla backup coinciden.';
END//

DELIMITER ;


#CALL vista_backup_ubicaciones (@mensage_avistamientos);
#SELECT @mensage_avistamientos;