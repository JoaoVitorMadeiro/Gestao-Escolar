CREATE DATABASE  IF NOT EXISTS `gestao_escolar_final2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gestao_escolar_final2`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gestao_escolar_final2
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alunos`
--

DROP TABLE IF EXISTS `alunos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alunos` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(255) NOT NULL,
  `data_nascimento` date NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `status` enum('ATIVO','INATIVO','TRANSFERIDO') DEFAULT 'ATIVO',
  PRIMARY KEY (`id_aluno`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alunos`
--

LOCK TABLES `alunos` WRITE;
/*!40000 ALTER TABLE `alunos` DISABLE KEYS */;
INSERT INTO `alunos` VALUES (1,'Ana Sophia Araújo','2011-08-22','438.150.926-98','carvalholeandro@santos.net','71 6379-4026','ATIVO'),(2,'Davi Lucas da Rosa','2011-09-26','518.302.467-71','hteixeira@cardoso.org','0900-593-1034','ATIVO'),(3,'Enzo Castro','2010-02-07','475.128.693-55','emillyfarias@rezende.net','(061) 0305 6413','ATIVO'),(4,'Raquel Lopes','2009-05-23','769.128.453-55','omoreira@hotmail.com','31 7101-2269','ATIVO'),(5,'João Pedro Nascimento','2011-01-08','784.905.231-50','anajulia27@ferreira.com','21 1489-3252','ATIVO'),(6,'Stephany Souza','2012-05-23','057.962.483-83','cardosonicole@campos.com','+55 81 7824 8963','ATIVO'),(7,'Sophia da Paz','2011-07-09','465.398.072-10','augusto98@das.com','+55 31 1051-8347','ATIVO'),(8,'Marcelo Costela','2011-07-25','973.685.102-86','anacarolina67@ig.com.br','+55 (071) 1065 1333','ATIVO'),(9,'Lavínia Cunha','2010-04-13','247.103.589-23','isaacoliveira@rocha.net','71 0260 6474','ATIVO'),(10,'Pietra Rodrigues','2009-02-22','349.085.621-05','rochaclara@caldeira.com','+55 (084) 9136 1939','ATIVO'),(11,'Amanda Cardoso','2010-04-09','985.216.734-00','ana51@ramos.com','+55 11 8384 2513','ATIVO'),(12,'Dr. Davi Lucca Pires','2012-01-13','840.592.731-04','vieirahenrique@gomes.net','(081) 3487 4016','ATIVO'),(13,'Augusto Almeida','2009-11-27','249.538.670-92','dacostafernanda@moura.com','(021) 2045-0533','ATIVO'),(14,'Ana Lívia Moraes','2011-10-21','862.195.307-21','rfarias@hotmail.com','+55 51 6073 3754','ATIVO'),(15,'Enzo Gabriel Araújo','2011-04-18','365.208.491-89','correialuizhenrique@hotmail.com','0800 401 9655','ATIVO'),(16,'Maria Silva','2008-12-23','634.058.927-83','qcampos@yahoo.com.br','0900-514-8465','ATIVO'),(17,'Pietra Gonçalves','2010-11-05','236.581.940-06','kaique69@bol.com.br','(061) 7773 8721','ATIVO'),(18,'Luiz Gustavo Melo','2008-11-19','349.615.072-61','ramosamanda@ig.com.br','0500 367 6320','ATIVO'),(19,'Yago Pereira','2009-06-01','287.041.653-90','rebeca79@ig.com.br','21 6872-7743','ATIVO'),(20,'Emilly Silveira','2010-07-19','347.052.198-05','cunhaheitor@hotmail.com','51 2316 6587','ATIVO');
/*!40000 ALTER TABLE `alunos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disciplinas`
--

DROP TABLE IF EXISTS `disciplinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `disciplinas` (
  `id_disciplina` int NOT NULL AUTO_INCREMENT,
  `nome_disciplina` varchar(100) NOT NULL,
  `carga_horaria` int DEFAULT '60',
  `status` enum('ATIVA','INATIVA') DEFAULT 'ATIVA',
  PRIMARY KEY (`id_disciplina`),
  UNIQUE KEY `nome_disciplina` (`nome_disciplina`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disciplinas`
--

LOCK TABLES `disciplinas` WRITE;
/*!40000 ALTER TABLE `disciplinas` DISABLE KEYS */;
INSERT INTO `disciplinas` VALUES (1,'Matemática',80,'ATIVA'),(2,'Português',60,'ATIVA'),(3,'História',60,'ATIVA'),(4,'Geografia',60,'ATIVA'),(5,'Ciências',60,'ATIVA'),(6,'Inglês',40,'ATIVA');
/*!40000 ALTER TABLE `disciplinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matriculas`
--

DROP TABLE IF EXISTS `matriculas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `matriculas` (
  `id_matricula` int NOT NULL AUTO_INCREMENT,
  `id_aluno` int NOT NULL,
  `id_turma` int NOT NULL,
  `data_matricula` date NOT NULL,
  `status_matricula` enum('ATIVA','TRANCADA','TRANSFERIDA','CONCLUIDA','CANCELADA') DEFAULT 'ATIVA',
  `resultado_final` enum('APROVADO','REPROVADO','EM_ANDAMENTO') DEFAULT 'EM_ANDAMENTO',
  PRIMARY KEY (`id_matricula`),
  UNIQUE KEY `uk_aluno_turma` (`id_aluno`,`id_turma`),
  KEY `id_turma` (`id_turma`),
  CONSTRAINT `matriculas_ibfk_1` FOREIGN KEY (`id_aluno`) REFERENCES `alunos` (`id_aluno`) ON DELETE CASCADE,
  CONSTRAINT `matriculas_ibfk_2` FOREIGN KEY (`id_turma`) REFERENCES `turmas` (`id_turma`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matriculas`
--

LOCK TABLES `matriculas` WRITE;
/*!40000 ALTER TABLE `matriculas` DISABLE KEYS */;
INSERT INTO `matriculas` VALUES (1,1,1,'2025-02-01','ATIVA','EM_ANDAMENTO'),(2,2,2,'2025-02-02','ATIVA','EM_ANDAMENTO'),(3,3,3,'2025-02-03','ATIVA','EM_ANDAMENTO'),(4,4,1,'2025-02-04','ATIVA','EM_ANDAMENTO'),(5,5,2,'2025-02-05','ATIVA','EM_ANDAMENTO'),(6,6,3,'2025-02-06','ATIVA','EM_ANDAMENTO'),(7,7,1,'2025-02-07','ATIVA','EM_ANDAMENTO'),(8,8,2,'2025-02-08','ATIVA','EM_ANDAMENTO'),(9,9,3,'2025-02-09','ATIVA','EM_ANDAMENTO'),(10,10,1,'2025-02-10','ATIVA','EM_ANDAMENTO'),(11,11,2,'2025-02-11','ATIVA','EM_ANDAMENTO'),(12,12,3,'2025-02-12','ATIVA','EM_ANDAMENTO'),(13,13,1,'2025-02-13','ATIVA','EM_ANDAMENTO'),(14,14,2,'2025-02-14','ATIVA','EM_ANDAMENTO'),(15,15,3,'2025-02-15','ATIVA','EM_ANDAMENTO'),(16,16,1,'2025-02-16','ATIVA','EM_ANDAMENTO'),(17,17,2,'2025-02-17','ATIVA','EM_ANDAMENTO'),(18,18,3,'2025-02-18','ATIVA','EM_ANDAMENTO'),(19,19,1,'2025-02-19','ATIVA','EM_ANDAMENTO'),(20,20,2,'2025-02-20','ATIVA','EM_ANDAMENTO');
/*!40000 ALTER TABLE `matriculas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `id_matricula` int NOT NULL,
  `id_disciplina` int NOT NULL,
  `bimestre` tinyint NOT NULL,
  `nota_valor` decimal(4,2) NOT NULL,
  `tipo_avaliacao` enum('ANALISE','AVALIACAO') NOT NULL,
  PRIMARY KEY (`id_nota`),
  KEY `id_matricula` (`id_matricula`),
  KEY `id_disciplina` (`id_disciplina`),
  CONSTRAINT `notas_ibfk_1` FOREIGN KEY (`id_matricula`) REFERENCES `matriculas` (`id_matricula`) ON DELETE CASCADE,
  CONSTRAINT `notas_ibfk_2` FOREIGN KEY (`id_disciplina`) REFERENCES `disciplinas` (`id_disciplina`) ON DELETE CASCADE,
  CONSTRAINT `notas_chk_1` CHECK ((`bimestre` between 1 and 4)),
  CONSTRAINT `notas_chk_2` CHECK ((`nota_valor` between 0 and 10))
) ENGINE=InnoDB AUTO_INCREMENT=481 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (1,1,1,1,6.22,'AVALIACAO'),(2,1,1,2,8.02,'AVALIACAO'),(3,1,1,3,7.65,'AVALIACAO'),(4,1,1,4,7.20,'AVALIACAO'),(5,1,2,1,4.98,'ANALISE'),(6,1,2,2,5.62,'AVALIACAO'),(7,1,2,3,8.11,'AVALIACAO'),(8,1,2,4,5.37,'AVALIACAO'),(9,1,3,1,8.83,'ANALISE'),(10,1,3,2,5.61,'AVALIACAO'),(11,1,3,3,6.89,'AVALIACAO'),(12,1,3,4,7.46,'AVALIACAO'),(13,1,4,1,5.01,'AVALIACAO'),(14,1,4,2,9.63,'ANALISE'),(15,1,4,3,6.61,'ANALISE'),(16,1,4,4,5.41,'AVALIACAO'),(17,1,5,1,6.82,'ANALISE'),(18,1,5,2,6.30,'AVALIACAO'),(19,1,5,3,7.46,'ANALISE'),(20,1,5,4,6.25,'AVALIACAO'),(21,1,6,1,7.87,'ANALISE'),(22,1,6,2,6.83,'ANALISE'),(23,1,6,3,9.64,'AVALIACAO'),(24,1,6,4,4.71,'ANALISE'),(25,2,1,1,6.22,'AVALIACAO'),(26,2,1,2,8.02,'AVALIACAO'),(27,2,1,3,7.65,'AVALIACAO'),(28,2,1,4,7.20,'AVALIACAO'),(29,2,2,1,4.98,'ANALISE'),(30,2,2,2,5.62,'AVALIACAO'),(31,2,2,3,8.11,'AVALIACAO'),(32,2,2,4,5.37,'AVALIACAO'),(33,2,3,1,8.83,'ANALISE'),(34,2,3,2,5.61,'AVALIACAO'),(35,2,3,3,6.89,'AVALIACAO'),(36,2,3,4,7.46,'AVALIACAO'),(37,2,4,1,5.01,'AVALIACAO'),(38,2,4,2,9.63,'ANALISE'),(39,2,4,3,6.61,'ANALISE'),(40,2,4,4,5.41,'AVALIACAO'),(41,2,5,1,6.82,'ANALISE'),(42,2,5,2,6.30,'AVALIACAO'),(43,2,5,3,7.46,'ANALISE'),(44,2,5,4,6.25,'AVALIACAO'),(45,2,6,1,7.87,'ANALISE'),(46,2,6,2,6.83,'ANALISE'),(47,2,6,3,9.64,'AVALIACAO'),(48,2,6,4,4.71,'ANALISE'),(49,3,1,1,7.15,'AVALIACAO'),(50,3,1,2,6.89,'AVALIACAO'),(51,3,1,3,8.32,'AVALIACAO'),(52,3,1,4,6.75,'AVALIACAO'),(53,3,2,1,5.42,'ANALISE'),(54,3,2,2,6.78,'AVALIACAO'),(55,3,2,3,7.95,'AVALIACAO'),(56,3,2,4,6.12,'AVALIACAO'),(57,3,3,1,7.64,'ANALISE'),(58,3,3,2,6.25,'AVALIACAO'),(59,3,3,3,7.43,'AVALIACAO'),(60,3,3,4,8.19,'AVALIACAO'),(61,3,4,1,6.47,'AVALIACAO'),(62,3,4,2,8.92,'ANALISE'),(63,3,4,3,7.28,'ANALISE'),(64,3,4,4,6.85,'AVALIACAO'),(65,3,5,1,7.15,'ANALISE'),(66,3,5,2,7.45,'AVALIACAO'),(67,3,5,3,8.12,'ANALISE'),(68,3,5,4,7.63,'AVALIACAO'),(69,3,6,1,8.12,'ANALISE'),(70,3,6,2,7.26,'ANALISE'),(71,3,6,3,8.95,'AVALIACAO'),(72,3,6,4,5.89,'ANALISE'),(73,4,1,1,6.75,'AVALIACAO'),(74,4,1,2,7.80,'AVALIACAO'),(75,4,1,3,8.15,'AVALIACAO'),(76,4,1,4,7.40,'AVALIACAO'),(77,4,2,1,5.50,'ANALISE'),(78,4,2,2,6.20,'AVALIACAO'),(79,4,2,3,7.90,'AVALIACAO'),(80,4,2,4,6.80,'AVALIACAO'),(81,4,3,1,8.25,'ANALISE'),(82,4,3,2,6.70,'AVALIACAO'),(83,4,3,3,7.10,'AVALIACAO'),(84,4,3,4,8.00,'AVALIACAO'),(85,4,4,1,6.30,'AVALIACAO'),(86,4,4,2,9.20,'ANALISE'),(87,4,4,3,7.50,'ANALISE'),(88,4,4,4,6.60,'AVALIACAO'),(89,4,5,1,7.40,'ANALISE'),(90,4,5,2,7.10,'AVALIACAO'),(91,4,5,3,8.30,'ANALISE'),(92,4,5,4,7.20,'AVALIACAO'),(93,4,6,1,8.50,'ANALISE'),(94,4,6,2,7.80,'ANALISE'),(95,4,6,3,9.10,'AVALIACAO'),(96,4,6,4,6.25,'ANALISE'),(97,5,1,1,7.50,'AVALIACAO'),(98,5,1,2,8.25,'AVALIACAO'),(99,5,1,3,6.90,'AVALIACAO'),(100,5,1,4,7.80,'AVALIACAO'),(101,5,2,1,5.75,'ANALISE'),(102,5,2,2,6.40,'AVALIACAO'),(103,5,2,3,8.20,'AVALIACAO'),(104,5,2,4,7.10,'AVALIACAO'),(105,5,3,1,8.60,'ANALISE'),(106,5,3,2,7.30,'AVALIACAO'),(107,5,3,3,6.85,'AVALIACAO'),(108,5,3,4,8.45,'AVALIACAO'),(109,5,4,1,6.20,'AVALIACAO'),(110,5,4,2,9.10,'ANALISE'),(111,5,4,3,7.75,'ANALISE'),(112,5,4,4,6.95,'AVALIACAO'),(113,5,5,1,7.80,'ANALISE'),(114,5,5,2,6.95,'AVALIACAO'),(115,5,5,3,8.60,'ANALISE'),(116,5,5,4,7.30,'AVALIACAO'),(117,5,6,1,8.75,'ANALISE'),(118,5,6,2,7.40,'ANALISE'),(119,5,6,3,9.30,'AVALIACAO'),(120,5,6,4,6.50,'ANALISE'),(121,6,1,1,6.80,'AVALIACAO'),(122,6,1,2,7.95,'AVALIACAO'),(123,6,1,3,8.40,'AVALIACAO'),(124,6,1,4,7.25,'AVALIACAO'),(125,6,2,1,5.30,'ANALISE'),(126,6,2,2,6.75,'AVALIACAO'),(127,6,2,3,7.85,'AVALIACAO'),(128,6,2,4,6.60,'AVALIACAO'),(129,6,3,1,8.40,'ANALISE'),(130,6,3,2,6.50,'AVALIACAO'),(131,6,3,3,7.20,'AVALIACAO'),(132,6,3,4,8.80,'AVALIACAO'),(133,6,4,1,6.60,'AVALIACAO'),(134,6,4,2,9.40,'ANALISE'),(135,6,4,3,7.30,'ANALISE'),(136,6,4,4,6.70,'AVALIACAO'),(137,6,5,1,7.20,'ANALISE'),(138,6,5,2,7.60,'AVALIACAO'),(139,6,5,3,8.90,'ANALISE'),(140,6,5,4,7.50,'AVALIACAO'),(141,6,6,1,8.90,'ANALISE'),(142,6,6,2,7.80,'ANALISE'),(143,6,6,3,9.50,'AVALIACAO'),(144,6,6,4,6.20,'ANALISE'),(145,7,1,1,7.20,'AVALIACAO'),(146,7,1,2,8.10,'AVALIACAO'),(147,7,1,3,6.75,'AVALIACAO'),(148,7,1,4,7.60,'AVALIACAO'),(149,7,2,1,5.60,'ANALISE'),(150,7,2,2,6.85,'AVALIACAO'),(151,7,2,3,8.30,'AVALIACAO'),(152,7,2,4,7.25,'AVALIACAO'),(153,7,3,1,8.75,'ANALISE'),(154,7,3,2,7.15,'AVALIACAO'),(155,7,3,3,6.95,'AVALIACAO'),(156,7,3,4,8.50,'AVALIACAO'),(157,7,4,1,6.40,'AVALIACAO'),(158,7,4,2,9.30,'ANALISE'),(159,7,4,3,7.60,'ANALISE'),(160,7,4,4,6.80,'AVALIACAO'),(161,7,5,1,7.90,'ANALISE'),(162,7,5,2,6.70,'AVALIACAO'),(163,7,5,3,8.40,'ANALISE'),(164,7,5,4,7.10,'AVALIACAO'),(165,7,6,1,8.60,'ANALISE'),(166,7,6,2,7.50,'ANALISE'),(167,7,6,3,9.20,'AVALIACAO'),(168,7,6,4,6.35,'ANALISE'),(169,8,1,1,6.90,'AVALIACAO'),(170,8,1,2,7.70,'AVALIACAO'),(171,8,1,3,8.25,'AVALIACAO'),(172,8,1,4,7.30,'AVALIACAO'),(173,8,2,1,5.45,'ANALISE'),(174,8,2,2,6.95,'AVALIACAO'),(175,8,2,3,7.80,'AVALIACAO'),(176,8,2,4,6.70,'AVALIACAO'),(177,8,3,1,8.90,'ANALISE'),(178,8,3,2,6.80,'AVALIACAO'),(179,8,3,3,7.40,'AVALIACAO'),(180,8,3,4,8.60,'AVALIACAO'),(181,8,4,1,6.75,'AVALIACAO'),(182,8,4,2,9.50,'ANALISE'),(183,8,4,3,7.20,'ANALISE'),(184,8,4,4,6.90,'AVALIACAO'),(185,8,5,1,7.60,'ANALISE'),(186,8,5,2,7.30,'AVALIACAO'),(187,8,5,3,8.70,'ANALISE'),(188,8,5,4,7.40,'AVALIACAO'),(189,8,6,1,8.80,'ANALISE'),(190,8,6,2,7.60,'ANALISE'),(191,8,6,3,9.40,'AVALIACAO'),(192,8,6,4,6.45,'ANALISE'),(193,9,1,1,7.10,'AVALIACAO'),(194,9,1,2,8.40,'AVALIACAO'),(195,9,1,3,6.60,'AVALIACAO'),(196,9,1,4,7.90,'AVALIACAO'),(197,9,2,1,5.80,'ANALISE'),(198,9,2,2,6.60,'AVALIACAO'),(199,9,2,3,8.10,'AVALIACAO'),(200,9,2,4,7.35,'AVALIACAO'),(201,9,3,1,8.30,'ANALISE'),(202,9,3,2,7.20,'AVALIACAO'),(203,9,3,3,6.70,'AVALIACAO'),(204,9,3,4,8.70,'AVALIACAO'),(205,9,4,1,6.50,'AVALIACAO'),(206,9,4,2,9.20,'ANALISE'),(207,9,4,3,7.90,'ANALISE'),(208,9,4,4,6.65,'AVALIACAO'),(209,9,5,1,7.70,'ANALISE'),(210,9,5,2,7.10,'AVALIACAO'),(211,9,5,3,8.80,'ANALISE'),(212,9,5,4,7.20,'AVALIACAO'),(213,9,6,1,8.95,'ANALISE'),(214,9,6,2,7.70,'ANALISE'),(215,9,6,3,9.60,'AVALIACAO'),(216,9,6,4,6.55,'ANALISE'),(217,10,1,1,7.35,'AVALIACAO'),(218,10,1,2,8.15,'AVALIACAO'),(219,10,1,3,6.85,'AVALIACAO'),(220,10,1,4,7.70,'AVALIACAO'),(221,10,2,1,5.70,'ANALISE'),(222,10,2,2,6.95,'AVALIACAO'),(223,10,2,3,8.40,'AVALIACAO'),(224,10,2,4,7.15,'AVALIACAO'),(225,10,3,1,8.85,'ANALISE'),(226,10,3,2,7.25,'AVALIACAO'),(227,10,3,3,7.05,'AVALIACAO'),(228,10,3,4,8.55,'AVALIACAO'),(229,10,4,1,6.45,'AVALIACAO'),(230,10,4,2,9.35,'ANALISE'),(231,10,4,3,7.65,'ANALISE'),(232,10,4,4,6.85,'AVALIACAO'),(233,10,5,1,7.95,'ANALISE'),(234,10,5,2,6.80,'AVALIACAO'),(235,10,5,3,8.45,'ANALISE'),(236,10,5,4,7.20,'AVALIACAO'),(237,10,6,1,8.65,'ANALISE'),(238,10,6,2,7.55,'ANALISE'),(239,10,6,3,9.25,'AVALIACAO'),(240,10,6,4,6.40,'ANALISE'),(241,11,1,1,6.95,'AVALIACAO'),(242,11,1,2,7.85,'AVALIACAO'),(243,11,1,3,8.30,'AVALIACAO'),(244,11,1,4,7.40,'AVALIACAO'),(245,11,2,1,5.50,'ANALISE'),(246,11,2,2,7.05,'AVALIACAO'),(247,11,2,3,7.90,'AVALIACAO'),(248,11,2,4,6.80,'AVALIACAO'),(249,11,3,1,8.95,'ANALISE'),(250,11,3,2,6.90,'AVALIACAO'),(251,11,3,3,7.50,'AVALIACAO'),(252,11,3,4,8.65,'AVALIACAO'),(253,11,4,1,6.80,'AVALIACAO'),(254,11,4,2,9.45,'ANALISE'),(255,11,4,3,7.30,'ANALISE'),(256,11,4,4,6.95,'AVALIACAO'),(257,11,5,1,7.70,'ANALISE'),(258,11,5,2,7.40,'AVALIACAO'),(259,11,5,3,8.80,'ANALISE'),(260,11,5,4,7.50,'AVALIACAO'),(261,11,6,1,8.90,'ANALISE'),(262,11,6,2,7.70,'ANALISE'),(263,11,6,3,9.45,'AVALIACAO'),(264,11,6,4,6.50,'ANALISE'),(265,12,1,1,7.25,'AVALIACAO'),(266,12,1,2,8.45,'AVALIACAO'),(267,12,1,3,6.70,'AVALIACAO'),(268,12,1,4,7.85,'AVALIACAO'),(269,12,2,1,5.90,'ANALISE'),(270,12,2,2,6.70,'AVALIACAO'),(271,12,2,3,8.20,'AVALIACAO'),(272,12,2,4,7.45,'AVALIACAO'),(273,12,3,1,8.40,'ANALISE'),(274,12,3,2,7.30,'AVALIACAO'),(275,12,3,3,6.80,'AVALIACAO'),(276,12,3,4,8.80,'AVALIACAO'),(277,12,4,1,6.60,'AVALIACAO'),(278,12,4,2,9.30,'ANALISE'),(279,12,4,3,7.80,'ANALISE'),(280,12,4,4,6.75,'AVALIACAO'),(281,12,5,1,7.80,'ANALISE'),(282,12,5,2,7.20,'AVALIACAO'),(283,12,5,3,8.90,'ANALISE'),(284,12,5,4,7.30,'AVALIACAO'),(285,12,6,1,9.05,'ANALISE'),(286,12,6,2,7.80,'ANALISE'),(287,12,6,3,9.55,'AVALIACAO'),(288,12,6,4,6.60,'ANALISE'),(289,13,1,1,6.80,'AVALIACAO'),(290,13,1,2,7.95,'AVALIACAO'),(291,13,1,3,8.20,'AVALIACAO'),(292,13,1,4,7.35,'AVALIACAO'),(293,13,2,1,5.65,'ANALISE'),(294,13,2,2,6.85,'AVALIACAO'),(295,13,2,3,7.75,'AVALIACAO'),(296,13,2,4,6.90,'AVALIACAO'),(297,13,3,1,8.70,'ANALISE'),(298,13,3,2,6.75,'AVALIACAO'),(299,13,3,3,7.35,'AVALIACAO'),(300,13,3,4,8.50,'AVALIACAO'),(301,13,4,1,6.70,'AVALIACAO'),(302,13,4,2,9.25,'ANALISE'),(303,13,4,3,7.45,'ANALISE'),(304,13,4,4,6.85,'AVALIACAO'),(305,13,5,1,7.60,'ANALISE'),(306,13,5,2,7.35,'AVALIACAO'),(307,13,5,3,8.65,'ANALISE'),(308,13,5,4,7.40,'AVALIACAO'),(309,13,6,1,8.80,'ANALISE'),(310,13,6,2,7.65,'ANALISE'),(311,13,6,3,9.35,'AVALIACAO'),(312,13,6,4,6.45,'ANALISE'),(313,14,1,1,7.15,'AVALIACAO'),(314,14,1,2,8.25,'AVALIACAO'),(315,14,1,3,6.95,'AVALIACAO'),(316,14,1,4,7.65,'AVALIACAO'),(317,14,2,1,5.75,'ANALISE'),(318,14,2,2,6.65,'AVALIACAO'),(319,14,2,3,8.15,'AVALIACAO'),(320,14,2,4,7.25,'AVALIACAO'),(321,14,3,1,8.55,'ANALISE'),(322,14,3,2,7.15,'AVALIACAO'),(323,14,3,3,6.90,'AVALIACAO'),(324,14,3,4,8.65,'AVALIACAO'),(325,14,4,1,6.55,'AVALIACAO'),(326,14,4,2,9.15,'ANALISE'),(327,14,4,3,7.70,'ANALISE'),(328,14,4,4,6.70,'AVALIACAO'),(329,14,5,1,7.85,'ANALISE'),(330,14,5,2,6.90,'AVALIACAO'),(331,14,5,3,8.55,'ANALISE'),(332,14,5,4,7.15,'AVALIACAO'),(333,14,6,1,8.95,'ANALISE'),(334,14,6,2,7.55,'ANALISE'),(335,14,6,3,9.50,'AVALIACAO'),(336,14,6,4,6.55,'ANALISE'),(337,15,1,1,7.40,'AVALIACAO'),(338,15,1,2,8.30,'AVALIACAO'),(339,15,1,3,6.80,'AVALIACAO'),(340,15,1,4,7.75,'AVALIACAO'),(341,15,2,1,5.85,'ANALISE'),(342,15,2,2,7.10,'AVALIACAO'),(343,15,2,3,8.45,'AVALIACAO'),(344,15,2,4,7.30,'AVALIACAO'),(345,15,3,1,8.90,'ANALISE'),(346,15,3,2,7.40,'AVALIACAO'),(347,15,3,3,7.15,'AVALIACAO'),(348,15,3,4,8.60,'AVALIACAO'),(349,15,4,1,6.60,'AVALIACAO'),(350,15,4,2,9.40,'ANALISE'),(351,15,4,3,7.80,'ANALISE'),(352,15,4,4,6.90,'AVALIACAO'),(353,15,5,1,8.05,'ANALISE'),(354,15,5,2,6.95,'AVALIACAO'),(355,15,5,3,8.50,'ANALISE'),(356,15,5,4,7.35,'AVALIACAO'),(357,15,6,1,8.70,'ANALISE'),(358,15,6,2,7.60,'ANALISE'),(359,15,6,3,9.35,'AVALIACAO'),(360,15,6,4,6.45,'ANALISE'),(361,16,1,1,6.90,'AVALIACAO'),(362,16,1,2,7.80,'AVALIACAO'),(363,16,1,3,8.35,'AVALIACAO'),(364,16,1,4,7.45,'AVALIACAO'),(365,16,2,1,5.55,'ANALISE'),(366,16,2,2,7.15,'AVALIACAO'),(367,16,2,3,7.95,'AVALIACAO'),(368,16,2,4,6.85,'AVALIACAO'),(369,16,3,1,9.00,'ANALISE'),(370,16,3,2,6.95,'AVALIACAO'),(371,16,3,3,7.55,'AVALIACAO'),(372,16,3,4,8.70,'AVALIACAO'),(373,16,4,1,6.85,'AVALIACAO'),(374,16,4,2,9.50,'ANALISE'),(375,16,4,3,7.35,'ANALISE'),(376,16,4,4,7.00,'AVALIACAO'),(377,16,5,1,7.75,'ANALISE'),(378,16,5,2,7.45,'AVALIACAO'),(379,16,5,3,8.85,'ANALISE'),(380,16,5,4,7.55,'AVALIACAO'),(381,16,6,1,8.95,'ANALISE'),(382,16,6,2,7.75,'ANALISE'),(383,16,6,3,9.50,'AVALIACAO'),(384,16,6,4,6.55,'ANALISE'),(385,17,1,1,7.30,'AVALIACAO'),(386,17,1,2,8.50,'AVALIACAO'),(387,17,1,3,6.75,'AVALIACAO'),(388,17,1,4,7.90,'AVALIACAO'),(389,17,2,1,5.95,'ANALISE'),(390,17,2,2,6.75,'AVALIACAO'),(391,17,2,3,8.25,'AVALIACAO'),(392,17,2,4,7.50,'AVALIACAO'),(393,17,3,1,8.45,'ANALISE'),(394,17,3,2,7.35,'AVALIACAO'),(395,17,3,3,6.85,'AVALIACAO'),(396,17,3,4,8.85,'AVALIACAO'),(397,17,4,1,6.65,'AVALIACAO'),(398,17,4,2,9.35,'ANALISE'),(399,17,4,3,7.85,'ANALISE'),(400,17,4,4,6.80,'AVALIACAO'),(401,17,5,1,7.85,'ANALISE'),(402,17,5,2,7.25,'AVALIACAO'),(403,17,5,3,8.95,'ANALISE'),(404,17,5,4,7.35,'AVALIACAO'),(405,17,6,1,9.10,'ANALISE'),(406,17,6,2,7.85,'ANALISE'),(407,17,6,3,9.60,'AVALIACAO'),(408,17,6,4,6.65,'ANALISE'),(409,18,1,1,6.85,'AVALIACAO'),(410,18,1,2,8.00,'AVALIACAO'),(411,18,1,3,8.25,'AVALIACAO'),(412,18,1,4,7.40,'AVALIACAO'),(413,18,2,1,5.70,'ANALISE'),(414,18,2,2,6.90,'AVALIACAO'),(415,18,2,3,7.80,'AVALIACAO'),(416,18,2,4,6.95,'AVALIACAO'),(417,18,3,1,8.75,'ANALISE'),(418,18,3,2,6.80,'AVALIACAO'),(419,18,3,3,7.40,'AVALIACAO'),(420,18,3,4,8.55,'AVALIACAO'),(421,18,4,1,6.75,'AVALIACAO'),(422,18,4,2,9.30,'ANALISE'),(423,18,4,3,7.50,'ANALISE'),(424,18,4,4,6.90,'AVALIACAO'),(425,18,5,1,7.65,'ANALISE'),(426,18,5,2,7.40,'AVALIACAO'),(427,18,5,3,8.70,'ANALISE'),(428,18,5,4,7.45,'AVALIACAO'),(429,18,6,1,8.85,'ANALISE'),(430,18,6,2,7.70,'ANALISE'),(431,18,6,3,9.40,'AVALIACAO'),(432,18,6,4,6.50,'ANALISE'),(433,19,1,1,7.20,'AVALIACAO'),(434,19,1,2,8.30,'AVALIACAO'),(435,19,1,3,7.00,'AVALIACAO'),(436,19,1,4,7.70,'AVALIACAO'),(437,19,2,1,5.80,'ANALISE'),(438,19,2,2,6.70,'AVALIACAO'),(439,19,2,3,8.20,'AVALIACAO'),(440,19,2,4,7.30,'AVALIACAO'),(441,19,3,1,8.60,'ANALISE'),(442,19,3,2,7.20,'AVALIACAO'),(443,19,3,3,6.95,'AVALIACAO'),(444,19,3,4,8.70,'AVALIACAO'),(445,19,4,1,6.60,'AVALIACAO'),(446,19,4,2,9.20,'ANALISE'),(447,19,4,3,7.75,'ANALISE'),(448,19,4,4,6.75,'AVALIACAO'),(449,19,5,1,7.90,'ANALISE'),(450,19,5,2,6.95,'AVALIACAO'),(451,19,5,3,8.60,'ANALISE'),(452,19,5,4,7.20,'AVALIACAO'),(453,19,6,1,9.00,'ANALISE'),(454,19,6,2,7.60,'ANALISE'),(455,19,6,3,9.55,'AVALIACAO'),(456,19,6,4,6.60,'ANALISE'),(457,20,1,1,7.50,'AVALIACAO'),(458,20,1,2,8.20,'AVALIACAO'),(459,20,1,3,6.90,'AVALIACAO'),(460,20,1,4,7.85,'AVALIACAO'),(461,20,2,1,5.90,'ANALISE'),(462,20,2,2,7.05,'AVALIACAO'),(463,20,2,3,8.35,'AVALIACAO'),(464,20,2,4,7.40,'AVALIACAO'),(465,20,3,1,8.80,'ANALISE'),(466,20,3,2,7.45,'AVALIACAO'),(467,20,3,3,7.20,'AVALIACAO'),(468,20,3,4,8.65,'AVALIACAO'),(469,20,4,1,6.70,'AVALIACAO'),(470,20,4,2,9.45,'ANALISE'),(471,20,4,3,7.90,'ANALISE'),(472,20,4,4,6.95,'AVALIACAO'),(473,20,5,1,8.10,'ANALISE'),(474,20,5,2,7.15,'AVALIACAO'),(475,20,5,3,8.75,'ANALISE'),(476,20,5,4,7.45,'AVALIACAO'),(477,20,6,1,9.15,'ANALISE'),(478,20,6,2,7.80,'ANALISE'),(479,20,6,3,9.65,'AVALIACAO'),(480,20,6,4,6.70,'ANALISE');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professores`
--

DROP TABLE IF EXISTS `professores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professores` (
  `id_professor` int NOT NULL AUTO_INCREMENT,
  `nome_completo` varchar(255) NOT NULL,
  `cpf` varchar(14) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `formacao` varchar(100) NOT NULL,
  `status` enum('ATIVO','INATIVO') DEFAULT 'ATIVO',
  PRIMARY KEY (`id_professor`),
  UNIQUE KEY `cpf` (`cpf`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professores`
--

LOCK TABLES `professores` WRITE;
/*!40000 ALTER TABLE `professores` DISABLE KEYS */;
INSERT INTO `professores` VALUES (1,'Ana Carolina da Rocha','690.843.571-75','ipeixoto@ig.com.br','71 9373-4670','Inglês','ATIVO'),(2,'Heloísa Nunes','279.460.385-00','dcunha@barros.br','+55 11 7556-4641','Matemática','ATIVO'),(3,'Alexia Viana','053.896.472-38','luccacostela@correia.net','(061) 4529-9124','Matemática','ATIVO'),(4,'Nathan Araújo','468.510.793-48','monteiroemilly@moura.com','21 5067-1657','Inglês','ATIVO'),(5,'Srta. Larissa da Luz','847.369.210-13','ana-sophia37@mendes.com','11 5273-5454','História','ATIVO');
/*!40000 ALTER TABLE `professores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `turmas`
--

DROP TABLE IF EXISTS `turmas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `turmas` (
  `id_turma` int NOT NULL AUTO_INCREMENT,
  `nome_turma` varchar(100) NOT NULL,
  `ano_letivo` year NOT NULL,
  `turno` enum('MANHA','TARDE','NOITE') NOT NULL,
  `sala` varchar(50) NOT NULL,
  `vagas` int NOT NULL,
  `id_professor_responsavel` int DEFAULT NULL,
  `status` enum('ATIVA','INATIVA') DEFAULT 'ATIVA',
  PRIMARY KEY (`id_turma`),
  KEY `id_professor_responsavel` (`id_professor_responsavel`),
  CONSTRAINT `turmas_ibfk_1` FOREIGN KEY (`id_professor_responsavel`) REFERENCES `professores` (`id_professor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `turmas`
--

LOCK TABLES `turmas` WRITE;
/*!40000 ALTER TABLE `turmas` DISABLE KEYS */;
INSERT INTO `turmas` VALUES (1,'7º Ano A',2025,'MANHA','Sala 117',30,1,'ATIVA'),(2,'6º Ano B',2025,'TARDE','Sala 104',30,1,'ATIVA'),(3,'6º Ano C',2025,'MANHA','Sala 129',30,5,'ATIVA');
/*!40000 ALTER TABLE `turmas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_alunos_por_turma`
--

DROP TABLE IF EXISTS `vw_alunos_por_turma`;
/*!50001 DROP VIEW IF EXISTS `vw_alunos_por_turma`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_alunos_por_turma` AS SELECT 
 1 AS `id_turma`,
 1 AS `nome_turma`,
 1 AS `id_aluno`,
 1 AS `nome_completo`,
 1 AS `status_aluno`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_professores_por_turma`
--

DROP TABLE IF EXISTS `vw_professores_por_turma`;
/*!50001 DROP VIEW IF EXISTS `vw_professores_por_turma`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_professores_por_turma` AS SELECT 
 1 AS `id_turma`,
 1 AS `nome_turma`,
 1 AS `id_professor`,
 1 AS `nome_completo`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_status_alunos_por_ano`
--

DROP TABLE IF EXISTS `vw_status_alunos_por_ano`;
/*!50001 DROP VIEW IF EXISTS `vw_status_alunos_por_ano`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_status_alunos_por_ano` AS SELECT 
 1 AS `ano_letivo`,
 1 AS `status_aluno`,
 1 AS `quantidade`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_turmas_disciplinas_professor`
--

DROP TABLE IF EXISTS `vw_turmas_disciplinas_professor`;
/*!50001 DROP VIEW IF EXISTS `vw_turmas_disciplinas_professor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_turmas_disciplinas_professor` AS SELECT 
 1 AS `id_professor`,
 1 AS `professor`,
 1 AS `id_turma`,
 1 AS `nome_turma`,
 1 AS `id_disciplina`,
 1 AS `nome_disciplina`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'gestao_escolar_final2'
--

--
-- Dumping routines for database 'gestao_escolar_final2'
--

--
-- Final view structure for view `vw_alunos_por_turma`
--

/*!50001 DROP VIEW IF EXISTS `vw_alunos_por_turma`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_alunos_por_turma` AS select `t`.`id_turma` AS `id_turma`,`t`.`nome_turma` AS `nome_turma`,`a`.`id_aluno` AS `id_aluno`,`a`.`nome_completo` AS `nome_completo`,`a`.`status` AS `status_aluno` from ((`turmas` `t` join `matriculas` `m` on((`m`.`id_turma` = `t`.`id_turma`))) join `alunos` `a` on((`a`.`id_aluno` = `m`.`id_aluno`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_professores_por_turma`
--

/*!50001 DROP VIEW IF EXISTS `vw_professores_por_turma`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_professores_por_turma` AS select `t`.`id_turma` AS `id_turma`,`t`.`nome_turma` AS `nome_turma`,`p`.`id_professor` AS `id_professor`,`p`.`nome_completo` AS `nome_completo` from (`turmas` `t` join `professores` `p` on((`p`.`id_professor` = `t`.`id_professor_responsavel`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_status_alunos_por_ano`
--

/*!50001 DROP VIEW IF EXISTS `vw_status_alunos_por_ano`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_status_alunos_por_ano` AS select year(`m`.`data_matricula`) AS `ano_letivo`,`a`.`status` AS `status_aluno`,count(0) AS `quantidade` from (`matriculas` `m` join `alunos` `a` on((`a`.`id_aluno` = `m`.`id_aluno`))) group by `ano_letivo`,`a`.`status` order by `ano_letivo`,`a`.`status` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_turmas_disciplinas_professor`
--

/*!50001 DROP VIEW IF EXISTS `vw_turmas_disciplinas_professor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_turmas_disciplinas_professor` AS select `p`.`id_professor` AS `id_professor`,`p`.`nome_completo` AS `professor`,`t`.`id_turma` AS `id_turma`,`t`.`nome_turma` AS `nome_turma`,`d`.`id_disciplina` AS `id_disciplina`,`d`.`nome_disciplina` AS `nome_disciplina` from ((`professores` `p` join `turmas` `t` on((`t`.`id_professor_responsavel` = `p`.`id_professor`))) join `disciplinas` `d`) where ((`t`.`status` = 'ATIVA') and (`d`.`status` = 'ATIVA')) order by `p`.`nome_completo`,`t`.`nome_turma`,`d`.`nome_disciplina` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-27 16:13:28
