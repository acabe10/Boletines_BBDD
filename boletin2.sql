# 1.b. Muestra el número de empleados que ganan más de 1400.

SELECT COUNT(ename)
FROM emp
WHERE sal > 1400;

# 1.b. Muestra los empleados que ganan más de 1400 en orden descendente.

SELECT ename
FROM emp
WHERE sal > 1400
ORDER BY sal DESC;

# 2. Muestra el salario medio de los conserjes (job='CLERK').

SELECT AVG(sal)
FROM emp
WHERE job='CLERK';

# 3. Muestra el empleado que gana más junto con su salario dando el formato siguiente:
#'El nombre del empleado que más gana es xxxx, y gana nnnnn'

SELECT 'El nombre del empleado que más gana es '|| ename ||', y gana ' ||sal
FROM emp
WHERE sal = (SELECT max(sal)
			FROM emp);

# 4. Muestra los nombres de los conserjes ordenados por salario.

SELECT ename
FROM emp
WHERE job='CLERK'
ORDER BY sal;

# 5. Muestra el gasto de personal total de la empresa, sumando salarios y comisiones.

SELECT SUM(sal + NVL(comm,0)) AS "Gasto total de personal"
FROM emp;


SELECT SUM(sal)+SUM(comm)
FROM emp;

# 6. Muestra un informe con los nombres de los empleados y su salario con el siguiente formato:

# nombre1........ salario1
# nombren.........salarion

SELECT rpad(ename,15,'.')||sal
from emp;

SELECT ename||'.....'||sal
FROM emp;

# 7. Muestra el número de trienios completos de cada empleado.

SELECT ename,ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)/36)
from emp;

# 8. Muestra el total de dinero ganado por el empleado desde que se incorporó a la empresa
#suponiendo que el salario no ha cambiado en todo ese tiempo.

SELECT ename,sal*ROUND(MONTHS_BETWEEN(SYSDATE,hiredate)) AS "Dinero total"
FROM emp;

# 9. Muestra con dos decimales el salario diario de cada trabajador suponiendo que los meses
# tienen 30 días.

SELECT ename, ROUND(sal/30,2) AS "Salario diario"
FROM emp;

# 10. Muestra los empleados que tengan en su nombre al menos dos vocales.

SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'.*[AEIOU].*[AEIOU].*');

# 11. Muestra los empleados cuyo nombre empieza por una vocal.

SELECT ename
FROM emp
WHERE SUBSTR(ename,1,1) IN ('A','E','I','O','U');

SELECT ename
FROM emp
WHERE REGEXP_LIKE(ename,'^[AEIOU].*');

# 12. Muestra los departamentos que tienen algún empleado cuyo nombre tiene más de cinco
# letras.

SELECT dname
FROM dept
WHERE deptno IN (SELECT DISTINCT deptno
				FROM emp
				WHERE LENGTH(ename) > 5;

# 13. Muestra en minúsculas los nombres de los departamentos que tienen algún empleado.

SELECT LOWER(dname)
FROM dept
WHERE deptno IN (SELECT DISTINCT deptno
				FROM emp);


# 14. Muestra un mensaje de saludo a cada empleado con el formato 'Hola nombreempleado'.

SELECT 'Hola '||ename
FROM emp;

Ejemplo de este tipo de SELECT para crear un script:

Vista DBA_USERS. Nombre del usuario en la columna username

SELECT 'GRANT dba TO'||username||';'
FROM DBA_USERS;
WHERE TO_CHAR(created,'YYYY')='2020'||;

# 15. Muestra el nombre de cada empleado junto con el nombre del mes en el que entró en la
# empresa.

SELECT ename||' '||TO_CHAR(hiredate,'Month')
FROM emp;

# 16. Muestra la hora del sistema con el formato siguiente: 'Hoy es nn del mes de nombremes del
# año n.nnn y son las hh y nn minutos.'

SELECT 'Hoy es '||
		TO_CHAR(SYSDATE,'DD')||
		' del mes de '||
		RTRIM(TO_CHAR(SYSDATE,'Month'))||
		' del año '||
		TO_CHAR(SYSDATE,'Y,YYY')||
		' y son las '||
		TO_CHAR(SYSDATE,'HH')||
		' y '||
		TO_CHAR(SYSDATE,'MI')||
		' minutos'
FROM dual;

# 17. Muestra el nombre del primer empleado por orden alfabético.

SELECT MIN(ename)
FROM emp;

# 18. Muestra el número de jefes que hay en la empresa.

SELECT COUNT(DISTINCT mgr)
FROM emp;

# 19. Muestra los empleados que fueron dados de alta entre el 01/03/1988 y el 31/06/1989.

SELECT ename
FROM emp
WHERE TO_CHAR(hiredate,'YYYYMMDD') BETWEEN '19870301' AND '19880630';

SELECT ename
FROM emp
WHERE hiredate BETWEEN TO_DATE('01031987','DDMMYYYY')
				AND TO_DATE('30061989','DDMMYYYY')

# 20. Muestra los empleados que llevan más de 6 años en la empresa.

SELECT ename
FROM emp
WHERE MONTHS_BETWEEN(SYSDATE,hiredate) > 72;