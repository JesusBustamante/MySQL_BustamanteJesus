CREATE DATABASE Libreria;

USE Libreria;

CREATE TABLE Libros (
    id_libro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ISBN INT UNIQUE NOT NULL,
    Titulo VARCHAR(45) NOT NULL,
    Editorial VARCHAR(45) NOT NULL,
    Fecha_publicacion DATE NOT NULL,
    Precio DECIMAL (10, 2) NOT NULL,
    Stock INT NOT NULL,
    fk_id_categoria INT NOT NULL,
    fk_id_autor INT NOT NULL,
    FOREIGN KEY (fk_id_categoria) REFERENCES Categorias (id_categoria),
    FOREIGN KEY (fk_id_autor) REFERENCES Autores (id_autor)
);
    
CREATE TABLE Categorias (
    id_categoria INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(45) NOT NULL
);

CREATE TABLE Autores (
    id_autor INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(45) NOT NULL,
    Nacionalidad VARCHAR(45) NOT NULL,
    Fecha_nacimiento DATE NOT NULL,
);

CREATE TABLE Clientes (
    id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(45) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    Telefono INT NOT NULL,
    Direccion VARCHAR(45) NOT NULL
);

CREATE TABLE Pedidos (
    id_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Cantidad_libros INT NOT NULL,
    Fecha_compra DATE NOT NULL,
    Estado VARCHAR(45) NOT NULL,
    fk_id_clientes INT NOT NULL,
    FOREIGN KEY(fk_id_clientes) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Transacciones (
	fk_id_libro INT NOT NULL,
    fk_id_pedido INT NOT NULL,
	PRIMARY KEY (fk_id_libro, fk_id_pedido),
    FOREIGN KEY (fk_id_libro) REFERENCES Libros(id_libro),
    FOREIGN KEY (fk_id_pedido) REFERENCES Pedidos(id_pedido),
    metodo_pago VARCHAR(45) NOT NULL,
    Total DECIMAL (10, 2) NOT NULL,
    Fecha_transaccion DATE NOT NULL
);

INSERT INTO nombre_de_la_tabla (columna1, columna2, ...) 
VALUES (valor1, valor2, ...);

INSERT INTO Libros (id_libros, ISBN, Titulo, Editorial, Fecha_publicacion, Precio, Stock, Categorias_id_categoria, Autores_id_autor) 
VALUES (1, 9781234567897, 'Cien Años de Soledad', 'Sudamericana', '1967-05-30', 200.00, 10, 1, 1);

INSERT INTO Autores (id_autor, Nombre, Nacionalidad, Fecha_nacimiento) 
VALUES (1, 'Gabriel Garcia Marquez', 'Colombiana', '1927-03-06');

INSERT INTO Clientes (id_cliente, Nombre, Email, Telefono, Direccion) 
VALUES (1, 'Juan Perez', 'juan.perez@example.com', 5551234, 'Calle Falsa 123');

INSERT INTO Pedidos (id_pedido, Cantidad_libros, Fecha_compra, Estado, Clientes_id_cliente) 
VALUES (1, 1, '2024-10-30', 'Enviado', 1);

INSERT INTO Transacciones (Pedidos_id_pedido, Libros_id_libros, metodo_pago, Total, Fecha_transaccion) 
VALUES (1, 1, 'Paypal', 200.00, '2024-10-30');

INSERT INTO Categorias (id_categoria, Nombre) 
VALUES (1, 'Novela');

SELECT * FROM Libros;

SELECT Titulo, Editorial, Precio, Stock
FROM Libros
WHERE Categorias_id_categoria = 1;

SELECT * FROM Clientes;

SELECT id_transaccion, Total, Fecha_transaccion
FROM Transacciones
WHERE metodo_pago = 'Paypal';

SELECT SUM(Stock) AS Total_Libros_Stock
FROM Libros;

SELECT id_pedido, Cantidad_libros, Estado
FROM Pedidos
WHERE Fecha_compra = '2024-10-30';

SELECT Nombre, Nacionalidad
FROM Autores;
