/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:34:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_admin
-- ----------------------------
DROP TABLE IF EXISTS `jc_admin`;
CREATE TABLE `jc_admin` (
  `id` char(50) NOT NULL,
  `organization_id` char(50) default NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `status` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_admin
-- ----------------------------
INSERT INTO `jc_admin` VALUES ('66a2f7ceab0c4240a3885cccdf26bd82', '', 'admin', 'e10adc3949ba59abbe56e057f20f883e\r\n', '1', '1');
