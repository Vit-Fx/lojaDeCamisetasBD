drop procedure if exists sp_InsProd;
Delimiter $$
create procedure sp_InsProd(
	in pNmProd varchar(80),
    in pValor decimal(10,2),
    in pStatus bit,
    in pCat int,
    in pTamanho int,
    in pItens int
)
begin
declare vId int;
declare erro_sql tinyint default false;
declare continue handler for sqlexception set erro_sql = true;
start transaction;
if exists(select nm_Produto from tbl_produto where nm_Produto = pNmProd) then    
	select 'Atenção, Produto já cadastrado no sistema' as Atenção;
else
    insert into tbl_produto(nm_Produto, vl_Produto, ds_status)
    values(pNmProd,pValor,pStatus);    
    set vId = last_insert_id();
    
    insert into tbl_prod_cat(cd_cat,cd_Produto)
    values(pcat,vId);
    
    insert into tbl_prod_tamanho(cd_Tamanho,cd_Produto,qt_Produto)
    values(pTamanho,vId,pItens);
    
   if(erro_sql = false) then -- se  houver algum erro na execução acima 
			commit;
			select 'transação executada com sucesso' as resultado;
		else
			rollback;
            select 'Ocorreu um erro ao executar a transação' as resultado;
	end if;
end if;
end $$
delimiter ;
desc tbl_prod_tamanho;
-- em andamento --
drop procedure if exists sp_TamECat;
Delimiter $$
create procedure sp_TamECat(
	in pCod varchar(80),
    in pQuant decimal(10,2),
    in pCat int,
    in pTamanho int,
    in pItens int
)
begin
declare vId int;
declare erro_sql tinyint default false;
declare continue handler for sqlexception set erro_sql = true;
start transaction;
    
    insert into tbl_prod_cat(cd_cat,cd_Produto)
    values(pcat,pCod);
    
    insert into tbl_prod_tamanho(cd_Tamanho,cd_Produto,qt_Produto)
    values(pTamanho,pCod,pItens);
    
   if(erro_sql = false) then -- se  houver algum erro na execução acima 
			commit;
			select 'transação executada com sucesso' as resultado;
		else
			rollback;
            select 'Ocorreu um erro ao executar a transação' as resultado;
end if;
end $$
delimiter ;

call sp_TamECat(3,1,2,1,13);

select * from tbl_prod_cat;
select * from tbl_prod_tamanho;

call sp_InsProd('Camiseta Cobra Kai V',89.90,1,2,1,10);
call sp_InsProd('Camiseta Microsoft',69.90,1,5,3,15);
call sp_InsProd('Camiseta Excel',69.90,1,5,2,8);
call sp_InsProd('Camiseta Not Found',79.90,1,6,1,5);

drop procedure if exists spMostrarProdutos;
delimiter $$
create procedure spMostrarProdutos(
	in pNomeProd varchar(80)
)
begin
select 
	tbl_produto.cd_produto as Código,
	tbl_produto.nm_produto as Produto,
    tbl_categoria.nm_cat as Categoria,
    tbl_prod_tamanho.qt_produto as Quantidade,
	tbl_produto.vl_produto as Valor,
	tbl_tamanho.sg_tamanho as Tamanho,
	tbl_produto.ds_status as Disponibilidade
	from tbl_Produto
	inner join tbl_prod_cat on tbl_prod_cat.cd_produto = tbl_produto.cd_produto
	inner join tbl_prod_tamanho on tbl_prod_tamanho.cd_produto = tbl_produto.cd_produto
	inner join tbl_categoria on tbl_categoria.cd_cat = tbl_prod_cat.cd_cat
	inner join tbl_tamanho on tbl_tamanho.cd_tamanho = tbl_prod_tamanho.cd_tamanho
    where tbl_produto.nm_produto like concat('%',pNomeProd,'%');
end $$
delimiter ;

call spMostrarProdutos('Kai'); 


drop procedure if exists spExibeClientesAtivos;
delimiter $$
create procedure spExibeClientesAtivos(
	in pTipo char(1),
    in pStatus bit
)
begin
	if (pTipo = "f") and (pStatus = 1) then
select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pf.no_CPF as CPF,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pf on tbl_cliente.cd_cliente = tbl_pf.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_cliente.ds_status = 1;
    
    else
		if (pTipo = "f") and (pStatus = 0) then
select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pf.no_CPF as CPF,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pf on tbl_cliente.cd_cliente = tbl_pf.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_cliente.ds_status = 0;
    
    else
		if (pTipo = "j") and (pStatus = 1) then
select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pj.no_CNPJ as CNPJ,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pj on tbl_cliente.cd_cliente = tbl_pj.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_cliente.ds_status = 1;
    
    else
		if (pTipo = "j") and (pStatus = 0) then
select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pj.no_CNPJ as CNPJ,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pj on tbl_cliente.cd_cliente = tbl_pj.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_cliente.ds_status = 0;
    
    end if;
    end if;
    end if;
    end if;
end $$
delimiter ; 

use db_lojaatarde;
call spExibeClientesAtivos('J',1);


call spExibeClientePFouPJ('111111111111');


drop procedure if exists spExibeClientePFouPJ;
delimiter $$
create procedure spExibeClientePFouPJ(
	in pVal varchar(14)
)
begin
declare qtd int;
set qtd = character_length(pVal);
if (qtd = 11) then
select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pf.no_CPF as CPF,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pf on tbl_cliente.cd_cliente = tbl_pf.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_pf.no_CPF = pVal; 
    else
    if ( qtd = 14) then
    select 
	tbl_cliente.cd_cliente as cod,
    tbl_cliente.nm_cliente as nome,
    tbl_cliente.nm_logradouro as log,
    tbl_cliente.no_logradouro as nolog,
    tbl_cliente.ds_complemento as complemento,
    tbl_cliente.nm_bairro as bairro,
    tbl_cliente.nm_login as login,
    tbl_cliente.ds_senha as senha,
    tbl_pj.no_CNPJ as CNPJ,
    tbl_telefonecli.no_telefone AS telefone
	from tbl_cliente
	inner join tbl_pj on tbl_cliente.cd_cliente = tbl_pj.cd_cliente
	inner join tbl_telefonecli on tbl_cliente.cd_cliente = tbl_telefonecli.cd_cliente
    where tbl_pj.no_CNPJ =pVal;
    else
    if (qtd <11) or (qtd > 14) or (qtd between 11 and 14) then
     select 'Ocorreu um erro ao executar a transação' as resultado;
    end if;
    end if;
    end if;
end $$
delimiter ; 
    
    
drop procedure if exists sp_altcadcli;
delimiter $$
	create procedure sp_altcadcli(
    pCod int,
	pTipoPessoa char(1),
	pCliente varchar(80),
	plogradouro varchar(80),
	pNumero varchar(5),
	pComplemento varchar(20),
	pBairro varchar(20),
	pLogin varchar(20),
	pSenha char(6),
	pStatus bit,
	pCPF char(11),
	pCNPJ char(14)
)
begin
	-- criação de variável
    declare cod int;
    declare erro_sql tinyint default false;
    declare continue handler for sqlexception set erro_sql = true;
	start transaction;
	if (pTipoPessoa = "F") then	-- se o valor do parametro pTipoPessoa é igual a F então execute o código abaixo
		update tbl_cliente
			set nm_Cliente = pCliente,nm_Logradouro = plogradouro,no_Logradouro = pNumero,
			ds_Complemento = pComplemento,nm_Bairro = pBairro,nm_login = pLogin,ds_senha = pSenha,ds_status = pStatus
		where cd_Cliente = pCod;   
    
		update tbl_PF
			set no_CPF= pCPF
            where cd_Cliente = pcod; -- inserindo registros na tabela PF    
	else -- caso o valor do parametro pTipoPessoa NÃO FOR IGUAL a F então ele só pode ser J, no caso execute o código abaixo
		update tbl_cliente
			set nm_Cliente = pCliente,nm_Logradouro = plogradouro,no_Logradouro = pNumero,
			ds_Complemento = pComplemento,nm_Bairro = pBairro,nm_login = pLogin,ds_senha = pSenha,ds_status = pStatus
		where cd_Cliente = pCod; 

        update tbl_PJ set no_CNPJ = pCNPJ where cd_Cliente = pCod;         
	end if;
    if(erro_sql = false) then -- se  houver algum erro na execução acima 
			commit;
			select 'transação executada com sucesso' as resultado;
		else
			rollback;
            select 'Ocorreu um erro ao executar a transação' as resultado;
    end if;
end $$
delimiter ;

call sp_altcadcli(6,"f", "Lojas Mel","Geroge Smith","85","","Jardim Íris","Lojas.Mel","15478",0,"","");

desc tbl_cliente;
desc tbl_pf;
desc tbl_pj;
       
call spExibeClientesAtivos('F',0);
call spExibeClientePFouPJ('111111111111');

