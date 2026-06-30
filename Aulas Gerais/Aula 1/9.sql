SELECT  placa,  marca, ano, modelo, valor_tabela_fipe,data_cadastro
FROM tbl_veiculos 
WHERE data_cadastro BETWEEN '2020-01-01' AND '2020-12-31'