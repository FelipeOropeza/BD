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
Cnpj bigint primary key unique,
Ie bigint unique,
idCli int,
foreign key (idCli) references tbcliente (idCli)
);

create table tbendereco(
Cep bigint primary key,
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
ValorUnitario decimal(8, 2) not null,
Qtd int
);

create table tbcompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(8, 2) not null,
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
CodigoBarras bigint, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
NumeroVenda int, 
foreign key (NumeroVenda) references tbvendas (NumeroVenda)
);

create table tbNotafiscal(
Nf int primary key,
TotalNota decimal(5, 2) not null,
DataEmissao date not null
);

insert into tbfornecedor (Cnpj, Nome, telefone)
values(1245678937123,'Revenda Chico Loco',11934567897),
      (1345678937123,'José Faz Tudo S/A',11934567898),
      (1445678937123,'Vadalto Entregas',11934567899),
      (1545678937123,'Astrogildo Das Estrelas',11934567800),
      (1645678937123,'Amoroso E Doce',11934567801),
      (1745678937123,'Marcelo Dedal',11934567802),
	  (1845678937123,'Franciscano Cachaça',11934567803),
	  (1945678937123,'Joãozinho Chupeta',11934567804);
      
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
create procedure spInserEst(vEstado char(2))
begin
insert into tbUF (UF) values (vEstado);
end $$

call spInserEst ("SP");
call spInserEst ("RJ");
call spInserEst ("RS");

select * from tbUF; 

delimiter $$
create procedure spInserBairro(vBairro varchar (200))
begin
insert into tbBairro (Nomebairro) values (vBairro);
end $$

call spInserBairro ("Aclimação");
call spInserBairro ("Capão Redondo");
call spInserBairro ("Pirituba");
call spInserBairro ("Liberdade");

select* from tbBairro

delimiter $$
create procedure spInserProd(vCodigoBarras bigint, vNome varchar(200),vValorUnitario decimal(5, 2), vQtd int)
begin
insert into tbProduto (CodigoBarras, Nome, ValorUnitario, Qtd) values (vCodigoBarras, vNome, vValorUnitario, vQtd);
end $$

call spInserProd (12345678910111, "Rei de papel mache", 54.61, 120);
call spInserProd (12345678910112, "Bolinha de Sabão", 100.45, 120);
call spInserProd (12345678910113, "Carro Bate Bate", 44.00, 120);
call spInserProd (12345678910114, "Bola Furada", 10.00, 120);
call spInserProd (12345678910115, "Maça Laranja", 99.44, 120);
call spInserProd (12345678910116, "Boneco do Hitler", 124.00, 200);
call spInserProd (12345678910117, "Farinha de Surui", 50.00, 200);
call spInserProd (12345678910118, "Zelador de cemiterio", 24.50, 100);

select * from tbProduto;
describe tbproduto;

delimiter $$
create procedure spInsertEnde(vCep int, vLogradouro varchar(200), vNomeBairro varchar(50), vNomeCidade varchar(50), vUF char(2))
begin
	if not exists(select Cep from tbendereco where vCep = Cep) then
    if not exists(select IdBairro from tbBairro where vNomeBairro = NomeBairro) then
		insert into tbBairro(NomeBairro) values(vNomeBairro);
	end if;
	if not exists(select IdCidade from tbCidade where vNomeCidade = NomeCidade) then
		insert into tbCidade(NomeCidade) values(vNomeCidade);
	end if;
	if not exists(select IdUf from tbUf where vUF = UF) then
		insert into tbUF (UF) values(vUF); 
    end if;
	insert into tbendereco (Cep, Logradouro, idBairro, IdCidade, IdUF)
                values(vCep, vLogradouro, (select idBairro from tbBairro where vNomeBairro = NomeBairro), (select idCidade from tbCidade where vNomeCidade = NomeCidade), 
				       (select idUf from tbUF where vUF = UF));
    else
      select "Informaçoes já registradas";
    end if;
end$$

call spInsertEnde(12345050, 'Rua da Federal', 'Lapa', 'São Paulo', 'SP');
call spInsertEnde(12345051, 'Av Brasil', 'Lapa', 'Campinas', 'SP');
call spInsertEnde(12345052, 'Rua Liberdade', 'Consolação', 'São Paulo', 'SP');
call spInsertEnde(12345053, 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEnde(12345054, 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertEnde(12345055, 'Rua Piu XI', 'Penha', 'Campinas', 'SP');
call spInsertEnde(12345056, 'Rua Chocolate', 'Aclimação', 'Barra Mansa', 'RJ');
call spInsertEnde(12345057, 'Rua Pão na Chapa', 'Barra Funda', 'Ponta Grossa', 'RS');

select * from tbBairro;
select * from tbCidade;
select * from tbUF;
select * from tbEndereco;

-- Conserta depois --

delimiter $$
create procedure spInsertCliPf(vNomeCLi varchar(200), vNumEnd int, vCompleEnd varchar(50), vCep int, vCpf bigint, vRg bigint, 
							   vRg_Dig char(1), VNasc date, vLogradouro varchar(200), vNomeBairro varchar(50), vNomeCidade varchar(50), vUF char(2))
begin
	if not exists(select Cpf from tbclientpf where vCpf = Cpf) then
       if not exists(select Cep from tbendereco where vCep = Cep) then
          if not exists(select IdBairro from tbBairro where vNomeBairro = NomeBairro) then
		  insert into tbBairro(NomeBairro) values(vNomeBairro);
          end if;
		  if not exists(select IdCidade from tbCidade where vNomeCidade = NomeCidade) then
		  insert into tbCidade(NomeCidade) values(vNomeCidade);
          end if;
	      if not exists(select IdUf from tbUf where vUF = UF) then
		  insert into tbUF (UF) values(vUF);
          end if;
          insert into tbendereco (Cep, Logradouro, idBairro, IdCidade, IdUF)
                    values(vCep, vLogradouro, (select idBairro from tbBairro where vNomeBairro = NomeBairro),
                       (select idCidade from tbCidade where vNomeCidade = NomeCidade), 
				       (select idUf from tbUF where vUF = UF));
      end if;
		insert into tbcliente(NomeCli, NumEnd, CompleEnd, Cep)
                    values(vNomeCli,vNumEnd, vCompleEnd, vCep);
		insert into tbclientpf(Cpf, Rg, Rg_dig, Nasc, Idcli)
                    values(vCpf, vRg, vRg_Dig, vNasc, (select Idcli from tbcliente where NomeCli = vNomeCli order by Idcli desc limit 1));
	else
	    select "informaçoes já resgistradas";
    end if;
end$$

call spInsertCliPf('Pumpão', 325, null, 12345051, 12345678911, 12345678, '0', '2000/10/12', 'Av Brasil', 'Lapa', 'São Paulo', 'SP');
call spInsertCliPf('Disney Chaplin', 89, 'Ap 12', 12345053, 12345678912, 12345679, '0', '2001/11/21', 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPf('Marciano', 744, null, 12345054, 12345678913, 12345680, '0', '2001/06/01', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPf('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004/04/05', 'Rua Veia', 'Jardin Santa Isabel', 'Cuiabá', 'MT');
call spInsertCliPf('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, '0', '2002/07/15', 'Av Nova', 'Jardin Santa Isabel', 'Cuiabá', 'MT');

select * from tbEndereco;
select * from tbBairro;
select * from tbclientpf;
select * from tbcliente;

delimiter $$
create procedure spInsertCliPj(vNomeCLi varchar(200), vCnpj bigint, vIe bigint, vCep int, vLogradouro varchar(200), vNumEnd int, vCompleEnd varchar(50), 
							   vNomeBairro varchar(50), vNomeCidade varchar(50), vUF char(2))
begin
	if not exists(select Cnpj from tbclientepj where vCnpj = Cnpj) then
       if not exists(select Cep from tbendereco where vCep = Cep) then
          if not exists(select IdBairro from tbBairro where vNomeBairro = NomeBairro) then
		  insert into tbBairro(NomeBairro) values(vNomeBairro);
          end if;
		  if not exists(select IdCidade from tbCidade where vNomeCidade = NomeCidade) then
		  insert into tbCidade(NomeCidade) values(vNomeCidade);
          end if;
	      if not exists(select IdUf from tbUf where vUF = UF) then
		  insert into tbUF (UF) values(vUF);
          end if;
          insert into tbendereco (Cep, Logradouro, idBairro, IdCidade, IdUF)
                    values(vCep, vLogradouro, (select idBairro from tbBairro where vNomeBairro = NomeBairro),
                       (select idCidade from tbCidade where vNomeCidade = NomeCidade), 
				       (select idUf from tbUF where vUF = UF));
      end if;
		insert into tbcliente(NomeCli, NumEnd, CompleEnd, Cep)
                    values(vNomeCli,vNumEnd, vCompleEnd, vCep);
		insert into tbclientepj(Cnpj, Ie, Idcli)
                    values(vCnpj, vIe, (select Idcli from tbcliente where NomeCli = vNomeCli order by Idcli desc limit 1));
	else
	    select "informaçoes já resgistradas";
    end if;
end$$

call spInsertCliPj('Paganada', 12345678912345, 98765432198, 12345051, 'Av Brasil', 159, null, 'Lapa', 'Campinas', 'SP');
call spInsertCliPj('Caloteando', 12345678912346, 98765432199, 12345053, 'Av Paulista', 69, null, 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPj('Semgrana', 12345678912347, 98765432100, 12345060, 'Rua dos Amores', 189, null, 'Sei Lá', 'Recife', 'PE');
call spInsertCliPj('Cemreais', 12345678912348, 98765432101, 12345060, 'Rua dos Amores', 5024, 'Sala 23', 'Sei Lá', 'Recife', 'PE');
call spInsertCliPj('Durango', 12345678912349, 98765432102, 12345060, 'Rua dos Amores', 1254, null, 'Sei Lá', 'Recife', 'PE');

select * from tbclientepj;
select * from tbcliente;
select * from tbendereco;
select * from tbUf;
select * from tbbairro;
select * from tbcidade;

delimiter $$
create procedure spInsertCom(vNotaFiscal int, vNome varchar(200), vDataCompra date, vCodigoBarras bigint, vValorItem decimal(8,2),
                             vQtd int, vQtdTotal bigint, vValorTotal decimal(8,2))
begin
	insert into tbcompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, codigo)
				  values(vNotaFiscal, vDataCompra, vValorTotal, vQtdTotal, (select codigo from tbfornecedor where vNome = Nome));
	insert into tbPedidoComprar(ValorItem, Qtd, CodigoBarras, NotaFiscal)
					     values(vValorItem, vQtd, (select CodigoBarras from tbproduto where vCodigoBarras = CodigoBarras),
                         (select NotaFiscal from tbcompra where vNotaFiscal = NotaFiscal));
end $$ 

call spInsertCom(8459, 'Amoroso e Doce', '2018/05/01', 12345678910111, 22.22, 200, 700, 21944.00);
call spInsertCom(2482, 'Revenda Chico Loco', '2020/04/22', 12345678910112, 40.50, 180, 180, 7290.00);
call spInsertCom(21563, 'Marcelo Dedal', '2020/07/12', 12345678810113, 3.00, 300, 300, 900.00);
call spInsertCom(8459, 'Amoroso e Doce', '2022/12/04', 12345678910114, 35.00, 500, 700, 21944.00);
call spInsertCom(156354, 'Revenda Chico Loco', '2021/11/23', 12345678910114, 54.00, 350, 350, 18900.00);

-- tbcompra, tbendereco, tbproduto --
 select * from tbPedidoComprar;
 select * from tbcompra;
 select * from tbfornecedor;
 select * from tbproduto;
