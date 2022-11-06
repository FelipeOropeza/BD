create database dbdfe;
use dbdfe;

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
idCliPf int,
foreign key (idCliPf) references tbcliente (idCli)
);

create table tbclientepj(
Cnpj bigint primary key unique,
Ie bigint unique,
idCliPj int,
foreign key (idCliPj) references tbcliente (idCli)
);

create table tbNotafiscal(
Nf int primary key auto_increment,
TotalNota decimal(7, 2) not null,
DataEmissao date not null
);

create table tbfornecedor(
Codigo smallint auto_increment primary key,
Cnpj bigint unique,
Nome varchar(200) not null,
Telefone bigint unique
);

create table tbcompra(
NotaFiscal int primary key,
DataCompra date not null,
ValorTotal decimal(8, 2) not null,
QtdTotal bigint not null,
CodComp smallint,
foreign key (CodComp) references tbfornecedor (Codigo)
);

create table tbproduto(
CodigoBarras bigint primary key,
Nome varchar(200) not null,
ValorUnitario decimal(8, 2) not null,
Qtd int
);

create table tbPedidoComprar(
ValorItem decimal(5, 2) not null,
Qtd bigint not null,
primary key(NotaFiscal, CodigoBarras),
NotaFiscal int,
foreign key (NotaFiscal) references tbcompra (NotaFiscal),
CodigoBarras bigint,
foreign key (CodigoBarras) references tbproduto (CodigoBarras)
);

create table tbvendas(
NumeroVenda int primary key auto_increment,
DataVenda datetime,
totalVenda decimal (7, 2) not null,
Nf int,
foreign key (Nf) references tbNotafiscal (Nf),
idCli int,
foreign key (idCli) references tbcliente (idCli)
);

create table tbPedidoVenda(
ValorItem decimal(6, 2) not null,
Qtd bigint not null,
primary key(NumeroVenda, CodigoBarras),
CodigoBarras bigint, 
foreign key (CodigoBarras) references tbproduto (CodigoBarras),
NumeroVenda int, 
foreign key (NumeroVenda) references tbvendas (NumeroVenda)
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

delimiter $$
create procedure spInserEst(vEstado char(2))
begin
insert into tbUF (UF) values (vEstado);
end $$

call spInserEst ("SP");
call spInserEst ("RJ");
call spInserEst ("RS");

delimiter $$
create procedure spInserBairro(vBairro varchar (200))
begin
insert into tbBairro (Nomebairro) values (vBairro);
end $$

call spInserBairro ("Aclimação");
call spInserBairro ("Capão Redondo");
call spInserBairro ("Pirituba");
call spInserBairro ("Liberdade");

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
		insert into tbclientpf(Cpf, Rg, Rg_dig, Nasc, Idclipf)
                    values(vCpf, vRg, vRg_Dig, vNasc, (select Idcli from tbcliente where NomeCli = vNomeCli order by Idcli desc limit 1));
	else
	    select "informaçoes já resgistradas";
    end if;
end$$

call spInsertCliPf('Pimpão', 325, null, 12345051, 12345678911, 12345678, '0', '2000/10/12', 'Av Brasil', 'Lapa', 'São Paulo', 'SP');
call spInsertCliPf('Disney Chaplin', 89, 'Ap 12', 12345053, 12345678912, 12345679, '0', '2001/11/21', 'Av Paulista', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPf('Marciano', 744, null, 12345054, 12345678913, 12345680, '0', '2001/06/01', 'Rua Ximbú', 'Penha', 'Rio de Janeiro', 'RJ');
call spInsertCliPf('Lança Perfume', 128, null, 12345059, 12345678914, 12345681, 'X', '2004/04/05', 'Rua Veia', 'Jardin Santa Isabel', 'Cuiabá', 'MT');
call spInsertCliPf('Remédio Amargo', 2585, null, 12345058, 12345678915, 12345682, '0', '2002/07/15', 'Av Nova', 'Jardin Santa Isabel', 'Cuiabá', 'MT');

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
		insert into tbclientepj(Cnpj, Ie, Idclipj)
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

delimiter $$
create procedure spInsertCom(vNotaFiscal int, vNome varchar(200), vDataCompra date, vCodigoBarras bigint, vQtd int, vQtdTotal bigint, vValorTotal decimal(8, 2))
begin
	set @CodBarra = (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras);
    set @ValorItem = (select ValorUnitario from tbProduto where CodigoBarras = vCodigoBarras);
    
	if (select codigo from tbFornecedor where vNome = Nome) then
		if (select CodigoBarras from tbProduto where CodigoBarras = @CodBarra) then
			if not exists(select NotaFiscal from tbCompra where vNotaFiscal = NotaFiscal) then
	insert into tbcompra(NotaFiscal, DataCompra, ValorTotal, QtdTotal, CodComp)
				  values(vNotaFiscal, vDataCompra, vValorTotal, vQtdTotal, (select codigo from tbfornecedor where vNome = Nome));
    end if;
    insert into tbPedidoComprar(ValorItem, Qtd, CodigoBarras, NotaFiscal)
					     values(@ValorItem, vQtd, @CodBarra, (select NotaFiscal from tbcompra where vNotaFiscal = NotaFiscal));
    else
        select('Produto Não cadastrado');
    end if;
    else  
		select('Fornecedor Não cadastrado!');
    end if;
end $$ 

call spInsertCom(8459, 'Amoroso e Doce', '2018/05/01', 12345678910111, 200, 700, 21944.00);
call spInsertCom(2482, 'Revenda Chico Loco', '2020/04/22', 12345678910112, 180, 180, 7290.00);
call spInsertCom(21563, 'Marcelo Dedal', '2020/07/12', 12345678910113, 300, 300, 900.00);
call spInsertCom(8459, 'Amoroso e Doce', '2022/12/04', 12345678910114, 500, 700, 21944.00);
call spInsertCom(156354, 'Revenda Chico Loco', '2021/11/23', 12345678910115, 350, 350, 18900.00);


select * from tbCompra;
select * from tbPedidoComprar;
select * from tbProduto;

-- QtdTotal é a soma do itens comprados

delimiter $$
create procedure spInsertVenda(vCliente varchar(200), vDataVenda date, vCodigoBarras bigint, vQtd bigint, vNF int)
begin
	set @IdCli = (select IdCli from tbCliente where NomeCli = vCliente);
    set @CodBarras = (select CodigoBarras from tbProduto where CodigoBarras = vCodigoBarras);
    set @ValorItem = (select ValorUnitario from tbProduto where CodigoBarras = vCodigoBarras);
    set @TotalVenda = (select ValorUnitario from tbProduto where CodigoBarras = vCodigoBarras) * vQtd;

	insert into tbVendas(NumeroVenda, DataVenda, TotalVenda, NF, IdCli) values (default, vDataVenda, @TotalVenda, vNF, @IdCli);
	insert into tbPedidoVenda(ValorItem, Qtd, CodigoBarras, NumeroVenda) values (@ValorItem, vQtd, @CodBarras, (select NumeroVenda from tbVendas order by NumeroVenda desc limit 1));
end $$

call spInsertVenda('Pimpão','2022/08/22',12345678910111, 1, null);
call spInsertVenda('Lança Perfume', '2022/08/22', 12345678910112, 2, null);
call spInsertVenda('Pimpão', '2022/08/22', 12345678910113, 1, null);

select * from tbProduto;

delimiter $$
create procedure spInsertNF(vNomeCli varchar(200))
begin
declare vIdCli int;
set vIdCLi = (select idCli from tbcliente where vNomeCli = NomeCli);
		
        if not exists(select idCli from tbVendas where idCli = null) then
        insert tbNotaFiscal(NF, TotalNota, DataEmissao)
					 values(default, (SELECT SUM(TotalVenda) from tbvendas where idCli = vidCli), (SELECT CURDATE()));
		else
			select 'Cliente não realizou pedido!';
		end if;
        update tbVendas set NF = (select Nf from tbNotaFiscal order by Nf desc limit 1) where IdCli = vIdCli; 
end $$

call spInsertNF('Pimpão');
call spInsertNF('Lança Perfume'); 

/* create view vwEndereco as
select 
	tbendereco.cep,
    tbendereco.logradouro,
    tbBairro.NomeBairro,
    tbCidade.NomeCidade,
    tbUf.Uf
    from tbendereco inner join tbCidade
    on (tbendereco.idcidade = tbcidade.idcidade)
    inner join tbBairro
    on (tbendereco.Idbairro = tbBairro.IdBairro)
       inner join tbUF
    on (tbendereco.IdUF = tbUF.IdUF);
    
select * from vwEndereco; */

call spInserProd(12345678910130, 'Camiseta de Poliéster', 35.61, 100);
call spInserProd(12345678910131, 'Blusa Frio Moletom', 200.00, 100);
call spInserProd(12345678910132, 'Vestido Decote Redondo', 144.00, 50);

delimiter $$
create procedure spDeleteProd(vCodBarras bigint)
begin
	if exists(select * from tbProduto where codigoBarras = vCodBarras) then
		delete from tbProduto where codigoBarras = vCodBarras;
	else
		select("O Produto não existe!");
end if;
end $$

select * from tbProduto;
call spDeleteProd(12345678910116);
call spDeleteProd(12345678910117);

delimiter $$
create procedure spUpdateProd(vCodigoBarras bigint, vNomeProd varchar(200), vValorUnitario decimal(8,2))
begin
	if exists(select * from tbProduto where codigoBarras = vCodigoBarras) then
	update tbproduto set Nome = vNomeProd, ValorUnitario = vValorUnitario where CodigoBarras = vCodigoBarras;
    else
    select 'Produto não existe';
    end if;
end $$

call spUpdateProd(12345678910111, 'Rei de Papel Mache', 64.50);
call spUpdateProd(12345678910112, 'Bolinha de Sabão', 120.00);
call spUpdateProd(12345678910113, 'Carro Bate Bate', 64.00);

select * from tbproduto;

delimiter $$
create procedure spSelectProd()
begin
	select * from tbProduto;
end $$

call spSelectProd();

create table tbProdHist like tbProduto;
alter table tbProdHist add Ocorrencia varchar(20);
alter table tbProdHist add Atualizacao datetime;
alter table tbProdHist drop primary key;
alter table tbProdHist add primary key(Ocorrencia, Atualizacao, CodigoBarras);
describe tbProdHist;

Delimiter $$
create trigger trgInsertProd after insert on tbProduto
	for each row
begin
	insert into tbProdHist set
		CodigoBarras = new.CodigoBarras,
                    Nome = new.Nome,
                    ValorUnitario = new.Valorunitario,
                    Qtd = new.Qtd,
                    Ocorrencia = "Novo",
                    Atualizacao = current_timestamp();
end $$
call spInserProd(12345678910119, 'Agua Mineral', 1.99, 500);
select * from tbProdHist;

delimiter $$
create trigger tgrUpdateProd after update on tbProduto
	for each row
begin
	insert into tbProdHist
		set  CodigoBarras = new.CodigoBarras,
			Nome = new.Nome,
			ValorUnitario = new.ValorUnitario,
			Qtd = new.Qtd, 
			Ocorrencia = 'Atualizado',
			Atualizacao = current_timestamp();
end$$

call spUpdateProd(12345678910119, 'Agua Mineral', 2.99);

call spSelectProd();
select * from tbProdHist;

call spInsertVenda('Disney Chaplin', '2022/09/26', 12345678910111, 1, null);

select * from tbVendas order by NumeroVenda desc limit 1;
select * from tbPedidoVenda order by NumeroVenda desc limit 1;
select * from tbProduto;

delimiter $$
create procedure spSelectCli(vNomeCli varchar(200))
begin
	select * from tbCliente where NomeCli = vNomeCli;
end $$

call spSelectCli('Disney Chaplin');

delimiter $$
create trigger trgUpVenda after insert on tbPedidoVenda
	for each row
begin
	update tbProduto 
    set Qtd = Qtd - new.Qtd 
    where CodigoBarras = new.CodigoBarras; 
end $$

select * from tbPedidoVenda;
select * from tbVendas;
select * from tbProduto;
call spInsertVenda('Paganada', '2022/09/26', 12345678910114, 15, null);

delimiter $$
create trigger trgUpCompra after insert on tbPedidoComprar for each row
	begin
        update tbProduto set 
        Qtd = Qtd + new.Qtd
        where CodigoBarras = new.CodigoBarras;
	end;
$$

call spInsertCom(10548, 'Amoroso e Doce', '2022/09/10', 12345678910111, 100, 100, 4000.00);

-- EX 32--
select * from tbcliente
inner join tbclientpf on tbcliente.IdCli = tbclientpf.IdClipf;

-- EX 33--
select * from tbcliente
inner join tbclientepj on tbcliente.IdCli = tbclientepj.IdClipj;

-- EX 34--
select
tbcliente.IdCli,
tbcliente.NomeCli,
tbclientepj.Cnpj,
tbclientepj.Ie,
tbclientepj.IdClipj from tbcliente
inner join tbclientepj on tbcliente.IdCli = tbclientepj.IdClipj;

-- EX 35--
select
tbcliente.Idcli "Codigo",
tbcliente.NomeCli "Nome",
tbclientpf.Cpf "CPF",
tbclientpf.Rg "RG",
tbclientpf.Nasc "Data de Nascimento" from tbcliente
inner join tbclientpf on tbcliente.IdCli = tbclientpf.IdClipf;

-- EX 36--
select * from tbcliente
inner join tbclientepj on tbcliente.IdCli = tbclientepj.IdClipj
inner join tbendereco on tbcliente.cep = tbendereco.cep;

-- EX 37--
select 
tbcliente.IdCli "Id", 
tbcliente.NomeCli "NomeCli", 
tbcliente.NumEnd "NumEnd", 
tbcliente.CompleEnd "CompEnd", 
tbcliente.Cep "CEP", 
tbendereco.logradouro "Logradouro", 
tbbairro.NomeBairro "Bairro", 
tbcidade.NomeCidade "Cidade", 
tbuf.UF "UF" from tbcliente
inner join tbclientepj on tbcliente.IdCli = tbclientepj.IdClipj
inner join tbendereco on tbcliente.cep = tbendereco.cep
inner join tbbairro on tbendereco.Idbairro = tbbairro.Idbairro
inner join tbcidade on tbendereco.Idcidade = tbcidade.IdCidade
inner join tbuf on tbendereco.IdUf = tbuf.idUF;

-- EX 38 --

DELIMITER $$
create procedure spSelectInnerCliPF(vIdCli int)
begin
	select 
	tbcliente.IdCli "Código", 
	tbcliente.NomeCli "Nome", 
	tbcliente.NumEnd "Número", 
	tbcliente.CompleEnd "Complemento", 
	tbcliente.Cep "CEP",
    tbclientpf.Cpf "CPF",
    tbclientpf.Rg "RG",
    tbclientpf.Rg_dig "Dígito",
    tbclientpf.Nasc "Data de Nascimento",
	tbendereco.logradouro "Logradouro", 
	tbbairro.NomeBairro "Bairro", 
	tbcidade.NomeCidade "Cidade", 
	tbuf.UF "UF" from tbcliente
	inner join tbclientpf on tbcliente.IdCli = tbclientpf.idCliPF
	inner join tbendereco on tbcliente.cep = tbendereco.cep
	inner join tbbairro on tbendereco.Idbairro = tbbairro.Idbairro
	inner join tbcidade on tbendereco.Idcidade = tbcidade.IdCidade
	inner join tbuf on tbendereco.IdUf = tbuf.idUF where idCli = vIdCli;
end;
$$

call spSelectInnerCliPF(2);
call spSelectInnerCliPF(11);

-- EX 39 --
select * from tbproduto
	left join tbpedidovenda on tbproduto.CodigoBarras = tbPedidoVenda.CodigoBarras;
    
-- EX 40 --
select * from tbCompra
	right join tbFornecedor on tbFornecedor.Codigo = tbCompra.CodComp;
    
-- EX 41 --
select
	tbFornecedor.Codigo "Código",
    tbFornecedor.Cnpj "CNPJ",
    tbFornecedor.Nome "Nome",
    tbFornecedor.Telefone "Telefone"
	from tbcompra
	right join tbfornecedor on tbCompra.CodComp = tbfornecedor.Codigo where tbcompra.CodComp is null;
    
-- EX 42 --
select
	tbCliente.idCli "Id",
    tbCliente.NomeCli "NomeCli",
    tbVendas.DataVenda "DataVenda",
    tbPedidoVenda.CodigoBarras "CodigoBarras",
    tbProduto.Nome "Nome",
    tbPedidoVenda.ValorItem "ValorItem"
    from tbCliente
    inner join tbVendas on tbCliente.idCli = tbVendas.idCli
    inner join tbPedidoVenda on tbvendas.NumeroVenda = tbPedidoVenda.NumeroVenda
    inner join tbProduto on tbPedidoVenda.CodigoBarras = tbProduto.CodigoBarras order by tbCliente.NomeCli;
    
-- EX 43 ==

select 
	tbBairro.NomeBairro,
    tbCliente.Cep,
    tbCliente.NomeCli,
	tbCliente.IdCli,
    tbEndereco.Cep,
    tbVendas.IdCli,
    tbVendas.NumeroVenda,
    tbVendas.Nf
	from tbBairro
	left join tbEndereco on tbBairro.Idbairro = tbEndereco.IdBairro
    left join tbCliente on tbEndereco.Cep = tbCliente.Cep
    left join tbVendas on tbCliente.IdCli = tbVendas.IdCli
    where tbVendas.IdCli is null;
    
select * from tbpedidovenda;
select * from tbendereco;
select * from tbcliente;
