# 1 Averigua el DNI de todos los clientes.

SELECT dni
FROM clientes;

# 2 Consulta todos los datos de todos los programas.

SELECT *
FROM programas;

# 3 Obtén un listado con los nombres de todos los programas.

SELECT nombre
FROM programas;

# 4 Genera una lista con todos los comercios.

SELECT nombre
FROM comercios;

# 5 Genera una lista de las ciudades con establecimientos donde se venden
# programas, sin que aparezcan valores duplicados (utiliza DISTINCT).

SELECT DISTINCT ciudad
FROM comercios;

# 6 Obtén una lista con los nombres de programas, sin que aparezcan valores
# duplicados (utiliza DISTINCT).

SELECT DISTINCT nombre
FROM programas;

# 7 Obtén el DNI más 4 de todos los clientes.

SELECT dni+4
FROM clientes;

# 8 Haz un listado con los códigos de los programas multiplicados por 7.

SELECT cod_programa*7
FROM programas;

# 9 ¿Cuáles son los programas cuyo código es inferior o igual a 10?

SELECT DISTINCT nombre
FROM programas
WHERE cod_programa<=10;

# 10 ¿Cuál es el programa cuyo código es 11?

SELECT nombre
FROM programas
WHERE cod_programa=11;

# 11 ¿Qué fabricantes son de Estados Unidos?

SELECT nombre
FROM fabricantes
WHERE pais='ESTADOS UNIDOS';

# 12 ¿Cuáles son los fabricantes no españoles? Utilizar el operador IN.

SELECT nombre
FROM fabricantes
WHERE pais NOT IN ('ESPAÑA');

# 13 Obtén un listado con los códigos de las distintas versiones de Windows.

SELECT cod_programa
FROM programas
WHERE nombre='WINDOWS';

# 14 ¿En qué ciudades comercializa programas El Corte Inglés?

SELECT DISTINCT ciudad
FROM comercio
WHERE nombre='EL CORTE INGLES';

# 15 ¿Qué otros comercios hay, además de El Corte Inglés? Utilizar el operador
# IN.

SELECT nombre
FROM comercios
WHERE nombre NOT IN ('EL CORTE INGLES');

# 16 Genera una lista con los códigos de las distintas versiones de Windows y
# Access. Utilizar el operador IN.

SELECT cod_programa
FROM programas
WHERE nombre IN ('WINDOWS','ACCESS');

# 17 Obtén un listado que incluya los nombres de los clientes de edades
# comprendidas entre 10 y 25 y de los mayores de 50 años. Da una solución con
# BETWEEN y otra sin BETWEEN.

SELECT nombre
FROM clientes
WHERE edad BETWEEN 10 AND 25 OR edad > 50;

SELECT nombre
FROM clientes
WHERE edad >= 10 AND edad <= 25 OR edad > 50;

# 18 Saca un listado con los comercios de Sevilla y Madrid. No se admiten
# valores duplicados.

SELECT DISTINCT nombre
FROM comercios
WHERE ciudad IN ('SEVILLA','MADRID');

# 19 ¿Qué clientes terminan su nombre en la letra “o”?

SELECT nombre
FROM clientes
WHERE nombre LIKE '%o';

# 20 ¿Qué clientes terminan su nombre en la letra “o” y, además, son mayores de
# 30 años?

SELECT nombre
FROM clientes
WHERE nombre LIKE '%o' AND edad > 30;

# 21 Obtén un listado en el que aparezcan los programas cuya versión finalice
# por una letra i, o cuyo nombre comience por una A o por una W.

SELECT nombre,version
FROM programas
WHERE (version LIKE '%i') OR (nombre LIKE 'A%') OR (nombre LIKE 'W%');

# 22 Obtén un listado en el que aparezcan los programas cuya versión finalice
# por una letra i, o cuyo nombre comience por una A y termine por una S.

SELECT nombre,version
FROM programas
WHERE version LIKE '%i' OR
nombre LIKE 'A%S';

# 23 Obtén un listado en el que aparezcan los programas cuya versión finalice
# por una letra i, y cuyo nombre no comience por una A.

SELECT nombre, version
FROM programas
WHERE version LIKE '%i'
AND nombre NOT LIKE 'A%';

# 24 Obtén una lista de empresas por orden alfabético ascendente.

SELECT DISTINCT nombre
FROM comercios
UNION
SELECT DISTINCT nombre
FROM fabricantes
ORDER BY nombre ASC;

# 25 Genera un listado de empresas por orden alfabético descendente.

SELECT DISTINCT nombre
FROM comercios
UNION
SELECT DISTINCT nombre
FROM fabricantes
ORDER BY nombre DESC;

# 26 Obtén un listado de programas por orden de versión

SELECT nombre,version
FROM programas
ORDER BY version ASC;


# 27 Genera un listado de los programas que desarrolla Oracle.

SELECT p.*
FROM programas p, fabricantes f, desarrolla d
WHERE f.cod_fab = d.cod_fabricante
AND p.cod_programa = d.cod_prog
AND f.nombre = 'Oracle';

# 28 ¿Qué comercios distribuyen Windows?

SELECT DISTINCT nombre
FROM comercios
WHERE CIF IN (SELECT cif 
FROM distribuye
WHERE codigo_prog IN (SELECT cod_programa
FROM programas
WHERE nombre='WINDOWS'));

# 29 Genera un listado de los programas y cantidades que se han distribuido a El
# Corte Inglés de Madrid.

SELECT CONCAT(p.nombre,' ',p.version),d.cantidad
FROM distribuye d, programas p
WHERE d.codigo_prog = p.cod_programa
AND d.cif_empresa = (SELECT cif
FROM comercios c
WHERE c.nombre='El Corte Inglés'
AND c.ciudad='Madrid');

#30 ¿Qué fabricante ha desarrollado Freddy Hardest?

SELECT nombre
FROM fabricantes
WHERE cod_fab = (SELECT cod_fabricante
FROM desarrolla
WHERE cod_prog = (SELECT cod_programa
FROM programas
WHERE nombre = 'Freddy Hardest'));

#31 Selecciona el nombre de los programas que se registran por Internet.

SELECT nombre
FROM programas
WHERE cod_programa IN (SELECT codigo_programa
FROM registra
WHERE medio='Internet');

#32 Selecciona el nombre de las personas que se registran por Internet.

SELECT nombre
FROM clientes
WHERE dni IN (SELECT dni_cliente
FROM registra
WHERE medio='Internet');

#33 ¿Qué medios ha utilizado para registrarse Pepe Pérez?

SELECT medio
FROM registra
WHERE dni_cliente IN (SELECT dni
FROM clientes
WHERE nombre='Pepe Pérez');

#34 ¿Qué usuarios han optado por Internet como medio de registro?

SELECT nombre
FROM clientes
WHERE dni IN (SELECT dni_cliente
FROM registra
WHERE medio='Internet');

#35 ¿Qué programas han recibido registros por tarjeta postal?

SELECT nombre
FROM programas
WHERE cod_programa IN (SELECT codigo_programa
FROM registra
WHERE medio='Tarjeta postal');

#36 ¿En qué localidades se han vendido productos que se han registrado por
#Internet?

SELECT c.ciudad
FROM distribuye d, comercios c, registra r
WHERE d.cif_empresa = c.cif
AND d.codigo_prog = r.codigo_programa
AND r.medio = 'Internet';

#37 Obtén un listado de los nombres de las personas que se han registrado por
#Internet, junto al nombre de los programas para los que ha efectuado el
#registro.

SELECT c.nombre, p.nombre
FROM clientes c, programas p
WHERE (c.dni, p.cod_programa) IN (SELECT dni_cliente,codigo_programa
FROM registra
WHERE medio = 'Internet');

#38 Genera un listado en el que aparezca cada cliente junto al programa que ha
#registrado, el medio con el que lo ha hecho y el comercio en el que lo ha
#adquirido.

SELECT c.nombre, p.nombre, r.medio, co.nombre
FROM clientes c, programas p, registra r, comercios co
WHERE c.dni = r.dni_cliente
AND r.codigo_programa = p.cod_programa
AND r.cif_emp = co.cif;

# 39 Genera un listado con las ciudades en las que se pueden obtener los
# productos de Oracle.

SELECT ciudad
FROM comercios
WHERE cif IN (SELECT cif 
FROM distribuye
WHERE codigo_prog IN
(SELECT cod_prog
FROM desarrolla
WHERE cod_fabricante IN
(SELECT cod_fab
FROM fabricantes
WHERE nombre = 'Oracle')));

# 40 Obtén el nombre de los usuarios que han registrado Access XP.


SELECT nombre
FROM clientes
WHERE dni IN (SELECT dni_cliente
FROM registra
WHERE codigo_programa IN
(SELECT cod_programa
FROM programas
WHERE nombre = 'ACCESS' 
AND version = 'XP'));

# 41 Nombre de aquellos fabricantes cuyo país es el mismo que ʻOracleʼ.
# (Subconsulta).

SELECT nombre
FROM fabricantes
WHERE pais IN(SELECT pais
FROM fabricantes
WHERE nombre = 'Oracle')
AND nombre!='Oracle';

# 42 Nombre de aquellos clientes que tienen la misma edad que Pepe Pérez.
# (Subconsulta).

SELECT nombre
FROM clientes
WHERE edad =
(SELECT edad
FROM clientes
WHERE nombre='Pepe Pérez');

# 43 Genera un listado con los comercios que tienen su sede en la misma ciudad
# que tiene el comercio ʻFNACʼ. (Subconsulta).

SELECT nombre
FROM comercios
WHERE ciudad IN
(SELECT ciudad
FROM comercios
WHERE nombre='FNAC');

# 44 Nombre de aquellos clientes que han registrado un producto de la misma
# forma que el cliente ʻPepe Pérezʼ. (Subconsulta).

SELECT DISTINCT nombre
FROM clientes
WHERE dni IN(SELECT dni_cliente
FROM registra
WHERE medio IN(SELECT DISTINCT medio
FROM registra
WHERE dni_cliente = (SELECT dni
FROM clientes
WHERE nombre='Pepe Pérez')));

# 45 Obtener el número de programas que hay en la tabla programas.

SELECT COUNT(*)
FROM programas;

# 46 Calcula el número de clientes cuya edad es mayor de 40 años.

SELECT COUNT(dni)
FROM clientes
WHERE edad>40;

# 47 Calcula el número de productos que ha vendido el establecimiento cuyo CIF
# es 1.

SELECT SUM(cantidad)
FROM distribuye
WHERE cif_empresa='1';

# 48 Calcula la media de programas que se venden cuyo código es 7.

SELECT AVG(cantidad)
FROM distribuye
WHERE codigo_prog =7;

# 49 Calcula la mínima cantidad de programas de código 7 que se ha vendido

SELECT min(cantidad)
FROM distribuye
WHERE codigo_prog=7;

# 50 Calcula la máxima cantidad de programas de código 7 que se ha vendido.

SELECT max(cantidad)
FROM distribuye
WHERE codigo_prog=7;

# 51 ¿En cuántos establecimientos se vende el programa cuyo código es 7?

SELECT DISTINCT COUNT(cif_empresa)
FROM distribuye
WHERE codigo_prog='7';

# 52 Calcular el número de registros que se han realizado por Internet.

SELECT COUNT(*)
FROM registra
WHERE medio='Internet';

# 53 Obtener el número total de programas que se han vendido en ʻSevillaʼ.

SELECT SUM(cantidad)
FROM distribuye
WHERE cif_empresa IN(SELECT CIF
FROM comercios
WHERE ciudad='Sevilla');

# 54 Calcular el número total de programas que han desarrollado los fabricantes
# cuyo país es ʻEstados Unidosʼ.

SELECT COUNT(*)
FROM programas
WHERE cod_programa IN(
SELECT cod_prog
FROM desarrolla
WHERE cod_fabricante IN(SELECT cod_fab
FROM fabricantes
WHERE pais='Estados Unidos'));

# 55 Visualiza el nombre de todos los clientes en mayúscula. En el resultado de
# la consulta debe aparecer también la longitud de la cadena nombre.

SELECT UPPER(nombre),LENGTH(nombre)
FROM clientes;

# 56 Con una consulta concatena los campos nombre y versión de la tabla
# PROGRAMA.

SELECT CONCAT(nombre,' ',version)
FROM programas;