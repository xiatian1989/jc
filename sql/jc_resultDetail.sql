/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:35:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_resultdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_resultdetail`;
CREATE TABLE `jc_resultdetail` (
  `id` varchar(50) NOT NULL,
  `questionNO` varchar(50) NOT NULL,
  `questionAnswer` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_resultdetail
-- ----------------------------
