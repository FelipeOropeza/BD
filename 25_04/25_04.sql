create database dbaula;
use dbaula;

create table tbescola(
id int primary key auto_increment,
nome varchar(50) not null,
datanasc date,
salario decimal(5, 2)
);

insert into tbescola(nome, datanasc, salario) 
		values('Felipe', '2000/11/30', 99.50);

select * from tbescola;

insert into tbescola(nome)
			values('gato');
            
insert into tbescola(id)
	     values(default);
		
alter table tbescola modify column nome varchar(20);

insert into tbescola(id, nome, datanasc, salario)
	  values(default, 'Dante', '2022/04/25', 100);
            
insert into tbescola(nome, datanasc, salario)
			  values('Alex', '2022/04/25', 300);

insert into tbescola(datanasc, nome)
            values('2000/01/30', 'Pai');

insert into tbescola values(default, 'Alexandra', '2010/01/01', 99.50);

insert into tbescola(nome, datanasc, salario)
            values('Vovo', '2011/11/11', 100),
                  ('Tio', '2011/11/11', 200);

insert into tbescola(nome)
			values('Astrogildo estrelinha da silva de araujo');

alter table tbescola modify column nome varchar(100);

select id, nome, datanasc, salario from tbescola;

select * from tbescola;

select nome, salario from tbescola;

select salario, nome from tbescola;

delete from tbescola;

delete from tbescola where id = 14;

delete from tbescola where salario is null;

select * from tbescola where nome = 'Tio';

select * from tbescola where datanasc = '2011/11/11';

set sql_safe_updates = 0;

select 2 + 2;
select 2 - 2;
select 2 * 2;
select 2 / 2;