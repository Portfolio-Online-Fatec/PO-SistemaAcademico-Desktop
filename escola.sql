-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema escola
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema escola
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `escola` DEFAULT CHARACTER SET utf8 ;
USE `escola` ;

-- -----------------------------------------------------
-- Table `escola`.`SECRETARIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`SECRETARIAS` (
  `adminID` INT NOT NULL AUTO_INCREMENT,
  `usuarioAdmin` VARCHAR(45) NOT NULL,
  `emailAdmin` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`adminID`),
  UNIQUE INDEX `email_UNIQUE` (`emailAdmin` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`USUARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`USUARIOS` (
  `usuarioID` INT NOT NULL AUTO_INCREMENT,
  `nomeUsuario` VARCHAR(100) NOT NULL,
  `senhaUsuario` VARCHAR(20) NOT NULL,
  `dataNascUsuario` DATE NOT NULL,
  `sexoUsuario` ENUM('f', 'm', 'outro') NOT NULL,
  `cpfUsuario` VARCHAR(20) NOT NULL,
  `tipoUsuario` ENUM('aluno', 'professor') NOT NULL,
  `ativo` TINYINT NOT NULL,
  `adminID` INT NOT NULL,
  `ruaUsuario` VARCHAR(100) NULL,
  `numResidenciaUsuario` INT NULL,
  `bairroUsuario` VARCHAR(50) NULL,
  `cepUsuario` VARCHAR(12) NULL,
  PRIMARY KEY (`usuarioID`),
  UNIQUE INDEX `cpfAluno_UNIQUE` (`cpfUsuario` ASC) ,
  INDEX `fk_USUARIOS_SECRETARIAS1_idx` (`adminID` ASC) ,
  CONSTRAINT `fk_USUARIOS_SECRETARIAS1`
    FOREIGN KEY (`adminID`)
    REFERENCES `escola`.`SECRETARIAS` (`adminID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`emailUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`emailUsuarios` (
  `emailID` INT NOT NULL AUTO_INCREMENT,
  `emailUsuario` VARCHAR(100) NOT NULL,
  `tipoEmail` VARCHAR(60) NULL,
  `alunoID` INT NOT NULL,
  PRIMARY KEY (`emailID`),
  UNIQUE INDEX `emailAluno_UNIQUE` (`emailUsuario` ASC) ,
  INDEX `fk_emailAlunos_ALUNOS1_idx` (`alunoID` ASC) ,
  CONSTRAINT `fk_emailAlunos_ALUNOS1`
    FOREIGN KEY (`alunoID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`telefoneUsuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`telefoneUsuarios` (
  `telefoneUsuarioID` INT NOT NULL AUTO_INCREMENT,
  `tipoTelefone` VARCHAR(45) NULL,
  `telefoneUsuario` VARCHAR(20) NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`telefoneUsuarioID`),
  UNIQUE INDEX `telefoneAluno_UNIQUE` (`telefoneUsuario` ASC) ,
  INDEX `fk_telefoneAlunos_ALUNOS1_idx` (`usuarioID` ASC) ,
  CONSTRAINT `fk_telefoneAlunos_ALUNOS1`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`PROFESSORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`PROFESSORES` (
  `professorID` INT NOT NULL AUTO_INCREMENT,
  `titulacaoProfessor` VARCHAR(45) NOT NULL,
  `formacaoProfessor` VARCHAR(30) NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`professorID`, `usuarioID`),
  INDEX `fk_PROFESSORES_USUARIOS1_idx` (`usuarioID` ASC) ,
  CONSTRAINT `fk_PROFESSORES_USUARIOS1`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`DISCIPLINAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`DISCIPLINAS` (
  `disciplinaID` INT NOT NULL AUTO_INCREMENT,
  `nomeDisciplina` VARCHAR(75) NOT NULL,
  `siglaDisciplina` VARCHAR(10) NOT NULL,
  `aulasSemanaisDisciplina` INT NOT NULL,
  `aulasTotaisSemestreDisciplina` INT NOT NULL,
  `cargaHorariaDisciplina` TIME NOT NULL,
  `ementa` LONGTEXT NOT NULL,
  `professorID` INT NOT NULL,
  PRIMARY KEY (`disciplinaID`),
  INDEX `fk_DISCIPLINAS_PROFESSORES1_idx` (`professorID` ASC) ,
  CONSTRAINT `fk_DISCIPLINAS_PROFESSORES1`
    FOREIGN KEY (`professorID`)
    REFERENCES `escola`.`PROFESSORES` (`professorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`CURSOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`CURSOS` (
  `cursoID` INT NOT NULL AUTO_INCREMENT,
  `nomeCurso` VARCHAR(75) NOT NULL,
  `siglaCurso` VARCHAR(10) NOT NULL,
  `tipoDuração` ENUM('semestral', 'anual') NOT NULL,
  `periodoCurso` ENUM('vespertino', 'matutino', 'noturno') NOT NULL,
  `tipoGraduacaoCurso` ENUM('Bacharelado', 'Licenciatura', 'Tecnólogo', 'Mestrado', 'Doutorado') NULL,
  PRIMARY KEY (`cursoID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`chamadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`chamadas` (
  `situacaoID` INT NOT NULL AUTO_INCREMENT,
  `faltasAluno` TINYINT NULL,
  `dataChamada` VARCHAR(45) NULL,
  `usuarioID` INT NOT NULL,
  `disciplinaID` INT NOT NULL,
  PRIMARY KEY (`situacaoID`),
  INDEX `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS1_idx` (`disciplinaID` ASC) ,
  INDEX `fk_ALUNOS_has_DISCIPLINAS_ALUNOS1_idx` (`usuarioID` ASC) ,
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_ALUNOS1`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS1`
    FOREIGN KEY (`disciplinaID`)
    REFERENCES `escola`.`DISCIPLINAS` (`disciplinaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`turmas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`turmas` (
  `turmaID` INT NOT NULL AUTO_INCREMENT,
  `turma` VARCHAR(45) NOT NULL,
  `dataInicio` DATE NULL,
  `dataFim` DATE NULL,
  `disciplinaID` INT NOT NULL,
  `cursoID` INT NOT NULL,
  PRIMARY KEY (`turmaID`, `disciplinaID`, `cursoID`),
  INDEX `fk_CURSOS_has_DISCIPLINAS_DISCIPLINAS1_idx` (`disciplinaID` ASC) ,
  INDEX `fk_CURSOS_has_DISCIPLINAS_CURSOS1_idx` (`cursoID` ASC) ,
  CONSTRAINT `fk_CURSOS_has_DISCIPLINAS_CURSOS1`
    FOREIGN KEY (`cursoID`)
    REFERENCES `escola`.`CURSOS` (`cursoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CURSOS_has_DISCIPLINAS_DISCIPLINAS1`
    FOREIGN KEY (`disciplinaID`)
    REFERENCES `escola`.`DISCIPLINAS` (`disciplinaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`matriculas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`matriculas` (
  `matriculaID` INT NOT NULL AUTO_INCREMENT,
  `situacaoAlunoMatricula` ENUM('ativo', 'pendente', 'inativo') NOT NULL,
  `alunoID` INT NOT NULL,
  `cursoID` INT NOT NULL,
  PRIMARY KEY (`matriculaID`, `alunoID`, `cursoID`),
  INDEX `fk_ALUNOS_has_CURSOS_CURSOS1_idx` (`cursoID` ASC) ,
  INDEX `fk_ALUNOS_has_CURSOS_ALUNOS1_idx` (`alunoID` ASC) ,
  CONSTRAINT `fk_ALUNOS_has_CURSOS_ALUNOS1`
    FOREIGN KEY (`alunoID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUNOS_has_CURSOS_CURSOS1`
    FOREIGN KEY (`cursoID`)
    REFERENCES `escola`.`CURSOS` (`cursoID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`telefoneAdmins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`telefoneAdmins` (
  `telefoneAdminID` INT NOT NULL AUTO_INCREMENT,
  `telefoneFixo` VARCHAR(15) NOT NULL,
  `numCelular` VARCHAR(15) NOT NULL,
  `adminID` INT NOT NULL,
  PRIMARY KEY (`telefoneAdminID`),
  INDEX `fk_telefoneAdmins_ADMINISTRACOES1_idx` (`adminID` ASC) ,
  UNIQUE INDEX `telefoneFixo_UNIQUE` (`telefoneFixo` ASC) ,
  UNIQUE INDEX `numCelular_UNIQUE` (`numCelular` ASC) ,
  CONSTRAINT `fk_telefoneAdmins_ADMINISTRACOES1`
    FOREIGN KEY (`adminID`)
    REFERENCES `escola`.`SECRETARIAS` (`adminID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`ALUNOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`ALUNOS` (
  `alunoID` INT NOT NULL,
  `raAluno` INT(15) NOT NULL,
  `dataIngressoAluno` DATE NOT NULL,
  `usuarioID` INT NOT NULL,
  PRIMARY KEY (`alunoID`, `usuarioID`),
  UNIQUE INDEX `codigoMatriculaAluno_UNIQUE` (`raAluno` ASC) ,
  INDEX `fk_ALUNOS_USUARIOS1_idx` (`usuarioID` ASC) ,
  CONSTRAINT `fk_ALUNOS_USUARIOS1`
    FOREIGN KEY (`usuarioID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`ATIVIDADES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`ATIVIDADES` (
  `atividadeID` INT NOT NULL AUTO_INCREMENT,
  `tituloAtividade` VARCHAR(45) NOT NULL,
  `pesoAtividade` VARCHAR(45) NOT NULL,
  `descricaoAtividade` VARCHAR(200) NULL,
  `disciplinaID` INT NOT NULL,
  INDEX `fk_ATIVIDADES_DISCIPLINAS1_idx` (`disciplinaID` ASC) ,
  PRIMARY KEY (`atividadeID`),
  CONSTRAINT `fk_ATIVIDADES_DISCIPLINAS1`
    FOREIGN KEY (`disciplinaID`)
    REFERENCES `escola`.`DISCIPLINAS` (`disciplinaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`notas` (
  `notaID` INT NOT NULL AUTO_INCREMENT,
  `nota` DECIMAL(2,2) NOT NULL,
  `alunoID` INT NOT NULL,
  `atividadeID` INT NOT NULL,
  PRIMARY KEY (`notaID`),
  INDEX `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1_idx` (`atividadeID` ASC) ,
  INDEX `fk_ALUNOS_has_ATIVIDADES_ALUNOS1_idx` (`alunoID` ASC) ,
  CONSTRAINT `fk_ALUNOS_has_ATIVIDADES_ALUNOS1`
    FOREIGN KEY (`alunoID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUNOS_has_ATIVIDADES_ATIVIDADES1`
    FOREIGN KEY (`atividadeID`)
    REFERENCES `escola`.`ATIVIDADES` (`atividadeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`boletins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`boletins` (
  `boletimID` INT NOT NULL AUTO_INCREMENT,
  `notaFinalBoletim` DECIMAL(2,2) NOT NULL,
  `frequenciaFinalBoletim` DECIMAL(2,1) NOT NULL,
  `situacaoAlunoDisciplina` ENUM('aprovado', 'reprovado') NULL,
  `alunoID` INT NOT NULL,
  `disciplinaID` INT NOT NULL,
  PRIMARY KEY (`boletimID`, `alunoID`, `disciplinaID`),
  INDEX `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS2_idx` (`disciplinaID` ASC) ,
  INDEX `fk_ALUNOS_has_DISCIPLINAS_ALUNOS2_idx` (`alunoID` ASC) ,
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_ALUNOS2`
    FOREIGN KEY (`alunoID`)
    REFERENCES `escola`.`USUARIOS` (`usuarioID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ALUNOS_has_DISCIPLINAS_DISCIPLINAS2`
    FOREIGN KEY (`disciplinaID`)
    REFERENCES `escola`.`DISCIPLINAS` (`disciplinaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`diasNaoLetivos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`diasNaoLetivos` (
  `iddiasNaoLetivos` INT NOT NULL,
  `dataDia` VARCHAR(45) NULL,
  `descricaoDia` VARCHAR(45) NULL,
  `turmaID` INT NOT NULL,
  PRIMARY KEY (`iddiasNaoLetivos`),
  INDEX `fk_diasNaoLetivos_turmas1_idx` (`turmaID` ASC) ,
  CONSTRAINT `fk_diasNaoLetivos_turmas1`
    FOREIGN KEY (`turmaID`)
    REFERENCES `escola`.`turmas` (`turmaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escola`.`horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escola`.`horarios` (
  `horarioID` INT NOT NULL,
  `horaInicio` TIME NULL,
  `horaFim` TIME NULL,
  `disciplinaID` INT NOT NULL,
  PRIMARY KEY (`horarioID`),
  INDEX `fk_horarios_DISCIPLINAS1_idx` (`disciplinaID` ASC) ,
  CONSTRAINT `fk_horarios_DISCIPLINAS1`
    FOREIGN KEY (`disciplinaID`)
    REFERENCES `escola`.`DISCIPLINAS` (`disciplinaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;