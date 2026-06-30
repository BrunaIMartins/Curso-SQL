SELECT SUM(valor_tabela_fipe) AS sum_fipe, marca
FROM tbl_veiculos
WHERE marca IN ('Fiat','Ferrari')
GROUP BY marca
HAVING sum_fipe > 6000000
ORDER BY MAX(valor_tabela_fipe) DESC