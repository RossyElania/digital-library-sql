-- Creación de la Base de Datos y Tablas
CREATE DATABASE comercio;
USE comercio;

CREATE TABLE clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    correo VARCHAR(50),
    telefono VARCHAR(15)
);

CREATE TABLE ventas (
    id INT PRIMARY KEY,
    cliente_id INT,
    producto VARCHAR(50),
    monto DECIMAL(10, 2),
    fecha DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);


-- Datos de Ejemplo
INSERT INTO clientes VALUES (1, 'Juan Perez', 'juan@example.com', '8091234567');
INSERT INTO clientes VALUES (2, 'Maria Gomez', 'maria@example.com', '8299876543');

INSERT INTO ventas VALUES (1, 1, 'Laptop', 1200.50, '2024-01-01');
INSERT INTO ventas VALUES (2, 2, 'Celular', 850.00, '2024-02-15');

-- Crear Usuarios y Asignar Permisos
--- Administrador (Acceso completo)
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON comercio.* TO 'admin'@'localhost' WITH GRANT OPTION;

--- Analista de Datos (Solo lectura en clientes y ventas)
CREATE USER 'analista'@'localhost' IDENTIFIED BY 'analista123';
GRANT SELECT ON comercio.clientes TO 'analista'@'localhost';
GRANT SELECT ON comercio.ventas TO 'analista'@'localhost';

--- Equipo de Ventas (Solo inserción en ventas)
CREATE USER 'ventas'@'localhost' IDENTIFIED BY 'ventas123';
GRANT INSERT ON comercio.ventas TO 'ventas'@'localhost';

--- Revocar Permisos
REVOKE INSERT ON comercio.ventas FROM 'ventas'@'localhost';

--- Verificar Permisos
SHOW GRANTS FOR 'analista'@'localhost';
SHOW GRANTS FOR 'ventas'@'localhost';
SHOW GRANTS FOR 'admin'@'localhost';

--- Prueba de Operaciones no Autorizadas
INSERT INTO ventas VALUES (3, 1, 'Tablet', 500.00, '2024-03-10');

--- ERROR 1142 (42000): 
INSERT command denied to user 'analista'@'localhost' for table 'ventas'


---  Nuevo Usuario "Gestor" con Permisos de Consulta y Actualización en Clientes
CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor123';
GRANT SELECT, UPDATE ON comercio.clientes TO 'gestor'@'localhost';
