create database Regina;
use Regina;

create table tbProduto(
IdProd int not null primary key,
NomeProd varchar(50) not null,
Qtd int,
DataValidade date not null,
Preco float(5, 2) not null
);

alter table tbProduto add Peso decimal(4, 2) null; -- Adiciona uma coluna em uma tabela
alter table tbProduto add Cor varchar(50) null; -- Adiciona uma coluna em uma tabela
alter table tbProduto add Marca varchar(50) not null; -- Adiciona uma coluna em uma tabela

alter table tbProduto drop column Cor; -- Excluir uma coluna de uma tabela

alter table tbProduto modify Peso decimal(5, 2) not null; -- Modifica parametros de uma coluna

alter table tbProduto drop column DataValidade; -- Excluir uma coluna de uma tabela



