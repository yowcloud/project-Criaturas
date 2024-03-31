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

