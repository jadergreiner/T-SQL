SELECT  
        
        qtdContribuintes= count(distinct i_pessoas),
        qtdImoveis= count(distinct i_imoveis),
        codCidade = (
                CASE i.end_entrega_iptu when 'C' THEN (select i_cidades from bethadba.pessoas_enderecos where i_pessoas = i.i_pessoas and tipo_endereco = 'P')
                                        when 'I' THEN 1
                                        when 'R' THEN (select i_cidades from bethadba.pessoas_enderecos where i_pessoas = I.i_responsavel and tipo_endereco = 'P')
                                        when 'O' THEN (select i_cidades from bethadba.correspondencias where correspondencias.i_imoveis = i.i_imoveis)
                ELSE 0
                END
        ),
        nomeCidade = (select nome from bethadba.cidades where i_cidades = codCidade),
        list(distinct i_pessoas),
        list(i_imoveis)  
         
    
    FROM bethadba.imoveis i 
    group by codCidade
    order by qtdContribuintes desc