create database dbBanco;
use dbBanco;

create table tbhistorico(
Cpf bigint, 
NumeroConta int, 
DataInicio date,
primary key(Cpf, NumeroConta),
constraint Cpf foreign key(Cpf) references tbcliente(Cpf),
constraint FK_NumeroConta foreign key(NumeroConta) references tbconta(NumeroConta)
);

create table tbconta(
NumeroConta int primary key,
Saldo decimal (7, 2),
TipoConta smallint,
NumAgencia int,
constraint Fk_NumAgencia foreign key(NumAgencia) references tbagencia(NumeroAgencia)
);

alter table tbconta modify column NumAgencia int not null;

create table tbagencia(
CodBanco int,
NumeroAgencia int primary key,
Endereço varchar (50) not null,
constraint Fk_CodBanco foreign key(CodBanco) references tbbanco(Codigo)
);

create table tbcliente(
Cpf bigint primary key,
Nome varchar(50) not null,
Sexo char(1) not null,
Endereço varchar(50) not null
);

create table tbtelefone_Cliente(
Cpf bigint,
Telefone int,
primary key(Telefone),
constraint Fk_Cpf foreign key(Cpf) references tbcliente(Cpf)
);

create table tbbanco(
Codigo int,
Nome varchar(50) not null,
primary key(Codigo)
);

insert into tbbanco(codigo, nome)
            values(1, 'Banco do Brasil'),
                  (104, 'Caixa Economica Federal'),
                  (801, 'Banco Escola');
                  
select * from tbbanco;

insert into tbagencia(CodBanco, NumeroAgencia, Endereço)
			values(1, 123, 'Av Paulista,78'),
                  (104, 159, 'Rua Liberdade,124'),
                  (801, 401, 'Rua Vinte três.23'),
                  (801, 485, 'Av Marechal,68');
                  
select * from tbagencia;

insert into tbcliente (cpf, Nome, Sexo, Endereço)
            values(12345678910, 'Enildo','M', 'Rua Grande,75'),
                  (12345678911, 'Astrogildo', 'M', 'Rua Pequeno,789'),
                  (12345678912, 'Monica', 'F', 'Av Larga,148'),
                  (12345678913, 'Cascão', 'M', 'Av Principal,369');
                  
select * from tbcliente;

insert into tbconta (NumeroConta, Saldo, TipoConta, NumAgencia)
            values(9876, 456.05, 1, 123),
				  (9877, 320.00, 1, 123),
                  (9878, 100.00, 2, 485),
                  (9879, 5589.48, 1, 401);
                  
select * from tbconta;

insert into tbhistorico(Cpf, NumeroConta, DataInicio)
             values(12345678910, 9876, '2001/04/15'),
			       (12345678911, 9877, '2011/03/10'),
                   (12345678912, 9878, '2021/03/11'),
                   (12345678913, 9879, '2000/07/05');

insert into tbtelefone_Cliente(cpf, telefone)
						values(12345678910, 912345678),
                              (12345678911, 912345679),
                              (12345678912, 912345680),
                              (12345678913, 912345681);

select * from tbhistorico;

select * from  tbtelefone_Cliente;

alter table tbcliente add column email varchar(100);

select cpf, endereço from tbcliente where nome = 'Monica';

select NumeroAgencia, Endereço from tbagencia where CodBanco = '801';

select * from tbcliente where Sexo = 'M';

delete from tbtelefone_Cliente where cpf = 12345678911;

update tbconta set tipoconta = "2" where numeroconta = 9879;
update tbcliente set email = 'Astro@Escola.com' where nome = 'monica';
update tbconta set Saldo = 10%456.05 where numeroconta = 9876;

select nome, email, endereço from tbcliente where nome = 'monica';

update tbcliente set email = 'enildo@escola.com' where nome = 'enildo';

update tbconta set Saldo = 
