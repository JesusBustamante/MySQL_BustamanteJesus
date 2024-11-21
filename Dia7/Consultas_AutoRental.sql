use AutoRental;

-- Consultas

-- Funciones

-- 1. Calcular el valor del alquiler basado en semanas y días
DELIMITER //
CREATE FUNCTION CalcularValorAlquiler(
    p_Id_Tipo INT,
    p_Dias INT
) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE semanas INT;
    DECLARE dias_restantes INT;
    DECLARE valor_semanal DECIMAL(10, 2);
    DECLARE valor_diario DECIMAL(10, 2);
    DECLARE costo_total DECIMAL(10, 2);

    -- Obtener las tarifas de la tabla Tarifas
    SELECT Valor_Semana, Valor_Dia INTO valor_semanal, valor_diario
    FROM Tarifas
    WHERE Id_Tipo = p_Id_Tipo;

    -- Calcular semanas y días restantes
    SET semanas = p_Dias DIV 7;
    SET dias_restantes = p_Dias % 7;

    -- Calcular el costo total
    SET costo_total = (semanas * valor_semanal) + (dias_restantes * valor_diario);

    RETURN costo_total;
END //
DELIMITER ;

select CalcularValorAlquiler(10,9) as Valor_Alquiler;

-- 2. Obtener el nombre de una Ciudad por su ID.
DELIMITER //
create function obtenerCiudad(ciudad_id_i INT)
returns varchar(50) deterministic
begin
	declare ciudad_name_r varchar(50);
    select Nombre into ciudad_name_r
    from Ciudades
    where Id = ciudad_id_i;
    return ciudad_name_r;
end //
DELIMITER ;

select obtenerCiudad(3);

-- 3. Calcular el recargo por días de retraso
DELIMITER //
CREATE FUNCTION CalcularRecargo(
    p_Fecha_Llegada DATE,
    p_Fecha_Esperada_Llegada DATE,
    p_CostoBase DECIMAL(10, 2)
) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE dias_retraso INT;
    DECLARE recargo DECIMAL(10, 2);

    -- Calcular los días de retraso
    SET dias_retraso = DATEDIFF(p_Fecha_Llegada, p_Fecha_Esperada_Llegada);

    -- Si hay retraso, calcular el recargo
    IF dias_retraso > 0 THEN
        SET recargo = dias_retraso * p_CostoBase * 0.08;
    ELSE
        SET recargo = 0;
    END IF;

    RETURN recargo;
END //
DELIMITER ;

SELECT CalcularRecargo('2023-08-15', '2023-08-10', 1000) AS Calcular_Recargo;

-- 4. Calcular la ganancia total de una sucursal en un período
DELIMITER //
CREATE FUNCTION CalcularGananciasSucursal(
    p_Id_Sucursal INT,
    p_FechaInicio DATE,
    p_FechaFin DATE
) RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE ganancias DECIMAL(10, 2);

    -- Calcular las ganancias sumando los valores pagados en los alquileres de la sucursal
    SELECT SUM(Valor_Pagado) INTO ganancias
    FROM Alquileres
    WHERE Id_Sucursal_Salida = p_Id_Sucursal
      AND Fecha_Salida BETWEEN p_FechaInicio AND p_FechaFin;

    RETURN COALESCE(ganancias, 0);
END //
DELIMITER ;

select CalcularGananciasSucursal(2, '2023-04-15', '2023-04-22');

-- Procedimientos

-- 1. Registrar una nueva sucursal
DELIMITER //
create procedure insertarSucursal (in Ciudad varchar(50), Direccion varchar(100), Telefono_fijo varchar(15), Celular varchar(15), Email varchar(50), Id_ciudad INT)
begin
	insert into Sucursales(Ciudad, Direccion, Telefono_fijo, Celular, Email, Id_ciudad) values (Ciudad, Direccion, Telefono_fijo, Celular, Email, Id_ciudad);
end
// DELIMITER ;

call insertarSucursal("Valencia", "El Socoroo", "668-4414", "3156611676", "jesus@gmail.com", 5);

select * from Sucursales;

-- 2. Registrar un empleado
DELIMITER //
create procedure insertarEmpleado (in Cedula varchar(20), Nombre varchar(50), Apellido varchar(50), Direccion varchar(100), Ciudad varchar(50), Celular varchar(15), Email varchar(50), Id_Sucursal INT, Id_ciudad INT)
begin
	insert into Empleados(Cedula, Nombre, Apellido, Direccion, Ciudad, Celular, Email, Id_Sucursal, Id_ciudad) values (Cedula, Nombre, Apellido, Direccion, Ciudad, Celular, Email, Id_Sucursal, Id_ciudad);
end
// DELIMITER ;

call insertarEmpleado("65137611-2", "Jesus", "Bustamante", "Buenos Aires", "Medellin", "3224567890", "leonardoqgmail.com", 4, 6);

select * from Empleados;

-- 3. Registrar un nuevo vehículo
DELIMITER //
create procedure insertarVehiculo (in Placa varchar(10), Referencia varchar(50), Modelo year, Puertas varchar(100), Capacidad tinyint, Sunroof tinyint, Color varchar(20), Id_tipo INT, Id_motor INT)
begin
	insert into Vehiculos(Placa, Referencia, Modelo, Puertas, Capacidad, Sunroof, Color, Id_tipo, Id_motor) values (Placa, Referencia, Modelo, Puertas, Capacidad, Sunroof, Color, Id_tipo, Id_motor);
end
// DELIMITER ;

call insertarVehiculo("H255W", "Modelo-282", 2012, 4, 5, 1, "Azul", 4, 6);

select * from Vehiculos;
-- 4. Actualizar el estado de un vehículo
DELIMITER //
CREATE PROCEDURE ActualizarTipoVehiculo(
    IN p_Id_Vehiculo INT,
    IN p_NuevoTipo INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Vehiculos WHERE Id = p_Id_Vehiculo) THEN

        IF EXISTS (SELECT 1 FROM Sucursales WHERE Id = p_NuevoTipo) THEN

            UPDATE Vehiculos
            SET Id_tipo = p_NuevoTipo
            WHERE Id = p_Id_Vehiculo;

            SELECT CONCAT('El vehículo con ID ', p_Id_Vehiculo, 
                          ' ahora está asignado a la sucursal con ID ', p_NuevoTipo) AS Mensaje;
        ELSE
            SELECT CONCAT('La sucursal con ID ', p_NuevoTipo, ' no existe.') AS Mensaje;
        END IF;
    ELSE
        SELECT CONCAT('El vehículo con ID ', p_Id_Vehiculo, ' no existe.') AS Mensaje;
    END IF;
END //
DELIMITER ;

call ActualizarTipoVehiculo(1, 4);

select * from Vehiculos;

-- 5. Registrar un cliente (signup)
DELIMITER //
CREATE PROCEDURE SignUpCliente(
    IN p_Cedula VARCHAR(20),
    IN p_Nombre VARCHAR(50),
    IN p_Apellido VARCHAR(50),
    IN p_Email VARCHAR(50),
    IN p_Direccion VARCHAR(100),
    IN p_Ciudad VARCHAR(50),
    IN p_Celular VARCHAR(15),
    IN p_Id_ciudad INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM Clientes WHERE Email = p_Email) THEN
        SELECT 'El correo ya está registrado.' AS Mensaje;
    ELSEIF EXISTS (SELECT 1 FROM Clientes WHERE Cedula = p_Cedula) THEN
        SELECT 'La cédula ya está registrada.' AS Mensaje;
    ELSE

        INSERT INTO Clientes (
            Cedula, Nombre, Apellido, Email, Direccion, Ciudad, Celular, Id_ciudad
        ) 
        VALUES (
            p_Cedula, p_Nombre, p_Apellido, p_Email, p_Direccion, p_Ciudad, p_Celular, p_Id_ciudad
        );
        SELECT 'Registro exitoso.' AS Mensaje;
    END IF;
END //
DELIMITER ;

CALL SignUpCliente(
    '123456789', 'Juan', 'Pérez', 'juan.perez@gmail.com', 'Calle 123', 'Bogotá', '3111234567', 5
);

select* from Clientes;


-- 6. Realizar un alquiler de vehículo
-- 7. Registrar la devolución de un vehículo
-- 8. Aplicar descuento a un alquiler
-- 9. Consultar disponibilidad de vehículos
-- 10. Consultar historial de alquileres de un cliente