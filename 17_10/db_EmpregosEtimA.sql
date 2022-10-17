create database db_EmpregosEtimA;
use db_EmpregosEtimA;

create table tbl_empregos(
	Registro int primary key,
    Nome varchar(200) not null,
    Cargo varchar(20) not null,
    Area varchar(25) not null,
    Salario decimal(10, 2) not null,
    Status varchar(8) not null
);

describe tbl_empregos;

select * from tbl_empregos;
select Cargo, Area from tbl_empregos;

select * from tbl_empregos group by Cargo;