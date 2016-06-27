/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-27 23:25:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_admin
-- ----------------------------
DROP TABLE IF EXISTS `jc_admin`;
CREATE TABLE `jc_admin` (
  `id` varchar(50) NOT NULL,
  `organization_id` varchar(50) default NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_admin
-- ----------------------------
INSERT INTO `jc_admin` VALUES ('4ae4019c137d470990298b2c6806a03d', '016440c0e633440d955452b8150bde28', 'xiatian', '', '0', '1');
INSERT INTO `jc_admin` VALUES ('66a2f7ceab0c4240a3885cccdf26bd82', '', 'admin', 'e10adc3949ba59abbe56e057f20f883e\r\n', '1', '1');

-- ----------------------------
-- Table structure for jc_depart
-- ----------------------------
DROP TABLE IF EXISTS `jc_depart`;
CREATE TABLE `jc_depart` (
  `id` varchar(50) NOT NULL,
  `depart_no` varchar(50) NOT NULL,
  `depart_name` varchar(100) NOT NULL,
  `parent_no` varchar(50) NOT NULL,
  `node_path` varchar(500) NOT NULL,
  `isLeaf` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_depart
-- ----------------------------

-- ----------------------------
-- Table structure for jc_organization
-- ----------------------------
DROP TABLE IF EXISTS `jc_organization`;
CREATE TABLE `jc_organization` (
  `id` varchar(50) NOT NULL,
  `organization_name` varchar(100) NOT NULL,
  `sequence` int(4) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_organization
-- ----------------------------
INSERT INTO `jc_organization` VALUES ('016440c0e633440d955452b8150bde28', '中国青年组织', '1', '1');
INSERT INTO `jc_organization` VALUES ('3f9707c783e3461ab601891d67c99a6b', '中国儿童组织', '5', '1');
INSERT INTO `jc_organization` VALUES ('c6f38dc45c01402199a62329e0f672bf', '中国少年组织', '4', '1');
INSERT INTO `jc_organization` VALUES ('d0b5c24ee50243a5bb9d882499bfd926', '中国中年组织', '3', '1');
INSERT INTO `jc_organization` VALUES ('e67838a55c6348fca88e00b797c5d178', '中国老年组织', '2', '1');

-- ----------------------------
-- Table structure for jc_paper
-- ----------------------------
DROP TABLE IF EXISTS `jc_paper`;
CREATE TABLE `jc_paper` (
  `id` varchar(50) NOT NULL,
  `sequence` int(4) NOT NULL,
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

-- ----------------------------
-- Table structure for jc_paperdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_paperdetail`;
CREATE TABLE `jc_paperdetail` (
  `id` varchar(50) NOT NULL,
  `questionNO` int(4) NOT NULL,
  `questionType` smallint(2) NOT NULL,
  `question` text NOT NULL,
  `optionA` varchar(200) NOT NULL,
  `optionAScore` smallint(2) NOT NULL,
  `optionB` varchar(200) NOT NULL,
  `optionBScore` smallint(2) NOT NULL,
  `optionC` varchar(200) NOT NULL,
  `optionCScore` smallint(2) NOT NULL,
  `optionD` varchar(200) NOT NULL,
  `optionDScore` smallint(2) NOT NULL,
  `optionE` varchar(200) NOT NULL,
  `optionEScore` smallint(2) NOT NULL,
  `optionF` varchar(200) NOT NULL,
  `optionFScore` smallint(2) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_paperdetail
-- ----------------------------

-- ----------------------------
-- Table structure for jc_plan
-- ----------------------------
DROP TABLE IF EXISTS `jc_plan`;
CREATE TABLE `jc_plan` (
  `id` varchar(50) NOT NULL,
  `planTitle` varchar(100) NOT NULL,
  `beginTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `isFinish` tinyint(1) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_plan
-- ----------------------------

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

-- ----------------------------
-- Table structure for jc_result
-- ----------------------------
DROP TABLE IF EXISTS `jc_result`;
CREATE TABLE `jc_result` (
  `id` varchar(50) NOT NULL,
  `relation_id` varchar(50) NOT NULL,
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

-- ----------------------------
-- Table structure for jc_resultdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_resultdetail`;
CREATE TABLE `jc_resultdetail` (
  `id` varchar(50) NOT NULL,
  `questionNO` int(4) NOT NULL,
  `questionAnswer` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_resultdetail
-- ----------------------------

-- ----------------------------
-- Table structure for jc_testformessage
-- ----------------------------
DROP TABLE IF EXISTS `jc_testformessage`;
CREATE TABLE `jc_testformessage` (
  `id` varchar(50) NOT NULL,
  `organization_id` varchar(50) NOT NULL,
  `relation_id` varchar(50) NOT NULL,
  `isUse` tinyint(1) NOT NULL,
  `createTime` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_testformessage
-- ----------------------------

-- ----------------------------
-- Table structure for jc_user
-- ----------------------------
DROP TABLE IF EXISTS `jc_user`;
CREATE TABLE `jc_user` (
  `id` varchar(50) NOT NULL,
  `organization_id` varchar(50) NOT NULL,
  `depart_no` varchar(50) NOT NULL,
  `trueName` varchar(50) NOT NULL,
  `userno` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `leader_no` varchar(50) default NULL,
  `sex` tinyint(1) NOT NULL,
  `phone` char(11) NOT NULL,
  `wechat` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_user
-- ----------------------------
