-- Creación de la base de datos
CREATE DATABASE mister_pizza;

-- Conectarse a la base de datos (si usas consola)
\c mister_pizza;

-- Tabla de Usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dni VARCHAR(8),
    password VARCHAR(100),
    rol VARCHAR(20) DEFAULT 'cliente'
);

-- Tabla de Pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    total DECIMAL(10,2),
    direccion VARCHAR(200),
    estado VARCHAR(20) DEFAULT 'Pendiente',
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2),
    descripcion TEXT
);

-- Tabla de Detalle de Pedidos
CREATE TABLE detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id),
    producto_nombre VARCHAR(100),
    precio DECIMAL(10,2),
    cantidad INT
);
