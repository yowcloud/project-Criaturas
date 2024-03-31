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



