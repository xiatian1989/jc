/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-23 17:25:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_questiontype
-- ----------------------------
DROP TABLE IF EXISTS `jc_questiontype`;
CREATE TABLE `jc_questiontype` (
  `id` varchar(50) NOT NULL,
  `type` smallint(2) NOT NULL,
  `typeName` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_questiontype
-- ----------------------------
