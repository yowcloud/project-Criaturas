DROP SCHEMA IF EXISTS avistamiento_criaturas;
CREATE SCHEMA  avistamiento_criaturas;

USE avistamiento_criaturas;

CREATE TABLE tipos_creaturas
(
    tipo_id INT PRIMARY KEY auto_increment,
    nombre_tipo VARCHAR(50),
    descripcion VARCHAR(512)
);

CREATE TABLE mitologias
(
    mitologia_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_tipo VARCHAR(50),
    descripcion VARCHAR(512)
);

CREATE TABLE clasificacion_criaturas
(
    nombre_clasificacion_id CHAR(12) PRIMARY KEY ,
    descripcion VARCHAR(512),
    tipo_creatura_id INT,
    mitologia_id INT,
    CONSTRAINT fk_tipo_creatura_clasificacion FOREIGN KEY (tipo_creatura_id) REFERENCES tipos_creaturas(tipo_id),
    CONSTRAINT fk_mitologia_clasificacion FOREIGN KEY (mitologia_id) REFERENCES mitologias(mitologia_id)
);
/*
Lo mas seguro que necesitemos una tabla porque seria N:N muchas criaturas  pueden tener el mimso riegos y al reves
*/
CREATE TABLE nivel_riesgo
(
    riesgo_id INT PRIMARY KEY,
    descripcion VARCHAR(512)
);

CREATE TABLE factores
(
    factores_id VARCHAR(50) PRIMARY KEY,
    riesgo_id INT,
    ubicacion VARCHAR(70),
    descripcion VARCHAR(512),
    CONSTRAINT fk_riesgo_criatura_id FOREIGN KEY (riesgo_id) REFERENCES nivel_riesgo(riesgo_id)
);

CREATE TABLE criaturas
(
    criatura_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_criatura VARCHAR(75) NOT NULL,
    factores_id VARCHAR(50),
    descripcion_id VARCHAR (512),
    CONSTRAINT fk_factores_id FOREIGN KEY (factores_id) REFERENCES factores(factores_id),
    CONSTRAINT fk_descripcion_id FOREIGN KEY (descripcion_id) REFERENCES clasificacion_criaturas(nombre_clasificacion_id)
);

-- creacion de la parte izquierda

CREATE TABLE evidencias
(
    evidencia_id INT PRIMARY KEY AUTO_INCREMENT,
    tipo_evidencia CHAR(5),
    url_tipo_evidencia VARCHAR(2048)
);

CREATE TABLE testigos
(
    testigo_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_testigo VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    genero ENUM('masculino', 'femenino', 'otro') NOT NULL,
    numero_contacto CHAR(9)
);
CREATE TABLE testimonios
(
    testimonio_id INT PRIMARY KEY  AUTO_INCREMENT,
    testigo_id INT,
    evidencias_id INT,
    fecha date,
    descripcion VARCHAR(512),
    CONSTRAINT fk_testigo_id FOREIGN KEY (testigo_id) REFERENCES testigos(testigo_id),
    CONSTRAINT fk_evidencias_id FOREIGN KEY (evidencias_id) REFERENCES evidencias(evidencia_id)
);

CREATE TABLE ubicaciones
(
    ubicacion_id INT PRIMARY KEY AUTO_INCREMENT,
    numbre_localizacion VARCHAR(60),
    descripcion VARCHAR(512)
);

CREATE TABLE  avistamientos
(
    avistamientos_id INT PRIMARY KEY AUTO_INCREMENT,
    criatura_id INT,
    ubicacion_id INT,
    nombre_testigo_id INT,
    CONSTRAINT fk_criatura_id FOREIGN KEY (criatura_id) REFERENCES criaturas(criatura_id),
    CONSTRAINT fk_ubicacion_id FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones(ubicacion_id),
    CONSTRAINT fk_nombre_testigo_id FOREIGN KEY (nombre_testigo_id) REFERENCES testigos(testigo_id)
);