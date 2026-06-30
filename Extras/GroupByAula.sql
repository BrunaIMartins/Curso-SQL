SELECT coluna1, funcaoAgrecacao(coluna2)
FROM nomeTabela
GROUP BY coluna1;

SELECT SpecialOfferID, COUNT(UnitPrice)
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID

SELECT SpecialOfferID, SUM(UnitPrice)
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID

SELECT *
FROM Sales.SalesOrderDetail

SELECT ProductId, COUNT(ProductID)
FROM Sales.SalesOrderDetail
GROUP BY ProductID

SELECT *
FROM Person.Person

SELECT FirstName, COUNT(FirstName)
FROM Person.Person
GROUP BY FirstName

SELECT Color, AVG(ListPrice) AS "Média Preço"
FROM Production.Product
WHERE Color = 'Silver'
GROUP BY Color
