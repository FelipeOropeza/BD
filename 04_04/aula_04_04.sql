CREATE DATABASE tb_felipe;
USE tb_felipe;

CREATE TABLE tb_aluno(
id int primary key auto_increment,
Nome varchar(50) not null,
CPF bigint unique not null,
Sexo char(1) default 'F',
Salario decimal (6,5) check (salario >= 0)
);

CREATE TABLE TELEFONE(
Codigo int  primary key auto_increment,
NumTel numeric(9) not null,
idAluno int not null,
constraint FK_TELEFONE_ALUNO foreign key (idaluno) references tb_aluno(id)
);

alter table TELEFONE add DDD tinyint null;
alter table TELEFONE modify column DDD tinyint null;

describe TELEFONE;

show databases;

create index IDX_tb_aluno_nome on tb_aluno(nome);

/* o index serve para nada */

rename table tb_aluno to tbaluno;
-- renomeia o nome da table

alter table tbaluno rename column Nome to NomeAlu;
-- renomeia a coluna de uma tabela

select current_timestamp(); -- Mostra o horario
select current_user(); -- Mostra o usúario que está logado