/*********** PRIMARY KEY ***********/

--1: criar tabela com PK
CREATE TABLE TREINAMENTO.TB_PK (
ID SMALLINT PRIMARY KEY,
LETRA CHAR(1)
)

--2: inserir registros
INSERT INTO treinamento.TB_PK (ID, LETRA)
VALUES (1, 'A'), (2, 'G')

--2.1: inserir registro
INSERT INTO treinamento.TB_PK (ID, LETRA)
VALUES (3, 'B')

--3: consultar tabela
SELECT * FROM treinamento.TB_PK

/*
4: -- Inserir novo registro com a mesma chave
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR UM NOVO VALOR 
COM UMA CHAVE PRIMARIA JÁ EXISTENTE. A CHAVE PRIMARIA DEVE SER UNICA
*/
INSERT INTO treinamento.TB_PK (ID, LETRA)
VALUES (3, 'F')

-- solução passar um novo valor de chave
INSERT INTO treinamento.TB_PK (ID, LETRA)
VALUES (4, 'F')

SELECT *
FROM sys.key_constraints

----5: criar uma tabela com chave primaria identity
CREATE TABLE TREINAMENTO.TB_PK2 (
ID SMALLINT CONSTRAINT PK_TB_2 PRIMARY KEY IDENTITY,
LETRA CHAR(1)
)

--6: inserir registros
INSERT INTO TREINAMENTO.TB_PK2 (LETRA)
VALUES ('A'),('G'),('B'),('H'),('C')

--7: consultar tabela
SELECT * FROM TREINAMENTO.TB_PK2


----8: criar uma tabela com chave primaria composta
CREATE TABLE TREINAMENTO.TB_PK3 (
ID SMALLINT,
LETRA CHAR(1),
NOME VARCHAR(20),
CONSTRAINT PK_COMPOSTA1 PRIMARY KEY (ID, LETRA)
)

--9: inserir registros
INSERT INTO TREINAMENTO.TB_PK3 (ID, LETRA, NOME)
VALUES (1, 'A', 'Pedro'), (1, 'B', 'Ana'), (1, 'C', 'Maria')

--10: consultar tabela (Veja que aceita o mesmo ID, porém! Com letra diferente)
SELECT * FROM TREINAMENTO.TB_PK3

--10.1: inserir registro
INSERT INTO treinamento.TB_PK3 (ID, LETRA, NOME)
VALUES (1, 'D', 'Marcos')

/*
11: -- Simular inclusão de um novo registro com a chave composta 
igual a um registro existente
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR A MESMA COMBINAÇÃO DE CHAVES 
PRIMARIAS PARA O MESMO REGISTRO.
*/
INSERT INTO treinamento.TB_PK3 (ID, LETRA, NOME)
VALUES (1, 'D', 'Vinicius')

-- 12: Solução mudar valor da chave
INSERT INTO treinamento.TB_PK3 (ID, LETRA, NOME)
VALUES (1, 'E', 'Vinicius')







/*********** FOREIGN KEY ***********/

--1: Simular modelagem - Dono(1) x (N)Animal - Animal(N) x (1)Raca


--2: criar tabela de raça
CREATE TABLE TREINAMENTO.TB_RACA (
RACA_COD SMALLINT PRIMARY KEY IDENTITY,
RACA_NOME VARCHAR(20)
)

--3: criar tabela de dono
CREATE TABLE TREINAMENTO.TB_DONO (
DONO_COD SMALLINT PRIMARY KEY IDENTITY,
DONO_NOME VARCHAR(20)
)

--4: criar tabela de animal
CREATE TABLE TREINAMENTO.TB_ANIMAL (
ANIMAL_COD SMALLINT PRIMARY KEY IDENTITY,
ANIMAL_NOME VARCHAR(15),
ANIMAL_CODRACA SMALLINT FOREIGN KEY REFERENCES TREINAMENTO.TB_RACA(RACA_COD),
ANIMAL_CODDONO SMALLINT CONSTRAINT FK_DONO FOREIGN KEY REFERENCES TREINAMENTO.TB_DONO(DONO_COD)
)

--5: inserir tabela raca
INSERT INTO TREINAMENTO.TB_RACA (RACA_NOME)
VALUES ('Pitbull'), ('Pinscher')

--5.1: consultando a raça
SELECT * FROM treinamento.TB_RACA

--6: inserir tabela dono
INSERT INTO TREINAMENTO.TB_DONO (DONO_NOME)
VALUES ('Lorena'), ('Luiz')

--6.1: consultando o dono
SELECT * FROM treinamento.TB_DONO

--7: inserir tabela animal
INSERT INTO TREINAMENTO.TB_ANIMAL (ANIMAL_NOME, ANIMAL_CODDONO, ANIMAL_CODRACA)
VALUES ('Zeus', 1, 1), ('Atena', 2, 2)

SELECT * FROM treinamento.TB_ANIMAL
/*
8 : -- Inserir na tabela animal uma raça que não existe
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR UMA RAÇA DE ANIMAL 
QUE NÃO EXISTE NA TABELA DE ORIGEM, OU SEJA, A FK EXIGE QUE O 
REGISTRO EXISTA NA TABELA DE REFERENCIA
*/
INSERT INTO treinamento.TB_ANIMAL (ANIMAL_NOME, ANIMAL_CODDONO, ANIMAL_CODRACA)
VALUES ('Gaya', 1, 3)

--9: solução: inserindo uma nova raça na tabela Raça
INSERT INTO TREINAMENTO.TB_RACA (RACA_NOME)
VALUES ('Husky Siberiano')

--10 : re-inserir registro na tabela animal 
INSERT INTO treinamento.TB_ANIMAL (ANIMAL_NOME, ANIMAL_CODDONO, ANIMAL_CODRACA)
VALUES ('Gaya', 1, 3)

--11: consultando tabela animal
SELECT * FROM treinamento.TB_ANIMAL

/*
12: -- Tentando deletar um dono vinculado a um animal -- erro de integridade referencial
Erro de fk - integridade referencial
ERRO APRESENTADO: NÃO É POSSÍVEL EXCLUIR UM REGISTRO QUE ESTA SENDO UTILIZADO COMO REFERENCIA EM OUTRA TABELA
*/
DELETE FROM TREINAMENTO.TB_DONO
WHERE DONO_COD = 2







/*********** NOT NULL ***********/
--É obrigátorio o preenchimento do campo? se sim NOT NULL, se não NULL

--1: criando tabela 
CREATE TABLE TREINAMENTO.TB_NOTNULL(
ID SMALLINT PRIMARY KEY IDENTITY,
LETRA_1 CHAR(1) NOT NULL,
LETRA_2 CHAR(1) NULL
)

--2: inserindo registros - as duas colunas preenchidas
INSERT INTO treinamento.TB_NOTNULL
VALUES ('A', 'B')

SELECT * FROM treinamento.TB_NOTNULL

--3: inserindo registros - coluna 1 preenchida e a coluna 2 não preenchida
INSERT INTO treinamento.TB_NOTNULL (LETRA_1, LETRA_2)
VALUES ('C', NULL)
--OU
INSERT INTO treinamento.TB_NOTNULL (LETRA_1)
VALUES ('D')

/*
4: inserindo registros - coluna 1 não preenchida e a coluna 2 preenchida
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR UM VALOR NULO EM UMA 
COLUNA QUE POSSUI A CONSTRAINT NOT NULL
*/
INSERT INTO treinamento.TB_NOTNULL (LETRA_1, LETRA_2)
VALUES (NULL, 'E')
--OU
INSERT INTO treinamento.TB_NOTNULL (LETRA_2)
VALUES ('F')

--4.1: inserido um valor em branco na coluna 1
INSERT INTO treinamento.TB_NOTNULL (LETRA_1, LETRA_2)
VALUES ('', 'E')

INSERT INTO treinamento.TB_NOTNULL (LETRA_1, LETRA_2)
VALUES ('', 'N')

--5: consultar dados da da tabela
SELECT * FROM TREINAMENTO.TB_NOTNULL







/************ DEFAULT ***********/

--1: criar tabela
CREATE TABLE TREINAMENTO.TB_DEFAULT(
ID SMALLINT PRIMARY KEY IDENTITY,
LETRA CHAR(1) DEFAULT ('A'),
DT DATE CONSTRAINT DF_DATA DEFAULT (GETDATE()) NOT NULL 
)

--2: inserir registro na letra e deixar a data default
INSERT INTO TREINAMENTO.TB_DEFAULT (LETRA)
VALUES ('K')

--3: inserir registro na data e deixar letra default
INSERT INTO TREINAMENTO.TB_DEFAULT (DT)
VALUES ('2023-05-01')

--4: consultando tabela
SELECT * FROM treinamento.TB_DEFAULT

--5: tabela com coluna de data de insert (Ingestão de dados, data que o registrou entrou tabela)
CREATE TABLE TREINAMENTO.TB_DEFAULT2(
ID CHAR(4),
NOME VARCHAR(20),
VALOR SMALLMONEY,
DT_INSERT DATE CONSTRAINT DT_INSERT DEFAULT (GETDATE()) NOT NULL
)

--6: inserindo um registro não informando a data de insert
INSERT INTO treinamento.TB_DEFAULT2 (ID, NOME, VALOR)
VALUES ('V001', 'Ana', 10)

--6.1: inserindo mesmo registro em outro dia
INSERT INTO treinamento.TB_DEFAULT2 (ID, NOME, VALOR, DT_INSERT)
VALUES ('V001', 'Ana', 10, '2023-11-01')

--7: consultando tabela
SELECT * FROM treinamento.TB_DEFAULT2






/************ CHECK ***********/
--1: criar tabela
CREATE TABLE TREINAMENTO.TB_CHECK(
ID SMALLINT PRIMARY KEY IDENTITY,
LETRA CHAR(1) CHECK (LETRA IN ('A', 'B', 'C')),
VALOR SMALLMONEY CONSTRAINT CHK_VALOR CHECK (VALOR > 0)
)

--2: inserir os registros - com os dois valores corretos
INSERT INTO treinamento.TB_CHECK
VALUES ('A', 10)

SELECT * FROM treinamento.TB_CHECK

/*
3: coluna 1 valor errado, coluna 2 valor certo
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR UM VALOR DIFERENTE 
DO QUE FOI DEFINIDO PARA A COLUNA QUE CONTÉM A CONSTRAINT CHECK
*/
INSERT INTO TREINAMENTO.TB_CHECK (LETRA, VALOR)
VALUES ('D', 50)

/*
4: coluna 1 valor certo, coluna 2 valor erro
ERRO APRESENTADO: NÃO É POSSÍVEL INSERIR UM VALOR 
DIFERENTE DO QUE FOI DEFINIDO PARA A COLUNA QUE CONTÉM A CONSTRAINT CHECK
*/
INSERT INTO TREINAMENTO.TB_CHECK (LETRA, VALOR)
VALUES ('B', 0)

-- Teste se é case sensitive a letra:
INSERT INTO TREINAMENTO.TB_CHECK (LETRA, VALOR)
VALUES ('a', 1)

--5: consultando tabela
SELECT * FROM treinamento.TB_CHECK









/************ desenvolvendo consultas ***********/
--1: ordenando ascendente (menor para maior) -- ASC (IMPLICITO)
SELECT *
FROM TREINAMENTO.Customers
ORDER BY CITY ASC

--2: ordenando descendente (maior para o menor)
 SELECT *
 FROM treinamento.Customers
 ORDER BY CITY DESC
 -->> Z para A

--2.1: ordenando por data
SELECT *
FROM treinamento.Orders
ORDER BY OrderDate DESC

--2.2: ordenando valores nulos
SELECT *
FROM TREINAMENTO.Orders
ORDER BY ShipRegion DESC

--3: ordenando por mais de uma coluna - pais ascendente e cidade descendente 
SELECT *
FROM treinamento.Customers
ORDER BY COUNTRY ASC, CITY  DESC

SELECT *
FROM treinamento.Customers
WHERE COUNTRY = 'BRAZIL'
ORDER BY COUNTRY ASC, CITY  DESC, Address ASC



--4: valor igual a 18, ou seja, a coluna tem que ser 18
SELECT *
FROM TREINAMENTO.Products
WHERE UnitPrice = 18

SELECT *
FROM TREINAMENTO.Products
WHERE ProductName = 'Filo mix'

--5: valor diferente a 18, a coluna tem que ser diferente de 18 != OU <>
SELECT *
FROM TREINAMENTO.Products
WHERE UnitPrice != 18

SELECT *
FROM TREINAMENTO.Products
WHERE UnitPrice <> 18