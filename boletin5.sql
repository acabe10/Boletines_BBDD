# 1.- Listar el nombre de los empleados que no tienen comisión.

SELECT ename
FROM emp
WHERE comm = 0 OR comm IS NULL;

# 2.- Mostrar un listado del código, nombre y gasto de personal (salarios + comisiones)
	# de los departamentos ordenado por criterio descendente de gasto de personal.

SELECT d.deptno,d.dname,SUM(NVL(sal,0))+SUM(NVL(comm,0)) AS gasto_personal
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
GROUP BY d.deptno, d.dname
ORDER BY gasto_personal DESC;

# 3.- Listar el salario mínimo, máximo y medio para cada departamento,
	# indicando el código de departamento
	# al que pertenece el dato.

SELECT d.deptno,NVL(ROUND(MIN(e.sal),2),0) AS "Salario minimo",NVL(ROUND(AVG(e.sal),2),0) AS "Salario medio"
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
GROUP BY d.deptno;

# 4.- Listar el salario medio de los empleados.

SELECT ROUND(AVG(sal),2)
FROM emp;

# 5.- Listar el nombre de los departamentos en los que alguno de los salarios es igual o 
# mayor al 25% del gasto de personal.

SELECT DISTINCT d.dname
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
AND sal >= (SELECT 0.25*(SUM(NVL(e.sal,0))+SUM(NVL(e.comm,0))) AS gasto_personal
FROM dept);

# 6.- Listar los departamentos que tengan algún empleado que gane más de 15.000 euros 
# al año. (Recuerda que el salario es mensual).

SELECT dname
FROM dept
WHERE deptno IN (SELECT deptno
				FROM emp
				WHERE sal*12>15000);

# 7.- Crear la tabla TEMP(CODEMP, NOMDEPT, NOMEMP, SALEMP) cuyas columnas tienen el mismo
	# tipo y tamaño que las similares existentes en la BD. Insertar en dicha tabla el 
	# código de empleado, nombre de departamento, nombre de empleado y salario de los 
	# empleados de los departamentos de DALLAS mediante una consulta de datos anexados.

CREATE TABLE TEMP
(
  CODEMP NUMBER(4),
  NOMDEPT VARCHAR2(14),
  NOMEMP VARCHAR2(10),
  SALEMP NUMBER(7,2)
);

INSERT INTO TEMP
SELECT e.empno,d.dname,e.ename,e.sal
FROM emp e,dept d
WHERE e.deptno=d.deptno
AND d.loc='DALLAS';

# 8.- Incrementar un 10% los salarios de los empleados que ganen menos de 10.000 euros al año.

UPDATE TEMP
SET SALEMP=SALEMP*1.10
WHERE SALEMP*12<10000;

# 9.- Deshacer la operación anterior.

rollback;

# 10.- Mostrar los departamentos que tienen más de dos personas trabajando
# en el mismo oficio.

SELECT d.dname
FROM emp e,dept d
WHERE e.deptno=d.deptno           ?????????????????????????????
GROUP BY d.dname;

# 11.- Mostrar el departamento con menos empleados.

SELECT d.dname,COUNT(empno) AS num_emp
FROM emp e, dept d
WHERE e.deptno(+)=d.deptno
GROUP BY d.dname
HAVING COUNT(empno) = (SELECT MIN(COUNT(empno))
				FROM emp e,dept d
				WHERE e.deptno(+)=d.deptno
				GROUP BY d.dname);

SELECT d.dname,COUNT(empno) AS num_emp
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
GROUP BY d.dname
HAVING COUNT(empno) = (SELECT MIN(COUNT(empno))
						FROM emp e,dept d
						WHERE e.deptno(+)=d.deptno
						GROUP BY d.dname);


# 12.- Crea la tabla EMP_A_JUBILAR con las mismas columnas de la tabla EMP
	# e inserta los datos de los empleados que llevan más de 10 años en la empresa.

CREATE TABLE emp_a_jubilar AS
SELECT *
FROM emp
WHERE MONTHS_BETWEEN (SYSDATE, hiredate) >= 120;

# 13.- Muestra los registros que se encuentran en la tabla EMP y no están en la tabla 
	# EMP_A_JUBILAR, realizando la consulta con operadores de conjuntos.

SELECT *
FROM emp
MINUS
SELECT *
FROM emp_a_jubilar;

# 14.- Muestra los datos de los empleados que se encuentran en una de las dos tablas,
	# realizando la consulta con operadores de conjuntos.

(SELECT *
FROM emp
MINUS
SELECT *
FROM emp_a_jubilar)
UNION
(SELECT *
FROM emp_a_jubilar
MINUS
SELECT *
FROM emp);

# 15.- Muestra una lista de los departamentos con el número de empleados que tiene, 
	# pero considerando que pueden existir departamentos sin empleados, en cuyo caso,
	# debe aparecer un cero.

SELECT d.dname,COUNT(empno) AS num_emp
FROM emp e,dept d
WHERE e.deptno(+)=d.deptno
GROUP BY d.dname;