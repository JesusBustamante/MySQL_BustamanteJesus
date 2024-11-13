USE funcion_t2;

-- Consultas

-- Lista el primer apellido de todos los empleados.
select apellido1 from empleado;

-- Lista el primer apellido de los empleados eliminando los apellidos que estén repetidos.
select distinct apellido1 from empleado;

-- Lista todas las columnas de la tabla empleado.
select * from empleado;

-- Lista el nombre y los apellidos de todos los empleados.
select nombre, apellido1, apellido2 from empleado;

-- Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado.
select id_departamento from empleado;

-- Lista el identificador de los departamentos de los empleados que aparecen en la tabla empleado, eliminando los identificadores que aparecen repetidos.
select distinct id_departamento from empleado;

-- Lista el nombre y apellidos de los empleados en una única columna.
select concat(nombre, ' ', apellido1, ' ', apellido2) as Nombre_Completo from empleado;

-- Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en mayúscula.
select upper(concat(nombre, ' ', apellido1, ' ', apellido2)) as Nombre_Completo from empleado;

-- Lista el nombre y apellidos de los empleados en una única columna, convirtiendo todos los caracteres en minúscula.
select lower(concat(nombre, ' ', apellido1, ' ', apellido2)) as Nombre_Completo from empleado;

-- Lista el identificador de los empleados junto al nif, pero el nif deberá aparecer en dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.
select id, left(nif, length(nif) -1) as Nif_dígitos, right(nif, 1) as Nif_letra from empleado;

-- Lista el nombre de cada departamento y el valor del presupuesto actual del que dispone. Para calcular este dato tendrá que restar al valor del
-- presupuesto inicial (columna presupuesto) los gastos que se han generado (columna gastos). Tenga en cuenta que en algunos casos pueden existir
-- valores negativos. Utilice un alias apropiado para la nueva columna columna que está calculando.

DELIMITER //
CREATE FUNCTION presupuesto_actual (presupuesto DECIMAL(10,2), gastos DECIMAL (10,2))
RETURNS DECIMAL (10,2) DETERMINISTIC
BEGIN
	RETURN presupuesto - gastos;
END //
DELIMITER ;

-- Uso de función creada
SELECT nombre, presupuesto_actual(presupuesto, gastos) as PresupuestoActual from departamento;

-- Lista el nombre de los departamentos y el valor del presupuesto actual ordenado de forma ascendente.
SELECT nombre, presupuesto_actual(presupuesto, gastos) as PresupuestoActual from departamento
order by PresupuestoActual ASC;

-- Lista el nombre de todos los departamentos ordenados de forma ascendente.
select nombre from departamento
order by nombre asc;

-- Lista el nombre de todos los departamentos ordenados de forma descendente.
select nombre from departamento
order by nombre desc;

-- Lista los apellidos y el nombre de todos los empleados, ordenados de forma alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su nombre.
select apellido1 as Primer_apellido, apellido2 as Segundo_apellido, nombre as Nombre from empleado
order by apellido1, apellido2, nombre asc;

-- Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen mayor presupuesto.
SELECT nombre, presupuesto_actual(presupuesto, gastos) as PresupuestoActual from departamento
order by PresupuestoActual desc
limit 3;

-- Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos que tienen menor presupuesto.
SELECT nombre, presupuesto_actual(presupuesto, gastos) as PresupuestoActual from departamento
order by PresupuestoActual asc
limit 3;

-- Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen mayor gasto.
select nombre, gastos from departamento
order by gastos desc
limit 2;

-- Devuelve una lista con el nombre y el gasto, de los 2 departamentos que tienen menor gasto.
select nombre, gastos from departamento
order by gastos asc
limit 2;

-- Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
-- columnas de la tabla empleado.
select * from empleado
limit 5 offset 2;

-- Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto mayor o igual a 150000 euros.
select nombre, presupuesto from departamento
where presupuesto >= 150000;

-- Devuelve una lista con el nombre de los departamentos y el gasto, de aquellos que tienen menos de 5000 euros de gastos.
select nombre, gastos from departamento
where gastos < 5000;

-- Devuelve una lista con el nombre de los departamentos y el presupuesto, de aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
select nombre, presupuesto from departamento
where presupuesto >= 100000 and presupuesto <= 200000;

-- Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
select nombre from departamento
where presupuesto < 100000 OR presupuesto > 200000;

-- Devuelve una lista con el nombre de los departamentos que tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
select nombre from departamento
where presupuesto between 100000 and 200000;

-- Devuelve una lista con el nombre de los departamentos que no tienen un presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
select nombre from departamento
where presupuesto not between 100000 and 200000;

-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean mayores que el presupuesto del que disponen.
select nombre, gastos, presupuesto from departamento
where gastos > presupuesto;

-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean menores que el presupuesto del que disponen.
select nombre, gastos, presupuesto from departamento
where gastos < presupuesto;

-- Devuelve una lista con el nombre de los departamentos, gastos y presupuesto, de aquellos departamentos donde los gastos sean iguales al presupuesto del que disponen.
select nombre, gastos, presupuesto from departamento
where gastos = presupuesto;

-- Lista todos los datos de los empleados cuyo segundo apellido sea NULL.
select * from empleado
where apellido2 is null;

-- Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.
select * from empleado
where apellido2 is not null;

-- Lista todos los datos de los empleados cuyo segundo apellido sea López.
select * from empleado
where apellido2 = 'López';

-- Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Sin utilizar el operador IN.
select * from empleado
where apellido2 = 'Díaz' or apellido2 = 'Moreno';

-- Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o Moreno. Utilizando el operador IN.
select * from empleado
where apellido2 in ('Díaz', 'Moreno');

-- Lista los nombres, apellidos y nif de los empleados que trabajan en el departamento 3.
select nombre, apellido1, apellido2, nif from empleado
where id_departamento = 3;

-- Lista los nombres, apellidos y nif de los empleados que trabajan en los departamentos 2, 4 o 5.
select nombre, apellido1, apellido2, nif from empleado
where id_departamento in (2, 4, 5);

-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno.
select * from empleado
inner join departamento on empleado.id_departamento = departamento.id;

-- Devuelve un listado con los empleados y los datos de los departamentos donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre
-- del departamento (en orden alfabético) y en segundo lugar por los apellidos y el nombre de los empleados.
select * from empleado
inner join departamento on empleado.id_departamento = departamento.id
order by departamento.nombre, empleado.apellido1, empleado.apellido2, empleado.nombre asc;

-- Devuelve un listado con el identificador y el nombre del departamento, solamente de aquellos departamentos que tienen empleados.
select distinct departamento.id, departamento.nombre
from departamento
inner join empleado on id_departamento = departamento.id
group by departamento.id, departamento.nombre;

-- Devuelve un listado con el identificador, el nombre del departamento y el valor del presupuesto actual del que dispone, solamente de aquellos departamentos
-- que tienen empleados. El valor del presupuesto actual lo puede calcular restando al valor del presupuesto inicial (columna presupuesto) el valor de los gastos 
-- que ha generado (columna gastos).
select departamento.id, departamento.nombre, presupuesto_actual(presupuesto, gastos) as PresupuestoActual
from departamento
inner join empleado on id_departamento = departamento.id
group by departamento.id, departamento.nombre;

-- Devuelve el nombre del departamento donde trabaja el empleado que tiene el nif 38382980M.
select departamento.nombre
from departamento
inner join empleado on id_departamento = departamento.id
where empleado.nif = '38382980M';

-- Devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz Santana.
select departamento.nombre
from departamento
inner join empleado on id_departamento = departamento.id
where empleado.nombre = 'Pepe' and empleado.apellido1 = 'Ruiz' and empleado.apellido2 = 'Santana';

-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de I+D. Ordena el resultado alfabéticamente.
select empleado.id, empleado.nif, empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.id_departamento
from empleado
inner join departamento on id_departamento = departamento.id
where departamento.nombre = 'I+D'
order by empleado.nombre, empleado.apellido1, empleado.apellido2 asc;

-- Devuelve un listado con los datos de los empleados que trabajan en el departamento de Sistemas, Contabilidad o I+D. Ordena el resultado alfabéticamente.
select empleado.id, empleado.nif, empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.id_departamento
from empleado
inner join departamento on id_departamento = departamento.id
where departamento.nombre in ('Sistemas', 'Contabilidad', 'I+D')
order by empleado.nombre, empleado.apellido1, empleado.apellido2 asc;

-- Devuelve una lista con el nombre de los empleados que tienen los departamentos que no tienen un presupuesto entre 100000 y 200000 euros.
select empleado.nombre
from empleado
inner join departamento on id_departamento = departamento.id
where departamento.presupuesto not between 100000 and 200000;

-- Devuelve un listado con el nombre de los departamentos donde existe algún empleado cuyo segundo apellido sea NULL. 
-- Tenga en cuenta que no debe mostrar nombres de departamentos que estén repetidos.
select distinct departamento.nombre
from departamento
inner join empleado on departamento.id = empleado.id_departamento
where empleado.apellido2 is null;

-- Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. Este listado también debe incluir los 
-- empleados que no tienen ningún departamento asociado.
select *
from empleado
left join departamento on id_departamento = departamento.id;

-- Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen ningún departamento asociado.
select empleado.id, empleado.nif, empleado.nombre, empleado.apellido1, empleado.apellido2, empleado.id_departamento
from empleado
left join departamento on id_departamento = departamento.id
where empleado.id_departamento is null;

-- Devuelve un listado donde sólo aparezcan aquellos departamentos que no tienen ningún empleado asociado.
select departamento.id, departamento.nombre, departamento.presupuesto, departamento.gastos
from departamento
left join empleado on departamento.id = empleado.id_departamento
where empleado.id_departamento is null;

-- Devuelve un listado con todos los empleados junto con los datos de los departamentos donde trabajan. El listado debe incluir los empleados que no
-- tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado. Ordene el listado alfabéticamente por el nombre del departamento.
SELECT empleado.id AS id_empleado, empleado.nif, empleado.nombre AS nombre_empleado, 
       empleado.apellido1, empleado.apellido2, empleado.id_departamento, 
       departamento.id AS id_departamento, departamento.nombre AS nombre_departamento, 
       departamento.presupuesto, departamento.gastos
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id

UNION

SELECT empleado.id AS id_empleado, empleado.nif, empleado.nombre AS nombre_empleado, 
       empleado.apellido1, empleado.apellido2, empleado.id_departamento, 
       departamento.id AS id_departamento, departamento.nombre AS nombre_departamento, 
       departamento.presupuesto, departamento.gastos
FROM departamento
RIGHT JOIN empleado ON departamento.id = empleado.id_departamento

ORDER BY nombre_departamento asc;

-- Devuelve un listado con los empleados que no tienen ningún departamento asociado y los departamentos que no tienen ningún empleado asociado.
-- Ordene el listado alfabéticamente por el nombre del departamento.
SELECT empleado.id AS id_empleado, empleado.nif, empleado.nombre AS nombre_empleado, 
       empleado.apellido1, empleado.apellido2, empleado.id_departamento, 
       departamento.id AS id_departamento, departamento.nombre AS nombre_departamento, 
       departamento.presupuesto, departamento.gastos
FROM empleado
LEFT JOIN departamento ON empleado.id_departamento = departamento.id
where departamento.id is null

UNION

select empleado.id AS id_empleado, empleado.nif, empleado.nombre AS nombre_empleado, 
       empleado.apellido1, empleado.apellido2, empleado.id_departamento, 
       departamento.id AS id_departamento, departamento.nombre AS nombre_departamento, 
       departamento.presupuesto, departamento.gastos
from departamento
left join empleado on departamento.id = empleado.id_departamento
where empleado.id_departamento is null

ORDER BY nombre_departamento asc;