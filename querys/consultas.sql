USE produccion
GO
-- Select rows from a Table or View 'maquina' in schema 'maq'
SELECT * FROM maq.maquina
--WHERE 	/* add search conditions here */
GO

-- Select rows from a Table or View 'bodega' in schema 'edi'
SELECT * FROM edi.bodega
--WHERE 	/* add search conditions here */
GO

CREATE VIEW pro.vCategorias as
-- Select rows from a Table or View 'Categorias' in schema 'pro'
SELECT c.id,c.nombre categoia,p.nombre producto FROM pro.categorias c
LEFT JOIN pro.productos p on c.id=p.categoriaId
--WHERE 	/* add search conditions here */
GO

-- Create a new stored procedure called 'spCumplimientoTurnos' in schema 'pro'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
  FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'pro'
  AND SPECIFIC_NAME = N'spCumplimientoTurnos'
)
DROP PROCEDURE pro.spCumplimientoTurnos
GO
-- Create the stored procedure in the specified schema
CREATE PROCEDURE pro.spCumplimientoTurnos
  @orden /*parameter name*/ int /*datatype_for_param1*/ = 0 /*default_value_for_param1*/
--  @param2 /*parameter name*/ int /*datatype_for_param1*/ = 0 /*default_value_for_param2*/
-- add more stored procedure parameters here
AS
  -- body of the stored procedure
  DECLARE @total FLOAT
  SELECT @total=sum(cantidad) FROM pro.ordenes WHERE id=@orden
  print @total
  SELECT t.id turnos,m.descripcion maquina,cantidadProduccion, @total total,cantidadProduccion/@total*100 [Porcentaje] FROM pro.turnos t
  inner JOIN maq.maquinas m on t.maquinaId=m.id
  WHERE ordenId=@orden

GO
-- example to execute the stored procedure we just created
EXECUTE pro.spCumplimientoTurnos 2 /*value_for_param1*/
GO
