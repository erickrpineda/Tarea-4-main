-- Create a new database called 'produccion'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Drop the new database if it's exist already
IF EXISTS (
  SELECT name
    FROM sys.databases
    WHERE name = N'produccion'
)
DROP DATABASE produccion
GO
--Create new database 'produccion'
CREATE DATABASE produccion
GO
--Seleccionar la base de datos 'produccion'
USE produccion
GO
CREATE SCHEMA maq
GO
CREATE SCHEMA pro
GO
CREATE SCHEMA rrh
GO
-- Create a new table called 'maquinas' in schema 'maq'
-- Drop the table if it already exists
IF OBJECT_ID('maq.maquinas', 'U') IS NOT NULL
DROP TABLE maq.maquinas
GO
-- Create the table in the specified schema
CREATE TABLE maq.maquinas
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  descripcion [NVARCHAR](250) NOT NULL,
  CONSTRAINT pkMaquinas PRIMARY KEY(id)
  -- specify more columns here
);
GO

-- Create a new table called 'categorias' in schema 'pro'
-- Drop the table if it already exists
IF OBJECT_ID('pro.categorias', 'U') IS NOT NULL
DROP TABLE pro.categorias
GO
-- Create the table in the specified schema
CREATE TABLE pro.categorias
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  nombre [NVARCHAR](250) NOT NULL,
  CONSTRAINT pkcategorias PRIMARY KEY(id)
  -- specify more columns here
);
GO
GO
-- Create a new table called 'productos' in schema 'pro'
-- Drop the table if it already exists
IF OBJECT_ID('pro.productos', 'U') IS NOT NULL
DROP TABLE pro.productos
GO
-- Create the table in the specified schema
CREATE TABLE pro.productos
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  nombre [NVARCHAR](250) NOT NULL,
  observacion [NVARCHAR](max) NULL,
  categoriaId [INT] NOT NULL,
  CONSTRAINT pkproductos PRIMARY KEY(id),
  CONSTRAINT fkCategoriaproductos FOREIGN KEY(categoriaId) REFERENCES pro.categorias(id)
  -- specify more columns here
);
GO
-- Create a new table called 'horarios' in schema 'rrh'
-- Drop the table if it already exists
IF OBJECT_ID('rrh.horarios', 'U') IS NOT NULL
DROP TABLE rrh.horarios
GO
-- Create the table in the specified schema
CREATE TABLE rrh.horarios
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  nombre [NVARCHAR](50) NOT NULL,
  inicio [TIME] NULL,
  final [TIME] NULL,
  observacion [NVARCHAR](max) NULL,
  CONSTRAINT pkHorarios PRIMARY KEY(id)
  -- specify more columns here
);
GO
GO
-- Create a new table called 'ordenes' in schema 'pro'
-- Drop the table if it already exists
IF OBJECT_ID('pro.ordenes', 'U') IS NOT NULL
DROP TABLE pro.ordenes
GO
-- Create the table in the specified schema
CREATE TABLE pro.ordenes
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  fecha [DATE] NOT NULL,
  productoId [INT] NOT NULL,
  cantidad [INT] NOT NULL,
  observaciones [NVARCHAR](max) NULL,
  CONSTRAINT pkOrdenes PRIMARY KEY(id),
  CONSTRAINT fkOrdenesproductos FOREIGN KEY(productoId) REFERENCES pro.productos(id),
  CONSTRAINT ckCantidad CHECK(cantidad>0)
  -- specify more columns here
);
GO
-- Create a new table called 'usuarios' in schema 'rrh'
-- Drop the table if it already exists
IF OBJECT_ID('rrh.usuarios', 'U') IS NOT NULL
DROP TABLE rrh.usuarios
GO
-- Create the table in the specified schema
CREATE TABLE rrh.usuarios
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  name [NVARCHAR](250) NOT NULL,
  password [NVARCHAR](250) NOT NULL,
  CONSTRAINT pkUsuarios PRIMARY KEY(id),
  -- specify more columns here
);
GO
-- Create a new table called 'turnos' in schema 'pro'
-- Drop the table if it already exists
IF OBJECT_ID('pro.turnos', 'U') IS NOT NULL
DROP TABLE pro.turnos
GO
-- Create the table in the specified schema
CREATE TABLE pro.turnos
(
  id INT NOT NULL IDENTITY(1,1), -- primary key column
  maquinaId [INT] NOT NULL,
  ordenId [INT] NOT NULL,
  usuarioId [INT] NOT NULL,
  horarioId [INT] NOT NULL,
  fecha [DATE] NOT NULL,
  cantidadProduccion [int] NOT NULL,
  CONSTRAINT pkTurnos PRIMARY KEY(id),
  CONSTRAINT fkMaquinaTurnos FOREIGN KEY(maquinaId) REFERENCES maq.maquinas(id),
  CONSTRAINT fkOrdenTurnos FOREIGN KEY(ordenId) REFERENCES pro.ordenes(id),
  CONSTRAINT fkUsuariosTurnos FOREIGN KEY(usuarioId) REFERENCES rrh.usuarios(id),
  CONSTRAINT fkHorariosTurnos FOREIGN KEY(horarioId) REFERENCES rrh.horarios(id),
  -- specify more columns here
);
GO
