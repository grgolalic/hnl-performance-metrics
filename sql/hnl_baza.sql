-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: hnl_ocjenjivanje
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `drzava`
--

DROP TABLE IF EXISTS `drzava`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `drzava` (
  `drzava_id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`drzava_id`),
  UNIQUE KEY `naziv` (`naziv`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drzava`
--

LOCK TABLES `drzava` WRITE;
/*!40000 ALTER TABLE `drzava` DISABLE KEYS */;
INSERT INTO `drzava` VALUES (5,'Argentina'),(2,'Brazil'),(4,'Francuska'),(1,'Hrvatska'),(3,'Španjolska');
/*!40000 ALTER TABLE `drzava` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grad`
--

DROP TABLE IF EXISTS `grad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grad` (
  `grad_id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`grad_id`),
  UNIQUE KEY `naziv` (`naziv`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grad`
--

LOCK TABLES `grad` WRITE;
/*!40000 ALTER TABLE `grad` DISABLE KEYS */;
INSERT INTO `grad` VALUES (4,'Osijek'),(3,'Rijeka'),(2,'Split'),(5,'Varaždin'),(1,'Zagreb');
/*!40000 ALTER TABLE `grad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `igrac`
--

DROP TABLE IF EXISTS `igrac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `igrac` (
  `igrac_id` int NOT NULL AUTO_INCREMENT,
  `ime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prezime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datum_rodenja` date NOT NULL,
  `visina` int DEFAULT NULL,
  `pozicija` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `broj_dresa` int DEFAULT NULL,
  `klub_id` int NOT NULL,
  `drzava_id` int NOT NULL,
  PRIMARY KEY (`igrac_id`),
  KEY `klub_id` (`klub_id`),
  KEY `drzava_id` (`drzava_id`),
  CONSTRAINT `igrac_ibfk_1` FOREIGN KEY (`klub_id`) REFERENCES `klub` (`klub_id`),
  CONSTRAINT `igrac_ibfk_2` FOREIGN KEY (`drzava_id`) REFERENCES `drzava` (`drzava_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `igrac`
--

LOCK TABLES `igrac` WRITE;
/*!40000 ALTER TABLE `igrac` DISABLE KEYS */;
INSERT INTO `igrac` VALUES (1,'Bruno','Petković','1994-09-16',193,'Napadač',9,1,1),(2,'Martin','Baturina','2003-02-16',172,'Vezni',10,1,1),(3,'Marko','Livaja','1993-08-26',182,'Napadač',10,2,1),(4,'Filip','Krovinović','1995-08-02',175,'Vezni',23,2,1),(5,'Niko','Janković','2001-02-14',180,'Vezni',4,3,1),(6,'Gabriel','Rukavina','2004-05-01',178,'Krilni',11,3,1),(7,'Ramón','Miérez','1997-05-13',181,'Napadač',9,4,5),(8,'Domagoj','Bukvić','2003-07-19',176,'Vezni',20,4,1),(9,'Matej','Vuk','2000-06-05',185,'Napadač',9,5,1),(10,'Leon','Barišić','2002-03-12',180,'Branič',5,5,1),(15,'Ante','Rebić','1989-02-02',180,'Napadač',12,2,1);
/*!40000 ALTER TABLE `igrac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `klub`
--

DROP TABLE IF EXISTS `klub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `klub` (
  `klub_id` int NOT NULL AUTO_INCREMENT,
  `puni_naziv` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `skraceni_naziv` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grad_id` int NOT NULL,
  PRIMARY KEY (`klub_id`),
  UNIQUE KEY `puni_naziv` (`puni_naziv`),
  UNIQUE KEY `skraceni_naziv` (`skraceni_naziv`),
  KEY `grad_id` (`grad_id`),
  CONSTRAINT `klub_ibfk_1` FOREIGN KEY (`grad_id`) REFERENCES `grad` (`grad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `klub`
--

LOCK TABLES `klub` WRITE;
/*!40000 ALTER TABLE `klub` DISABLE KEYS */;
INSERT INTO `klub` VALUES (1,'GNK Dinamo Zagreb','Dinamo',1),(2,'HNK Hajduk Split','Hajduk',2),(3,'HNK Rijeka','Rijeka',3),(4,'NK Osijek','Osijek',4),(5,'NK Varaždin','Varazdin',5);
/*!40000 ALTER TABLE `klub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liga`
--

DROP TABLE IF EXISTS `liga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liga` (
  `liga_id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`liga_id`),
  UNIQUE KEY `naziv` (`naziv`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liga`
--

LOCK TABLES `liga` WRITE;
/*!40000 ALTER TABLE `liga` DISABLE KEYS */;
INSERT INTO `liga` VALUES (1,'HNL');
/*!40000 ALTER TABLE `liga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocjena`
--

DROP TABLE IF EXISTS `ocjena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocjena` (
  `ocjena_id` int NOT NULL AUTO_INCREMENT,
  `vrijednost` decimal(3,2) NOT NULL,
  `datum_izracuna` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `napomena` text COLLATE utf8mb4_unicode_ci,
  `statistika_id` int NOT NULL,
  PRIMARY KEY (`ocjena_id`),
  UNIQUE KEY `statistika_id` (`statistika_id`),
  CONSTRAINT `ocjena_ibfk_1` FOREIGN KEY (`statistika_id`) REFERENCES `statistika_igraca` (`statistika_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocjena`
--

LOCK TABLES `ocjena` WRITE;
/*!40000 ALTER TABLE `ocjena` DISABLE KEYS */;
INSERT INTO `ocjena` VALUES (1,7.80,'2026-01-16 00:50:07','Dobar učinak (gol).',1),(2,7.40,'2026-01-16 00:50:07','Asistencija i dobra distribucija.',2),(3,6.90,'2026-01-16 00:50:07','Solidna utakmica u veznoj liniji.',3),(4,6.60,'2026-01-16 00:50:07','Kratak nastup, nekoliko prodora.',4),(5,7.70,'2026-01-16 00:50:07','Gol i prijetnja cijelu utakmicu.',5),(6,7.10,'2026-01-16 00:50:07','Asistencija, dobar posjed.',6),(7,7.60,'2026-01-16 00:50:07','Gol i dobra kretnja.',7),(8,6.80,'2026-01-16 00:50:07','Korektno odrađeno, karton.',8),(9,6.90,'2026-01-16 00:50:07','Stabilan nastup.',9),(10,6.70,'2026-01-16 00:50:07','Bez učinka prema naprijed.',10),(11,9.80,'2026-01-16 19:03:36','Automatski izračun (INSERT statistike).',11),(22,8.00,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',18),(23,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',17),(24,7.60,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',16),(25,6.50,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',15),(26,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',14),(27,7.60,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',13),(28,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',12),(29,7.35,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',25),(30,6.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',24),(31,7.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',23),(32,6.45,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',22),(33,6.55,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',21),(34,6.95,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',20),(35,7.35,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',19),(36,7.60,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',32),(37,6.50,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',31),(38,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',30),(39,7.60,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',29),(40,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',28),(41,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',27),(42,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',26),(43,7.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',39),(44,6.45,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',38),(45,6.55,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',37),(46,6.95,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',36),(47,7.35,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',35),(48,6.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',34),(49,6.65,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',33),(50,6.45,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',46),(51,6.55,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',45),(52,6.95,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',44),(53,7.35,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',43),(54,6.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',42),(55,6.65,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',41),(56,6.75,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',40),(57,7.60,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',53),(58,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',52),(59,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',51),(60,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',50),(61,7.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',49),(62,7.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',48),(63,6.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',47),(64,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',60),(65,6.30,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',59),(66,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',58),(67,7.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',57),(68,7.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',56),(69,6.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',55),(70,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',54),(71,7.35,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',67),(72,6.85,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',66),(73,6.65,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',65),(74,6.75,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',64),(75,7.75,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',63),(76,6.95,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',62),(77,7.05,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',61),(78,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',74),(79,7.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',73),(80,7.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',72),(81,6.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',71),(82,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',70),(83,6.00,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',69),(84,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',68),(85,7.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',81),(86,7.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',80),(87,6.40,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',79),(88,6.80,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',78),(89,6.00,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',77),(90,6.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',76),(91,7.70,'2026-01-18 13:03:42','Automatski izračun (INSERT statistike).',75),(92,9.55,'2026-01-18 13:35:14','Automatski izračun (INSERT statistike).',82);
/*!40000 ALTER TABLE `ocjena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sezona`
--

DROP TABLE IF EXISTS `sezona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sezona` (
  `sezona_id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datum_pocetka` date NOT NULL,
  `datum_zavrsetka` date NOT NULL,
  `liga_id` int NOT NULL,
  PRIMARY KEY (`sezona_id`),
  KEY `liga_id` (`liga_id`),
  CONSTRAINT `sezona_ibfk_1` FOREIGN KEY (`liga_id`) REFERENCES `liga` (`liga_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sezona`
--

LOCK TABLES `sezona` WRITE;
/*!40000 ALTER TABLE `sezona` DISABLE KEYS */;
INSERT INTO `sezona` VALUES (1,'2024/25','2024-07-20','2025-05-25',1);
/*!40000 ALTER TABLE `sezona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stadion`
--

DROP TABLE IF EXISTS `stadion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stadion` (
  `stadion_id` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kapacitet` int DEFAULT NULL,
  `grad_id` int NOT NULL,
  PRIMARY KEY (`stadion_id`),
  KEY `grad_id` (`grad_id`),
  CONSTRAINT `stadion_ibfk_1` FOREIGN KEY (`grad_id`) REFERENCES `grad` (`grad_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stadion`
--

LOCK TABLES `stadion` WRITE;
/*!40000 ALTER TABLE `stadion` DISABLE KEYS */;
INSERT INTO `stadion` VALUES (1,'Maksimir',35000,1),(2,'Poljud',34000,2),(3,'Rujevica',8200,3),(4,'Opus Arena',13000,4),(5,'Stadion Varteks',9000,5);
/*!40000 ALTER TABLE `stadion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `statistika_igraca`
--

DROP TABLE IF EXISTS `statistika_igraca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `statistika_igraca` (
  `statistika_id` int NOT NULL AUTO_INCREMENT,
  `minute` int NOT NULL DEFAULT '0',
  `golovi` int NOT NULL DEFAULT '0',
  `asistencije` int NOT NULL DEFAULT '0',
  `udarci` int NOT NULL DEFAULT '0',
  `udarci_u_okvir` int NOT NULL DEFAULT '0',
  `dodavanja` int NOT NULL DEFAULT '0',
  `uspjesna_dodavanja` int NOT NULL DEFAULT '0',
  `kljucna_dodavanja` int NOT NULL DEFAULT '0',
  `driblinzi` int NOT NULL DEFAULT '0',
  `uspjesni_driblinzi` int NOT NULL DEFAULT '0',
  `prekrsaji` int NOT NULL DEFAULT '0',
  `zuti` int NOT NULL DEFAULT '0',
  `crveni` int NOT NULL DEFAULT '0',
  `igrac_id` int NOT NULL,
  `utakmica_id` int NOT NULL,
  PRIMARY KEY (`statistika_id`),
  UNIQUE KEY `igrac_id` (`igrac_id`,`utakmica_id`),
  KEY `utakmica_id` (`utakmica_id`),
  CONSTRAINT `statistika_igraca_ibfk_1` FOREIGN KEY (`igrac_id`) REFERENCES `igrac` (`igrac_id`),
  CONSTRAINT `statistika_igraca_ibfk_2` FOREIGN KEY (`utakmica_id`) REFERENCES `utakmica` (`utakmica_id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `statistika_igraca`
--

LOCK TABLES `statistika_igraca` WRITE;
/*!40000 ALTER TABLE `statistika_igraca` DISABLE KEYS */;
INSERT INTO `statistika_igraca` VALUES (1,90,1,0,4,2,22,17,2,3,2,1,0,0,1,1),(2,90,0,1,1,1,54,49,3,2,1,2,1,0,2,1),(3,90,0,0,2,1,48,43,1,1,1,2,0,0,5,1),(4,30,0,0,1,0,12,10,0,2,1,0,0,0,6,1),(5,90,1,0,5,3,18,14,1,4,3,2,1,0,3,2),(6,85,0,1,1,0,62,56,2,1,1,1,0,0,4,2),(7,90,1,0,4,2,15,12,0,2,1,3,0,0,7,2),(8,90,0,0,1,0,51,44,1,1,1,2,1,0,8,2),(9,90,0,0,2,1,50,45,2,1,1,1,0,0,5,3),(10,90,0,0,1,0,20,16,0,1,1,2,0,0,9,3),(11,90,2,0,6,4,20,16,1,3,2,1,0,0,1,3),(12,90,0,0,5,1,36,33,2,5,1,2,0,0,1,10),(13,90,1,0,4,0,35,32,1,4,0,1,0,0,1,9),(14,90,0,0,3,1,34,31,0,3,1,0,1,0,1,8),(15,90,0,0,2,0,33,30,2,2,0,2,0,0,1,7),(16,90,0,1,5,1,32,29,1,5,1,1,0,0,1,6),(17,90,0,0,4,0,31,28,0,4,0,0,0,0,1,5),(18,90,1,0,3,1,30,27,2,3,1,2,0,0,1,4),(19,90,0,1,1,0,57,52,1,1,0,0,0,0,2,10),(20,90,0,0,3,1,56,51,3,3,1,2,0,0,2,9),(21,90,0,0,2,0,55,50,2,2,0,1,0,0,2,8),(22,90,0,0,1,1,54,49,1,1,1,0,1,0,2,7),(23,90,1,0,3,0,53,48,3,3,0,2,0,0,2,6),(24,90,0,0,2,1,52,47,2,2,1,1,0,0,2,5),(25,90,0,1,1,0,51,46,1,1,0,0,0,0,2,4),(26,90,0,0,3,1,38,35,1,3,1,1,0,0,3,10),(27,90,0,0,2,0,37,34,0,2,0,0,0,0,3,9),(28,90,0,0,5,1,36,33,2,5,1,2,0,0,3,8),(29,90,1,0,4,0,35,32,1,4,0,1,0,0,3,7),(30,90,0,0,3,1,34,31,0,3,1,0,1,0,3,6),(31,90,0,0,2,0,33,30,2,2,0,2,0,0,3,5),(32,90,0,1,5,1,32,29,1,5,1,1,0,0,3,4),(33,90,0,0,3,0,59,54,3,3,0,2,0,0,4,10),(34,90,0,0,2,1,58,53,2,2,1,1,0,0,4,9),(35,90,0,1,1,0,57,52,1,1,0,0,0,0,4,8),(36,90,0,0,3,1,56,51,3,3,1,2,0,0,4,7),(37,90,0,0,2,0,55,50,2,2,0,1,0,0,4,6),(38,90,0,0,1,1,54,49,1,1,1,0,1,0,4,5),(39,90,1,0,3,0,53,48,3,3,0,2,0,0,4,4),(40,90,0,0,1,1,60,55,1,1,1,0,0,0,5,10),(41,90,0,0,3,0,59,54,3,3,0,2,0,0,5,9),(42,90,0,0,2,1,58,53,2,2,1,1,0,0,5,8),(43,90,0,1,1,0,57,52,1,1,0,0,0,0,5,7),(44,90,0,0,3,1,56,51,3,3,1,2,0,0,5,6),(45,90,0,0,2,0,55,50,2,2,0,1,0,0,5,5),(46,90,0,0,1,1,54,49,1,1,1,0,1,0,5,4),(47,90,0,0,2,0,41,38,1,2,0,1,0,0,6,10),(48,90,1,0,5,1,40,37,0,5,1,0,0,0,6,9),(49,90,0,1,4,0,39,36,2,4,0,2,0,0,6,8),(50,90,0,0,3,1,38,35,1,3,1,1,0,0,6,7),(51,90,0,0,2,0,37,34,0,2,0,0,0,0,6,6),(52,90,0,0,5,1,36,33,2,5,1,2,0,0,6,5),(53,90,1,0,4,0,35,32,1,4,0,1,0,0,6,4),(54,90,0,0,3,1,42,39,2,3,1,2,0,0,7,10),(55,90,0,0,2,0,41,38,1,2,0,1,0,0,7,9),(56,90,1,0,5,1,40,37,0,5,1,0,0,0,7,8),(57,90,0,1,4,0,39,36,2,4,0,2,0,0,7,7),(58,90,0,0,3,1,38,35,1,3,1,1,0,0,7,6),(59,90,0,0,2,0,37,34,0,2,0,0,0,0,7,5),(60,90,0,0,5,1,36,33,2,5,1,2,0,0,7,4),(61,90,0,1,1,0,63,58,1,1,0,0,1,0,8,10),(62,90,0,0,3,1,62,57,3,3,1,2,0,0,8,9),(63,90,1,0,2,0,61,56,2,2,0,1,0,0,8,8),(64,90,0,0,1,1,60,55,1,1,1,0,0,0,8,7),(65,90,0,0,3,0,59,54,3,3,0,2,0,0,8,6),(66,90,0,0,2,1,58,53,2,2,1,1,0,0,8,5),(67,90,0,1,1,0,57,52,1,1,0,0,0,0,8,4),(68,90,0,0,5,1,44,41,1,5,1,1,0,0,9,10),(69,90,0,0,4,0,43,40,0,4,0,0,1,0,9,9),(70,90,0,0,3,1,42,39,2,3,1,2,0,0,9,8),(71,90,0,0,2,0,41,38,1,2,0,1,0,0,9,7),(72,90,1,0,5,1,40,37,0,5,1,0,0,0,9,6),(73,90,0,1,4,0,39,36,2,4,0,2,0,0,9,5),(74,90,0,0,3,1,38,35,1,3,1,1,0,0,9,4),(75,90,1,0,2,0,25,22,2,2,0,2,0,0,10,10),(76,90,0,0,5,1,44,41,1,5,1,1,0,0,10,9),(77,90,0,0,4,0,43,40,0,4,0,0,1,0,10,8),(78,90,0,0,3,1,42,39,2,3,1,2,0,0,10,7),(79,90,0,0,2,0,41,38,1,2,0,1,0,0,10,6),(80,90,1,0,5,1,40,37,0,5,1,0,0,0,10,5),(81,90,0,1,4,0,39,36,2,4,0,2,0,0,10,4),(82,75,1,2,3,2,10,4,1,5,2,4,1,0,15,2);
/*!40000 ALTER TABLE `statistika_igraca` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ocjena_after_insert` AFTER INSERT ON `statistika_igraca` FOR EACH ROW BEGIN
    DECLARE nova_ocjena DECIMAL(3,2);

    SET nova_ocjena = izracunaj_ocjenu(
        NEW.minute,
        NEW.golovi,
        NEW.asistencije,
        NEW.udarci_u_okvir,
        NEW.kljucna_dodavanja,
        NEW.uspjesni_driblinzi,
        NEW.prekrsaji,
        NEW.zuti,
        NEW.crveni
    );

    INSERT INTO ocjena (vrijednost, datum_izracuna, napomena, statistika_id)
    VALUES (nova_ocjena, NOW(), 'Automatski izračun (INSERT statistike).', NEW.statistika_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_ocjena_after_update` AFTER UPDATE ON `statistika_igraca` FOR EACH ROW BEGIN
    DECLARE nova_ocjena DECIMAL(3,2);

    SET nova_ocjena = izracunaj_ocjenu(
        NEW.minute,
        NEW.golovi,
        NEW.asistencije,
        NEW.udarci_u_okvir,
        NEW.kljucna_dodavanja,
        NEW.uspjesni_driblinzi,
        NEW.prekrsaji,
        NEW.zuti,
        NEW.crveni
    );

    UPDATE ocjena
    SET vrijednost = nova_ocjena,
        datum_izracuna = NOW(),
        napomena = 'Automatski izračun (UPDATE statistike).'
    WHERE statistika_id = NEW.statistika_id;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `trener`
--

DROP TABLE IF EXISTS `trener`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trener` (
  `trener_id` int NOT NULL AUTO_INCREMENT,
  `ime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prezime` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datum_rodenja` date DEFAULT NULL,
  PRIMARY KEY (`trener_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trener`
--

LOCK TABLES `trener` WRITE;
/*!40000 ALTER TABLE `trener` DISABLE KEYS */;
INSERT INTO `trener` VALUES (1,'Sergej','Jakirović','1976-12-17'),(2,'Mislav','Karoglan','1982-05-20'),(3,'Željko','Sopić','1974-08-18'),(4,'Federico','Coppitelli','1984-01-17'),(5,'Mario','Kovačević','1975-09-09');
/*!40000 ALTER TABLE `trener` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trener_klub`
--

DROP TABLE IF EXISTS `trener_klub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trener_klub` (
  `trener_id` int NOT NULL,
  `klub_id` int NOT NULL,
  `datum_od` date NOT NULL,
  `datum_do` date DEFAULT NULL,
  PRIMARY KEY (`trener_id`,`klub_id`,`datum_od`),
  KEY `klub_id` (`klub_id`),
  CONSTRAINT `trener_klub_ibfk_1` FOREIGN KEY (`trener_id`) REFERENCES `trener` (`trener_id`),
  CONSTRAINT `trener_klub_ibfk_2` FOREIGN KEY (`klub_id`) REFERENCES `klub` (`klub_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trener_klub`
--

LOCK TABLES `trener_klub` WRITE;
/*!40000 ALTER TABLE `trener_klub` DISABLE KEYS */;
INSERT INTO `trener_klub` VALUES (1,1,'2024-07-01',NULL),(2,2,'2024-07-01',NULL),(3,3,'2024-07-01',NULL),(4,4,'2024-07-01',NULL),(5,5,'2024-07-01',NULL);
/*!40000 ALTER TABLE `trener_klub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `utakmica`
--

DROP TABLE IF EXISTS `utakmica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `utakmica` (
  `utakmica_id` int NOT NULL AUTO_INCREMENT,
  `sezona_id` int NOT NULL,
  `datum_vrijeme` datetime NOT NULL,
  `kolo` int NOT NULL,
  `stadion_id` int NOT NULL,
  `domaci_klub_id` int NOT NULL,
  `gostujuci_klub_id` int NOT NULL,
  `gol_domaci` int NOT NULL DEFAULT '0',
  `gol_gost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`utakmica_id`),
  KEY `sezona_id` (`sezona_id`),
  KEY `stadion_id` (`stadion_id`),
  KEY `domaci_klub_id` (`domaci_klub_id`),
  KEY `gostujuci_klub_id` (`gostujuci_klub_id`),
  CONSTRAINT `utakmica_ibfk_1` FOREIGN KEY (`sezona_id`) REFERENCES `sezona` (`sezona_id`),
  CONSTRAINT `utakmica_ibfk_2` FOREIGN KEY (`stadion_id`) REFERENCES `stadion` (`stadion_id`),
  CONSTRAINT `utakmica_ibfk_3` FOREIGN KEY (`domaci_klub_id`) REFERENCES `klub` (`klub_id`),
  CONSTRAINT `utakmica_ibfk_4` FOREIGN KEY (`gostujuci_klub_id`) REFERENCES `klub` (`klub_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `utakmica`
--

LOCK TABLES `utakmica` WRITE;
/*!40000 ALTER TABLE `utakmica` DISABLE KEYS */;
INSERT INTO `utakmica` VALUES (1,1,'2024-08-10 20:00:00',1,1,1,3,2,1),(2,1,'2024-08-11 21:00:00',1,2,2,4,1,1),(3,1,'2024-08-12 19:00:00',1,3,3,5,0,0),(4,1,'2024-09-01 18:00:00',50,1,1,2,0,1),(5,1,'2024-09-02 18:00:00',51,1,1,2,1,2),(6,1,'2024-09-03 18:00:00',52,1,1,2,2,3),(7,1,'2024-09-04 18:00:00',53,1,1,2,3,0),(8,1,'2024-09-05 18:00:00',54,1,1,2,0,1),(9,1,'2024-09-06 18:00:00',55,1,1,2,1,2),(10,1,'2024-09-07 18:00:00',56,1,1,2,2,3);
/*!40000 ALTER TABLE `utakmica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hnl_ocjenjivanje'
--

--
-- Dumping routines for database 'hnl_ocjenjivanje'
--
/*!50003 DROP FUNCTION IF EXISTS `izracunaj_ocjenu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `izracunaj_ocjenu`(
    p_minute INT,
    p_golovi INT,
    p_asistencije INT,
    p_udarci_u_okvir INT,
    p_kljucna_dodavanja INT,
    p_uspjesni_driblinzi INT,
    p_prekrsaji INT,
    p_zuti INT,
    p_crveni INT
) RETURNS decimal(3,2)
    DETERMINISTIC
BEGIN
    DECLARE ocjena DECIMAL(5,2);

    -- Bazna ocjena (start)
    SET ocjena = 6.00;

    -- Nagrada za minute (ako je igrao)
    IF p_minute >= 60 THEN
        SET ocjena = ocjena + 0.30;
    ELSEIF p_minute >= 30 THEN
        SET ocjena = ocjena + 0.10;
    END IF;

    -- Pozitivne akcije
    SET ocjena = ocjena
        + (p_golovi * 1.20)
        + (p_asistencije * 0.90)
        + (p_udarci_u_okvir * 0.20)
        + (p_kljucna_dodavanja * 0.15)
        + (p_uspjesni_driblinzi * 0.10);

    -- Negativne akcije
    SET ocjena = ocjena
        - (p_prekrsaji * 0.05)
        - (p_zuti * 0.30)
        - (p_crveni * 1.20);

    -- Ograniči na raspon 0 - 10
    IF ocjena < 0 THEN
        SET ocjena = 0;
    ELSEIF ocjena > 10 THEN
        SET ocjena = 10;
    END IF;

    RETURN ROUND(ocjena, 2);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-23 18:45:28
