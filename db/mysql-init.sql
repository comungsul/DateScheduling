-- drop database if exists example_docker_db;
-- create database example_docker_db;
use example_db;

--
-- Table structure for table `example_table`
--

-- DROP TABLE IF EXISTS `example_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `example_table` (
  `id`        int(20)   NOT NULL,
  `INS_DATE`  datetime     NOT NULL,
  `NAME`      varchar(255) NOT NULL,
  `VALUE`     varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE `duty`(
`title` VARCHAR(45) NOT NULL,
`info` VARCHAR(200) NULL,
`userId` VARCHAR(45) NOT NULL,
`date` VARCHAR(45) NOT NULL,
`weight` VARCHAR(45) NOT NULL,
PRIMARY KEY(`title`))ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`(
`userName` VARCHAR(45) NOT NULL,
`userId` VARCHAR(45) NOT NULL,
`userPw` VARCHAR(45) NOT NULL,
PRIMARY KEY(`userId`))ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EXAMPLE_TABLE`
--

LOCK TABLES `example_table` WRITE;
/*!40000 ALTER TABLE `example_table` DISABLE KEYS */;
INSERT INTO `example_table` (id, INS_DATE, NAME, VALUE)
VALUES
( 1, now(), 'example-1', 'value-1'),
( 2, now(), 'example-2', 'value-2'),
( 3, now(), 'example-3', 'value-3');
/*!40000 ALTER TABLE `example_table` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `duty` WRITE;
/*!40000 ALTER TABLE `duty` DISABLE KEYS */;
INSERT INTO `duty` (title, info, userId, date, weight)
VALUES
( 'OSS report', 'max:25p', '222', '20211209','3'),
( 'computer application design', 'so difficult..', '111', '20211220','5'),
( 'computer network', 'make socket sniffer', '111', '20211209','4');
/*!40000 ALTER TABLE `duty` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (userName, userId, userPw)
VALUES
( 'hj', '111','111'),
( '2mh','222','222'),
( 'hihi','333','333');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES; 
