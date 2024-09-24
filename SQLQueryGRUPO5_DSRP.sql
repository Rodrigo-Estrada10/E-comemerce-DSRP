CREATE DATABASE E_commerce
GO

USE E_commerce
GO

CREATE TABLE usuarios
	
	(
		id						INT PRIMARY KEY,
		nombre_usuario			VARCHAR(255) UNIQUE NOT NULL,
		email					VARCHAR(255) UNIQUE NOT NULL,
		password_user			VARCHAR(255) NOT NULL,
		nombres					VARCHAR(255) NOT NULL,
		apellido_paterno		VARCHAR(255) NOT NULL,
		apellido_materno		VARCHAR(255) NOT NULL,
		direccion				NVARCHAR(1000) NOT NULL,
		telefono				VARCHAR(20) NOT NULL,
		fecha_registro			DATETIME DEFAULT GETDATE() NOT NULL	
	)
GO

--ALTER TABLE 


CREATE TABLE categorias

	(
		id					INT PRIMARY KEY,
		nombre_categoria	VARCHAR(255) UNIQUE NOT NULL,
		descripcion			NVARCHAR(500) NULL
	)
GO

CREATE TABLE productos

	(
		id					INT PRIMARY KEY,
		categoria_id		INT NOT NULL,
		nombre_producto		VARCHAR(255) NOT NULL,
		descripcion			NVARCHAR(1000) NOT NULL,
		precio				DECIMAL(10, 2) NOT NULL,
		stock				INT NOT NULL,
		fecha_agregado		DATETIME DEFAULT GETDATE() NOT NULL,

	CONSTRAINT FK_categoria_producto FOREIGN KEY (categoria_id) REFERENCES categorias (id)
	)
GO

CREATE TABLE carrito

	(
		id					INT PRIMARY KEY,
		usuario_id			INT NOT NULL,
		fecha_creacion		DATETIME DEFAULT GETDATE() NOT NULL,

	CONSTRAINT FK_usuario_carrito FOREIGN KEY (usuario_id) REFERENCES usuarios (id)
	)
GO

CREATE TABLE carrito_productos
	
	(
		id					INT PRIMARY KEY,
		carrito_id			INT NOT NULL,
		producto_id			INT NOT NULL,
		cantidad			INT NOT NULL,
	
	CONSTRAINT FK_carrito_carrito_productos		FOREIGN KEY (carrito_id)	REFERENCES carrito (id),
	CONSTRAINT FK_producto_carrito_productos	FOREIGN KEY (producto_id)	REFERENCES productos (id)
	)
GO


CREATE TABLE pedidos

	(
		id					INT PRIMARY KEY,
		usuario_id			INT NOT NULL,
		monto_total_pedido	DECIMAL(10, 2) NOT NULL,
		estado				VARCHAR(50) NOT NULL,
		fecha_orden			DATETIME DEFAULT GETDATE() NOT NULL,
		direccion_envio		NVARCHAR(1000) NOT NULL,

	CONSTRAINT FK_usuario_pedidos FOREIGN KEY (usuario_id) REFERENCES usuarios (id)	
	)
GO

CREATE TABLE detalle_pedidos

	(
		id					INT PRIMARY KEY,
		pedido_id			INT NOT NULL,
		producto_id			INT NOT NULL,
		cantidad			INT NOT NULL,
		precio_unitario		DECIMAL(10, 2) NOT NULL,

	CONSTRAINT FK_pedido_detalle_pedidos FOREIGN KEY (pedido_id) REFERENCES pedidos (id),
	CONSTRAINT FK_producto_detalle_pedido FOREIGN KEY (producto_id) REFERENCES productos (id)
	)
GO

CREATE TABLE metodos_pago

	(
		id					INT PRIMARY KEY,
		nombre				VARCHAR(255) UNIQUE NOT NULL,
		descripcion			NVARCHAR(500) NOT NULL	
	)
GO


CREATE TABLE pagos
	
	(
		id					INT PRIMARY KEY,
		pedido_id			INT NOT NULL,
		metodo_pago_id		INT NOT NULL,
		monto				DECIMAL(10, 2) NOT NULL,
		fecha_pago			DATETIME DEFAULT GETDATE() NOT NULL,
		estado				VARCHAR(50) NOT NULL,

	CONSTRAINT FK_pedido_pago FOREIGN KEY (pedido_id)		REFERENCES pedidos (id),
	CONSTRAINT FK_metodo_pago FOREIGN KEY (metodo_pago_id)	REFERENCES metodos_pago (id)	
	)
GO


CREATE TABLE envios
	
	(
		id					INT PRIMARY KEY,
		pedido_id			INT NOT NULL,
		fecha_envio			DATETIME DEFAULT GETDATE(),
		fecha_entrega		DATETIME,
		estado_envio		VARCHAR(50) NOT NULL,

	CONSTRAINT FK_pedido_envio FOREIGN KEY (pedido_id) REFERENCES pedidos (id)
	)
GO

--INSERTAR DATOS

--usuarios

INSERT INTO usuarios (id, nombre_usuario, email, password_user, nombres, apellido_paterno, apellido_materno, direccion, telefono, fecha_registro)
VALUES 
(101, 'jrodriguez', 'jrodriguez@mail.com', 'pass1234', 'Juan', 'Rodriguez', 'Lopez', 'Av. Larco 123, Miraflores, Lima', '987654321', '2024-07-05'),
(105, 'mhernandez', 'mhernandez@mail.com', 'pass5678', 'Maria', 'Hernandez', 'Gonzalez', 'Jr. Puno 456, San Isidro, Lima', '987654322', '2024-07-12'),
(112, 'aperez', 'aperez@mail.com', 'pass8765', 'Ana', 'Perez', 'Martinez', 'Calle Cusco 789, Barranco, Lima', '987654323', '2024-07-25'),
(118, 'cfernandez', 'cfernandez@mail.com', 'pass2345', 'Carlos', 'Fernandez', 'Morales', 'Av. Grau 321, Miraflores, Lima', '987654324', '2024-08-02'),
(123, 'fgarcia', 'fgarcia@mail.com', 'pass4321', 'Francisco', 'Garcia', 'Santos', 'Calle Arequipa 654, San Isidro, Lima', '987654325', '2024-08-10'),
(130, 'lgutierrez', 'lgutierrez@mail.com', 'pass3456', 'Luis', 'Gutierrez', 'Vargas', 'Av. Bolívar 987, Miraflores, Lima', '987654326', '2024-08-20'),
(135, 'mpalacios', 'mpalacios@mail.com', 'pass5432', 'Maria', 'Palacios', 'Ruiz', 'Jr. Tacna 258, La Victoria, Lima', '987654327', '2024-08-30'),
(142, 'nrojas', 'nrojas@mail.com', 'pass6789', 'Natalia', 'Rojas', 'Paredes', 'Calle San Martín 159, Jesús María, Lima', '987654328', '2024-09-05'),
(150, 'ojimenez', 'ojimenez@mail.com', 'pass7890', 'Oscar', 'Jimenez', 'Cano', 'Av. Javier Prado 753, Surco, Lima', '987654329', '2024-09-10'),
(160, 'mcastro', 'mcastro@mail.com', 'pass8901', 'Miguel', 'Castro', 'Castro', 'Calle Libertad 963, San Borja, Lima', '987654330', '2024-09-15');


SELECT * FROM usuarios

-- categorias
INSERT INTO categorias (id, nombre_categoria, descripcion)
VALUES 
(12258, 'Electrodomésticos', 'Aparatos eléctricos para el hogar como refrigeradoras, lavadoras, microondas, etc.'),
(12259, 'Celulares', 'Teléfonos móviles de diversas marcas y modelos.'),
(12260, 'Laptops', 'Portátiles de diferentes marcas para uso personal o profesional.'),
(12261, 'Televisores', 'Televisores de distintas pulgadas y tecnologías como LED, OLED, Smart TV.'),
(12262, 'Tablets', 'Dispositivos móviles con pantalla táctil para entretenimiento y trabajo.'),
(12263, 'Aires Acondicionados', 'Equipos para la climatización de espacios, portátiles o fijos.'),
(12264, 'Cámaras Fotográficas', 'Cámaras digitales y profesionales de diferentes marcas.'),
(12265, 'Consolas de Videojuegos', 'Equipos de entretenimiento como PlayStation, Xbox, Nintendo.'),
(12266, 'Electrónica de Audio', 'Audífonos, parlantes, y sistemas de sonido.'),
(12267, 'Impresoras', 'Impresoras multifuncionales y de oficina.');

SELECT * FROM categorias

-- productos

INSERT INTO productos (id, categoria_id, nombre_producto, descripcion, precio, stock)
VALUES 
(1001, 12258, 'Refrigeradora LG 300L', 'Refrigeradora de 300 litros con tecnología inverter, eficiencia energética A++.', 1200.00, 10),
(1002, 12258, 'Lavadora Samsung 8kg', 'Lavadora automática de carga frontal de 8 kg, con función de vapor.', 900.00, 15),
(1003, 12259, 'iPhone 13', 'Teléfono móvil con pantalla de 6.1 pulgadas y 128 GB de almacenamiento.', 800.00, 20),
(1004, 12259, 'Samsung Galaxy A32', 'Teléfono móvil con pantalla de 6.4 pulgadas y 64 GB de almacenamiento.', 250.00, 30),
(1005, 12260, 'Dell XPS 13', 'Laptop de 13.3 pulgadas con procesador i7 y 16 GB de RAM.', 1500.00, 5),
(1006, 12260, 'HP Pavilion 15', 'Laptop de 15.6 pulgadas con procesador AMD Ryzen 5 y 8 GB de RAM.', 700.00, 8),
(1007, 12261, 'Televisor Samsung 55" 4K', 'Televisor LED de 55 pulgadas con resolución 4K y Smart TV.', 600.00, 12),
(1008, 12262, 'iPad 10.2"', 'Tablet de 10.2 pulgadas con 64 GB de almacenamiento y Apple Pencil.', 350.00, 25),
(1009, 12263, 'Aire Acondicionado LG 12000 BTU', 'Aire acondicionado portátil de 12,000 BTU, eficiencia energética A.', 800.00, 6),
(1010, 12264, 'Cámara Canon EOS M50', 'Cámara digital con lente intercambiable y 24 MP, ideal para vloggers.', 700.00, 10);

SELECT * FROM productos


-- carrito
INSERT INTO carrito (id, usuario_id, fecha_creacion)
VALUES 
(201, 101, '2024-07-06'),
(202, 105, '2024-07-13'),
(203, 112, '2024-07-26'),
(204, 118, '2024-08-03'),
(205, 123, '2024-08-11'),
(206, 130, '2024-08-21'),
(207, 135, '2024-09-01'),
(208, 142, '2024-09-06'),
(209, 150, '2024-09-11'),
(210, 160, '2024-09-16');

select * from carrito

-- carrito_productos
INSERT INTO carrito_productos (id, carrito_id, producto_id, cantidad)
VALUES 
(301, 201, 1001, 1),  -- Refrigeradora LG 300L
(302, 202, 1003, 2),  -- iPhone 13
(303, 203, 1005, 1),  -- Dell XPS 13
(304, 204, 1007, 3),  -- Televisor Samsung 55" 4K
(305, 205, 1002, 1),  -- Lavadora Samsung 8kg
(306, 206, 1008, 2),  -- iPad 10.2"
(307, 207, 1009, 1),  -- Aire Acondicionado LG 12000 BTU
(308, 208, 1010, 1),  -- Cámara Canon EOS M50
(309, 209, 1004, 1),  -- Samsung Galaxy A32
(310, 210, 1006, 2),  -- HP Pavilion 15
(311, 201, 1002, 1),  -- Lavadora Samsung 8kg
(312, 202, 1001, 1),  -- Refrigeradora LG 300L
(313, 203, 1004, 1),  -- Samsung Galaxy A32
(314, 204, 1009, 2),  -- Aire Acondicionado LG 12000 BTU
(315, 205, 1008, 1);  -- iPad 10.2"

SELECT * FROM carrito_productos

-- pedidos
INSERT INTO pedidos (id, usuario_id, monto_total_pedido, estado, fecha_orden, direccion_envio)
VALUES
(501, 101, 2400.00, 'En proceso', '2024-07-06', 'Av. Larco 123, Miraflores, Lima'),
(502, 105, 1600.00, 'En proceso', '2024-07-13', 'Jr. Puno 456, San Isidro, Lima'),
(503, 112, 1200.00, 'Completado', '2024-07-27', 'Calle Cusco 789, Barranco, Lima'),
(504, 118, 1800.00, 'Completado', '2024-08-03', 'Av. Grau 321, Miraflores, Lima'),
(505, 123, 900.00, 'Pendiente', '2024-08-11', 'Calle Arequipa 654, San Isidro, Lima'),
(506, 130, 1600.00, 'Pendiente', '2024-08-21', 'Av. Bolívar 987, Miraflores, Lima'),
(507, 135, 2200.00, 'En proceso', '2024-09-01', 'Jr. Tacna 258, La Victoria, Lima'),
(508, 142, 700.00, 'Completado', '2024-09-06', 'Calle San Martín 159, Jesús María, Lima'),
(509, 150, 800.00, 'Pendiente', '2024-09-11', 'Av. Javier Prado 753, Surco, Lima'),
(510, 160, 1500.00, 'En proceso', '2024-09-16', 'Calle Libertad 963, San Borja, Lima');

SELECT * FROM pedidos;

-- detalle_pedidos
INSERT INTO detalle_pedidos (id, pedido_id, producto_id, cantidad, precio_unitario)
VALUES
(601, 501, 1001, 1, 1200.00),  -- Pedido de Juan Rodriguez
(602, 501, 1002, 1, 1200.00),  -- Pedido de Juan Rodriguez
(603, 502, 1003, 2, 800.00),   -- Pedido de Maria Hernandez
(604, 503, 1005, 1, 1500.00),  -- Pedido de Ana Perez
(605, 504, 1007, 3, 600.00),   -- Pedido de Carlos Fernandez
(606, 505, 1002, 1, 900.00),   -- Pedido de Francisco Garcia
(607, 506, 1006, 2, 700.00),   -- Pedido de Luis Gutierrez
(608, 507, 1009, 1, 800.00),   -- Pedido de Maria Palacios
(609, 508, 1010, 1, 700.00),   -- Pedido de Natalia Rojas
(610, 509, 1004, 2, 250.00);   -- Pedido de Oscar Jimenez

SELECT * FROM detalle_pedidos;

-- metodos_pago
INSERT INTO metodos_pago (id, nombre, descripcion)
VALUES
(701, 'Tarjeta de crédito', 'Pago con tarjeta de crédito Visa, MasterCard.'),
(702, 'PayPal', 'Pago a través de cuenta PayPal.'),
(703, 'Transferencia bancaria', 'Pago mediante transferencia a cuenta bancaria.'),
(704, 'Pago contra entrega', 'Pago en efectivo al momento de la entrega del producto.'),
(705, 'Crédito tienda', 'Pago con crédito otorgado por la tienda.'),
(706, 'Apple Pay', 'Pago rápido con Apple Pay.'),
(707, 'Google Pay', 'Pago rápido con Google Pay.'),
(708, 'Western Union', 'Pago mediante Western Union.'),
(709, 'Bitcoin', 'Pago con criptomonedas.'),
(710, 'Cheque', 'Pago mediante cheque.');

SELECT * FROM metodos_pago;

-- pagos
INSERT INTO pagos (id, pedido_id, metodo_pago_id, monto, fecha_pago, estado)
VALUES
(801, 501, 701, 2400.00, '2024-07-06', 'Completado'),
(802, 502, 702, 1600.00, '2024-07-13', 'Completado'),
(803, 503, 703, 1200.00, '2024-07-27', 'Completado'),
(804, 504, 704, 1800.00, '2024-08-03', 'Pendiente'),
(805, 505, 701, 900.00, '2024-08-11', 'Pendiente'),
(806, 506, 705, 1600.00, '2024-08-21', 'Completado'),
(807, 507, 706, 2200.00, '2024-09-01', 'Completado'),
(808, 508, 707, 700.00, '2024-09-06', 'Completado'),
(809, 509, 708, 800.00, '2024-09-11', 'Pendiente'),
(810, 510, 709, 1500.00, '2024-09-16', 'Completado');

SELECT * FROM pagos;

-- envios
INSERT INTO envios (id, pedido_id, fecha_envio, fecha_entrega, estado_envio)
VALUES
(901, 501, '2024-07-07', '2024-07-10', 'Entregado'),
(902, 502, '2024-07-14', '2024-07-17', 'Entregado'),
(903, 503, '2024-07-28', '2024-07-31', 'Entregado'),
(904, 504, '2024-08-04', '2024-08-07', 'En tránsito'),
(905, 505, NULL, NULL, 'Pendiente'),
(906, 506, '2024-08-22', '2024-08-25', 'Entregado'),
(907, 507, '2024-09-02', '2024-09-05', 'Entregado'),
(908, 508, '2024-09-07', '2024-09-10', 'Entregado'),
(909, 509, '2024-09-12', '2024-09-15', 'En tránsito'),
(910, 510, '2024-09-17', '2024-09-20', 'Pendiente');

SELECT * FROM envios;










