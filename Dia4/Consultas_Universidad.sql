USE universidad_t2;

-- CONSULTAS

-- Devuelve el número total de alumnas que hay.
select COUNT(*) as Cantidad_alumnas from alumno where sexo = 2;

-- Calcula cuántos alumnos nacieron en 1999.
select COUNT(*) as Alumnos_1999 from alumno where year(fecha_nacimiento) = '1999';

-- Calcula cuántos profesores hay en cada departamento. El resultado sólo debe mostrar dos columnas,
-- una con el nombre del departamento y otra con el número de profesores que hay en ese departamento. 
-- El resultado sólo debe incluir los departamentos que tienen profesores asociados y deberá estar ordenado de mayor a menor por el número de profesores.
SELECT departamento.nombre AS departamento, COUNT(profesor.id) AS numero_de_profesores
FROM departamento
INNER JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre
HAVING COUNT(profesor.id) > 0
ORDER BY numero_de_profesores DESC;

-- Devuelve un listado con todos los departamentos y el número de profesores que hay en cada uno de ellos. 
-- Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también tienen que aparecer en el listado.
SELECT departamento.nombre AS departamento, COUNT(profesor.id) AS numero_de_profesores
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. 
-- Tenga en cuenta que pueden existir grados que no tienen asignaturas asociadas. Estos grados también tienen que aparecer en el listado. 
-- El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
SELECT grado.nombre AS Grado, COUNT(asignatura.id) AS numero_de_asignaturas
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
ORDER BY numero_de_asignaturas DESC;

-- Devuelve un listado con el nombre de todos los grados existentes en la base de datos
-- y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
SELECT grado.nombre AS Grado, COUNT(asignatura.id) AS numero_de_asignaturas
FROM grado
LEFT JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre
HAVING numero_de_asignaturas > 40;

-- Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos que hay para cada tipo de asignatura. 
-- El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que hay de ese tipo.
-- Ordene el resultado de mayor a menor por el número total de crédidos.
SELECT grado.nombre AS Grado, asignatura.tipo AS tipo_asignatura, SUM(asignatura.creditos) AS total_creditos
FROM grado
INNER JOIN asignatura ON grado.id = asignatura.id_grado
GROUP BY grado.nombre, asignatura.tipo
ORDER BY total_creditos DESC;

-- Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. 
-- El resultado deberá mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
SELECT curso_escolar.anyo_inicio AS año_de_inicio, COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno) AS alumnos_matriculados
FROM curso_escolar
INNER JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar
GROUP BY curso_escolar.anyo_inicio;

-- Devuelve un listado con el número de asignaturas que imparte cada profesor. 
-- El listado debe tener en cuenta aquellos profesores que no imparten ninguna asignatura.
-- El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. 
-- El resultado estará ordenado de mayor a menor por el número de asignaturas.
select profesor.id, profesor.nombre, profesor.apellido1, profesor.apellido2, COUNT(asignatura.id) as numero_asignaturas
FROM profesor
left JOIN asignatura ON profesor.id = asignatura.id_profesor
group by profesor.id, profesor.nombre, profesor.apellido1, profesor.apellido2
ORDER BY numero_asignaturas DESC;