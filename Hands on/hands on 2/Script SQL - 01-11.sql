--9: MERGE
-- CRIANDO TABELA DE ORIGEM
CREATE TABLE TREINAMENTO.ORIGEM_PRD (
ID CHAR(4),
NOME VARCHAR(20),
PRECO SMALLMONEY
)

--CRIANDO TABELA DE DESTINO
CREATE TABLE TREINAMENTO.DESTINO_PRD (
ID CHAR(4),
NOME VARCHAR(20),
PRECO SMALLMONEY
)

--INSERINDO DADOS NA ORIGEM
INSERT INTO TREINAMENTO.ORIGEM_PRD (ID, NOME, PRECO)
VALUES	('P001', 'PRODUTO_1', 55.55),
		('P002', 'PRODUTO_2', 100.10),
		('P003', 'PRODUTO_3', 200.50)

-- CRIANDO MERGE -upsert: insert + update
MERGE
	TREINAMENTO.DESTINO_PRD AS DEST -- Tabela de destino
USING
	TREINAMENTO.ORIGEM_PRD AS ORIG -- Tabela de origem utilizada para inserir ou atualizar no destino
ON (DEST.ID = ORIG.ID) -- Filtro para realizar o procedimento merge

WHEN NOT MATCHED BY TARGET -- Quando existir na origem e não existir no destino
THEN
	INSERT (ID, NOME, PRECO) -- Campos da tabela de destino
	VALUES (ORIG.ID, ORIG.NOME, ORIG.PRECO) -- Campos da tabela de origem

WHEN MATCHED -- Quando existir registros iguais na origem e no destino
AND (ORIG.NOME <> DEST.NOME OR ORIG.PRECO <> DEST.PRECO)
THEN 
	UPDATE -- Update na tabela de destino
	SET DEST.NOME = ORIG.NOME, -- Atualizar os dados do destino, alterando com o que vem da origem
		DEST.PRECO = ORIG.PRECO --Atualizar os dados do destino, alterando com o que vem da origem

WHEN NOT MATCHED BY SOURCE -- Quando não existe na origem e existe no destino
THEN
	DELETE;


-- ANALISE DO MERGE
SELECT * FROM TREINAMENTO.origem_prd
SELECT * FROM TREINAMENTO.destino_prd

-- UPDATE NO VALOR DO PRODUTO NA ORIGEM
UPDATE TREINAMENTO.ORIGEM_PRD
SET PRECO = 650.90
WHERE ID = 'P001'

-- ANALISE DO MERGE
SELECT * FROM TREINAMENTO.origem_prd
SELECT * FROM TREINAMENTO.destino_prd

-- DELETAR UMA LINHA NA TABELA DE ORIGEM
DELETE
FROM TREINAMENTO.ORIGEM_PRD
WHERE ID = 'P001'

-- ANALISE DO MERGE
SELECT * FROM TREINAMENTO.origem_prd
SELECT * FROM TREINAMENTO.destino_prd






/* PADRÕES DE NOMENCLATURA COLUNA/TABELA

TUDO MAISCULO - CLIENTE - NOME
tudo minusculo - cliente - nome
NomeComposto - TbCliente - NomeCompleto
nomeComposto - nomeCliente - nomeCompleto
com separador - tb_Cliente - nome_cliente
nome coluna com tipo - str_nome_animal, dt_dtnasc_animal, int_qtdItens, num_valorConsulta

Não colocar acentos e nem espaços em nome de tabela e coluna

TbAnimal
	animal_nomeCompleto, animal_dtNasc, animal_codRaca
	animal_dt_Nasc
TbDono
	dono_dt_Nasc
TbRaca
TbAtendente
TbConsulta


SELECT coluna 
FROM tabela
WHERE filtro = 100
*/





/*DTL: BEGIN TRAN, COMMIT, ROLLBACK*/

--1: BEGIN TRAN COM COMANDO UPDATE
BEGIN TRAN
UPDATE TREINAMENTO.Customers
SET City = 'Belo Horizonte', Region = 'MG'
WHERE CustomerID = 'COMMI'

COMMIT -- Salva a transação
ROLLBACK -- Desfaz a transação 'CTRL + Z'

--2: BEGIN TRAN COM COMANDO DROP TABLE
BEGIN TRAN APAGANDO_TABELA
TRUNCATE TABLE TREINAMENTO.DESTINO_PRD

--3: BEGIN TRAN COM O COMANDO DELETE
BEGIN TRAN DELETANDO
DELETE FROM TREINAMENTO.DESTINO_PRD
WHERE Nome = 'PRODUTO_2'




/* DQL: SELECT */

--1: SELECT COM O ASTERISCO - RETORNA TODAS AS COLUNAS DA TABELA. OBS: NÃO É BOA PRÁTICA
SELECT * FROM TREINAMENTO.Orders

--2: SELECT DEFININDO AS COLUNAS. OBS: É UMA ÓTIMA PRÁTICA
SELECT OrderID, CustomerId, ShipName, ShipCity FROM TREINAMENTO.Orders

--3: SELECT DEFININDO AS COLUNAS. RETORNANDO APENAS AS COLUNAS DESEJADAS. OBS: É UMA ÓTIMA PRÁTICA
SELECT OrderID, CustomerId FROM TREINAMENTO.Orders

--4: SELECT DEFININDO AS COLUNAS E FILTRANDO OS DADOS. OBS: É UMA ÓTIMA PRÁTICA
SELECT CompanyName, ContactName, ContactTitle, Address, City FROM TREINAMENTO.Customers
WHERE CITY = 'Berlin'





/*** DCL: GRANT,  DENY***/

--1: CRIANDO UM USUARIO NO BANCO DE DADOS SEM LOGIN
CREATE USER USER_DCL WITHOUT LOGIN;

--2: DAR PERMISSÃO PARA O USUARIO REALIZAR SELECT E INSERT NA TABELA_01
GRANT SELECT, INSERT ON TREINAMENTO.TABELA_01 TO USER_DCL

--2.1: DAR PERMISSÃO PARA O USUARIO REALIZAR TODOS OS COMANDOS DML, DDL
GRANT ALL ON TREINAMENTO.TABELA_01 TO USER_DCL

--3: NEGAR UMA PERMISSÃO
DENY INSERT ON TREINAMENTO.TABELA_01 TO USER_DCL
DENY SELECT ON TREINAMENTO.TABELA_01 TO USER_DCL

--4: EXECUTAR UMA QUERY INSERT COMO SE FOSSE O USUÁRIO USER_DCL,
EXECUTE AS USER = 'USER_DCL'
INSERT INTO treinamento.TABELA_01
VALUES (16, 'TEXTO_X', 98.4, 99.5, '2023-11-01')
REVERT; -- Após a execução o comando revert, retorna a janela de query atual ao usuário de origem 

--5: EXECUTAR UMA QUERY SELECT COMO SE FOSSE O USUÁRIO USER_DCL, 
EXECUTE AS USER = 'USER_DCL'
SELECT * FROM TREINAMENTO.TABELA_01
REVERT; -- Após a execução o comando revert, retorna a janela de query atual ao usuário de origem 

-- 6: REMOVER PERMISSÕES COM REVOK
REVOKE SELECT ON TREINAMENTO.TABELA_01 TO USER_DCL;




/*********** IDENTITY ***********/

-- 1: criar uma tabela com campo identity
CREATE TABLE TREINAMENTO.TB_IDENTITY (
ID SMALLINT IDENTITY,
LETRA CHAR(1)
)

--2: inserir 3 linhas
INSERT INTO treinamento.TB_IDENTITY (letra)
VALUES ('A'), ('B'), ('C')

--3: consultando tabela
SELECT * FROM treinamento.TB_IDENTITY

/*
4: -- Simulando um erro, vamos passar um valor maior que a letra, 
ele alocará o valor do incremento em memoria
ERRO APRESENTADO: DATA TRUNCATION - O VALOR INFORMADO PARA A COLUNA 
É MAIOR DO QUE O TAMANHO DEFINIDO NA TABELA. 
*/
INSERT INTO treinamento.TB_IDENTITY (letra)
VALUES ('AA')

--5: inserindo um novo registro
INSERT INTO treinamento.TB_IDENTITY (letra)
VALUES ('D')

SELECT * FROM treinamento.TB_IDENTITY

--6: corrigir - desabilitar o identity
SET IDENTITY_INSERT TREINAMENTO.TB_IDENTITY ON

--7: inserir o valor com a numeração correta
INSERT INTO treinamento.TB_IDENTITY (id, letra)
VALUES (4, 'E')

--8: Habilitar o identity
SET IDENTITY_INSERT TREINAMENTO.TB_IDENTITY OFF 

--9: inserindo um novo registro
INSERT INTO treinamento.TB_IDENTITY (letra)
VALUES ('F')

SELECT * FROM treinamento.TB_IDENTITY

--10: apagando registro 6
DELETE FROM TREINAMENTO.TB_IDENTITY
WHERE ID = 6

--11: inserindo um novo registro
INSERT INTO treinamento.TB_IDENTITY (letra)
VALUES ('G')

SELECT * FROM treinamento.TB_IDENTITY

--12: Truncar a tabela para reiniciar a coluna identity, re-executar todos os processos menos o do erro
-- Truncate reseta a coluna com identity, já o delete pula.
TRUNCATE TABLE treinamento.TB_IDENTITY

SELECT * FROM treinamento.TB_IDENTITY