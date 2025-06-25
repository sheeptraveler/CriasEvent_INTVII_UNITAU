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
INSERT INTO `evento` VALUES (1,'s',11,'s',_binary '‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0”\0\0\0¾÷\Û,\0\0\0PLTEÿÿÿ<{LXŠ÷ûü\0mCb‘ôöø\00u¥À\09y…–³C\İ\â\ê.Lƒ\ã\æ\ì5P†Q``i”\0\"pº\Ã\ÔewRk—6x!>}»\È\Ø\é\îóQqœ\Ê\Ö\â=^q…©hƒ©\0\0d\0)s\0j¯Ç®½\Ğ\0h1Ev‘³§²Æ•·¢©À4WŒK„{®\0m#S‹‡»\"†Sl\0\0IDATxœ\í›\ív¢0@Cù j7…,¤j­¨øşo·	u»\Û\ÓhE‡–=;÷œöÁ\\&d2$AAAA\äÃ†R.Z9°¬fvSË…Äš\Ã\Ú\İy\ÜA\Û~!ÿ]ù\Ô\Ã\Øy÷u;ü\ÇPv|\Ôv\ãÚ¡Ú¡Ú¡Ú¡\Úõ´»“\ÔÄ©š\ÔØ˜\Êûa\ì\ìMh$¦\æ -\Ì\Í7\ÃØ\"uŒv\ìŒÀ\Ú=œ°‹\Ğ\íĞ®‡]1b;{\Ôvb>j»)Ú\Än†vh‡vÿ·+\Æk7›f#¶\Ë¢İ¨\ìN<\Î|?M\È\èDûa\ì<wb\"\ÈDd$±LÍ­d »{ ñ‰ƒjj®\ï£cg¼\Ës\Æ\Î\Ô\í\Ğ\îû\ì\Ê1\Û¥7^»”Ù®†µ;wW\í\Î3\î‘\í\ìlóû(=\íh	o7\×Ta\'ı\Î4\ß\Í\ïlB\ÍÁ\ègç¤„¬Y\Z;w’«Sf\0vKµS\Ê¯”µ\Ú\è=\Ø1µ§†´#•³Q\0±£™.²i\njW³š´\æşz\Ù1u–B¶“B­ŒV«Fdc\n^\ÏØ©1P9b»3µ7¼ydùu’\ÏlkG’¥¦|\ÜË®K\Ã++¶KùJEğ`ê°T^9m`/;¶-W{ûH\Z+\ÉS#\Å\Ç@s\í2XN\çK—>\êÜŒ¡f\Ğ\ËØ¬	`ó‰&\íÎ»º\é\Å\Ô`®WY€\ËRÈµ^\Òn\Ñ\ã;5\'\Ü\åz\0»ú©U•Àú»`š\ë=\Å\nô\çG¼©|\ĞÁ3¿Aq	òY¯\Øû\Í\0r*\ËBM\Û4¸ö^\è—\Ğ\é\äÛ¥õwmğÏ‹G\Øò\ä\Ñr]?1d¨¾b³w’#ä°…\Ş\É_£G[/\Ô\Ó3\Ï\ãoD$R-©M‰öxÑ…\r‘M~“w\Ğz¼Ur\Şb‘M\Ş8H\î‰ò\Å13´\ÕGh]œ¼\Ç_õ\êm=šDİ™m\á\Ø÷ˆ’\é+ˆ\Ô\íÅ‰% ±>bM)\èN\Ì\È,“\İøDñ…£K\'¾Ş¼úœ/§£\çLô	ÿ’ğ2Ö½ƒ”_!§zÊœ©\îÉJI\ÏO^.\'•×ÿ\"9¢÷f¬\ìÿŠİ–ß€\Òû\×e+mÕ°³õµÅš×£u\Ë(ıÿ8§’.ò\în‰ZN2\Üa@d”e\Çp\áNtù\Şıuu¼\Õd\á1{\Øõ”M\à7\çñª†\Ñ0?¦~‘§õ¡Ì²$É²ò¹zH£\ãvZ\îi6tš3\í¶’—ùŸjÍ¶»œır7ª]*\İ\nòn\Ø\åD»†\í?¦î…¨\Ãö‰ºş0\Å\æx\ÑÁu\ä\Ê\İ\Õù_1$ö,O«¸\ZWb\Ğeÿ3Dº+ö\äM¼8R&\r].\é<®òoU\ëğD^…q+\ß\ØóbñR\ç\ßs¹™ğ„˜½=r\ÆAAA\ëùQ¥ƒ!R•½\0\0\0\0IEND®B`‚','0022-02-22','s','Ativo');
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
INSERT INTO `usuario` VALUES (2,'Ã§','xupisco','willsoa.iam@gmail.com','0111-02-22','scrypt:32768:8:1$iMuVj8NcXKAPbQuL$43a20341c3f3e22ded3e8957909eb8df37ce6ba87','padrao'),(4,'xx','x','xupisca@hotmail.com','0002-02-02','scrypt:32768:8:1$CZlntu3D1brVdZOn$43cb831504eebd8b1a6a403a959a6ef9b83a76b9e',''),(6,'x','x','xmiglokox@gmail.com','0022-02-22','scrypt:32768:8:1$ed8xVpQkPFtD8bri$6a8ff51923c789adb7a0948c1b3ac6d971c9c288e',''),(7,'xxx','xupisco','xxmiglokoxx@gmail.com','0002-02-02','scrypt:32768:8:1$P8FNFZOeRE9x4Ga6$0bfdc8d4af391e8b0d40bbda9cfa89f9b9576e501',''),(8,'xxxxxxxxx','x','x@gmail.com','1111-11-11','scrypt:32768:8:1$UD3hyZN3BdsJojFZ$44ffd533d82715ba1d08f95f9d73a476fee7ec101',''),(9,'s','s','s@gmail.com','0000-00-00','123','padrao'),(10,'y','y','y@gmail.com','2222-02-22','scrypt:32768:8:1$0vvb2e2puSHQQk8J$8e6f53fd04762b670c03f9967a2c3a11178ad567b8d898050a6513ae80399b7e1a04bdcf7e9b764e1c6327cab41d1e525afb487bf0e8a74273c53540ef6bbcb9',''),(11,'w','w','w@gmail.com','0111-11-11','scrypt:32768:8:1$tyxCBryL9cTEQqOJ$07ceb838def3b86b05761d5b08e6aad88101652122acad95e9efeec41a6320f869f383ade7f5d119bdab6ba86bca60a40de4e914df764ec24c7ea6a68093cca9','organizador'),(14,'xupisco','xupisco','migueloliveiraa2003@gmail.com','2133-02-21','scrypt:32768:8:1$2CqUymtPgem2GOS8$f2b569ac4767ffc5c871b7b42e9fa27d545757f4e75c0768ae7ade4964680b83eb97711a382ac8f1bc24b5cc788fa58dd32f6695e45e00a5624f0c06deb1d6ac','organizador'),(15,'Cu de Fossa','Cu de Fossa','pedrocalauria2004@gmail.com','0222-02-22','scrypt:32768:8:1$rCEfzxubcm7yK2s8$cdfb0ae1a0a1fc2348a2a3724e69299c88f01a575100aa024363541c985e335d0f72a313c4524176d357fd855db906370da6dd91986433ee812fc8460fe6d379','');
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
