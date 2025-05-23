/* Una empresa almacena los datos de sus empleados en una tabla "empleados".
1- Elimine la tabla, si existe: */
 if object_id('empleados') is not null
  drop table empleados;

/* 2- Cree la tabla: */
 create table empleados(
  nombre varchar(30),
  documento char(8),
  domicilio varchar(30),
  seccion varchar(20),
  sueldo decimal(6,2),
  cantidadhijos tinyint,
  primary key(documento)
 );

/* 3- Ingrese algunos registros: */
 insert into empleados
  values('Juan Perez','22333444','Colon 123','Gerencia',5000,2);
 insert into empleados
  values('Ana Acosta','23444555','Caseros 987','Secretaria',2000,0);
 insert into empleados
  values('Lucas Duarte','25666777','Sucre 235','Sistemas',4000,1);
 insert into empleados
  values('Pamela Gonzalez','26777888','Sarmiento 873','Secretaria',2200,3);
 insert into empleados
  values('Marcos Juarez','30000111','Rivadavia 801','Contaduria',3000,0);
 insert into empleados
  values('Yolanda Perez','35111222','Colon 180','Administracion',3200,1);
 insert into empleados
  values('Rodolfo Perez','35555888','Coronel Olmedo 588','Sistemas',4000,3);
 insert into empleados
  values('Martina Rodriguez','30141414','Sarmiento 1234','Administracion',3800,4);
 insert into empleados
  values('Andres Costa','28444555',default,'Secretaria',null,null);

/* 4- Muestre la cantidad de empleados usando "count" (9 empleados) */

SELECT COUNT(nombre) AS Cantidad_de_empleados
FROM dbo.empleados

/* 5- Muestre la cantidad de empleados con sueldo no nulo de la sección "Secretaria" (2 empleados) */

SELECT COUNT(*) AS Empleados_con_sueldos
FROM empleados
WHERE seccion = 'secretaria'

/* 6- Muestre el sueldo más alto y el más bajo colocando un alias (5000 y 2000) */

SELECT 
MAX(sueldo) AS Mayor_Sueldo, 
MIN(sueldo) AS Menor_Sueldo
FROM empleados

/* 7- Muestre el valor mayor de "cantidadhijos" de los empleados "Perez" (3 hijos) */

SELECT MAX(cantidadhijos) AS Mayor_Cantidad_Hijos_Perez
FROM empleados
WHERE nombre LIKE '%Perez%'

/* 8- Muestre el promedio de sueldos de todo los empleados (3400. Note que hay un sueldo nulo y no es 
tenido en cuenta) */

SELECT AVG(sueldo) AS Promedio_Sueldos
FROM empleados

/* 9- Muestre el promedio de sueldos de los empleados de la sección "Secretaría" (2100) */

SELECT AVG(sueldo) AS Promedio_Sueldos_Secretaria
FROM empleados
WHERE seccion = 'secretaria'

/* 10- Muestre el promedio de hijos de todos los empleados de "Sistemas" (2) */

SELECT AVG(cantidadhijos) AS Promedio_Hijos_Sistemas
FROM empleados
WHERE seccion = 'Sistemas'



/* Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos.*/ 

/* 1- Elimine la tabla "visitantes", si existe: */

 if object_id('visitantes') is not null
  drop table visitantes;

/* 2- Cree la tabla con la siguiente estructura: */

 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1) default 'f',
  domicilio varchar(30),
  ciudad varchar(20) default 'Cordoba',
  telefono varchar(11),
  mail varchar(30) default 'no tiene',
  montocompra decimal (6,2)
 );

/* 3- Ingrese algunos registros: */

 insert into visitantes
  values ('Susana Molina',35,default,'Colon 123',default,null,null,59.80);
 insert into visitantes
  values ('Marcos Torres',29,'m',default,'Carlos Paz',default,'marcostorres@hotmail.com',150.50);
 insert into visitantes
  values ('Mariana Juarez',45,default,default,'Carlos Paz',null,default,23.90);
 insert into visitantes (nombre, edad,sexo,telefono, mail)
  values ('Fabian Perez',36,'m','4556677','fabianperez@xaxamail.com');
 insert into visitantes (nombre, ciudad, montocompra)
  values ('Alejandra Gonzalez','La Falda',280.50);
 insert into visitantes (nombre, edad,sexo, ciudad, mail,montocompra)
  values ('Gaston Perez',29,'m','Carlos Paz','gastonperez1@gmail.com',95.40);
 insert into visitantes
  values ('Liliana Torres',40,default,'Sarmiento 876',default,default,default,85);
 insert into visitantes
  values ('Gabriela Duarte',21,null,null,'Rio Tercero',default,'gabrielaltorres@hotmail.com',321.50);

/* 4- Queremos saber la cantidad de visitantes de cada ciudad utilizando la cláusula "group by" (4 filas devueltas)*/

SELECT ciudad, COUNT(*) AS Cantidad_Visitantes
FROM visitantes
GROUP BY ciudad

/* 5- Queremos la cantidad visitantes con teléfono no nulo, de cada ciudad (4 filas devueltas)*/

SELECT ciudad, COUNT(telefono) AS Cantidad_Telefono_Visitantes
FROM visitantes
GROUP BY ciudad

/* 6- Necesitamos el total del monto de las compras agrupadas por sexo (3 filas)*/

SELECT sexo, SUM(montocompra) AS Total_Compras_Por_Sexo
FROM visitantes
GROUP BY sexo

/* 7- Se necesita saber el máximo y mínimo valor de compra agrupados por sexo y ciudad (6 filas)*/

SELECT sexo, ciudad, 
MAX(montocompra) AS Mayor_Compra, 
MIN(montocompra) AS Menor_Compra
FROM visitantes
GROUP BY sexo, ciudad

/* 8- Calcule el promedio del valor de compra agrupados por ciudad (4 filas)*/

SELECT ciudad, AVG(montocompra) AS Promedio_Compra
FROM visitantes
GROUP BY ciudad

/* 9- Cuente y agrupe por ciudad sin tener en cuenta los visitantes que no tienen mail (3 filas):*/

SELECT ciudad, COUNT(mail) AS Numero_Visitantes_Mail
FROM visitantes
WHERE mail != 'No tiene'
GROUP BY ciudad

/* 10- Realice la misma consulta anterior, pero use la palabra clave "all" para mostrar todos los 
valores de ciudad, incluyendo las que devuelven cero o "null" en la columna de agregado (4 filas)*/

SELECT ciudad, COUNT(*) AS Numero_Visitantes_Mail
FROM visitantes
GROUP BY ciudad


						/* Primer problema: */

/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes".*/

/* 1- Elimine la tabla "clientes", si existe:*/
 if object_id('clientes') is not null
  drop table clientes;

/* 2- Créela con la siguiente estructura:*/

 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  provincia varchar (20),
  telefono varchar(11),
  primary key(codigo)
);

/* 3- Ingrese algunos registros:*/

 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba','null');
 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445');
 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null);
 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685');
 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525');
 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455');
 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba',null);
 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366');
 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

/* 4- Obtenga el total de los registros agrupados por ciudad y provincia (6 filas)*/

SELECT ciudad, provincia, COUNT(*) AS Total_Registro
FROM clientes
GROUP BY ciudad, provincia

/* 5- Obtenga el total de los registros agrupados por ciudad y provincia sin considerar los que tienen
menos de 2 clientes (3 filas)  */

SELECT ciudad, provincia, COUNT(*) AS Total_Registro
FROM clientes
GROUP BY ciudad, provincia
HAVING COUNT(*) > 1

/* 6- Obtenga el total de los clientes que viven en calle "San Martin" (where), agrupados por provincia 
(group by), teniendo en cuenta todos los valores (all), de aquellas ciudades que tengan menos de 2 
clientes (having) y omitiendo la fila correspondiente a la ciudad de "Cordoba" (having) (4 filas 
devueltas) */

SELECT ciudad, COUNT(*) AS Total_Registro
FROM clientes
WHERE domicilio LIKE '%San Martin%'
GROUP BY all ciudad
HAVING COUNT(*) < 2
AND ciudad <> 'Cordoba'



										/* Segundo problema:*/


/* Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos 
de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos. */

/* 1- Elimine la tabla "visitantes", si existe: */
 if object_id('visitantes') is not null
  drop table visitantes;

/* 2- Créela con la siguiente estructura: */
 create table visitantes(
  nombre varchar(30),
  edad tinyint,
  sexo char(1),
  domicilio varchar(30),
  ciudad varchar(20),
  telefono varchar(11),
  montocompra decimal(6,2) not null
 );

/* 3- Ingrese algunos registros: */
 insert into visitantes
  values ('Susana Molina',28,'f',null,'Cordoba',null,45.50); 
 insert into visitantes
  values ('Marcela Mercado',36,'f','Avellaneda 345','Cordoba','4545454',22.40);
 insert into visitantes
  values ('Alberto Garcia',35,'m','Gral. Paz 123','Alta Gracia','03547123456',25); 
 insert into visitantes
  values ('Teresa Garcia',33,'f',default,'Alta Gracia','03547123456',120);
 insert into visitantes
  values ('Roberto Perez',45,'m','Urquiza 335','Cordoba','4123456',33.20);
 insert into visitantes
  values ('Marina Torres',22,'f','Colon 222','Villa Dolores','03544112233',95);
 insert into visitantes
  values ('Julieta Gomez',24,'f','San Martin 333','Alta Gracia',null,53.50);
 insert into visitantes
  values ('Roxana Lopez',20,'f','null','Alta Gracia',null,240);
 insert into visitantes
  values ('Liliana Garcia',50,'f','Paso 999','Cordoba','4588778',48);
 insert into visitantes
  values ('Juan Torres',43,'m','Sarmiento 876','Cordoba',null,15.30);

/* 4- Obtenga el total de las compras agrupados por ciudad y sexo de aquellas filas que devuelvan un 
valor superior a 50 (3 filas) */

SELECT ciudad, SUM(montocompra) AS Total_Compra
FROM visitantes
GROUP BY ciudad, sexo
HAVING SUM(montocompra) > 50

/* 5- Obtenga el total de las compras agrupados por ciudad y sexo (group by), teniendo en cuenta todos 
los valores (all), considerando sólo los montos de compra superiores a 50 (where), los visitantes 
con teléfono (where), sin considerar la ciudad de "Cordoba" (having), ordenados por ciudad (order 
by) (3 filas) */

SELECT ciudad, MAX(montocompra) AS Total_Compra
FROM visitantes
WHERE montocompra > 50 
AND telefono is not null
GROUP BY all ciudad, sexo
HAVING ciudad <> 'Cordoba'
ORDER BY ciudad

/* 6- Muestre el monto mayor de compra agrupado por ciudad, siempre que dicho valor supere los 50 pesos 
(having), considerando sólo los visitantes de sexo femenino y domicilio conocido (where) (2 filas) */

SELECT ciudad, MAX(montocompra) AS Mayor_Compra
FROM visitantes
WHERE domicilio is not null AND sexo = 'f'
GROUP BY ALL ciudad
HAVING MAX(montocompra) > 50

/* 7- Agrupe por ciudad y sexo, muestre para cada grupo el total de visitantes, la suma de sus compras 
y el promedio de compras, ordenado por la suma total y considerando las filas con promedio superior 
a 30 (3 filas) */

SELECT ciudad, sexo,
COUNT(ciudad) AS Total_Visitante, 
SUM(montocompra) AS Total_Compra,
AVG(montocompra) AS Promedio_Compra
FROM visitantes
GROUP BY ciudad, sexo
HAVING AVG(montocompra) > 30
ORDER BY Total_Compra




							/* Primer problema: */

/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes". */

/* 1- Elimine la tabla "clientes", si existe: */
 if object_id('clientes') is not null
  drop table clientes;

/* 2- Créela con la siguiente estructura: */
 create table clientes (
  codigo int identity,
  nombre varchar(30) not null,
  domicilio varchar(30),
  ciudad varchar(20),
  provincia varchar (20),
  primary key(codigo)
);

/* 3- Ingrese algunos registros:*/

 insert into clientes
  values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
 insert into clientes
  values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
 insert into clientes
  values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
 insert into clientes
  values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
 insert into clientes
  values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
 insert into clientes
  values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
 insert into clientes
  values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
 insert into clientes
  values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');

/* 4- Obtenga las provincias sin repetir (3 registros)*/

SELECT distinct provincia
FROM clientes

/* 5- Cuente las distintas provincias.*/

SELECT COUNT(distinct provincia) AS Numero_Provincias
FROM clientes

/* 6- Se necesitan los nombres de las ciudades sin repetir (6 registros)*/

SELECT distinct ciudad
FROM clientes

/* 7- Obtenga la cantidad de ciudades distintas.*/

SELECT COUNT(distinct ciudad) AS Numero_Ciudades
FROM clientes

/* 8- Combine con "where" para obtener las distintas ciudades de la provincia de Cordoba (3 registros)*/

SELECT distinct ciudad
FROM clientes
WHERE provincia <> 'Cordoba'

/* 9- Contamos las distintas ciudades de cada provincia empleando "group by" (3 registros) */

SELECT provincia, COUNT(distinct ciudad) AS numero_ciudades
FROM clientes
GROUP BY provincia



											/* Segundo problema:*/

/* La provincia almacena en una tabla llamada "inmuebles" los siguientes datos de los inmuebles y sus 
propietarios para cobrar impuestos:*/

/* 1- Elimine la tabla si existe: */

 if object_id('inmuebles') is not null
  drop table inmuebles;

/* 2- Créela con la siguiente estructura: */
 create table inmuebles (
  documento varchar(8) not null,
  apellido varchar(30),
  nombre varchar(30),
  domicilio varchar(20),
  barrio varchar(20),
  ciudad varchar(20),
  tipo char(1),--b=baldio, e: edificado
  superficie decimal (8,2)
 );

/* 3- Ingrese algunos registros: */

 insert into inmuebles
  values ('11000000','Perez','Alberto','San Martin 800','Centro','Cordoba','e',100);
 insert into inmuebles
  values ('11000000','Perez','Alberto','Sarmiento 245','Gral. Paz','Cordoba','e',200);
 insert into inmuebles
  values ('12222222','Lopez','Maria','San Martin 202','Centro','Cordoba','e',250);
 insert into inmuebles
  values ('13333333','Garcia','Carlos','Paso 1234','Alberdi','Cordoba','b',200);
 insert into inmuebles
  values ('13333333','Garcia','Carlos','Guemes 876','Alberdi','Cordoba','b',300);
 insert into inmuebles
  values ('14444444','Perez','Mariana','Caseros 456','Flores','Cordoba','b',200);
 insert into inmuebles
  values ('15555555','Lopez','Luis','San Martin 321','Centro','Carlos Paz','e',500);
 insert into inmuebles
  values ('15555555','Lopez','Luis','Lopez y Planes 853','Flores','Carlos Paz','e',350);
 insert into inmuebles
  values ('16666666','Perez','Alberto','Sucre 1877','Flores','Cordoba','e',150);

/* 4- Muestre los distintos apellidos de los propietarios, sin repetir (3 registros)*/

SELECT distinct apellido
FROM inmuebles

/* 5- Muestre los distintos documentos de los propietarios, sin repetir (6 registros)*/

SELECT distinct documento 
FROM inmuebles

/* 6- Cuente, sin repetir, la cantidad de propietarios de inmuebles de la ciudad de Cordoba (5)*/

SELECT COUNT(distinct documento)
FROM inmuebles
WHERE ciudad = 'Cordoba'

/* 7- Cuente la cantidad de inmuebles con domicilio en 'San Martin', sin repetir la ciudad (2)*/

SELECT count(ciudad)
FROM inmuebles
WHERE domicilio like 'San Martin %';

/* 8- Muestre los apellidos y nombres, sin repetir (5 registros)
Note que hay 2 personas con igual nombre y apellido que aparece una sola vez.*/

SELECT distinct apellido,nombre 
FROM inmuebles;

/* 9- Muestre la cantidad de inmuebles que tiene cada propietario agrupando por documento, sin repetir 
barrio (6 registros) */

SELECT documento,count(distinct barrio) as 'cantidad'
FROM inmuebles
GROUP BY documento;



							 /*  Primer problema: */ 
/* Una empresa tiene registrados sus empleados en una tabla llamada "empleados".*/ 

/* 1- Elimine la tabla si existe:*/ 

 if object_id('empleados') is not null
  drop table empleados;

/* 2- Créela con la siguiente estructura: */ 
 
 create table empleados (
  documento varchar(8) not null,
  nombre varchar(30),
  estadocivil char(1),--c=casado, s=soltero,v=viudo
  seccion varchar(20)
 );

/* 3- Ingrese algunos registros:*/ 

 insert into empleados
  values ('22222222','Alberto Lopez','c','Sistemas');
 insert into empleados
  values ('23333333','Beatriz Garcia','c','Administracion');
 insert into empleados
  values ('24444444','Carlos Fuentes','s','Administracion');
 insert into empleados
  values ('25555555','Daniel Garcia','s','Sistemas');
 insert into empleados
  values ('26666666','Ester Juarez','c','Sistemas');
 insert into empleados
  values ('27777777','Fabian Torres','s','Sistemas');
 insert into empleados
  values ('28888888','Gabriela Lopez',null,'Sistemas');
 insert into empleados
  values ('29999999','Hector Garcia',null,'Administracion');

/* 4- Muestre los 5 primeros registros (5 registros)*/ 
SELECT top 5 * 
FROM empleados;


/* 5- Muestre nombre y seccion de los 4 primeros registros ordenados por sección (4 registros)*/ 
SELECT top 4 nombre,seccion
FROM empleados
ORDER BY seccion;


/* 6- Realice la misma consulta anterior pero incluya todos los registros que tengan el mismo valor en 
"seccion" que el último (8 registros)*/ 
SELECT top 4 with ties nombre,seccion
FROM empleados
ORDER BY seccion;


/* 7- Muestre nombre, estado civil y seccion de los primeros 4 empleados ordenados por estado civil y 
sección (4 registros)*/ 
SELECT top 4 nombre,estadocivil,seccion
FROM empleados
ORDER BY estadocivil,seccion;


/* 8- Realice la misma consulta anterior pero incluya todos los valores iguales al último registro 
retornado (5 registros)*/ 
SELECT top 4 with ties nombre,estadocivil,seccion
FROM empleados
ORDER BY estadocivil,seccion;



					/* Primer problema: */

/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"provincias" donde registra los nombres de las provincias. */

/* 1- Elimine las tablas "clientes" y "provincias", si existen: */
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

/* 2- Créelas con las siguientes estructuras: */

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

/* 3- Ingrese algunos registros para ambas tablas: */

 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Pereyra Lucas','San Martin 555','Cruz del Eje',1);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','Ibera',3);

/* 4- Obtenga los datos de ambas tablas, usando alias: */

 select c.nombre,domicilio,ciudad,p.nombre
  from clientes as c
  join provincias as p
  on c.codigoprovincia=p.codigo;

/* 5- Obtenga la misma información anterior pero ordenada por nombre de provincia. */

SELECT c.nombre,domicilio,ciudad,p.nombre
FROM clientes as c
JOIN provincias as p
ON  c.codigoprovincia=p.codigo
ORDER BY p.nombre;

/* 6- Recupere los clientes de la provincia "Santa Fe" (2 registros devueltos)
Ver solución */

 SELECT c.nombre,domicilio,ciudad
FROM clientes as c
JOIN provincias as p
ON c.codigoprovincia=p.codigo
WHERE p.nombre='Santa Fe';



									/*	Segundo problema: */

/* Un club dicta clases de distintos deportes. Almacena la información en una tabla llamada 
"inscriptos" que incluye el documento, el nombre, el deporte y si la matricula esta paga o no y una 
tabla llamada "inasistencias" que incluye el documento, el deporte y la fecha de la inasistencia. */

/* 1- Elimine las tablas si existen y cree las tablas:*/
 if (object_id('inscriptos')) is not null
  drop table inscriptos;
 if (object_id('inasistencias')) is not null
  drop table inasistencias;

 create table inscriptos(
  nombre varchar(30),
  documento char(8),
  deporte varchar(15),
  matricula char(1), --'s'=paga 'n'=impaga
  primary key(documento,deporte)
 );

 create table inasistencias(
  documento char(8),
  deporte varchar(15),
  fecha datetime
 );

/* 2- Ingrese algunos registros para ambas tablas:*/
 insert into inscriptos values('Juan Perez','22222222','tenis','s');
 insert into inscriptos values('Maria Lopez','23333333','tenis','s');
 insert into inscriptos values('Agustin Juarez','24444444','tenis','n');
 insert into inscriptos values('Marta Garcia','25555555','natacion','s');
 insert into inscriptos values('Juan Perez','22222222','natacion','s');
 insert into inscriptos values('Maria Lopez','23333333','natacion','n');

 insert into inasistencias values('22222222','tenis','2006-12-01');
 insert into inasistencias values('22222222','tenis','2006-12-08');
 insert into inasistencias values('23333333','tenis','2006-12-01');
 insert into inasistencias values('24444444','tenis','2006-12-08');
 insert into inasistencias values('22222222','natacion','2006-12-02');
 insert into inasistencias values('23333333','natacion','2006-12-02');

/* 3- Muestre el nombre, el deporte y las fechas de inasistencias, ordenado por nombre y deporte.
Note que la condición es compuesta porque para identificar los registros de la tabla "inasistencias" 
necesitamos ambos campos.*/

SELECT nombre,insc.deporte,ina.fecha
FROM inscriptos as insc
JOIN inasistencias as ina
ON insc.documento=ina.documento and
insc.deporte=ina.deporte
ORDER BY nombre, insc.deporte;

/* 4- Obtenga el nombre, deporte y las fechas de inasistencias de un determinado inscripto en un 
determinado deporte (3 registros)*/

SELECT nombre,insc.deporte, ina.fecha
FROM inscriptos as insc
JOIN inasistencias as ina
ON insc.documento=ina.documento and
insc.deporte=ina.deporte
WHERE insc.documento='22222222';


/* 5- Obtenga el nombre, deporte y las fechas de inasistencias de todos los inscriptos que pagaron la 
matrícula(4 registros)*/

SELECT nombre,insc.deporte, ina.fecha
FROM inscriptos as insc
JOIN inasistencias as ina
ON insc.documento=ina.documento and
insc.deporte=ina.deporte
WHERE insc.matricula='s';



							/* Primer problema: */

/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"provincias" donde registra los nombres de las provincias. */

/* 1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas: */
  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

/* 2- Ingrese algunos registros para ambas tablas:  */
 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

/* 3- Muestre todos los datos de los clientes, incluido el nombre de la provincia: */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes as c
LEFT JOIN provincias as p
ON codigoprovincia = p.codigo;

/* 4- Realice la misma consulta anterior pero alterando el orden de las tablas: */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias as p
LEFT JOIN clientes as c
ON codigoprovincia = p.codigo;

/* 5- Muestre solamente los clientes de las provincias que existen en "provincias" (5 registros): */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes as c
LEFT JOIN provincias as p
ON codigoprovincia = p.codigo
WHERE p.codigo is not null;

/* 6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
nombre del cliente (2 registros): */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes as c
LEFT JOIN provincias as p
ON codigoprovincia = p.codigo
WHERE p.codigo is null
ORDER BY c.nombre;

/* 7- Obtenga todos los datos de los clientes de "Cordoba" (3 registros): */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes as c
LEFT JOIN provincias as p
ON codigoprovincia = p.codigo
WHERE p.nombre='Cordoba';



								/* Primer problema:*/

/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una 
tabla "provincias" donde registra los nombres de las provincias. */

/* 1- Elimine las tablas "clientes" y "provincias", si existen y cree las tablas:  */

  if (object_id('clientes')) is not null
   drop table clientes;
  if (object_id('provincias')) is not null
   drop table provincias;

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  ciudad varchar(20),
  codigoprovincia tinyint not null,
  primary key(codigo)
 );

 create table provincias(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

/* 2- Ingrese algunos registros para ambas tablas: */

 insert into provincias (nombre) values('Cordoba');
 insert into provincias (nombre) values('Santa Fe');
 insert into provincias (nombre) values('Corrientes');

 insert into clientes values ('Lopez Marcos','Colon 111','Córdoba',1);
 insert into clientes values ('Perez Ana','San Martin 222','Cruz del Eje',1);
 insert into clientes values ('Garcia Juan','Rivadavia 333','Villa Maria',1);
 insert into clientes values ('Perez Luis','Sarmiento 444','Rosario',2);
 insert into clientes values ('Gomez Ines','San Martin 666','Santa Fe',2);
 insert into clientes values ('Torres Fabiola','Alem 777','La Plata',4);
 insert into clientes values ('Garcia Luis','Sucre 475','Santa Rosa',5);

/* 3- Muestre todos los datos de los clientes, incluido el nombre de la provincia empleando un "right 
join". */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias as p
RIGHT JOIN clientes as c
ON codigoprovincia = p.codigo;

/* 4- Obtenga la misma salida que la consulta anterior pero empleando un "left join". */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM clientes as c
LEFT JOIN provincias as p
ON codigoprovincia = p.codigo;

/* 5- Empleando un "right join", muestre solamente los clientes de las provincias que existen en 
"provincias" (5 registros) */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias as p
RIGHT JOIN clientes as c
ON codigoprovincia = p.codigo
WHERE p.codigo is not null;

/* 6- Muestre todos los clientes cuyo código de provincia NO existe en "provincias" ordenados por 
ciudad (2 registros) */

SELECT c.nombre,domicilio,ciudad, p.nombre
FROM provincias as p
RIGHT JOIN clientes as c
ON codigoprovincia = p.codigo
WHERE p.codigo is null
ORDER BY ciudad;


							/* Primer problema: */
							
/* Una empresa tiene registrados sus clientes en una tabla llamada "clientes", también tiene una tabla 
"ciudades" donde registra los nombres de las ciudades. */

/* 1- Elimine las tablas "clientes" y "ciudades", si existen:  */

  if (object_id('ciudades')) is not null
   drop table ciudades;
  if (object_id('clientes')) is not null
   drop table clientes;

/* 2- Cree la tabla "clientes" (codigo, nombre, domicilio, ciudad, codigociudad) y "ciudades" (codigo, 
nombre). Agregue una restricción "primary key" para el campo "codigo" de ambas tablas y una "foreing 
key" para validar que el campo "codigociudad" exista en "ciudades" con actualización en cascada: */

 create table ciudades(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
 );

 create table clientes (
  codigo int identity,
  nombre varchar(30),
  domicilio varchar(30),
  codigociudad tinyint not null,
  primary key(codigo),
  constraint FK_clientes_ciudad
   foreign key (codigociudad)
   references ciudades(codigo)
   on update cascade,
 );

/* 3- Ingrese algunos registros para ambas tablas:*/

 insert into ciudades (nombre) values('Cordoba');
 insert into ciudades (nombre) values('Cruz del Eje');
 insert into ciudades (nombre) values('Carlos Paz');
 insert into ciudades (nombre) values('La Falda');
 insert into ciudades (nombre) values('Villa Maria');

 insert into clientes values ('Lopez Marcos','Colon 111',1);
 insert into clientes values ('Lopez Hector','San Martin 222',1);
 insert into clientes values ('Perez Ana','San Martin 333',2);
 insert into clientes values ('Garcia Juan','Rivadavia 444',3);
 insert into clientes values ('Perez Luis','Sarmiento 555',3);
 insert into clientes values ('Gomez Ines','San Martin 666',4);
 insert into clientes values ('Torres Fabiola','Alem 777',5);
 insert into clientes values ('Garcia Luis','Sucre 888',5);

/* 4- Necesitamos conocer los nombres de las ciudades de aquellos clientes cuyo domicilio es en calle 
"San Martin", empleando subconsulta. 3 registros. */

SELECT nombre
FROM ciudades
WHERE codigo in
(SELECT codigociudad
FROM clientes
WHERE domicilio like 'San Martin %');

/* 5- Obtenga la misma salida anterior pero empleando join. */

SELECT distinct ci.nombre
FROM ciudades as ci
JOIN clientes as cl
ON codigociudad=ci.codigo
WHERE domicilio like 'San Martin%';

/* 6- Obtenga los nombre de las ciudades de los clientes cuyo apellido no comienza con una letra 
específica, empleando subconsulta. 2 registros. */

SELECT nombre
FROM ciudades
WHERE codigo not in
(SELECT codigociudad
FROM clientes
WHERE nombre like 'G%');

/* 7- Pruebe la subconsulta del punto 6 separada de la consulta exterior para verificar que retorna una 
lista de valores de un solo campo. */

SELECT codigociudad
FROM clientes
WHERE nombre like 'G%';

