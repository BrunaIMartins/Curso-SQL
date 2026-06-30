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

--6: valor maior que  50
SELECT *
FROM TREINAMENTO.Products
WHERE UnitPrice > 50

--6.1: valor MENOR que  50
SELECT *
FROM treinamento.Products
WHERE UnitPrice < 50

--7: valor maior ou igual a 81
SELECT *
FROM treinamento.Products
WHERE UnitPrice >= 81 

--7.1: valor menor ou igual a 81
SELECT *
FROM treinamento.Products
WHERE UnitPrice <= 81

--8: data maior ou igual maior a '1960-01-27'
SELECT *
FROM treinamento.Employees
WHERE BirthDate >= '1960-01-27'

--10: AND todas as condições tem que ser verdadeiras (Cliente de São Paulo, Brazil, com CEP 05634-030)
SELECT *
FROM treinamento.Customers
WHERE Country = 'Brazil'
AND City = 'São Paulo'
AND Region = 'SP'
AND PostalCode = '05634-030' -- Verificar como fazer consulta sendo case sentive

--11: OR a condição pode ser verdadeira ou falsa
SELECT *
FROM treinamento.Customers
WHERE COUNTRY = 'Brazil'
OR City = 'Buenos Aires'
OR Region = 'BC'

SELECT *
FROM treinamento.Customers
WHERE COUNTRY = 'Brazil' AND (Region IS NULL OR REGION = 'SP') -- Isolar a condição

--12: NOT inverso da condição
SELECT *
FROM treinamento.Customers
WHERE NOT Country = 'Brazil'

--13: calculos matematicos
SELECT *,
	(UnitPrice * Quantity) AS SubTotal,
	((UnitPrice * Quantity) /100) AS Divisao,
	((UnitPrice * Quantity) - Discount) AS Subtotal_Com_Desconto
FROM treinamento.OrderDetails

--14: is null
SELECT *
FROM treinamento.Orders
WHERE ShipRegion IS NULL

--15: is not null
SELECT *
FROM treinamento.Orders
WHERE ShipRegion IS NOT NULL

--16: is not null para a region e is null para shipostalcode
SELECT *
FROM treinamento.Orders
WHERE ShipRegion IS NOT NULL 
AND ShipPostalCode IS NULL

--17: IN lista de valores, ele vai verificar se um dos valores passados existe na coluna
SELECT *
FROM treinamento.Customers
WHERE City IN ('Buenos Aires', 'Belo Horizonte', 'Montréal', 'São Paulo')

--18: IN lista de valores, ele vai verificar se um dos valores passados existe na coluna
SELECT *
FROM treinamento.Orders
WHERE EmployeeID IN (8, 1, 3, 450)

/*
19: NOT IN inverso da lista de valores, ele vai verificar se um dos 
valores passados existe na coluna
*/
SELECT *
FROM treinamento.Orders
WHERE EmployeeID NOT IN (8, 1, 3, 450)


--20: IN com resultado de subconsulta
SELECT *
FROM treinamento.Orders
WHERE ShipCity = (	SELECT DISTINCT CITY 
					FROM treinamento.Customers
					WHERE Country = 'Brazil'
					AND REGION = 'RJ')

--21: BETWEEN valores entre X e Y - valores numericos
SELECT *
FROM treinamento.Orders
WHERE Freight BETWEEN 5 AND 10.5

SELECT * FROM treinamento.Orders
WHERE Freight >= 5 AND Freight <= 10.5

--22: BETWEEN valores entre X e Y - valores de data
SELECT *
FROM treinamento.Orders
WHERE OrderDate BETWEEN '1991-05-28' AND '1991-06-30'

--erro data maior primeiro que a data menor
SELECT *
FROM treinamento.Orders
WHERE OrderDate BETWEEN '1991-06-30' AND '1991-05-28' 

--23:  NOT BETWEEN inverso dos valores entre X e Y - valores de data
SELECT *
FROM treinamento.Orders
WHERE OrderDate NOT BETWEEN '1991-05-28' AND '1991-06-30' 


--24:  like busca de texto personalizada 
SELECT *
FROM TREINAMENTO.Orders
WHERE ShipAddress like '43 rue St. Laurent'

-- mesma coisa da consulta abaixo com WHERE
SELECT *
FROM TREINAMENTO.Orders
WHERE ShipAddress = '43 rue St. Laurent'

--25:  like busca de texto personalizada - palavra% - todo mundo que começa com a palavra
SELECT *
FROM TREINAMENTO.Orders
WHERE ShipAddress like 'Av.%'

SELECT *
FROM TREINAMENTO.Orders
WHERE ShipAddress like 'T%'

--Expressão regular (Palavras que começam com A B ou C)
SELECT *
FROM treinamento.Orders
WHERE ShipAddress like '[abc]%'

--26:  like busca de texto personalizada - %palavra - todo mundo que termina com a palavra
SELECT *
FROM treinamento.Orders
WHERE ShipAddress like '%5'

/*
27:  like busca de texto personalizada - %palavra% - todos que contem 
a palavra no inicio, meio e final do texto
*/
SELECT *
FROM treinamento.Orders
WHERE ShipAddress like '%St.%'
AND ShipCountry = 'Canada'

--28: ALIAS apelidos para as colunas e tabelas - alias de coluna
SELECT 
	CustomerID as 'Id_Cliente', -- Maneira 1 com palavra AS
	Cidade = City, -- Maneira 2 - apelido = coluna
	Country [País], -- Maneira 3 - sem o AS
	Region as [Região Cliente] 
FROM treinamento.Customers

--29: ALIAS apelidos para as colunas e tabelas - alias de tabela
SELECT 
	CustomerID as 'Id_Cliente', -- Maneira 1 com palavra AS
	Cidade = City, -- Maneira 2 - apelido = coluna
	Country [País], -- Maneira 3 - sem o AS
	Region as [Região Cliente],
	TBCLIENTES.Phone,
	TBCLIENTES.Address
FROM treinamento.Customers AS TBCLIENTES

--Ambiguous column name 'City'.
SELECT 
	--CITY,
	TB_EMP.City as 'Cidade_Funcionario',
	TB_CLI.City as 'Cidade_Cliente'
FROM TREINAMENTO.Employees AS TB_EMP, treinamento.Customers AS TB_CLI

/*
Utilizando alias (apelido da coluna) no order by -- O order by é a ultima 
clausula da consulta SQL a ser executada
*/
SELECT 
	--CITY,
	TB_EMP.City as 'Cidade_Funcionario',
	TB_CLI.City as 'Cidade_Cliente'
FROM TREINAMENTO.Employees AS TB_EMP, treinamento.Customers AS TB_CLI
ORDER BY 'Cidade_Funcionario'

--30: CASE/IIF É SEMELHANTE AO IF ELSE
SELECT 
	CASE Region -- Maneira 1 coluna no case
	 WHEN 'SP' THEN 'SUDESTE - BRAZIL'
	 WHEN 'RJ' THEN 'SUDESTE - BRAZIL'
	 WHEN 'RS' THEN 'SUL - BRAZIL'
	 -- WHEN NULL THEN 'SEM_REGIAO'
	 ELSE 'OUTRA_REGIAO'
	END AS 'ANALISE_CASE1'
,
   CASE -- Maneira 2 a lógica vai no WHEN
	 WHEN Country = 'Brazil' AND Region = 'SP' AND City = 'Campinas' THEN 'Outra cidade de SP'
	 WHEN Country = 'Brazil' AND Region = 'SP' THEN 'SP - BRAZIL'
	 WHEN Country = 'Brazil' AND Region = 'RJ' THEN 'RJ - BRAZIL'
	ELSE 'OUTROS_VALORES' 
	END  'ANALISE_CASE2',
-- IIF Especifico do SQL SERVER
	IIF (Country = 'Brazil' AND Region ='SP', 'VERDADEIRO', 'FALSO') AS ANALISE_IIF,
	*

FROM treinamento.Customers
WHERE Country = 'Brazil'


--31: CASE ENCADEADO
SELECT 
	CASE
		WHEN Country = 'Brazil' THEN
			(CASE 
				WHEN CITY = 'Campinas' THEN 'Verdadeiro - Campinas/SP'
			ELSE
			(CASE 
				WHEN CITY = 'Resende' THEN 'Verdadeiro - Resende/RJ'
			ELSE 'Falso para todos'
			END)
				END)
		ELSE 'OUTRO_VALOR'
		END AS 'CASE_ENCADEADO',
		*
FROM treinamento.Customers

/*case no where*/
SELECT * FROM treinamento.Customers
WHERE (CASE WHEN Country = 'BRAZIL' AND Region = 'SP' THEN 'SP - BRAZIL' END) = 'SP - BRAZIL'

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