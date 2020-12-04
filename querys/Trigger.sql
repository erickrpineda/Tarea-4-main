use master
go
drop database facturacion
go
Create database facturacion
go
use facturacion

Create table factura(
id int identity(1,1) not null,
cliente varchar(250) null,
fecha date null default getdate(),
total float null default 0,
constraint pkFactura primary key(id),
constraint chkTotal check(total>=0)
)
go
create table detalleFactura(
id int not null identity(1,1),
facturaId int not null,
producto varchar(250),
cantidad int not null,
precio float not null,
constraint pkDetalleFactura primary key(id),
constraint fkFacturaDetalle foreign key(facturaId) references Factura(id),
constraint chkCantidad check(cantidad>=0), 
constraint chkPrecio check(precio>=0)
)
-- INSERT, UPDATE, DELETE
-- ON TABLE
-- BEFORE, AFTER

--TRIGGER INSERT
go
CREATE TRIGGER trgDetalleFactura_insert
on DetalleFactura
AFTER
INSERT
as
BEGIN
declare @totalanterior float
declare @id int

select @id=facturaId from inserted

select @totalanterior = total from factura where id=@id

update factura set total=@totalanterior+(i.cantidad*i.precio) from factura f
inner join inserted i on i.facturaId=f.id

--update
--delete
--select * from factura f
--inner join detalleFactura df on f.id=df.facturaId
END
go

--TRIGGER DELETE
CREATE TRIGGER trgDetalleFactura_delete
on DetalleFactura
AFTER
DELETE
as
BEGIN
declare @totalanterior float
declare @id int

select @id=facturaId from deleted

select @totalanterior = total from factura where id=@id

update factura set total=@totalanterior-(i.cantidad*i.precio) from factura f
inner join deleted i on i.facturaId=f.id
END
go
--TRIGGER UPDATE
CREATE TRIGGER trgDetalleFactura_update
on DetalleFactura
AFTER
UPDATE
as
BEGIN
declare @totalanterior float
declare @id int
select @id=facturaId from deleted

select @totalanterior = total from factura where id=@id

update factura set total=@totalanterior-(i.cantidad*i.precio) from factura f
inner join deleted i on i.facturaId=f.id

select @totalanterior = total from factura where id=@id

update factura set total=@totalanterior+(i.cantidad*i.precio) from factura f
inner join inserted i on i.facturaId=f.id
END

insert into factura(cliente,fecha,total)
values('Diego',default,default)
go
insert into factura(cliente,fecha,total)
values('Hugo',default,default)
go
insert into factura(cliente,fecha,total)
values('Valeria',default,default)



insert into detalleFactura(facturaId,producto,cantidad,precio)
values(1,'Tomates',2,10)
go
insert into detalleFactura(facturaId,producto,cantidad,precio)
values(1,'Guineos',5,2)
go
insert into detalleFactura(facturaId,producto,cantidad,precio)
values(1,'Lechuga',6,4)
go
insert into detalleFactura(facturaId,producto,cantidad,precio)
values(2,'Papas',5,3)

select * from factura
select * from detalleFactura

--update detalleFactura set cantidad=1 where id=1