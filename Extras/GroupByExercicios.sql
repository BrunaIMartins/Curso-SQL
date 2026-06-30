SELECT *
FROM Person.Person

SELECT COUNT(MiddleName), MiddleName
FROM Person.Person
GROUP BY MiddleName

SELECT *
FROM Sales.SalesOrderDetail

SELECT ProductID, AVG(OrderQty)
FROM Sales.SalesOrderDetail
GROUP BY ProductID

SELECT TOP 10 ProductID, SUM(LineTotal)
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY SUM(LineTotal) DESC

SELECT *
FROM Production.WorkOrder

SELECT AVG(OrderQty), COUNT(ProductID)
FROM Production.WorkOrder
GROUP BY ProductID
