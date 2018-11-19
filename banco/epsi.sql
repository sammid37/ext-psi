CREATE SCHEMA Bancoep;
ALTER SCHEMA Bancoep CHARSET = UTF8 COLLATE = utf8_general_ci;
USE Bancoep;
-- DROP SCHEMA Bancoep;
-- TABELAS DE USUÁRIOS

SELECT COUNT(P.matriPsi) AS tPsi FROM Psicologo P;

CREATE TABLE Usuarios(
	nome varchar(20) NOT NULL,
	sobrenome varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	matricula bigint NOT NULL,
	senha varchar(500) NOT NULL,
	sexo int NOT NULL,
	campus int NOT NULL,
	ocupa int NOT NULL,
	nasc date NOT NULL,
	primary key(matricula,ocupa)
);
INSERT INTO Usuarios VALUES ('Psicólgo','Bot','psi@mail.com',20161,md5('senha123'),1,1,1,'1989-12-07');
INSERT INTO Usuarios VALUES ('Aluno','Bot','aluno@mail.com',20162,md5('senha123'),2,1,2,'1999-09-03');
INSERT INTO Usuarios VALUES ('Administrador','Bot','admim@admEP.com',20163,md5('senha123'),1,1,3,'1977-12-31');
CREATE TABLE Psicologo(
	nome varchar(20) NOT NULL,
	sobrenome varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	matriPsi bigint NOT NULL,
	senha varchar(500) NOT NULL,
	sexo int NOT NULL,
	campus int NOT NULL,
	ocupa int NOT NULL,
	nasc date NOT NULL,
	primary key(matriPsi,ocupa)
);
CREATE TABLE Aluno(
	nome varchar(20) NOT NULL,
	sobrenome varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	matriAlu bigint NOT NULL,
	senha varchar(500) NOT NULL,
	sexo int NOT NULL,
	campus int NOT NULL,
	ocupa int NOT NULL,
	nasc date NOT NULL,
	primary key(matriAlu,ocupa)
);
INSERT INTO Psicologo VALUES ('Psicólgo','Bot','psi@mail.com',20161,md5('senha123'),1,1,1,'1989-12-07');
INSERT INTO Aluno VALUES ('Aluno','Bot','aluno@mail.com',20162,md5('senha123'),2,1,2,'1999-09-03');
SELECT*FROM Usuarios;
SELECT*FROM Psicologo;
SELECT*FROM Aluno;

-- TABELAS REFERENTES A CADASTROS DO ADM
CREATE TABLE Categoria(
	categoria int auto_increment primary key,
    catnome varchar(50)
);
CREATE TABLE Humor(
	numhumor int auto_increment primary key,
	humor varchar(50) 
);
CREATE TABLE Sala(
	sala int NOT NULL,
	salanome varchar(50),
	primary key (sala)
);
INSERT INTO Categoria VALUES (1,'Categoria Bot');
INSERT INTO Humor VALUES (1,'Humor Bot');
INSERT INTO Sala VALUES (1,'Sala Bot');
SELECT*FROM Categoria;
SELECT*FROM Humor;
SELECT*FROM Sala;
CREATE TABLE Atribuicao(
	codA int auto_increment,
	matriPsi bigint NOT NULL,
	matriAlu bigint NOT NULL,
	primary key(codA,matriPsi, matriAlu),
	foreign key(matriPsi) references Psicologo(matriPsi),
	foreign key(matriAlu) references Aluno(matriAlu)
);
SELECT*FROM Atribuicao;
SELECT DISTINCT A.nome, Atri.matriAlu FROM Atribuicao Atri, Aluno A, Psicologo P  WHERE Atri.matriAlu = 2015110909 AND Atri.matriAlu = A.matriAlu;

CREATE TABLE Exercicios(
	cod int auto_increment primary key,
	titulo varchar(100) NOT NULL,
	imgexer varchar(500) NOT NULL,
	autor varchar(50),
	origem varchar(80),
	categoria int NOT NULL,
	conteudo varchar(500) NOT NULL,
  foreign key(categoria) references Categoria(categoria)
);
SELECT*FROM Exercicios;

-- Funcionalidades referente a Alunos
CREATE TABLE Relatos(
	cod int auto_increment,
	codAutor bigint,
	titulo varchar(50) NOT NULL,
	codhumor int NOT NULL,
	privacidade int NOT NULL,
	corpo varchar(500) NOT NULL,
	primary key(cod,codhumor,privacidade),
	foreign key(codhumor) references Humor(numhumor),
	foreign key(codAutor) references Aluno(matriAlu) 
);
CREATE TABLE SolicitarEncontro(
	cod int auto_increment primary key,
	matriAlu bigint NOT NULL,
    matriPsi bigint NOT NULL,
	solicitar varchar(300) NOT NULL,
    foreign key(matriPsi) references Atribuicao(matriPsi),
	foreign key(matriAlu) references Aluno(matriAlu)
);
-- INSERT INTO SolicitarEncontro(matriAlu, solicitar) VALUES (2015110909,'Me help me psii, pls');
SELECT*FROM Relatos;
SELECT*FROM SolicitarEncontro;
SELECT DISTINCT SE.solicitar as Mensagem FROM SolicitarEncontro SE, Aluno A WHERE SE.matriAlu = 2015110909;

-- Funcionalidades referente a Psicologos
CREATE TABLE Agendamento(
	cod int auto_increment primary key,
	psicologo bigint,
	aluno bigint,
	sala int NOT NULL,
	dia date NOT NULL,
	hora time NOT NULL,
	comentario varchar(300),
	foreign key(psicologo) references Psicologo(matriPsi),
	foreign key(aluno) references Aluno(matriAlu),
	foreign key(sala) references Sala(sala)
);
SELECT*FROM Agendamento;
SELECT Al.matriAlu FROM Agendamento Ag, Aluno Al WHERE Ag.aluno = Al.nome;

-- Funcionalidade comum a Alunos e Psicólogos
-- Necessita ser incrementado, ainda
CREATE TABLE Favoritos(
	codFav int auto_increment primary key,
	codExer int,
	matricula bigint,
  foreign key(codExer) references Exercicios(cod),
  foreign key(matricula) references Usuarios(matricula)
);
SELECT*FROM Favoritos;
SELECT * FROM Aluno;
SELECT distinct P.nome, P.sobrenome, P.matriPsi 
FROM Psicologo P, Atribuicao Atri, Aluno A 
WHERE P.matriPsi = Atri.matriPsi AND A.matriAlu = 201622 AND Atri.matriAlu = 201622;

SELECT Atri.matriPsi 
FROM Psicologo P, Atribuicao Atri, Aluno A 
WHERE Atri.matriPsi = P.matriPsi AND A.matriAlu = 201622 AND Atri.matriAlu = 201622;"