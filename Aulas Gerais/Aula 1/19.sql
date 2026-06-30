SELECT 
	SUM(valor_tabela_fipe) 
FROM 
	tbl_veiculos
WHERE
	marca = 'Ferrari' AND valor_tabela_fipe < 50000