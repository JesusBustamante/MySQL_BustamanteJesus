CREATE DATABASE migrupoT2;

USE migrupoT2;

CREATE TABLE Libros (
    id_libro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ISBN INT UNIQUE NOT NULL,
    Titulo VARCHAR(45) NOT NULL,
    Editorial VARCHAR(45) NOT NULL,
    Fecha_publicacion DATE NOT NULL,
    Precio DECIMAL (10, 2) NOT NULL,
    Stock INT NOT NULL
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
    FOREIGN KEY (id_libro) REFERENCES Libros (id_libro)
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
    FOREIGN KEY (id_libro) REFERENCES Libros (id_libro),
    FOREIGN KEY (id_cliente) REFERENCES Clientes (id_cliente)
);

CREATE TABLE Transacciones (
    id_transaccion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    metodo_pago VARCHAR(45) NOT NULL,
    Total DECIMAL (10, 2) NOT NULL,
    Fecha_transaccion DATE NOT NULL,
    FOREIGN KEY (id_libro) REFERENCES Libros (id_libro),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos (id_pedido)
);

SHOW tables;

