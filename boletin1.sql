# Muestra los empleados que ganan más que SMITH

SELECT ename
FROM emp
WHERE sal >	(SELECT sal FROM emp
			WHERE ename='SMITH');

# Muestra los nombres de los empleados junto con el nombre del departamento en el que
# trabajan.

SELECT ename,dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

# Muestra los empleados del departamento 10 que entraron en la empresa antes del año 1998.

SELECT ename
FROM emp
WHERE deptno = 10
AND hiredate < '01/01/1998';

SELECT ename
FROM emp
WHERE deptno = 10
AND TO_CHAR(hiredate,'YYYY') < '1998';

# Muestra los empleados cuyo oficio es CLERK y ganan menos de 2000.

SELECT ename
FROM emp
WHERE job = 'CLERK'
AND sal < 2000;

# Muestra los empleados sin comisión del departamento 10.

SELECT ename
FROM emp
WHERE (comm IS NULL
OR comm = 0)
AND deptno = 10;

# Muestra los empleados del mismo departamento que ALLEN.

SELECT ename
FROM emp
WHERE deptno = (SELECT deptno
				FROM emp
				WHERE ename = 'ALLEN');

# Muestra los empleados cuyo nombre empiece por A.

SELECT ename
FROM emp
WHERE ename LIKE 'A%';

# Muestra los empleados que trabajan en un departamento ubicado en DALLAS.

SELECT ename
FROM emp
WHERE deptno IN (SELECT deptno
				FROM dept
				WHERE loc = 'DALLAS');


# Muestra nombre y salario de los empleados del departamento 'ACCOUNTING'.

SELECT ename,sal
FROM emp
WHERE deptno = (SELECT deptno
				FROM dept
				WHERE dname = 'ACCOUNTING');

# Muestra nombre y comisión de los empleados cuyo oficio es 'SALESMAN'.

SELECT ename,comm
FROM emp
WHERE job = ('SALESMAN');

# Muestra nombre y fecha de alta de todos los empleados que no son 'CLERK' ni
# 'SALESMAN'.

SELECT ename,hiredate
FROM emp
WHERE job NOT IN ('CLERK','SALESMAN')

SELECT ename,hiredate
FROM emp
WHERE job != 'CLERK' AND job != 'SALESMAN';

# Muestra el nombre, el salario y la comisión de los empleados que trabajan en el mismo
# departamento que 'JONES'.

SELECT ename,sal,comm
FROM emp
WHERE deptno = (SELECT deptno
				FROM emp
				WHERE ename = 'JONES');

# Muestra los nombres de los departamentos en los que trabaja alguien que gane menos que
# 'ALLEN'.

SELECT dname
FROM dept
WHERE deptno IN (SELECT deptno
				FROM emp
				WHERE sal < (SELECT sal
							FROM emp
							WHERE ename='ALLEN'));

# Muestra código y nombre de los empleados que están en un departamento de 'DALLAS' y
# ganan más que 'SMITH' pero menos que 'ALLEN'.

SELECT empno,ename
FROM emp
WHERE sal > (SELECT sal
			FROM emp
			WHERE ename='SMITH') AND
					sal < (SELECT sal
					FROM emp
					WHERE ename='ALLEN') AND
							deptno IN (SELECT deptno
							FROM dept
							WHERE loc = 'DALLAS');

# Muestra el nombre del jefe (campo MGR) de los empleados del departamento 10.

SELECT ename
FROM emp
WHERE mgr IS NULL AND deptno = 10;