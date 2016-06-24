/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-24 17:35:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_result
-- ----------------------------
DROP TABLE IF EXISTS `jc_result`;
CREATE TABLE `jc_result` (
  `id` varchar(50) NOT NULL,
  `relation_id` varchar(50) NOT NULL,
  `detail_id` varchar(50) NOT NULL,
  `Aproportion` int(2) default NULL,
  `Bproportion` int(2) default NULL,
  `Cproportion` int(2) default NULL,
  `Dproportion` int(2) default NULL,
  `Eproportion` int(2) default NULL,
  `Fproportion` int(2) default NULL,
  `Answerproportion` int(2) NOT NULL,
  `resultMessage` varchar(200) NOT NULL,
  `createTime` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_result
-- ----------------------------
