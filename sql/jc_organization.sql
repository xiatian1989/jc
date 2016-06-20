/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-20 17:41:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_organization
-- ----------------------------
DROP TABLE IF EXISTS `jc_organization`;
CREATE TABLE `jc_organization` (
  `id` char(32) NOT NULL,
  `organization_name` varchar(100) NOT NULL,
  `sequence` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_organization
-- ----------------------------
