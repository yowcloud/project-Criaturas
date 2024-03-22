# Práctica de Gestión de Base de Datos

## Introducción

¡Bienvenidos al proyecto de gestión de base de datos en grupo! En esta práctica, hemos trabajado en equipo para desarrollar una base de datos basada en una temática de nuestra elección. Para llevar a cabo este proyecto, hemos seguido una metodología estructurada y hemos utilizado Git para gestionar el desarrollo de manera eficiente.

## Desarrollo

### 0. Metodología de Trabajo

Hemos seguido una metodología clara para organizar nuestro trabajo en este proyecto:

- División de tareas en scripts individuales `.sql`.
- Trabajo en grupo para los apartados 2, 3 y 10, mientras que los apartados 4 a 9 se asignaron individualmente dentro del grupo.
- Utilización de issues y Merge Requests en Git para gestionar el desarrollo de forma colaborativa.
- Revisión por parte del profesor antes de fusionar los cambios en la rama principal.

### 1. Git

Hemos utilizado Git como herramienta de control de versiones para colaborar en el proyecto:

- Instalación de DataGrip y clonación del proyecto en nuestro entorno de desarrollo.
- Utilización de issues y Merge Requests para organizar y separar el trabajo.
- Creación de nuevas issues y Merge Requests para cada tarea, asegurando una gestión eficiente del proyecto.

### 2. Diseño

En esta etapa, hemos definido el alcance de nuestra base de datos y hemos creado los diagramas Entidad-Relación y Relacional:

- Definición del alcance de la base de datos con al menos 10 tablas.
- Elaboración de los diagramas Entidad-Relación y Relacional, subiéndolos al repositorio para su revisión.

### 3. Script Inicial

Hemos creado el script inicial de la base de datos utilizando el diagrama Relacional:

- Creación del schema y definición de la estructura de la base de datos.
- Aplicación de constraints y relaciones entre tablas.
- Verificación de la consistencia del esquema generado comparándolo con el diagrama Relacional.

**4. TRIGGERS**

**Tarea 1: Backup de Datos**
- Se implementaron triggers para realizar backups de datos en todas las tablas en caso de actualizaciones o eliminaciones.

**Tarea 2: Registro de Operaciones**
- Se creó una tabla adicional llamada DATA_USAGES para registrar el número de operaciones (inserts, updates, deletes) realizadas por cada usuario. Se implementaron triggers para mantener actualizados estos registros.

**Tarea 3: Última Acción de Usuario**
- Se implementaron triggers para almacenar la fecha de la última acción realizada por cada usuario en la tabla DDBB_CONNECTIONS.

**5. INDICES**

**Tarea 1: Índices Ordinarios**
- Se crearon índices ordinarios en las columnas de las tablas que se prevé que serán utilizadas en cláusulas WHERE para agilizar las consultas.

**Tarea 2: Índices Únicos**
- Se crearon índices únicos en las columnas de las tablas donde el valor no puede repetirse y puede ser utilizado en cláusulas WHERE.

**Tarea 3: Índices Compuestos**
- Se crearon índices compuestos en la combinación de columnas de las tablas que normalmente se usan juntas en cláusulas WHERE al realizar una consulta.

**6. VISTAS**

**Tarea 1: Vistas Intermedias**
- Se crearon vistas para cada una de las tablas intermedias que fusionan los valores de las dos tablas junto con la tabla intermedia, siguiendo el formato [nombre_tabla_intermedia]_view. Se generaron un mínimo de 5 vistas, combinando las tablas más relacionadas.

**Tarea 2: Vista de Toda la Información**
- Se creó una vista que muestra toda la información de la base de datos.

**Tarea 3: Vista de Backups**
- Se creó una vista llamada backup_view que muestra la información de todas las tablas de respaldo creadas en los triggers en un solo listado, representado en una única columna.

**Pruebas**
- Se realizaron pruebas que invocan cada una de las vistas creadas en este apartado. Esto se incluyó en el script .sql que se subió al repositorio GIT.


### 7. Funciones

- **Tarea 1: Implementación de Funciones**
  - Se han creado funciones para validar correos, determinar el máximo y mínimo de dos números, y generar un string con caracteres repetidos.
- **Tarea 2: Implementación de Funciones**
  - Se han desarrollado funciones para comparar strings sin distinción de mayúsculas y minúsculas, verificar el orden de tres números y realizar operaciones matemáticas.
- **Tarea 3: Implementación de Funciones**
  - Se han creado funciones para contar la frecuencia de un carácter en un string, calcular el promedio de tres números y determinar si una lista de números está ordenada.

### 8. Procedimientos Almacenados

- **Tarea 1: Procedimientos Almacenados**
  - Se ha desarrollado un procedimiento almacenado que guarda en una tabla temporal los resultados de aplicar un filtro a una vista específica.
- **Tarea 2: Procedimientos Almacenados**
  - Se ha creado un procedimiento almacenado que inserta valores por defecto en cada una de las tablas, generando un número especificado de registros.
- **Tarea 3: Procedimientos Almacenados**
  - Se ha implementado un procedimiento almacenado que consulta la vista de las tablas backups y la compara con los registros de las tablas backup.

### 9. DCL Gestión de Usuarios

- **Tarea 1: Gestión de Perfiles de Usuario**
  - Se han definido perfiles de superusuario, administrador y usuario con distintos privilegios en las tablas.
- **Tarea 2: Asignación y Revocación de Privilegios**
  - Se han desarrollado procedimientos almacenados para asignar y revocar privilegios a los perfiles de usuario definidos.
- **Tarea 3: Creación y Eliminación de Usuarios**
  - Se han creado procedimientos almacenados para crear y eliminar usuarios, asignándoles permisos de lectura en las tablas.

### 10. Script Final

- Se ha generado un único archivo .sql que contiene todos los apartados anteriores para su ejecución secuencial. El script funciona sin errores y contiene la sentencia `USE` al inicio para seleccionar el schema.

### 11. Defensa

- Se ha preparado una presentación con la información del proyecto, incluyendo la distribución de tareas, la temática de la base de datos, la explicación de los diagramas y el repaso de los componentes implementados.
- Se ha participado en la evaluación de las Bases de Datos del resto de grupos, realizando preguntas constructivas al finalizar la defensa.

## Evaluación

Nuestro proyecto será evaluado de acuerdo con los siguientes criterios:

- Correcto uso de Git y metodología de trabajo.
- Implementación de Triggers, Índices y Vistas.
- Desarrollo de Funciones y Procedimientos Almacenados.
- Gestión de Usuarios según los permisos establecidos.
- Calidad de la defensa del proyecto y participación en la evaluación de otros grupos.

## Tips y Recursos

- Consulta los tutoriales de Git para mejorar tu flujo de trabajo.
- Aprovecha los video tutoriales disponibles para resolver cualquier duda.

## Defensa

La presentación de la defensa del proyecto debe incluir:

- Distribución de tareas entre los miembros del grupo.
- Temática de la base de datos.
- Explicación de los diagramas Entidad-Relación, Relacional y el generado por el IDE.
- Repaso del script de creación destacando puntos fuertes y áreas de mejora.
- Explicación de los Triggers, Vistas, Índices, Procedimientos Almacenados y Gestión de Usuarios.
- Participación en la evaluación de las Bases de Datos de otros grupos.

## Evaluación Individual

La rúbrica utilizada para evaluar individualmente a cada miembro del grupo se compone de varios criterios, incluyendo el correcto uso de GIT, la implementación de componentes de la base de datos y la defensa del proyecto.

## Entrega

La entrega del proyecto debe incluir:

- Script final del apartado 10.
- Nombre del archivo de entrega: `ABP_NumeroDelGrupo.sql`.
