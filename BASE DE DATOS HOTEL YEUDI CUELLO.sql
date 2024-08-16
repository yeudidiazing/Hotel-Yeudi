CREATE DATABASE HotelYeudiCuello;

USE HotelYeudiCuello;

CREATE TABLE Habitaciones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    numero_habitacion INT NOT NULL,
    piso INT NOT NULL,
    precio DECIMAL(6,2) CHECK (precio BETWEEN 1000 AND 2000),
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('vacía', 'ocupada', 'reservada')),
    nombre_cliente VARCHAR(100),
    CONSTRAINT UQ_NumeroHabitacion UNIQUE (numero_habitacion)
);

CREATE TABLE Clientes (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE,
    monto_pagado DECIMAL(8,2),
    numero_habitacion INT,
    CONSTRAINT UQ_NombreCliente UNIQUE (nombre),
    FOREIGN KEY (numero_habitacion) REFERENCES Habitaciones(numero_habitacion)
);

CREATE TABLE Reservas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    monto DECIMAL(8,2) NOT NULL,
    numero_habitacion INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (nombre_cliente) REFERENCES Clientes(nombre),
    FOREIGN KEY (numero_habitacion) REFERENCES Habitaciones(numero_habitacion)
);

CREATE TABLE Pagos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    numero_habitacion INT NOT NULL,
    monto DECIMAL(8,2) NOT NULL,
    fecha_pago DATE NOT NULL,
    FOREIGN KEY (nombre_cliente) REFERENCES Clientes(nombre),
    FOREIGN KEY (numero_habitacion) REFERENCES Habitaciones(numero_habitacion)
);

CREATE TABLE ServiciosAdicionales (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    costo DECIMAL(8,2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (nombre_cliente) REFERENCES Clientes(nombre)
);

INSERT INTO Habitaciones (numero_habitacion, piso, precio, estado, nombre_cliente)
VALUES 
(101, 1, 1500, 'vacía', NULL),
(102, 1, 1800, 'reservada', 'Juan Perez'),
(103, 1, 1700, 'ocupada', 'Carlos Lopez'),
(104, 1, 1600, 'vacía', NULL),
(105, 1, 2000, 'reservada', 'Ana Martinez'),
(201, 2, 1400, 'vacía', NULL),
(202, 2, 1200, 'ocupada', 'Luis Rodriguez'),
(203, 2, 1300, 'reservada', 'Sofia Hernandez'),
(204, 2, 1500, 'vacía', NULL),
(205, 2, 1600, 'ocupada', 'Jose Ramirez'),
(301, 3, 1800, 'vacía', NULL),
(302, 3, 1900, 'reservada', 'Maria Garcia'),
(303, 3, 1100, 'vacía', NULL),
(304, 3, 1000, 'vacía', NULL);

INSERT INTO Clientes (nombre, fecha_inicio, fecha_fin, monto_pagado, numero_habitacion)
VALUES 
('Juan Perez', '2024-07-01', '2024-07-05', 7500, 102),
('Maria Garcia', '2024-07-10', '2024-07-15', 9000, 302),
('Carlos Lopez', '2024-07-20', '2024-07-25', 8000, 103),
('Ana Martinez', '2024-07-15', '2024-07-18', 5000, 105),
('Luis Rodriguez', '2024-07-05', '2024-07-10', 6000, 202),
('Sofia Hernandez', '2024-07-12', '2024-07-14', 4000, 203),
('Jose Ramirez', '2024-07-08', '2024-07-12', 7200, 205);

INSERT INTO Reservas (nombre_cliente, monto, numero_habitacion, fecha_inicio, fecha_fin)
VALUES 
('Carlos Lopez', 8000, 103, '2024-07-20', '2024-07-25'),
('Ana Martinez', 5000, 105, '2024-07-15', '2024-07-18'),
('Luis Rodriguez', 6000, 202, '2024-07-05', '2024-07-10'),
('Sofia Hernandez', 4000, 203, '2024-07-12', '2024-07-14'),
('Jose Ramirez', 7200, 205, '2024-07-08', '2024-07-12');

INSERT INTO Pagos (nombre_cliente, numero_habitacion, monto, fecha_pago)
VALUES 
('Juan Perez', 102, 7500, '2024-07-01'),
('Maria Garcia', 302, 9000, '2024-07-10'),
('Carlos Lopez', 103, 8000, '2024-07-20'),
('Ana Martinez', 105, 5000, '2024-07-15'),
('Luis Rodriguez', 202, 6000, '2024-07-05'),
('Sofia Hernandez', 203, 4000, '2024-07-12'),
('Jose Ramirez', 205, 7200, '2024-07-08');

INSERT INTO ServiciosAdicionales (nombre_cliente, descripcion, costo, fecha)
VALUES 
('Juan Perez', 'Servicio de lavandería', 500, '2024-07-02'),
('Maria Garcia', 'Desayuno en la habitación', 300, '2024-07-11'),
('Carlos Lopez', 'Servicio de spa', 1000, '2024-07-21'),
('Ana Martinez', 'Transporte al aeropuerto', 700, '2024-07-16'),
('Luis Rodriguez', 'Alquiler de coche', 1500, '2024-07-06'),
('Sofia Hernandez', 'Visita guiada', 800, '2024-07-13'),
('Jose Ramirez', 'Servicio de lavandería', 500, '2024-07-09');

SELECT * FROM Habitaciones;

SELECT * FROM Clientes;

SELECT * FROM Reservas;

SELECT * FROM Pagos;

SELECT * FROM ServiciosAdicionales;

SELECT * FROM Habitaciones WHERE estado = 'ocupada';

-- Obtener todas las reservas de un cliente específico
SELECT * FROM Reservas WHERE nombre_cliente = 'Carlos Lopez';

-- Obtener todos los pagos realizados por un cliente específico
SELECT * FROM Pagos WHERE nombre_cliente = 'Ana Martinez';

-- Obtener todos los servicios adicionales solicitados por un cliente específico
SELECT * FROM ServiciosAdicionales WHERE nombre_cliente = 'Juan Perez';

-- Relacionar reservas con habitaciones y clientes
SELECT r.id, r.nombre_cliente, r.numero_habitacion, h.piso, r.monto, r.fecha_inicio, r.fecha_fin
FROM Reservas r
INNER JOIN Habitaciones h ON r.numero_habitacion = h.numero_habitacion
INNER JOIN Clientes c ON r.nombre_cliente = c.nombre;

-- Relacionar pagos con habitaciones y clientes
SELECT p.id, p.nombre_cliente, p.numero_habitacion, h.piso, p.monto, p.fecha_pago
FROM Pagos p
INNER JOIN Habitaciones h ON p.numero_habitacion = h.numero_habitacion
INNER JOIN Clientes c ON p.nombre_cliente = c.nombre;

-- Relacionar servicios adicionales con clientes
SELECT s.id, s.nombre_cliente, s.descripcion, s.costo, s.fecha
FROM ServiciosAdicionales s
INNER JOIN Clientes c ON s.nombre_cliente = c.nombre;


