-- Crea la base de datos "sistema"
CREATE DATABASE sistema;

-- Selecciona la base de datos "sistema"
USE sistema;

-- Crea la tabla "usuarios" con los campos id (autoincrementable y clave), nombre y edad
CREATE TABLE usuarios (
  id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(255) NOT NULL,
  edad INT(100) NOT NULL
);
