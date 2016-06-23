/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50087
Source Host           : localhost:3306
Source Database       : jc

Target Server Type    : MYSQL
Target Server Version : 50087
File Encoding         : 65001

Date: 2016-06-23 17:25:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for jc_paperdetail
-- ----------------------------
DROP TABLE IF EXISTS `jc_paperdetail`;
CREATE TABLE `jc_paperdetail` (
  `id` varchar(50) NOT NULL,
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
