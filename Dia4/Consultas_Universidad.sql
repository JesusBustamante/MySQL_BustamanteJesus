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

-- Devuelve todos los datos del alumno más joven.
select * from alumno ORDER BY fecha_nacimiento DESC LIMIT 1;

-- Devuelve un listado con los profesores que no están asociados a un departamento.
SELECT profesor.nombre AS profesor, COUNT(departamento.id) AS numero_de_departamentos
FROM profesor
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
WHERE departamento.id IS NULL
GROUP BY profesor.nombre;

-- Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT departamento.nombre AS departamento, COUNT(profesor.id) AS numero_de_profesores
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
GROUP BY departamento.nombre
HAVING COUNT(profesor.id) < 1;

-- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT profesor.id, profesor.nif, profesor.nombre, profesor.apellido1, profesor.apellido2, profesor.ciudad, profesor.direccion, profesor.telefono, profesor.fecha_nacimiento, profesor.sexo, id_departamento
FROM profesor
INNER JOIN departamento ON profesor.id_departamento  = departamento.id
LEFT JOIN asignatura ON profesor.id = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT * FROM asignatura WHERE id_profesor IS NULL;

-- Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT departamento.id, departamento.nombre AS departamento
FROM departamento
LEFT JOIN profesor ON departamento.id = profesor.id_departamento
LEFT JOIN asignatura ON profesor.id = asignatura.id_profesor
LEFT JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
WHERE alumno_se_matricula_asignatura.id_asignatura IS NULL
GROUP BY departamento.id, departamento.nombre;

-- Devuelve un listado con el nombre de todos los departamentos que tienen profesores que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015)
SELECT DISTINCT departamento.nombre AS Departamentos FROM departamento
INNER JOIN profesor ON departamento.id = profesor.id_departamento
INNER JOIN asignatura ON profesor.id = asignatura.id_profesor
INNER JOIN grado ON asignatura.id_grado = grado.id
WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- Devuelve un listado con los nombres de todos los profesores y los departamentos que tienen vinculados. El listado también debe mostrar aquellos profesores
-- que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor. 
-- El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y el nombre.
SELECT departamento.nombre AS Departamento, profesor.apellido1 AS Primer_apellido, profesor.apellido2 AS Segundo_apellido, profesor.nombre AS Nombre
FROM profesor 
LEFT JOIN departamento ON profesor.id_departamento = departamento.id
ORDER BY departamento.nombre, profesor.apellido1, profesor.apellido2, profesor.nombre ASC;

-- Devuelve un listado con los profesores que no imparten ninguna asignatura.
SELECT profesor.nombre FROM profesor
LEFT JOIN asignatura ON profesor.id = asignatura.id_profesor
WHERE asignatura.id_profesor IS NULL;

-- Devuelve un listado con todos los departamentos que tienen alguna asignatura que no se haya impartido en ningún curso escolar. 
-- El resultado debe mostrar el nombre del departamento y el nombre de la asignatura que no se haya impartido nunca.
SELECT departamento.nombre AS Departamento, asignatura.nombre AS Asignatura
FROM departamento
INNER JOIN profesor ON departamento.id = profesor.id_departamento
INNER JOIN asignatura ON profesor.id = asignatura.id_profesor
LEFT JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
WHERE alumno_se_matricula_asignatura.id_curso_escolar IS NULL;