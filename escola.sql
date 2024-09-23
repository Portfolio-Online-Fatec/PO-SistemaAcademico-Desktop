-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.39 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para escola
CREATE DATABASE IF NOT EXISTS `escola` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `escola`;

-- Copiando estrutura para tabela escola.alunos
CREATE TABLE IF NOT EXISTS `alunos` (
  `raAluno` int NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE KEY `codigoMatriculaAluno_UNIQUE` (`raAluno`),
  KEY `fk_ALUNOS_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.alunos: ~4 rows (aproximadamente)
INSERT INTO `alunos` (`raAluno`, `usuarioID`) VALUES
	(1001, 1),
	(1002, 3),
	(1003, 5),
	(1004, 7);

-- Copiando estrutura para tabela escola.atividades
CREATE TABLE IF NOT EXISTS `atividades` (
  `atividadeID` int NOT NULL AUTO_INCREMENT,
  `tituloAtividade` varchar(45) NOT NULL,
  `pesoAtividade` varchar(45) NOT NULL,
  `descricaoAtividade` varchar(200) DEFAULT NULL,
  `turmaID` int NOT NULL,
  PRIMARY KEY (`atividadeID`),
  KEY `fk_ATIVIDADES_TURMAS1_idx` (`turmaID`),
  CONSTRAINT `fk_ATIVIDADES_TURMAS1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.atividades: ~4 rows (aproximadamente)
INSERT INTO `atividades` (`atividadeID`, `tituloAtividade`, `pesoAtividade`, `descricaoAtividade`, `turmaID`) VALUES
	(1, 'Trabalho de História', '2', 'Análise de eventos históricos', 1),
	(2, 'Prova de Matemática', '3', 'Prova sobre funções e equações', 1),
	(3, 'Apresentação de Ciências', '1', 'Apresentação sobre ecossistemas', 2),
	(4, 'Atividade Prática de Química', '2', 'Experimentos sobre reações químicas', 2);

-- Copiando estrutura para tabela escola.boletins
CREATE TABLE IF NOT EXISTS `boletins` (
  `boletimID` int NOT NULL AUTO_INCREMENT,
  `notaFinalBoletim` decimal(3,1) NOT NULL,
  `frequenciaFinalBoletim` float NOT NULL,
  `situacaoAlunoDisciplina` enum('aprovado','reprovado') DEFAULT NULL,
  `usuarioID` int NOT NULL,
  `turmaID` int NOT NULL,
  PRIMARY KEY (`boletimID`),
  KEY `fk_boletins_USUARIOS1_idx` (`usuarioID`),
  KEY `fk_boletins_TURMAS1_idx` (`turmaID`),
  CONSTRAINT `fk_boletins_TURMAS1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`),
  CONSTRAINT `fk_boletins_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.boletins: ~4 rows (aproximadamente)
INSERT INTO `boletins` (`boletimID`, `notaFinalBoletim`, `frequenciaFinalBoletim`, `situacaoAlunoDisciplina`, `usuarioID`, `turmaID`) VALUES
	(9, 9.5, 90, 'aprovado', 1, 2),
	(10, 8.7, 80.5, 'aprovado', 3, 2),
	(11, 7.0, 70, 'reprovado', 5, 1),
	(12, 6.5, 60, 'reprovado', 7, 1);

-- Copiando estrutura para tabela escola.chamadas
CREATE TABLE IF NOT EXISTS `chamadas` (
  `situacaoID` int NOT NULL AUTO_INCREMENT,
  `faltasAluno` tinyint NOT NULL,
  `dataChamada` date DEFAULT NULL,
  `usuarioID` int NOT NULL,
  `turmaID` int NOT NULL,
  PRIMARY KEY (`situacaoID`),
  KEY `fk_chamadas_USUARIOS1_idx` (`usuarioID`),
  KEY `fk_chamadas_TURMAS1_idx` (`turmaID`),
  CONSTRAINT `fk_chamadas_TURMAS1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`),
  CONSTRAINT `fk_chamadas_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.chamadas: ~4 rows (aproximadamente)
INSERT INTO `chamadas` (`situacaoID`, `faltasAluno`, `dataChamada`, `usuarioID`, `turmaID`) VALUES
	(1, 1, '2023-09-01', 1, 2),
	(2, 0, '2023-09-01', 5, 1),
	(3, 1, '2023-09-01', 7, 1),
	(4, 0, '2023-09-01', 3, 2);

-- Copiando estrutura para tabela escola.cursos
CREATE TABLE IF NOT EXISTS `cursos` (
  `cursoID` int NOT NULL AUTO_INCREMENT,
  `nomeCurso` varchar(75) NOT NULL,
  `siglaCurso` varchar(10) NOT NULL,
  `tipoDuração` enum('semestral','anual') NOT NULL,
  `periodoCurso` enum('vespertino','matutino','noturno') NOT NULL,
  `tipoGraduacaoCurso` enum('Bacharelado','Licenciatura','Tecnólogo','Mestrado','Doutorado') NOT NULL,
  `descricaoCurso` longtext NOT NULL,
  PRIMARY KEY (`cursoID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.cursos: ~2 rows (aproximadamente)
INSERT INTO `cursos` (`cursoID`, `nomeCurso`, `siglaCurso`, `tipoDuração`, `periodoCurso`, `tipoGraduacaoCurso`, `descricaoCurso`) VALUES
	(1, 'Ciência da Computação', 'CC', 'semestral', 'vespertino', 'Bacharelado', 'Curso voltado para o desenvolvimento de habilidades em programação e tecnologia.'),
	(2, 'Pedagogia', 'Ped', 'anual', 'matutino', 'Licenciatura', 'Curso destinado à formação de professores para a educação básica.');

-- Copiando estrutura para tabela escola.diasnaoletivos
CREATE TABLE IF NOT EXISTS `diasnaoletivos` (
  `diasNaoLetivosID` int NOT NULL AUTO_INCREMENT,
  `dataDia` varchar(45) DEFAULT NULL,
  `descricaoDia` varchar(45) DEFAULT NULL,
  `turmaID` int NOT NULL,
  PRIMARY KEY (`diasNaoLetivosID`),
  KEY `fk_diasNaoLetivos_TURMAS1_idx` (`turmaID`),
  CONSTRAINT `fk_diasNaoLetivos_TURMAS1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.diasnaoletivos: ~2 rows (aproximadamente)
INSERT INTO `diasnaoletivos` (`diasNaoLetivosID`, `dataDia`, `descricaoDia`, `turmaID`) VALUES
	(1, '2023-04-21', 'Tiradentes', 1),
	(2, '2023-06-15', 'Feriado de São João', 2);

-- Copiando estrutura para tabela escola.disciplinas
CREATE TABLE IF NOT EXISTS `disciplinas` (
  `disciplinaID` int NOT NULL AUTO_INCREMENT,
  `nomeDisciplina` varchar(75) NOT NULL,
  `siglaDisciplina` varchar(10) NOT NULL,
  `aulasSemanaisDisciplina` int NOT NULL,
  `aulasTotaisSemestreDisciplina` int NOT NULL,
  `cargaHorariaDisciplina` time NOT NULL,
  `ementa` longtext NOT NULL,
  `turmaID` int NOT NULL,
  `cursoID` int NOT NULL,
  PRIMARY KEY (`disciplinaID`),
  KEY `fk_disciplinas_TURMAS1_idx` (`turmaID`),
  KEY `fk_disciplinas_CURSOS1_idx` (`cursoID`),
  CONSTRAINT `fk_disciplinas_CURSOS1` FOREIGN KEY (`cursoID`) REFERENCES `cursos` (`cursoID`),
  CONSTRAINT `fk_disciplinas_TURMAS1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.disciplinas: ~8 rows (aproximadamente)
INSERT INTO `disciplinas` (`disciplinaID`, `nomeDisciplina`, `siglaDisciplina`, `aulasSemanaisDisciplina`, `aulasTotaisSemestreDisciplina`, `cargaHorariaDisciplina`, `ementa`, `turmaID`, `cursoID`) VALUES
	(1, 'Programação I', 'PROG1', 4, 60, '60:00:00', 'Introdução à programação e lógica de programação.', 1, 1),
	(2, 'Banco de Dados', 'BD', 3, 45, '45:00:00', 'Conceitos de banco de dados e SQL.', 1, 1),
	(3, 'Estruturas de Dados', 'ED', 4, 60, '60:00:00', 'Estudo de estruturas de dados e algoritmos.', 1, 1),
	(4, 'Sistemas Operacionais', 'SO', 2, 30, '30:00:00', 'Conceitos de sistemas operacionais.', 1, 1),
	(5, 'Didática', 'DID', 3, 45, '45:00:00', 'Fundamentos da didática e métodos de ensino.', 2, 2),
	(6, 'Psicologia da Educação', 'PSICO', 2, 30, '30:00:00', 'Estudo da psicologia aplicada à educação.', 2, 2),
	(7, 'Educação Inclusiva', 'EDUCI', 2, 30, '30:00:00', 'Práticas de inclusão no ambiente escolar.', 2, 2),
	(8, 'Avaliação Educacional', 'AVAL', 3, 45, '45:00:00', 'Conceitos de avaliação na educação.', 2, 2);

-- Copiando estrutura para tabela escola.emailusuarios
CREATE TABLE IF NOT EXISTS `emailusuarios` (
  `emailID` int NOT NULL AUTO_INCREMENT,
  `emailUsuario` varchar(100) NOT NULL,
  `tipoEmail` varchar(60) DEFAULT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`emailID`),
  UNIQUE KEY `emailAluno_UNIQUE` (`emailUsuario`),
  KEY `fk_emailUsuarios_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_emailUsuarios_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.emailusuarios: ~8 rows (aproximadamente)
INSERT INTO `emailusuarios` (`emailID`, `emailUsuario`, `tipoEmail`, `usuarioID`) VALUES
	(1, 'ana.silva@example.com', 'Pessoal', 1),
	(2, 'carlos.oliveira@example.com', 'Profissional', 2),
	(3, 'julia.costa@example.com', 'Pessoal', 3),
	(4, 'fernando.almeida@example.com', 'Profissional', 4),
	(5, 'mariana.santos@example.com', 'Pessoal', 5),
	(6, 'roberto.ferreira@example.com', 'Profissional', 6),
	(7, 'luiza.martins@example.com', 'Pessoal', 7),
	(8, 'tiago.ramos@example.com', 'Profissional', 8);

-- Copiando estrutura para tabela escola.enderecousuarios
CREATE TABLE IF NOT EXISTS `enderecousuarios` (
  `enderecoUsuarioID` int NOT NULL AUTO_INCREMENT,
  `cepUsuario` varchar(10) NOT NULL,
  `bairroUsuario` varchar(45) NOT NULL,
  `logradouroUsuario` varchar(60) NOT NULL,
  `numResidenciaUsuario` int NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`enderecoUsuarioID`),
  KEY `fk_enderecoUsuarios_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_enderecoUsuarios_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.enderecousuarios: ~8 rows (aproximadamente)
INSERT INTO `enderecousuarios` (`enderecoUsuarioID`, `cepUsuario`, `bairroUsuario`, `logradouroUsuario`, `numResidenciaUsuario`, `usuarioID`) VALUES
	(1, '01000-000', 'Centro', 'Rua A', 100, 1),
	(2, '02000-000', 'Jardim', 'Rua B', 200, 2),
	(3, '03000-000', 'Vila', 'Rua C', 300, 3),
	(4, '04000-000', 'Alameda', 'Rua D', 400, 4),
	(5, '05000-000', 'Praça', 'Rua E', 500, 5),
	(6, '06000-000', 'Lagoa', 'Rua F', 600, 6),
	(7, '07000-000', 'Parque', 'Rua G', 700, 7),
	(8, '08000-000', 'Planalto', 'Rua H', 800, 8);

-- Copiando estrutura para tabela escola.horarios
CREATE TABLE IF NOT EXISTS `horarios` (
  `horarioID` int NOT NULL AUTO_INCREMENT,
  `horaInicio` time DEFAULT NULL,
  `horaFim` time DEFAULT NULL,
  `disciplinaID` int NOT NULL,
  PRIMARY KEY (`horarioID`),
  KEY `fk_horarios_disciplinas1_idx` (`disciplinaID`),
  CONSTRAINT `fk_horarios_disciplinas1` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.horarios: ~8 rows (aproximadamente)
INSERT INTO `horarios` (`horarioID`, `horaInicio`, `horaFim`, `disciplinaID`) VALUES
	(1, '08:00:00', '09:30:00', 1),
	(2, '09:45:00', '11:15:00', 2),
	(3, '11:30:00', '13:00:00', 3),
	(4, '14:00:00', '15:30:00', 4),
	(5, '08:00:00', '09:30:00', 5),
	(6, '09:45:00', '11:15:00', 6),
	(7, '11:30:00', '13:00:00', 7),
	(8, '14:00:00', '15:30:00', 8);

-- Copiando estrutura para tabela escola.matriculas
CREATE TABLE IF NOT EXISTS `matriculas` (
  `matriculaID` int NOT NULL AUTO_INCREMENT,
  `situacaoAlunoMatricula` enum('ativo','pendente','inativo') NOT NULL,
  `dataMatricula` date NOT NULL,
  `cursoID` int NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`matriculaID`),
  KEY `fk_ALUNOS_has_CURSOS_CURSOS1_idx` (`cursoID`),
  KEY `fk_matriculas_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_CURSOS_CURSOS1` FOREIGN KEY (`cursoID`) REFERENCES `cursos` (`cursoID`),
  CONSTRAINT `fk_matriculas_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.matriculas: ~8 rows (aproximadamente)
INSERT INTO `matriculas` (`matriculaID`, `situacaoAlunoMatricula`, `dataMatricula`, `cursoID`, `usuarioID`) VALUES
	(1, 'ativo', '2023-01-10', 1, 2),
	(2, 'pendente', '2023-02-15', 1, 1),
	(3, 'inativo', '2023-03-20', 1, 3),
	(4, 'ativo', '2023-04-25', 1, 4),
	(5, 'ativo', '2023-05-30', 2, 6),
	(6, 'pendente', '2023-06-15', 2, 5),
	(7, 'inativo', '2023-07-10', 2, 7),
	(8, 'ativo', '2023-08-20', 2, 8);

-- Copiando estrutura para tabela escola.notas
CREATE TABLE IF NOT EXISTS `notas` (
  `notaID` int NOT NULL AUTO_INCREMENT,
  `nota` decimal(4,2) NOT NULL,
  `atividadeID` int NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`notaID`),
  KEY `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1_idx` (`atividadeID`),
  KEY `fk_notas_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1` FOREIGN KEY (`atividadeID`) REFERENCES `atividades` (`atividadeID`),
  CONSTRAINT `fk_notas_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.notas: ~8 rows (aproximadamente)
INSERT INTO `notas` (`notaID`, `nota`, `atividadeID`, `usuarioID`) VALUES
	(1, 9.50, 3, 1),
	(2, 8.00, 4, 1),
	(3, 7.75, 3, 3),
	(4, 10.00, 4, 3),
	(5, 6.50, 1, 5),
	(6, 8.25, 2, 5),
	(7, 9.00, 1, 7),
	(8, 7.50, 2, 7);

-- Copiando estrutura para tabela escola.professores
CREATE TABLE IF NOT EXISTS `professores` (
  `titulacaoProfessor` varchar(45) NOT NULL,
  `formacaoProfessor` varchar(30) NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  KEY `fk_PROFESSORES_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_PROFESSORES_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.professores: ~4 rows (aproximadamente)
INSERT INTO `professores` (`titulacaoProfessor`, `formacaoProfessor`, `usuarioID`) VALUES
	('Mestre', 'Educação Física', 2),
	('Doutor', 'Matemática', 4),
	('Especialista', 'Química', 6),
	('Mestre', 'História', 8);

-- Copiando estrutura para tabela escola.secretarias
CREATE TABLE IF NOT EXISTS `secretarias` (
  `adminID` int NOT NULL AUTO_INCREMENT,
  `usuarioAdmin` varchar(45) NOT NULL,
  `emailAdmin` varchar(50) NOT NULL,
  `senhaAdmin` varchar(30) NOT NULL,
  PRIMARY KEY (`adminID`),
  UNIQUE KEY `email_UNIQUE` (`emailAdmin`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.secretarias: ~1 rows (aproximadamente)
INSERT INTO `secretarias` (`adminID`, `usuarioAdmin`, `emailAdmin`, `senhaAdmin`) VALUES
	(1, 'adminPrincipal', 'admin@escola.com', 'senhaSegura123');

-- Copiando estrutura para tabela escola.telefoneadmins
CREATE TABLE IF NOT EXISTS `telefoneadmins` (
  `telefoneAdminID` int NOT NULL AUTO_INCREMENT,
  `telefoneFixo` varchar(15) NOT NULL,
  `numCelular` varchar(15) NOT NULL,
  `adminID` int NOT NULL,
  PRIMARY KEY (`telefoneAdminID`),
  UNIQUE KEY `telefoneFixo_UNIQUE` (`telefoneFixo`),
  UNIQUE KEY `numCelular_UNIQUE` (`numCelular`),
  KEY `fk_telefoneAdmins_ADMINISTRACOES1_idx` (`adminID`),
  CONSTRAINT `fk_telefoneAdmins_ADMINISTRACOES1` FOREIGN KEY (`adminID`) REFERENCES `secretarias` (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.telefoneadmins: ~1 rows (aproximadamente)
INSERT INTO `telefoneadmins` (`telefoneAdminID`, `telefoneFixo`, `numCelular`, `adminID`) VALUES
	(1, '(11) 1234-5678', '(11) 91234-5678', 1);

-- Copiando estrutura para tabela escola.telefoneusuarios
CREATE TABLE IF NOT EXISTS `telefoneusuarios` (
  `telefoneUsuarioID` int NOT NULL AUTO_INCREMENT,
  `tipoTelefone` varchar(45) DEFAULT NULL,
  `telefoneUsuario` varchar(20) NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`telefoneUsuarioID`),
  UNIQUE KEY `telefoneAluno_UNIQUE` (`telefoneUsuario`),
  KEY `fk_telefoneAlunos_ALUNOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_telefoneAlunos_ALUNOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.telefoneusuarios: ~8 rows (aproximadamente)
INSERT INTO `telefoneusuarios` (`telefoneUsuarioID`, `tipoTelefone`, `telefoneUsuario`, `usuarioID`) VALUES
	(1, 'Celular', '11-91234-5678', 1),
	(2, 'Fixo', '11-1234-5678', 2),
	(3, 'Celular', '21-91234-5678', 3),
	(4, 'Fixo', '21-1234-5678', 4),
	(5, 'Celular', '31-91234-5678', 5),
	(6, 'Fixo', '31-1234-5678', 6),
	(7, 'Celular', '41-91234-5678', 7),
	(8, 'Fixo', '41-1234-5678', 8);

-- Copiando estrutura para tabela escola.turmas
CREATE TABLE IF NOT EXISTS `turmas` (
  `turmaID` int NOT NULL AUTO_INCREMENT,
  `turma` varchar(45) NOT NULL,
  `siglaTurma` varchar(10) DEFAULT NULL,
  `dataInicio` date NOT NULL,
  `dataFim` date DEFAULT NULL,
  PRIMARY KEY (`turmaID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.turmas: ~2 rows (aproximadamente)
INSERT INTO `turmas` (`turmaID`, `turma`, `siglaTurma`, `dataInicio`, `dataFim`) VALUES
	(1, 'PED-1', 'PED', '2023-01-10', '2026-12-15'),
	(2, 'CC-1', 'CC', '2023-02-01', '2026-12-15');

-- Copiando estrutura para tabela escola.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuarioID` int NOT NULL AUTO_INCREMENT,
  `nomeUsuario` varchar(100) NOT NULL,
  `senhaUsuario` varchar(20) NOT NULL,
  `dataNascUsuario` date NOT NULL,
  `sexoUsuario` enum('f','m','outro') NOT NULL,
  `cpfUsuario` varchar(20) NOT NULL,
  `tipoUsuario` enum('aluno','professor') NOT NULL,
  `ufUsuarios` varchar(2) DEFAULT NULL,
  `ativo` tinyint NOT NULL,
  `adminID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE KEY `cpfAluno_UNIQUE` (`cpfUsuario`),
  KEY `fk_USUARIOS_SECRETARIAS1_idx` (`adminID`),
  CONSTRAINT `fk_USUARIOS_SECRETARIAS1` FOREIGN KEY (`adminID`) REFERENCES `secretarias` (`adminID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.usuarios: ~8 rows (aproximadamente)
INSERT INTO `usuarios` (`usuarioID`, `nomeUsuario`, `senhaUsuario`, `dataNascUsuario`, `sexoUsuario`, `cpfUsuario`, `tipoUsuario`, `ufUsuarios`, `ativo`, `adminID`) VALUES
	(1, 'Ana Silva', 'senha123', '2000-05-15', 'f', '123.456.789-00', 'aluno', 'SP', 1, 1),
	(2, 'Carlos Oliveira', 'senha456', '1985-08-22', 'm', '987.654.321-00', 'professor', 'RJ', 1, 1),
	(3, 'Julia Costa', 'senha789', '1998-03-10', 'f', '321.654.987-00', 'aluno', 'MG', 1, 1),
	(4, 'Fernando Almeida', 'senha101', '1979-12-05', 'm', '456.789.123-00', 'professor', 'SP', 1, 1),
	(5, 'Mariana Santos', 'senha202', '2001-01-20', 'f', '111.222.333-44', 'aluno', 'PR', 1, 1),
	(6, 'Roberto Ferreira', 'senha303', '1980-07-14', 'm', '222.333.444-55', 'professor', 'SP', 1, 1),
	(7, 'Luiza Martins', 'senha404', '1999-11-30', 'f', '333.444.555-66', 'aluno', 'BA', 1, 1),
	(8, 'Tiago Ramos', 'senha505', '1987-04-10', 'm', '444.555.666-77', 'professor', 'CE', 1, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
