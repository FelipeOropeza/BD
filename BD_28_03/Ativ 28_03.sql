create database Alexandra;
use Alexandra;

create table tbVenda(
NF int not null primary key auto_increment,
DataValidade date not null
);

alter table tbVenda add Preco decimal(5, 2) not null;

alter table tbVenda add Qtd tinyint;

alter table tbVenda drop column DataValidade;

alter table tbVenda add DataVenda date default('28/03/2022');

create table Produto(
CodigoB int(13) not null primary key,
NomeProd varchar(50) not null
);

create table tbVenda(
NF int not null primary key auto_increment,
DataValidade date not null,
IdCod int,
constraint fkCodVen
foreign key (IdCod) references Produto (Id)
);