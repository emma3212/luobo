/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.6.19-log : Database - luobo
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`luobo` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `luobo`;

/*Table structure for table `t_currency` */

DROP TABLE IF EXISTS `t_currency`;

CREATE TABLE `t_currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '货币名称',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='货币表';

/*Data for the table `t_currency` */

insert  into `t_currency`(`id`,`name`,`created_time`,`last_modified_time`) values (3,'1234','2015-06-01 10:49:02','2015-06-01 10:49:02'),(4,'美元','2015-06-01 15:04:53','2015-06-01 15:04:53'),(5,'人名币','2015-06-01 15:05:05','2015-06-01 15:05:05'),(6,'欧元','2015-06-01 15:05:20','2015-06-01 15:05:20'),(7,'日元','2015-06-02 13:32:49','2015-06-02 13:32:49'),(8,'32','2015-06-03 17:47:50','2015-06-03 17:47:50'),(9,'韩元','2015-06-03 20:39:27','2015-06-03 20:39:27');

/*Table structure for table `t_rate` */

DROP TABLE IF EXISTS `t_rate`;

CREATE TABLE `t_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `from_currency_id` int(11) NOT NULL COMMENT '原币种id',
  `to_currency_id` int(11) NOT NULL COMMENT '目标币种id',
  `rate` decimal(10,4) NOT NULL COMMENT '汇率',
  `date` date DEFAULT NULL COMMENT '兑换日期',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `NewIndex1` (`from_currency_id`,`to_currency_id`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='汇率表';

/*Data for the table `t_rate` */

insert  into `t_rate`(`id`,`from_currency_id`,`to_currency_id`,`rate`,`date`,`created_time`,`last_modified_time`) values (1,4,7,'1.0000','2015-05-29','2015-05-29 14:29:46','2015-06-03 16:56:50'),(2,4,6,'1.2000','2015-01-23','2015-06-01 15:31:08','2015-06-01 15:31:08'),(3,4,5,'1.2000','2014-12-01','2015-06-01 16:18:39','2015-06-01 16:48:30'),(4,5,7,'1.5000','2014-12-06','2015-06-02 13:33:15','2015-06-02 13:33:15'),(5,4,7,'1.2000','2015-06-02','2015-06-02 13:37:26','2015-06-02 13:41:40'),(6,5,3,'1.5000','2015-06-02','2015-06-02 13:38:20','2015-06-02 13:41:33'),(7,3,4,'23.0000','2015-06-02','2015-06-02 13:41:59','2015-06-02 13:41:59'),(8,4,6,'1.5000','2015-06-03','2015-06-03 17:47:24','2015-06-03 17:47:24'),(9,9,4,'1.5000','2015-06-03','2015-06-03 20:39:46','2015-06-03 20:39:46'),(10,4,7,'1.6000','2015-06-01','2015-06-03 20:42:40','2015-06-03 20:42:40');

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(128) DEFAULT '' COMMENT '登陆标示符',
  `pwd` varchar(128) DEFAULT '' COMMENT '登陆需要的密码',
  `group_id` tinyint(4) DEFAULT '0' COMMENT '权限组',
  `enabled` tinyint(4) DEFAULT '1' COMMENT '用户状态，1可用；0不可用',
  `card_num` varchar(32) DEFAULT '' COMMENT '会员卡卡号',
  `open_id` varchar(128) DEFAULT '' COMMENT 'openId',
  `update_pwd` tinyint(4) NOT NULL DEFAULT '1' COMMENT '修改密码标识位：1表示必须修改密码，0，表示不需要修改密码。',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_user_name` (`login_name`) USING BTREE,
  KEY `index_user_status` (`enabled`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='用户登陆表';

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`login_name`,`pwd`,`group_id`,`enabled`,`card_num`,`open_id`,`update_pwd`,`created_time`,`last_modified_time`) values (1,'admin','25d55ad283aa400af464c76d713c07ad',1,1,'','',1,'2015-06-03 18:39:50','2015-06-03 18:39:50');

/*Table structure for table `t_user_group` */

DROP TABLE IF EXISTS `t_user_group`;

CREATE TABLE `t_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT '' COMMENT '组名称',
  `desc` varchar(1024) DEFAULT '' COMMENT '组的简短描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='权限组表。';

/*Data for the table `t_user_group` */

insert  into `t_user_group`(`id`,`name`,`desc`,`created_time`,`last_modified_time`) values (1,'Admin','Admin','2014-06-05 00:00:00','2014-08-27 10:58:05'),(2,'Vip','Vip','2014-06-10 16:03:05','2015-01-21 17:05:07');

/*Table structure for table `t_user_group_permission` */

DROP TABLE IF EXISTS `t_user_group_permission`;

CREATE TABLE `t_user_group_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限组ID',
  `permission_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限ID',
  `from_time` datetime DEFAULT NULL COMMENT '开始时间',
  `thru_time` datetime DEFAULT NULL COMMENT '结束时间',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `index_party_security_group_id_permission_id` (`group_id`,`permission_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='权限组关联表';

/*Data for the table `t_user_group_permission` */

insert  into `t_user_group_permission`(`id`,`group_id`,`permission_id`,`from_time`,`thru_time`,`created_time`,`last_modified_time`) values (1,1,1,'2014-06-11 21:03:33',NULL,'2014-06-11 21:03:33','2014-08-27 10:58:30'),(2,2,2,'2014-06-11 21:04:03',NULL,'2014-06-11 21:04:03','2014-08-27 10:58:32');

/*Table structure for table `t_user_permission` */

DROP TABLE IF EXISTS `t_user_permission`;

CREATE TABLE `t_user_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expression` varchar(512) DEFAULT '' COMMENT '权限表达式',
  `desc` varchar(1024) DEFAULT '' COMMENT '权限描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组权限关联表';

/*Data for the table `t_user_permission` */

insert  into `t_user_permission`(`id`,`expression`,`desc`,`created_time`,`last_modified_time`) values (1,'Admin','Admin','2014-06-05 00:00:00','2014-08-27 10:58:51'),(2,'Vip','Vip','2014-06-11 19:51:53','2015-01-21 17:05:16');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
