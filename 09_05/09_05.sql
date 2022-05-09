create database dbpokemon;
use dbpokemon;

create table tbaluno(
id int primary key auto_increment,
nome varchar(50),
sexo char,
nascimento date
);

alter table tbaluno rename column id to rm;

insert into tbaluno (rm, nome, sexo, nascimento)
			 value(1, 'Bob', 'M', '2000/01/22'),
				  (2, 'Astrogildo', 'M', '2000/03/15'),
                  (3, 'Monica', 'F', '2000/02/11'),
                  (4, 'Juju', 'F', '2000/02/28');
                  
select * from tbaluno;

delete from tbaluno where rm;

set sql_safe_updates = 0;

truncate tbaluno;

update tbaluno set sexo = "F";
update tbaluno set sexo = "M" where rm = 1 or rm = 2;
update tbaluno set sexo = "M", nome = "Jujubinha" where rm = 4;