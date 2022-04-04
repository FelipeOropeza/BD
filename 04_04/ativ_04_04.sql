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

create database dbLogica;
use dbLogica;

create table tbCliente(
NomeCli varchar (50) not null,
Codigocli int primary key,
DataCadastro date not null
);

create table tbFuncionario(
NomeFunc varchar(50) not null,
CodigoFunc int primary key,
DataCadastro datetime not null
);

drop database dblojagrande;

alter table tbCliente add CPT bigint not null unique;

-- Felipe e Andriely

create database dbEscola;
use dbEscola;

create table tbCliente(
idCli int not null primary key 
);
