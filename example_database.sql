/*
MySQL - 5.5.5-10.4.24-MariaDB : Exported By - Aziz Arif Rizaldi
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;
/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*Table structure for table `rents` */
DROP TABLE IF EXISTS `rents`;

CREATE TABLE `rents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `room_id` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `rents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `rents_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `rents` */

insert  into `rents`(`id`,`user_id`,`room_id`,`duration`) values (1,1,1,2),(2,2,1,1),(3,3,2,1),(4,4,1,3),(5,5,3,1),(6,1,1,1),(7,1,1,1),(8,3,5,2),(9,2,5,3),(10,2,5,1);

/*Table structure for table `rooms` */

DROP TABLE IF EXISTS `rooms`;

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `rented_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `rooms` */

insert  into `rooms`(`id`,`name`,`rented_count`) values (1,'Ruang Mawar',5),(2,'Ruang Melati',1),(3,'Ruang Tulip',1),(4,'Ruang Anggrek',0),(5,'Ruang Kamboja',2);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`address`) values (1,'Aziz Arif Rizaldi','Alamat Aziz'),(2,'Beni Wahyudi','Alamat Beni'),(3,'Cecep Rokani','Alamat Cecep'),(4,'Dirga Prakersa','Alamat Dirga'),(5,'Erlangga Ishak','Alamat Erlangga');

/* Trigger structure for table `rents` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `update_rooms_rented_count` */$$

/*!50003 CREATE TRIGGER `update_rooms_rented_count` AFTER INSERT ON `rents` FOR EACH ROW BEGIN
    UPDATE rooms
    SET rented_count = rented_count + 1
    WHERE id = NEW.room_id;
END */$$


DELIMITER ;

/* Trigger structure for table `rents` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `decrease_rooms_rented_count` */$$

/*!50003 CREATE TRIGGER `decrease_rooms_rented_count` AFTER DELETE ON `rents` FOR EACH ROW BEGIN
    UPDATE rooms
    SET rented_count = rented_count - 1
    WHERE id = OLD.room_id;
END */$$


DELIMITER ;

/* Function  structure for function  `room_popularity` */

/*!50003 DROP FUNCTION IF EXISTS `room_popularity` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `room_popularity`(params int) RETURNS varchar(50) CHARSET utf8mb4
BEGIN        
    IF params > 4 THEN
        RETURN 'PALING LAKU';
    ELSE
        RETURN 'KURANG LAKU';
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `rental_report` */

/*!50003 DROP PROCEDURE IF EXISTS  `rental_report` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `rental_report`()
BEGIN
	SELECT *, room_popularity(rooms.`rented_count`) AS rooms_status
	FROM rooms;
END */$$
DELIMITER ;

/*Table structure for table `rental_view` */

DROP TABLE IF EXISTS `rental_view`;

/*!50001 DROP VIEW IF EXISTS `rental_view` */;
/*!50001 DROP TABLE IF EXISTS `rental_view` */;

/*!50001 CREATE TABLE  `rental_view`(
 `nama_penyewa` varchar(100) ,
 `nama_ruangan` varchar(100) ,
 `durasi_sewa` int(11) 
)*/;

/*View structure for view rental_view */

/*!50001 DROP TABLE IF EXISTS `rental_view` */;
/*!50001 DROP VIEW IF EXISTS `rental_view` */;

/*!50001 CREATE VIEW `rental_view` AS select `users`.`name` AS `nama_penyewa`,`rooms`.`name` AS `nama_ruangan`,`rents`.`duration` AS `durasi_sewa` from ((`rents` join `users` on(`rents`.`user_id` = `users`.`id`)) join `rooms` on(`rents`.`room_id` = `rooms`.`id`)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
