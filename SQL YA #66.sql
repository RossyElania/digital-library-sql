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