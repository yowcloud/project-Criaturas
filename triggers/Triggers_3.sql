
USE avistamiento_criaturas;

# Triggers parte 3 actualizar fecha ultimo usuario
drop table if exists DDBB_CONNECTIONS;
CREATE TABLE DDBB_CONNECTIONS
(
	nombre_Usuario varchar (50),
    fecha_Ultima_Accion date
);

CREATE TRIGGER actualizarFechaUltimaAccion_tipos_creaturas
AFTER UPDATE ON tipos_creaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_mitologias
AFTER UPDATE ON mitologias
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_clasificacion_criaturas
AFTER UPDATE ON clasificacion_criaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_nivel_riesgo
AFTER UPDATE ON nivel_riesgo
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_caracteristicas
AFTER UPDATE ON caracteristicas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_criaturas
AFTER UPDATE ON criaturas
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_evidencias
AFTER UPDATE ON evidencias
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_testigos
AFTER UPDATE ON testigos
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_testimonios
AFTER UPDATE ON testimonios
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_ubicaciones
AFTER UPDATE ON ubicaciones
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();

CREATE TRIGGER actualizarFechaUltimaAccion_avistamientos
AFTER UPDATE ON avistamientos
FOR EACH ROW
	INSERT INTO DDBB_CONNECTIONS (nombre_usuario, fecha_ultima_accion)
    VALUES (NEW.nombre_usuario, NOW())
    ON DUPLICATE KEY UPDATE fecha_ultima_accion = NOW();