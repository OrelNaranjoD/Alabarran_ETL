-- Verificar si la base de datos Dim_Albarran existe
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Albarran')
BEGIN
    -- Crear la base de datos Dim_Albarran
    CREATE DATABASE Albarran;
    PRINT 'Base de datos Albarran creada.';
END
ELSE
BEGIN
    PRINT 'La base de datos Albarran ya existe.';
END
GO

-- Cambiar al contexto de la base de datos Albarran
USE Albarran;
GO

-- Eliminar claves foráneas
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

GO
ALTER DATABASE [Albarran] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Albarran] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Albarran] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Albarran] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Albarran] SET ARITHABORT OFF 
GO
ALTER DATABASE [Albarran] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Albarran] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Albarran] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Albarran] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Albarran] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Albarran] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Albarran] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Albarran] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Albarran] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Albarran] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Albarran] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Albarran] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Albarran] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Albarran] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Albarran] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Albarran] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Albarran] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Albarran] SET RECOVERY FULL 
GO
ALTER DATABASE [Albarran] SET  MULTI_USER 
GO
ALTER DATABASE [Albarran] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Albarran] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Albarran] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Albarran] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Albarran] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Albarran] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Albarran] SET QUERY_STORE = OFF
GO
USE [Albarran]
GO
/****** Object:  Table [dbo].[cargos]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargos](
	[cargo_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cargos] PRIMARY KEY CLUSTERED 
(
	[cargo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[categorias]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categorias](
	[categoria_id] [int] NOT NULL,
	[categoria] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_categorias] PRIMARY KEY CLUSTERED 
(
	[categoria_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[clientes]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[clientes](
	[cliente_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[appaterno] [nvarchar](255) NOT NULL,
	[apmaterno] [nvarchar](255) NOT NULL,
	[sexo] [char](1) NOT NULL,
	[fecha_nacimiento] [datetime] NULL,
	[estado_civil] [nvarchar](255) NULL,
 CONSTRAINT [PK_clientes] PRIMARY KEY CLUSTERED 
(
	[cliente_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comunas]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comunas](
	[comuna_id] [int] NOT NULL,
	[comuna] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_comunas] PRIMARY KEY CLUSTERED 
(
	[comuna_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[detalle_ventas]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detalle_ventas](
	[venta_id] [int] NOT NULL,
	[producto_id] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precio_unitario] [int] NOT NULL,
	[descuento] [numeric](5, 2) NOT NULL,
 CONSTRAINT [PK_detalle_ventas] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC,
	[producto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[empleados]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[empleados](
	[empleado_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[appaterno] [nvarchar](255) NOT NULL,
	[apmaterno] [nvarchar](255) NOT NULL,
	[fecha_contrato] [datetime] NOT NULL,
	[sueldo_base] [int] NOT NULL,
	[cargo_id] [int] NOT NULL,
 CONSTRAINT [PK_empleados] PRIMARY KEY CLUSTERED 
(
	[empleado_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productos]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productos](
	[producto_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[precio] [int] NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[categoria_id] [int] NOT NULL,
 CONSTRAINT [PK_productos] PRIMARY KEY CLUSTERED 
(
	[producto_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sucursales]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sucursales](
	[sucursal_id] [int] NOT NULL,
	[sucursal] [nvarchar](255) NOT NULL,
	[comuna_id] [int] NOT NULL,
 CONSTRAINT [PK_sucursales] PRIMARY KEY CLUSTERED 
(
	[sucursal_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ventas]    Script Date: 29-09-2024 10:42:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ventas](
	[venta_id] [int] NOT NULL,
	[vendedor_id] [int] NOT NULL,
	[cliente_id] [int] NOT NULL,
	[sucursal_id] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[tipo_documento] [nvarchar](255) NOT NULL,
	[numero_documento] [int] NOT NULL,
 CONSTRAINT [PK_ventas] PRIMARY KEY CLUSTERED 
(
	[venta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[cargos] ([cargo_id], [nombre]) VALUES (1, N'vendedor')
GO
INSERT [dbo].[cargos] ([cargo_id], [nombre]) VALUES (2, N'cajero')
GO
INSERT [dbo].[cargos] ([cargo_id], [nombre]) VALUES (3, N'encargado despacho')
GO
INSERT [dbo].[cargos] ([cargo_id], [nombre]) VALUES (4, N'bodeguero')
GO
INSERT [dbo].[cargos] ([cargo_id], [nombre]) VALUES (5, N'mueblista')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (1, N'Arrimos')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (2, N'Banquetas')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (3, N'Bares')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (4, N'Buffets')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (5, N'Comedores')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (6, N'Dormitorio')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (7, N'Esquineros')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (8, N'Mesas de Centro')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (9, N'Modulares')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (10, N'Paneles TV')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (11, N'Puertas')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (12, N'Sitiales')
GO
INSERT [dbo].[categorias] ([categoria_id], [categoria]) VALUES (13, N'Sofás')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (1, N'Rodrigo', N'Aliaga', N'Gonzalez', N'M', CAST(N'1980-02-01T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (2, N'Ramón', N'Carnicer', N'Pérez', N'M', CAST(N'1970-01-20T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (3, N'Juan', N'Rebolledo', N'Santander', N'M', CAST(N'1965-02-02T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (4, N'Luis', N'Andrade', N'Molina', N'M', CAST(N'1963-12-22T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (5, N'Jorge', N'Pellicer', N'Díaz', N'M', CAST(N'1978-10-29T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (6, N'Julia', N'Le-Roy', N'Díaz', N'F', CAST(N'1977-12-01T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (7, N'Pamela', N'Neira', N'Durán', N'F', CAST(N'1980-06-19T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (8, N'Dalila', N'Rojas', N'Pérez', N'F', CAST(N'1988-09-18T00:00:00.000' AS DateTime), N'soltero')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (9, N'Luisa', N'Durán', N'Rojas', N'F', CAST(N'1954-11-29T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (10, N'Julieta', N'Santander', N'Ríos', N'F', CAST(N'1988-12-12T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (11, N'Michel', N'Muñoz', N'Soto', N'M', CAST(N'1974-02-02T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (12, N'Samuel', N'Gonzalez', N'Pedreros', N'M', CAST(N'1977-08-25T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (13, N'Rony', N'Rodriguez', N'Rodriguez', N'M', CAST(N'1973-09-10T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (14, N'Adrián', N'Dados', N'Negrete', N'M', CAST(N'1982-10-20T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (15, N'Ramón', N'Ulloa', N'Velásquez', N'M', CAST(N'1971-10-10T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (16, N'Alfonso', N'Sierra', N'Mujica', N'M', CAST(N'1988-12-31T00:00:00.000' AS DateTime), N'soltero')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (17, N'Diego', N'Navarrete', N'Sierra', N'M', CAST(N'1990-11-18T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (18, N'Ricardo', N'Veloso', N'Soto', N'M', CAST(N'1989-12-09T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (19, N'Gonzalo', N'Andrade', N'Barraza', N'M', CAST(N'1976-04-04T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[clientes] ([cliente_id], [nombre], [appaterno], [apmaterno], [sexo], [fecha_nacimiento], [estado_civil]) VALUES (20, N'Margarita', N'Barraza', N'Andrade', N'F', CAST(N'1975-03-22T00:00:00.000' AS DateTime), N'casado')
GO
INSERT [dbo].[comunas] ([comuna_id], [comuna]) VALUES (1, N'Viña del Mar')
GO
INSERT [dbo].[comunas] ([comuna_id], [comuna]) VALUES (2, N'Las Condes')
GO
INSERT [dbo].[comunas] ([comuna_id], [comuna]) VALUES (3, N'Santiago')
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (1, 13, 1, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (2, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (3, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (4, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (5, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (6, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (7, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (8, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (9, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (10, 15, 1, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (11, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (12, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (13, 9, 3, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (14, 3, 2, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (15, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (16, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (17, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (18, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (19, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (20, 3, 3, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (21, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (22, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (23, 5, 1, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (24, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (25, 9, 3, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (26, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (27, 13, 1, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (28, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (29, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (30, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (31, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (32, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (33, 6, 2, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (34, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (35, 9, 3, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (36, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (37, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (38, 20, 2, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (39, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (40, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (41, 15, 1, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (42, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (43, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (44, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (45, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (46, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (47, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (48, 19, 1, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (49, 9, 2, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (50, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (51, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (52, 20, 1, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (53, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (54, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (55, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (56, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (57, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (58, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (59, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (60, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (61, 13, 2, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (62, 10, 3, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (63, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (64, 9, 2, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (65, 13, 2, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (66, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (67, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (68, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (69, 12, 3, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (70, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (71, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (72, 18, 3, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (73, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (74, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (75, 15, 1, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (76, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (77, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (78, 20, 1, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (79, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (80, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (81, 6, 2, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (82, 9, 2, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (83, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (84, 16, 3, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (85, 3, 2, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (86, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (87, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (88, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (89, 8, 3, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (90, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (91, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (92, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (93, 6, 2, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (94, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (95, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (96, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (97, 3, 2, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (98, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (99, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (100, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (101, 13, 2, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (102, 15, 2, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (103, 18, 3, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (104, 19, 1, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (105, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (106, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (107, 16, 3, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (108, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (109, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (110, 16, 3, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (111, 9, 3, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (112, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (113, 14, 2, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (114, 10, 2, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (115, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (116, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (117, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (118, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (119, 8, 1, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (120, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (121, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (122, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (123, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (124, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (125, 13, 3, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (126, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (127, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (128, 19, 1, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (129, 12, 3, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (130, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (131, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (132, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (133, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (134, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (135, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (136, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (137, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (138, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (139, 20, 1, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (140, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (141, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (142, 20, 2, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (143, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (144, 10, 3, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (145, 6, 2, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (146, 11, 1, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (147, 3, 2, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (148, 10, 3, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (149, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (150, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (151, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (152, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (153, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (154, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (155, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (156, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (157, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (158, 20, 2, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (159, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (160, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (161, 20, 2, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (162, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (163, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (164, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (165, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (166, 16, 3, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (167, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (168, 13, 1, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (169, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (170, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (171, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (172, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (173, 9, 1, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (174, 10, 3, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (175, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (176, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (177, 13, 1, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (178, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (179, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (180, 9, 1, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (181, 13, 3, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (182, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (183, 20, 2, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (184, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (185, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (186, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (187, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (188, 15, 1, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (189, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (190, 19, 2, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (191, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (192, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (193, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (194, 8, 3, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (195, 8, 1, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (196, 8, 1, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (197, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (198, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (199, 5, 1, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (200, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (201, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (202, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (203, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (204, 18, 3, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (205, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (206, 10, 2, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (207, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (208, 10, 2, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (209, 9, 2, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (210, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (211, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (212, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (213, 18, 3, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (214, 3, 1, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (215, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (216, 17, 1, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (217, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (218, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (219, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (220, 12, 3, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (221, 11, 1, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (222, 19, 2, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (223, 10, 2, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (224, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (225, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (226, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (227, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (228, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (229, 14, 2, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (230, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (231, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (232, 16, 3, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (233, 8, 3, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (234, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (235, 3, 1, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (236, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (237, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (238, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (239, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (240, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (241, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (242, 11, 1, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (243, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (244, 19, 3, 700000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (245, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (246, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (247, 11, 1, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (248, 2, 1, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (249, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (250, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (251, 4, 2, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (252, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (253, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (254, 9, 1, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (255, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (256, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (257, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (258, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (259, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (260, 6, 2, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (261, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (262, 1, 2, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (263, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (264, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (265, 8, 3, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (266, 12, 2, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (267, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (268, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (269, 12, 3, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (270, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (271, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (272, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (273, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (274, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (275, 20, 1, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (276, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (277, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (278, 9, 3, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (279, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (280, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (281, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (282, 3, 3, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (283, 12, 2, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (284, 6, 3, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (285, 5, 1, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (286, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (287, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (288, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (289, 8, 2, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (290, 20, 3, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (291, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (292, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (293, 1, 3, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (294, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (295, 13, 2, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (296, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (297, 5, 1, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (298, 15, 3, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (299, 12, 2, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (300, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (301, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (302, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (303, 12, 2, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (304, 9, 2, 298500, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (305, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (306, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (307, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (308, 13, 3, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (309, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (310, 6, 1, 950900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (311, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (312, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (313, 2, 3, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (314, 8, 1, 210000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (315, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (316, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (317, 17, 3, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (318, 15, 1, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (319, 10, 2, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (320, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (321, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (322, 16, 2, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (323, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (324, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (325, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (326, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (327, 17, 2, 550000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (328, 11, 2, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (329, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (330, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (331, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (332, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (333, 14, 3, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (334, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (335, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (336, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (337, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (338, 7, 1, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (339, 7, 2, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (340, 10, 1, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (341, 2, 2, 699000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (342, 13, 2, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (343, 5, 3, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (344, 3, 1, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (345, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (346, 3, 2, 450000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (347, 12, 1, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (348, 20, 1, 650000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (349, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (350, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (351, 4, 3, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (352, 7, 3, 290000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (353, 18, 2, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (354, 10, 3, 350000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (355, 16, 1, 750000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (356, 13, 1, 310000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (357, 5, 2, 699900, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (358, 11, 3, 199000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (359, 1, 1, 550999, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (360, 14, 1, 680000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (361, 12, 3, 850000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (362, 15, 2, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (363, 4, 1, 399000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (364, 15, 2, 1300000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[detalle_ventas] ([venta_id], [producto_id], [cantidad], [precio_unitario], [descuento]) VALUES (365, 18, 1, 490000, CAST(0.00 AS Numeric(5, 2)))
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (1, N'Pamela', N'Cortez', N'Soto', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 400000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (2, N'Javier', N'Contreras', N'Escalante', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (3, N'Jesús', N'Navas', N'Quintanilla', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (4, N'Romina', N'Vasquez', N'Ampuero', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (5, N'Marjorie', N'Contreras', N'Solabarrieta', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (6, N'Irma', N'Soto', N'Gonzalez', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 1)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (7, N'Fabián', N'Cerda', N'Contreras', CAST(N'2012-01-02T00:00:00.000' AS DateTime), 400000, 5)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (8, N'Andrés', N'Hiriart', N'Quezada', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 5)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (9, N'Sandro', N'Riquelme', N'Andrade', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 3)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (10, N'Juan', N'Vargas', N'Yañez', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 3)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (11, N'Sergio', N'Mena', N'Lanaro', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 3)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (12, N'Jessita', N'Cartes', N'Olavarría', CAST(N'2015-06-12T00:00:00.000' AS DateTime), 300000, 2)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (13, N'Ramiro', N'Mendoza', N'Torres', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 2)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (14, N'Paulina', N'Herrera', N'Montalva', CAST(N'2014-03-25T00:00:00.000' AS DateTime), 255000, 2)
GO
INSERT [dbo].[empleados] ([empleado_id], [nombre], [appaterno], [apmaterno], [fecha_contrato], [sueldo_base], [cargo_id]) VALUES (15, N'Rómulo', N'Otero', N'Pérez', CAST(N'2012-01-15T00:00:00.000' AS DateTime), 255000, 4)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (1, N'Comedor agapanto', 550999, NULL, 5)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (2, N'Bar con cava', 699000, NULL, 3)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (3, N'Bar raulí c/ carros', 450000, NULL, 3)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (4, N'Cava madera', 399000, NULL, 3)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (5, N'Comedor madera y vidrio', 699900, NULL, 5)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (6, N'Librero Tobar', 950900, NULL, 6)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (7, N'Escritorio melamina blanco', 290000, NULL, 6)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (8, N'Mesa centro blanca madera', 210000, NULL, 8)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (9, N'Sitial Vial', 298500, NULL, 12)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (10, N'Mueble rack TV 2 puertas', 350000, NULL, 10)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (11, N'Banqueta Calderón', 199000, NULL, 2)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (12, N'Mampara doble', 850000, NULL, 11)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (13, N'Arrimo Acevedo', 310000, NULL, 1)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (14, N'Chaise Longe', 680000, NULL, 13)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (15, N'Living MJO', 1300000, NULL, 13)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (16, N'Esquinero Std', 750000, NULL, 7)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (17, N'Panel TV', 550000, NULL, 10)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (18, N'Comedor Fritz', 490000, NULL, 5)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (19, N'Comedor base roble', 700000, NULL, 5)
GO
INSERT [dbo].[productos] ([producto_id], [nombre], [precio], [descripcion], [categoria_id]) VALUES (20, N'Comedor Valeria', 650000, NULL, 5)
GO
INSERT [dbo].[sucursales] ([sucursal_id], [sucursal], [comuna_id]) VALUES (1, N'Viña del Mar', 1)
GO
INSERT [dbo].[sucursales] ([sucursal_id], [sucursal], [comuna_id]) VALUES (2, N'Manquehue', 2)
GO
INSERT [dbo].[sucursales] ([sucursal_id], [sucursal], [comuna_id]) VALUES (3, N'Franklin', 3)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (1, 1, 6, 1, CAST(N'2017-01-01T00:00:00.000' AS DateTime), N'boleta', 1)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (2, 4, 15, 2, CAST(N'2017-01-02T00:00:00.000' AS DateTime), N'boleta', 2)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (3, 4, 11, 3, CAST(N'2017-01-02T00:00:00.000' AS DateTime), N'boleta', 3)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (4, 5, 14, 3, CAST(N'2017-01-03T00:00:00.000' AS DateTime), N'factura', 4)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (5, 5, 11, 2, CAST(N'2017-01-05T00:00:00.000' AS DateTime), N'boleta', 5)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (6, 4, 12, 2, CAST(N'2017-01-06T00:00:00.000' AS DateTime), N'boleta', 6)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (7, 5, 18, 3, CAST(N'2017-01-07T00:00:00.000' AS DateTime), N'boleta', 7)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (8, 1, 15, 3, CAST(N'2017-01-07T00:00:00.000' AS DateTime), N'boleta', 8)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (9, 3, 8, 2, CAST(N'2017-01-07T00:00:00.000' AS DateTime), N'factura', 9)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (10, 2, 10, 2, CAST(N'2017-01-08T00:00:00.000' AS DateTime), N'boleta', 10)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (11, 5, 20, 2, CAST(N'2017-01-11T00:00:00.000' AS DateTime), N'boleta', 11)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (12, 4, 9, 3, CAST(N'2017-01-11T00:00:00.000' AS DateTime), N'boleta', 12)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (13, 2, 18, 2, CAST(N'2017-01-12T00:00:00.000' AS DateTime), N'boleta', 13)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (14, 1, 1, 1, CAST(N'2017-01-12T00:00:00.000' AS DateTime), N'boleta', 14)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (15, 5, 1, 2, CAST(N'2017-01-13T00:00:00.000' AS DateTime), N'boleta', 15)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (16, 2, 1, 3, CAST(N'2017-01-17T00:00:00.000' AS DateTime), N'boleta', 16)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (17, 2, 18, 1, CAST(N'2017-01-17T00:00:00.000' AS DateTime), N'boleta', 17)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (18, 1, 15, 2, CAST(N'2017-01-19T00:00:00.000' AS DateTime), N'boleta', 18)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (19, 5, 5, 1, CAST(N'2017-01-19T00:00:00.000' AS DateTime), N'factura', 19)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (20, 5, 12, 3, CAST(N'2017-01-20T00:00:00.000' AS DateTime), N'boleta', 20)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (21, 2, 6, 1, CAST(N'2017-01-23T00:00:00.000' AS DateTime), N'boleta', 21)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (22, 1, 8, 3, CAST(N'2017-01-27T00:00:00.000' AS DateTime), N'boleta', 22)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (23, 2, 4, 1, CAST(N'2017-01-27T00:00:00.000' AS DateTime), N'boleta', 23)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (24, 6, 20, 1, CAST(N'2017-01-28T00:00:00.000' AS DateTime), N'boleta', 24)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (25, 2, 5, 2, CAST(N'2017-01-29T00:00:00.000' AS DateTime), N'boleta', 25)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (26, 4, 2, 3, CAST(N'2017-02-01T00:00:00.000' AS DateTime), N'boleta', 26)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (27, 2, 7, 3, CAST(N'2017-02-01T00:00:00.000' AS DateTime), N'boleta', 27)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (28, 5, 19, 3, CAST(N'2017-02-02T00:00:00.000' AS DateTime), N'factura', 28)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (29, 4, 20, 1, CAST(N'2017-02-02T00:00:00.000' AS DateTime), N'boleta', 29)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (30, 4, 13, 2, CAST(N'2017-02-03T00:00:00.000' AS DateTime), N'boleta', 30)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (31, 2, 15, 2, CAST(N'2017-02-05T00:00:00.000' AS DateTime), N'boleta', 31)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (32, 2, 10, 2, CAST(N'2017-02-07T00:00:00.000' AS DateTime), N'boleta', 32)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (33, 1, 6, 3, CAST(N'2017-02-07T00:00:00.000' AS DateTime), N'factura', 33)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (34, 1, 16, 3, CAST(N'2017-02-10T00:00:00.000' AS DateTime), N'boleta', 34)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (35, 3, 12, 3, CAST(N'2017-02-11T00:00:00.000' AS DateTime), N'boleta', 35)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (36, 5, 12, 2, CAST(N'2017-02-11T00:00:00.000' AS DateTime), N'boleta', 36)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (37, 2, 13, 1, CAST(N'2017-02-12T00:00:00.000' AS DateTime), N'factura', 37)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (38, 4, 20, 2, CAST(N'2017-02-13T00:00:00.000' AS DateTime), N'boleta', 38)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (39, 6, 7, 3, CAST(N'2017-02-13T00:00:00.000' AS DateTime), N'boleta', 39)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (40, 2, 17, 2, CAST(N'2017-02-13T00:00:00.000' AS DateTime), N'boleta', 40)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (41, 1, 6, 1, CAST(N'2017-02-13T00:00:00.000' AS DateTime), N'factura', 41)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (42, 1, 16, 3, CAST(N'2017-02-16T00:00:00.000' AS DateTime), N'boleta', 42)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (43, 4, 15, 2, CAST(N'2017-02-16T00:00:00.000' AS DateTime), N'boleta', 43)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (44, 6, 6, 3, CAST(N'2017-02-16T00:00:00.000' AS DateTime), N'boleta', 44)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (45, 5, 12, 3, CAST(N'2017-02-17T00:00:00.000' AS DateTime), N'boleta', 45)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (46, 4, 17, 2, CAST(N'2017-02-17T00:00:00.000' AS DateTime), N'boleta', 46)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (47, 2, 14, 1, CAST(N'2017-02-18T00:00:00.000' AS DateTime), N'boleta', 47)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (48, 6, 13, 3, CAST(N'2017-02-19T00:00:00.000' AS DateTime), N'boleta', 48)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (49, 5, 18, 3, CAST(N'2017-02-21T00:00:00.000' AS DateTime), N'factura', 49)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (50, 4, 2, 2, CAST(N'2017-02-22T00:00:00.000' AS DateTime), N'boleta', 50)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (51, 1, 10, 2, CAST(N'2017-02-22T00:00:00.000' AS DateTime), N'boleta', 51)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (52, 2, 1, 2, CAST(N'2017-02-24T00:00:00.000' AS DateTime), N'boleta', 52)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (53, 5, 9, 3, CAST(N'2017-02-27T00:00:00.000' AS DateTime), N'boleta', 53)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (54, 5, 7, 1, CAST(N'2017-02-27T00:00:00.000' AS DateTime), N'factura', 54)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (55, 2, 1, 3, CAST(N'2017-02-28T00:00:00.000' AS DateTime), N'boleta', 55)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (56, 5, 5, 1, CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'boleta', 56)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (57, 2, 16, 3, CAST(N'2017-03-02T00:00:00.000' AS DateTime), N'boleta', 57)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (58, 4, 3, 2, CAST(N'2017-03-04T00:00:00.000' AS DateTime), N'boleta', 58)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (59, 5, 12, 3, CAST(N'2017-03-05T00:00:00.000' AS DateTime), N'factura', 59)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (60, 1, 1, 2, CAST(N'2017-03-05T00:00:00.000' AS DateTime), N'boleta', 60)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (61, 2, 10, 2, CAST(N'2017-03-05T00:00:00.000' AS DateTime), N'boleta', 61)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (62, 3, 18, 3, CAST(N'2017-03-07T00:00:00.000' AS DateTime), N'boleta', 62)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (63, 5, 11, 2, CAST(N'2017-03-08T00:00:00.000' AS DateTime), N'boleta', 63)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (64, 3, 6, 1, CAST(N'2017-03-09T00:00:00.000' AS DateTime), N'factura', 64)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (65, 4, 20, 2, CAST(N'2017-03-10T00:00:00.000' AS DateTime), N'boleta', 65)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (66, 4, 16, 3, CAST(N'2017-03-12T00:00:00.000' AS DateTime), N'boleta', 66)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (67, 1, 11, 2, CAST(N'2017-03-14T00:00:00.000' AS DateTime), N'boleta', 67)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (68, 2, 11, 1, CAST(N'2017-03-14T00:00:00.000' AS DateTime), N'boleta', 68)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (69, 4, 1, 2, CAST(N'2017-03-15T00:00:00.000' AS DateTime), N'boleta', 69)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (70, 2, 9, 1, CAST(N'2017-03-15T00:00:00.000' AS DateTime), N'boleta', 70)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (71, 1, 19, 1, CAST(N'2017-03-16T00:00:00.000' AS DateTime), N'boleta', 71)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (72, 2, 19, 3, CAST(N'2017-03-19T00:00:00.000' AS DateTime), N'boleta', 72)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (73, 2, 3, 2, CAST(N'2017-03-21T00:00:00.000' AS DateTime), N'boleta', 73)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (74, 5, 16, 2, CAST(N'2017-03-23T00:00:00.000' AS DateTime), N'factura', 74)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (75, 1, 20, 3, CAST(N'2017-03-23T00:00:00.000' AS DateTime), N'boleta', 75)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (76, 3, 9, 1, CAST(N'2017-03-24T00:00:00.000' AS DateTime), N'boleta', 76)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (77, 2, 10, 3, CAST(N'2017-03-25T00:00:00.000' AS DateTime), N'boleta', 77)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (78, 3, 5, 2, CAST(N'2017-03-26T00:00:00.000' AS DateTime), N'boleta', 78)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (79, 5, 5, 2, CAST(N'2017-03-26T00:00:00.000' AS DateTime), N'boleta', 79)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (80, 4, 13, 3, CAST(N'2017-03-27T00:00:00.000' AS DateTime), N'boleta', 80)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (81, 3, 14, 2, CAST(N'2017-03-27T00:00:00.000' AS DateTime), N'boleta', 81)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (82, 6, 8, 1, CAST(N'2017-03-28T00:00:00.000' AS DateTime), N'boleta', 82)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (83, 4, 8, 1, CAST(N'2017-03-29T00:00:00.000' AS DateTime), N'factura', 83)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (84, 1, 14, 2, CAST(N'2017-03-31T00:00:00.000' AS DateTime), N'boleta', 84)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (85, 6, 2, 2, CAST(N'2017-03-31T00:00:00.000' AS DateTime), N'boleta', 85)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (86, 6, 6, 2, CAST(N'2017-04-01T00:00:00.000' AS DateTime), N'boleta', 86)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (87, 6, 5, 3, CAST(N'2017-04-03T00:00:00.000' AS DateTime), N'boleta', 87)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (88, 1, 4, 2, CAST(N'2017-04-03T00:00:00.000' AS DateTime), N'factura', 88)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (89, 5, 9, 3, CAST(N'2017-04-04T00:00:00.000' AS DateTime), N'boleta', 89)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (90, 5, 4, 2, CAST(N'2017-04-04T00:00:00.000' AS DateTime), N'boleta', 90)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (91, 5, 1, 1, CAST(N'2017-04-04T00:00:00.000' AS DateTime), N'boleta', 91)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (92, 2, 14, 2, CAST(N'2017-04-05T00:00:00.000' AS DateTime), N'factura', 92)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (93, 1, 1, 2, CAST(N'2017-04-06T00:00:00.000' AS DateTime), N'boleta', 93)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (94, 4, 3, 2, CAST(N'2017-04-06T00:00:00.000' AS DateTime), N'boleta', 94)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (95, 2, 18, 3, CAST(N'2017-04-08T00:00:00.000' AS DateTime), N'boleta', 95)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (96, 3, 8, 3, CAST(N'2017-04-08T00:00:00.000' AS DateTime), N'factura', 96)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (97, 1, 12, 3, CAST(N'2017-04-11T00:00:00.000' AS DateTime), N'boleta', 97)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (98, 4, 18, 3, CAST(N'2017-04-13T00:00:00.000' AS DateTime), N'boleta', 98)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (99, 5, 19, 3, CAST(N'2017-04-14T00:00:00.000' AS DateTime), N'boleta', 99)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (100, 3, 18, 1, CAST(N'2017-04-15T00:00:00.000' AS DateTime), N'boleta', 100)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (101, 3, 15, 3, CAST(N'2017-04-18T00:00:00.000' AS DateTime), N'boleta', 101)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (102, 1, 20, 3, CAST(N'2017-04-18T00:00:00.000' AS DateTime), N'boleta', 102)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (103, 5, 17, 2, CAST(N'2017-04-18T00:00:00.000' AS DateTime), N'boleta', 103)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (104, 1, 5, 3, CAST(N'2017-04-19T00:00:00.000' AS DateTime), N'factura', 104)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (105, 5, 3, 3, CAST(N'2017-04-19T00:00:00.000' AS DateTime), N'boleta', 105)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (106, 5, 6, 1, CAST(N'2017-04-20T00:00:00.000' AS DateTime), N'boleta', 106)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (107, 3, 6, 2, CAST(N'2017-04-20T00:00:00.000' AS DateTime), N'boleta', 107)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (108, 6, 16, 2, CAST(N'2017-04-21T00:00:00.000' AS DateTime), N'boleta', 108)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (109, 2, 3, 1, CAST(N'2017-04-21T00:00:00.000' AS DateTime), N'factura', 109)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (110, 3, 4, 1, CAST(N'2017-04-21T00:00:00.000' AS DateTime), N'boleta', 110)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (111, 4, 17, 1, CAST(N'2017-04-21T00:00:00.000' AS DateTime), N'boleta', 111)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (112, 3, 11, 2, CAST(N'2017-04-22T00:00:00.000' AS DateTime), N'boleta', 112)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (113, 5, 16, 1, CAST(N'2017-04-22T00:00:00.000' AS DateTime), N'boleta', 113)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (114, 3, 17, 1, CAST(N'2017-04-23T00:00:00.000' AS DateTime), N'factura', 114)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (115, 2, 16, 2, CAST(N'2017-04-24T00:00:00.000' AS DateTime), N'boleta', 115)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (116, 3, 11, 1, CAST(N'2017-04-24T00:00:00.000' AS DateTime), N'boleta', 116)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (117, 6, 15, 2, CAST(N'2017-04-25T00:00:00.000' AS DateTime), N'boleta', 117)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (118, 4, 9, 2, CAST(N'2017-04-25T00:00:00.000' AS DateTime), N'boleta', 118)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (119, 6, 10, 3, CAST(N'2017-04-27T00:00:00.000' AS DateTime), N'factura', 119)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (120, 1, 9, 2, CAST(N'2017-04-29T00:00:00.000' AS DateTime), N'boleta', 120)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (121, 4, 13, 2, CAST(N'2017-04-29T00:00:00.000' AS DateTime), N'boleta', 121)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (122, 1, 7, 1, CAST(N'2017-04-30T00:00:00.000' AS DateTime), N'boleta', 122)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (123, 5, 8, 2, CAST(N'2017-05-02T00:00:00.000' AS DateTime), N'boleta', 123)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (124, 6, 10, 2, CAST(N'2017-05-02T00:00:00.000' AS DateTime), N'boleta', 124)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (125, 2, 8, 1, CAST(N'2017-05-02T00:00:00.000' AS DateTime), N'boleta', 125)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (126, 3, 12, 1, CAST(N'2017-05-06T00:00:00.000' AS DateTime), N'boleta', 126)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (127, 3, 8, 3, CAST(N'2017-05-07T00:00:00.000' AS DateTime), N'boleta', 127)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (128, 2, 7, 1, CAST(N'2017-05-07T00:00:00.000' AS DateTime), N'boleta', 128)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (129, 1, 10, 3, CAST(N'2017-05-09T00:00:00.000' AS DateTime), N'factura', 129)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (130, 5, 16, 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'boleta', 130)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (131, 5, 11, 3, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'boleta', 131)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (132, 2, 19, 2, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'boleta', 132)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (133, 1, 7, 1, CAST(N'2017-05-11T00:00:00.000' AS DateTime), N'boleta', 133)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (134, 3, 18, 3, CAST(N'2017-05-12T00:00:00.000' AS DateTime), N'boleta', 134)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (135, 4, 19, 1, CAST(N'2017-05-14T00:00:00.000' AS DateTime), N'boleta', 135)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (136, 2, 4, 1, CAST(N'2017-05-15T00:00:00.000' AS DateTime), N'boleta', 136)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (137, 1, 3, 3, CAST(N'2017-05-17T00:00:00.000' AS DateTime), N'boleta', 137)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (138, 4, 5, 2, CAST(N'2017-05-21T00:00:00.000' AS DateTime), N'factura', 138)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (139, 1, 7, 1, CAST(N'2017-05-23T00:00:00.000' AS DateTime), N'boleta', 139)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (140, 1, 18, 2, CAST(N'2017-05-23T00:00:00.000' AS DateTime), N'boleta', 140)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (141, 3, 12, 1, CAST(N'2017-05-25T00:00:00.000' AS DateTime), N'boleta', 141)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (142, 1, 5, 2, CAST(N'2017-05-25T00:00:00.000' AS DateTime), N'boleta', 142)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (143, 4, 12, 1, CAST(N'2017-05-26T00:00:00.000' AS DateTime), N'factura', 143)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (144, 3, 20, 3, CAST(N'2017-05-27T00:00:00.000' AS DateTime), N'boleta', 144)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (145, 3, 16, 1, CAST(N'2017-05-27T00:00:00.000' AS DateTime), N'boleta', 145)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (146, 5, 11, 3, CAST(N'2017-05-28T00:00:00.000' AS DateTime), N'boleta', 146)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (147, 2, 10, 1, CAST(N'2017-05-28T00:00:00.000' AS DateTime), N'factura', 147)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (148, 3, 3, 3, CAST(N'2017-05-29T00:00:00.000' AS DateTime), N'boleta', 148)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (149, 4, 16, 3, CAST(N'2017-05-30T00:00:00.000' AS DateTime), N'boleta', 149)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (150, 4, 6, 3, CAST(N'2017-05-31T00:00:00.000' AS DateTime), N'boleta', 150)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (151, 6, 20, 2, CAST(N'2017-05-31T00:00:00.000' AS DateTime), N'factura', 151)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (152, 4, 3, 2, CAST(N'2017-06-02T00:00:00.000' AS DateTime), N'boleta', 152)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (153, 3, 17, 1, CAST(N'2017-06-02T00:00:00.000' AS DateTime), N'boleta', 153)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (154, 5, 5, 1, CAST(N'2017-06-03T00:00:00.000' AS DateTime), N'boleta', 154)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (155, 4, 20, 3, CAST(N'2017-06-03T00:00:00.000' AS DateTime), N'boleta', 155)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (156, 3, 11, 1, CAST(N'2017-06-03T00:00:00.000' AS DateTime), N'boleta', 156)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (157, 6, 14, 3, CAST(N'2017-06-05T00:00:00.000' AS DateTime), N'boleta', 157)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (158, 2, 18, 1, CAST(N'2017-06-06T00:00:00.000' AS DateTime), N'boleta', 158)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (159, 5, 4, 2, CAST(N'2017-06-06T00:00:00.000' AS DateTime), N'factura', 159)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (160, 6, 16, 2, CAST(N'2017-06-07T00:00:00.000' AS DateTime), N'boleta', 160)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (161, 3, 9, 1, CAST(N'2017-06-08T00:00:00.000' AS DateTime), N'boleta', 161)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (162, 6, 10, 3, CAST(N'2017-06-12T00:00:00.000' AS DateTime), N'boleta', 162)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (163, 3, 6, 1, CAST(N'2017-06-14T00:00:00.000' AS DateTime), N'boleta', 163)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (164, 4, 11, 3, CAST(N'2017-06-14T00:00:00.000' AS DateTime), N'factura', 164)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (165, 1, 16, 1, CAST(N'2017-06-14T00:00:00.000' AS DateTime), N'boleta', 165)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (166, 1, 10, 3, CAST(N'2017-06-15T00:00:00.000' AS DateTime), N'boleta', 166)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (167, 4, 11, 3, CAST(N'2017-06-16T00:00:00.000' AS DateTime), N'boleta', 167)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (168, 5, 17, 2, CAST(N'2017-06-16T00:00:00.000' AS DateTime), N'boleta', 168)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (169, 1, 9, 1, CAST(N'2017-06-17T00:00:00.000' AS DateTime), N'factura', 169)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (170, 1, 12, 3, CAST(N'2017-06-21T00:00:00.000' AS DateTime), N'boleta', 170)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (171, 1, 12, 2, CAST(N'2017-06-22T00:00:00.000' AS DateTime), N'boleta', 171)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (172, 1, 17, 2, CAST(N'2017-06-24T00:00:00.000' AS DateTime), N'boleta', 172)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (173, 5, 1, 1, CAST(N'2017-06-24T00:00:00.000' AS DateTime), N'boleta', 173)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (174, 3, 7, 1, CAST(N'2017-06-25T00:00:00.000' AS DateTime), N'factura', 174)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (175, 5, 10, 2, CAST(N'2017-06-27T00:00:00.000' AS DateTime), N'boleta', 175)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (176, 1, 18, 2, CAST(N'2017-06-28T00:00:00.000' AS DateTime), N'boleta', 176)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (177, 2, 16, 2, CAST(N'2017-06-28T00:00:00.000' AS DateTime), N'boleta', 177)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (178, 5, 19, 1, CAST(N'2017-06-29T00:00:00.000' AS DateTime), N'boleta', 178)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (179, 2, 7, 1, CAST(N'2017-06-29T00:00:00.000' AS DateTime), N'boleta', 179)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (180, 2, 11, 2, CAST(N'2017-06-29T00:00:00.000' AS DateTime), N'boleta', 180)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (181, 5, 18, 2, CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'boleta', 181)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (182, 6, 2, 1, CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'boleta', 182)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (183, 6, 1, 1, CAST(N'2017-07-01T00:00:00.000' AS DateTime), N'boleta', 183)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (184, 2, 16, 2, CAST(N'2017-07-02T00:00:00.000' AS DateTime), N'factura', 184)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (185, 6, 13, 3, CAST(N'2017-07-02T00:00:00.000' AS DateTime), N'boleta', 185)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (186, 4, 6, 2, CAST(N'2017-07-02T00:00:00.000' AS DateTime), N'boleta', 186)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (187, 1, 15, 3, CAST(N'2017-07-04T00:00:00.000' AS DateTime), N'boleta', 187)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (188, 3, 13, 3, CAST(N'2017-07-05T00:00:00.000' AS DateTime), N'boleta', 188)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (189, 2, 10, 1, CAST(N'2017-07-08T00:00:00.000' AS DateTime), N'boleta', 189)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (190, 5, 8, 1, CAST(N'2017-07-08T00:00:00.000' AS DateTime), N'boleta', 190)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (191, 6, 15, 2, CAST(N'2017-07-09T00:00:00.000' AS DateTime), N'boleta', 191)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (192, 3, 12, 2, CAST(N'2017-07-09T00:00:00.000' AS DateTime), N'boleta', 192)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (193, 1, 4, 3, CAST(N'2017-07-10T00:00:00.000' AS DateTime), N'factura', 193)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (194, 4, 4, 1, CAST(N'2017-07-10T00:00:00.000' AS DateTime), N'boleta', 194)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (195, 2, 14, 2, CAST(N'2017-07-10T00:00:00.000' AS DateTime), N'boleta', 195)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (196, 3, 6, 1, CAST(N'2017-07-11T00:00:00.000' AS DateTime), N'boleta', 196)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (197, 1, 13, 3, CAST(N'2017-07-13T00:00:00.000' AS DateTime), N'boleta', 197)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (198, 3, 19, 1, CAST(N'2017-07-14T00:00:00.000' AS DateTime), N'factura', 198)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (199, 6, 20, 3, CAST(N'2017-07-15T00:00:00.000' AS DateTime), N'boleta', 199)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (200, 2, 3, 1, CAST(N'2017-07-15T00:00:00.000' AS DateTime), N'boleta', 200)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (201, 5, 9, 1, CAST(N'2017-07-15T00:00:00.000' AS DateTime), N'boleta', 201)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (202, 2, 11, 1, CAST(N'2017-07-17T00:00:00.000' AS DateTime), N'factura', 202)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (203, 3, 4, 2, CAST(N'2017-07-19T00:00:00.000' AS DateTime), N'boleta', 203)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (204, 4, 8, 2, CAST(N'2017-07-19T00:00:00.000' AS DateTime), N'boleta', 204)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (205, 4, 3, 1, CAST(N'2017-07-19T00:00:00.000' AS DateTime), N'boleta', 205)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (206, 3, 12, 1, CAST(N'2017-07-20T00:00:00.000' AS DateTime), N'factura', 206)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (207, 6, 1, 1, CAST(N'2017-07-21T00:00:00.000' AS DateTime), N'boleta', 207)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (208, 5, 1, 1, CAST(N'2017-07-21T00:00:00.000' AS DateTime), N'boleta', 208)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (209, 6, 8, 3, CAST(N'2017-07-22T00:00:00.000' AS DateTime), N'boleta', 209)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (210, 5, 19, 3, CAST(N'2017-07-22T00:00:00.000' AS DateTime), N'boleta', 210)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (211, 6, 17, 1, CAST(N'2017-07-25T00:00:00.000' AS DateTime), N'boleta', 211)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (212, 3, 16, 1, CAST(N'2017-07-26T00:00:00.000' AS DateTime), N'boleta', 212)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (213, 2, 11, 1, CAST(N'2017-07-27T00:00:00.000' AS DateTime), N'boleta', 213)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (214, 1, 9, 3, CAST(N'2017-07-27T00:00:00.000' AS DateTime), N'factura', 214)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (215, 6, 7, 3, CAST(N'2017-07-28T00:00:00.000' AS DateTime), N'boleta', 215)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (216, 6, 6, 2, CAST(N'2017-07-28T00:00:00.000' AS DateTime), N'boleta', 216)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (217, 4, 15, 2, CAST(N'2017-07-28T00:00:00.000' AS DateTime), N'boleta', 217)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (218, 3, 3, 2, CAST(N'2017-07-28T00:00:00.000' AS DateTime), N'boleta', 218)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (219, 3, 10, 1, CAST(N'2017-07-29T00:00:00.000' AS DateTime), N'factura', 219)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (220, 5, 5, 3, CAST(N'2017-07-29T00:00:00.000' AS DateTime), N'boleta', 220)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (221, 2, 10, 3, CAST(N'2017-07-31T00:00:00.000' AS DateTime), N'boleta', 221)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (222, 1, 8, 1, CAST(N'2017-08-01T00:00:00.000' AS DateTime), N'boleta', 222)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (223, 3, 11, 1, CAST(N'2017-08-02T00:00:00.000' AS DateTime), N'boleta', 223)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (224, 2, 2, 2, CAST(N'2017-08-03T00:00:00.000' AS DateTime), N'factura', 224)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (225, 4, 12, 1, CAST(N'2017-08-03T00:00:00.000' AS DateTime), N'boleta', 225)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (226, 2, 14, 1, CAST(N'2017-08-04T00:00:00.000' AS DateTime), N'boleta', 226)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (227, 1, 17, 1, CAST(N'2017-08-05T00:00:00.000' AS DateTime), N'boleta', 227)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (228, 2, 16, 3, CAST(N'2017-08-06T00:00:00.000' AS DateTime), N'boleta', 228)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (229, 6, 4, 3, CAST(N'2017-08-06T00:00:00.000' AS DateTime), N'factura', 229)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (230, 1, 17, 2, CAST(N'2017-08-06T00:00:00.000' AS DateTime), N'boleta', 230)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (231, 2, 7, 3, CAST(N'2017-08-07T00:00:00.000' AS DateTime), N'boleta', 231)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (232, 5, 8, 2, CAST(N'2017-08-09T00:00:00.000' AS DateTime), N'boleta', 232)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (233, 4, 14, 1, CAST(N'2017-08-09T00:00:00.000' AS DateTime), N'boleta', 233)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (234, 3, 7, 2, CAST(N'2017-08-10T00:00:00.000' AS DateTime), N'boleta', 234)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (235, 2, 19, 2, CAST(N'2017-08-10T00:00:00.000' AS DateTime), N'boleta', 235)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (236, 6, 17, 3, CAST(N'2017-08-11T00:00:00.000' AS DateTime), N'boleta', 236)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (237, 2, 2, 1, CAST(N'2017-08-11T00:00:00.000' AS DateTime), N'boleta', 237)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (238, 1, 7, 3, CAST(N'2017-08-13T00:00:00.000' AS DateTime), N'boleta', 238)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (239, 6, 10, 1, CAST(N'2017-08-13T00:00:00.000' AS DateTime), N'factura', 239)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (240, 3, 8, 3, CAST(N'2017-08-13T00:00:00.000' AS DateTime), N'boleta', 240)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (241, 3, 1, 1, CAST(N'2017-08-14T00:00:00.000' AS DateTime), N'boleta', 241)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (242, 4, 8, 2, CAST(N'2017-08-14T00:00:00.000' AS DateTime), N'boleta', 242)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (243, 2, 18, 2, CAST(N'2017-08-15T00:00:00.000' AS DateTime), N'boleta', 243)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (244, 6, 16, 1, CAST(N'2017-08-15T00:00:00.000' AS DateTime), N'boleta', 244)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (245, 2, 12, 3, CAST(N'2017-08-15T00:00:00.000' AS DateTime), N'boleta', 245)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (246, 5, 5, 1, CAST(N'2017-08-16T00:00:00.000' AS DateTime), N'boleta', 246)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (247, 4, 18, 1, CAST(N'2017-08-16T00:00:00.000' AS DateTime), N'boleta', 247)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (248, 4, 2, 2, CAST(N'2017-08-17T00:00:00.000' AS DateTime), N'factura', 248)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (249, 6, 14, 3, CAST(N'2017-08-19T00:00:00.000' AS DateTime), N'boleta', 249)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (250, 6, 18, 1, CAST(N'2017-08-19T00:00:00.000' AS DateTime), N'boleta', 250)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (251, 4, 5, 1, CAST(N'2017-08-20T00:00:00.000' AS DateTime), N'boleta', 251)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (252, 2, 11, 3, CAST(N'2017-08-21T00:00:00.000' AS DateTime), N'boleta', 252)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (253, 4, 7, 1, CAST(N'2017-08-22T00:00:00.000' AS DateTime), N'factura', 253)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (254, 5, 6, 1, CAST(N'2017-08-26T00:00:00.000' AS DateTime), N'boleta', 254)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (255, 1, 2, 1, CAST(N'2017-08-28T00:00:00.000' AS DateTime), N'boleta', 255)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (256, 4, 6, 1, CAST(N'2017-08-28T00:00:00.000' AS DateTime), N'boleta', 256)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (257, 2, 17, 3, CAST(N'2017-08-28T00:00:00.000' AS DateTime), N'factura', 257)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (258, 6, 9, 3, CAST(N'2017-08-29T00:00:00.000' AS DateTime), N'boleta', 258)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (259, 6, 10, 1, CAST(N'2017-08-30T00:00:00.000' AS DateTime), N'boleta', 259)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (260, 2, 1, 3, CAST(N'2017-09-01T00:00:00.000' AS DateTime), N'boleta', 260)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (261, 4, 19, 2, CAST(N'2017-09-07T00:00:00.000' AS DateTime), N'factura', 261)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (262, 6, 18, 2, CAST(N'2017-09-07T00:00:00.000' AS DateTime), N'boleta', 262)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (263, 1, 6, 3, CAST(N'2017-09-10T00:00:00.000' AS DateTime), N'boleta', 263)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (264, 6, 20, 1, CAST(N'2017-09-11T00:00:00.000' AS DateTime), N'boleta', 264)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (265, 4, 6, 2, CAST(N'2017-09-12T00:00:00.000' AS DateTime), N'boleta', 265)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (266, 4, 3, 3, CAST(N'2017-09-13T00:00:00.000' AS DateTime), N'boleta', 266)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (267, 4, 16, 1, CAST(N'2017-09-13T00:00:00.000' AS DateTime), N'boleta', 267)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (268, 1, 9, 3, CAST(N'2017-09-16T00:00:00.000' AS DateTime), N'boleta', 268)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (269, 4, 7, 2, CAST(N'2017-09-17T00:00:00.000' AS DateTime), N'factura', 269)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (270, 2, 18, 1, CAST(N'2017-09-19T00:00:00.000' AS DateTime), N'boleta', 270)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (271, 6, 6, 1, CAST(N'2017-09-19T00:00:00.000' AS DateTime), N'boleta', 271)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (272, 6, 9, 2, CAST(N'2017-09-20T00:00:00.000' AS DateTime), N'boleta', 272)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (273, 1, 4, 2, CAST(N'2017-09-21T00:00:00.000' AS DateTime), N'boleta', 273)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (274, 6, 9, 1, CAST(N'2017-09-21T00:00:00.000' AS DateTime), N'factura', 274)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (275, 5, 3, 2, CAST(N'2017-09-26T00:00:00.000' AS DateTime), N'boleta', 275)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (276, 5, 6, 2, CAST(N'2017-09-26T00:00:00.000' AS DateTime), N'boleta', 276)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (277, 3, 15, 1, CAST(N'2017-09-27T00:00:00.000' AS DateTime), N'boleta', 277)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (278, 5, 2, 1, CAST(N'2017-09-27T00:00:00.000' AS DateTime), N'boleta', 278)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (279, 5, 10, 2, CAST(N'2017-09-27T00:00:00.000' AS DateTime), N'factura', 279)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (280, 2, 19, 2, CAST(N'2017-10-01T00:00:00.000' AS DateTime), N'boleta', 280)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (281, 3, 5, 3, CAST(N'2017-10-02T00:00:00.000' AS DateTime), N'boleta', 281)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (282, 5, 8, 2, CAST(N'2017-10-04T00:00:00.000' AS DateTime), N'boleta', 282)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (283, 6, 13, 2, CAST(N'2017-10-04T00:00:00.000' AS DateTime), N'boleta', 283)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (284, 4, 2, 3, CAST(N'2017-10-04T00:00:00.000' AS DateTime), N'factura', 284)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (285, 2, 4, 1, CAST(N'2017-10-04T00:00:00.000' AS DateTime), N'boleta', 285)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (286, 1, 1, 2, CAST(N'2017-10-07T00:00:00.000' AS DateTime), N'boleta', 286)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (287, 4, 9, 2, CAST(N'2017-10-07T00:00:00.000' AS DateTime), N'boleta', 287)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (288, 1, 9, 3, CAST(N'2017-10-10T00:00:00.000' AS DateTime), N'boleta', 288)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (289, 5, 8, 2, CAST(N'2017-10-10T00:00:00.000' AS DateTime), N'boleta', 289)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (290, 2, 20, 1, CAST(N'2017-10-13T00:00:00.000' AS DateTime), N'boleta', 290)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (291, 3, 13, 3, CAST(N'2017-10-14T00:00:00.000' AS DateTime), N'boleta', 291)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (292, 5, 17, 3, CAST(N'2017-10-18T00:00:00.000' AS DateTime), N'boleta', 292)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (293, 1, 12, 2, CAST(N'2017-10-19T00:00:00.000' AS DateTime), N'boleta', 293)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (294, 1, 6, 3, CAST(N'2017-10-19T00:00:00.000' AS DateTime), N'factura', 294)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (295, 3, 13, 3, CAST(N'2017-10-20T00:00:00.000' AS DateTime), N'boleta', 295)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (296, 6, 11, 2, CAST(N'2017-10-20T00:00:00.000' AS DateTime), N'boleta', 296)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (297, 5, 11, 3, CAST(N'2017-10-21T00:00:00.000' AS DateTime), N'boleta', 297)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (298, 4, 18, 3, CAST(N'2017-10-21T00:00:00.000' AS DateTime), N'boleta', 298)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (299, 4, 5, 3, CAST(N'2017-10-22T00:00:00.000' AS DateTime), N'boleta', 299)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (300, 2, 9, 2, CAST(N'2017-10-22T00:00:00.000' AS DateTime), N'boleta', 300)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (301, 5, 4, 1, CAST(N'2017-10-24T00:00:00.000' AS DateTime), N'boleta', 301)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (302, 6, 13, 1, CAST(N'2017-10-25T00:00:00.000' AS DateTime), N'boleta', 302)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (303, 3, 18, 3, CAST(N'2017-10-26T00:00:00.000' AS DateTime), N'factura', 303)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (304, 4, 20, 1, CAST(N'2017-10-27T00:00:00.000' AS DateTime), N'boleta', 304)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (305, 5, 5, 2, CAST(N'2017-10-28T00:00:00.000' AS DateTime), N'boleta', 305)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (306, 5, 2, 1, CAST(N'2017-10-29T00:00:00.000' AS DateTime), N'boleta', 306)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (307, 6, 13, 1, CAST(N'2017-10-29T00:00:00.000' AS DateTime), N'boleta', 307)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (308, 6, 6, 1, CAST(N'2017-10-30T00:00:00.000' AS DateTime), N'factura', 308)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (309, 2, 19, 3, CAST(N'2017-10-30T00:00:00.000' AS DateTime), N'boleta', 309)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (310, 1, 17, 3, CAST(N'2017-10-31T00:00:00.000' AS DateTime), N'boleta', 310)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (311, 3, 4, 1, CAST(N'2017-10-31T00:00:00.000' AS DateTime), N'boleta', 311)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (312, 3, 2, 1, CAST(N'2017-10-31T00:00:00.000' AS DateTime), N'factura', 312)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (313, 2, 4, 1, CAST(N'2017-11-01T00:00:00.000' AS DateTime), N'boleta', 313)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (314, 5, 16, 1, CAST(N'2017-11-02T00:00:00.000' AS DateTime), N'boleta', 314)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (315, 3, 8, 1, CAST(N'2017-11-04T00:00:00.000' AS DateTime), N'boleta', 315)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (316, 4, 17, 3, CAST(N'2017-11-04T00:00:00.000' AS DateTime), N'factura', 316)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (317, 5, 14, 2, CAST(N'2017-11-05T00:00:00.000' AS DateTime), N'boleta', 317)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (318, 1, 4, 3, CAST(N'2017-11-06T00:00:00.000' AS DateTime), N'boleta', 318)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (319, 3, 9, 2, CAST(N'2017-11-06T00:00:00.000' AS DateTime), N'boleta', 319)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (320, 4, 16, 2, CAST(N'2017-11-10T00:00:00.000' AS DateTime), N'boleta', 320)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (321, 1, 17, 1, CAST(N'2017-11-10T00:00:00.000' AS DateTime), N'boleta', 321)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (322, 6, 5, 2, CAST(N'2017-11-14T00:00:00.000' AS DateTime), N'boleta', 322)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (323, 1, 2, 1, CAST(N'2017-11-15T00:00:00.000' AS DateTime), N'boleta', 323)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (324, 3, 10, 3, CAST(N'2017-11-15T00:00:00.000' AS DateTime), N'factura', 324)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (325, 3, 13, 2, CAST(N'2017-11-18T00:00:00.000' AS DateTime), N'boleta', 325)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (326, 6, 20, 2, CAST(N'2017-11-19T00:00:00.000' AS DateTime), N'boleta', 326)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (327, 3, 3, 3, CAST(N'2017-11-20T00:00:00.000' AS DateTime), N'boleta', 327)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (328, 4, 15, 2, CAST(N'2017-11-20T00:00:00.000' AS DateTime), N'boleta', 328)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (329, 2, 4, 2, CAST(N'2017-11-22T00:00:00.000' AS DateTime), N'factura', 329)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (330, 4, 11, 3, CAST(N'2017-11-22T00:00:00.000' AS DateTime), N'boleta', 330)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (331, 1, 6, 2, CAST(N'2017-11-24T00:00:00.000' AS DateTime), N'boleta', 331)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (332, 2, 5, 2, CAST(N'2017-11-26T00:00:00.000' AS DateTime), N'boleta', 332)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (333, 6, 20, 3, CAST(N'2017-11-28T00:00:00.000' AS DateTime), N'boleta', 333)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (334, 6, 10, 3, CAST(N'2017-12-01T00:00:00.000' AS DateTime), N'factura', 334)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (335, 2, 16, 3, CAST(N'2017-12-01T00:00:00.000' AS DateTime), N'boleta', 335)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (336, 2, 6, 2, CAST(N'2017-12-03T00:00:00.000' AS DateTime), N'boleta', 336)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (337, 6, 20, 1, CAST(N'2017-12-03T00:00:00.000' AS DateTime), N'boleta', 337)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (338, 2, 8, 1, CAST(N'2017-12-04T00:00:00.000' AS DateTime), N'boleta', 338)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (339, 2, 15, 1, CAST(N'2017-12-05T00:00:00.000' AS DateTime), N'factura', 339)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (340, 3, 11, 3, CAST(N'2017-12-05T00:00:00.000' AS DateTime), N'boleta', 340)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (341, 1, 15, 1, CAST(N'2017-12-06T00:00:00.000' AS DateTime), N'boleta', 341)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (342, 6, 19, 1, CAST(N'2017-12-06T00:00:00.000' AS DateTime), N'boleta', 342)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (343, 6, 17, 2, CAST(N'2017-12-12T00:00:00.000' AS DateTime), N'boleta', 343)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (344, 2, 11, 3, CAST(N'2017-12-15T00:00:00.000' AS DateTime), N'boleta', 344)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (345, 3, 5, 2, CAST(N'2017-12-15T00:00:00.000' AS DateTime), N'boleta', 345)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (346, 5, 13, 3, CAST(N'2017-12-16T00:00:00.000' AS DateTime), N'boleta', 346)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (347, 6, 13, 3, CAST(N'2017-12-16T00:00:00.000' AS DateTime), N'boleta', 347)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (348, 2, 6, 1, CAST(N'2017-12-16T00:00:00.000' AS DateTime), N'boleta', 348)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (349, 3, 7, 2, CAST(N'2017-12-17T00:00:00.000' AS DateTime), N'factura', 349)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (350, 2, 17, 3, CAST(N'2017-12-17T00:00:00.000' AS DateTime), N'boleta', 350)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (351, 5, 20, 1, CAST(N'2017-12-18T00:00:00.000' AS DateTime), N'boleta', 351)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (352, 4, 3, 1, CAST(N'2017-12-19T00:00:00.000' AS DateTime), N'boleta', 352)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (353, 1, 7, 1, CAST(N'2017-12-20T00:00:00.000' AS DateTime), N'boleta', 353)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (354, 5, 20, 1, CAST(N'2017-12-21T00:00:00.000' AS DateTime), N'boleta', 354)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (355, 5, 17, 2, CAST(N'2017-12-22T00:00:00.000' AS DateTime), N'boleta', 355)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (356, 4, 14, 1, CAST(N'2017-12-23T00:00:00.000' AS DateTime), N'boleta', 356)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (357, 6, 4, 1, CAST(N'2017-12-25T00:00:00.000' AS DateTime), N'boleta', 357)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (358, 3, 4, 1, CAST(N'2017-12-26T00:00:00.000' AS DateTime), N'factura', 358)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (359, 1, 9, 1, CAST(N'2017-12-26T00:00:00.000' AS DateTime), N'boleta', 359)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (360, 3, 4, 2, CAST(N'2017-12-27T00:00:00.000' AS DateTime), N'boleta', 360)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (361, 3, 8, 2, CAST(N'2017-12-27T00:00:00.000' AS DateTime), N'boleta', 361)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (362, 4, 16, 3, CAST(N'2017-12-28T00:00:00.000' AS DateTime), N'boleta', 362)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (363, 3, 3, 2, CAST(N'2017-12-28T00:00:00.000' AS DateTime), N'factura', 363)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (364, 6, 10, 1, CAST(N'2017-12-29T00:00:00.000' AS DateTime), N'boleta', 364)
GO
INSERT [dbo].[ventas] ([venta_id], [vendedor_id], [cliente_id], [sucursal_id], [fecha], [tipo_documento], [numero_documento]) VALUES (365, 1, 18, 1, CAST(N'2017-12-30T00:00:00.000' AS DateTime), N'boleta', 365)
GO
ALTER TABLE [dbo].[detalle_ventas]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ventas_productos] FOREIGN KEY([producto_id])
REFERENCES [dbo].[productos] ([producto_id])
GO
ALTER TABLE [dbo].[detalle_ventas] CHECK CONSTRAINT [FK_detalle_ventas_productos]
GO
ALTER TABLE [dbo].[detalle_ventas]  WITH CHECK ADD  CONSTRAINT [FK_detalle_ventas_ventas] FOREIGN KEY([venta_id])
REFERENCES [dbo].[ventas] ([venta_id])
GO
ALTER TABLE [dbo].[detalle_ventas] CHECK CONSTRAINT [FK_detalle_ventas_ventas]
GO
ALTER TABLE [dbo].[empleados]  WITH CHECK ADD  CONSTRAINT [FK_empleados_cargos] FOREIGN KEY([cargo_id])
REFERENCES [dbo].[cargos] ([cargo_id])
GO
ALTER TABLE [dbo].[empleados] CHECK CONSTRAINT [FK_empleados_cargos]
GO
ALTER TABLE [dbo].[productos]  WITH CHECK ADD  CONSTRAINT [FK_productos_categorias] FOREIGN KEY([categoria_id])
REFERENCES [dbo].[categorias] ([categoria_id])
GO
ALTER TABLE [dbo].[productos] CHECK CONSTRAINT [FK_productos_categorias]
GO
ALTER TABLE [dbo].[sucursales]  WITH CHECK ADD  CONSTRAINT [FK_sucursales_comunas] FOREIGN KEY([comuna_id])
REFERENCES [dbo].[comunas] ([comuna_id])
GO
ALTER TABLE [dbo].[sucursales] CHECK CONSTRAINT [FK_sucursales_comunas]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_ventas_clientes] FOREIGN KEY([cliente_id])
REFERENCES [dbo].[clientes] ([cliente_id])
GO
ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_ventas_clientes]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_ventas_empleados] FOREIGN KEY([vendedor_id])
REFERENCES [dbo].[empleados] ([empleado_id])
GO
ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_ventas_empleados]
GO
ALTER TABLE [dbo].[ventas]  WITH CHECK ADD  CONSTRAINT [FK_ventas_sucursales] FOREIGN KEY([sucursal_id])
REFERENCES [dbo].[sucursales] ([sucursal_id])
GO
ALTER TABLE [dbo].[ventas] CHECK CONSTRAINT [FK_ventas_sucursales]
GO
USE [master]
GO
ALTER DATABASE [Albarran] SET  READ_WRITE 
GO
