/*
Navicat MySQL Data Transfer

Source Server         : 25:3306
Source Server Version : 50617
Source Host           : 192.168.1.25:3306
Source Database       : db_boman

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2014-10-09 14:31:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_biz_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_biz_tag`;
CREATE TABLE `t_biz_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '业务标签标识',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT '权重',
  `link` varchar(255) DEFAULT '' COMMENT '链接',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='业务标签';

-- ----------------------------
-- Table structure for t_constant
-- ----------------------------
DROP TABLE IF EXISTS `t_constant`;
CREATE TABLE `t_constant` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) DEFAULT '' COMMENT '常量表的key',
  `value` varchar(2048) DEFAULT '' COMMENT '常量表的value',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

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
  UNIQUE KEY `index_unique_t_friendly_link_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Table structure for t_maintenance_order
-- ----------------------------
DROP TABLE IF EXISTS `t_maintenance_order`;
CREATE TABLE `t_maintenance_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `num` char(13) NOT NULL DEFAULT '' COMMENT '订单号',
  `party_id` int(11) NOT NULL DEFAULT '0' COMMENT '当事人标识',
  `type_id` int(11) NOT NULL DEFAULT '0' COMMENT '维护类型',
  `problem` varchar(255) DEFAULT '' COMMENT '问题描述',
  `solution` varchar(255) DEFAULT '' COMMENT '解决方案',
  `employee_party_id` int(11) DEFAULT '0' COMMENT '工程师标识',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单状态(0未完成;1已完成;2已取消)',
  `desc` varchar(255) DEFAULT '' COMMENT '订单备注',
  `estimate_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评价(0未评价;1系统好评;2客户好评;3客户差评)',
  `estimate` varchar(255) DEFAULT '' COMMENT '评价(客户差评必须有)',
  `signatory` varchar(20) DEFAULT '' COMMENT '订单确认签字',
  `thru_time` datetime DEFAULT NULL COMMENT '完成时间',
  `comments` varchar(255) DEFAULT '' COMMENT '客服备注',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='免费IT维护订单表';

-- ----------------------------
-- Table structure for t_maintenance_type
-- ----------------------------
DROP TABLE IF EXISTS `t_maintenance_type`;
CREATE TABLE `t_maintenance_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT '名称',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父类型',
  `desc` varchar(255) DEFAULT '' COMMENT '描述',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(1可用;0禁用)',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_name_parent_id` (`name`,`parent_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8 COMMENT='免费IT维护类型表';

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
  `enabled` int(11) DEFAULT '1' COMMENT '启用停用状态1启用0停用',
  PRIMARY KEY (`id`),
  KEY `party_type_id` (`party_type_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='当事人';

-- ----------------------------
-- Table structure for t_party_credit
-- ----------------------------
DROP TABLE IF EXISTS `t_party_credit`;
CREATE TABLE `t_party_credit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分id',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `credit` float DEFAULT NULL COMMENT '积分',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_party_id` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='积分表';

-- ----------------------------
-- Table structure for t_party_credit_income
-- ----------------------------
DROP TABLE IF EXISTS `t_party_credit_income`;
CREATE TABLE `t_party_credit_income` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '积分id',
  `party_id` int(11) NOT NULL COMMENT '当事人标识',
  `credit` float DEFAULT NULL COMMENT '积分',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `credit_income` varchar(255) NOT NULL DEFAULT '' COMMENT '积分来源',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_party_id` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='积分来源表';

-- ----------------------------
-- Table structure for t_party_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_party_employee`;
CREATE TABLE `t_party_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工标识ID',
  `party_id` int(11) NOT NULL COMMENT '当事人标志ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '员工姓名',
  `gender` int(11) DEFAULT NULL COMMENT '员工性别',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  `phone` varchar(128) DEFAULT NULL COMMENT '手机号码',
  `qq` varchar(128) DEFAULT NULL COMMENT 'qq号码',
  `wechat` varchar(128) DEFAULT NULL COMMENT '微信账号',
  `open_wechat` varchar(128) DEFAULT NULL COMMENT '公众号',
  `enabled` int(11) DEFAULT '1' COMMENT '员工禁用启用状态 1 启用 0禁用',
  `admin_status` int(4) DEFAULT '0' COMMENT '是否是管理员',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='员工表';

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='会员组';

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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COMMENT='公司行业类别表';

-- ----------------------------
-- Table structure for t_party_maintenance
-- ----------------------------
DROP TABLE IF EXISTS `t_party_maintenance`;
CREATE TABLE `t_party_maintenance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `party_id` int(11) NOT NULL DEFAULT '0' COMMENT '当事人标识',
  `source` tinyint(4) NOT NULL DEFAULT '0' COMMENT '来源(0:默认赠送;1:积分兑换)',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COMMENT='当事人免费IT维护次数表';

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
  `contact_tel` varchar(12) NOT NULL COMMENT '固定电话',
  `contact_phone` varchar(11) NOT NULL COMMENT '联系人手机',
  `contact_email` varchar(128) NOT NULL COMMENT '联系人邮箱',
  `department` varchar(128) DEFAULT NULL COMMENT '所在部门',
  `position` varchar(128) DEFAULT NULL COMMENT '所在职位',
  `website` varchar(128) DEFAULT NULL COMMENT '公司网址',
  `industry` int(11) NOT NULL COMMENT '公司行业',
  `remark` varchar(128) DEFAULT NULL COMMENT '备注',
  `recommend_id` int(11) DEFAULT NULL COMMENT '推荐人的partyId',
  `recommend_order` char(1) DEFAULT NULL COMMENT '推荐人排序',
  `manager_order` char(1) DEFAULT NULL COMMENT '客户经理排序',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='客户表';

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
-- Table structure for t_party_person_sign_up
-- ----------------------------
DROP TABLE IF EXISTS `t_party_person_sign_up`;
CREATE TABLE `t_party_person_sign_up` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `host_id` int(11) NOT NULL COMMENT '用户id',
  `sign_date` date NOT NULL COMMENT '签到日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

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
  `enabled` int(4) DEFAULT '1' COMMENT '员工启用禁用状态 1启用  0停用',
  `level` tinyint(4) DEFAULT NULL COMMENT '地区等级',
  `parent_id` int(11) DEFAULT NULL COMMENT '父标识',
  `postal_code` int(11) DEFAULT NULL COMMENT '邮编',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique_t_party_region_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

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
  UNIQUE KEY `index_unique_party_id` (`party_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='区域站点关联表';

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
  `party_relationship_type_id` int(11) DEFAULT '0' COMMENT '当事人关系类型标识',
  `permissions_enum_id` int(11) DEFAULT '0' COMMENT '权限枚举标识',
  `position_title` varchar(255) DEFAULT '' COMMENT '职位头衔',
  `comments` varchar(255) DEFAULT '' COMMENT '说明',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_unique` (`party_id_from`,`party_relationship_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8 COMMENT='当事人关系';

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='关系类型';

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='当事人角色表关联表，当事人与角色类型多对多关系表，表示当事都都有哪些角色';

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
  `enabled` int(11) DEFAULT '1' COMMENT '停用启用状态0停用1启用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='角色类型，表示角色在不同场所充当哪种角色';

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
-- Table structure for t_party_security_user
-- ----------------------------
DROP TABLE IF EXISTS `t_party_security_user`;
CREATE TABLE `t_party_security_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `party_id` int(11) NOT NULL DEFAULT '0' COMMENT '当事人ID',
  `user_name` varchar(128) DEFAULT '' COMMENT '登陆标示符',
  `pwd` varchar(128) DEFAULT '' COMMENT '登陆需要的密码',
  `pwd_hint` varchar(128) DEFAULT '' COMMENT '密码提示',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态，0表示正常用户；1表示禁用，详见代码中的SecurityUserStatusEnums',
  `trust_time` datetime DEFAULT NULL COMMENT '信任时间，到该时间后不信任',
  `update_pwd` tinyint(4) NOT NULL DEFAULT '0' COMMENT '修改密码标识位：1表示必须修改密码，0，表示不需要修改密码。',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='用户登陆表';

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
  UNIQUE KEY `index_party_uid` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='用户安全组关联表';

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
-- Table structure for t_public_page
-- ----------------------------
DROP TABLE IF EXISTS `t_public_page`;
CREATE TABLE `t_public_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '页面主键',
  `title` varchar(255) NOT NULL COMMENT '页面标题',
  `content` text COMMENT '页面内容（html代码）',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8 COMMENT='页面表';

-- ----------------------------
-- Table structure for t_serial_num
-- ----------------------------
DROP TABLE IF EXISTS `t_serial_num`;
CREATE TABLE `t_serial_num` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标识',
  `key` varchar(9) NOT NULL DEFAULT '' COMMENT '时间',
  `value` int(11) NOT NULL DEFAULT '1' COMMENT '流水号',
  `created_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最近修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_t_serial_num_unique_key` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='流水号表';

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
  `brand_id` int(11) DEFAULT NULL COMMENT '品牌id',
  `category_id` int(11) DEFAULT NULL COMMENT '分类id',
  `desc` text COMMENT '商品描述',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '商品最后一次修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品创建时间',
  `first_secondary_category_id` int(11) DEFAULT '0' COMMENT '商品第一次要分类id',
  `second_secondary_category_id` int(11) DEFAULT '0' COMMENT '商品第二次要分类id',
  `third_secondary_category_id` int(11) DEFAULT '0' COMMENT '商品第三次要分类id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='产品管理表';

-- ----------------------------
-- Table structure for t_shop_product_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_brand`;
CREATE TABLE `t_shop_product_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT '产品品牌名称',
  `logo_path` varchar(128) NOT NULL DEFAULT '' COMMENT '产品品牌logo路径',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '产品品牌排序序号',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否停用（0-停用，1-启用）',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `desc` varchar(1024) DEFAULT '' COMMENT '品牌描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='产品品牌表';

-- ----------------------------
-- Table structure for t_shop_product_category
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_category`;
CREATE TABLE `t_shop_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '分类名称',
  `father_id` int(11) NOT NULL DEFAULT '0' COMMENT '父节点id',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '排序序号',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否停用',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='商城产品分类';

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
-- Table structure for t_shop_product_payment
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_payment`;
CREATE TABLE `t_shop_product_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商城支付方式表id',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '商城支付方式排序序号',
  `name` varchar(10) NOT NULL DEFAULT '' COMMENT '支付方式名称',
  `instruction` varchar(30) NOT NULL DEFAULT '' COMMENT '支付方式说明',
  `enabled` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否停用（默认值为1）',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='支付方式表';

-- ----------------------------
-- Table structure for t_shop_product_picture
-- ----------------------------
DROP TABLE IF EXISTS `t_shop_product_picture`;
CREATE TABLE `t_shop_product_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pic_path` varchar(256) NOT NULL COMMENT '图片路径',
  `seq_num` int(11) NOT NULL DEFAULT '0' COMMENT '排序序号',
  `product_id` int(11) NOT NULL COMMENT '产品id',
  `created_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `last_modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
