/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50619
Source Host           : localhost:3306
Source Database       : db_boman

Target Server Type    : MYSQL
Target Server Version : 50619
File Encoding         : 65001

Date: 2014-09-05 10:01:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_friendly_link
-- ----------------------------
DROP TABLE IF EXISTS `t_friendly_link`;
CREATE TABLE `t_friendly_link` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '链接标识',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '链接名称',
  `link_address` varchar(255) DEFAULT '' COMMENT '链接地址',
  `sort_weight` int(11) DEFAULT '0' COMMENT '排序权重',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_t_friendly_link_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of t_friendly_link
-- ----------------------------

-- ----------------------------
-- Table structure for t_party
-- ----------------------------
DROP TABLE IF EXISTS `t_party`;
CREATE TABLE `t_party` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '当事人id',
  `party_type_id` int(11) NOT NULL COMMENT '当事人类型id',
  `external_id` int(11) DEFAULT '0' COMMENT '外部标识',
  `preferred_currency_uom_id` int(11) DEFAULT '0' COMMENT '优先使用币种',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `data_source_id` int(11) DEFAULT '0' COMMENT '数据资源标识',
  `is_unread` tinyint(4) DEFAULT '0' COMMENT '是否未读(1是；0否)',
  `status_id` int(11) DEFAULT '0' COMMENT '状态',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `created_by_user_login` varchar(20) DEFAULT '' COMMENT '创建人',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `last_modified_by_user_login` varchar(20) DEFAULT '' COMMENT '最后修改人',
  PRIMARY KEY (`id`),
  KEY `party_type_id` (`party_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='当事人';

-- ----------------------------
-- Records of t_party
-- ----------------------------
INSERT INTO `t_party` VALUES ('18', '1', '0', '0', '', '0', '0', '0', '2014-06-04 15:46:35', '', '2014-08-15 14:20:14', '');
INSERT INTO `t_party` VALUES ('19', '1', '0', '0', '', '0', '0', '0', '2014-06-04 15:47:51', '', '2014-08-15 14:20:18', '');
INSERT INTO `t_party` VALUES ('20', '1', '0', '0', '', '0', '0', '0', '2014-06-04 15:54:14', '', '2014-08-15 13:49:18', '');
INSERT INTO `t_party` VALUES ('21', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:03', '', '2014-08-15 13:49:19', '');
INSERT INTO `t_party` VALUES ('22', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:03', '', '2014-08-15 13:49:19', '');
INSERT INTO `t_party` VALUES ('23', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:03', '', '2014-08-15 13:49:19', '');
INSERT INTO `t_party` VALUES ('24', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:04', '', '2014-08-15 13:49:20', '');
INSERT INTO `t_party` VALUES ('25', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:04', '', '2014-08-15 13:49:20', '');
INSERT INTO `t_party` VALUES ('26', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:04', '', '2014-08-15 13:49:20', '');
INSERT INTO `t_party` VALUES ('27', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:04', '', '2014-08-15 13:49:21', '');
INSERT INTO `t_party` VALUES ('28', '1', '0', '0', '', '0', '0', '0', '2014-06-10 16:31:04', '', '2014-08-15 13:49:22', '');
INSERT INTO `t_party` VALUES ('32', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:13', '');
INSERT INTO `t_party` VALUES ('33', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:13', '');
INSERT INTO `t_party` VALUES ('34', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:13', '');
INSERT INTO `t_party` VALUES ('35', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:13', '');
INSERT INTO `t_party` VALUES ('36', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:13', '');
INSERT INTO `t_party` VALUES ('37', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-15 13:49:24', '');
INSERT INTO `t_party` VALUES ('38', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:31', '', '2014-08-26 15:02:14', '');
INSERT INTO `t_party` VALUES ('39', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:32', '', '2014-08-26 15:02:14', '');
INSERT INTO `t_party` VALUES ('40', '2', '0', '0', '', '0', '0', '0', '2014-06-10 16:36:32', '', '2014-08-26 15:02:14', '');
INSERT INTO `t_party` VALUES ('41', '2', '0', '0', '', '0', '0', '0', '2014-06-11 18:06:22', '', '2014-08-26 15:02:14', '');
INSERT INTO `t_party` VALUES ('42', '2', '0', '0', '', '0', '0', '0', '2014-06-11 18:13:18', '', '2014-08-26 15:02:14', '');
INSERT INTO `t_party` VALUES ('44', '2', '0', '0', '', '0', '0', '0', '2014-06-11 18:19:39', '', '2014-08-26 15:02:15', '');
INSERT INTO `t_party` VALUES ('45', '2', '0', '0', '', '0', '0', '0', '2014-06-11 18:26:08', '', '2014-08-26 15:02:15', '');
INSERT INTO `t_party` VALUES ('46', '2', '0', '0', '', '0', '0', '0', '2014-06-12 08:36:16', '', '2014-08-26 15:02:15', '');
INSERT INTO `t_party` VALUES ('48', '2', '0', '0', '', '0', '0', '0', '2014-06-12 08:47:41', '', '2014-08-26 15:02:15', '');
INSERT INTO `t_party` VALUES ('52', '1', '0', '0', '', '0', '0', '0', '2014-08-26 15:02:16', '', '2014-08-29 18:18:39', '');
INSERT INTO `t_party` VALUES ('81', '2', '0', '0', '', '0', '0', '0', '2014-08-30 13:51:08', '', '2014-08-30 13:51:08', '');
INSERT INTO `t_party` VALUES ('82', '2', '0', '0', '', '0', '0', '0', '2014-08-30 14:23:30', '', '2014-08-30 14:23:30', '');
INSERT INTO `t_party` VALUES ('92', '3', '0', '0', '', '0', '0', '0', '2014-09-02 16:53:45', '', '2014-09-02 16:53:45', '');

-- ----------------------------
-- Table structure for t_party_group
-- ----------------------------
DROP TABLE IF EXISTS `t_party_group`;
CREATE TABLE `t_party_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员组标识',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `name` varchar(100) NOT NULL COMMENT '名称',
  `english_name` varchar(100) DEFAULT '' COMMENT '英文名称',
  `office_site_name` varchar(100) DEFAULT '' COMMENT '办公站点名称',
  `annual_revenue` decimal(18,2) DEFAULT NULL COMMENT '年收入',
  `num_employees` decimal(20,0) DEFAULT NULL COMMENT '员工数',
  `ticker_symbol` varchar(10) DEFAULT NULL COMMENT '股票代码',
  `comments` varchar(255) DEFAULT '' COMMENT '评论',
  `logo_image_url` varchar(255) DEFAULT '' COMMENT 'logo图地址',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='会员组';

-- ----------------------------
-- Records of t_party_group
-- ----------------------------
INSERT INTO `t_party_group` VALUES ('3', '32', 'holy11', 'hohoh1', '', '0.00', '0', null, '这是宫1', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:06');
INSERT INTO `t_party_group` VALUES ('4', '33', 'holy12', 'hohoh2', '', '0.00', '0', null, '这是宫2', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:10');
INSERT INTO `t_party_group` VALUES ('5', '34', 'holy13', 'hohoh3', '', '0.00', '0', null, '这是宫3', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:24');
INSERT INTO `t_party_group` VALUES ('6', '35', 'holy14', 'hohoh4', '', '0.00', '0', null, '这是宫4', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:27');
INSERT INTO `t_party_group` VALUES ('7', '36', 'holy15', 'hohoh5', '', '0.00', '0', null, '这是宫5', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:29');
INSERT INTO `t_party_group` VALUES ('8', '37', 'holy16', 'hohoh6', '', '0.00', '0', null, '这是宫6', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:33');
INSERT INTO `t_party_group` VALUES ('9', '38', 'holy17', 'hohoh7', '', '0.00', '0', null, '这是宫7', '', null, '2014-06-10 16:36:31', '2014-06-10 17:43:36');
INSERT INTO `t_party_group` VALUES ('10', '39', 'holy181', 'hohoh8', '', '0.00', '0', null, '这是宫8', '', null, '2014-06-10 16:36:32', '2014-08-30 14:22:58');
INSERT INTO `t_party_group` VALUES ('11', '40', 'holy19', 'hohoh9', '', '0.00', '0', null, '这是宫9', '', null, '2014-06-10 16:36:32', '2014-06-10 17:43:44');
INSERT INTO `t_party_group` VALUES ('12', '41', 'pandawork', 'pandawork', 'pandawork.net', '1000.00', '50', '555', '好', 'zz', 'hao ', '2014-06-11 18:06:22', '2014-06-11 18:06:22');
INSERT INTO `t_party_group` VALUES ('13', '42', 'pandawork1', 'pandawork1', 'pandawork1', '50.00', '55', '55', 'pandawork', 'pandawork', 'pandawork', '2014-06-11 18:13:18', '2014-06-11 18:13:18');
INSERT INTO `t_party_group` VALUES ('15', '44', '组织1', 'zuzhi1', 'zuzhi1', '44.00', '44', '44', 'zuzhi1', 'zuzhi1', 'zuzhi1', '2014-06-11 18:19:40', '2014-06-11 18:19:40');
INSERT INTO `t_party_group` VALUES ('16', '45', '月华209', '209', '209', '29.00', '29', '29', '29', '29', '29', '2014-06-11 18:26:08', '2014-06-11 18:26:08');
INSERT INTO `t_party_group` VALUES ('17', '46', 'facebook', 'facebook', 'facebook', '55.00', '55', '55', 'facebook', 'facebook', 'facebook', '2014-06-12 08:36:16', '2014-06-12 08:36:16');
INSERT INTO `t_party_group` VALUES ('19', '48', 'redirect', 'shenmeyisi', 'shenmeyisi', '555.00', '44', '44', 'shenmeyisi', 'shenmeyisi', 'shenmeyisi', '2014-06-12 08:47:42', '2014-06-13 14:06:55');
INSERT INTO `t_party_group` VALUES ('50', '81', 'fsa', '', '', null, null, null, '', '', '', '2014-08-30 13:51:08', '2014-08-30 13:51:08');
INSERT INTO `t_party_group` VALUES ('51', '82', '111', '', '', null, null, null, '', '', '', '2014-08-30 14:23:30', '2014-08-30 14:23:30');

-- ----------------------------
-- Table structure for t_party_industry_type
-- ----------------------------
DROP TABLE IF EXISTS `t_party_industry_type`;
CREATE TABLE `t_party_industry_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公司行业ID',
  `name` varchar(255) NOT NULL COMMENT '行业名称',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公司行业类别表';

-- ----------------------------
-- Records of t_party_industry_type
-- ----------------------------

-- ----------------------------
-- Table structure for t_party_member
-- ----------------------------
DROP TABLE IF EXISTS `t_party_member`;
CREATE TABLE `t_party_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `name` varchar(128) NOT NULL COMMENT '公司全称',
  `office_site_name` varchar(255) NOT NULL COMMENT '详细办公地址',
  `contact_person` varchar(128) NOT NULL COMMENT '联系人姓名',
  `contact_phone` varchar(11) NOT NULL COMMENT '联系人手机',
  `contact_email` varchar(128) NOT NULL COMMENT '联系人邮箱',
  `department` varchar(128) DEFAULT NULL COMMENT '所在部门',
  `position` varchar(128) NOT NULL COMMENT '所在职位',
  `website` varchar(128) DEFAULT NULL COMMENT '公司网址',
  `industry` int(11) NOT NULL COMMENT '公司行业',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='客户表';

-- ----------------------------
-- Records of t_party_member
-- ----------------------------
INSERT INTO `t_party_member` VALUES ('2', '92', '广告公司', '北京', '小明', '18744047227', '1530238286@qq.com', '信息技术部', '程序员', 'www.eee.com', '1', '2014-09-02 16:53:45', '2014-09-02 16:53:45');

-- ----------------------------
-- Table structure for t_party_person
-- ----------------------------
DROP TABLE IF EXISTS `t_party_person`;
CREATE TABLE `t_party_person` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '会员标识',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `family_name` varchar(100) DEFAULT '' COMMENT '姓',
  `given_name` varchar(100) DEFAULT '' COMMENT '名',
  `personal_title` varchar(100) DEFAULT '' COMMENT '头衔',
  `suffix` varchar(100) DEFAULT '' COMMENT '后缀',
  `nickname` varchar(100) DEFAULT '' COMMENT '昵称',
  `english_name` varchar(100) DEFAULT '' COMMENT '英文名字',
  `member_id` int(11) DEFAULT NULL COMMENT '成员标识',
  `gender` tinyint(4) DEFAULT '0' COMMENT '性别(0.未设置1.男;2.女)',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `height` double DEFAULT NULL COMMENT '身高',
  `weight` double DEFAULT NULL COMMENT '体重',
  `mothers_maiden_name` varchar(255) DEFAULT '' COMMENT '母亲娘家姓',
  `marital_status` tinyint(4) DEFAULT '0' COMMENT '婚姻状态(0未设置;1单身;2已婚3分居;4离异;5丧偶)',
  `social_security_number` varchar(100) DEFAULT NULL COMMENT '社保号',
  `passport_number` varchar(100) DEFAULT NULL COMMENT '护照号',
  `passport_expire_time` date DEFAULT NULL COMMENT '护照过期时间',
  `total_years_work_experience` double DEFAULT NULL COMMENT '总工作年限',
  `comments` varchar(255) DEFAULT '' COMMENT '评论',
  `employment_status_enum_id` int(11) DEFAULT '0' COMMENT '雇用状态',
  `residence_status_enum_id` int(11) DEFAULT '0' COMMENT '居住状态',
  `occupation` varchar(255) DEFAULT '' COMMENT '职业',
  `years_with_employer` decimal(20,0) DEFAULT '0' COMMENT '雇佣年数',
  `months_with_employer` decimal(20,0) DEFAULT '0' COMMENT '雇佣月数',
  `existing_customer` tinyint(4) DEFAULT '1' COMMENT '是否是存在的客户(1.是；0.否)',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='会员';

-- ----------------------------
-- Records of t_party_person
-- ----------------------------
INSERT INTO `t_party_person` VALUES ('1', '18', '语', '文', '1', '1', '哇哈哈', '1', '1', '0', '2014-06-18', '0', '0', 'sdasf', '0', '23423423424234', '3424234', '2014-06-09', '0', 'asdaf', '1', '0', '', '0', '0', '1', '11', '2014-06-04 15:46:35', '2014-06-18 15:54:51');
INSERT INTO `t_party_person` VALUES ('2', '19', '语', '文', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-04 15:47:51', '2014-06-12 18:56:07');
INSERT INTO `t_party_person` VALUES ('3', '20', '余', 'zzz', 'zzz', 'zzz', 'zzz', 'zzzz', null, '0', null, '0', '0', '', '0', '', '', null, '0', 'zzz', '1', '0', '', '0', '0', '1', '', '2014-06-04 15:54:14', '2014-06-21 17:22:57');
INSERT INTO `t_party_person` VALUES ('4', '21', '余0', '以飞0', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:03', '2014-06-10 16:31:03');
INSERT INTO `t_party_person` VALUES ('5', '22', '余1', '以飞1', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:03', '2014-06-10 16:31:03');
INSERT INTO `t_party_person` VALUES ('6', '23', '余2', '以飞2', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-06-10 16:31:04');
INSERT INTO `t_party_person` VALUES ('7', '24', '余3', '以飞3', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-06-10 16:31:04');
INSERT INTO `t_party_person` VALUES ('8', '25', '余4', '以飞4', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-06-10 16:31:04');
INSERT INTO `t_party_person` VALUES ('9', '26', '余5', '以飞5', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-06-10 16:31:04');
INSERT INTO `t_party_person` VALUES ('10', '27', '余6', '以飞6', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-06-10 16:31:04');
INSERT INTO `t_party_person` VALUES ('11', '28', '王', '王', '', '', '', '', null, '1', null, '0', '0', '', '0', null, null, null, '0', '', '0', '0', '', '0', '0', '1', '', '2014-06-10 16:31:04', '2014-08-14 10:27:45');

-- ----------------------------
-- Table structure for t_party_region
-- ----------------------------
DROP TABLE IF EXISTS `t_party_region`;
CREATE TABLE `t_party_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地区标识',
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '地区名称',
  `customer_num` int(11) NOT NULL DEFAULT '0' COMMENT '区域拥有客户数',
  `sort_weight` int(4) NOT NULL DEFAULT '0' COMMENT '排序权重',
  `open_products` int(4) NOT NULL DEFAULT '0' COMMENT '是否开通核心产品',
  `level` tinyint(4) DEFAULT NULL COMMENT '地区等级',
  `parent_id` int(11) DEFAULT NULL COMMENT '父标识',
  `postal_code` int(11) DEFAULT NULL COMMENT '邮编',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_t_party_region_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

-- ----------------------------
-- Records of t_party_region
-- ----------------------------
INSERT INTO `t_party_region` VALUES ('2', '朝阳区', '1111111111', '1', '0', '0', '0', '0', '2014-08-21 15:43:43', '2014-09-02 09:55:38');
INSERT INTO `t_party_region` VALUES ('3', '丰台区', '0', '1', '0', '0', '0', '0', '2014-08-21 15:43:48', '2014-08-30 17:10:41');
INSERT INTO `t_party_region` VALUES ('4', '通州区', '5', '5', '1', '0', '0', '0', '2014-08-21 15:44:31', '2014-08-28 17:46:51');
INSERT INTO `t_party_region` VALUES ('18', '昌平区', '12', '12', '0', '1', '1', '1', '2014-08-29 14:53:29', '2014-08-29 14:53:29');
INSERT INTO `t_party_region` VALUES ('38', '海淀区', '23', '2', '1', null, null, null, '2014-08-30 14:39:32', '2014-08-30 14:39:32');
INSERT INTO `t_party_region` VALUES ('67', '最后', '11111111', '0', '0', null, null, null, '2014-09-03 09:57:17', '2014-09-03 09:57:17');
INSERT INTO `t_party_region` VALUES ('68', '追吼吼', '1', '0', '0', null, null, null, '2014-09-03 10:24:11', '2014-09-03 10:24:11');

-- ----------------------------
-- Table structure for t_party_region_site
-- ----------------------------
DROP TABLE IF EXISTS `t_party_region_site`;
CREATE TABLE `t_party_region_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域站点关联标识',
  `party_id` int(11) NOT NULL COMMENT '站点标志',
  `region_id` int(11) DEFAULT NULL COMMENT '区域标志',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_party_id` (`party_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COMMENT='区域站点关联表';

-- ----------------------------
-- Records of t_party_region_site
-- ----------------------------
INSERT INTO `t_party_region_site` VALUES ('63', '81', '3', '2014-08-30 13:51:29', '2014-08-30 13:51:29');
INSERT INTO `t_party_region_site` VALUES ('64', '48', '4', '2014-08-30 13:51:44', '2014-08-30 13:51:44');
INSERT INTO `t_party_region_site` VALUES ('65', '46', '18', '2014-08-30 13:51:54', '2014-08-30 13:51:54');
INSERT INTO `t_party_region_site` VALUES ('68', '39', '18', '2014-08-30 14:22:53', '2014-08-30 14:22:53');
INSERT INTO `t_party_region_site` VALUES ('70', '35', '30', '2014-08-30 14:23:14', '2014-08-30 14:23:14');
INSERT INTO `t_party_region_site` VALUES ('72', '82', '34', '2014-08-30 14:23:36', '2014-08-30 14:23:36');

-- ----------------------------
-- Table structure for t_party_relationship
-- ----------------------------
DROP TABLE IF EXISTS `t_party_relationship`;
CREATE TABLE `t_party_relationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '当事人关系标识',
  `party_id_from` int(11) NOT NULL COMMENT '当事人标识自',
  `party_id_to` int(11) NOT NULL COMMENT '当事人标识到',
  `role_type_id_from` int(11) DEFAULT NULL COMMENT '当事人角色标识从',
  `role_type_id_to` int(11) DEFAULT NULL COMMENT '当事人角色标识到',
  `from_time` datetime DEFAULT NULL COMMENT '开始时间',
  `thru_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status_id` int(11) DEFAULT '1' COMMENT '状态标识',
  `security_group_id` int(11) DEFAULT '0' COMMENT '安全组标识',
  `priority_type_id` int(11) DEFAULT '0' COMMENT '优先类型标识',
  `party_relationship_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '当事人关系类型标识',
  `permissions_enum_id` int(11) DEFAULT '0' COMMENT '权限枚举标识',
  `position_title` varchar(255) DEFAULT '' COMMENT '职位头衔',
  `comments` varchar(255) DEFAULT '' COMMENT '说明',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique` (`party_id_from`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='当事人关系';

-- ----------------------------
-- Records of t_party_relationship
-- ----------------------------
INSERT INTO `t_party_relationship` VALUES ('4', '1', '1', '1', '1', '2014-08-20 13:52:05', null, null, '0', '0', '1', '0', '', '', '2014-08-20 13:52:01', '2014-09-02 11:10:05');
INSERT INTO `t_party_relationship` VALUES ('8', '2', '1', null, null, null, null, '1', '0', '0', '4', '0', '', '', '2014-09-02 11:12:31', '2014-09-02 12:26:03');
INSERT INTO `t_party_relationship` VALUES ('12', '92', '1', null, null, null, null, '1', '0', '0', '4', '0', '', '', '2014-09-02 17:15:33', '2014-09-02 17:15:33');

-- ----------------------------
-- Table structure for t_party_relationship_type
-- ----------------------------
DROP TABLE IF EXISTS `t_party_relationship_type`;
CREATE TABLE `t_party_relationship_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '关系类型标识',
  `name` varchar(20) NOT NULL COMMENT '关系名称',
  `parent_id` int(11) DEFAULT '0' COMMENT '上级类型',
  `has_table` tinyint(4) DEFAULT '0' COMMENT '有库表',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `role_type_id_valid_from` int(11) DEFAULT '0' COMMENT '角色标识有效从',
  `role_type_id_valid_to` int(11) DEFAULT '0' COMMENT '角色标识有效到',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_Unique_t_party_relationship_type_name` (`name`,`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='关系类型';

-- ----------------------------
-- Records of t_party_relationship_type
-- ----------------------------
INSERT INTO `t_party_relationship_type` VALUES ('1', '好人关系', '0', '1', '好人关系', '1', '1', '2014-07-01 09:05:23', '2014-07-01 09:05:23');
INSERT INTO `t_party_relationship_type` VALUES ('2', 'asdasdasd淡淡的', null, '0', 'asdasdasd淡淡的', '1', '1', '2014-07-02 09:38:36', '2014-07-02 09:38:36');
INSERT INTO `t_party_relationship_type` VALUES ('3', 'ddddddd', null, '0', 'asdaddddd', '1', '1', '2014-07-03 08:36:29', '2014-07-03 08:36:29');
INSERT INTO `t_party_relationship_type` VALUES ('4', '合伙人', null, '0', '合伙人', '1', '1', '2014-07-03 09:04:41', '2014-07-03 09:04:41');
INSERT INTO `t_party_relationship_type` VALUES ('5', 'asddddddd', null, '0', 'ddd', '1', '1', '2014-07-03 17:19:45', '2014-07-03 17:19:45');
INSERT INTO `t_party_relationship_type` VALUES ('6', 'asddddddd', null, '0', 'ddd', '1', '1', '2014-07-03 17:24:02', '2014-07-03 17:24:02');
INSERT INTO `t_party_relationship_type` VALUES ('7', 'henghang', null, '0', 'henghang', '1', '1', '2014-07-03 20:43:13', '2014-07-03 20:43:13');

-- ----------------------------
-- Table structure for t_party_role
-- ----------------------------
DROP TABLE IF EXISTS `t_party_role`;
CREATE TABLE `t_party_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '当事人角色标识',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `party_role_type_id` int(11) NOT NULL COMMENT '角色类型标识',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_party_id` (`party_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='当事人角色表关联表，当事人与角色类型多对多关系表，表示当事都都有哪些角色';

-- ----------------------------
-- Records of t_party_role
-- ----------------------------
INSERT INTO `t_party_role` VALUES ('26', '2', '3', '2014-09-04 09:04:24', '2014-09-04 09:04:53');

-- ----------------------------
-- Table structure for t_party_role_type
-- ----------------------------
DROP TABLE IF EXISTS `t_party_role_type`;
CREATE TABLE `t_party_role_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色类型标识',
  `name` varchar(20) NOT NULL COMMENT '类型名称',
  `parent_id` int(11) DEFAULT '0' COMMENT '上级类型标识',
  `has_table` tinyint(4) DEFAULT '0' COMMENT '有库表',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='角色类型，表示角色在不同场所充当哪种角色';

-- ----------------------------
-- Records of t_party_role_type
-- ----------------------------
INSERT INTO `t_party_role_type` VALUES ('1', '整站管理员', '0', '0', '卡布达', '2014-06-05 10:17:01', '2014-09-01 16:55:08');
INSERT INTO `t_party_role_type` VALUES ('2', '子系统管理员', '0', '0', '子系统管理员', '2014-06-05 10:17:21', '2014-06-19 16:05:43');
INSERT INTO `t_party_role_type` VALUES ('3', '管理员', '1', '0', '管理员', '2014-06-05 10:17:32', '2014-06-05 10:17:32');
INSERT INTO `t_party_role_type` VALUES ('5', '哈哈哈哈', '1', '0', '价格监管机构', '2014-06-13 14:28:11', '2014-06-13 14:28:11');
INSERT INTO `t_party_role_type` VALUES ('15', '好人', '0', '0', '这是好人', '2014-06-19 16:14:51', '2014-06-19 16:14:51');
INSERT INTO `t_party_role_type` VALUES ('17', '坏人角色', '0', '0', '坏人角色', '2014-06-21 17:03:10', '2014-06-21 17:03:10');
INSERT INTO `t_party_role_type` VALUES ('23', '坏人', '0', '0', 'fsd', '2014-08-28 10:49:24', '2014-08-28 13:41:06');

-- ----------------------------
-- Table structure for t_party_security_group
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_group`;
CREATE TABLE `t_party_security_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) CHARACTER SET utf8 DEFAULT '' COMMENT '组名称',
  `desc` varchar(1024) CHARACTER SET utf8 DEFAULT '' COMMENT '组的简短描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限组表。';

-- ----------------------------
-- Records of t_party_security_group
-- ----------------------------
INSERT INTO `t_party_security_group` VALUES ('1', 'Admin', 'Admin', '2014-06-05 00:00:00', '2014-08-27 10:58:05');
INSERT INTO `t_party_security_group` VALUES ('2', 'User', 'User', '2014-06-10 16:03:05', '2014-08-27 10:58:09');

-- ----------------------------
-- Table structure for t_party_security_group_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_group_permission`;
CREATE TABLE `t_party_security_group_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限组ID',
  `permission_id` int(11) NOT NULL DEFAULT '0' COMMENT '权限ID',
  `from_time` datetime DEFAULT NULL COMMENT '开始时间',
  `thru_time` datetime DEFAULT NULL COMMENT '结束时间',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `fk_party_security_gourp_id` (`group_id`) USING BTREE,
  KEY `fk_party_security_permission_id` (`permission_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='权限组关联表';

-- ----------------------------
-- Records of t_party_security_group_permission
-- ----------------------------
INSERT INTO `t_party_security_group_permission` VALUES ('1', '1', '1', '2014-06-11 21:03:33', null, '2014-06-11 21:03:33', '2014-08-27 10:58:30');
INSERT INTO `t_party_security_group_permission` VALUES ('2', '2', '2', '2014-06-11 21:04:03', null, '2014-06-11 21:04:03', '2014-08-27 10:58:32');

-- ----------------------------
-- Table structure for t_party_security_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_permission`;
CREATE TABLE `t_party_security_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT '' COMMENT '权限名称',
  `expression` varchar(512) DEFAULT '' COMMENT '权限表达式',
  `desc` varchar(1024) DEFAULT '' COMMENT '权限描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='组权限关联表';

-- ----------------------------
-- Records of t_party_security_permission
-- ----------------------------
INSERT INTO `t_party_security_permission` VALUES ('1', 'Admin', 'Admin', 'Admin', '2014-06-05 00:00:00', '2014-08-27 10:58:51');
INSERT INTO `t_party_security_permission` VALUES ('2', 'User', 'User', 'User', '2014-06-11 19:51:53', '2014-08-27 10:58:59');

-- ----------------------------
-- Table structure for t_party_security_user
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_user`;
CREATE TABLE `t_party_security_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(128) DEFAULT '' COMMENT '登陆标示符',
  `pwd` varchar(128) DEFAULT '' COMMENT '登陆需要的密码',
  `pwd_hint` varchar(128) DEFAULT '' COMMENT '密码提示',
  `party_id` int(11) NOT NULL DEFAULT '0' COMMENT '当事人ID',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态，0表示正常用户；1表示禁用，详见代码中的SecurityUserStatusEnums',
  `trust_time` datetime DEFAULT NULL COMMENT '信任时间，到该时间后不信任',
  `update_pwd` tinyint(4) NOT NULL DEFAULT '0' COMMENT '修改密码标识位：1表示必须修改密码，0，表示不需要修改密码。',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_Unique_t_party_security_user_user_name` (`user_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户登陆表';

-- ----------------------------
-- Records of t_party_security_user
-- ----------------------------
INSERT INTO `t_party_security_user` VALUES ('1', '0000', '96d0028878d58c89feb959b7d4642fcb', '', '1', '0', null, '0', '2014-06-13 10:22:32', '2014-08-28 14:04:00');

-- ----------------------------
-- Table structure for t_party_security_user_group
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_user_group`;
CREATE TABLE `t_party_security_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` int(11) NOT NULL COMMENT '权限组id',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `from_time` datetime NOT NULL COMMENT '信任开始时间',
  `trust_time` datetime DEFAULT NULL COMMENT '信任结束时间',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  KEY `index_party_uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户安全组关联表';

-- ----------------------------
-- Records of t_party_security_user_group
-- ----------------------------
INSERT INTO `t_party_security_user_group` VALUES ('1', '1', '1', '2014-08-28 15:39:21', '0000-00-00 00:00:00', '2014-06-05 15:54:56', null);

-- ----------------------------
-- Table structure for t_party_type
-- ----------------------------
DROP TABLE IF EXISTS `t_party_type`;
CREATE TABLE `t_party_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '当事人类型标识',
  `name` varchar(20) NOT NULL COMMENT '当事人类型名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级类型标识',
  `has_table` tinyint(4) DEFAULT '0' COMMENT '有库表',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_Unique_t_party_type_type_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='当事人的类别\r\n默认1为人员，2为会员组\r\n......';

-- ----------------------------
-- Records of t_party_type
-- ----------------------------
INSERT INTO `t_party_type` VALUES ('1', '人员', '0', '0', '代表个人', '2014-05-29 10:57:47', '2014-08-15 16:27:26');
INSERT INTO `t_party_type` VALUES ('2', '站点', '2', '0', '站点', '2014-06-03 14:13:59', '2014-08-26 11:10:24');
INSERT INTO `t_party_type` VALUES ('3', '客户', '2', '0', '客户', '2014-06-03 14:12:41', '2014-08-26 11:10:26');

-- ----------------------------
-- Table structure for t_shop_product
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product`;
CREATE TABLE `t_shop_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `name` varchar(30) DEFAULT NULL COMMENT '商品名称',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '商品类型(0代表非积分，1代表积分)',
  `price` float DEFAULT NULL COMMENT '商品价格或积分',
  `market_price` float DEFAULT NULL COMMENT '商品市场价格',
  `bar_code` int(11) DEFAULT NULL COMMENT '商品条码',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '商品序号',
  `send_credits` int(11) DEFAULT NULL COMMENT '商品赠送积分',
  `inventory` int(11) DEFAULT NULL COMMENT '库存量',
  `sales_volume` int(11) DEFAULT NULL COMMENT '销售数量',
  `pic_path` varchar(128) DEFAULT NULL COMMENT '图片路径',
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌id',
  `category_id` int(11) DEFAULT NULL COMMENT '分类id',
  `desc` text COMMENT '商品描述',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '商品最后一次修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='产品管理表';

-- ----------------------------
-- Records of t_shop_product
-- ----------------------------
INSERT INTO `t_shop_product` VALUES ('1', '7', '12', '9.99', '6.66', '1', '11', '13', '0', '10', '/8/8/8', '1', '3', '4', '2014-08-27 09:50:17', '2014-08-25 17:16:48');
INSERT INTO `t_shop_product` VALUES ('2', '蒋坤', '1', '123.2', '123.01', '2', '122', '12', '132', '123', '/asd/asd/asd', '12', '12', '421321321dsadjlaskjdlk好好', '2014-08-27 09:51:47', '2014-08-25 17:11:24');
INSERT INTO `t_shop_product` VALUES ('4', '1', '1', '1', '1', '1', '1', '1', '1', '1', '/shop/product/pic/4/e49e7384daefa231c3c2b20c0b4f4837140963816497142.jpg', '1', '1', '1', '2014-09-02 14:09:24', '2014-09-02 14:09:24');

-- ----------------------------
-- Table structure for t_shop_product_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_brand`;
CREATE TABLE `t_shop_product_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '产品品牌名称',
  `logo_path` varchar(128) NOT NULL DEFAULT '' COMMENT '产品品牌logo路径',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '产品品牌排序序号',
  `canceled` tinyint(11) NOT NULL DEFAULT '0' COMMENT '是否取消(1-取消，0-不取消)',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='产品品牌表';

-- ----------------------------
-- Records of t_shop_product_brand
-- ----------------------------
INSERT INTO `t_shop_product_brand` VALUES ('1', 'mbp', '/shop/product/logo/c114d3ba0303c43f6e9d9c182c9759ee140903251834284.doc', '1', '1', '2014-08-26 14:02:17', '2014-08-26 10:17:22');
INSERT INTO `t_shop_product_brand` VALUES ('2', 'mac11', '/shop/product/logo/ee795a1e00d3654eda5f3eb8fd7c9b4f14090195052337.doc', '1', '0', '2014-08-26 10:18:27', '2014-08-26 10:18:27');
INSERT INTO `t_shop_product_brand` VALUES ('3', 'mac11', '/shop/product/logo/ee795a1e00d3654eda5f3eb8fd7c9b4f14090206566145.doc', '1', '0', '2014-08-26 10:37:38', '2014-08-26 10:37:38');
INSERT INTO `t_shop_product_brand` VALUES ('4', 'mac11', '/shop/product/logo/ee795a1e00d3654eda5f3eb8fd7c9b4f140902215125849.doc', '1', '0', '2014-08-26 11:02:33', '2014-08-26 11:02:33');
INSERT INTO `t_shop_product_brand` VALUES ('5', 'test', '/shop/product/logo/5\\ab43e7d500b7d6c8b61fcf60ad6ca346140910876603496.png', '1', '0', '2014-08-27 11:06:06', '2014-08-27 11:06:05');
INSERT INTO `t_shop_product_brand` VALUES ('6', 'test', '/shop/product/logo/6\\ab43e7d500b7d6c8b61fcf60ad6ca346140910924117463.png', '1', '0', '2014-08-27 11:14:01', '2014-08-27 11:14:00');
INSERT INTO `t_shop_product_brand` VALUES ('7', 'test', '/shop/product/logo/7\\ab43e7d500b7d6c8b61fcf60ad6ca346140910949561970.png', '1', '0', '2014-08-27 11:18:15', '2014-08-27 11:18:15');
INSERT INTO `t_shop_product_brand` VALUES ('8', 'test1111', '/shop/product/logo/8\\ab43e7d500b7d6c8b61fcf60ad6ca34614091265968123.png', '1', '0', '2014-08-27 16:03:17', '2014-08-27 16:03:15');
INSERT INTO `t_shop_product_brand` VALUES ('9', 'test1111', '/shop/product/logo/9\\ab43e7d500b7d6c8b61fcf60ad6ca346140912668829782.png', '1', '0', '2014-08-27 16:04:48', '2014-08-27 16:04:48');
INSERT INTO `t_shop_product_brand` VALUES ('10', 'macbook air', '/shop/product/logo/10/f2d3eb2e59c532ee1c624b72cd4ecef8140912911050572.png', '2', '0', '2014-08-27 16:45:10', '2014-08-27 16:45:09');
INSERT INTO `t_shop_product_brand` VALUES ('11', 'rewfdsfds', '/shop/product/logo/11/f212dc64035ef702df1fae0d2814057a140912919865491.png', '12321', '0', '2014-08-27 16:46:38', '2014-08-27 16:46:38');
INSERT INTO `t_shop_product_brand` VALUES ('12', '1', '/shop/product/logo/12/e49e7384daefa231c3c2b20c0b4f4837140962509740212.jpg', '2', '0', '2014-09-02 10:31:37', '2014-09-02 10:31:36');

-- ----------------------------
-- Table structure for t_shop_product_category
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_category`;
CREATE TABLE `t_shop_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父节点id',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '排序序号',
  `canceled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否停用',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='商城产品分类';

-- ----------------------------
-- Records of t_shop_product_category
-- ----------------------------
INSERT INTO `t_shop_product_category` VALUES ('1', '笔记本', '0', '15', '1', '2014-08-25 15:18:39', '2014-08-25 15:36:21');
INSERT INTO `t_shop_product_category` VALUES ('2', '电脑', '1', '12', '0', '2014-08-25 16:35:27', '2014-08-25 16:35:27');

-- ----------------------------
-- Table structure for t_shop_product_order
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_order`;
CREATE TABLE `t_shop_product_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单表id',
  `party_id` int(11) NOT NULL DEFAULT '0' COMMENT '会员id',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态（0未完成未分配 1未完成已分配 2已取消 3已完成）',
  `assessed` tinyint(2) NOT NULL DEFAULT '0' COMMENT '已经完成订单是否已评价(0未评价 1已评价且满意 2已评价但不满意)',
  `assess_content` varchar(255) NOT NULL DEFAULT '' COMMENT '评价内容(当不满意时需要填写评价内容)',
  `payment_type` varchar(20) NOT NULL DEFAULT '' COMMENT '支付方式',
  `service_person_site_id` int(11) NOT NULL DEFAULT '0' COMMENT '上门服务人员站点id',
  `service_person_id` int(11) NOT NULL DEFAULT '0' COMMENT '上门服务人员id',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人姓名',
  `region` varchar(30) NOT NULL DEFAULT '' COMMENT '收货人所在区域',
  `address` varchar(255) NOT NULL DEFAULT '' COMMENT '收货地址',
  `telephone` varchar(50) NOT NULL DEFAULT '' COMMENT '收货人电话',
  `mobile_phone` varchar(50) NOT NULL DEFAULT '' COMMENT '手机',
  `comment` varchar(255) NOT NULL DEFAULT '' COMMENT '附言(会员下单时填的)',
  `total_price` float(2,0) NOT NULL DEFAULT '0' COMMENT '订单总额',
  `total_credit` float(2,0) NOT NULL DEFAULT '0' COMMENT '订单总共需要积分',
  `total_credit_after_buy` float(2,0) NOT NULL DEFAULT '0' COMMENT '购买成功可赠送总积分',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '订单备注(管理员在管理员面板填的)',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of t_shop_product_order
-- ----------------------------
INSERT INTO `t_shop_product_order` VALUES ('1', '2', '0', '0', '', '', '0', '0', '庞名狮', '', '', '', '', '', '0', '0', '0', '', '2014-09-02 15:56:56', '2014-09-02 15:56:56');
INSERT INTO `t_shop_product_order` VALUES ('2', '1', '0', '0', '', '', '0', '0', '庞哥', '', '', '18658633558', '', '', '0', '0', '0', '', '2014-09-02 16:45:42', '2014-09-02 16:45:42');
INSERT INTO `t_shop_product_order` VALUES ('3', '1', '1', '0', '', '', '0', '0', '二蛋', '', '', '13918622338', '', '', '0', '0', '0', '', '2014-09-02 16:46:03', '2014-09-02 16:46:03');

-- ----------------------------
-- Table structure for t_shop_product_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_order_detail`;
CREATE TABLE `t_shop_product_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单产品信息表id',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单id',
  `product_type` int(11) NOT NULL DEFAULT '0' COMMENT '产品类型(0为非积分商品 1为积分商品)',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '订单产品id',
  `price` float(2,0) NOT NULL DEFAULT '0' COMMENT '购买所需单价或者积分',
  `send_credits` int(11) NOT NULL DEFAULT '0' COMMENT '单件产品购买可送积分数(默认为0)',
  `amount` int(11) NOT NULL DEFAULT '0' COMMENT '购买数量',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单产品信息表';

-- ----------------------------
-- Records of t_shop_product_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for t_shop_product_order_log
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_order_log`;
CREATE TABLE `t_shop_product_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '订单日志序号',
  `type` varchar(5) NOT NULL DEFAULT '' COMMENT '日志类型，0表示下单，1表示取消，2表示完成',
  `operate_person_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人员(会员或管理员)id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间(操作时间)',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='产品订单的操作日志表';

-- ----------------------------
-- Records of t_shop_product_order_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_shop_product_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_payment`;
CREATE TABLE `t_shop_product_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商城支付方式表id',
  `name` varchar(10) NOT NULL COMMENT '支付方式名称',
  `instruction` varchar(30) DEFAULT NULL COMMENT '支付方式说明',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='支付方式表';

-- ----------------------------
-- Records of t_shop_product_payment
-- ----------------------------
INSERT INTO `t_shop_product_payment` VALUES ('1', '', null, '2014-08-25 16:47:34', '2014-08-25 16:47:34');
INSERT INTO `t_shop_product_payment` VALUES ('2', '刷卡付款', null, '2014-08-25 16:48:18', '2014-08-26 17:01:05');
INSERT INTO `t_shop_product_payment` VALUES ('3', '微信支付', null, '2014-08-26 16:34:20', '2014-08-26 16:34:20');
INSERT INTO `t_shop_product_payment` VALUES ('4', '测试', null, '2014-08-26 17:43:01', '2014-08-26 17:43:01');
