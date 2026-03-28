create table lista4.livro(
	idlivro serial primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	ano_publicacao date not null,
	genero varchar(100) not null,
	quantidade_estoque int not null
);

create table lista4.usuario(
	idusuario serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) unique,
	email varchar (100) unique, 
	telefone varchar(100) not null,
	endereco varchar(100) not null
);

CREATE TYPE lista4.status_tipo AS ENUM ('emprestado', 'devolvido');

create table lista4.emprestimo(
	idemprestimo serial primary key,
	idusuario int references lista4.usuario(idusuario),
	idlivro int references lista4.livro(idlivro),
	data_emprestimo date not null,
	data_devolucao date null,
	status lista4.status_tipo
);

alter table lista4.livro 
	add column editora varchar(100);

alter table lista4.livro 
 alter column ano_publicacao 
 type integer using (extract(year from ano_publicacao)::integer);

insert into lista4.livro
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

insert into lista4.usuario
(nome, cpf, email, telefone, endereco)
values
('Bruna', '25825825825', 'Bruna@gmail.com', '21912341234', 'Rua1'),
('Alberto', '78978978978', 'Lucas@gmail.com', '21945674567', 'Rua2'),
('Luis', '36936936936', 'Will@gmail.com', '21923652365', 'Rua3'),
('Carla', '15915915915', 'Margarida@gmail.com', '21945874587', 'Rua4'),
('Maria', '35735735735', 'Bruno@gmail.com', '21912541254', 'Rua5');

update lista4.usuario set telefone = '21925872587' where idusuario = 5;

insert into lista4.emprestimo
(idusuario, idlivro, data_emprestimo,data_devolucao, status) 
values 
(1, 1, '27-02-2026', '27-03-2026', 'emprestado'),
(2, 2, '20-02-2026', '20-03-2026', 'devolvido'),
(5, 5, '25-02-2026', '28-03-2026', 'emprestado'),
(5, 5, '10-02-2026', '10-02-2026', 'devolvido'),
(3, 5, '15-02-2026', '15-03-2026', 'devolvido'),
(1, 7, '27-02-2026', '27-03-2026', 'emprestado'),
(4, 10, '28-02-2026' ,'28-03-2026', 'emprestado');
-----------------------------------------------------------------------------------------
--------------------------------------lista4---------------------------------------------
-----------------------------------------------------------------------------------------

--Selecione todos os livros cadastrados no banco de dados.
select * from lista4.livro;


--Liste o nome do usuário e o título do livro de todos os empréstimos realizados, utilizando um JOIN. 

select 
	nome,
	titulo
from lista4.usuario us
join lista4.emprestimo em 
	on us.idusuario = em.idusuario
join lista4.livro li 
	on em.idlivro = li.idlivro
order by nome;

--Selecione todos os empréstimos que ainda não foram devolvidos (status = 'emprestado').

select * from lista4.emprestimo 
where status = 'emprestado';

--Liste todos os autores e os livros que eles escreveram. 

select 
	autor,
	titulo 
from lista4.livro 
order by autor;

--Crie uma consulta que mostre todos os usuários e os livros que já pegaram emprestado,
--incluindo usuários que nunca pegaram livros.

select 
	nome "Usuário",
	titulo "Livro emprestado"
from lista4.usuario u
left join lista4.emprestimo e 
	on u.idusuario = e.idusuario
left join lista4.livro l 
	on e.idlivro = l.idlivro;
