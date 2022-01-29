-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: shop
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `buyer`
--

DROP TABLE IF EXISTS `buyer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyer` (
  `Cid` int NOT NULL,
  `C_name` varchar(20) DEFAULT NULL,
  `C_Address` varchar(50) DEFAULT NULL,
  `pid` int DEFAULT NULL,
  `C_phone` varchar(25) DEFAULT NULL,
  KEY `pid` (`pid`),
  CONSTRAINT `buyer_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyer`
--

/*!40000 ALTER TABLE `buyer` DISABLE KEYS */;
INSERT INTO `buyer` VALUES (1,'preethi','Bengaluru',1,'1234567890'),(1,'preethi','Bengaluru',6,'1234567890'),(3,'jayanth','Bengaluru',7,'1234567890'),(3,'jayanth','Bengaluru',6,'1234567890'),(3,'jayanth','Bengaluru',13,'1234567890'),(5,'prajwal','Bengaluru',5,'1234567890');
/*!40000 ALTER TABLE `buyer` ENABLE KEYS */;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `pid` int DEFAULT NULL,
  `P_name` varchar(45) NOT NULL,
  `total_price` int NOT NULL,
  `img_url` varchar(45) NOT NULL,
  `stock` int NOT NULL,
  `quantity` int DEFAULT '1',
  `id` int DEFAULT NULL,
  KEY `pid_idx` (`pid`),
  KEY `id_idx` (`id`),
  CONSTRAINT `id` FOREIGN KEY (`id`) REFERENCES `user_login` (`id`),
  CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `products` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (6,'headphones',1000,'images/Gadgets/pid6.jpg',2,1,1),(1,'High jeans',1500,'images/Dresses/pid1.jpg',15,1,1),(5,'track pants',500,'images/Dresses/pid5.jpg',14,1,3),(13,'Kadai',2000,'images/Crockery/pid13.jpg',3,1,3);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `pid` int NOT NULL,
  `P_name` varchar(45) NOT NULL,
  `P_category` varchar(45) NOT NULL,
  `P_price` varchar(45) NOT NULL,
  `img_url` varchar(45) NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'High jeans','Dresses','1500','images/Dresses/pid1.jpg',15),(2,'Crop top','Dresses','850','images/Dresses/pid2.jpg',20),(3,'Western outfits','Dresses','1000','images/Dresses/pid3.jpg',10),(4,'Gowns','Dresses','800','images/Dresses/pid4.jpg',6),(5,'track pants','Dresses','500','images/Dresses/pid5.jpg',14),(6,'headphones','Gadgets','1000','images/Gadgets/pid6.jpg',2),(7,'Phone case','Gadgets','200','images/Gadgets/pid7.jpg',4),(8,'Screen Gaurd','Gadgets','60','images/Gadgets/pid8.jpg',25),(9,'pendrive','Gadgets','500','images/Gadgets/pid9.jpg',20),(10,'bluetooth Speaker','Gadgets','2000','images/Gadgets/pid10.jpg',5),(11,'cooking pan','Crockery','1500','images/Crockery/pid11.jpg',7),(12,'cooker','Crockery','3500','images/Crockery/pid12.jpg',12),(13,'Kadai','Crockery','2000','images/Crockery/pid13.jpg',3),(14,'glass bowls','Crockery','1500','images/Crockery/pid14.jpg',30),(15,'grilled pan','Crockery','2500','images/Crockery/pid15.jpg',6),(16,'school bags','Kids','4000','images/School/pid16.jpg',3),(17,'water bottles','Kids','1500','images/School/pid17.jpg',10),(18,'Lunch boxes','Kids','450','images/School/pid18.jpg',5),(19,'watches','Kids','1500','images/School/pid19.jpg',2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Cus_name` varchar(45) NOT NULL,
  `C_Email` varchar(45) NOT NULL,
  `C_Phone` varchar(45) NOT NULL,
  `C_password` varchar(45) NOT NULL,
  -- `C_address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES (1,'preethi','preethi.kp189@gamil.com','6366013491','preethi',''),(2,'preethi','preethi.kp189@gamil.com','6366013491','preethi',''),(3,'jayanth','jayanth@gmail.com','985647124','jayanth',''),(4,'pradeep','pradeepspj@gamil.com','9035701332','pradeep',''),(5,'prajwal','prajwal@gmail.com','965875412','prajwal','');
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-20 15:43:01
