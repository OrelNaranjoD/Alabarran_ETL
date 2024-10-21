IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Dim_Albarran')
BEGIN
    CREATE DATABASE Dim_Albarran;
    PRINT 'Base de datos Dim_Albarran creada.';
END
ELSE
BEGIN
    PRINT 'La base de datos Dim_Albarran ya existe.';
END
GO

USE Dim_Albarran;
GO

DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'IF OBJECT_ID(''[' + OBJECT_SCHEMA_NAME(f.parent_object_id) + '].[' + OBJECT_NAME(f.parent_object_id) + ']'', ''U'') IS NOT NULL
BEGIN
    ALTER TABLE [' + OBJECT_SCHEMA_NAME(f.parent_object_id) + '].[' + OBJECT_NAME(f.parent_object_id) + '] DROP CONSTRAINT [' + f.name + '];
END; '
FROM sys.foreign_keys AS f;

EXEC sp_executesql @sql;
GO

-- Eliminar tablas
IF OBJECT_ID('[dbo].[HECHOSVENTAS]', 'U') IS NOT NULL DROP TABLE [dbo].[HECHOSVENTAS];
IF OBJECT_ID('[dbo].[DIMSUCURSAL]', 'U') IS NOT NULL DROP TABLE [dbo].[DIMSUCURSAL];
IF OBJECT_ID('[dbo].[DIMEMPLEADO]', 'U') IS NOT NULL DROP TABLE [dbo].[DIMEMPLEADO];
IF OBJECT_ID('[dbo].[DIMCLIENTE]', 'U') IS NOT NULL DROP TABLE [dbo].[DIMCLIENTE];
IF OBJECT_ID('[dbo].[DIMPRODUCTO]', 'U') IS NOT NULL DROP TABLE [dbo].[DIMPRODUCTO];
IF OBJECT_ID('[dbo].[DIMTIEMPO]', 'U') IS NOT NULL DROP TABLE [dbo].[DIMTIEMPO];
GO

-- Crear tablas
CREATE TABLE DIMTIEMPO (
    tiempoId INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    anio INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    dia_semana NVARCHAR(10) NOT NULL,
    nombre_mes NVARCHAR(20) NOT NULL,
    trimestre INT NOT NULL
);
GO

CREATE TABLE DIMPRODUCTO (
    productoId INT PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    categoria NVARCHAR(255) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion NVARCHAR(255) NULL
);
GO

CREATE TABLE DIMCLIENTE (
    clienteId INT PRIMARY KEY,
    nombreCompleto NVARCHAR(255) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fechaNacimiento DATE NULL,
    estadoCivil NVARCHAR(255) NULL
);
GO

CREATE TABLE DIMEMPLEADO (
    empleadoId INT PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apPaterno NVARCHAR(255) NOT NULL,
    apMaterno NVARCHAR(255) NOT NULL,
    fechaContrato DATE NOT NULL,
    sueldoBase DECIMAL(10, 2) NOT NULL,
    cargo NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE DIMSUCURSAL (
    sucursalId INT PRIMARY KEY,
    nombreSucursal NVARCHAR(255) NOT NULL,
    comuna NVARCHAR(255) NOT NULL,
    ciudad NVARCHAR(255) NOT NULL,
    region NVARCHAR(255) NOT NULL,
    pais NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE HECHOSVENTAS (
    hechoVentaId INT IDENTITY(1,1) PRIMARY KEY,
    tiempoId INT NOT NULL REFERENCES DIMTIEMPO(tiempoId),
    productoId INT NOT NULL REFERENCES DIMPRODUCTO(productoId),
    clienteId INT NOT NULL REFERENCES DIMCLIENTE(clienteId),
    empleadoId INT NOT NULL REFERENCES DIMEMPLEADO(empleadoId),
    sucursalId INT NOT NULL REFERENCES DIMSUCURSAL(sucursalId),
    cantidadProductosVenta INT NOT NULL,
    costoProductosVenta DECIMAL(10, 2) NOT NULL,
    montoTotalVenta DECIMAL(10, 2) NOT NULL,
    beneficioBruto DECIMAL(10, 2) NOT NULL,
    tipoDocumento NVARCHAR(255) NOT NULL,
    numeroDocumento INT NOT NULL,
    totalDescuentos DECIMAL(5, 2) NOT NULL
);
GO
