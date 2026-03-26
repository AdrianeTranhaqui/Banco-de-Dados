create table lista6.livro(
	idlivro serial primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	ano_publicacao date not null,
	genero varchar(100) not null,
	quantidade_estoque int not null
);

create table lista6.usuario(
	idusuario serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) unique,
	email varchar (100) unique, 
	telefone varchar(100) not null,
	endereco varchar(100) not null
);

CREATE TYPE lista5.status_tipo AS ENUM ('emprestado', 'devolvido');

create table lista6.emprestimo(
	idemprestimo serial primary key,
	idusuario int references lista5.usuario(idusuario),
	idlivro int references lista5.livro(idlivro),
	data_emprestimo date not null,
	data_devolucao date null,
	status lista5.status_tipo
);

alter table lista6.livro 
	add column editora varchar(100);

alter table lista6.livro 
 alter column ano_publicacao 
 type integer using (extract(year from ano_publicacao)::integer);

insert into lista6.livro
(titulo, autor, ano_publicacao, genero, quantidade_estoque, editora)
values
('Livro1', 'Bruna', '2000', 'Romance', '1000', 'sol'),
('Livro2', 'Alberto', '1998', 'Fantasia', '1500', 'Lercultura'),
('Livro3', 'Luis', '2013', 'Suspense', '1000', 'Saber'),
('Livro4', 'Carla', '1980', 'Terror', '2000', 'Dark'),
('Livro5', 'Alberto', '2010', 'Infantil', '1300', 'Leiturinha'),
('Livro6', 'Maria', '2001', 'Ficção científica', '2000', 'Infociencia'),
('Livro7', 'Caio', '1966', 'Infanto juvenil', '1000', 'Curioso'),
('Livro8', 'Luna', '2025', 'Romance', '1040', 'Saber'),
('Livro9', 'Paulo', '2009', 'Suspense', '2500', 'sol'),
('Livro10', 'Sofia', '2020', 'Infantil', '1000', 'Leiturinha');


insert into lista6.usuario
(nome, cpf, email, telefone, endereco)
values
('Bruna', '25825825825', 'Bruna@gmail.com', '21912341234', 'Rua1'),
('Alberto', '78978978978', 'Lucas@gmail.com', '21945674567', 'Rua2'),
('Luis', '36936936936', 'Will@gmail.com', '21923652365', 'Rua3'),
('Carla', '15915915915', 'Margarida@gmail.com', '21945874587', 'Rua4'),
('Maria', '35735735735', 'Bruno@gmail.com', '21912541254', 'Rua5');

update lista5.usuario set telefone = '21925872587' where idusuario = 5;

insert into lista6.emprestimo
(idusuario, idlivro, data_emprestimo,data_devolucao, status) 
values 
(1, 1, '2026-03-24', '2026-03-10', 'emprestado'),
(2, 2, '2026-03-20','2026-03-15', 'devolvido'),
(5, 5, '2026-03-10','2026-03-05', 'emprestado'),
(5, 5, '2026-03-10','2026-03-05', 'devolvido'),
(3, 5, '2026-03-10','2026-03-05', 'devolvido'),
(1, 7, '2026-03-10','2026-03-05', 'emprestado'),
(4, 10, '2026-03-10','2026-03-05', 'emprestado');


------------------------------------------------------------------------------------------
---------------------------------------lista6---------------------------------------------
------------------------------------------------------------------------------------------

--1. Crie um índice na tabela livro para melhorar a busca pelo campo titulo. 

create index idx_livro 
	on lista6.livro(titulo);

--2. Crie um índice na tabela emprestimo para otimizar a busca por data_emprestimo. 

create index idx_emprestimo
	on lista6.emprestimo(data_emprestimo);

--3. Crie uma VIEW chamada vw_historico_emprestimos que exiba o nome do usuário, título do
--livro, data do empréstimo e data de devolução. 

create view vw_historico_emprestimos as 
select
	us.nome as "Cliente",
	li.titulo as "Títtulo do livro",
	em.data_emprestimo as "Data do empréstimo",
	em.data_devolucao as "Data da devolução"
from 
	lista6.usuario us
inner join lista6.emprestimo em 
	on us.idusuario = em.idusuario
inner join lista6.livro li 
	on em.idlivro = li.idlivro;

select * from vw_historico_emprestimos
order by "Cliente";

--4. Explique como um índice pode melhorar a performance de uma consulta e quais são os
--impactos negativos de usar muitos índices. 

--Um índice auxilia na identificação mais rápida de uma informação contida em uma coluna
--sem precisar passar linha por linha levando mais tempo, ele utiliza algumas comparações 
--e faz uma busca mais direta. Os impactos negativos de usar muitos causa lentidão no insert,
--update e delete pois força a atualização constante das tabelas, além disso, usar muitos 
--pode aumentar o consumo de espaço em disco e também causar mais complexidade para otimizar.


--5. Teste a performance de uma consulta antes e depois de criar um índice usando EXPLAIN
--ANALYZE. (Caso já tenha criado os índices nos exercícios 1 e 2, utilize o comando DROP
--INDEX nome_indice; faça o teste, crie novamente e refaça o teste para analisar a diferença.)

drop index if exists lista6.idx_livro;

explain analyze 
select * from lista6.livro where titulo = 'Livro10';


create index idx_livro on lista6.livro(titulo);

explain analyze  
select * from lista6.livro where titulo = 'Livro10';


