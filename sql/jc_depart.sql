/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:34:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_depart
-- ----------------------------
DROP TABLE IF EXISTS `jc_depart`;
CREATE TABLE `jc_depart` (
  `id` varchar(50) NOT NULL,
  `depart_no` varchar(50) NOT NULL,
  `depart_name` varchar(50) NOT NULL,
  `parent_no` varchar(50) NOT NULL,
  `node_path` varchar(500) NOT NULL,
  `isLeaf` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_depart
-- ----------------------------
