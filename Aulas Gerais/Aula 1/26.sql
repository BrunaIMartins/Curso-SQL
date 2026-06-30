SELECT MAX(valor_tabela_fipe) as valor_max_fipe, MIN(valor_tabela_fipe) as valor_min_fipe, AVG(valor_tabela_fipe) as valor_medio_fipe, marca
FROM tbl_veiculos
GROUP BY marca
ORDER BY valor_max_fipe DESC