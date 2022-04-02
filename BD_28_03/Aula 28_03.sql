create database dbYZ;
use dbYz;

create table tbMargarida(
Id int primary key auto_increment, -- Coloca o numero por si só em ordem crecente
Nome varchar(50),
Sexo char(1) not null,
Uf char(2) default('SP'), -- Caso não seja digitado um valor, colocara SP
Cpf bigint unique null -- Faz que o dado não se repita
);

create table tbfilha(
Id int primary key,
Nome varchar(10),
IdDaOutra int,
constraint fkMargOutra -- Da um nome para a chave estrangeira
foreign key (IdDaOutra) references tbMargarida (Id) -- Faz a ligação de uma tabela com a outra 
);

show tables; -- Mostra as tabelas no banco de dados

drop table tbfilha