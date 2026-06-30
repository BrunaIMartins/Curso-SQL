SELECT *
FROM Production.Product

SELECT ProductID, Name, ListPrice
FROM Production.Product
ORDER BY ListPrice desc

SELECT TOP 4 ProductNumber, Name
FROM Production.Product
ORDER BY ProductID asc