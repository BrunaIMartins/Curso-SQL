select MAX(valor_tabela_fipe) AS valor_max_fipe, marca #mudou nome da coluna
FROM tbl_veiculos
GROUP BY marca
