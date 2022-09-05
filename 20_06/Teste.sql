create database dbFuncionario;
use dbFuncionario;

create table tbFuncionario(
FuncId int primary key auto_increment,
FuncNome varchar(200),
FuncEmail varchar(200)
);

insert into tbFuncionario(FuncNome, FuncEmail)
				   values('José Mario', 'jose@escola.com'),
                         ('Antonio Pedro', 'ant@escola.com'),
                         ('Monica Cascão', 'moc@escola.com');
select * from tbFuncionario;