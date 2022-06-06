create database dbdisi;
use dbdisi;

create table tbcliente(
idCli int primary key auto_increment not null,
NomeCli varchar(200) not null,
NumEnd int null,
CompleEnd varchar(50),
Cep int not null, foreign key (Cep) references tbendereco (Cep)
);

create table tbclientpf(
Cpf bigint primary key not null,
Rg bigint not null,
Rg_dig bigint not null,
Nasc date not null,
idCli int,
foreign key (idCli) references tbcliente (idCli)
);

create table tbclientepj(
Cnpj int primary key unique,
Ie bigint unique,
idCli int,
foreign key (idCli) references tbcliente (idCli)
);

create table tbendereco(
Cep int primary key not null,
Logradouro varchar(200) not null,
idBairro int not null,
foreign key (idBairro) references tbBairro (IdBairro), 
IdCidade int not null,
foreign key (IdCidade) references tbCidade (IdCidade),
IdUF int not null,
foreign key (IdUF) references tbUF (IdUF)
);

create table tbBairro(
idBairro int primary key auto_increment,
NomeBairro varchar(200) not null
);

create table tbCidade(
idCidade int primary key auto_increment,
NomeCidade varchar(200) not null
);

create table tbUF(
idUF int primary key auto_increment, 
UF char (2) not null
);

create table tbfornecedor(
Codigo smallint auto_increment primary key,
Cnpj smallint unique,
Nome varchar(200) not null,
Telefone smallint
);

create table tbproduto(
CodigoBarras int primary key unique,
Nome varchar(200) not null,
ValorUnitario decimal(5, 2) not null,
Qtd int
);

create table tbcompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(5, 2) not null,
QtdTotal bigint not null,
codigo smallint,
foreign key (Codigo) references tbfornecedor (Codigo)
);

create table tbPedidoComprar(
ValorItem decimal(5, 2) not null,
Qtd bigint not null,
primary key(CodigoBarras, NotaFiscal),
CodigoBarras int,
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
NotaFiscal int,
foreign key (NotaFiscal) references tbcompra (NotaFiscal)
);

create table tbvendas(
NumeroVenda int primary key,
DataVenda date default '(current_timestamp())',
totalVenda decimal (5, 2) not null,
Nf int,
foreign key (Nf) references tbNotafiscal (Nf),
idCli int,
foreign key (idCli) references tbcliente (idCli)
);

-- default current_time

create table tbPedidoVenda(
ValorItem decimal(5, 2) not null,
Qtd bigint not null,
primary key(NumeroVenda, CodigoBarras),
NumeroVenda int, 
foreign key (NumeroVenda) references tbvendas (NumeroVenda),
CodigoBarras int, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
);

create table tbNotafiscal(
Nf int primary key,
TotalNota decimal(5, 2) not null,
DataEmissao date not null
);
