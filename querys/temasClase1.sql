use Pesaje
go
select 
--*
mp.descripcion,
AVG(peso_entrada-peso_salida) PROMEDIO,
SUM(peso_entrada-peso_salida) SUMATORIA --PROMEDIO
--COUNT(b.placavehiculo) [Cantidad Vehiculos]
from boletas b
inner join materiaprima mp on b.materiaprimaid=mp.materiaprimaid
WHERE mp.estadoid>100
GROUP BY mp.descripcion
HAVING COUNT(b.placavehiculo)>100
--EstacionPesaje PalmaAfricana-->Bascula peso entrada y peso de salida


select fechahoraingreso, 
CONVERT(varchar(20),fechahoraingreso,107) FechaC 
from boletas

select 'Modelo='+CAST(tipovehiculoid as varchar(4)) Tipo, *
from vehiculos

select DATENAME(MONTH,fechahoraingreso) NombreMes,
DATEPART(year,
	dateadd(year,4,fechahoraingreso)
) NombreYear,
fechahoraingreso from boletas

go
Alter function dbo.fnValidarHorario(@Hora as time)
returns bit
as
BEGIN
	Declare @resp bit
	IF(@Hora>='05:30' and @Hora<='18:00')
		set @resp=0
	ELSE 
		set @resp=1

		return(@resp)
END

-- VISTAS
Create view vTipodeHorarios as
select HoraInicial,HoraFinal,
case when dbo.fnValidarHorario(HoraInicial)=0 and
	dbo.fnValidarHorario(HoraFinal)=0
		then 'Horario de Dia'
	when dbo.fnValidarHorario(HoraInicial)=1 and
	dbo.fnValidarHorario(HoraFinal)=1
		then 'Horario de Noche'
else 'Horario Mixto'
	end TipoHorario
	from 
	
	(select
		cast(substring(descripcion,1,8) as time) HoraInicial,
		cast(right(descripcion,8) as time) HoraFinal
		from horario
	) as THorario --Subconsulta
	

-- PIVOT
-- UNPIVOT
Select [Horario de Dia],[Horario Mixto] from(
		select horainicial,tipohorario from vTipodeHorarios
	) as Source
PIVOT(
	COUNT(horainicial) for TipoHorario in([Horario de Dia],[Horario de Noche],[Horario Mixto])
) as tpivot


-- STORED PROCEDURE

Alter procedure spPorcentaje @Fecha1 datetime, @Fecha2 datetime, @MateriaID int
as
BEGIN
declare @total float
-- Encontrar el TOTAL
select @total=sum(peso_entrada-peso_salida) from boletas 
	where materiaprimaid=@MateriaID and 
	fechahoraingreso between @Fecha1 and @Fecha2 and 
	fechahorasalida between @Fecha1 and @Fecha2

print @total

-- Mostrar el porcentaje por transaccion
select 
	c.nombre Conducto,v.placaprincipal Placa,@Fecha1 [Fecha Inicial], @Fecha2 [Fecha Final],
	sum(peso_entrada-peso_salida) Tonelaje,
	Concat( Round( sum(peso_entrada-peso_salida)/@total*100, 0),' %') Porcentaje 
from boletas b
	inner join vehiculos v on b.placavehiculo=v.vehiculoid
	inner join conductor c on c.conductorid=b.conductorid
where 
	materiaprimaid=@MateriaID and 
	fechahoraingreso between @Fecha1 and @Fecha2 and 
	fechahorasalida between @Fecha1 and @Fecha2
group by c.nombre,v.placaprincipal
order by Porcentaje desc
END
go
spPorcentaje '20170401','20170410',1003

Alter procedure spPivotDinamico @F1 date, @F2 date as
declare @var1 varchar(max), @query nvarchar(max)
create table #data(Fecha varchar(100))
insert into #data select distinct(datename(month,Fecha) + convert(varchar(4),DATEPART(year,fecha))) 
from Datos where Fecha between @F1 and @F2
select @var1=COALESCE(@var1 + '], [', '') + Fecha from #data

select @var1='['+@var1+']'
--select @var1
set @query='select * from (
select datename(month,Fecha) + convert(varchar(4),DATEPART(year,fecha)) Fecha, 
m.Codigo,Valor from Datos d
inner join Medidores m on d.Medidor=m.id
where DATEPART(day,fecha)=1 
) as ORIGENDATOS
pivot(
max(Valor) for Fecha in('+@var1+')
) TABLAPIVOT'

EXECUTE sp_executesql @query
go
spPivotDinamico '20180101','20180331'

-- CURSORES
go
Alter procedure spRecorrerboletas as
BEGIN
create table #compra(fecha datetime, Tonelaje float)
create table #venta(fecha datetime, Tonelaje float)

DECLARE @fecha datetime, @entrada float, @salida float,@dif float

DECLARE cursorPesaje CURSOR for
select fechahoraingreso,peso_entrada,peso_salida from boletas

OPEN cursorPesaje

FETCH NEXT FROM cursorPesaje INTO @fecha,@entrada,@salida

WHILE @@FETCH_STATUS = 0
BEGIN
	--select @fecha,@entrada 'Entrada',@salida 'Salida'
	set @dif=@entrada-@salida
	if(@dif>=0)
		insert into #compra values(@fecha,@dif)
	else
		insert into #venta values(@fecha,ABS(@dif))
	FETCH NEXT FROM cursorPesaje INTO @fecha,@entrada,@salida
END
Close cursorPesaje
Deallocate cursorPesaje

select *,'Compra' Tipo from #compra
union all
select *,'Venta' Tipo from #venta
END
go
spRecorrerboletas
--select * from boletas

--select * from #compra


-- TRANSACCIONES
-- TRIGGER
