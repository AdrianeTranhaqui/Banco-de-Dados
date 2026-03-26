create table lista5.livro(
	idlivro serial primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	ano_publicacao date not null,
	genero varchar(100) not null,
	quantidade_estoque int not null
);

create table lista5.usuario(
	idusuario serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) unique,
	email varchar (100) unique, 
	telefone varchar(100) not null,
	endereco varchar(100) not null
);

CREATE TYPE lista5.status_tipo AS ENUM ('emprestado', 'devolvido');

create table lista5.emprestimo(
	idemprestimo serial primary key,
	idusuario int references lista5.usuario(idusuario),
	idlivro int references lista5.livro(idlivro),
	data_emprestimo date not null,
	data_devolucao date null,
	status lista5.status_tipo
);

alter table lista5.livro 
	add column editora varchar(100);

alter table lista5.livro 
 alter column ano_publicacao 
 type integer using (extract(year from ano_publicacao)::integer);

insert into lista5.livro
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

insert into lista5.usuario
(nome, cpf, email, telefone, endereco)
values
('Bruna', '25825825825', 'Bruna@gmail.com', '21912341234', 'Rua1'),
('Alberto', '78978978978', 'Lucas@gmail.com', '21945674567', 'Rua2'),
('Luis', '36936936936', 'Will@gmail.com', '21923652365', 'Rua3'),
('Carla', '15915915915', 'Margarida@gmail.com', '21945874587', 'Rua4'),
('Maria', '35735735735', 'Bruno@gmail.com', '21912541254', 'Rua5');

update lista5.usuario set telefone = '21925872587' where idusuario = 5;

insert into lista5.emprestimo
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
---------------------------------------lista5---------------------------------------------
------------------------------------------------------------------------------------------

--Conte quantos livros estão cadastrados na biblioteca usando COUNT.
select count(*) total_livros
from lista5.livro;

--Descubra a média de tempo de empréstimo dos livros utilizando AVG.
select round (avg(data_emprestimo - data_devolucao ), 2) media_dias_emprestimo 
from lista5.emprestimo;

--Encontre o livro mais antigo e o mais recente utilizando MIN e MAX.
select
    min(ano_publicacao) ano_mais_antigo, 
    max(ano_publicacao) ano_mais_recente 
from lista5.livro;

--Liste quantos empréstimos cada usuário já fez, agrupando por nome do usuário. 
select
	nome,
	count(e.idemprestimo) total_emprestimo
from lista5.usuario u
left join lista5.emprestimo e
	on u.idusuario = e.idusuario
group by nome
order by nome;

--Mostre quantos livros existem por gênero, agrupando os resultados.
select
	genero, 
	count(*) Quantidade_por_genero
from lista5.livro
group by genero
order by genero;
	
