# Práctica de Gestión de Base de Datos

## Introducción

Para llevar a cabo esta práctica, en grupo, es necesario seleccionar una temática para la gestión de una base de datos. El proyecto se desarrollará utilizando Git y se partirá de un Proyecto Esqueleto. Cada grupo recibirá un proyecto donde se les asignará el rol de Developer, lo que implica que no podrán trabajar en la rama principal (main). Antes de continuar con la práctica, se debe completar un formulario que define el grupo y la temática.

## Desarrollo

Para la elaboración de esta práctica, se deben cumplir los siguientes pasos:

### 0. Metodología de Trabajo

- Se trabajará en scripts .sql separados.
- Los apartados 2, 3 y 10 se realizarán en grupo, entregando un único script .sql por cada apartado.
- Los apartados 4 a 9 se realizarán en grupo, con cada miembro asignado a una tarea específica.
- Todo el código será revisado por el profesor y fusionado en la rama principal si está correcto.
- Es obligatorio trabajar con issues y Merge Requests.

### 1. Git

- Instalación de DataGrip y clonación del proyecto en DataGrip.
- Trabajo por issues y Merge Requests para separar correctamente el trabajo.

### 2. Diseño

- Pensar en el alcance de la base de datos (mínimo 10 tablas).
- Realizar diagramas Entidad-Relación y Relacional, subiéndolos al repositorio.

### 3. Script Inicial

- Crear el Schema y realizar el script de creación de la base de datos a partir del diagrama Relacional.
- Aplicar constraints y verificar la consistencia del diagrama.

### 4. Triggers

- **Tarea 1: Backup de Datos**
  - Se deben crear triggers en todas las tablas para realizar un backup de los datos junto con la fecha y el usuario que ha ejecutado la sentencia. Estos triggers se activarán en updates y deletes.
  - Se creará una tabla adicional llamada `DATA_USAGES` para registrar el número de updates, inserts y deletes que realiza cada usuario.
  - Se almacenará la fecha de la última acción realizada por cada usuario en una tabla llamada `DDBB_CONNECTIONS`.
  
### 5. Índices

- **Tarea 1: Creación de Índices**
  - Se revisarán las tablas en grupo para determinar la creación de índices ordinarios, únicos y compuestos según las necesidades de cada tabla.
  - Se crearán un mínimo de 3 índices de cada tipo en el total de las tablas.
  
### 6. Vistas

- **Tarea 1: Creación de Vistas**
  - Se creará una vista para cada una de las tablas intermedias que junte los valores de las dos tablas junto con la tabla intermedia.
  - Se generarán un mínimo de 5 vistas, agrupando las tablas más relacionadas entre ellas en caso de tener menos de 5 tablas intermedias.
  - Se creará una vista que muestre toda la información de la base de datos.
  - Se generará una vista llamada `backup_view` que muestre la información de todas las tablas backup creadas en los triggers en un solo listado.

### 7. Funciones

- **Tarea 1: Implementación de Funciones**
  - Se crearán funciones para validar correos, determinar el máximo y mínimo de dos números, y generar un string con caracteres repetidos.
- **Tarea 2: Implementación de Funciones**
  - Se desarrollarán funciones para comparar strings sin distinción de mayúsculas y minúsculas, verificar el orden de tres números y realizar operaciones matemáticas.
- **Tarea 3: Implementación de Funciones**
  - Se crearán funciones para contar la frecuencia de un carácter en un string, calcular el promedio de tres números y determinar si una lista de números está ordenada.

### 8. Procedimientos Almacenados

- **Tarea 1: Procedimientos Almacenados**
  - Se desarrollará un procedimiento almacenado que guarde en una tabla temporal los resultados de aplicar un filtro a una vista específica.
- **Tarea 2: Procedimientos Almacenados**
  - Se creará un procedimiento almacenado que inserte valores por defecto en cada una de las tablas, generando un número especificado de registros.
- **Tarea 3: Procedimientos Almacenados**
  - Se implementará un procedimiento almacenado que consulte la vista de las tablas backups y la compare con los registros de las tablas backup.

### 9. DCL Gestión de Usuarios

- **Tarea 1: Gestión de Perfiles de Usuario**
  - Se definirán perfiles de superusuario, administrador y usuario con distintos privilegios en las tablas.
- **Tarea 2: Asignación y Revocación de Privilegios**
  - Se desarrollarán procedimientos almacenados para asignar y revocar privilegios a los perfiles de usuario definidos.
- **Tarea 3: Creación y Eliminación de Usuarios**
  - Se crearán procedimientos almacenados para crear y eliminar usuarios, asignándoles permisos de lectura en las tablas.

### 10. Script Final

- Se generará un único archivo .sql que contenga todos los apartados anteriores para su ejecución secuencial. El script debe funcionar sin errores y contener la sentencia `USE` al inicio para seleccionar el schema.

### 11. Defensa

- Se preparará una presentación con la información del proyecto, incluyendo la distribución de tareas, la temática de la base de datos, la explicación de los diagramas y el repaso de los componentes implementados.
- Se participará en la evaluación de las Bases de Datos del resto de grupos, realizando preguntas constructivas al finalizar la defensa.
## Evaluación

La evaluación del proyecto se realizará según los siguientes criterios:

- Correcto uso de GIT y creación del diseño de la base de datos (0.5 puntos).
- Implementación de Triggers, Índices y Vistas (2 puntos).
- Implementación de Funciones y Procedimientos Almacenados (4 puntos).
- Implementación de Gestión de Usuarios (1.5 puntos).
- Defensa del proyecto (2 puntos).

## Tips

- Se proporcionan tutoriales de Git para trabajar de manera eficiente.

## Video Tutoriales

- Se encuentran disponibles video tutoriales para ayudar en el desarrollo del proyecto.

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
