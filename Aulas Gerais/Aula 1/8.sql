SELECT  placa,  marca, modelo, valor_tabela_fipe, ano
FROM  tbl_veiculos 
WHERE (marca = 'Acura' OR marca = 'fiat') AND ano = '1993'