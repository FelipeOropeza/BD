create database dbdfe;
use dbdfe;

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

alter table tbfornecedor modify column Cnpj bigint unique;
alter table tbfornecedor modify column Telefone bigint unique;


create table tbproduto(
CodigoBarras bigint primary key unique,
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
CodigoBarras bigint,
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
NotaFiscal int,
foreign key (NotaFiscal) references tbcompra (NotaFiscal)
);

create table tbvendas(
NumeroVenda int primary key,
DataVenda date,
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
CodigoBarras bigint, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
);

create table tbNotafiscal(
Nf int primary key,
TotalNota decimal(5, 2) not null,
DataEmissao date not null
);

insert into tbfornecedor (Cnpj, Nome, telefone)
values('1245678937123','Revenda Chico Loco','11934567897'),
      ('1345678937123','José Faz Tudo S/A','11934567898'),
      ('1445678937123','Vadalto Entregas','11934567899'),
      ('1545678937123','Astrogildo Das Estrelas','11934567800'),
      ('1645678937123','Amoroso E Doce','11934567801'),
      ('1745678937123','Marcelo Dedal','11934567802'),
	  ('1845678937123','Franciscano Cachaça','11934567803'),
	  ('1945678937123','Joãozinho Chupeta','11934567804');
      
select * from tbfornecedor;

delimiter $$
create procedure spInsertCid(vNomeCida varchar(200))
begin
insert into tbCidade (NomeCidade) values (vNomeCida);
end $$

call spInsertCid ("Rio de Janeiro");
call spInsertCid ("São Carlos");
call spInsertCid ("Campinas");
call spInsertCid ("Franco da Rocha");
call spInsertCid ("Osasco");
call spInsertCid ("Pirituba");
call spInsertCid ("Lapa");
call spInsertCid ("Ponta Grossa");
call spInsertCid("São Paulo");
call spInsertCid("Barra Mansa");

select * from tbCidade;

delimiter $$
create procedure spInsertest(vEstado char(2))
begin
insert into tbUF (UF) values (vEstado);
end $$

call spInsertest ("SP");
call spInsertest ("RJ");
call spInsertest ("RS");

select * from tbUF; 

delete from tbCidade where IdCidade = 3; 

delimiter $$
create procedure spInsety(vBairro varchar (200))
begin
insert into tbBairro (Nomebairro) values (vBairro);
end $$

call spInsety ("Aclimação");
call spInsety("Capão Redondo");
call spInsety ("Pirituba");
call spInsety ("Liberdade");
call spInsety("Lapa");
call spInsety("Consolação");
call spInsety("Penha");
call spInsety("Barra Funda");

select* from tbBairro

delimiter $$
create procedure spInsetyix(vCodigoBarras bigint, vNome varchar(200),vValorUnitario decimal(5, 2), vQtd int)
begin
insert into tbProduto (CodigoBarras, Nome, ValorUnitario, Qtd) values (vCodigoBarras, vNome, vValorUnitario, vQtd);
end $$

call spInsetyix ('12345678910111', "Rei de papel mache", 54.61, "120");
call spInsetyix ('12345678910112', "Bolinha de Sabão", 100.45, "120");
call spInsetyix ('12345678910113', "Carro Bate Bate", 44.00, "120");
call spInsetyix ('12345678910114', "Bola Furada", 10.00, "120");
call spInsetyix ('12345678910115', "Maça Laranja", 99.44, "120");
call spInsetyix ('12345678910116', "Boneco do Hitler", 124.00, "200");
call spInsetyix ('12345678910117', "Farinha de Surui", 50.00, "200");
call spInsetyix ('12345678910118', "Zelador de cemiterio", 24.50, "100");

select * from tbProduto;

delimiter $$
create procedure spInsertEnde(vCep int, vLogradouro varchar(200), vIdBairro int, vIdCidade int, vIdUF int)
begin
	if not exists(select* from tbendereco where vCep = Cep) then
    insert into tbendereco(Cep, Logradouro, idBairro, IdCidade, IdUF)
                values(vCep, vLogradouro, vIdBairro, vIdCidade, vIdUF);
	else
      select "Informaçoes já registradas";
    end if;
end$$


call spInsertEnde(12345050, 'Rua da Federal', 5, 9, 1);
call spInsertEnde(12345051, 'Av Brasil', 5, 3, 1);
call spInsertEnde(12345052, 'Rua Liberdade', 6, 9, 1);
call spInsertEnde(12345053, 'Av Paulista', 7, 1, 2);
call spInsertEnde(12345054, 'Rua Ximbú', 7, 1, 2);
call spInsertEnde(12345055, 'Rua Piu XI', 7, 3, 1);
call spInsertEnde(12345056, 'Rua Chocolate', 1, 10, 2);
call spInsertEnde(12345057, 'Rua Pão na Chapa', 8, 8, 3);

select * from tbBairro;
select * from tbCidade;
select * from tbUF;
select * from tbEndereco;
