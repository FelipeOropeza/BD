create database dbdisi;
use dbdisi;

create table tbcliente(
idCli int primary key auto_increment not null,
NomeCli varchar(50) not null,
NumEnd int not null,
Cpf bigint not null,
Cnpj int not null,
Cep int not null, foreign key (Cep) references tbendereco (Cep),
NumeroVenda int, 
foreign key (NumeroVenda) references tbvendas (Numerovendas)
);

create table tbclientpf(
Cpf bigint primary key not null,
Rg bigint not null,
Rg_dig bigint,
Nasc date not null,
CPF bigint not null, 
foreign key (CPF) references tbCliente (CPF)
);

create table tbclientepj(
Cnpj int primary key not null,
Ie bigint not null,
CNPJ int not null,
foreign key (CNPJ) references tbcliente (CNPJ)
);

create table tbendereco(
Cep int primary key not null,
IdLogradouro int not null,
foreign key (IdLogradouro) references tblogra (IdLogradouro),
idBairro varchar(30) not null,
foreign key (idBairro) references tbBairro (IdBairro), 
IdCidade varchar(30) not null,
foreign key (IdCidade) references tbCidade (IdCidade),
IdUF char(2) not null,
foreign key (IdUF) references tbUF (IdUF),
CompleEnd varchar(50)
);

create table tbBairro(
idBairro int primary key auto_increment,
NomeBairro varchar(30) not null
);

create table tbCidade(
idCidade int primary key auto_increment,
NomeCidade varchar(20) not null
);

create table tbUF(
idUF int primary key auto_increment, 
UF char (2) not null
);

create table tblogra(
idLogradouro int primary key auto_increment,
nomeLogradouro varchar(30) not null
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
NumeroVenda int primary key auto_increment not null,
DataVenda date not null,
totalVenda bigint not null,
Nf int not null,
foreign key (Nf) references tbNotafiscal (Nf)
);

create table tbcompra(
NotaFiscal int primary key not null,
DataCompra date not null,
ValorTotal decimal(7,2) not null,
QtdTotal bigint not null,
codigo int not null,
foreign key (Codigo) references tbfornecedor (Codigo)
);

create table tbNotafiscal(
Nf int primary key not null,
TotalNota bigint not null,
DataEmissao date not null
);

create table tbPedidoComprar(
ValorItem decimal(7,2) not null,
Qtd bigint not null,
CodigoBarras int not null, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
NotaFiscal int not null,
foreign key (NotaFiscal) references tbcompra (NotaFiscal)
);

create table tbPedidoVenda(
idPedidoVenda int primary key,
ValorItem decimal(7,2) not null,
Qtd bigint not null,
NumeroVenda int not null, 
foreign key (NumeroVenda) references tbvendas (NumeroVenda),
CodigoBarras int not null, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
); 

