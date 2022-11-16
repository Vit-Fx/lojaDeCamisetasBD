alter table tbl_cliente
add column no_logradouro varchar(5) not null;

describe tbl_telefonecli;

alter table tbl_cliente
drop column no_logradouro;

alter table tbl_cliente
add column no_logradouro varchar(5) not null
after nm_lougradouro;

alter table tbl_cliente
add column ds_status bit not null;

alter table tbl_cliente
change column nm_lougradouro nm_logradouro varchar(80) not null;

alter table no_telefone 
rename to tbl_TelefoneCli;

show tables;

-- alterando o tipo de dado do campo no_telefone para char(11) 
alter table tbl_telefonecli
modify column no_Telefone char(11) not null;

alter table tbl_clifi
rename to tbl_pf;

alter table tbl_clijuri
rename to tbl_pj;

desc tbl_pj;

alter table tbl_pf
modify column no_CPF char(11) not null;

alter table tbl_pj
modify column no_CNPJ char(14) not null;

alter table tbl_produto
add column ds_status bit not null;

alter table tbl_categoria
add column ds_status bit not null;

-- aula 16/08

alter table tbl_pf
add primary key(cd_cliente, no_CPF);

desc tbl_telefonecli;

alter table tbl_pj
add primary key(cd_cliente, no_CNPJ);

alter table tbl_telefonecli
add primary key (cd_cliente, no_telefone);