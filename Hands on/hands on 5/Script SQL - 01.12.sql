/* fazendo update com case

update tbFuncionario
set salario = 
			(
			case
				when regiao = 'nordeste' and salario between 1800 and 7000 then salario * 1.3
				when regiao = 'sudeste' and salario > 5000 then salario * 1.4
				when regiao = 'sul' and salario > 4000 then salario * 1.2
			end
			)
		
where status_func = 'A' 
*/


/*
-- Extração de relatorio com condições: 
1) Salario maior ou igual 900 e Data de admissao maior ou igual 2018 = +20%
2) Salario entre 2000 e 4000 = +10%
3) Salario maior que 4000 = +100 reais
*/
SELECT
NOME,
SALARIO,
DATAADMISSAO,
CASE
	WHEN SALARIO >= 900 AND YEAR(DATAADMISSAO) >= 2018 THEN SALARIO * 1.2
	WHEN SALARIO BETWEEN 2000 AND 4000 THEN SALARIO * 1.1
	WHEN SALARIO > 4000 THEN SALARIO + 100
ELSE SALARIO
END SALARIO_NOVO
FROM TREINAMENTO.FUNCIONARIO


--32: distinct - remove linhas duplicadas do resultado da consulta ** apenas na exibição**
SELECT 
COUNTRY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY

SELECT DISTINCT
COUNTRY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY

-- Com duas colunas:
SELECT
COUNTRY, CITY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY

SELECT DISTINCT
COUNTRY, CITY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY

SELECT DISTINCT COUNTRY, CITY, FAX
FROM treinamento.Customers
ORDER BY COUNTRY, CITY

-- OU com GROUP BY
SELECT COUNTRY, CITY
FROM TREINAMENTO.Customers
GROUP BY COUNTRY, CITY
ORDER BY COUNTRY

--33: top - limita a quantidade de registros exibidos na consulta -- o order by influencia na saida
SELECT DISTINCT TOP(5) COUNTRY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY ASC -- Ordem alfabetica de A para Z

SELECT DISTINCT TOP(5) COUNTRY
FROM TREINAMENTO.Customers
ORDER BY COUNTRY DESC -- Ordem alfabetica de Z para A




/************ JOINS ***********/

CREATE TABLE treinamento.DEPARTAMENTO (
CODIGO INT PRIMARY KEY IDENTITY,
DESCRICAO VARCHAR(100) NOT NULL);
GO

CREATE TABLE treinamento.FUNCAO (
CODIGO INT PRIMARY KEY IDENTITY,
DESCRICAO VARCHAR(100))
GO

CREATE TABLE treinamento.FUNCIONARIO(
MATRICULA INT PRIMARY KEY IDENTITY,
NOME VARCHAR (255) NOT NULL,
DATANASCIMENTO DATE NOT NULL,
CPF CHAR(11) UNIQUE CHECK (LEN(CPF) = 11),
SALARIO MONEY NULL,
DATAADMISSAO DATE DEFAULT (GETDATE()),
DATADEMISSAO DATE NULL,
INICIOFERIAS DATE NULL,
FIMFERIAS DATE NULL,
STATUS_FUNC VARCHAR (20) CHECK (STATUS_FUNC IN ('ATIVO','INATIVO','FERIAS','LICENÇA','INSS')),

CODDEPTO INT FOREIGN KEY REFERENCES treinamento.DEPARTAMENTO (CODIGO),

CODSUPERVISOR INT FOREIGN KEY REFERENCES treinamento.FUNCIONARIO (MATRICULA),

CODFUNCAO INT FOREIGN KEY REFERENCES treinamento.FUNCAO (CODIGO))
GO


/*INSERINDO REGISTROS*/


INSERT INTO treinamento.DEPARTAMENTO
VALUES 	('TECNOLOGIA DA INFORMACAO'),
	('RECURSOS HUMANOS'),
	('JURIDICO'),('SELEÇÃO'),
	('CONTABILIDADE'),
	('CONTAS A PAGAR E RECEBER'), 
	('DEPARTAMENTO PESSOAL')
GO

INSERT INTO treinamento.FUNCAO
VALUES ('ESTAGIARIO'), ('ANALISTA JR'),('ANALISTA PL'),('ANALISTA SR'),('COORDENADOR'),('GERENTE')
GO


INSERT INTO treinamento.FUNCIONARIO (NOME, DATANASCIMENTO,CPF, SALARIO,DATAADMISSAO,DATADEMISSAO,INICIOFERIAS,FIMFERIAS, STATUS_FUNC, CODDEPTO, CODSUPERVISOR, CODFUNCAO)
VALUES 
('ANA MARIA', '2000-01-01','12345678911', 1200.55, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1, 6, 2 ),
('JOSE HENRIQUE', '1998-11-20','12345678912', 2575.55, '2005-09-01','2017-12-01',NULL,NULL, 'INATIVO', 7, NULL, 3 ),
('ANA MARIA', '2002-08-21','12345678913', 950.00, '2019-01-01',NULL,NULL,NULL, 'ATIVO', 6, NULL, 1),
('LUAN FELIX', '1991-09-28','12345678914', 3500.00, '2013-04-01',NULL,NULL,NULL, 'ATIVO', 3,NULL,2),
('FELIPE JOSE DOS SANTOS', '1996-01-11','12345678915', 4000, '2011-05-01','2015-01-29',NULL,NULL, 'INATIVO', 2, NULL, 3),
('MARCELO JOSE', '1980-10-05','12345678916', 7000, '2000-05-01',NULL,'2019-05-01','2019-06-01', 'ATIVO', 1, NULL, 1),
('MARIANA MARIA', '1987-02-08','12345678917', 4500, '2010-01-01',NULL,NULL,NULL, 'INSS', 1, 6, 3 ),
('JULIANA MARIA DOS SANTOS', '2002-01-01','12345678918', 2000, '2017-05-01',NULL,NULL,NULL, 'LICENÇA', 5, NULL, 2 ),
('MARIA ALICIA', '2001-01-01','12345678919', 950, '2018-05-01',NULL,NULL,NULL, 'ATIVO', 1, 6, 1)
GO
	
INSERT INTO treinamento.FUNCIONARIO (NOME, DATANASCIMENTO,CPF, SALARIO,STATUS_FUNC, CODDEPTO,CODSUPERVISOR,CODFUNCAO)
VALUES ('MARIA ALICIA', '2003-09-18','12345678920', 950,  'ATIVO', NULL, NULL,1)


SELECT *
FROM treinamento.DEPARTAMENTO

SELECT *
FROM treinamento.FUNCIONARIO

SELECT * 
FROM treinamento.FUNCAO

/*
INNER JOIN - TRAGA SOMENTE FUNCIONARIOS QUE TEM DEPARTAMENTO 
E DEPARTAMENTO QUE TEM FUNCIONARIO VINCULADO
SE HOUVER UM JOIN SEM O INNER, NÃO SE PREOCUPE, O INNER ESTA IMPLICITO
*/
SELECT
F.NOME,
D.DESCRICAO,
F.CODDEPTO AS FK_FUNC_DEPARTAMENTO,
D.CODIGO AS PK_DEPARTAMENTO
FROM treinamento.FUNCIONARIO AS F
INNER JOIN treinamento.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO


/*
LEFT JOIN - TRAGA TODOS OS FUNCIONARIOS QUE TEM DEPARTAMENTO OU NÃO
SE HOUVER UM LEFT JOIN SEM O OUTER, NÃO SE PREOCUPE, O OUTER ESTA IMPLICITO
*/
SELECT
F.NOME,
D.DESCRICAO,
F.CODDEPTO AS FK_FUNC_DEPARTAMENTO,
D.CODIGO AS PK_DEPARTAMENTO
FROM treinamento.FUNCIONARIO AS F
LEFT JOIN treinamento.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO


/*
LEFT JOIN EXCLUSIVO- TRAGA SOMENTE OS FUNCIONARIOS QUE NÃO TEM DEPARTAMENTO
SE HOUVER UM LEFT JOIN SEM O OUTER, NÃO SE PREOCUPE, O OUTER ESTA IMPLICITO
*/
SELECT
F.NOME,
D.DESCRICAO,
F.CODDEPTO AS FK_FUNC_DEPARTAMENTO,
D.CODIGO AS PK_DEPARTAMENTO
FROM treinamento.FUNCIONARIO AS F
LEFT JOIN treinamento.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE D.CODIGO IS NULL


/*
RIGHT JOIN - TRAGA TODOS OS DEPARTAMENTOS QUE TEM FUNCIONARIO OU NÃO
SE HOUVER UM RIGHT JOIN SEM O OUTER, NÃO SE PREOCUPE, O OUTER ESTA IMPLICITO
*/
SELECT 
F.NOME,
F.CODDEPTO AS FK_DEPTO,
D.CODIGO AS PK_DEPTO
FROM treinamento.FUNCIONARIO as F
RIGHT JOIN TREINAMENTO.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO

--RIGHT JOIN EXCLUSIVO
SELECT 
F.NOME,
F.CODDEPTO AS FK_DEPTO,
D.CODIGO AS PK_DEPTO
FROM treinamento.FUNCIONARIO as F
RIGHT JOIN TREINAMENTO.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE F.CODDEPTO IS NULL

/*
FULL JOIN - TRAGA TODOS OS DEPARTAMENTOS QUE TEM OU NÃO FUNCIONARIO 
E TODOS OS FUNCIONARIOS QUE TEM OU NÃO DEPARTAMENTO
SE HOUVER UM FULL JOIN SEM O OUTER, NÃO SE PREOCUPE, O OUTER ESTA IMPLICITO
*/
SELECT
F.NOME,
D.DESCRICAO,
F.CODDEPTO AS FK_FUNC_DEPARTAMENTO,
D.CODIGO AS PK_DEPARTAMENTO
FROM treinamento.FUNCIONARIO AS F
FULL JOIN treinamento.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO


--FULL JOIN EXCLUSIVO
SELECT
F.NOME,
D.DESCRICAO,
F.CODDEPTO AS FK_FUNC_DEPARTAMENTO,
D.CODIGO AS PK_DEPARTAMENTO
FROM treinamento.FUNCIONARIO AS F
FULL JOIN treinamento.DEPARTAMENTO AS D
ON F.CODDEPTO = D.CODIGO
WHERE F.CODDEPTO IS NULL OR D.CODIGO IS NULL


/*
CROSS JOIN - PRODUTO CARTESIANO
*NÃO UTILIZA A CLAUSULA ON
FAZ UMA MULTIPLICAÇÃO DOS REGISTROS DE A COM B
SE A TEM 3 REGISTROS E B TEM 4 REGISTROS O RESULTADO DO CROSS É 12.
*/
SELECT 
F.NOME,
D.DESCRICAO,
F.CPF
FROM TREINAMENTO.FUNCIONARIO AS F
CROSS JOIN treinamento.DEPARTAMENTO AS D
ORDER BY F.NOME


-- RESPONDENDO PERGUNTAS COM JOIN:
--Inner join - todo mundo que tem correlação nas duas tabelas, 
--Ex: clientes que fizeram pedidos e pedidos que estão vinculados a um cliente
SELECT 
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM treinamento.Customers AS cli
INNER JOIN treinamento.Orders as ped
ON cli.CustomerID = ped.CustomerID


-- Left join - todo mundo da tabela da esquerda que tem ou não correlação com a tabela da direita
-- Ex: Clientes que fizeram ou não um pedido
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Customers AS cli
LEFT JOIN TREINAMENTO.Orders AS ped
on cli.CustomerID = ped.CustomerID
ORDER BY CodigoPedido

-- left join exclusivo (Apenas clientes que não fizeram compras)
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Customers AS cli
LEFT JOIN TREINAMENTO.Orders AS ped
on cli.CustomerID = ped.CustomerID
WHERE PED.OrderID IS NULL
ORDER BY CodigoPedido


-- Right join - todo mundo da tabela da direita que tem ou não correlação com a tabela da esquerda
-- Ex: Clientes que fizeram ou não um pedido
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Orders AS ped
RIGHT JOIN TREINAMENTO.Customers AS cli
ON cli.CustomerID = ped.CustomerID
ORDER BY CodigoPedido

-- right join exclusivo
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Orders AS ped
RIGHT JOIN TREINAMENTO.Customers AS cli
ON cli.CustomerID = ped.CustomerID
WHERE ped.OrderID IS NULL
ORDER BY CodigoPedido

-- Full join - todo mundo que tem ou não correlação da esquerda e direita
-- Ex: clientes que fizeram ou não um pedido, pedidos que tem ou não cliente
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Orders AS ped
FULL JOIN TREINAMENTO.Customers AS cli
ON cli.CustomerID = ped.CustomerID
ORDER BY CodigoPedido

-- full join exclusivo
SELECT
cli.CustomerID as CodigoCliente,
ped.OrderID as CodigoPedido
FROM TREINAMENTO.Orders AS ped
FULL JOIN TREINAMENTO.Customers AS cli
ON cli.CustomerID = ped.CustomerID
WHERE ped.OrderID is null or cli.CustomerID is null
ORDER BY CodigoPedido

-- Cross Join - produto cartesiano - multiplica as linhas da tabela A com as da tabela B
SELECT
a.CompanyName,
b.CompanyName,
b.City
FROM TREINAMENTO.Shippers as a
CROSS JOIN TREINAMENTO.Customers as b
ORDER BY A.CompanyName

--JOIN com mais de uma tabela
SELECT 
cli.CustomerID as CodigoCliente,
cli.CompanyName as NomeCliente,
ped.OrderID,
func.FirstName as PrimeiroNomeFuncionario,
func.LastName as UltimoNomeFuncionario,
transp.CompanyName as Transportadora
FROM TREINAMENTO.Orders as ped

INNER JOIN TREINAMENTO.Customers as cli
ON cli.CustomerID = ped.CustomerID

LEFT JOIN treinamento.Employees as func
ON ped.EmployeeID = func.EmployeeID

LEFT JOIN treinamento.Shippers as transp
ON ped.ShipperID = transp.ShipperID

-- Explicação do case sensitive:
ALTER DATABASE TREINAMENTO_SQL COLLATE Latin1_General_CS_AI; 

-- Fazer o COLLATE no momento de execução da query:
SELECT *
FROM TREINAMENTO.Orders
WHERE ShipAddress like 'Av. Ines%'
COLLATE Latin1_General_CS_AI;