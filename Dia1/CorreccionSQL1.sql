CREATE DATABASE prueba;
USE prueba;

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
    fk_id_libro INT NOT NULL,
    FOREIGN KEY(fk_id_libro) REFERENCES Libros(id_libro)
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
    fk_id_libro INT NOT NULL,
    fk_id_clientes INT NOT NULL,
    FOREIGN KEY(fk_id_clientes) REFERENCES Clientes(id_cliente),
    FOREIGN KEY(fk_id_libro) REFERENCES Libros(id_libro)
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

