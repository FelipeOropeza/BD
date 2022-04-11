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

create table tbEst(
idUF tinyint primary key,
nomeUFS char (2) not null,
nomeEstado varchar (40) not null
);

alter table tbEndereco add constraint Fk_idUF_tbEndereco foreign key (IdUF) references tbEst (IdUF);

create table tbCliente(
idCli int not null primary key,
NomeCli varchar(50) not null,
NumEnd bigint,
DataCadastro datetime default ('datetime')
);

create table tbEndereco(
Cep decimal(5,0) not null primary key,
Logradouro varchar(250) not null,
idUF tinyint null
);

alter table tbCliente add constraint Fk_Cep_tbCliente foreign key (Cep) references tbEndereco(Cep);

alter table tbCliente add CPF decimal(11,0) unique not null;

alter table tbCliente add Cep decimal(5,0) null;

alter table tbCliente modify column NomeCli varchar(50) null;
alter table tbcliente modify column NumEnd smallint check (NumEnd <= 32767);
alter table tbCliente modify column DataCadastro date default ('curdate()');
alter table tbCliente modify column CPF decimal(11,0) unique null;

create database dbEmpresa;

describe tbCliente;

alter table tbEst drop column NomeEstado;

rename table tbEst to tbEstado;

alter table tbEstado rename column NomeUFs to nomeUF 

alter table tbEndereco add idCid mediumint

alter table tbCidade modify column nomeCidade varchar (250) not null

alter table tbEndereco add constraint Fk_tbCid_tbEndereco foreign key () references ();

create table tbCidade(
idCid mediumint primary key,
nomeCidade varchar (50) not null
);
