create table lista3.livro(
	idlivro serial primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	ano_publicacao date not null,
	genero varchar(100) not null,
	quantidade_estoque int not null
);

create table lista3.usuario(
	idusuario serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) unique,
	email varchar (100) unique, 
	telefone varchar(100) not null,
	endereco varchar(100) not null
);

CREATE TYPE lista3.status_tipo AS ENUM ('emprestado', 'devolvido');

create table lista3.emprestimo(
	idemprestimo serial primary key,
	idusuario int references lista3.usuario(idusuario),
	idlivro int references lista3.livro(idlivro),
	data_emprestimo date not null,
	data_devolucao date null,
	status lista3.status_tipo
);

alter table lista3.livro 
	add column editora varchar(100);

alter table lista3.livro 
 alter column ano_publicacao 
 type integer using (extract(year from ano_publicacao)::integer);

insert into lista3.livro
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

select * from lista3.livro;

insert into lista3.usuario
(nome, cpf, email, telefone, endereco)
values
('Bruna', '25825825825', 'Bruna@gmail.com', '21912341234', 'Rua1'),
('Alberto', '78978978978', 'Lucas@gmail.com', '21945674567', 'Rua2'),
('Luis', '36936936936', 'Will@gmail.com', '21923652365', 'Rua3'),
('Carla', '15915915915', 'Margarida@gmail.com', '21945874587', 'Rua4'),
('Maria', '35735735735', 'Bruno@gmail.com', '21912541254', 'Rua5');


select * from lista3.usuario;

update lista3.usuario set telefone = '21925872587' where idusuario = 5;

insert into lista3.emprestimo
(idusuario, idlivro, data_emprestimo,data_devolucao, status) 
values 
(1, 1, '2026-03-24','2026-03-30', 'emprestado');

select * from lista3.emprestimo;

DELETE FROM lista3.usuario WHERE idusuario = 1; 
