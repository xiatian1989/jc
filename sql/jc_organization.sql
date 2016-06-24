/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:34:56
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
INSERT INTO `jc_organization` VALUES ('7183ac0e68e64bc2bbf7af4c1a2e5d86', '中国中老年组织', '2', '0');
INSERT INTO `jc_organization` VALUES ('ae7591af487146819ad747e4eb79586d', '中国青少年组织', '1', '1');
