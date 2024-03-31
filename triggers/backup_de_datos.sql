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

