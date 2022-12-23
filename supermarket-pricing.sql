-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: supermarket_pricing
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `name` varchar(50) COLLATE utf32_persian_ci DEFAULT NULL,
  `code` varchar(5) COLLATE utf32_persian_ci DEFAULT (left(uuid(),5)),
  `userId` binary(16) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_persian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `name` varchar(50) COLLATE utf32_persian_ci NOT NULL,
  `code` varchar(5) COLLATE utf32_persian_ci NOT NULL DEFAULT (left(uuid(),5)),
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_persian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `good_price`
--

DROP TABLE IF EXISTS `good_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `good_price` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `goodId` binary(16) NOT NULL,
  `price` decimal(10,0) unsigned NOT NULL,
  `dateApplicable` date NOT NULL,
  `pwpPrice` decimal(10,0) unsigned DEFAULT NULL,
  `quantityToFree` tinyint unsigned DEFAULT NULL,
  `quantityBeFree` tinyint unsigned DEFAULT NULL,
  `quantityToGift` tinyint unsigned DEFAULT NULL,
  `giftGoodId` binary(16) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `giftGoodIdInGoodPriceToIdInGoods` (`goodId`,`giftGoodId`),
  KEY `giftGoodIdInGoodPriceToIdInGoods_idx` (`giftGoodId`),
  CONSTRAINT `giftGoodIdGoodPrice_IdGoods` FOREIGN KEY (`giftGoodId`) REFERENCES `goods` (`id`),
  CONSTRAINT `goodIdGoodPrice_IdGoods` FOREIGN KEY (`goodId`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_persian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `good_price`
--

LOCK TABLES `good_price` WRITE;
/*!40000 ALTER TABLE `good_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `good_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `goods` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `name` varchar(50) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `code` varchar(5) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_goods`
--

DROP TABLE IF EXISTS `invoice_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_goods` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `invoiceId` binary(16) NOT NULL,
  `goodId` binary(16) NOT NULL,
  `goodPrice` decimal(10,0) unsigned NOT NULL,
  `free` bit(1) DEFAULT NULL,
  `freeByGoodId` binary(16) DEFAULT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `invoiceIdInvoiceGoods_IdInvoices` (`invoiceId`),
  KEY `goodIdInvoiceGoods_IdGoods` (`goodId`),
  KEY `freeByGoodIdInInvoiceGoodsToIdInGoods_idx` (`freeByGoodId`),
  CONSTRAINT `freeByGoodIdInvoiceGoods_IdGoods` FOREIGN KEY (`freeByGoodId`) REFERENCES `goods` (`id`),
  CONSTRAINT `goodIdInvoiceGoods_IdGoods` FOREIGN KEY (`goodId`) REFERENCES `goods` (`id`),
  CONSTRAINT `invoiceIdInvoiceGoods_IdInvoices` FOREIGN KEY (`invoiceId`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_goods`
--

LOCK TABLES `invoice_goods` WRITE;
/*!40000 ALTER TABLE `invoice_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `no` varchar(15) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL,
  `clientId` binary(16) NOT NULL,
  `totalPrice` decimal(10,0) unsigned NOT NULL,
  `currencyId` binary(16) NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `currencyIdInvoices_IdCurrencies` (`currencyId`),
  KEY `clientIdInvoices_IdClients` (`clientId`),
  CONSTRAINT `clientIdInvoices_IdClients` FOREIGN KEY (`clientId`) REFERENCES `clients` (`id`),
  CONSTRAINT `currencyIdInvoices_IdCurrencies` FOREIGN KEY (`currencyId`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes_coins`
--

DROP TABLE IF EXISTS `notes_coins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes_coins` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `name` varchar(15) COLLATE utf32_persian_ci NOT NULL,
  `code` varchar(5) COLLATE utf32_persian_ci NOT NULL DEFAULT (left(uuid(),5)),
  `value` decimal(10,0) NOT NULL,
  `currencyId` binary(16) NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `currencyIdNotesCoins_IdCurrencies` (`currencyId`),
  CONSTRAINT `currencyIdNotesCoins_IdCurrencies` FOREIGN KEY (`currencyId`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_persian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes_coins`
--

LOCK TABLES `notes_coins` WRITE;
/*!40000 ALTER TABLE `notes_coins` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes_coins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_in_good`
--

DROP TABLE IF EXISTS `stock_in_good`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock_in_good` (
  `id` binary(16) NOT NULL DEFAULT (uuid_to_bin(uuid())),
  `goodId` binary(16) NOT NULL,
  `quantity` tinyint unsigned NOT NULL,
  `inPrice` decimal(10,0) unsigned NOT NULL,
  `inDate` date NOT NULL,
  `active` bit(1) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `creatorId` binary(16) NOT NULL,
  `createDate` date NOT NULL,
  `updaterId` binary(16) DEFAULT NULL,
  `updDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `goodIdStockInGood_IdGoods` (`goodId`),
  CONSTRAINT `goodIdStockInGood_IdGoods` FOREIGN KEY (`goodId`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_in_good`
--

LOCK TABLES `stock_in_good` WRITE;
/*!40000 ALTER TABLE `stock_in_good` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_in_good` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-23 17:54:20
