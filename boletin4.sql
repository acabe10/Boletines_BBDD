-- 1. Mostrar los datos de los empleados que pertenezcan al mismo departamento
	-- que ʻGILʼ.

SELECT *
FROM emple
WHERE dept_no = (SELECT dept_no
FROM emple
WHERE apellidos='GIL');

-- 2. Mostrar los datos de los empleados que tengan el mismo oficio que
	-- ʻCEREZOʼ. El resultado debe ir ordenado por apellido.

SELECT *
FROM emple
WHERE oficio = (SELECT oficio
FROM emple
WHERE apellidos='SANCHEZ')
ORDER BY apellidos;

-- 3. Mostrar los empleados (nombre, oficio, salario y fecha de alta) que
	-- desempeñen el mismo oficio que ʻJIMÉNEZʼ o que tengan un salario mayor o
	-- igual que ʻFERNÁNDEZʼ.

SELECT apellidos,salario,fecha_alt
FROM emple
WHERE oficio = (SELECT oficio
FROM emple
WHERE apellidos = 'JIMENEZ') OR
salario >= (SELECT salario
FROM emple
WHERE apellidos = 'FERNANDEZ');

-- 4. Mostrar en pantalla el apellido, oficio y salario de los empleados del
	-- departamento de ʻFERNÁNDEZʼ que tengan su mismo salario.

SELECT apellidos,oficio,salario
FROM emple
WHERE dept_no = (SELECT dept_no
FROM emple
WHERE apellidos ='FERNANDEZ') AND
salario = (SELECT salario
FROM emple
WHERE apellidos='FERNANDEZ');

SELECT apellidos,oficio,salario
FROM emple
WHERE (dept_no,salario) = (SELECT dept_no,salario
							FROM emple
							WHERE apellidos='FERNANDEZ');

-- 5. Mostrar los datos de los empleados que tengan un salario mayor que ʻGILʼ y
	-- que pertenezcan al departamento número 10.

SELECT *
FROM emple
WHERE salario > (SELECT salario
FROM emple
WHERE apellidos='GIL') AND
dept_no = 10;

-- 6. Mostrar los apellidos, oficios y localizaciones de los departamentos de cada
	-- uno de los empleados.

SELECT e.apellidos,e.oficio,d.loc
FROM emple e, depart d
WHERE e.dept_no=d.dept_no;

-- 7. Seleccionar el apellido, el oficio y la localidad de los departamentos donde
	-- trabajan los ANALISTAS.

SELECT e.apellidos,e.oficio,d.loc
FROM emple e,depart d
WHERE e.dept_no=d.dept_no
AND e.oficio='ANALISTA';

-- 8. Seleccionar el apellido, el oficio y salario de los empleados que trabajan en
	-- Madrid.

SELECT apellidos,oficio,salario
FROM emple
WHERE dept_no IN (SELECT dept_no
FROM depart
WHERE loc='MADRID');

-- 9. Seleccionar el apellido, salario y localidad donde trabajan de los empleados
	-- que tengan un salario entre 200000 y 300000.

SELECT e.apellidos,e.salario,d.loc
FROM emple e,depart d
WHERE e.dept_no=d.dept_no
AND e.salario BETWEEN 200000 AND 300000;

-- 10. Mostrar el apellido, salario y nombre del departamento de los empleados
	-- que tengan el mismo oficio que ʻGILʼ.

SELECT e.apellidos,e.salario,d.dnombre
FROM emple e,depart d
WHERE e.dept_no=d.dept_no
AND e.oficio=(SELECT oficio
FROM emple
WHERE apellidos='GIL');

-- 11. Mostrar el apellido, salario y nombre del departamento de los empleados
	-- que tengan el mismo oficio que ʻGILʼ y que no tengan comisión.

SELECT e.apellidos,e.salario,d.dnombre
FROM emple e,depart d
WHERE e.dept_no=depart.dept_no
AND e.oficio=(SELECT oficio
FROM emple
WHERE apellidos='GIL')
AND comision IS NULL;

-- 12. Mostrar los datos de los empleados que trabajan en el departamento de
	-- contabilidad, ordenados por apellidos.

SELECT *
FROM emple
WHERE dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='CONTABILIDAD')
ORDER BY apellidos;

-- 13. Apellido de los empleados que trabajan en Sevilla y cuyo oficio sea analista
	-- o empleado.

SELECT apellidos
FROM emple
WHERE oficio IN('ANALISTA','EMPLEADO')
AND dept_no IN (SELECT dept_no
FROM depart
WHERE loc='SEVILLA');

-- 14. Calcula el salario medio de todos los empleados.

SELECT AVG(salario)
FROM emple;

-- 15. ¿Cuál es el máximo salario de los empleados del departamento 10?

SELECT MAX(salario)
FROM emple
WHERE dept_no=10;

-- 16. Calcula el salario mínimo de los empleados del departamento 'VENTAS'.

SELECT MIN(salario)
FROM emple
WHERE dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='VENTAS');

-- 17. Calcula el promedio del salario de los empleados del departamento de
	-- 'CONTABILIDAD'.

SELECT AVG(salario)
FROM emple
WHERE dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='CONTABILIDAD');

-- 18. Mostrar los datos de los empleados cuyo salario sea mayor que la media de
	-- todos los salarios.

SELECT *
FROM emple
WHERE salario>(SELECT AVG(salario)
FROM emple);

-- 19. ¿Cuántos empleados hay en el departamento número 10?

SELECT COUNT(*)
FROM emple
WHERE dept_no=10;

-- 20. ¿Cuántos empleados hay en el departamento de 'VENTAS'?

SELECT COUNT(*)
FROM emple
WHERE dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='VENTAS');

-- 21. Calcula el número de empleados que hay que no tienen comisión.

SELECT COUNT(*)
FROM emple
WHERE comision IS NULL;

-- 22. Seleccionar el apellido del empleado que tiene máximo salario.

SELECT apellidos
FROM emple
WHERE salario=(SELECT MAX(salario)
FROM emple);

-- 23. Mostrar los apellidos del empleado que tiene el salario más bajo.

SELECT apellidos
FROM emple
WHERE salario=(SELECT MIN(salario)
FROM emple);

-- 24. Mostrar los datos del empleado que tiene el salario más alto en el
	-- departamento de 'VENTAS'.

SELECT *
FROM emple
WHERE salario=(SELECT MAX(salario)
FROM emple
WHERE dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='VENTAS'))
AND dept_no=(SELECT dept_no
FROM depart
WHERE dnombre='VENTAS');

-- 25. A partir de la tabla EMPLE visualizar cuántos apellidos de los empleados
	-- empiezan por la letra ʻA'.

SELECT COUNT(*)
FROM emple
WHERE apellidos LIKE 'A%';

-- 26. Dada la tabla EMPLE, obtener el sueldo medio, el número de comisiones no nulas,
-- el máximo sueldo y el sueldo mínimo de los empleados del
-- departamento 30.

SELECT ROUND(AVG(salario),2) AS "SalarioMedio",COUNT(comision) AS "Comisiones no nulas",MAX(salario) AS "Salario maximo",MIN(salario) AS "Salario minimo"
FROM emple
WHERE dept_no=30;