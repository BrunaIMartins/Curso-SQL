SELECT cpf, data_nascimento,
CASE
WHEN data_nascimento <= '1989-12-31' THEN 'ADULTO'
WHEN data_nascimento > '1989-12-31' THEN 'CRIANÇA'
ELSE 'NÃO INFORMADA'
END AS categoria_idade
FROM cadastro_cliente