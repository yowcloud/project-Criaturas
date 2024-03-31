/* Script inicial*/
DROP SCHEMA IF EXISTS avistamiento_criaturas;
CREATE SCHEMA  avistamiento_criaturas;

USE avistamiento_criaturas;

CREATE TABLE tipos_creaturas
(
    tipo_id INT PRIMARY KEY auto_increment,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(512) NOT NULL
);

CREATE TABLE mitologias
(
    mitologia_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(512) NOT NULL
);

CREATE TABLE clasificacion_criaturas
(
    nombre_clasificacion_id CHAR(12) PRIMARY KEY ,
    descripcion VARCHAR(512) NOT NULL,
    tipo_creatura_id INT NOT NULL,
    mitologia_id INT NOT NULL,
    CONSTRAINT fk_tipo_creatura_clasificacion FOREIGN KEY (tipo_creatura_id) REFERENCES tipos_creaturas(tipo_id),
    CONSTRAINT fk_mitologia_clasificacion FOREIGN KEY (mitologia_id) REFERENCES mitologias(mitologia_id)
);

CREATE TABLE nivel_riesgo
(
    riesgo_id INT PRIMARY KEY AUTO_INCREMENT,
    nivel_riesgo enum('Alto','Medio', 'Bajo') NOT NULL ,
    descripcion VARCHAR(512) NOT NULL CHECK (LENGTH(descripcion) >= 10)
);

CREATE TABLE caracteristicas
(
    caracteristicas_id INT PRIMARY KEY AUTO_INCREMENT,
    riesgo_id INT,
    ubicacion VARCHAR(70) NOT NULL,
    descripcion VARCHAR(512) NOT NULL,
    CONSTRAINT fk_riesgo_criatura_id FOREIGN KEY (riesgo_id) REFERENCES nivel_riesgo(riesgo_id)
);


CREATE TABLE criaturas
(
    criatura_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_criatura VARCHAR(75) NOT NULL,
    caracteristicas_id INT,
    descripcion_id VARCHAR (512),
    CONSTRAINT fk_caracteristicas_id FOREIGN KEY (caracteristicas_id) REFERENCES caracteristicas(caracteristicas_id),
    CONSTRAINT fk_descripcion_id FOREIGN KEY (descripcion_id) REFERENCES clasificacion_criaturas(nombre_clasificacion_id)
);


CREATE TABLE evidencias
(
    evidencia_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_evidencia CHAR(5) NOT NULL,
    url_tipo_evidencia VARCHAR(2048)
);

CREATE TABLE testigos
(
    testigo_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_testigo VARCHAR(50) NOT NULL,
    edad INT check (16 <= edad),
    genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
    numero_contacto CHAR(9) UNIQUE NOT NULL
);


CREATE TABLE testimonios
(
    evidencias_id INT,
    fecha date NOT NULL,
    descripcion VARCHAR(512) NOT NULL CHECK (LENGTH(descripcion) BETWEEN 10 AND 512),
    CONSTRAINT fk_evidencias_id FOREIGN KEY (evidencias_id) REFERENCES evidencias(evidencia_id)

);

CREATE TABLE ubicaciones
(
    ubicacion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_localizacion VARCHAR(60) NOT NULL,
    descripcion VARCHAR(512)
);

CREATE TABLE  avistamientos
(
    avistamientos_id INT PRIMARY KEY AUTO_INCREMENT,
    criatura_id INT,
    ubicacion_id INT,
    CONSTRAINT fk_criatura_id FOREIGN KEY (criatura_id) REFERENCES criaturas(criatura_id),
    CONSTRAINT fk_ubicacion_id FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(ubicacion_id)

);

ALTER TABLE testimonios
ADD COLUMN testigo_id int,
ADD COLUMN avistamientos_id int,
ADD CONSTRAINT fk_testigo_id FOREIGN KEY (testigo_id) REFERENCES testigos(testigo_id),
ADD CONSTRAINT fk_avistamientos_id FOREIGN KEY (avistamientos_id) REFERENCES avistamientos(avistamientos_id),
ADD PRIMARY KEY (testigo_id, avistamientos_id);

/* triggers 1 */
/*  Backup schema */
DROP SCHEMA IF EXISTS avistamiento_criaturas_backup;
CREATE SCHEMA  avistamiento_criaturas_backup;

USE avistamiento_criaturas_backup;

CREATE TABLE tipos_creaturas_backup
(
    tipo_id INT PRIMARY KEY auto_increment,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(512) NOT NULL,
    fecha_backup DATETIME,
    usuario VARCHAR(255)
);

CREATE TABLE mitologias_backup
(
    mitologia_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion VARCHAR(512) NOT NULL,
    fecha_backup DATETIME,
    usuario VARCHAR(255)
);

CREATE TABLE clasificacion_criaturas_backup
(
    nombre_clasificacion_id CHAR(12) PRIMARY KEY ,
    descripcion VARCHAR(512) NOT NULL,
    tipo_creatura_id INT NOT NULL,
    mitologia_id INT NOT NULL,
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    CONSTRAINT fk_tipo_creatura_clasificacion FOREIGN KEY (tipo_creatura_id) REFERENCES tipos_creaturas_backup(tipo_id),
    CONSTRAINT fk_mitologia_clasificacion FOREIGN KEY (mitologia_id) REFERENCES mitologias_backup(mitologia_id)
);

CREATE TABLE nivel_riesgo_backup
(
    riesgo_id INT PRIMARY KEY AUTO_INCREMENT,
    nivel_riesgo enum('Alto','Medio', 'Bajo') NOT NULL ,
    descripcion VARCHAR(512) NOT NULL CHECK (LENGTH(descripcion) >= 10),
    fecha_backup DATETIME,
    usuario VARCHAR(255)
);

CREATE TABLE caracteristicas_backup
(
    caracteristicas_id INT PRIMARY KEY AUTO_INCREMENT,
    riesgo_id INT,
    ubicacion VARCHAR(70) NOT NULL,
    descripcion VARCHAR(512) NOT NULL,
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    CONSTRAINT fk_riesgo_criatura_id FOREIGN KEY (riesgo_id) REFERENCES nivel_riesgo_backup(riesgo_id)
);


CREATE TABLE criaturas_backup
(
    criatura_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_criatura VARCHAR(75) NOT NULL,
    caracteristicas_id INT,
    descripcion_id VARCHAR (512),
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    CONSTRAINT fk_caracteristicas_id FOREIGN KEY (caracteristicas_id) REFERENCES caracteristicas_backup(caracteristicas_id),
    CONSTRAINT fk_descripcion_id FOREIGN KEY (descripcion_id) REFERENCES clasificacion_criaturas_backup(nombre_clasificacion_id)
);


CREATE TABLE evidencias_backup
(
    evidencia_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_evidencia CHAR(5) NOT NULL,
    url_tipo_evidencia VARCHAR(2048),
    fecha_backup DATETIME,
    usuario VARCHAR(255)
);

CREATE TABLE testigos_backup
(
    testigo_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_testigo VARCHAR(50) NOT NULL,
    edad INT check (16 <= edad),
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
    numero_contacto CHAR(9) UNIQUE NOT NULL
);


CREATE TABLE testimonios_backup
(
    evidencias_id INT,
    fecha date NOT NULL,
    descripcion VARCHAR(512) NOT NULL CHECK (LENGTH(descripcion) BETWEEN 10 AND 512),
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    CONSTRAINT fk_evidencias_id FOREIGN KEY (evidencias_id) REFERENCES evidencias_backup(evidencia_id)

);

CREATE TABLE ubicaciones_backup
(
    ubicacion_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_localizacion VARCHAR(60) NOT NULL,
    descripcion VARCHAR(512),
    fecha_backup DATETIME,
    usuario VARCHAR(255)
);

CREATE TABLE  avistamientos_backup
(
    avistamientos_id INT PRIMARY KEY AUTO_INCREMENT,
    criatura_id INT,
    ubicacion_id INT,
    fecha_backup DATETIME,
    usuario VARCHAR(255),
    CONSTRAINT fk_criatura_id FOREIGN KEY (criatura_id) REFERENCES criaturas_backup(criatura_id),
    CONSTRAINT fk_ubicacion_id FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones_backup(ubicacion_id)

);

ALTER TABLE testimonios_backup
ADD COLUMN testigo_id int,
ADD COLUMN avistamientos_id int,
ADD CONSTRAINT fk_testigo_id FOREIGN KEY (testigo_id) REFERENCES testigos_backup(testigo_id),
ADD CONSTRAINT fk_avistamientos_id FOREIGN KEY (avistamientos_id) REFERENCES avistamientos_backup(avistamientos_id),
ADD PRIMARY KEY (testigo_id, avistamientos_id);


USE avistamiento_criaturas;

/* TRIGGERS BACKUP DE DATOS */
-- tipos_creaturas

CREATE TRIGGER backup_tipos_criaturas_update
AFTER UPDATE ON tipos_creaturas
FOR EACH ROW

    INSERT INTO tipos_creaturas_backup (tipo_id, nombre_tipo, descripcion, fecha_backup, usuario)
    VALUES (OLD.tipo_id, OLD.nombre_tipo, OLD.descripcion, NOW(), CURRENT_USER());

CREATE TRIGGER backup_tipos_creaturas_delete
AFTER DELETE ON tipos_creaturas
FOR EACH ROW

    INSERT INTO tipos_creaturas_backup (tipo_id, nombre_tipo, descripcion, fecha_backup, usuario)
    VALUES (OLD.tipo_id, OLD.nombre_tipo, OLD.descripcion, NOW(), CURRENT_USER());

-- mitologias
CREATE TRIGGER backup_mitologias_update
AFTER UPDATE ON mitologias
FOR EACH ROW
    INSERT INTO mitologias_backup (mitologia_id, nombre_tipo, descripcion, fecha_backup, usuario)
    VALUES (OLD.mitologia_id, OLD.nombre_tipo, OLD.descripcion, NOW(), CURRENT_USER());

CREATE TRIGGER backup_mitologias_delete
AFTER DELETE ON mitologias
FOR EACH ROW
    INSERT INTO mitologias_backup (mitologia_id, nombre_tipo, descripcion, fecha_backup, usuario)
    VALUES (OLD.mitologia_id, OLD.nombre_tipo, OLD.descripcion, NOW(), CURRENT_USER());

-- clasificacion_criaturas
CREATE TRIGGER backup_clasificacion_criaturas_update
AFTER UPDATE ON clasificacion_criaturas
FOR EACH ROW
    INSERT INTO clasificacion_criaturas_backup (nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id, fecha_backup, usuario)
    VALUES (OLD.nombre_clasificacion_id, OLD.descripcion, OLD.tipo_creatura_id, OLD.mitologia_id, NOW(), CURRENT_USER());

CREATE TRIGGER backup_clasificacion_criaturas_delete
AFTER DELETE ON clasificacion_criaturas
FOR EACH ROW
    INSERT INTO clasificacion_criaturas_backup (nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id, fecha_backup, usuario)
    VALUES (OLD.nombre_clasificacion_id, OLD.descripcion, OLD.tipo_creatura_id, OLD.mitologia_id, NOW(), CURRENT_USER());

-- nivel_riesgo
CREATE TRIGGER backup_nivel_riesgo_update
AFTER UPDATE ON nivel_riesgo
FOR EACH ROW
    INSERT INTO nivel_riesgo_backup (riesgo_id, nivel_riesgo, descripcion, fecha_backup, usuario)
    VALUES (OLD.riesgo_id, OLD.nivel_riesgo, OLD.descripcion, NOW(), CURRENT_USER());

CREATE TRIGGER backup_nivel_riesgo_delete
AFTER DELETE ON nivel_riesgo
FOR EACH ROW
    INSERT INTO nivel_riesgo_backup (riesgo_id, nivel_riesgo, descripcion, fecha_backup, usuario)
    VALUES (OLD.riesgo_id, OLD.nivel_riesgo, OLD.descripcion, NOW(), CURRENT_USER());

-- caracteristicas
CREATE TRIGGER backup_caracteristicas_update
AFTER UPDATE ON caracteristicas
FOR EACH ROW
    INSERT INTO caracteristicas_backup (caracteristicas_id, riesgo_id, ubicacion, descripcion, fecha_backup, usuario)
    VALUES (OLD.caracteristicas_id, OLD.riesgo_id, OLD.ubicacion, OLD.descripcion, NOW(), CURRENT_USER());

CREATE TRIGGER backup_caracteristicas_delete
AFTER DELETE ON caracteristicas
FOR EACH ROW
    INSERT INTO caracteristicas_backup (caracteristicas_id, riesgo_id, ubicacion, descripcion, fecha_backup, usuario)
    VALUES (OLD.caracteristicas_id, OLD.riesgo_id, OLD.ubicacion, OLD.descripcion, NOW(), CURRENT_USER());

-- criaturas
CREATE TRIGGER backup_criaturas_update
AFTER UPDATE ON criaturas
FOR EACH ROW
    INSERT INTO criaturas_backup (criatura_id, nombre_criatura, caracteristicas_id, descripcion_id, fecha_backup, usuario)
    VALUES (OLD.criatura_id, OLD.nombre_criatura, OLD.caracteristicas_id, OLD.descripcion_id, NOW(), CURRENT_USER());

CREATE TRIGGER backup_criaturas_delete
AFTER DELETE ON criaturas
FOR EACH ROW
    INSERT INTO criaturas_backup (criatura_id, nombre_criatura, caracteristicas_id, descripcion_id, fecha_backup, usuario)
    VALUES (OLD.criatura_id, OLD.nombre_criatura, OLD.caracteristicas_id, OLD.descripcion_id, NOW(), CURRENT_USER());

-- evidencias
CREATE TRIGGER backup_evidencias_update
AFTER UPDATE ON evidencias
FOR EACH ROW
    INSERT INTO evidencias_backup (evidencia_id, tipo_evidencia, url_tipo_evidencia, fecha_backup, usuario)
    VALUES (OLD.evidencia_id, OLD.tipo_evidencia, OLD.url_tipo_evidencia, NOW(), CURRENT_USER());

CREATE TRIGGER backup_evidencias_delete
AFTER DELETE ON evidencias
FOR EACH ROW
    INSERT INTO evidencias_backup (evidencia_id, tipo_evidencia, url_tipo_evidencia, fecha_backup, usuario)
    VALUES (OLD.evidencia_id, OLD.tipo_evidencia, OLD.url_tipo_evidencia, NOW(), CURRENT_USER());

-- testigos
CREATE TRIGGER backup_testigos_update
AFTER UPDATE ON testigos
FOR EACH ROW
    INSERT INTO testigos_backup (testigo_id, nombre_testigo, edad, genero, numero_contacto, fecha_backup, usuario)
    VALUES (OLD.testigo_id, OLD.nombre_testigo, OLD.edad, OLD.genero, OLD.numero_contacto, NOW(), CURRENT_USER());

CREATE TRIGGER backup_testigos_delete
AFTER DELETE ON testigos
FOR EACH ROW
    INSERT INTO testigos_backup (testigo_id, nombre_testigo, edad, genero, numero_contacto, fecha_backup, usuario)
    VALUES (OLD.testigo_id, OLD.nombre_testigo, OLD.edad, OLD.genero, OLD.numero_contacto, NOW(), CURRENT_USER());

-- testimonios
CREATE TRIGGER backup_testimonios_update
AFTER UPDATE ON testimonios
FOR EACH ROW
    INSERT INTO testimonios_backup (evidencias_id, fecha, descripcion, testigo_id, avistamientos_id, fecha_backup, usuario)
    VALUES (OLD.evidencias_id, OLD.fecha, OLD.descripcion, OLD.testigo_id, OLD.avistamientos_id, NOW(), CURRENT_USER());

CREATE TRIGGER backup_testimonios_delete
AFTER DELETE ON testimonios
FOR EACH ROW
    INSERT INTO testimonios_backup (evidencias_id, fecha, descripcion, testigo_id, avistamientos_id, fecha_backup, usuario)
    VALUES (OLD.evidencias_id, OLD.fecha, OLD.descripcion, OLD.testigo_id, OLD.avistamientos_id, NOW(), CURRENT_USER());

-- ubicaciones
CREATE TRIGGER backup_ubicaciones_update
AFTER UPDATE ON ubicaciones
FOR EACH ROW
    INSERT INTO ubicaciones_backup (ubicacion_id, nombre_localizacion, descripcion, fecha_backup, usuario)
    VALUES (OLD.ubicacion_id, OLD.nombre_localizacion, OLD.descripcion, NOW(), CURRENT_USER());

CREATE TRIGGER backup_ubicaciones_delete
AFTER DELETE ON ubicaciones
FOR EACH ROW
    INSERT INTO ubicaciones_backup (ubicacion_id, nombre_localizacion, descripcion, fecha_backup, usuario)
    VALUES (OLD.ubicacion_id, OLD.nombre_localizacion, OLD.descripcion, NOW(), CURRENT_USER());

-- avistamientos
CREATE TRIGGER backup_avistamientos_update
AFTER UPDATE ON avistamientos
FOR EACH ROW
    INSERT INTO avistamientos_backup (avistamientos_id, criatura_id, ubicacion_id, fecha_backup, usuario)
    VALUES (OLD.avistamientos_id, OLD.criatura_id, OLD.ubicacion_id, NOW(), CURRENT_USER());

CREATE TRIGGER backup_avistamientos_delete
AFTER DELETE ON avistamientos
FOR EACH ROW
    INSERT INTO avistamientos_backup (avistamientos_id, criatura_id, ubicacion_id, fecha_backup, usuario)
    VALUES (OLD.avistamientos_id, OLD.criatura_id, OLD.ubicacion_id, NOW(), CURRENT_USER());

#Triggers 3


# Triggers parte 3 actualizar fecha ultimo usuario
drop table if exists DDBB_CONNECTIONS;
CREATE TABLE DDBB_CONNECTIONS
(
	nombre_usuario varchar (50),
    fecha_ultima_accion date
);

CREATE TRIGGER actualizarFechaUltimaAccion_tipos_creaturas
AFTER UPDATE ON tipos_creaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_mitologias
AFTER UPDATE ON mitologias
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_clasificacion_criaturas
AFTER UPDATE ON clasificacion_criaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_nivel_riesgo
AFTER UPDATE ON nivel_riesgo
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_caracteristicas
AFTER UPDATE ON caracteristicas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_criaturas
AFTER UPDATE ON criaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_evidencias
AFTER UPDATE ON evidencias
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_testigos
AFTER UPDATE ON testigos
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_testimonios
AFTER UPDATE ON testimonios
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_ubicaciones
AFTER UPDATE ON ubicaciones
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_avistamientos
AFTER UPDATE ON avistamientos
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (CURRENT_USER(), NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();



/* TESTS*/
/*
-- registro en tipos_creaturas
INSERT INTO tipos_creaturas (nombre_tipo, descripcion) VALUES ('Nuevo Tipo', 'Descripción del nuevo tipo');

-- registro en mitologias
UPDATE mitologias SET descripcion = 'Nueva descripción' WHERE mitologia_id = 1;

-- eliminar un registro en clasificacion_criaturas
DELETE FROM clasificacion_criaturas WHERE nombre_clasificacion_id = 'Clasificación existente';

--  registro en nivel_riesgo
INSERT INTO nivel_riesgo (nivel_riesgo, descripcion) VALUES ('Alto', 'Animal agresivo, poco colaborativo');

-- registro en caracteristicas
INSERT INTO caracteristicas (riesgo_id, ubicacion, descripcion) VALUES (1, 'Ciudad de Barcelona', 'Descripción de ejemplo');

-- registro en mitologias
INSERT INTO mitologias (nombre_tipo, descripcion) VALUES ('Nuevo Tipo de Mitología', 'Descripción de la nueva mitología');

-- registro en tipos_creaturas
INSERT INTO tipos_creaturas (nombre_tipo, descripcion) VALUES ('Nuevo Tipo de Criatura', 'Descripción del nuevo tipo de criatura');

-- registro en clasificacion_criaturas
INSERT INTO clasificacion_criaturas (nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id) VALUES ('NuevoID', 'Descripción nueva', 1, 1);

-- registro en criaturas
INSERT INTO criaturas (nombre_criatura, caracteristicas_id, descripcion_id) VALUES ('Nueva Criatura', 1, 'NuevoID');

-- eliminar registro en testigos
DELETE FROM testigos WHERE testigo_id = 1;

-- registro en testimonios
UPDATE testimonios SET descripcion = 'Nueva descripción' WHERE evidencias_id = 1;

-- eliminar un registro en avistamientos
DELETE FROM avistamientos WHERE avistamientos_id = 1;
*/

/* indices - 1 */
/* Índices ordinarios */


-- columna nombre_criatura de la tabla criaturas
CREATE INDEX idx_nombre_criatura ON criaturas(nombre_criatura);

--  columna nombre_localizacion de la tabla ubicaciones
CREATE INDEX idx_nombre_localizacion ON ubicaciones(nombre_localizacion);

-- columna fecha de la tabla testimonios
CREATE INDEX idx_fecha ON testimonios(fecha);

-- columna ubicacion de la tabla ubicaciones
CREATE INDEX idx_ubicacion_descripcion ON ubicaciones(descripcion);



/* indices - 2 */
/* Índices únicos*/


ALTER TABLE tipos_creaturas
ADD UNIQUE INDEX idx_unique_nombre_tipo (nombre_tipo);


ALTER TABLE mitologias
ADD UNIQUE INDEX idx_unique_nombre_tipo (nombre_tipo);

ALTER TABLE clasificacion_criaturas
ADD UNIQUE INDEX idx_unique_nombre_clasificacion_id (nombre_clasificacion_id);

ALTER TABLE nivel_riesgo
ADD UNIQUE INDEX idx_unique_nivel_riesgo (nivel_riesgo);

ALTER TABLE criaturas
ADD UNIQUE INDEX idx_unique_nombre_criatura (nombre_criatura);

ALTER TABLE evidencias
ADD UNIQUE INDEX idx_unique_tipo_evidencia (tipo_evidencia);

ALTER TABLE testigos
ADD UNIQUE INDEX idx_unique_numero_contacto (numero_contacto);

ALTER TABLE ubicaciones
ADD UNIQUE INDEX idx_unique_nombre_localizacion (nombre_localizacion);


/*Indices -3*/
/* Índices Compuestos */

CREATE UNIQUE INDEX tipos_creaturas_tipo_descripcion ON tipos_creaturas (nombre_tipo, descripcion);


CREATE UNIQUE INDEX mitologias_tipo_descripcion ON mitologias (nombre_tipo, descripcion);


CREATE UNIQUE INDEX tipo_descripcion ON tipos_creaturas (nombre_tipo, descripcion);


CREATE UNIQUE INDEX clasificacion_criaturas_nombre_descripcion ON clasificacion_criaturas (nombre_clasificacion_id, descripcion);


CREATE UNIQUE INDEX clasificacion_criaturas_nombre_tipo ON clasificacion_criaturas (nombre_clasificacion_id, tipo_creatura_id);


CREATE UNIQUE INDEX nivel_riesgo_nivel_riesgo_descripcion ON nivel_riesgo (nivel_riesgo, descripcion);


CREATE UNIQUE INDEX caracteristicas_riesgo_caracteristicas_id ON caracteristicas (caracteristicas_id, riesgo_id);


CREATE UNIQUE INDEX caracteristicas_ubicacion_caracteristicas_id ON caracteristicas (caracteristicas_id, ubicacion);


CREATE UNIQUE INDEX caracteristicas_descripcion_caracteristicas_id ON caracteristicas (caracteristicas_id, descripcion);


CREATE UNIQUE INDEX criaturas_descripcion_criatura_id ON criaturas (criatura_id, descripcion_id);


CREATE UNIQUE INDEX criaturas_nombreCriatura_criatura_id ON criaturas (criatura_id, nombre_criatura);


CREATE UNIQUE INDEX criaturas_caracteristicas_criatura_id ON criaturas (criatura_id, caracteristicas_id);


CREATE UNIQUE INDEX evidenica_tipo_URL ON evidencias (tipo_evidencia, url_tipo_evidencia);


CREATE UNIQUE INDEX testigos_testigo_id_numero_contacto ON testigos (testigo_id, numero_contacto);


CREATE UNIQUE INDEX testigos_testigo_id_genero ON testigos (testigo_id, genero);


CREATE UNIQUE INDEX testigos_testigo_id_edad ON testigos (testigo_id, edad);


CREATE UNIQUE INDEX testigos_testigo_id_nombre_id ON testigos (testigo_id, nombre_testigo);


CREATE UNIQUE INDEX testimonios_evidencias_fecha ON testimonios (evidencias_id, fecha);


CREATE UNIQUE INDEX testimonios_evidencias_descripcion ON testimonios (evidencias_id, descripcion);


CREATE UNIQUE INDEX testimonios_evidencias_nombre_testigo ON testimonios (evidencias_id, testigo_id );


CREATE UNIQUE INDEX testimonios_evidencias_avistamiento_id ON testimonios (evidencias_id, avistamientos_id);


CREATE UNIQUE INDEX ubicaciones_nombre_localizacion_ubicacion_id ON ubicaciones (ubicacion_id, nombre_localizacion);


CREATE UNIQUE INDEX ubicaciones_descripcion_ubicacion_id ON ubicaciones (ubicacion_id, descripcion);


CREATE UNIQUE INDEX avistamientos_localizacion_avistamiento_id ON avistamientos (avistamientos_id, criatura_id);


CREATE UNIQUE INDEX avistamientos_criatura_avistamiento_id ON avistamientos (avistamientos_id, ubicacion_id);

# Tests
#show index from mitologias;

#EXPLAIN SELECT * FROM mitologias WHERE nombre_tipo = 'griega';






/* TESTS */
/*
SELECT * FROM criaturas WHERE nombre_criatura = 'Nombre de la criatura';


SELECT * FROM ubicaciones WHERE nombre_localizacion = 'Nombre de la ubicación';


SELECT * FROM testimonios WHERE fecha = '2024-03-11';


SELECT * FROM ubicaciones WHERE descripcion LIKE '%Descripción%';

*/

/* vistas -1 */
/*
-- Insertar datos en la tabla tipos_creaturas
INSERT INTO tipos_creaturas (nombre_tipo, descripcion) VALUES
('Tipo 1', 'Descripción del Tipo 1'),
('Tipo 2', 'Descripción del Tipo 2');

-- Insertar datos en la tabla mitologias
INSERT INTO mitologias (nombre_tipo, descripcion) VALUES
('Mitología 1', 'Descripción de la Mitología 1'),
('Mitología 2', 'Descripción de la Mitología 2');

-- Insertar datos en la tabla clasificacion_criaturas
INSERT INTO clasificacion_criaturas (nombre_clasificacion_id, descripcion, tipo_creatura_id, mitologia_id) VALUES
('Clasif1', 'Descripción de la Clasificación 1', 1, 1),
('Clasif2', 'Descripción de la Clasificación 2', 2, 2);

-- Insertar datos en la tabla nivel_riesgo
INSERT INTO nivel_riesgo (nivel_riesgo, descripcion) VALUES
('Alto', 'Descripción del Riesgo Alto'),
('Medio', 'Descripción del Riesgo Medio');

-- Insertar datos en la tabla caracteristicas
INSERT INTO caracteristicas (riesgo_id, ubicacion, descripcion) VALUES
(1, 'Ubicación 1', 'Descripción de la Ubicación 1'),
(2, 'Ubicación 2', 'Descripción de la Ubicación 2');

-- Insertar datos en la tabla criaturas
INSERT INTO criaturas (nombre_criatura, caracteristicas_id, descripcion_id) VALUES
('Criatura 1', 1, 'Clasif1'),
('Criatura 2', 2, 'Clasif2');

-- Insertar datos en la tabla evidencias
INSERT INTO evidencias (tipo_evidencia, url_tipo_evidencia) VALUES
('Tipo1', 'URL 1'),
('Tipo2', 'URL 2');

-- Insertar datos en la tabla testigos
INSERT INTO testigos (nombre_testigo, edad, genero, numero_contacto) VALUES
('Testigo 1', 20, 'masculino', '123456789'),
('Testigo 2', 30, 'femenino', '987654321');

-- Insertar datos en la tabla ubicaciones
INSERT INTO ubicaciones (nombre_localizacion, descripcion) VALUES
('Ubicación 1', 'Descripción de la Ubicación 1'),
('Ubicación 2', 'Descripción de la Ubicación 2');

-- Insertar datos en la tabla avistamientos
INSERT INTO avistamientos (criatura_id, ubicacion_id) VALUES
(1, 1),
(2, 2);

-- Insertar datos en la tabla testimonios
INSERT INTO testimonios (evidencias_id, fecha, descripcion, testigo_id, avistamientos_id) VALUES
(1, '2024-03-18', 'Descripción del Testimonio 1', 1, 1),
(2, '2024-03-19', 'Descripción del Testimonio 2', 2, 2);
*/

/* FIN INSERTS*/

/* vistas - tablas intermedias */

-- la tabla intermedia que tenemos
CREATE VIEW testimonios_view AS
    SELECT t.evidencias_id, t.fecha, t.descripcion, ev.tipo_evidencia, ev.url_tipo_evidencia
    FROM testimonios t
    INNER JOIN evidencias ev ON t.evidencias_id = ev.evidencia_id;


-- debemos tener 4 tablas intermedias como minimo

-- Vista combinando testimonios con testigos
CREATE VIEW testimonios_testigos_view AS
    SELECT t.evidencias_id, t.fecha, t.descripcion, te.nombre_testigo, te.edad, te.genero, te.numero_contacto
    FROM testimonios t
    INNER JOIN testigos te ON t.testigo_id = te.testigo_id;

-- Vista combinando testimonios con avistamientos
CREATE VIEW testimonios_avistamientos_view AS
    SELECT t.evidencias_id, t.fecha, t.descripcion, a.criatura_id, a.ubicacion_id
    FROM testimonios t
    INNER JOIN avistamientos a ON t.avistamientos_id = a.avistamientos_id;

-- Vista combinando testimonios con avistamientos y ubicaciones
CREATE VIEW testimonios_avistamientos_ubicaciones_view AS
    SELECT t.evidencias_id, t.fecha, t.descripcion, a.criatura_id, a.ubicacion_id, u.nombre_localizacion, u.descripcion AS ubicacion_descripcion
    FROM testimonios t
    INNER JOIN avistamientos a ON t.avistamientos_id = a.avistamientos_id
    INNER JOIN ubicaciones u ON a.ubicacion_id = u.ubicacion_id;


-- Vista combinando testimonios con avistamientos, ubicaciones y criaturas
CREATE VIEW testimonios_avistamientos_ubicaciones_criaturas_view AS
    SELECT t.evidencias_id, t.fecha, t.descripcion, a.criatura_id, a.ubicacion_id, u.nombre_localizacion, u.descripcion AS ubicacion_descripcion, c.nombre_criatura
    FROM testimonios t
    INNER JOIN avistamientos a ON t.avistamientos_id = a.avistamientos_id
    INNER JOIN ubicaciones u ON a.ubicacion_id = u.ubicacion_id
    INNER JOIN criaturas c ON a.criatura_id = c.criatura_id;

/* TESTS */
/*
-- Prueba de la vista testimonios_view
SELECT * FROM testimonios_view;

-- Prueba de la vista testimonios_testigos_view
SELECT * FROM testimonios_testigos_view;

-- Prueba de la vista testimonios_avistamientos_view
SELECT * FROM testimonios_avistamientos_view;

-- Prueba de la vista testimonios_avistamientos_ubicaciones_view
SELECT * FROM testimonios_avistamientos_ubicaciones_view;

-- Prueba de la vista testimonios_avistamientos_ubicaciones_criaturas_view
SELECT * FROM testimonios_avistamientos_ubicaciones_criaturas_view;
*/
/*Vistas - 2*/
CREATE VIEW vista_informacion_completa AS
SELECT
    tc.tipo_id AS tc_tipo_id,
    tc.nombre_tipo AS tc_nombre_tipo,
    tc.descripcion AS tc_descripcion,
    m.mitologia_id,
    m.nombre_tipo AS mitologia_nombre_tipo,
    m.descripcion AS mitologia_descripcion,
    cc.nombre_clasificacion_id,
    cc.descripcion AS cc_descripcion,
    nr.riesgo_id,
    nr.nivel_riesgo,
    nr.descripcion AS nr_descripcion,
    c.caracteristicas_id,
    c.ubicacion,
    c.descripcion AS c_descripcion,
    cr.criatura_id,
    cr.nombre_criatura,
    cr.descripcion_id,
    e.evidencia_id,
    e.tipo_evidencia,
    e.url_tipo_evidencia,
    t.testigo_id,
    t.nombre_testigo,
    t.edad,
    t.genero,
    t.numero_contacto,
    ub.ubicacion_id,
    ub.nombre_localizacion,
    ub.descripcion AS ub_descripcion,
    a.avistamientos_id,
    a.criatura_id AS avistamientos_criatura_id,
    a.ubicacion_id AS avistamientos_ubicacion_id
FROM
    tipos_creaturas tc
    JOIN mitologias m ON tc.tipo_id = m.mitologia_id
    JOIN clasificacion_criaturas cc ON tc.tipo_id = cc.tipo_creatura_id
    JOIN nivel_riesgo nr ON cc.tipo_creatura_id = nr.riesgo_id
    JOIN caracteristicas c ON nr.riesgo_id = c.riesgo_id
    JOIN criaturas cr ON c.caracteristicas_id = cr.caracteristicas_id
    JOIN evidencias e ON cr.criatura_id = e.evidencia_id
    JOIN testigos t ON e.evidencia_id = t.testigo_id
    JOIN avistamientos a ON cr.criatura_id = a.criatura_id
    JOIN ubicaciones ub ON a.ubicacion_id = ub.ubicacion_id;


/*Vistas - 3*/

CREATE VIEW all_Backup as

USE avistamiento_criaturas_backup;

CREATE VIEW all_Backup as
SELECT concat(tipo_id,nombre_tipo,descripcion) AS tipos_criaturas_backup FROM tipos_creaturas_backup
UNION SELECT concat(mitologia_id,nombre_tipo,descripcion) AS mitologias_backup FROM mitologias_backup
UNION SELECT concat(nombre_clasificacion_id,descripcion,tipo_creatura_id,mitologia_id) AS clasificacion_criaturas_backup FROM clasificacion_criaturas_backup
UNION SELECT concat(riesgo_id,nivel_riesgo,descripcion) AS nivel_riesgo_backup FROM nivel_riesgo_backup
UNION SELECT concat(caracteristicas_id,riesgo_id,ubicacion,descripcion) AS caracteristicas_backup FROM caracteristicas_backup
UNION SELECT concat(criatura_id,nombre_criatura,caracteristicas_id,descripcion_id) AS criaturas_backup FROM criaturas_backup
UNION SELECT concat(evidencia_id,tipo_evidencia,url_tipo_evidencia) AS evidencias_backup FROM evidencias_backup
UNION SELECT concat(testigo_id,nombre_testigo,edad,genero,numero_contacto) AS testigos_backup FROM testigos_backup
UNION SELECT concat(evidencias_id,fecha,descripcion,testigo_id,avistamientos_id) AS testimonios_backup FROM testimonios_backup
UNION SELECT concat(ubicacion_id,nombre_localizacion,descripcion) AS ubicaciones_backup FROM ubicaciones_backup
UNION SELECT concat(avistamientos_id,criatura_id,ubicacion_id) AS avistamientos_backup FROM avistamientos_backup;


/* Funciones - 1 */
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


/*Funciones - 2*/

-- Procedimiento para comparar dos strings sin tener en cuenta mayúsculas y minúsculas
DELIMITER //

CREATE PROCEDURE comparar_strings(IN str1 VARCHAR(255), IN str2 VARCHAR(255), OUT resultado BOOLEAN)
BEGIN
    IF LOWER(str1) = LOWER(str2) THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;
END//

DELIMITER ;

-- Procedimiento para verificar si tres números están ordenados
DELIMITER //

CREATE PROCEDURE estan_ordenados(IN num1 INT, IN num2 INT, IN num3 INT, OUT resultado BOOLEAN)
BEGIN
    IF num1 < num2 AND num2 < num3 THEN
        SET resultado = TRUE;
    ELSE
        SET resultado = FALSE;
    END IF;
END//

DELIMITER ;

-- Procedimiento para sumar el segundo número al primero tantas veces como el tercero
-- y aumentar el segundo en 1 cada vez que se suma al primero
DELIMITER //

CREATE PROCEDURE sumar_con_incremento(INOUT num1 INT, INOUT num2 INT, IN veces INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= veces DO
        SET num1 = num1 + num2;
        SET num2 = num2 + 1;
        SET i = i + 1;
    END WHILE;
END//

DELIMITER ;

/* Tests para la función comparar_strings 
SELECT comparar_strings('Hola', 'hola'); -- Ha de devolver 1.
SELECT comparar_strings('Python', 'python'); -- Ha de devolver 1.
SELECT comparar_strings('Casa', 'cAsA'); -- Ha de devolver 1.
SELECT comparar_strings('Hola', 'adiós'); -- Ha de devolver 0.
SELECT comparar_strings('Gato', 'perro'); -- Ha de devolver 0.

 Tests para la función estan_ordenados 
SELECT estan_ordenados(1, 2, 3); -- Ha de devolver 1.
SELECT estan_ordenados(5, 3, 1); -- Ha de devolver 0.
SELECT estan_ordenados(10, 20, 30); -- Ha de devolver 1.
SELECT estan_ordenados(-1, 0, 1); -- Ha de devolver 1.
SELECT estan_ordenados(5, 5, 5); -- Ha de devolver 0.

 Tests para la función sumar_con_incremento 
SET @num1 = 1; SET @num2 = 2;
CALL sumar_con_incremento(@num1, @num2, 3);
SELECT @num1, @num2; -- Ha de devolver 7 y 5.

SET @num1 = 5; SET @num2 = 3;
CALL sumar_con_incremento(@num1, @num2, 2);
SELECT @num1, @num2; -- Ha de devolver 11 y 5.

SET @num1 = 10; SET @num2 = 20;
CALL sumar_con_incremento(@num1, @num2, 1);
SELECT @num1, @num2; -- Ha de devolver 30 y 21.

SET @num1 = -1; SET @num2 = 0;
CALL sumar_con_incremento(@num1, @num2, 4);
SELECT @num1, @num2; -- Ha de devolver 2 y 4.

SET @num1 = 5; SET @num2 = 5;
CALL sumar_con_incremento(@num1, @num2, 0);
SELECT @num1, @num2; -- Ha de devolver 5 y 5.

*/
/*Funciones - 3*/

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

/*Tests
SELECT char_en_cadena('Esta frase tiene muchas es', 'e'); #Ha de devolver 5.
SELECT char_en_cadena('Esta frase tiene pocas us', 'u'); #Ha de devolver 1.
SELECT char_en_cadena('No se que mas poner', 'k'); #Ha de devolver 0.
SELECT char_en_cadena('Realmente espero que funcione', 'e'); #Ha de devolver 7.
SELECT char_en_cadena('Porfavor funciona', 'i'); #Ha de devolver i.*/



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

/*Tests
SELECT promedio_maximo(4, 5, 6, 7); #Ha de devolver 7
SELECT promedio_maximo(10, 12, 18, 6); #Ha de devolver 13,333...
SELECT promedio_maximo(1, 1, 1, 0); #Ha de devolver 1
SELECT promedio_maximo(9, 5, 4, 12); #Ha de devolver 12
SELECT promedio_maximo(14, 12, 16, 13); #Ha de devolver 14*/




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

/*Tests
SELECT orden_cadena('1,2,3,4,5,6'); #Ha de devolver 1
SELECT orden_cadena('5,2,5,4,7,9'); #Ha de devolver 0
SELECT orden_cadena('12,24,48,96'); #Ha de devolver 1
SELECT orden_cadena('2556,5256,5526,6552,5256'); #Ha de devolver 0
SELECT orden_cadena('1,100000'); #Ha de devolver 1*/




/* procedures - 1 */

USE avistamiento_criaturas;

DELIMITER //

CREATE PROCEDURE aplicar_filtro(
    IN filtro INT,
    OUT mensaje VARCHAR(255)
)

BEGIN
    -- Variable para control de errores
    DECLARE exito BOOLEAN DEFAULT FALSE;

    -- Variables para recorrer el cursor
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE evidencia_id_resultado INT;
    DECLARE fecha_resultado DATE;
    DECLARE descripcion_resultado VARCHAR(512);
    DECLARE tipo_evidencia_resultado CHAR(5);
    DECLARE url_evidencia_resultado VARCHAR(2048);

    -- Declarar cursor para recorrer los resultados filtrados
    DECLARE cur_cursor CURSOR FOR
        SELECT evidencias_id, fecha, descripcion, tipo_evidencia, url_tipo_evidencia FROM resultados_filtro;

    -- Gestion de error cuando falle al abrir el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Creacion de la tabla temporal para almacenar los resultados del filtro
    CREATE TEMPORARY TABLE IF NOT EXISTS resultados_filtro AS
        SELECT * FROM testimonios_view WHERE evidencias_id = filtro;

    -- Manejo de errores con los mensajes
    IF NOT EXISTS (SELECT * FROM resultados_filtro) THEN
        SET exito = TRUE;
        SET mensaje = 'KO. No se encontraron resultados para el filtro especificado';
    ELSE
        SET mensaje = 'OK. Todo está correcto';
    END IF;

    -- Mostrar la tabla temporal
    SELECT * FROM resultados_filtro;

    -- Abrir cursor
    OPEN cur_cursor;

    -- Recorrer cursor con WHILE
    loop_read: WHILE NOT done DO
        FETCH cur_cursor INTO evidencia_id_resultado, fecha_resultado, descripcion_resultado, tipo_evidencia_resultado, url_evidencia_resultado;
        IF NOT done THEN
            -- Las tres columnas mzás importantes del resultado
            SELECT evidencia_id_resultado, fecha_resultado, descripcion_resultado;
        END IF;
    END WHILE;

    CLOSE cur_cursor;

    DROP TEMPORARY TABLE IF EXISTS resultados_filtro;
END //

DELIMITER ;

/* TESTS */

CALL aplicar_filtro(1, @mensaje);
SELECT @mensaje AS mensaje_salida;


CALL aplicar_filtro(-1, @mensaje);
SELECT @mensaje AS mensaje_salida;


CALL aplicar_filtro(NULL, @mensaje);
SELECT @mensaje AS mensaje_salida;

CALL aplicar_filtro(999, @mensaje); -- Usar un filtro que no exista en la tabla
SELECT @mensaje AS mensaje_salida;

CALL aplicar_filtro(2, @mensaje);
SELECT @mensaje AS mensaje_salida;

/* DCL - gestion de usuarios - 1  (optional)*/

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


/* tests mas forzar triggers
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
*/

/* DCL - gestion de usuarios - 2  (optional)*/
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE ON *.* TO 'admin'@'localhost';

DELIMITER //
CREATE PROCEDURE gestionar_privilegios(IN permiso VARCHAR(10), IN activar BOOLEAN)
BEGIN
    IF activar = 1 THEN
        IF permiso = 'SELECT' THEN
            GRANT SELECT ON *.* TO 'admin'@'localhost';
        ELSEIF permiso = 'INSERT' THEN
            GRANT INSERT ON *.* TO 'admin'@'localhost';
        ELSEIF permiso = 'UPDATE' THEN
            GRANT UPDATE ON *.* TO 'admin'@'localhost';
        END IF;
    ELSE
        IF permiso = 'SELECT' THEN
            REVOKE SELECT ON *.* FROM 'admin'@'localhost';
        ELSEIF permiso = 'INSERT' THEN
            REVOKE INSERT ON *.* FROM 'admin'@'localhost';
        ELSEIF permiso = 'UPDATE' THEN
            REVOKE UPDATE ON *.* FROM 'admin'@'localhost';
        END IF;
    END IF;
END//
DELIMITER ;

/* DCL - gestion de usuarios - 3  (optional)*/



CREATE USER IF NOT EXISTS 'Usuario'@'localhost' IDENTIFIED BY 'LaMejorContraseñaDelMundo123';

GRANT ALL PRIVILEGES ON tipos_creaturas.* TO Usuario;

GRANT ALL PRIVILEGES ON mitologias TO Usuario;

GRANT ALL PRIVILEGES ON clasificacion_criaturas TO Usuario;

GRANT ALL PRIVILEGES ON nivel_riesgo TO Usuario;

GRANT ALL PRIVILEGES ON caracteristicas TO Usuario;

GRANT ALL PRIVILEGES ON criaturas TO Usuario;

GRANT ALL PRIVILEGES ON evidencias TO Usuario;

GRANT ALL PRIVILEGES ON testigos TO Usuario;

GRANT ALL PRIVILEGES ON testimonios TO Usuario;

GRANT ALL PRIVILEGES ON ubicaciones TO Usuario;

GRANT ALL PRIVILEGES ON avistamientos TO Usuario;


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

