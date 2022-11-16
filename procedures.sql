
-- proc de inserir
drop procedure if exists sp_inscat;
delimiter $$
	create procedure sp_inscat(
	in pcat varchar(20),
    in pstatus bit
    )
    begin 
    insert into tbl_categoria(nm_cat, ds_status)
    values (pcat, pstatus);
    end $$
delimiter ;

call sp_inscat('lancamentos', 1);

select * from tbl_categoria;

call sp_inscat('filmes & TV', 1);

call sp_inscat('series', 1);

call sp_inscat('games', 1);

call sp_inscat('nerd', 1);

call sp_inscat('divertidas', 1);

call sp_inscat('pets', 1);

-- proc de alterar
drop procedure if exists sp_altcat;
delimiter $$
	create procedure sp_altcat(
		in pcat varchar(20),
		in pstatus bit,
		in pcod int 
    )
    begin 
		update tbl_categoria
		set nm_cat = pcat, ds_status = pstatus
		where cd_cat = pcod;
    end $$
delimiter ;


call sp_altcat('pets', 0, 7);


-- proc de select por status
drop procedure if exists sp_mostrarcatstatus;
delimiter $$
	create procedure sp_mostrarcatstatus(
		in pstatus bit
    )
    begin 
		select * from tbl_categoria 
		where ds_status = pstatus;
    end $$
delimiter ;

call sp_mostrarcatstatus(0);


-- proc de select por nome
drop procedure if exists sp_mostrarcatnome;
delimiter $$
	create procedure sp_mostrarcatnome(
		in pcat varchar(20)
    )
    begin 
		select * from tbl_categoria
        where nm_cat like concat ('%', pcat, '%');
    end $$
delimiter ;

call sp_mostrarcatnome('fil');

desc tbl_pagamento;

-- proc de inserir
drop procedure if exists sp_inspag;
delimiter $$
	create procedure sp_inspag(
	in pcdpag int,
    in pdspag varchar(20)
    )
    begin 
    insert into tbl_pagamento(cd_pagto, ds_pagto)
    values (pcdpag, pdspag);
    end $$
delimiter ;

call sp_inspag(1, 'Pix');
call sp_inspag(2, 'Cartão de crédito');
call sp_inspag(3, 'Cartão de débito');
call sp_inspag(4, 'Boleto bancário');

select * from tbl_pagamento;

-- proc de select por nome
drop procedure if exists sp_mostrarpag;
delimiter $$
	create procedure sp_mostrarpag()
    begin
		select * from tbl_pagamento;
    end $$
delimiter ;

call sp_mostrarpag();

-- proc de alterar
drop procedure if exists sp_altpag;
delimiter $$
	create procedure sp_altpag(
		in pcdpag int,
		in pdspag varchar(20)
    )
    begin 
		update tbl_pagamento
		set ds_pagto = pdspag, cd_pagto = pcdpag
		where cd_pagto = pcdpag;
    end $$
delimiter ;

call sp_altpag(1, 'Pix');

drop procedure if exists sp_insprod;
delimiter $$
	create procedure sp_insprod(
		in pnome varchar(80), 
        in pquant int,
        in pstatus bit(1),
        in ptam int,
        in pcat int,
        in pvalor decimal(10,2)
	)
    
	begin
		declare pcod int;
        REPLACE into tbl_produto
				(nm_produto,
				vl_produto,
				ds_status
				)
				values(pnome,pvalor,pstatus);
				
				set pcod = last_insert_id();
                
				insert into tbl_prod_tamanho(cd_tamanho, cd_produto, qt_produto)
				values(ptam, pcod, pquant);
                
				insert into tbl_prod_cat(cd_cat, cd_produto)
				values(pcat, pcod);
		    end $$
	delimiter ;
    
    call sp_insprod('Camiseta Etec',10,0,2,3,20.00);

           select * from tbl_prod_tamanho; 
			
    
            

drop procedure if exists sp_inscli;
delimiter $$
	create procedure sp_inscli(
	in ppessoa char(1),
	in pnome varchar(80),
	in plogradouro varchar(80),
	in pnologradouro varchar(5),
	in pcomplemento varchar(20),
	in pbairro varchar(20),
	in plogin varchar(20),
	in psenha char(20),
    in pstatus bit,
    in pcpf char(11),
    in pcnpj char(14),     
    in pfone char(11)
    )
    
    begin
    declare vcod int;
    declare erro_sql tinyint default false;
    declare continue handler for sqlexception set erro_sql = true;
    start transaction;

    
    if (ppessoa = "f") then
    insert into tbl_cliente
    (nm_cliente,
    nm_logradouro, 
    no_logradouro, 
    ds_complemento, 
    nm_bairro, 
    nm_login,
    ds_senha,
    ds_status)
    values (pnome, plogradouro, pnologradouro, pcomplemento, pbairro, plogin, psenha, pstatus);
    
    set vcod = last_insert_id();
    
    insert into tbl_telefonecli(cd_cliente, no_telefone)
    values (vcod, pfone);
    
    insert into tbl_pf(cd_cliente, no_cpf)
    values (vcod, pcpf);
    
    else
    insert into tbl_cliente
    (nm_cliente,
    nm_logradouro, 
    no_logradouro, 
    ds_complemento, 
    nm_bairro, 
    nm_login,
    ds_senha,
    ds_status)
    values (pnome, plogradouro, pnologradouro, pcomplemento, pbairro, plogin, psenha, pstatus);
    
    set vcod = last_insert_id();
    
    insert into tbl_telefonecli(cd_cliente, no_telefone)
    values (vcod, pfone);
    
    insert into tbl_pj(cd_cliente, no_cnpj)
    values (vcod, pcnpj);
    
    end if;
		if (erro_sql = false) then
			commit;
			select 'transação executada com sucesso' as resultado;
			else 
			rollback;
			select 'Ocorreu um erro ao executar a transação' as resultado;
		end if;
    end $$
delimiter ;

desc tbl_cliente;

-- inserindo tamanho

drop procedure if exists sp_instam;
delimiter $$
	create procedure sp_instam(
	in psg varchar(2)
    )
    begin 
    insert into tbl_tamanho(sg_tamanho)
    values (psg);
    end $$
delimiter ;

call sp_instam('P');
call sp_instam('M');
call sp_instam('G');
call sp_instam('GG');
call sp_instam('G3');



use db_LojaAtarde;

select * from tbl_tamanho;


	

