USE produccion
GO
-- Insert rows into table 'maq.maquinas'
INSERT INTO maq.maquinas
( -- columns to insert data into
 [descripcion]
)
VALUES
( -- first row: values for the columns in the list above
 'Maquina 1'
),
( -- second row: values for the columns in the list above
 'Maquina 2'
),
-- add more rows here
('Maquina 3'),
('Maquina 4')
GO
-- Insert rows into table 'pro.categorias'
INSERT INTO pro.categorias
( -- columns to insert data into
 [nombre]
)
VALUES
( -- first row: values for the columns in the list above
 'Bebidas'
),
( -- second row: values for the columns in the list above
 'Golosinas'
),
(
 'Dulces'
)
-- add more rows here
GO
-- Insert rows into table 'pro.productos'
INSERT INTO pro.productos
( -- columns to insert data into
 [nombre],[categoriaId]
)
VALUES
( -- first row: values for the columns in the list above
 'Churros',2
),
( -- second row: values for the columns in the list above
'Galletas',2
),
(
'Confites',3
),
(
'Jugos',1
)
-- add more rows here
GO
-- Insert rows into table 'rrh.horarios'
INSERT INTO rrh.horarios
( -- columns to insert data into
 [nombre], [inicio], [final]
)
VALUES
( -- first row: values for the columns in the list above
 'Horario 1', '12:01','00:00'
),
( -- second row: values for the columns in the list above
 'Horario 2','00:01','12:00'
)
-- add more rows here
GO
-- Insert rows into table 'rrh.usuarios'
INSERT INTO rrh.usuarios
( -- columns to insert data into
 [name], [password]
)
VALUES
( -- first row: values for the columns in the list above
 'user 1','123456'
),
( -- second row: values for the columns in the list above
 'user 2','654321'
)
-- add more rows here
GO
-- Insert rows into table 'pro.ordenes'
INSERT INTO pro.ordenes
( -- columns to insert data into
 [fecha], [productoId], [cantidad]
)
VALUES
( -- first row: values for the columns in the list above
 '20201101',1,100
),
( -- second row: values for the columns in the list above
 '20201102',2,200
),
(
 '20201103',3,500
),
(
 '20201104',1,300
),
(
 '20201105',4,600
),
(
 '20201106',2,350
),
(
 '20201107',3,820
)
GO
-- Insert rows into table 'pro.turnos'
INSERT INTO pro.turnos
( -- columns to insert data into
 [maquinaId], [ordenId], [usuarioId],[horarioId],[fecha],[cantidadProduccion]
)
VALUES
( -- first row: values for the columns in the list above
 1, 1, 1,1,'20201107',50
),
( -- second row: values for the columns in the list above
 2,1,2,2,'20201107',30
),
(
2,2,1,1,'20201108',60
),
(
4,3,2,1,'20201108',40
),
(
3,2,1,2,'20201109',60
)
GO
-- add more rows here
GO
