create table lista2.livro(
	idlivro serial primary key,
	titulo varchar(100) not null,
	autor varchar(100) not null,
	ano_publicacao date not null,
	genero varchar(100) not null,
	quantidade_estoque int not null
);

create table lista2.usuario(
	idusuario serial primary key,
	nome varchar(100) not null,
	cpf varchar(11) unique,
	email varchar (100) unique, 
	telefone varchar(100) not null,
	endereco varchar(100) not null
);

CREATE TYPE lista2.status_tipo AS ENUM ('emprestado', 'devolvido');
create table lista2.emprestimo(
	idemprestimo serial primary key,
	idusuario int not null,
	idlivro int not null,
	data_emprestimo date not null,
	data_devolucao date null,
	status lista2.status_tipo,

	CONSTRAINT fk_idusuario 
        FOREIGN KEY (idusuario) 
        REFERENCES lista2.usuario (idusuario),

	CONSTRAINT fk_idlivro 
        FOREIGN KEY (idlivro) 
        REFERENCES lista2.livro (idlivro)
);

ALTER TABLE lista2.livro 
	ADD COLUMN editora VARCHAR(100);

