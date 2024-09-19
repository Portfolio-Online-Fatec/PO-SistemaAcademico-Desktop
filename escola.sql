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
  `dataIngressoAluno` date NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE KEY `codigoMatriculaAluno_UNIQUE` (`raAluno`),
  KEY `fk_ALUNOS_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.alunos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.atividades
CREATE TABLE IF NOT EXISTS `atividades` (
  `atividadeID` int NOT NULL AUTO_INCREMENT,
  `tituloAtividade` varchar(45) NOT NULL,
  `pesoAtividade` varchar(45) NOT NULL,
  `descricaoAtividade` varchar(200) DEFAULT NULL,
  `disciplinaID` int NOT NULL,
  PRIMARY KEY (`atividadeID`),
  KEY `fk_ATIVIDADES_DISCIPLINAS1_idx` (`disciplinaID`),
  CONSTRAINT `fk_ATIVIDADES_DISCIPLINAS1` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.atividades: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.boletins
CREATE TABLE IF NOT EXISTS `boletins` (
  `boletimID` int NOT NULL AUTO_INCREMENT,
  `notaFinalBoletim` decimal(2,2) NOT NULL,
  `frequenciaFinalBoletim` decimal(2,1) NOT NULL,
  `situacaoAlunoDisciplina` enum('aprovado','reprovado') DEFAULT NULL,
  `alunoID` int NOT NULL,
  `disciplinaID` int NOT NULL,
  PRIMARY KEY (`boletimID`,`alunoID`,`disciplinaID`),
  KEY `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS2_idx` (`disciplinaID`),
  KEY `fk_ALUNOS_has_DISCIPLINAS_ALUNOS2_idx` (`alunoID`),
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_ALUNOS2` FOREIGN KEY (`alunoID`) REFERENCES `usuarios` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS2` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.boletins: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.chamadas
CREATE TABLE IF NOT EXISTS `chamadas` (
  `situacaoID` int NOT NULL AUTO_INCREMENT,
  `faltasAluno` tinyint DEFAULT NULL,
  `dataChamada` varchar(45) DEFAULT NULL,
  `usuarioID` int NOT NULL,
  `disciplinaID` int NOT NULL,
  PRIMARY KEY (`situacaoID`),
  KEY `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS1_idx` (`disciplinaID`),
  KEY `fk_ALUNOS_has_DISCIPLINAS_ALUNOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_ALUNOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS1` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.chamadas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.cursos
CREATE TABLE IF NOT EXISTS `cursos` (
  `cursoID` int NOT NULL AUTO_INCREMENT,
  `nomeCurso` varchar(75) NOT NULL,
  `siglaCurso` varchar(10) NOT NULL,
  `tipoDuração` enum('semestral','anual') NOT NULL,
  `periodoCurso` enum('vespertino','matutino','noturno') NOT NULL,
  `tipoGraduacaoCurso` enum('Bacharelado','Licenciatura','Tecnólogo','Mestrado','Doutorado') DEFAULT NULL,
  PRIMARY KEY (`cursoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.cursos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.diasnaoletivos
CREATE TABLE IF NOT EXISTS `diasnaoletivos` (
  `iddiasNaoLetivos` int NOT NULL,
  `dataDia` varchar(45) DEFAULT NULL,
  `descricaoDia` varchar(45) DEFAULT NULL,
  `turmaID` int NOT NULL,
  PRIMARY KEY (`iddiasNaoLetivos`),
  KEY `fk_diasNaoLetivos_turmas1_idx` (`turmaID`),
  CONSTRAINT `fk_diasNaoLetivos_turmas1` FOREIGN KEY (`turmaID`) REFERENCES `turmas` (`turmaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.diasnaoletivos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.disciplinas
CREATE TABLE IF NOT EXISTS `disciplinas` (
  `disciplinaID` int NOT NULL AUTO_INCREMENT,
  `nomeDisciplina` varchar(75) NOT NULL,
  `siglaDisciplina` varchar(10) NOT NULL,
  `aulasSemanaisDisciplina` int NOT NULL,
  `aulasTotaisSemestreDisciplina` int NOT NULL,
  `cargaHorariaDisciplina` time NOT NULL,
  `ementa` longtext NOT NULL,
  `professorID` int NOT NULL,
  PRIMARY KEY (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.disciplinas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.emailusuarios
CREATE TABLE IF NOT EXISTS `emailusuarios` (
  `emailID` int NOT NULL AUTO_INCREMENT,
  `emailUsuario` varchar(100) NOT NULL,
  `tipoEmail` varchar(60) DEFAULT NULL,
  `alunoID` int NOT NULL,
  PRIMARY KEY (`emailID`),
  UNIQUE KEY `emailAluno_UNIQUE` (`emailUsuario`),
  KEY `fk_emailAlunos_ALUNOS1_idx` (`alunoID`),
  CONSTRAINT `fk_emailAlunos_ALUNOS1` FOREIGN KEY (`alunoID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.emailusuarios: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.enderecousuarios
CREATE TABLE IF NOT EXISTS `enderecousuarios` (
  `enderecoUsuarioID` int NOT NULL AUTO_INCREMENT,
  `ruaUsuario` varchar(100) NOT NULL,
  `numResidenciaUsuario` int NOT NULL,
  `bairroUsuario` varchar(50) NOT NULL,
  `cepUsuario` varchar(12) NOT NULL,
  PRIMARY KEY (`enderecoUsuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.enderecousuarios: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.horarios
CREATE TABLE IF NOT EXISTS `horarios` (
  `horarioID` int NOT NULL,
  `horaInicio` time DEFAULT NULL,
  `horaFim` time DEFAULT NULL,
  `disciplinaID` int NOT NULL,
  PRIMARY KEY (`horarioID`),
  KEY `fk_horarios_DISCIPLINAS1_idx` (`disciplinaID`),
  CONSTRAINT `fk_horarios_DISCIPLINAS1` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.horarios: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.matriculas
CREATE TABLE IF NOT EXISTS `matriculas` (
  `matriculaID` int NOT NULL AUTO_INCREMENT,
  `situacaoAlunoMatricula` enum('ativo','pendente','inativo') NOT NULL,
  `alunoID` int NOT NULL,
  `cursoID` int NOT NULL,
  PRIMARY KEY (`matriculaID`,`alunoID`,`cursoID`),
  KEY `fk_ALUNOS_has_CURSOS_CURSOS1_idx` (`cursoID`),
  KEY `fk_ALUNOS_has_CURSOS_ALUNOS1_idx` (`alunoID`),
  CONSTRAINT `fk_ALUNOS_has_CURSOS_ALUNOS1` FOREIGN KEY (`alunoID`) REFERENCES `usuarios` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_CURSOS_CURSOS1` FOREIGN KEY (`cursoID`) REFERENCES `cursos` (`cursoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.matriculas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.notas
CREATE TABLE IF NOT EXISTS `notas` (
  `notaID` int NOT NULL AUTO_INCREMENT,
  `nota` decimal(2,2) NOT NULL,
  `alunoID` int NOT NULL,
  `atividadeID` int NOT NULL,
  PRIMARY KEY (`notaID`),
  KEY `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1_idx` (`atividadeID`),
  KEY `fk_ALUNOS_has_ATIVIDADES_ALUNOS1_idx` (`alunoID`),
  CONSTRAINT `fk_ALUNOS_has_ATIVIDADES_ALUNOS1` FOREIGN KEY (`alunoID`) REFERENCES `usuarios` (`usuarioID`),
  CONSTRAINT `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1` FOREIGN KEY (`atividadeID`) REFERENCES `atividades` (`atividadeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.notas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.professores
CREATE TABLE IF NOT EXISTS `professores` (
  `titulacaoProfessor` varchar(45) NOT NULL,
  `formacaoProfessor` varchar(30) NOT NULL,
  `usuarioID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  KEY `fk_PROFESSORES_USUARIOS1_idx` (`usuarioID`),
  CONSTRAINT `fk_PROFESSORES_USUARIOS1` FOREIGN KEY (`usuarioID`) REFERENCES `usuarios` (`usuarioID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.professores: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.secretarias
CREATE TABLE IF NOT EXISTS `secretarias` (
  `adminID` int NOT NULL AUTO_INCREMENT,
  `usuarioAdmin` varchar(45) NOT NULL,
  `emailAdmin` varchar(45) NOT NULL,
  PRIMARY KEY (`adminID`),
  UNIQUE KEY `email_UNIQUE` (`emailAdmin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.secretarias: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.telefoneadmins: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.telefoneusuarios: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.turmas
CREATE TABLE IF NOT EXISTS `turmas` (
  `turmaID` int NOT NULL AUTO_INCREMENT,
  `turma` varchar(45) NOT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `disciplinaID` int NOT NULL,
  `cursoID` int NOT NULL,
  PRIMARY KEY (`turmaID`,`disciplinaID`,`cursoID`),
  KEY `fk_CURSOS_has_DISCIPLINAS_DISCIPLINAS1_idx` (`disciplinaID`),
  KEY `fk_CURSOS_has_DISCIPLINAS_CURSOS1_idx` (`cursoID`),
  CONSTRAINT `fk_CURSOS_has_DISCIPLINAS_CURSOS1` FOREIGN KEY (`cursoID`) REFERENCES `cursos` (`cursoID`),
  CONSTRAINT `fk_CURSOS_has_DISCIPLINAS_DISCIPLINAS1` FOREIGN KEY (`disciplinaID`) REFERENCES `disciplinas` (`disciplinaID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.turmas: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela escola.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuarioID` int NOT NULL AUTO_INCREMENT,
  `nomeUsuario` varchar(100) NOT NULL,
  `senhaUsuario` varchar(20) NOT NULL,
  `dataNascUsuario` date NOT NULL,
  `sexoUsuario` enum('f','m','outro') NOT NULL,
  `cpfUsuario` varchar(20) NOT NULL,
  `tipoUsuario` enum('aluno','professor') NOT NULL,
  `ativo` tinyint NOT NULL,
  `enderecoUsuarioID` int NOT NULL,
  `adminID` int NOT NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE KEY `cpfAluno_UNIQUE` (`cpfUsuario`),
  KEY `fk_ALUNOS_enderecoAlunos_idx` (`enderecoUsuarioID`),
  KEY `fk_USUARIOS_SECRETARIAS1_idx` (`adminID`),
  CONSTRAINT `fk_ALUNOS_enderecoAlunos` FOREIGN KEY (`enderecoUsuarioID`) REFERENCES `enderecousuarios` (`enderecoUsuarioID`),
  CONSTRAINT `fk_USUARIOS_SECRETARIAS1` FOREIGN KEY (`adminID`) REFERENCES `secretarias` (`adminID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- Copiando dados para a tabela escola.usuarios: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
