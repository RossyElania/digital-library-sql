-- Creacion de base de dato:
CREATE DATABASE Prueba_Final;

-- Uso de base de dato:
USE Prueba_Final;


-- 1. CREACIÓN DEL ESQUEMA (DDL) --

-- Crear tabla de Categorías
IF OBJECT_ID('Categorias') IS NOT NULL DROP TABLE Categorias;
CREATE TABLE Categorias (
    id_categoria INT IDENTITY(1,1) PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL
);

-- Crear tabla de Productos
IF OBJECT_ID('Productos') IS NOT NULL DROP TABLE Productos;
CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    id_categoria INT,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2),
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria)
);

-- Crear tabla de Movimientos de Inventario
IF OBJECT_ID('Movimientos') IS NOT NULL DROP TABLE Movimientos;
CREATE TABLE Movimientos (
    id_movimiento INT IDENTITY(1,1) PRIMARY KEY,
    id_producto INT,
    tipo_movimiento VARCHAR(10) CHECK (tipo_movimiento IN ('entrada', 'salida')) NOT NULL,
    cantidad_movida INT NOT NULL,
    fecha_movimiento DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- 2. MANIPULACIÓN DE DATOS (DML) --

-- Insertar categorías
INSERT INTO Categorias (nombre_categoria) VALUES ('Electrónica');
INSERT INTO Categorias (nombre_categoria) VALUES ('Hogar');
INSERT INTO Categorias (nombre_categoria) VALUES ('Alimentos');

-- Insertar productos
INSERT INTO Productos (nombre_producto, id_categoria, cantidad, precio)
VALUES 
('Audífonos Bluetooth', 1, 50, 1499.99),
('Licuadora', 2, 25, 3200.00),
('Arroz 10lb', 3, 8, 550.00),
('Cafetera', 2, 12, 2750.00);

-- Insertar movimientos de inventario
INSERT INTO Movimientos (id_producto, tipo_movimiento, cantidad_movida)
VALUES 
(1, 'entrada', 50),
(2, 'entrada', 25),
(3, 'entrada', 8),
(4, 'entrada', 12),
(3, 'salida', 2);

-- 2.1 CONSULTAS SQL --

-- Mostrar todos los productos con su categoría
SELECT p.nombre_producto, c.nombre_categoria, p.cantidad
FROM Productos p
JOIN Categorias c ON p.id_categoria = c.id_categoria;

-- Mostrar productos con menos de 10 unidades, ordenados por cantidad ascendente
SELECT nombre_producto, cantidad 
FROM Productos 
WHERE cantidad < 10 
ORDER BY cantidad ASC;

-- 2.2 ACTUALIZAR Y ELIMINAR --

-- Actualizar la cantidad de un producto (por ejemplo, id = 3)
UPDATE Productos 
SET cantidad = 10 
WHERE id_producto = 3;

-- Eliminar un producto (por ejemplo, id = 2)
DELETE FROM Productos 
WHERE id_producto = 2;

-- 3. CONTROL DE ACCESO (DCL) --

-- Crear login y usuario
CREATE LOGIN gerente_inventario WITH PASSWORD = 'Password123';
CREATE USER gerente_inventario FOR LOGIN gerente_inventario;

-- Otorgar permisos de SELECT e INSERT
GRANT SELECT, INSERT ON Categorias TO gerente_inventario;
GRANT SELECT, INSERT ON Productos TO gerente_inventario;
GRANT SELECT, INSERT ON Movimientos TO gerente_inventario;

-- Revocar permisos en la tabla Movimientos
REVOKE SELECT, INSERT ON Movimientos FROM gerente_inventario;
