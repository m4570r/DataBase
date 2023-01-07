CREATE DATABASE ventas;

USE ventas;

CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
	card_code VARCHAR(255) NOT NULL,
	card_name VARCHAR(255) NOT NULL,
	card_type VARCHAR(255) NOT NULL,
	group_code INT NOT NULL,
	address VARCHAR(255) NOT NULL,
	zip_code VARCHAR(255) NOT NULL,
	phone1 VARCHAR(255) NOT NULL,
	phone2 VARCHAR(255) NOT NULL,
	notes VARCHAR(255) NOT NULL,
	federal_tax_id VARCHAR(255) NOT NULL,
	currency VARCHAR(255) NOT NULL,
	city VARCHAR(255) NOT NULL,
	country VARCHAR(255) NOT NULL,
	email_address VARCHAR(255) NOT NULL,
	picture VARCHAR(255) NOT NULL,
	default_account VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
	frozen BOOLEAN NOT NULL DEFAULT FALSE,
	create_date DATE NOT NULL,
	create_time TIME NOT NULL,
	update_date DATE NOT NULL,
	update_time TIME NOT NULL
);

INSERT INTO clientes (card_code, card_name,	card_type, group_code, address,	zip_code, phone1, phone2, notes, federal_tax_id, currency, city, country, email_address, picture, default_account, password, create_date, create_time, update_date, update_time) VALUES ('17127987', 'Miguel A. Gonzalez', 'C', 1, 'Pob. Ramon Sanfurgo, pje. Luis Valdes #153', '3130000', '569-7764-2706', '569-2226-5898', '', '17127987-9','CLP', 'Santa Cruz', 'CHILE', 'miguel.php@gmail.com', '', "1", 'm4573r0fd00m', '2022-01-01', '12:00:00', '2022-01-01', '12:00:00');

UPDATE clientes
SET frozen = 1
WHERE id_cliente = 2;

DELETE FROM clientes
WHERE id_cliente = 1;

CREATE TABLE productos (
  id_producto INT PRIMARY KEY AUTO_INCREMENT,
  order_item_id VARCHAR(255) NOT NULL,
  shop_id VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  sku VARCHAR(255) NOT NULL,
  shop_sku VARCHAR(255) NOT NULL,
  item_price DECIMAL(10, 2) NOT NULL,
  is_digital BOOLEAN NOT NULL DEFAULT FALSE,
  detail VARCHAR(255) NOT NULL,
  package_id VARCHAR(255) NOT NULL,
  promised_shipping_time VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);

 SELECT productos.name
       FROM productos
       INNER JOIN productos_promocion
       ON productos.id_producto = productos_promocion.id_producto
       WHERE productos_promocion.id_promocion = 1;

INSERT INTO productos (order_item_id, shop_id, name, description, sku, shop_sku, item_price, is_digital, detail, package_id, promised_shipping_time, created_at, updated_at)
       VALUES ('123456', 'shop1', 'Product 1', 'Description of product 1', 'sku123', 'shopsku123', 10.99, 0, '', 'package1', '1 day', '2022-01-01 12:00:00', '2022-01-01 12:00:00');

-- Update the price of the product with id_producto of 1
UPDATE productos
       SET item_price = 12.99
       WHERE id_producto = 1;

-- Delete the product with id_producto of 1
DELETE FROM productos
       WHERE id_producto = 1;
	   
	   

CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL
);

INSERT INTO categorias (nombre) VALUES ('Jugos');
INSERT INTO categorias (nombre) VALUES ('Bebidas');
INSERT INTO categorias (nombre) VALUES ('Arroz');
INSERT INTO categorias (nombre) VALUES ('Audifonos');
INSERT INTO categorias (nombre) VALUES ('Sal');

CREATE TABLE productos_categoria (
  id_producto INT NOT NULL,
  id_categoria INT NOT NULL,
  PRIMARY KEY (id_producto, id_categoria),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

SELECT productos.name, productos.shop_id, productos.description, productos.sku, productos.item_price, productos.promised_shipping_time, productos.created_at, productos.updated_at FROM productos INNER JOIN productos_categoria ON productos.id_producto = productos_categoria.id_producto WHERE productos_categoria.id_categoria = 2;

CREATE TABLE promociones (
  id_promocion INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  porcentaje_descuento DECIMAL(5, 2) NOT NULL,
  vigencia_desde DATE NOT NULL,
  vigencia_hasta DATE NOT NULL
);

INSERT INTO promociones (nombre, porcentaje_descuento, vigencia_desde, vigencia_hasta)
       VALUES ('Promotion 1', 0.10, '2022-01-01', '2022-01-31');
	  

CREATE TABLE productos_promocion (
  id_producto INT NOT NULL,
  id_promocion INT NOT NULL,
  PRIMARY KEY (id_producto, id_promocion),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
  FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion)
);

INSERT INTO productos_promocion (id_producto, id_promocion) VALUES (2, 1);



CREATE TABLE ordenes (
  id_orden INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  fecha DATE NOT NULL,
  metodo_pago VARCHAR(255) NOT NULL,
  estado VARCHAR(255) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE detalles_orden (
  id_detalle INT PRIMARY KEY AUTO_INCREMENT,
  id_orden INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL,
  precio DECIMAL(10, 2) NOT NULL,
  descuento DECIMAL(5, 2) NOT NULL,
  FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE envios (
  id_envio INT PRIMARY KEY AUTO_INCREMENT,
  id_orden INT NOT NULL,
  direccion VARCHAR(255) NOT NULL,
  metodo VARCHAR(255) NOT NULL,
  costo DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (id_orden) REFERENCES ordenes(id_orden)
);

CREATE TABLE stock (
  id_stock INT PRIMARY KEY AUTO_INCREMENT,
  id_producto INT NOT NULL,
  cantidad INT NOT NULL,
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

SELECT productos.name, stock.quantity
       FROM productos
       INNER JOIN stock
       ON productos.id_producto = stock.id_producto;
	   
INSERT INTO stock (id_producto, quantity) VALUES (2, 5), (3, 7), (4, 12);

CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(255),
  password VARCHAR(255),
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  phone1 VARCHAR(255) NOT NULL,
  notes VARCHAR(255) NOT NULL,
  federal_tax_id VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  email_address VARCHAR(255) NOT NULL,
  picture VARCHAR(255) NOT NULL,
  create_date DATE NOT NULL,
  create_time TIME NOT NULL,
  update_date DATE NOT NULL,
  update_time TIME NOT NULL,
  role ENUM('support', 'admin', 'sales')
);

INSERT INTO usuarios (username, password, role)
VALUES ('user1', 'password1', 'support'),
       ('user2', 'password2', 'admin'),
       ('user3', 'password3', 'sales');