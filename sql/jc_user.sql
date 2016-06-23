/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-23 17:25:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_user
-- ----------------------------
DROP TABLE IF EXISTS `jc_user`;
CREATE TABLE `jc_user` (
  `id` varchar(50) NOT NULL,
  `depart_no` varchar(50) NOT NULL,
  `trueName` varchar(50) NOT NULL,
  `userno` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `leader_no` varchar(50) default NULL,
  `sex` tinyint(1) NOT NULL,
  `phone` char(11) NOT NULL,
  `wechat` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_user
-- ----------------------------
