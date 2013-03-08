-- MySQL dump 10.13  Distrib 5.1.43, for Win32 (ia32)
--
-- Host: localhost    Database: ishopping
-- ------------------------------------------------------
-- Server version	5.1.43-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(45) NOT NULL,
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (10,'阿小信大人','ca09d5649ccd04ce57db79527b84d0e9b1da550e6b2552e98f0aed3861ce4b2d','ashin.myclover@gmail.com','2012-11-05 14:12:42'),(11,'test','9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08','test@test.com','2012-11-09 08:44:33');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goods`
--

DROP TABLE IF EXISTS `goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `brand` varchar(45) NOT NULL,
  `pub_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `price` float NOT NULL,
  `count` int(10) unsigned NOT NULL,
  `sex` varchar(8) NOT NULL,
  `color` varchar(24) NOT NULL,
  `size` varchar(4) NOT NULL,
  `sales` int(10) unsigned NOT NULL DEFAULT '0',
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goods`
--

LOCK TABLES `goods` WRITE;
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` VALUES (36,'凤姐','fengjie','2012-11-10 00:58:25',1,11,'男','-','-',0,'精品妹子'),(37,'芙蓉姐姐','furong','2012-11-10 00:58:26',3,15,'男','-','-',0,'精品妹子'),(38,'屌丝','adidiaosi','2012-11-10 00:53:59',5,256,'女','-','-',0,'精品汉子'),(39,'Python科学计算','清华大学出版社','2012-11-10 01:09:45',89,60,'不限','蓝色','-',0,'图书'),(40,'Python基础教程','Apress','2012-11-10 01:11:51',59,150,'不限','-','-',0,'图书'),(41,'Python源码剖析','电子工业出版社','2012-11-10 01:13:39',99,56,'不限','-','-',0,'图书'),(42,'Python灰帽子','电子工业出版社','2012-11-10 01:32:31',39,190,'不限','-','-',0,'图书'),(43,'Python网络编程基础','电子工业出版社','2012-11-10 01:34:44',68,1024,'不限','-','-',0,'图书'),(44,'Redhat卫衣','adidiaosi','2012-11-10 01:42:49',89,128,'不限','红色','L',0,'服饰'),(45,'Linux卫衣','adidiaosi','2012-11-10 01:45:43',89,1024,'不限','红色','L',0,'服饰'),(46,'木质LED台灯','Tunto','2012-11-10 01:52:53',259,90,'不限','黄色','S',0,'家电'),(47,'玫瑰台灯','Tunto','2012-11-10 01:53:44',239,98,'不限','红色','S',0,'家电'),(48,'太阳','银河系','2012-11-10 01:59:30',1e+009,1,'不限','红色','XXL',0,'精品星球'),(49,'地球','银河系','2012-11-10 02:05:47',1e+008,1,'不限','蓝色','M',0,'精品星球');
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `goodstypes`
--

DROP TABLE IF EXISTS `goodstypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `goodstypes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `goodstypes`
--

LOCK TABLES `goodstypes` WRITE;
/*!40000 ALTER TABLE `goodstypes` DISABLE KEYS */;
INSERT INTO `goodstypes` VALUES (18,'精品妹子'),(19,'精品汉子'),(20,'图书'),(21,'服饰'),(22,'家电'),(23,'精品星球');
/*!40000 ALTER TABLE `goodstypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordered_goods`
--

DROP TABLE IF EXISTS `ordered_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordered_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(10) unsigned NOT NULL,
  `how_many` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordered_goods`
--

LOCK TABLES `ordered_goods` WRITE;
/*!40000 ALTER TABLE `ordered_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordered_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `who` varchar(45) NOT NULL,
  `addr` varchar(150) NOT NULL,
  `code` varchar(45) NOT NULL,
  `callnum` varchar(45) NOT NULL,
  `is_ok` tinyint(1) DEFAULT '0',
  `email` varchar(45) NOT NULL,
  `receive` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pics`
--

DROP TABLE IF EXISTS `pics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pics` (
  `goods_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pic_url` varchar(100) NOT NULL,
  `pic_desc` varchar(150) NOT NULL,
  PRIMARY KEY (`goods_id`,`pic_url`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pics`
--

LOCK TABLES `pics` WRITE;
/*!40000 ALTER TABLE `pics` DISABLE KEYS */;
INSERT INTO `pics` VALUES (36,'http://ww1.sinaimg.cn/large/a74e55b4jw1dyowhq014zj.jpg','这个妹子怎么样~'),(36,'http://ww1.sinaimg.cn/large/a74ecc4cjw1dyowi0w8enj.jpg','你会说我是重口味吗？'),(36,'http://ww4.sinaimg.cn/large/a74ecc4cjw1dyowgobu94j.jpg','那你就错了~'),(36,'http://ww4.sinaimg.cn/large/a74eed94jw1dyowha4t9uj.jpg','这位是树袋熊_D的偶像'),(36,'http://ww4.sinaimg.cn/large/a74eed94jw1dyowijgpc1j.jpg','Orz~~~~~~'),(37,'http://ww1.sinaimg.cn/large/a74ecc4cjw1dyoy007jswj.jpg','树袋熊_D的第2个女神~~~~~'),(37,'http://ww2.sinaimg.cn/large/a74e55b4jw1dyoy1fudlnj.jpg','黄金圣斗士~~~'),(37,'http://ww2.sinaimg.cn/large/a74eed94jw1dyoy0kmemjj.jpg','质量绝对可靠360度全死角'),(38,'http://ww1.sinaimg.cn/large/a74eed94jw1dyoy46yb9wj.jpg','心中淡淡的苦涩~~'),(38,'http://ww3.sinaimg.cn/large/a74e55b4jw1dyoy4pypc4j.jpg','蛋蛋的忧伤~'),(38,'http://ww4.sinaimg.cn/large/a74ecc4cjw1dyoy3ox5knj.jpg','伤不起啊'),(39,'http://ww2.sinaimg.cn/large/a74ecc4cjw1dypo9x1uh9j.jpg','微积分顿时简单到蛋碎'),(39,'http://ww3.sinaimg.cn/large/a74e55b4jw1dypoib8mrcj.jpg','python(x,y)'),(39,'http://ww4.sinaimg.cn/large/a74eed94jw1dypoc94bn4j.jpg','pdf试读'),(40,'http://img3.douban.com/lpic/s4387251.jpg','Python基础教程封面'),(41,'http://img3.douban.com/lpic/s3435132.jpg','深度探索动态语言核心技术-封面'),(42,'http://img3.douban.com/lpic/s4676930.jpg','黑客与逆向工程师的Python编程之道'),(43,'http://img3.douban.com/lpic/s2604186.jpg','使用Python构建网络程序的综合指南'),(44,'http://ww3.sinaimg.cn/large/a74ecc4cjw1dypp9zafznj.jpg','to follow the path'),(45,'http://ww2.sinaimg.cn/large/a74eed94jw1dyppcyw03jj.jpg','知了也睡了安心的睡了'),(45,'http://ww4.sinaimg.cn/large/a74e55b4jw1dyppcl792cj.jpg','也可以偷偷的想念'),(45,'http://ww4.sinaimg.cn/large/a74ecc4cjw1dyppcrwakoj.jpg','直到让我摸到你那温暖的脸'),(45,'http://ww4.sinaimg.cn/large/a74eed94jw1dyppcdi97qj.jpg','我可以假装看不见'),(46,'http://ww3.sinaimg.cn/large/a74e55b4jw1dypplggi5yj.jpg','好看~~'),(47,'http://ww3.sinaimg.cn/large/a74ecc4cjw1dyppmcaryqj.jpg','也很好看~~'),(48,'http://ww2.sinaimg.cn/large/a74eed94jw1dypppkkj9sj.jpg','太阳风暴'),(49,'http://ww2.sinaimg.cn/large/a74eed94jw1dyppxzgzfuj.jpg','看阳光很冷淡我爱上大自然'),(49,'http://ww3.sinaimg.cn/large/a74e55b4jw1dyppy63m80j.jpg','你是巨大的海洋，我是雨下在你身上');
/*!40000 ALTER TABLE `pics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(25) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(45) NOT NULL,
  `register_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (23,'阿小信','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3','254606826@qq.com','2012-11-09 10:47:49');
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

-- Dump completed on 2012-11-10 10:25:42
