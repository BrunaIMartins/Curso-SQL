SELECT *
FROM Production.Product
WHERE ListPrice > 1500

SELECT *
FROM Person.Person

SELECT COUNT(LastName)
FROM Person.Person
WHERE LastName LIKE ('P%')

SELECT *
FROM Person.Address

SELECT COUNT(DISTINCT City)
FROM Person.Address

SELECT DISTINCT City
FROM Person.Address

SELECT *
FROM Production.Product
WHERE Color = 'Red' 
AND ListPrice BETWEEN 500 AND 1000

SELECT COUNT(*)
FROM Production.Product
WHERE Name LIKE ('%road%')


