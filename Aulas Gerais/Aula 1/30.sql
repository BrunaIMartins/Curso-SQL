SELECT marca, SUM(valor_tabela_fipe)
FROM tbl_veiculos
WHERE data_cadastro > '2020-01-01' AND marca IN ('Acura')
GROUP BY marca
ORDER BY marca DESC