CREATE DATABASE IF NOT EXISTS criasEvent;
USE criasEvent;

DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Evento;

-- Table Usuario 
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Usuario (
  IDUsuario INT UNSIGNED NOT NULL AUTO_INCREMENT,
  NomeUsuario VARCHAR(45) NULL,
  NickUsuario VARCHAR(45) NULL,
  EmailUsuario VARCHAR(45) NOT NULL,
  DataNascimento DATE NULL,
  SenhaUsuario VARCHAR(45) NULL,
  TipoUsuario ENUM("Participante", "Organizador", "Administrador") NULL,
  PRIMARY KEY (IDUsuario)
);

-- -----------------------------------------------------
-- Table Evento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Evento (
  EventoID INT NOT NULL AUTO_INCREMENT,
  EventoNome VARCHAR(45) NULL,
  EventoOrganizadorID INT,
  EventoDescricao VARCHAR(255) NULL,
  EventoData DATE NULL,
  EventoLocal VARCHAR(45) NULL,
  EventoStatus ENUM("Ativo", "Cancelado", "Removido") NOT NULL,
  PRIMARY KEY (EventoID)
  -- FOREIGN KEY (EventoOrganizadorID) REFERENCES Usuario(IDUsuario)
);
