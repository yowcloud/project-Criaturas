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