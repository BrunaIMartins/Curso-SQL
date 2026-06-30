SELECT coluna1, funcaoAgregacao(coluna2)
FROM tabela
GROUP BY coluna1
HAVING condicao

SELECT FirstName, COUNT(FirstName) as "quantidade"
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10

