USE produccion
GO

SELECT *
FROM maq.maquinas
GO

SELECT *
FROM pro.turnos
GO

SELECT *
FROM pro.ordenes
GO

IF EXISTS (
SELECT *
FROM sys.views
  JOIN sys.schemas
  ON sys.views.schema_id = sys.schemas.schema_id
WHERE sys.schemas.name = N'pro'
  AND sys.views.name = N'vProductosMaquina'
)

DROP VIEW pro.vProductosMaquina
GO
CREATE VIEW pro.vProductosMaquina
AS
  SELECT maquinaId, SUM
(cantidadProduccion) as 'Cantidad producida'
  FROM pro.turnos
    JOIN maq.maquinas on maquinas.id = turnos.maquinaId
  WHERE turnos.maquinaId = maquinas.id
  GROUP BY maquinaId
GO

SELECT *
FROM pro.vProductosMaquina
GO
