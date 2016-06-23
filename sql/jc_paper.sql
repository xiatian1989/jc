/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-23 17:24:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_paper
-- ----------------------------
DROP TABLE IF EXISTS `jc_paper`;
CREATE TABLE `jc_paper` (
  `id` varchar(50) NOT NULL,
  `paperDetail_id` varchar(50) NOT NULL,
  `paperTitle` varchar(500) NOT NULL,
  `isPublish` tinyint(1) NOT NULL,
  `createPerson` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_paper
-- ----------------------------
