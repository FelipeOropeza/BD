create database dbdistri;
use dbdistri;

create table tbcliente(
idCli int primary key auto_increment not null,
NomeCli varchar(50) not null,
NumEnd int,
Cpf bigint not null,
Cnpj int not null,
Cep int not null, foreign key (Cep) references tbendereco (Cep)
);

create table tbclientpf(
Cpf bigint primary key not null,
Rg bigint not null,
Rg_dig bigint,
Nasc date
);

create table tbclientep(
Cnpj int primary key not null,
Ie bigint not null
);

create table tbendereco(
Cep int primary key not null,
Logradouro int,
Bairro varchar(50) not null,
Cidade varchar(30) unique not null,
UF char(2) not null,
CompleEnd varchar(50)
);

create table tbfornecedor(
Codigo int auto_increment primary key,
Cnpj bigint not null,
Nome varchar(50) not null,
Telefone int unique not null
);

create table tbproduto(
CodigoBarras int primary key not null,
Nome varchar(50) not null,
ValorUnitario bigint not null,
Qtd bigint not null
);

create table tbvendas(
NumeroVenda int primary key auto_increment,
DataVenda date,
totalVenda bigint
);

create table tbcompra(
NotaFiscal int primary key not null,
DataCompra date not null,
ValorTotal decimal(7,2) not null,
QtdTotal bigint not null
);

create table tbNotafical(
Nf int primary key,
TotalNota bigint,
DataEmissao date
);

create table tbPedidoComprar(
ValorItem decimal(7,2) not null,
Qtd bigint not null
);

create table tbPedidoVenda(
ValorItem decimal(7,2) not null,
Qtd bigint not null
); 




