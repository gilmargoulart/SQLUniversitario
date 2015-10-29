/*
Use a tabela cliente do banco 
MyBank ou Minha Caixa
Recrie e tabela Clientes
ou exlcua a FK´s e PK´s
*/
SELECT ClienteNome
FROM Clientes
WHERE 
ClienteCodigo = 4
/*
Ao executar a constulta acima vai gerar um 
table scan
*/
CREATE Clustered INDEX IX_ClienteCodigo on 
CLientes (ClienteCodigo)
/*
Repare que agora a consutla abaixo vai causar um
índice scan
*/
SELECT ClienteNome FROM Clientes
/*
A consulta abaixo vai causar uma operação de
ordenação
*/
SELECT ClienteNome FROM Clientes
order by ClienteNome

/*
Agora criamos um índice para auxiliar 
a leitura dos nomes
*/
CREATE INDEX IX_NOME ON Clientes (ClienteNome)

/*repare que agora ele vai usar o índice*/
SELECT ClienteNome FROM Clientes
order by ClienteNome

/*A consulta abaixo irá gerar um key look up, pois
não temos um índice no campo CidadeCliente*/ 
SELECT ClienteNome FROM Clientes
where ClienteCidade = 'Joinville'
order by ClienteNome

CREATE INDEX IX_CIDADE_NOME ON clientes
(ClienteCidade,ClienteNome)
/*repare que agora vamos gerar um index seek*/
SELECT ClienteNome FROM Clientes
where ClienteCidade = 'Joinville'
order by ClienteNome

