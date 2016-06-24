/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:40:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_relation
-- ----------------------------
DROP TABLE IF EXISTS `jc_relation`;
CREATE TABLE `jc_relation` (
  `id` varchar(50) NOT NULL,
  `plan_id` varchar(50) NOT NULL,
  `testPerson` varchar(50) NOT NULL,
  `beTestedPerson` varchar(50) NOT NULL,
  `isFinish` tinyint(1) NOT NULL,
  `paper_id` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_relation
-- ----------------------------
