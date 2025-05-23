-- 1. Creación de la base de datos
CREATE DATABASE BibliotecaDigital;
USE BibliotecaDigital;

-- 2. Creación de tablas
CREATE TABLE Autores (
    autor_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL,
    nacionalidad VARCHAR(100) NOT NULL
);

CREATE TABLE Libros (
    libro_id INT PRIMARY KEY IDENTITY(1,1),
    titulo VARCHAR(255) NOT NULL,
    genero VARCHAR(100),
    año_publicacion INT,  
    autor_id INT,
    FOREIGN KEY (autor_id) REFERENCES Autores(autor_id)
);

CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(255) NOT NULL,
    fecha_registro DATE,
    membresia VARCHAR(50)
);

CREATE TABLE Prestamos (
    prestamo_id INT PRIMARY KEY IDENTITY(1,1),
    libro_id INT,
    usuario_id INT,
    fecha_prestamo DATE,
    fecha_devolucion DATE,
    FOREIGN KEY (libro_id) REFERENCES Libros(libro_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- 3. Población de datos iniciales
INSERT INTO Autores (nombre, nacionalidad) VALUES
('Gabriel García Márquez', 'Colombiana'),
('J.K. Rowling', 'Británica'),
('George Orwell', 'Británica'),
('Miguel de Cervantes', 'Española'),
('Julio Verne', 'Francesa');

INSERT INTO Libros (titulo, genero, año_publicacion, autor_id) VALUES
('Cien años de soledad', 'Realismo mágico', 1967, 1),
('Harry Potter y la piedra filosofal', 'Fantasía', 1997, 2),
('1984', 'Ciencia ficción', 1949, 3),
('Don Quijote de la Mancha', 'Aventura', 1605, 4),
('Viaje al centro de la Tierra', 'Ciencia ficción', 1864, 5);

INSERT INTO Usuarios (nombre, fecha_registro, membresia) VALUES
('Juan Pérez', '2024-01-15', 'Básica'),
('María López', '2024-02-10', 'Premium'),
('Carlos Gómez', '2024-03-05', 'Básica');

INSERT INTO Prestamos (libro_id, usuario_id, fecha_prestamo, fecha_devolucion) VALUES
(1, 1, '2024-03-01', '2024-03-15'),
(2, 2, '2024-03-02', '2024-03-16'),
(3, 3, '2024-03-03', '2024-03-17');

-- 4. Consultas

-- a. ¿Cuántos libros ha prestado cada usuario?
SELECT usuario_id, COUNT(*) AS total_prestamos FROM Prestamos GROUP BY usuario_id;

-- b. ¿Qué libros se prestaron entre dos fechas específicas?
SELECT * FROM Prestamos WHERE fecha_prestamo BETWEEN '2024-03-01' AND '2024-03-10';

-- c. ¿Cuál es el libro más prestado y quiénes fueron sus usuarios?
SELECT TOP 1 libro_id, COUNT(*) AS total_prestamos FROM Prestamos GROUP BY libro_id ORDER BY total_prestamos DESC;

-- d. Listar todos los autores y los títulos de sus libros disponibles en la biblioteca.
SELECT a.nombre, l.titulo FROM Autores a INNER JOIN Libros l ON a.autor_id = l.autor_id;

-- e. ¿Cuántos usuarios están registrados en cada tipo de membresía?
SELECT membresia, COUNT(*) AS total_usuarios FROM Usuarios GROUP BY membresia;

-- 5. Actualización y Manipulación de Datos

-- a. Actualizar los géneros de los libros de un autor específico
UPDATE Libros SET genero = 'Novela clásica' WHERE autor_id = 4;

-- b. Eliminar un usuario que se ha dado de baja
DELETE FROM Prestamos WHERE usuario_id = 3;
DELETE FROM Usuarios WHERE usuario_id = 3;

-- c. Modificar la fecha de devolución de un préstamo para un usuario específico
UPDATE Prestamos SET fecha_devolucion = '2024-03-20' WHERE usuario_id = 1 AND libro_id = 1;
