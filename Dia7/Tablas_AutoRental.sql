Create database AutoRental;

Use AutoRental;

CREATE TABLE Ciudades (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(45) NOT NULL
);

CREATE TABLE Sucursales (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Ciudad VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    Telefono_fijo VARCHAR(15),
    Celular VARCHAR(15),
    Email VARCHAR(50),
    Id_ciudad INT NOT NULL,
    FOREIGN KEY (Id_ciudad) REFERENCES Ciudades (Id)
);

CREATE TABLE Empleados (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100),
    Ciudad VARCHAR(50),
    Celular VARCHAR(15),
    Email VARCHAR(50),
    Id_Sucursal INT NOT NULL,
    FOREIGN KEY (Id_Sucursal) REFERENCES Sucursales(Id),
    Id_ciudad INT NOT NULL,
    FOREIGN KEY (Id_ciudad) REFERENCES Ciudades (Id)
);

CREATE TABLE Clientes (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cedula VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Direccion VARCHAR(100),
    Ciudad VARCHAR(50),
    Celular VARCHAR(15),
    Email VARCHAR(50),
    Id_ciudad INT NOT NULL,
    FOREIGN KEY (Id_ciudad) REFERENCES Ciudades (Id)
);

CREATE TABLE Tipos_vehiculo (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(15)
);

CREATE TABLE Motores (
	Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(50)
);

CREATE TABLE Tarifas (
    Id_Tipo INT NOT NULL,
    PRIMARY KEY (Id_Tipo),
    Valor_Semana DECIMAL(10, 2) NOT NULL,
    Valor_Dia DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (Id_Tipo) REFERENCES Tipos_vehiculo(Id)
);

CREATE TABLE Vehiculos (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Placa VARCHAR(10) UNIQUE NOT NULL,
    Referencia VARCHAR(50),
    Modelo YEAR,
    Puertas TINYINT,
    Capacidad TINYINT,
    Sunroof BOOLEAN,
    Color VARCHAR(20),
    Id_tipo INT NOT NULL,
    FOREIGN KEY (Id_tipo) REFERENCES Tipos_vehiculo (Id),
    Id_motor INT NOT NULL,
    FOREIGN KEY (Id_motor) REFERENCES Motores (Id)
);

CREATE TABLE Alquileres (
    Id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Id_Vehiculo INT NOT NULL,
    Id_Cliente INT NOT NULL,
    Id_Empleado INT NOT NULL,
    Id_Sucursal_Salida INT NOT NULL,
    Fecha_Salida DATE NOT NULL,
    Id_Sucursal_Llegada INT NOT NULL,
    Fecha_Llegada DATE,
    Fecha_Esperada_Llegada DATE NOT NULL,
    Porcentaje_Descuento DECIMAL(5, 2),
    Valor_Cotizado DECIMAL(10, 2),
    Valor_Pagado DECIMAL(10, 2),
    FOREIGN KEY (Id_Vehiculo) REFERENCES Vehiculos(Id),
    FOREIGN KEY (Id_Cliente) REFERENCES Clientes(Id),
    FOREIGN KEY (Id_Empleado) REFERENCES Empleados(Id),
    FOREIGN KEY (Id_Sucursal_Salida) REFERENCES Sucursales(Id),
    FOREIGN KEY (Id_Sucursal_Llegada) REFERENCES Sucursales(Id)
);