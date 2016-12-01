/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-12-01 17:38:44
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_admin
-- ----------------------------
DROP TABLE IF EXISTS `jc_admin`;
CREATE TABLE `jc_admin` (
  `id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_admin
-- ----------------------------
INSERT INTO `jc_admin` VALUES ('050019cb63ec49998e62cf03d7db3148', 'xiatian', '', '0', '0');
INSERT INTO `jc_admin` VALUES ('66a2f7ceab0c4240a3885cccdf26bd82', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1', '1');
INSERT INTO `jc_admin` VALUES ('901f87814c8d4f46b97fad5b98d67aaa', 'feng', '', '0', '0');

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
INSERT INTO `jc_depart` VALUES ('795de6738a8c4ac7b92b91f705cf61bd', '2', '人事部', '0', '0|2', '1', '1');
INSERT INTO `jc_depart` VALUES ('d909a5d3e6eb4470a4304f3b84c04394', '1', '组织部', '0', '0|1', '1', '1');

-- ----------------------------
-- Table structure for jc_paper
-- ----------------------------
DROP TABLE IF EXISTS `jc_paper`;
CREATE TABLE `jc_paper` (
  `id` varchar(50) NOT NULL,
  `paperTitle` varchar(200) NOT NULL,
  `createTime` datetime NOT NULL,
  `type` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_paper
-- ----------------------------
INSERT INTO `jc_paper` VALUES ('be1a920b3cd94478af531405c9fd49b3', 'test1', '2016-11-30 17:43:56', '1', '1');
INSERT INTO `jc_paper` VALUES ('c32c43accb1949e8ac693e9af6a4eb66', '行政能力', '2016-11-25 14:04:54', '1', '1');

-- ----------------------------
-- Table structure for jc_paperdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_paperdetail`;
CREATE TABLE `jc_paperdetail` (
  `id` varchar(50) NOT NULL,
  `paper_id` varchar(50) default NULL,
  `questionNO` int(4) NOT NULL,
  `question` text NOT NULL,
  `optionA` varchar(200) NOT NULL,
  `optionAScore` smallint(2) NOT NULL,
  `optionB` varchar(200) NOT NULL,
  `optionBScore` smallint(2) NOT NULL,
  `optionC` varchar(200) NOT NULL,
  `optionCScore` smallint(2) NOT NULL,
  `optionD` varchar(200) NOT NULL,
  `optionDScore` smallint(2) NOT NULL,
  `optionE` varchar(200) default NULL,
  `optionEScore` smallint(2) default NULL,
  `optionF` varchar(200) default NULL,
  `optionFScore` smallint(2) default NULL,
  `isSuggest` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_paperdetail
-- ----------------------------
INSERT INTO `jc_paperdetail` VALUES ('1b0e4c80ce8d458d8e5ab29accd4c0d5', 'c32c43accb1949e8ac693e9af6a4eb66', '4', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_paperdetail` VALUES ('38d1bbf1fc81450ab92e64c84bc9cbd2', 'be1a920b3cd94478af531405c9fd49b3', '4', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_paperdetail` VALUES ('508641dbb81445aa9578184e05a0fd74', 'be1a920b3cd94478af531405c9fd49b3', '1', '是否按时完成领导交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '1', '1');
INSERT INTO `jc_paperdetail` VALUES ('6f5ec44aae0e4d8e8337b578a5f3abeb', 'c32c43accb1949e8ac693e9af6a4eb66', '4', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_paperdetail` VALUES ('a7cdfc5f2661451e942798913c6bb3c2', 'c32c43accb1949e8ac693e9af6a4eb66', '2', '是否完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '1', '0');
INSERT INTO `jc_paperdetail` VALUES ('c7e4209b2ab647da995e3a1404bc05b3', 'c32c43accb1949e8ac693e9af6a4eb66', '4', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_paperdetail` VALUES ('d0e1f92c713e4ea8b3bd8a69a037b6d6', 'be1a920b3cd94478af531405c9fd49b3', '2', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '3', '不做', '0', '0');
INSERT INTO `jc_paperdetail` VALUES ('d5594833d04d4416a71927a866a61895', 'be1a920b3cd94478af531405c9fd49b3', '1', '是否按时完成领导交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_paperdetail` VALUES ('edf34cc1f414410fabcdb9f7c4531932', 'c32c43accb1949e8ac693e9af6a4eb66', '1', '是否完成领导交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '1', '0');

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
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_plan
-- ----------------------------
INSERT INTO `jc_plan` VALUES ('37e311ebe4514f15acfde448a8ec2f16', 'hehe', '2016-12-01 15:57:00', '2016-12-02 15:57:00', '0', '2016-12-01 15:57:15');
INSERT INTO `jc_plan` VALUES ('771c04eef6f84111bd2c0b2e6ccc1ec7', '人事测评', '2016-12-01 00:00:00', '2016-12-02 00:00:00', '0', '2016-12-01 15:32:53');
INSERT INTO `jc_plan` VALUES ('c4579f41474540af90a85599847425d1', '人事测评3', '2016-12-03 17:30:00', '2016-12-10 17:30:00', '0', '2016-12-01 17:30:57');

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
  `isPerson` tinyint(1) default NULL,
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
-- Table structure for jc_templet
-- ----------------------------
DROP TABLE IF EXISTS `jc_templet`;
CREATE TABLE `jc_templet` (
  `id` varchar(50) NOT NULL,
  `templetTitle` varchar(200) NOT NULL,
  `keyWord` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `createTime` datetime NOT NULL,
  `updateTime` datetime default NULL,
  `type` tinyint(255) default NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_templet
-- ----------------------------
INSERT INTO `jc_templet` VALUES ('eecb9b1aa7a642eaa95dd723ee0ad703', '执行力', '执行力，责任心', '主要用来考核人员的执行力考核', '2016-11-18 11:25:53', '2016-11-18 11:32:56', '1', '1');

-- ----------------------------
-- Table structure for jc_templetdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_templetdetail`;
CREATE TABLE `jc_templetdetail` (
  `id` varchar(50) NOT NULL,
  `templet_id` varchar(50) NOT NULL,
  `questionNO` int(4) NOT NULL,
  `question` text NOT NULL,
  `optionA` varchar(200) NOT NULL,
  `optionAScore` smallint(2) NOT NULL,
  `optionB` varchar(200) NOT NULL,
  `optionBScore` smallint(2) NOT NULL,
  `optionC` varchar(200) NOT NULL,
  `optionCScore` smallint(2) NOT NULL,
  `optionD` varchar(200) NOT NULL,
  `optionDScore` smallint(2) NOT NULL,
  `optionE` varchar(200) default NULL,
  `optionEScore` smallint(2) default NULL,
  `optionF` varchar(200) default NULL,
  `optionFScore` smallint(2) default NULL,
  `isSuggest` tinyint(1) unsigned zerofill NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_templetdetail
-- ----------------------------
INSERT INTO `jc_templetdetail` VALUES ('1f0becfa9ecb4a04918be321e48c4a18', 'eecb9b1aa7a642eaa95dd723ee0ad703', '1', '是否按时完成领导交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');
INSERT INTO `jc_templetdetail` VALUES ('52e7df391034462ca2fc74c3c456b78f', 'eecb9b1aa7a642eaa95dd723ee0ad703', '1', '是否按时完成领导交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '1', '1');
INSERT INTO `jc_templetdetail` VALUES ('7932c2d55ad94bdabe4af7b5e9b62737', 'eecb9b1aa7a642eaa95dd723ee0ad703', '2', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '3', '不做', '0', '0');
INSERT INTO `jc_templetdetail` VALUES ('d16a465d4f8d416fa57f44b26ea703bd', 'eecb9b1aa7a642eaa95dd723ee0ad703', '4', '是否按时完成同事交代的任务', '按时，质量保证', '10', '不按时，质量保证', '8', '按时，质量不保证', '6', '不按时，质量不保证', '4', '完成不了', '2', '不做', '0', '1');

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
  `depart_No` varchar(50) NOT NULL,
  `trueName` varchar(50) NOT NULL,
  `userNo` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `leader_No` varchar(50) default NULL,
  `sex` tinyint(1) NOT NULL,
  `phone` char(11) NOT NULL,
  `webChat` varchar(50) NOT NULL,
  `createTime` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jc_user
-- ----------------------------
INSERT INTO `jc_user` VALUES ('2e31535cb29f42aaa2944d6793794ce4', '1', '用户4', '14', 'e10adc3949ba59abbe56e057f20f883e', '', '0', '13618627457', '12123', '2016-11-17 16:56:06', '1');
INSERT INTO `jc_user` VALUES ('f0ec04dc54f44586bdcfabcc526c796c', '1', '用户3', '13', 'e10adc3949ba59abbe56e057f20f883e', '21', '0', '13618627457', 'xia1991', '2016-11-17 14:03:56', '1');
SET FOREIGN_KEY_CHECKS=1;
