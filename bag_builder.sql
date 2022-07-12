-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: bag_builder
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `bags`
--

DROP TABLE IF EXISTS `bags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `driver` varchar(255) DEFAULT NULL,
  `woods` varchar(255) DEFAULT NULL,
  `hybrids` varchar(255) DEFAULT NULL,
  `irons` varchar(255) DEFAULT NULL,
  `wedges` varchar(255) DEFAULT NULL,
  `putter` varchar(255) DEFAULT NULL,
  `content` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bags_users_idx` (`user_id`),
  CONSTRAINT `fk_bags_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bags`
--

LOCK TABLES `bags` WRITE;
/*!40000 ALTER TABLE `bags` DISABLE KEYS */;
INSERT INTO `bags` VALUES (2,'Distance Bag','Big Driver','Huge Woods','Rescue Hybrids','Oversized Irons','Slice','Nice',NULL,'2022-01-16 15:05:00','2022-01-22 17:17:40',2),(3,'Competitive Bag','Sponsored Driver - 2','Prototype 3 Wood','Secret Custom hybrid','Lucky Irons','Brand New Wedges','Heirloom Putter',NULL,'2022-01-16 19:28:11','2022-06-29 15:40:10',2),(4,'Simple Bag','Big Stick','Cobra 3 Wood','Titleist','Cobra One Length','PxG','Odyssey',NULL,'2022-01-17 15:32:36','2022-01-18 06:59:34',3),(5,'Vacation Bag','Lazy Driver','Sleepy Woods','All inclusive Hybrids','Poolside Irons - 2','Sandy Beach Wedge','All you can Sink',NULL,'2022-01-18 06:12:52','2022-01-25 18:39:32',2),(6,'Lazy Bag','Main Driver','None','Cobra 4h','5,7,9','SW','Odyssey',NULL,'2022-01-18 06:26:56','2022-01-18 06:26:56',3),(7,'Test Bag','','','','','','',NULL,'2022-01-18 16:31:21','2022-06-29 15:41:08',2),(11,'Kitty Clubs','Fluffy Driver','Scratch Woods','Fish Hybrids','Litter Irons','Lazy Wedges','Purring Putter',NULL,'2022-01-22 20:43:48','2022-01-22 20:44:43',4);
/*!40000 ALTER TABLE `bags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `bag_id` int NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`user_id`,`bag_id`),
  KEY `fk_users_has_bags_bags1_idx` (`bag_id`),
  KEY `fk_users_has_bags_users1_idx` (`user_id`),
  CONSTRAINT `fk_users_has_bags_bags1` FOREIGN KEY (`bag_id`) REFERENCES `bags` (`id`),
  CONSTRAINT `fk_users_has_bags_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (1,2,2,'2022-01-16 19:25:51','2022-01-16 19:25:51'),(2,2,3,'2022-01-16 19:28:15','2022-01-16 19:28:15'),(6,2,2,'2022-01-18 17:00:30','2022-01-18 17:00:30'),(8,2,7,'2022-01-18 17:10:44','2022-01-18 17:10:44'),(9,4,2,'2022-01-22 20:42:22','2022-01-22 20:42:22'),(10,2,5,'2022-01-25 18:40:09','2022-01-25 18:40:09'),(11,2,5,'2022-01-25 18:40:15','2022-01-25 18:40:15'),(12,2,5,'2022-06-20 10:03:22','2022-06-20 10:03:22'),(13,2,5,'2022-06-20 10:03:24','2022-06-20 10:03:24'),(14,2,7,'2022-07-12 12:03:12','2022-07-12 12:03:12');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Col','Rob','cole@cole.com','$2b$12$UwFmm3SvTiJZ9moLlgfd5e1hJsXsi0S7jElf9aCS.jUVtv4Yo7BYK','2022-01-16 15:04:13','2022-01-17 19:59:41'),(3,'Debbie','Rob','debbie@debbie.nya','$2b$12$I6/fehDotp1zfqHU1s/M3uEh./RA0fZgGCd.7BemO0wi6/MCPzh52','2022-01-17 15:31:51','2022-01-17 18:37:04'),(4,'Yuri','Nyan','Yuri@meow.nyet','$2b$12$JfVrAF1KadoOFCSRdgGAt.Z1YJ6XjZthR.0qNtOMix3X39fApGqrm','2022-01-22 20:41:33','2022-01-22 20:41:33'),(5,'Michael','Jordan','mj23@bb.com','$2b$12$2oqQoJ1KF9F.kAG9E8v/zO3qFN3yopxKsnsTqR7UMmqUrqdi.JeyG','2022-01-25 18:32:45','2022-01-25 18:32:45'),(6,'Yuri','San','yuri@meow.com','$2b$12$OI2ILlUNujCCkdP8fJojfeiiwVvd.TbUAPTsO/S4fA5iLH6M4BDSe','2022-06-16 14:28:46','2022-06-16 14:28:46'),(7,'New','User','user1@new.com','$2b$12$GMLED9Y2kvO7fpjCZg9rneVx7YaZPWjm9pqXX5IebAv6ehzP/3VQK','2022-06-30 09:56:01','2022-06-30 09:56:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-12 14:21:29
