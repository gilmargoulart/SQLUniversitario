/*
Crie uma Trigger que controle a movimentação
do estoque dessa empresa.
Cada vez que um produto chega, é lançado na tabela
movimentação um registro E (Entrada) e quando é
vendido lança um registro S (Saída).
Essa quantidade recebida ou vendida deve ser atualizada
na tabela estoque.
*/
USE master
GO
--DROP DATABASE PROVA
--GO
CREATE DATABASE PROVA
GO
USE PROVA
GO
CREATE TABLE [Movimentos](
	[ProdutoCodigo] [INT] NULL,
	[Quantidade] [FLOAT] NULL,
	[EntradaSaida] [CHAR](1) NULL,
	[DataEntradaSaida] [SMALLDATETIME] NULL
)
GO
CREATE TABLE [Estoque](
	[ProdutoCodigo] [INT] NULL,
	[Quantidade] [FLOAT] NULL,
	[DataMovimento] [SMALLDATETIME] NULL
)
GO
INSERT Estoque (ProdutoCodigo,Quantidade,DataMovimento)
VALUES
(1,0,'2015-11-03 00:00:00'),
(2,0,'2015-11-03 00:00:00'),
(3,0,'2015-11-03 00:00:00'),
(4,0,'2015-11-03 00:00:00'),
(5,0,'2015-11-03 00:00:00'),
(6,0,'2015-11-03 00:00:00'),
(7,30,GETDATE()),
(8,0,'2015-11-03 00:00:00'),
(9,0,'2015-11-03 00:00:00'),
(10,0,'2015-11-03 00:00:00')
GO
INSERT Movimentos 
(ProdutoCodigo, Quantidade,EntradaSaida,DataEntradaSaida)
VALUES  (7,30,'E',GETDATE())
GO

--logica da trigger
create trigger TG_Movimentos
on Movimentos
For insert 
as 
begin
declare @operacao varchar (1)
	set @operacao = (select EntradaSaida from inserted)
if @operacao= 'E'
begin
	update Estoque SET Quantidade = Quantidade + (Select inserted.Quantidade FROM inserted)
	WHERE ProdutoCodigo = (select inserted.ProdutoCodigo from inserted)
end
else 
begin
	update Estoque SET Quantidade = Quantidade - (Select inserted.Quantidade FROM inserted)
	WHERE ProdutoCodigo = (select inserted.ProdutoCodigo from inserted)
end 
end





SELECT * FROM dbo.Movimentos
GO
SELECT * FROM dbo.Estoque
GO
/*
Crie um índice que auxilie a consulta abaixo
*/
SELECT DataEntradaSaida
FROM Movimentos
WHERE Movimentos.EntradaSaida = 'E'
/*
Crie uma função que retorne a idade da pessoa
em anos
*/
CREATE TABLE [dbo].[Pessoa](
	[Nome] [VARCHAR](50) NULL,
	[Nascimento] [SMALLDATETIME] NULL
)
INSERT dbo.Pessoa ( Nome, Nascimento )
VALUES  
('Rodrigo','1980-01-01'),
('Maria','1985-01-01')


