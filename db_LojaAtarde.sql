--  CRIAÇÃO DE TABELAS

create database db_LojaAtarde;

use db_LojaAtarde;

create table tbl_cliente(
cd_Cliente int primary key auto_increment,
nm_Cliente varchar(80) not null,
nm_Lougradouro varchar (80) not null,
ds_Complemento varchar (20),
nm_Bairro varchar(20) not null,
nm_Login varchar(20) not null,
ds_Senha char(6) not null
);


create table no_Telefone(
cd_Cliente int,
no_Telefone varchar(11),
CONSTRAINT foreign key(cd_Cliente) references tbl_cliente(cd_Cliente)
);


create table tbl_CliJuri(
cd_Cliente int,
no_CNPJ varchar(14) not null,
CONSTRAINT foreign key(cd_Cliente) references tbl_cliente(cd_Cliente)
);


create table tbl_CliFi(
cd_Cliente int,
no_CPF varchar(11) not null,
CONSTRAINT foreign key(cd_Cliente) references tbl_cliente(cd_Cliente)
);


create table tbl_Pagamento(
cd_Pagto int primary key auto_increment,
ds_Pagto varchar(20) not null
);

create table tbl_Carrinho(
cd_Carrinho int primary key auto_increment,
dt_Compra date not null,
vl_Compra decimal (10,2) not null,
cd_Cliente int not null,
cd_Pagto int not null,
CONSTRAINT foreign key(cd_Cliente) references tbl_cliente(cd_Cliente),
CONSTRAINT foreign key(cd_Pagto) references tbl_pagamento (cd_Pagto)
);


create table tbl_produto(
cd_Produto int primary key auto_increment,
nm_Produto varchar(80) not null,
vl_Produto decimal (10,2) not null
);

create table tbl_Itens_Carrinho(
cd_Carrinho int,
cd_Produto int,
vl_Total decimal (10,2),
qt_iIens int,
primary key(cd_Produto, cd_Carrinho),
CONSTRAINT foreign key(cd_Produto) references tbl_Produto(cd_Produto),
CONSTRAINT foreign key(cd_Carrinho) references tbl_Carrinho(cd_Carrinho)
);

create table tbl_Fornecedor(
cd_Forn int primary key auto_increment,
nm_Forn varchar(80) not null
);


create table tbl_Fone_Forn(
cd_Forn int,
no_Telefone varchar(11),
foreign key(cd_Forn) references tbl_Fornecedor(cd_Forn)
);

create table tbl_Forn_Prod(
cd_Forn int,
cd_Produto int,
dt_Compra date not null,
primary key(cd_Forn, cd_Produto),
CONSTRAINT foreign key(cd_Forn) references tbl_Fornecedor(cd_Forn),
CONSTRAINT foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);

create table tbl_Categoria(
cd_Cat int primary key auto_increment,
nm_Cat varchar(20) not null
);


create table tbl_Prod_Cat(
cd_Cat int,
cd_Produto int,
primary key(cd_Cat, cd_Produto),
foreign key(cd_Cat) references tbl_Categoria(cd_Cat),
foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);


create table tbl_Tamanho(
cd_Tamanho int primary key auto_increment,
sg_Tamanho varchar(2) not null
);


create table tbl_Prod_Tamanho(
cd_Tamanho int,
cd_Produto int,
qt_Produto int not null,
primary key(cd_Tamanho, cd_Produto),
foreign key(cd_Tamanho) references tbl_Tamanho(cd_Tamanho),
foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);

show tables;

-- COMANDO PARA CONTAR AS QUANTIDADES DE TABELAS NO BANCO DE DADOS
SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'db_lojaatarde' and TABLE_TYPE='BASE TABLE';


call sp_insCli ('F', 'Juliano Souza','Rua Camargo Coelho', '570', '', 'Vila Ipojuca', 'Juliano@hotmail.com', '123456', 1, '11122233304', '', '11999687574');
call sp_insCli ('J', 'Lojas Marisa','Rua Comandante Sampaio', '1580', '', 'Km18', 'centralma@marisa.com', 'mari@@', 1, '', '11222333100040', '12985621145');
call sp_insCli ('F','Marilia Dias Souza','Rua Senegal','12','','Jd. Felicidade', 'maribs@gmail.com','669856',1,'22233356689','','11968581213');
call sp_insCli ('F', 'João Carlos','Av Mirante do vale','1325','casa 3','Jd. Esmeralda','joca21@gmail.com','cacaca',1,'32323451166','','11988887475');


select * from tbl_cliente;
select * from tbl_pf;
select * from tbl_pj;
select * from tbl_telefonecli;

select * from tbl_tamanho;





