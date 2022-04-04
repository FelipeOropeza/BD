create database dbDesenvolvimento;
use dbDesenvolvimento;

create table tbProduto(
idProp int not null primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preco float not null
);

alter table tbProduto add Peso float null;
alter table tbProduto add Cor varchar(50) null;
alter table tbProduto add Marca varchar(50) not null;

alter table tbProduto drop Cor;

alter table tbProduto modify Peso float not null;

alter table tbProduto drop Cor;
/* Já foi realizado esse comando*/

create database dbLojagrande;
use dbLojagrande;

create table tbProduto(
idProp int not null primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preco float not null
);

alter table tbProduto add Cor varchar(50) null;




