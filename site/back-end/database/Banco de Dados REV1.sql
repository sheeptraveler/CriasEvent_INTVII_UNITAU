-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cadastro
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

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
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `evento_id` int(11) NOT NULL AUTO_INCREMENT,
  `evento_nome` varchar(45) NOT NULL,
  `evento_organizador_id` int(11) NOT NULL,
  `evento_descricao` text NOT NULL,
  `evento_imagem` blob NOT NULL,
  `evento_data` date NOT NULL,
  `evento_local` varchar(45) NOT NULL,
  `evento_status` enum('Ativo','Cancelado','Removido') NOT NULL,
  PRIMARY KEY (`evento_id`),
  UNIQUE KEY `evento_id_UNIQUE` (`evento_id`),
  KEY `id_usuario_idx` (`evento_organizador_id`),
  CONSTRAINT `id_usuario` FOREIGN KEY (`evento_organizador_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,'s',11,'s',_binary '�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0��\�,\0\0\0�PLTE���<{LX����\0mCb����\00u���\09y���C�\�\�\�.L�\�\�\�5P�Q`�`i�\0\"p�\�\�ew�Rk�6x!>}�\�\�\�\��Qq�\�\�\�=^�q��h��\0\0d\0)s\0j��Ǯ�\�\0h1Ev����ƕ�����4W�K�{��\0m#S����\"�Sl\0\0IDATx�\�\�v�0@C� j7�,�j����o�	u�\�\�hE��=;�����\\&d2$AAAA\�ÆR.Z9��f�vS˅Ě\�\�\�y�\�A\�~!���]�\�\�\�y��u;�\�Pv|\�v\�ڡڡڡڡ\�����\�ĩ�\�ؘ\��a\�\�Mh$�\� -\�\�7\�؝\"u�v\��\�=���\�\�Ю�]1b;{\�vb>j�)ڍ\�n�vh�v���+\�k7�f#�\��ݨ\�N<\�|�?M\�\�D�a\�<wb\"\�Dd$�Lͭd �{��jj�\�cg�\�s\�\�\�\�\�\��\�\�1\��7^���ٮ��;wW\�\�3\�\�\�l��(=\�h	o7\�Ta\'�\�4\�\�\�lB�\��\�g礄�Y\Z;w��Sf\0vK��S\����\�\�=\�1����#��Q�\0���.�i\njW����\��z\�1u�B���B��V�Fdc\n^\�ة1�P9b��3�7�yd�u�\�lkG����|\�ˮK\�++�K�JE�`갏�T^9m`/;�-W{�H\Z+\�S#\�\�@s\�2XN\�K�>\�܌�f\�\�ج	`�&\�λ�\�\�\�`�WY�\�Rȵ^\�n\�\�;5\'\�\�z\0���U����`�\�=\�\n�\�G��|\��3�Aq	�Y�\��\�\0r*\�BM\�4���^\��\�\�\�ۥ�wm��ϋG\��\�\�r]?1d��b�w�#䰏�\�\�_�G[/\�\�3\�\�oD$R�-�M��xх�\r�M~�w\�z�Ur\�b�M\�8H�\��\�13�\�Gh]��\�_�\�m=�Dݙm\�\����\�+�\�\�ŉ%��>bM)\�N\�\�,�\��D�K\'�޼��/��\�L�	���2֍���_!�zʜ�\�ɎJI\�O^.\'�ם�\"9��f�\���ݖ�߀\��\�e+m�հ���Ś׎�u\�(���8��.�\�n�ZN2\�a@d�e\�p\�Nt�\��uu�\�d\�1{\���M\�7\��\�0?�~����̲$ɲ�zH�\�vZ\�i6t�3\����jͶ���r7�]*\�\n�n\�\�D��\�?�\�����0\�\�x\��u\�\�\�\��_1$�,O��\ZWb\�e�3D�+�\�M�8R&\r].\�<��oU\��D^�q+\�\��b�R\�\�s������=r\�AAA�\��Q��!R��\0\0\0\0IEND�B`�','0022-02-22','s','Ativo');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `new_table`
--

DROP TABLE IF EXISTS `new_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `new_table` (
  `a` int(11) NOT NULL,
  PRIMARY KEY (`a`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `new_table`
--

LOCK TABLES `new_table` WRITE;
/*!40000 ALTER TABLE `new_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `new_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participacao`
--

DROP TABLE IF EXISTS `participacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participacao` (
  `id_participacao` int(11) NOT NULL AUTO_INCREMENT,
  `data_inscricao` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_participacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participacao`
--

LOCK TABLES `participacao` WRITE;
/*!40000 ALTER TABLE `participacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `participacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `participation`
--

DROP TABLE IF EXISTS `participation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `participation` (
  `participation_id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `evento_id` int(11) NOT NULL,
  PRIMARY KEY (`participation_id`),
  UNIQUE KEY `usuario_id` (`usuario_id`,`evento_id`),
  KEY `usuario_id_idx` (`usuario_id`),
  KEY `evento_id_idx` (`evento_id`),
  CONSTRAINT `evento_id` FOREIGN KEY (`evento_id`) REFERENCES `evento` (`evento_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `participation`
--

LOCK TABLES `participation` WRITE;
/*!40000 ALTER TABLE `participation` DISABLE KEYS */;
INSERT INTO `participation` VALUES (1,11,1),(3,14,1),(5,15,1);
/*!40000 ALTER TABLE `participation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome_usuario` varchar(100) NOT NULL,
  `nome_completo` varchar(100) NOT NULL,
  `email_usuario` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `senha` varchar(300) NOT NULL,
  `tipo` enum('padrao','organizador') NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `nome_usuario_UNIQUE` (`nome_usuario`),
  UNIQUE KEY `id_usuario_UNIQUE` (`id_usuario`),
  UNIQUE KEY `email_usuario_UNIQUE` (`email_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='criar usuario \n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (2,'ç','xupisco','willsoa.iam@gmail.com','0111-02-22','scrypt:32768:8:1$iMuVj8NcXKAPbQuL$43a20341c3f3e22ded3e8957909eb8df37ce6ba87','padrao'),(4,'xx','x','xupisca@hotmail.com','0002-02-02','scrypt:32768:8:1$CZlntu3D1brVdZOn$43cb831504eebd8b1a6a403a959a6ef9b83a76b9e',''),(6,'x','x','xmiglokox@gmail.com','0022-02-22','scrypt:32768:8:1$ed8xVpQkPFtD8bri$6a8ff51923c789adb7a0948c1b3ac6d971c9c288e',''),(7,'xxx','xupisco','xxmiglokoxx@gmail.com','0002-02-02','scrypt:32768:8:1$P8FNFZOeRE9x4Ga6$0bfdc8d4af391e8b0d40bbda9cfa89f9b9576e501',''),(8,'xxxxxxxxx','x','x@gmail.com','1111-11-11','scrypt:32768:8:1$UD3hyZN3BdsJojFZ$44ffd533d82715ba1d08f95f9d73a476fee7ec101',''),(9,'s','s','s@gmail.com','0000-00-00','123','padrao'),(10,'y','y','y@gmail.com','2222-02-22','scrypt:32768:8:1$0vvb2e2puSHQQk8J$8e6f53fd04762b670c03f9967a2c3a11178ad567b8d898050a6513ae80399b7e1a04bdcf7e9b764e1c6327cab41d1e525afb487bf0e8a74273c53540ef6bbcb9',''),(11,'w','w','w@gmail.com','0111-11-11','scrypt:32768:8:1$tyxCBryL9cTEQqOJ$07ceb838def3b86b05761d5b08e6aad88101652122acad95e9efeec41a6320f869f383ade7f5d119bdab6ba86bca60a40de4e914df764ec24c7ea6a68093cca9','organizador'),(14,'xupisco','xupisco','migueloliveiraa2003@gmail.com','2133-02-21','scrypt:32768:8:1$2CqUymtPgem2GOS8$f2b569ac4767ffc5c871b7b42e9fa27d545757f4e75c0768ae7ade4964680b83eb97711a382ac8f1bc24b5cc788fa58dd32f6695e45e00a5624f0c06deb1d6ac','organizador'),(15,'Cu de Fossa','Cu de Fossa','pedrocalauria2004@gmail.com','0222-02-22','scrypt:32768:8:1$rCEfzxubcm7yK2s8$cdfb0ae1a0a1fc2348a2a3724e69299c88f01a575100aa024363541c985e335d0f72a313c4524176d357fd855db906370da6dd91986433ee812fc8460fe6d379','');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-24 21:46:28
