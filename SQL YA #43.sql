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