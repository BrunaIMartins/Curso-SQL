SELECT Name,Weight
FROM Production.Product
WHERE Weight > 500 AND Weight <= 700

SELECT NationalIDNumber,MaritalStatus,SalariedFlag
FROM HumanResources.Employee
WHERE MaritalStatus = 'm' AND SalariedFlag=1


SELECT *
FROM Person.EmailAddress

SELECT *
FROM Person.Person

SELECT BusinessEntityID, FirstName, LastName
FROM Person.Person
WHERE FirstName = 'Peter' AND LastName = 'Krebs'

SELECT BusinessEntityID,EmailAddress
FROM Person.EmailAddress
WHERE BusinessEntityID = '26'
