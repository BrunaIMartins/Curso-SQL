SELECT MAX(valor_tabela_fipe) AS valor_max_fipe, marca
FROM tbl_veiculos
GROUP BY marca
ORDER BY valor_max_fipe DESC