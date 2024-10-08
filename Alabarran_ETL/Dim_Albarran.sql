-- Verificar si la base de datos Dim_Albarran existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Dim_Albarran')
BEGIN
    -- Crear la base de datos Dim_Albarran
    CREATE DATABASE Dim_Albarran;
    PRINT 'Base de datos Dim_Albarran creada.';
END
ELSE
BEGIN
    PRINT 'La base de datos Dim_Albarran ya existe.';
END
GO

-- Cambiar al contexto de la base de datos Dim_Albarran
USE Dim_Albarran;
GO

-- Eliminar claves for�neas
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'IF OBJECT_ID(''[' + OBJECT_SCHEMA_NAME(f.parent_object_id) + '].[' + OBJECT_NAME(f.parent_object_id) + ']'', ''U'') IS NOT NULL
BEGIN
    ALTER TABLE [' + OBJECT_SCHEMA_NAME(f.parent_object_id) + '].[' + OBJECT_NAME(f.parent_object_id) + '] DROP CONSTRAINT [' + f.name + '];
END; '
FROM sys.foreign_keys AS f;

EXEC sp_executesql @sql;
GO

-- Eliminar tablas si existen
DECLARE @dropSql NVARCHAR(MAX) = '';

SELECT @dropSql += 'IF OBJECT_ID(''[' + s.name + '].[' + t.name + ']'', ''U'') IS NOT NULL DROP TABLE [' + s.name + '].[' + t.name + ']; '
FROM sys.tables AS t
JOIN sys.schemas AS s ON t.schema_id = s.schema_id;

EXEC sp_executesql @dropSql;
GO

-- Crear Tabla Dimensi�n: TIEMPO (desnormalizada)
CREATE TABLE DIMTIEMPO (
    tiempoId INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    a�o INT NOT NULL,
    mes INT NOT NULL,
    dia INT NOT NULL,
    trimestre INT NOT NULL
);
GO

-- Crear Tabla Dimensi�n: PRODUCTO (sin claves for�neas)
CREATE TABLE DIMPRODUCTO (
    productoId INT PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    categoria NVARCHAR(255) NOT NULL, -- Categor�a como parte de la dimensi�n
    precio DECIMAL(10, 2) NOT NULL,
    descripcion NVARCHAR(255) NULL
);
GO

-- Crear Tabla Dimensi�n: CLIENTE (sin claves for�neas)
CREATE TABLE DIMCLIENTE (
    clienteId INT PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apPaterno NVARCHAR(255) NOT NULL,
    apMaterno NVARCHAR(255) NOT NULL,
    sexo CHAR(1) NOT NULL,
    fechaNacimiento DATE NULL,
    estadoCivil NVARCHAR(255) NULL
);
GO

-- Crear Tabla Dimensi�n: EMPLEADO (sin claves for�neas)
CREATE TABLE DIMEMPLEADO (
    empleadoId INT PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apPaterno NVARCHAR(255) NOT NULL,
    apMaterno NVARCHAR(255) NOT NULL,
    fechaContrato DATE NOT NULL,
    sueldoBase DECIMAL(10, 2) NOT NULL,
    cargo NVARCHAR(255) NOT NULL -- Cargo desnormalizado
);
GO

-- Crear Tabla Dimensi�n: SUCURSAL (sin claves for�neas)
CREATE TABLE DIMSUCURSAL (
    sucursalId INT PRIMARY KEY,
    sucursal NVARCHAR(255) NOT NULL,
    comuna NVARCHAR(255) NOT NULL -- Comuna desnormalizada
);
GO

-- Crear Tabla Hecho: HECHOSVENTAS
CREATE TABLE HECHOSVENTAS (
    hechoVentaId INT IDENTITY(1,1) PRIMARY KEY,
    tiempoId INT NOT NULL,
    productoId INT NOT NULL,
    clienteId INT NOT NULL,
    empleadoId INT NOT NULL,
    sucursalId INT NOT NULL,
    cantidadProductosVenta INT NOT NULL,
    costoProductosVenta DECIMAL(10, 2) NOT NULL,
    montoTotalVenta DECIMAL(10, 2) NOT NULL,
    beneficioBruto DECIMAL(10, 2) NOT NULL,
    tipoDocumento NVARCHAR(255) NOT NULL,
    numeroDocumento INT NOT NULL,
    totalDescuentos DECIMAL(5, 2) NOT NULL
);
GO

-- Crear claves for�neas para la tabla HECHOSVENTAS
ALTER TABLE HECHOSVENTAS
ADD CONSTRAINT FK_HechosVentas_DimTiempo FOREIGN KEY (tiempoId)
REFERENCES DIMTIEMPO(tiempoId);
GO

ALTER TABLE HECHOSVENTAS
ADD CONSTRAINT FK_HechosVentas_DimProducto FOREIGN KEY (productoId)
REFERENCES DIMPRODUCTO(productoId);
GO

ALTER TABLE HECHOSVENTAS
ADD CONSTRAINT FK_HechosVentas_DimCliente FOREIGN KEY (clienteId)
REFERENCES DIMCLIENTE(clienteId);
GO

ALTER TABLE HECHOSVENTAS
ADD CONSTRAINT FK_HechosVentas_DimEmpleado FOREIGN KEY (empleadoId)
REFERENCES DIMEMPLEADO(empleadoId);
GO

ALTER TABLE HECHOSVENTAS
ADD CONSTRAINT FK_HechosVentas_DimSucursal FOREIGN KEY (sucursalId)
REFERENCES DIMSUCURSAL(sucursalId);
GO
