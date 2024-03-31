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

