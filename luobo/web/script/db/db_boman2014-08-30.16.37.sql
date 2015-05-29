/*
Navicat MySQL Data Transfer

Source Server         : ad
Source Server Version : 50619
Source Host           : localhost:3306
Source Database       : db_boman

Target Server Type    : MYSQL
Target Server Version : 50619
File Encoding         : 65001

Date: 2014-08-30 16:37:58
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='当事人';

-- ----------------------------
-- Records of t_party
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='会员组';

-- ----------------------------
-- Records of t_party_group
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

-- ----------------------------
-- Records of t_party_region
-- ----------------------------

-- ----------------------------
-- Table structure for t_party_region_site
-- ----------------------------
DROP TABLE IF EXISTS `t_party_region_site`;
CREATE TABLE `t_party_region_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域站点关联标识',
  `party_id` int(11) NOT NULL COMMENT '站点标志',
  `region_id` int(11) DEFAULT NULL COMMENT '区域标志',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_party_id` (`party_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8 COMMENT='区域站点关联表';

-- ----------------------------
-- Records of t_party_region_site
-- ----------------------------

-- ----------------------------
-- Table structure for t_party_relationship
-- ----------------------------
DROP TABLE IF EXISTS `t_party_relationship`;
CREATE TABLE `t_party_relationship` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '当事人关系标识',
  `party_id_from` int(11) NOT NULL COMMENT '当事人标识自',
  `party_id_to` int(11) NOT NULL COMMENT '当事人标识到',
  `role_type_id_from` int(11) NOT NULL COMMENT '当事人角色标识从',
  `role_type_id_to` int(11) NOT NULL COMMENT '当事人角色标识到',
  `from_time` datetime NOT NULL COMMENT '开始时间',
  `thru_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status_id` int(11) DEFAULT '1' COMMENT '状态标识',
  `security_group_id` int(11) DEFAULT '0' COMMENT '安全组标识',
  `priority_type_id` int(11) DEFAULT '0' COMMENT '优先类型标识',
  `party_relationship_type_id` int(11) DEFAULT '0' COMMENT '当事人关系类型标识',
  `permissions_enum_id` int(11) DEFAULT '0' COMMENT '权限枚举标识',
  `position_title` varchar(255) DEFAULT '' COMMENT '职位头衔',
  `comments` varchar(255) DEFAULT '' COMMENT '说明',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique` (`party_id_from`,`party_id_to`,`party_relationship_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='当事人关系';

-- ----------------------------
-- Records of t_party_relationship
-- ----------------------------

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
  KEY `role_type_id` (`party_role_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='当事人角色表关联表，当事人与角色类型多对多关系表，表示当事都都有哪些角色';

-- ----------------------------
-- Records of t_party_role
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COMMENT='角色类型，表示角色在不同场所充当哪种角色';

-- ----------------------------
-- Records of t_party_role_type
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='权限组表。';

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='权限组关联表';

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='组权限关联表';

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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='用户登陆表';

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户安全组关联表';

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COMMENT='当事人的类别\r\n默认1为人员，2为会员组\r\n......';

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
  `pic_path` varchar(50) DEFAULT NULL COMMENT '图片路径',
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌id',
  `category_id` int(11) DEFAULT NULL COMMENT '分类id',
  `desc` text COMMENT '商品描述',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '商品最后一次修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='产品管理表';

-- ----------------------------
-- Records of t_shop_product
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='产品品牌表';

-- ----------------------------
-- Records of t_shop_product_brand
-- ----------------------------

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

-- ----------------------------
-- Table structure for t_shop_product_order
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_order`;
CREATE TABLE `t_shop_product_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '订单表id',
  `code` varchar(20) NOT NULL COMMENT '订单编号',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态（0未完成未分配 1未完成已分配 2已取消 3已完成）',
  `assessed` tinyint(2) DEFAULT '0' COMMENT '已经完成订单是否已评价(0未评价 1已评价)',
  `payment_type` varchar(20) NOT NULL COMMENT '支付方式',
  `service_person_site` varchar(20) DEFAULT NULL COMMENT '上门服务人员站点',
  `service_person_id` int(11) DEFAULT NULL COMMENT '上门服务人员id',
  `name` varchar(30) NOT NULL COMMENT '收货人姓名',
  `region` varchar(30) NOT NULL COMMENT '收货人所在区域',
  `address` varchar(255) NOT NULL COMMENT '收货地址',
  `telephone` varchar(50) NOT NULL COMMENT '收货人电话',
  `mobile_phone` varchar(50) NOT NULL COMMENT '手机',
  `comment` varchar(255) DEFAULT NULL COMMENT '附言',
  `total_price` float DEFAULT NULL COMMENT '订单总额',
  `total_credit` int(11) DEFAULT NULL COMMENT '订单总共需要积分',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单表';

-- ----------------------------
-- Records of t_shop_product_order
-- ----------------------------

-- ----------------------------
-- Table structure for t_shop_product_order_log
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_order_log`;
CREATE TABLE `t_shop_product_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '订单日志序号',
  `type` tinyint(11) NOT NULL DEFAULT '0' COMMENT '日志类型，0表示下单，1表示取消，2表示完成',
  `operate_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  `operate_personid` int(11) NOT NULL DEFAULT '0' COMMENT '操作人员(会员或管理员)id',
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
