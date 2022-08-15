create database dbdfe;
use dbdfe;

create table tbcliente(
idCli int primary key auto_increment not null,
NomeCli varchar(200) not null,
NumEnd int null,
CompleEnd varchar(50),
Cep bigint not null, foreign key (Cep) references tbendereco (Cep)
);

create table tbclientpf(
Cpf bigint primary key not null,
Rg bigint not null,
Rg_dig char(1) not null,
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
Cep bigint primary key not null,
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
Cnpj bigint unique,
Nome varchar(200) not null,
Telefone bigint unique
);

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
call spInsety ("Capão Redondo");
call spInsety ("Pirituba");
call spInsety ("Liberdade");
CALL spInsety ("Lapa");

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
create procedure spInsertEnde(vCep int, vLogradouro varchar(200), vNomeBairro varchar(50), vNomeCidade varchar(50), vUF char(2))
begin
	if not exists(select* from tbendereco where vCep = Cep) then
    if not exists(select * from tbBairro where vNomeBairro = NomeBairro) then
		insert into tbBairro(NomeBairro) values(vNomeBairro);
	else if not exists(select * from tbCidade where vNomeCidade = NomeCidade) then
		insert into tbCidade(NomeCidade) values(vNomeCidade);
	else if not exists(select * from tbUf where vUF = UF) then
		insert into tbUF (UF) values(vUF); 
	else insert into tbendereco (Cep, Logradouro, idBairro, IdCidade, IdUF)
                values(vCep, vLogradouro, (select idBairro from tbBairro where vNomeBairro = NomeBairro), (select idCidade from tbCidade where vNomeCidade = NomeCidade), 
				       (select idUf from tbUF where vUF = UF));
	end if;
    end if;
    end if;
    else
      select "Informaçoes já registradas";
    end if;
end$$
select idBairro from tbBairro where NomeBairro = "Lapa";

call spInsertEnde(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
call spInsertEnde(12345051, 'Av Brasil', 'Lapa',  , 1);
call spInsertEnde(12345052, 'Rua Liberdade', 6, 9, 1);
call spInsertEnde(12345053, 'Av Paulista', 7, 1, 2);
call spInsertEnde(12345054, 'Rua Ximbú', 7, 1, 2);
call spInsertEnde(12345055, 'Rua Piu XI', 7, 3, 1);
call spInsertEnde(12345056, 'Rua Chocolate', 1, 10, 2);
call spInsertEnde(12345057, 'Rua Pão na Chapa', 8, 8, 3);
call spInsertEnde(12345058, 'Av Nova', 9, 11, 4);
call spInsertEnde(12345059, 'Rua Veia', 9, 11, 4);

select * from tbBairro;
select * from tbCidade;
select * from tbUF;
select * from tbEndereco;

delimiter $$
create procedure spInsertCliPf(vNomeCLi varchar(200), vNumEnd int, CompleEnd varchar(50), vCep int, vCpf bigint, vRg bigint, 
							   vRg_Dig char(1), VNasc date, vLogradouro varchar(200), vIdBairro int, vIdCidade int, vIdUF int)
begin
	if not exists(select * from tbclientpf where vCpf = Cpf) then
		insert into tbcliente(NomeCli, NumEnd, CompleEnd, Cep)
                    values(vNomeCli,vNumEnd, CompleEnd, vCep);
		insert into tbclientpf(Cpf, Rg, Rg_dig, Nasc, Idcli)
                    values(vCpf, vRg, vRg_Dig, vNasc, (select Idcli from tbcliente where NomeCli = vNomeCli order by Idcli desc limit 1));
	    insert into tbendereco(Cep, Logradouro, idBairro, IdCidade, IdUF)
					values(vCep, vLogradouro, vIdBairro, vIdCidade, vIdUF);
	else
	    select "informaçoes já resgistradas";
    end if;
end$$

call spInsertCliPf('Pumpão', 325, null, 12345051, 12345678911, 12345678, '0', '2000/10/12', 'Av Brasil', 5, 3, 1);
call spInsertCliPf('Disney Chaplin', 89, 'Ap 12', 12345053, 12345678912, 12345679, '0', '2001/11/21', 'Av Paulista', 7, 1, 2);
call spInsertCliPf('Marciano', 744, null, 12345054, 12345678913, 12345680, '0', '2001/06/01', 'Rua Ximbú', 7, 1, 2);
call spInsertCliPf('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004/04/05', 'Rua Veia', 9, 11, 4);
call spInsertCliPf('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, '0', '2002/07/15', 'Av Nova', 9, 11, 4);

delete from tbendereco where cep = 12345051;
select * from tbEndereco;
select * from tbBairro;
select * from tbclientpf;
select * from tbcliente;

delimiter $$
create procedure spInsertCliPj(vNomeCLi varchar(200), vNumEnd int, vCompleEnd varchar(50), vCnpj bigint, vIe bigint,
                               vCep bigint, vLogradouro varchar(200), vNomeBairro varchar(50), vCidade varchar(50), vUF char(2))

begin
	if not exists(select * from tbclientepj where vCnpj = Cnpj) then
		insert into tbcliente(NomeCli, NumEnd, CompleEnd)
                    values(vNomeCli,vNumEnd, vCompleEnd);
		insert into tbclientepj(Cnpj, Ie, Idcli)
                    values(vCnpj, vIe, (select Idcli from tbcliente where NomeCli = vNomeCli order by Idcli desc limit 1));
	    insert into tbendereco(Cep, Logradouro, idBairro, IdCidade, IdUF)
					values((select Cep from tbEndereco where Logradouro = vLogradouro), vLogradouro, (select idBairro from tbBairro where NomeBairro = vNomeBairro),(select idCidade from tbCidade where NomeCidade = vCidade),
						(select idUf from tbUf where UF = vUF));
	else
	    select "informaçoes já resgistradas";
    end if;
end$$

call spInsertCliPj("Paganada", 159, null,12345678912345, 98765432198, 13254051, "Av Brasil", "Lapa", "Campinas", "SP");
