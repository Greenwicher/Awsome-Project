-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2014-03-12 05:47:20
-- 服务器版本： 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- 表的结构 `auth_group`
--

CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `auth_group_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `auth_permission`
--

CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=46 ;

--
-- 转存表中的数据 `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can add permission', 2, 'add_permission'),
(5, 'Can change permission', 2, 'change_permission'),
(6, 'Can delete permission', 2, 'delete_permission'),
(7, 'Can add group', 3, 'add_group'),
(8, 'Can change group', 3, 'change_group'),
(9, 'Can delete group', 3, 'delete_group'),
(10, 'Can add user', 4, 'add_user'),
(11, 'Can change user', 4, 'change_user'),
(12, 'Can delete user', 4, 'delete_user'),
(13, 'Can add content type', 5, 'add_contenttype'),
(14, 'Can change content type', 5, 'change_contenttype'),
(15, 'Can delete content type', 5, 'delete_contenttype'),
(16, 'Can add session', 6, 'add_session'),
(17, 'Can change session', 6, 'change_session'),
(18, 'Can delete session', 6, 'delete_session'),
(19, 'Can add book', 7, 'add_book'),
(20, 'Can change book', 7, 'change_book'),
(21, 'Can delete book', 7, 'delete_book'),
(22, 'Can add customer', 8, 'add_customer'),
(23, 'Can change customer', 8, 'change_customer'),
(24, 'Can delete customer', 8, 'delete_customer'),
(25, 'Can add supplier', 9, 'add_supplier'),
(26, 'Can change supplier', 9, 'change_supplier'),
(27, 'Can delete supplier', 9, 'delete_supplier'),
(28, 'Can add customer order', 10, 'add_customerorder'),
(29, 'Can change customer order', 10, 'change_customerorder'),
(30, 'Can delete customer order', 10, 'delete_customerorder'),
(31, 'Can add purchase order', 11, 'add_purchaseorder'),
(32, 'Can change purchase order', 11, 'change_purchaseorder'),
(33, 'Can delete purchase order', 11, 'delete_purchaseorder'),
(34, 'Can add in list', 12, 'add_inlist'),
(35, 'Can change in list', 12, 'change_inlist'),
(36, 'Can delete in list', 12, 'delete_inlist'),
(37, 'Can add out list', 13, 'add_outlist'),
(38, 'Can change out list', 13, 'change_outlist'),
(39, 'Can delete out list', 13, 'delete_outlist'),
(40, 'Can add financial report', 14, 'add_financialreport'),
(41, 'Can change financial report', 14, 'change_financialreport'),
(42, 'Can delete financial report', 14, 'delete_financialreport'),
(43, 'Can add stock list', 15, 'add_stocklist'),
(44, 'Can change stock list', 15, 'change_stocklist'),
(45, 'Can delete stock list', 15, 'delete_stocklist');

-- --------------------------------------------------------

--
-- 表的结构 `auth_user`
--

CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_bin NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_bin NOT NULL,
  `first_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `last_name` varchar(30) COLLATE utf8_bin NOT NULL,
  `email` varchar(75) COLLATE utf8_bin NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=23 ;

--
-- 转存表中的数据 `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$12000$sxhSXzRgjrAz$IE0jFKOCldk2HAv2ljNJqAEh/pmIe2hTIDsMZk+X7g8=', '2014-03-12 03:29:24', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2014-03-04 04:56:21'),
(14, 'pbkdf2_sha256$12000$gWwWx55xg02S$68hNH7VLiLUQRmWOXDEvojYbTo8fEoSFDPO6cU0xs8E=', '2014-03-12 03:32:57', 1, 'TinyCute', '', '', '', 1, 1, '2014-03-06 14:03:27'),
(16, 'pbkdf2_sha256$12000$YJbIjdWBDeU6$ojXoiz07FwEJJSGbL0GXCxTCUdH2yoCnGXdyWKvWBGQ=', '2014-03-12 03:38:52', 1, 'purchase-01', '', '', '', 1, 1, '2014-03-07 01:27:10'),
(17, 'pbkdf2_sha256$12000$H6C9bZCtnVLi$9hqrsGwvbJ4ub2i5j4kEBMtM7+ZTfvxCfycoApORDls=', '2014-03-12 03:39:23', 1, 'sales-01', '', '', '', 1, 1, '2014-03-07 01:27:31'),
(18, 'pbkdf2_sha256$12000$TkbHhV7CmMuV$N+/evhUK4Ga4Z7BzMgquc9fDDe+6hQrC48WTh/yp244=', '2014-03-12 03:39:54', 1, 'finance-01', '', '', '', 1, 1, '2014-03-07 01:27:58'),
(19, 'pbkdf2_sha256$12000$mYHuozV0wgsH$yI363fT0eEDSHsnHQZdmTqfBXkNjhEZa1WW2mqjO7S0=', '2014-03-12 03:29:41', 0, '刘威志', '', '', 'weizhiliu2009@gmail.com', 0, 1, '2014-03-07 17:17:33'),
(20, 'pbkdf2_sha256$12000$1i2CZpVdfShk$yoCTGhbLx+XPKZuhWHLqDbyME2ydlmLmZrTwKJ+NWik=', '2014-03-10 15:16:37', 0, '刘曜玮', '', '', 'liuyaowei@gmail.com', 0, 1, '2014-03-07 17:17:52'),
(21, 'pbkdf2_sha256$12000$VyRQ85XEDw7m$GcSNhKvMTHleIYOyV+PqpR5cL2GrIgJJPtl70b/ZXP0=', '2014-03-11 05:37:25', 0, '胡淑雅', '', '', 'kaduoshy@gmail.com', 0, 1, '2014-03-07 17:18:08'),
(22, 'pbkdf2_sha256$12000$kavv86lOwHpd$TevCKRcsB06diWLVx4ki3ZKp+FDc69hLubbxBjmXxs8=', '2014-03-10 15:17:58', 0, '陈新', '', '', 'chenxin@gmail.com', 0, 1, '2014-03-07 17:18:25');

-- --------------------------------------------------------

--
-- 表的结构 `auth_user_groups`
--

CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `auth_user_user_permissions`
--

CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=37 ;

--
-- 转存表中的数据 `auth_user_user_permissions`
--

INSERT INTO `auth_user_user_permissions` (`id`, `user_id`, `permission_id`) VALUES
(19, 1, 1),
(20, 1, 2),
(21, 1, 3),
(22, 1, 4),
(23, 1, 5),
(24, 1, 6),
(25, 1, 7),
(26, 1, 8),
(27, 1, 9),
(28, 1, 10),
(29, 1, 11),
(30, 1, 12),
(31, 1, 13),
(32, 1, 14),
(33, 1, 15),
(34, 1, 16),
(35, 1, 17),
(36, 1, 18),
(1, 14, 1),
(2, 14, 2),
(3, 14, 3),
(4, 14, 4),
(5, 14, 5),
(6, 14, 6),
(7, 14, 7),
(8, 14, 8),
(9, 14, 9),
(10, 14, 10),
(11, 14, 11),
(12, 14, 12),
(13, 14, 13),
(14, 14, 14),
(15, 14, 15),
(16, 14, 16),
(17, 14, 17),
(18, 14, 18);

-- --------------------------------------------------------

--
-- 表的结构 `book`
--

CREATE TABLE IF NOT EXISTS `book` (
  `b_isbn` varchar(100) COLLATE utf8_bin NOT NULL,
  `b_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `b_author` varchar(100) COLLATE utf8_bin NOT NULL,
  `b_publisher` varchar(100) COLLATE utf8_bin NOT NULL,
  `b_date` date NOT NULL,
  `b_price` float NOT NULL,
  PRIMARY KEY (`b_isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `book`
--

INSERT INTO `book` (`b_isbn`, `b_name`, `b_author`, `b_publisher`, `b_date`, `b_price`) VALUES
('9780061713569', 'On Writing Well', 'William Zinsser ', 'HarperCollins Publishers, New', '2008-01-01', 48),
('9780307887894', 'The Lean Startup', 'Eric Ries ', 'Crown Business', '2011-09-13', 156),
('9780387402727', 'All of Statistics', ' Larry Wasserman ', 'Springer', '2004-10-21', 594),
('9780387848570', 'The Elements of Statistical Learning', 'Trevor Hastie / Robert Tibshirani / Jerome Friedman ', 'Springer', '2008-12-01', 540),
('9780470168790', 'Cellular Automata', 'Joel L. Schiff ', 'Wiley-Interscience', '2008-01-06', 711),
('9780486402581', 'Combinatorial Optimization', 'Christos H. Papadimitriou / Kenneth Steiglitz ', 'Dover Publications', '1998-01-01', 131.7),
('9780521195331', 'Networks, Crowds, and Markets', 'Jon Kleinberg / David Easley ', 'Cambridge University Press', '2010-07-19', 300),
('9780521602624', 'Exploratory Social Network Analysis with Pajek', 'Wouter de Nooy / Andrej Mrvar / Vladimir Batagelj ', 'Cambridge University Press', '2005-01-10', 294),
('9780521833783', 'Convex Optimization', 'Stephen Boyd / Lieven Vandenberghe ', ' Cambridge University Press', '2004-03-08', 540),
('9780552997041', 'A Short History of Nearly Everything', 'Bill Bryson ', 'Black Swan', '2004-06-01', 60),
('9780671741907', 'Word Power Made Easy', 'Norman Lewis ', ' Pocket Books', '1991-02-15', 48),
('9780971015821', 'Case in Point', 'Marc P. Cosentino ', 'Burgee Press', '2005-09-05', 180),
('9781461471370', 'An Introduction to Statistical Learning', 'Gareth James / Daniela Witten / Trevor Hastie / Robert Tibshirani ', 'Springer', '2013-08-12', 480),
('9781579550080', 'A New Kind of Science', 'Stephen Wolfram ', 'Wolfram Media', '2002-05-01', 400),
('9781590597255', 'The Definitive Guide to Django', 'Adrian Holovaty / Jacob Kaplan-Moss ', 'Apress', '2007-12-06', 270),
('9787020065394', '无人生还', '阿加莎・克里斯蒂 ', '人民文学出版社', '2008-03-01', 19),
('9787100013239', '哥德尔、艾舍尔、巴赫', '侯世达 ', '商务印书馆', '1997-05-01', 69.9),
('9787100040945', '如何阅读一本书', '莫提默·J. 艾德勒 / 查尔斯·范多伦 ', '商务印书馆', '2004-01-01', 38),
('9787108017031', '森林唱游', '幾米 ', '生活·读书·新知三联书店', '2002-04-01', 25),
('9787108017444', '向左走·向右走', '幾米', '生活·读书·新知三联书店', '2002-08-01', 16),
('9787115287960', '30天自制操作系统', '川合秀实 ', '人民邮电出版社', '2012-08-01', 99),
('9787121220371', '1024·人与机器共同进化', '东西文库 / 李婷', '电子工业出版社', '2013-12-20', 55),
('9787214057846', '平面国', '艾勃特 ', '江苏人民出版社', '2009-06-01', 26),
('9787300144382', '“我们”比“我”更聪明', '巴里•李伯特 / 乔恩•斯佩克特 ', '中国人民大学出版社', '2011-11-01', 32),
('9787508629643', '众包2', '凡卡•雷马斯瓦米/弗朗西斯•古雅尔', '中信出版社', '2011-09-01', 42),
('9787508639789', '他们创造了美国', '哈罗德·埃文斯/盖尔·巴克兰/戴维·列 ', '中信出版社', '2013-07-15', 98),
('9787530467558', '囚徒健身', '保罗•威德 ', '北京科学技术出版社', '2003-10-01', 79),
('9787530739488', '爱德华的奇妙之旅', '凯特·迪卡米洛 / 马格拉姆·伊巴图林/绘 ', '新蕾出版社', '2007-01-01', 15),
('9787532134366', '先秦诸子百家争鸣', '易中天 ', '上海文艺出版社', '2009-01-01', 29),
('9787532733095', '旅行的艺术', '阿兰·德波顿 ', '上海译文出版社', '2004-04-01', 16.8),
('9787535537409', '数理统计学简史', '陈希孺 ', '湖南教育出版社', '2002-01-01', 17.3),
('9787536692930', '三体', '刘慈欣 ', '重庆出版社', '2008-01-01', 23),
('9787549535644', '平如美棠', '饶平如', '广西师范大学出版社', '2013-05-01', 39.8),
('9787560946689', '创新算法', '根里奇·斯拉维奇·阿奇舒勒 ', '华中科技大学出版社', '2008-10-01', 32.8),
('9787561324233', '蜡笔小新（全32册）', '臼井仪人 ', '陕西师范大学出版社', '2002-05-01', 144),
('9787801734143', '富兰克林自传', '富兰克林 ', '国际文化出版公司', '2005-01-01', 28.8),
('9787802444331', '星空', '幾米', '现代出版社', '2009-10-01', 48);

-- --------------------------------------------------------

--
-- 表的结构 `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `c_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_email` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_password` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_sex` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_address` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_expense` int(11) DEFAULT NULL,
  PRIMARY KEY (`c_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `customer`
--

INSERT INTO `customer` (`c_id`, `c_name`, `c_email`, `c_password`, `c_sex`, `c_address`, `c_expense`) VALUES
('1', '刘威志', 'weizhiliu2009@gmail.com', '123', '男', '江苏省南京市鼓楼区汉口路22号', 127681),
('2', '刘曜玮', 'liuyaowei@gmail.com', '123', '男', '台湾桃园', 33484),
('3', '胡淑雅', 'kaduoshy@gmail.com', '123', '女', '江苏省南京市鼓楼区汉口路22号', 6672292),
('4', '陈新', 'chenxin@gmail.com', '123', '女', '江苏省南京市鼓楼区汉口路22号', 169558);

-- --------------------------------------------------------

--
-- 表的结构 `customerorder`
--

CREATE TABLE IF NOT EXISTS `customerorder` (
  `co_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `c_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `b_isbn` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `o_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `po_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `co_date` date NOT NULL,
  `co_amount` int(11) NOT NULL,
  `b_price` float NOT NULL,
  `co_status` smallint(6) NOT NULL,
  PRIMARY KEY (`co_id`),
  KEY `FK_CustomerBookQuery` (`b_isbn`),
  KEY `FK_CustomerBuy` (`c_id`),
  KEY `FK_Sale` (`o_id`),
  KEY `FK_StockOut` (`po_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `customerorder`
--

INSERT INTO `customerorder` (`co_id`, `c_id`, `b_isbn`, `o_id`, `po_id`, `co_date`, `co_amount`, `b_price`, `co_status`) VALUES
('1', '1', '9787536692930', NULL, NULL, '2014-03-08', 4, 23, 1),
('10', '1', '9780552997041', NULL, NULL, '2014-03-08', 3, 60, 1),
('11', '3', '9787530739488', NULL, NULL, '2014-03-08', 1000, 15, 1),
('12', '3', '9787108017031', NULL, NULL, '2014-03-08', 10000, 25, 1),
('13', '3', '9787300144382', NULL, NULL, '2014-03-08', 200, 32, 1),
('14', '4', '9787100013239', NULL, NULL, '2014-03-08', 100, 69.9, 1),
('15', '4', '9787508629643', NULL, NULL, '2014-03-08', 47, 42, 1),
('16', '2', '9780521833783', NULL, NULL, '2014-03-08', 23, 540, 1),
('17', '2', '9780521833783', NULL, NULL, '2014-03-08', 17, 540, 1),
('18', '2', '9787214057846', NULL, NULL, '2014-03-08', 67, 26, 1),
('19', '3', '9787535537409', NULL, NULL, '2014-03-08', 1, 17.3, 1),
('2', '1', '9787100013239', NULL, NULL, '2014-03-08', 1, 69.9, 1),
('20', '3', '9787532134366', NULL, NULL, '2014-03-08', 23, 29, 1),
('21', '1', '9787020065394', NULL, NULL, '2014-03-08', 6, 19, 1),
('22', '2', '9787100013239', NULL, NULL, '2014-03-08', 4, 69.9, 1),
('23', '4', '9780061713569', NULL, NULL, '2014-03-08', 100, 48, 1),
('24', '1', '9787530739488', NULL, NULL, '2014-03-09', 53, 15, 1),
('25', '1', '9787532134366', NULL, NULL, '2014-03-09', 3, 29, 1),
('26', '1', '9787108017031', NULL, NULL, '2014-03-09', 20, 25, 1),
('27', '1', '9781461471370', NULL, NULL, '2014-03-09', 100, 480, 1),
('28', '1', '9780552997041', NULL, NULL, '2014-03-09', 10, 60, 1),
('29', '2', '9787508629643', NULL, NULL, '2014-03-09', 34, 42, 1),
('3', '1', '9781590597255', NULL, NULL, '2014-03-08', 5, 270, 1),
('30', '2', '9780552997041', NULL, NULL, '2014-03-09', 35, 60, 1),
('31', '2', '9787100013239', NULL, NULL, '2014-03-09', 30, 69.9, 1),
('32', '1', '9787100013239', NULL, NULL, '2014-03-09', 5, 69.9, 1),
('33', '4', '9781590597255', NULL, NULL, '2014-03-09', 5, 270, 1),
('34', '1', '9780387848570', NULL, NULL, '2014-03-09', 100, 540, 1),
('35', '2', '9780061713569', NULL, NULL, '2014-03-09', 35, 48, 1),
('36', '1', '9787108017031', NULL, NULL, '2014-03-09', 4, 25, 1),
('37', '1', '9787020065394', NULL, NULL, '2014-03-09', 100, 19, 1),
('38', '4', '9781461471370', NULL, NULL, '2014-03-09', 20, 480, 1),
('39', '1', '9787801734143', NULL, NULL, '2014-03-09', 5, 28.8, 1),
('4', '3', '9787300144382', NULL, NULL, '2014-03-08', 2, 32, 1),
('40', '1', '9780387848570', NULL, NULL, '2014-03-09', 10, 540, 1),
('41', '1', '9787530467558', NULL, NULL, '2014-03-09', 34, 79, 1),
('42', '1', '9787100040945', NULL, NULL, '2014-03-09', 50, 38, 1),
('43', '3', '9780671741907', NULL, NULL, '2014-03-09', 3, 48, 1),
('44', '4', '9787532733095', NULL, NULL, '2014-03-09', 42, 16.8, 1),
('45', '2', '9787801734143', NULL, NULL, '2014-03-09', 12, 28.8, 1),
('46', '1', '9787560946689', NULL, NULL, '2014-03-10', 3, 32.8, 1),
('47', '1', '9787121220371', NULL, NULL, '2014-03-10', 5, 55, 1),
('48', '2', '9787508639789', NULL, NULL, '2014-03-10', 1, 98, 1),
('49', '2', '9787115287960', NULL, NULL, '2014-03-10', 5, 99, 1),
('5', '2', '9780521833783', NULL, NULL, '2014-03-08', 3, 540, 1),
('50', '4', '9787561324233', NULL, NULL, '2014-03-10', 1000, 144, 1),
('51', '3', '9787108017444', NULL, NULL, '2014-03-10', 100000, 16, 1),
('52', '3', '9787802444331', NULL, NULL, '2014-03-10', 100000, 48, 1),
('53', '1', '9787549535644', NULL, NULL, '2014-03-11', 3, 39.8, 1),
('54', '1', '9780307887894', NULL, NULL, '2014-03-12', 5, 156, 2),
('55', '1', '9787300144382', NULL, NULL, '2014-03-12', 6, 32, 1),
('56', '1', '9780061713569', NULL, NULL, '2014-03-12', 30, 48, 1),
('57', '1', '9780521833783', NULL, NULL, '2014-03-12', 23, 540, 2),
('58', '1', '9787536692930', NULL, NULL, '2014-03-12', 5, 23, 1),
('59', '1', '9787536692930', NULL, NULL, '2014-03-12', 3, 23, 2),
('6', '4', '9787100013239', NULL, NULL, '2014-03-08', 2, 69.9, 1),
('60', '1', '9787108017031', NULL, NULL, '2014-03-12', 200, 25, 1),
('61', '1', '9787535537409', NULL, NULL, '2014-03-12', 20, 17.3, 0),
('7', '1', '9787214057846', NULL, NULL, '2014-03-08', 5, 26, 1),
('8', '1', '9787508629643', NULL, NULL, '2014-03-08', 3, 42, 1),
('9', '1', '9781461471370', NULL, NULL, '2014-03-08', 4, 480, 1);

-- --------------------------------------------------------

--
-- 表的结构 `django_admin_log`
--

CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext COLLATE utf8_bin,
  `object_repr` varchar(200) COLLATE utf8_bin NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=30 ;

--
-- 转存表中的数据 `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `user_id`, `content_type_id`, `object_id`, `object_repr`, `action_flag`, `change_message`) VALUES
(1, '2014-03-04 05:37:09', 1, 4, '2', 'test', 1, ''),
(2, '2014-03-04 05:39:12', 1, 4, '2', 'test', 2, '已修改 first_name 。'),
(3, '2014-03-04 05:39:13', 1, 4, '2', 'test', 2, '已修改 first_name 。'),
(4, '2014-03-04 05:43:13', 1, 7, '9780199760244', 'Book object', 1, ''),
(5, '2014-03-04 05:44:54', 1, 7, '9780801854149', 'Book object', 1, ''),
(6, '2014-03-04 05:46:55', 1, 7, '9780375709326', 'Book object', 1, ''),
(7, '2014-03-04 05:48:57', 1, 7, '9780387310732', 'Book object', 1, ''),
(8, '2014-03-04 05:50:21', 1, 7, '9787312018381', 'Book object', 1, ''),
(9, '2014-03-04 05:53:10', 1, 7, '9787542830326', 'Book object', 1, ''),
(10, '2014-03-04 05:55:42', 1, 7, '9787532739974', 'Book object', 1, ''),
(11, '2014-03-04 05:58:27', 1, 7, '9787535774446', 'Book object', 1, ''),
(12, '2014-03-04 06:00:06', 1, 7, '9787223011297', 'Book object', 1, ''),
(13, '2014-03-04 06:02:41', 1, 7, '9787208101401', 'Book object', 1, ''),
(14, '2014-03-04 16:37:15', 1, 7, '9780199760244', 'Book object', 2, '已修改 b_name 。'),
(15, '2014-03-06 13:54:10', 1, 4, '9', '采购部', 3, ''),
(16, '2014-03-06 14:03:27', 1, 4, '14', 'TinyCute', 1, ''),
(17, '2014-03-06 14:03:44', 1, 4, '14', 'TinyCute', 2, '已修改 is_staff，is_superuser 和 user_permissions 。'),
(18, '2014-03-06 14:03:58', 1, 4, '1', 'admin', 2, '已修改 user_permissions 。'),
(19, '2014-03-07 01:27:10', 1, 4, '16', 'purchase-01', 1, ''),
(20, '2014-03-07 01:27:19', 1, 4, '16', 'purchase-01', 2, '已修改 is_staff 和 is_superuser 。'),
(21, '2014-03-07 01:27:31', 1, 4, '17', 'sales-01', 1, ''),
(22, '2014-03-07 01:27:43', 1, 4, '17', 'sales-01', 2, '已修改 is_superuser 。'),
(23, '2014-03-07 01:27:58', 1, 4, '18', 'finance-01', 1, ''),
(24, '2014-03-07 01:28:13', 1, 4, '18', 'finance-01', 2, '已修改 is_superuser 。'),
(25, '2014-03-07 01:50:52', 1, 4, '18', 'finance-01', 2, '已修改 is_staff 。'),
(26, '2014-03-07 01:50:54', 1, 4, '18', 'finance-01', 2, '没有字段被修改。'),
(27, '2014-03-07 01:51:08', 1, 4, '17', 'sales-01', 2, '已修改 is_staff 。'),
(28, '2014-03-07 01:55:16', 1, 4, '1', 'admin', 2, '已修改 password 。'),
(29, '2014-03-07 01:55:31', 1, 4, '1', 'admin', 2, '已修改 password 。');

-- --------------------------------------------------------

--
-- 表的结构 `django_content_type`
--

CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_bin NOT NULL,
  `app_label` varchar(100) COLLATE utf8_bin NOT NULL,
  `model` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=16 ;

--
-- 转存表中的数据 `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `name`, `app_label`, `model`) VALUES
(1, 'log entry', 'admin', 'logentry'),
(2, 'permission', 'auth', 'permission'),
(3, 'group', 'auth', 'group'),
(4, 'user', 'auth', 'user'),
(5, 'content type', 'contenttypes', 'contenttype'),
(6, 'session', 'sessions', 'session'),
(7, 'book', 'mis', 'book'),
(8, 'customer', 'mis', 'customer'),
(9, 'supplier', 'mis', 'supplier'),
(10, 'customer order', 'mis', 'customerorder'),
(11, 'purchase order', 'mis', 'purchaseorder'),
(12, 'in list', 'mis', 'inlist'),
(13, 'out list', 'mis', 'outlist'),
(14, 'financial report', 'mis', 'financialreport'),
(15, 'stock list', 'mis', 'stocklist');

-- --------------------------------------------------------

--
-- 表的结构 `django_session`
--

CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) COLLATE utf8_bin NOT NULL,
  `session_data` longtext COLLATE utf8_bin NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('47andjdrzpmpo5ulxm6k32oojnwl44g7', 'NmU2OWM5N2MxNmI3MGU4NDA0OWRlMzdiYjAzYTNiMTdkNGVkYWIzNjp7fQ==', '2014-03-20 12:38:49'),
('5yjhbxjunbbt629qm38cl3j19689gkig', 'NmU2OWM5N2MxNmI3MGU4NDA0OWRlMzdiYjAzYTNiMTdkNGVkYWIzNjp7fQ==', '2014-03-20 11:47:40'),
('9eiziim36pg50gyalk39b8iyx1tfwjtt', 'NmU2OWM5N2MxNmI3MGU4NDA0OWRlMzdiYjAzYTNiMTdkNGVkYWIzNjp7fQ==', '2014-03-26 03:40:18'),
('jtavdm0pp1qzeirhgpblso5rqp8l348i', 'NmU2OWM5N2MxNmI3MGU4NDA0OWRlMzdiYjAzYTNiMTdkNGVkYWIzNjp7fQ==', '2014-03-20 11:44:45'),
('q95nbh0rjpvuxlfsi1bu5vi4aybhorf1', 'NmU2OWM5N2MxNmI3MGU4NDA0OWRlMzdiYjAzYTNiMTdkNGVkYWIzNjp7fQ==', '2014-03-25 05:42:09');

-- --------------------------------------------------------

--
-- 表的结构 `financialreport`
--

CREATE TABLE IF NOT EXISTS `financialreport` (
  `f_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `sl_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `f_date` date NOT NULL,
  `f_revenue` int(11) NOT NULL,
  `f_cost` int(11) NOT NULL,
  `f_profit` int(11) NOT NULL,
  PRIMARY KEY (`f_id`),
  KEY `FK_Analyze` (`sl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `financialreport`
--

INSERT INTO `financialreport` (`f_id`, `sl_id`, `f_date`, `f_revenue`, `f_cost`, `f_profit`) VALUES
('1', NULL, '2014-03-08', 309305, 185445, 123860),
('2', NULL, '2014-03-09', 117249, 96636, 20613),
('3', NULL, '2014-03-10', 6569422, 3823070, 2746352),
('4', NULL, '2014-03-11', 0, 48785, -48785);

-- --------------------------------------------------------

--
-- 表的结构 `inlist`
--

CREATE TABLE IF NOT EXISTS `inlist` (
  `i_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `f_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `sl_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `po_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `i_date` date NOT NULL,
  `s_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `co_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `b_isbn` varchar(100) COLLATE utf8_bin NOT NULL,
  `po_amount` int(11) NOT NULL,
  `po_price` int(11) NOT NULL,
  PRIMARY KEY (`i_id`),
  KEY `FK_Buy2` (`po_id`),
  KEY `FK_Cost` (`f_id`),
  KEY `FK_InStock` (`sl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `inlist`
--

INSERT INTO `inlist` (`i_id`, `f_id`, `sl_id`, `po_id`, `i_date`, `s_id`, `co_id`, `b_isbn`, `po_amount`, `po_price`) VALUES
('1', NULL, NULL, '1', '2014-03-08', '1', '1', '9787536692930', 4, 13),
('10', NULL, NULL, '10', '2014-03-08', '3', '10', '9780552997041', 3, 36),
('11', NULL, NULL, '11', '2014-03-08', '2', '11', '9787530739488', 1000, 9),
('12', NULL, NULL, '12', '2014-03-08', '2', '12', '9787108017031', 10000, 15),
('13', NULL, NULL, '13', '2014-03-08', '2', '13', '9787300144382', 200, 19),
('14', NULL, NULL, '14', '2014-03-08', '2', '14', '9787100013239', 100, 41),
('15', NULL, NULL, '15', '2014-03-08', '2', '15', '9787508629643', 47, 25),
('16', NULL, NULL, '16', '2014-03-08', '2', '16', '9780521833783', 23, 324),
('17', NULL, NULL, '17', '2014-03-08', '2', '17', '9780521833783', 17, 324),
('18', NULL, NULL, '18', '2014-03-08', '2', '18', '9787214057846', 67, 15),
('19', NULL, NULL, '19', '2014-03-09', '1', '19', '9787535537409', 1, 10),
('2', NULL, NULL, '2', '2014-03-08', '1', '2', '9787100013239', 1, 41),
('20', NULL, NULL, '20', '2014-03-09', '1', '20', '9787532134366', 23, 17),
('21', NULL, NULL, '21', '2014-03-09', '1', '21', '9787020065394', 6, 11),
('22', NULL, NULL, '22', '2014-03-09', '1', '22', '9787100013239', 4, 41),
('23', NULL, NULL, '23', '2014-03-09', '1', '23', '9780061713569', 100, 28),
('24', NULL, NULL, '24', '2014-03-09', '1', '24', '9787530739488', 53, 9),
('25', NULL, NULL, '25', '2014-03-09', '1', '25', '9787532134366', 3, 17),
('26', NULL, NULL, '26', '2014-03-09', '1', '26', '9787108017031', 20, 15),
('27', NULL, NULL, '27', '2014-03-09', '1', '27', '9781461471370', 100, 288),
('28', NULL, NULL, '28', '2014-03-09', '1', '28', '9780552997041', 10, 36),
('29', NULL, NULL, '29', '2014-03-09', '1', '29', '9787508629643', 34, 25),
('3', NULL, NULL, '3', '2014-03-08', '1', '3', '9781590597255', 5, 162),
('30', NULL, NULL, '30', '2014-03-09', '1', '30', '9780552997041', 35, 36),
('31', NULL, NULL, '31', '2014-03-09', '3', NULL, '9781590597255', 8, 162),
('32', NULL, NULL, '32', '2014-03-09', '3', NULL, '9787300144382', 45, 19),
('33', NULL, NULL, '33', '2014-03-09', '3', NULL, '9787508629643', 29, 25),
('34', NULL, NULL, '34', '2014-03-09', '3', NULL, '9787214057846', 27, 15),
('35', NULL, NULL, '35', '2014-03-09', '3', NULL, '9787530739488', 103, 9),
('36', NULL, NULL, '36', '2014-03-09', '3', NULL, '9787108017031', 317, 15),
('37', NULL, NULL, '37', '2014-03-09', '3', NULL, '9787532134366', 16, 17),
('38', NULL, NULL, '38', '2014-03-09', '3', NULL, '9787536692930', 6, 13),
('39', NULL, NULL, '39', '2014-03-09', '3', NULL, '9787020065394', 8, 11),
('4', NULL, NULL, '4', '2014-03-08', '1', '4', '9787300144382', 2, 19),
('40', NULL, NULL, '40', '2014-03-09', '3', NULL, '9787535537409', 4, 10),
('41', NULL, NULL, '41', '2014-03-09', '3', NULL, '9787100013239', 33, 41),
('42', NULL, NULL, '42', '2014-03-09', '3', NULL, '9781461471370', 32, 288),
('43', NULL, NULL, '43', '2014-03-09', '3', NULL, '9780521833783', 21, 324),
('44', NULL, NULL, '44', '2014-03-09', '3', NULL, '9780061713569', 32, 28),
('45', NULL, NULL, '45', '2014-03-09', '3', NULL, '9780552997041', 22, 36),
('46', NULL, NULL, '46', '2014-03-09', '2', '32', '9787100013239', 5, 41),
('47', NULL, NULL, '47', '2014-03-09', '1', '34', '9780387848570', 100, 324),
('48', NULL, NULL, '48', '2014-03-10', '6', '35', '9780061713569', 35, 28),
('49', NULL, NULL, '49', '2014-03-10', '6', '37', '9787020065394', 100, 11),
('5', NULL, NULL, '5', '2014-03-08', '1', '5', '9780521833783', 3, 324),
('50', NULL, NULL, '50', '2014-03-10', '6', '39', '9787801734143', 5, 17),
('51', NULL, NULL, '51', '2014-03-10', '6', '40', '9780387848570', 10, 324),
('52', NULL, NULL, '52', '2014-03-10', '6', '41', '9787530467558', 34, 47),
('53', NULL, NULL, '53', '2014-03-10', '6', '42', '9787100040945', 50, 22),
('54', NULL, NULL, '54', '2014-03-10', '6', '43', '9780671741907', 3, 28),
('55', NULL, NULL, '55', '2014-03-10', '6', '44', '9787532733095', 42, 10),
('56', NULL, NULL, '56', '2014-03-10', '6', '45', '9787801734143', 12, 17),
('57', NULL, NULL, '57', '2014-03-10', '3', NULL, '9781590597255', 8, 162),
('58', NULL, NULL, '58', '2014-03-10', '3', NULL, '9787508629643', 18, 25),
('59', NULL, NULL, '59', '2014-03-10', '3', NULL, '9787532134366', 16, 17),
('6', NULL, NULL, '6', '2014-03-08', '1', '6', '9787100013239', 2, 41),
('60', NULL, NULL, '60', '2014-03-10', '3', NULL, '9787801734143', 13, 17),
('61', NULL, NULL, '61', '2014-03-10', '3', NULL, '9787532733095', 20, 10),
('62', NULL, NULL, '62', '2014-03-10', '3', NULL, '9787530467558', 18, 47),
('63', NULL, NULL, '63', '2014-03-10', '3', NULL, '9787100040945', 22, 22),
('64', NULL, NULL, '64', '2014-03-10', '3', NULL, '9787020065394', 33, 11),
('65', NULL, NULL, '65', '2014-03-10', '3', NULL, '9787100013239', 20, 41),
('66', NULL, NULL, '66', '2014-03-10', '3', NULL, '9781461471370', 35, 288),
('67', NULL, NULL, '67', '2014-03-10', '3', NULL, '9780387848570', 33, 324),
('68', NULL, NULL, '68', '2014-03-10', '3', NULL, '9780671741907', 6, 28),
('69', NULL, NULL, '69', '2014-03-10', '3', NULL, '9780061713569', 37, 28),
('7', NULL, NULL, '7', '2014-03-08', '2', '7', '9787214057846', 5, 15),
('70', NULL, NULL, '70', '2014-03-10', '3', NULL, '9780552997041', 21, 36),
('71', NULL, NULL, '71', '2014-03-10', '1', '46', '9787560946689', 3, 19),
('72', NULL, NULL, '72', '2014-03-10', '1', '47', '9787121220371', 5, 33),
('73', NULL, NULL, '73', '2014-03-10', '1', '48', '9787508639789', 1, 58),
('74', NULL, NULL, '74', '2014-03-10', '1', '49', '9787115287960', 5, 59),
('75', NULL, NULL, '75', '2014-03-10', '1', '50', '9787561324233', 1000, 86),
('76', NULL, NULL, '76', '2014-03-10', '1', '51', '9787108017444', 100000, 9),
('77', NULL, NULL, '77', '2014-03-10', '1', '52', '9787802444331', 100000, 28),
('78', NULL, NULL, '78', '2014-03-11', '1', NULL, '9787801734143', 13, 17),
('79', NULL, NULL, '79', '2014-03-11', '1', NULL, '9787532733095', 20, 10),
('8', NULL, NULL, '8', '2014-03-08', '2', '8', '9787508629643', 3, 25),
('80', NULL, NULL, '80', '2014-03-11', '1', NULL, '9787530467558', 18, 47),
('81', NULL, NULL, '81', '2014-03-11', '1', NULL, '9787100040945', 22, 22),
('82', NULL, NULL, '82', '2014-03-11', '1', NULL, '9787020065394', 32, 11),
('83', NULL, NULL, '83', '2014-03-11', '1', NULL, '9787560946689', 6, 19),
('84', NULL, NULL, '84', '2014-03-11', '1', NULL, '9787508639789', 4, 58),
('85', NULL, NULL, '85', '2014-03-11', '1', NULL, '9787121220371', 8, 33),
('86', NULL, NULL, '86', '2014-03-11', '1', NULL, '9787115287960', 8, 59),
('87', NULL, NULL, '87', '2014-03-11', '1', NULL, '9787561324233', 100, 86),
('88', NULL, NULL, '88', '2014-03-11', '1', NULL, '9787802444331', 1000, 28),
('89', NULL, NULL, '89', '2014-03-11', '1', NULL, '9787108017444', 1000, 9),
('9', NULL, NULL, '9', '2014-03-08', '3', '9', '9781461471370', 4, 288),
('90', NULL, NULL, '90', '2014-03-12', '3', '53', '9787549535644', 3, 23);

-- --------------------------------------------------------

--
-- 表的结构 `outlist`
--

CREATE TABLE IF NOT EXISTS `outlist` (
  `o_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `f_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `co_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `sl_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `o_date` date NOT NULL,
  `c_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `b_isbn` varchar(100) COLLATE utf8_bin NOT NULL,
  `co_amount` int(11) NOT NULL,
  `b_price` int(11) NOT NULL,
  PRIMARY KEY (`o_id`),
  KEY `FK_OutStock` (`sl_id`),
  KEY `FK_Revenue` (`f_id`),
  KEY `FK_Sale2` (`co_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `outlist`
--

INSERT INTO `outlist` (`o_id`, `f_id`, `co_id`, `sl_id`, `o_date`, `c_id`, `b_isbn`, `co_amount`, `b_price`) VALUES
('1', NULL, '1', NULL, '2014-03-08', '1', '9787536692930', 4, 23),
('10', NULL, '10', NULL, '2014-03-08', '1', '9780552997041', 3, 60),
('11', NULL, '11', NULL, '2014-03-08', '3', '9787530739488', 1000, 15),
('12', NULL, '12', NULL, '2014-03-08', '3', '9787108017031', 10000, 25),
('13', NULL, '13', NULL, '2014-03-08', '3', '9787300144382', 200, 32),
('14', NULL, '14', NULL, '2014-03-08', '4', '9787100013239', 100, 69),
('15', NULL, '15', NULL, '2014-03-08', '4', '9787508629643', 47, 42),
('16', NULL, '16', NULL, '2014-03-08', '2', '9780521833783', 23, 540),
('17', NULL, '17', NULL, '2014-03-08', '2', '9780521833783', 17, 540),
('18', NULL, '18', NULL, '2014-03-08', '2', '9787214057846', 67, 26),
('19', NULL, '19', NULL, '2014-03-09', '3', '9787535537409', 1, 17),
('2', NULL, '2', NULL, '2014-03-08', '1', '9787100013239', 1, 69),
('20', NULL, '20', NULL, '2014-03-09', '3', '9787532134366', 23, 29),
('21', NULL, '21', NULL, '2014-03-09', '1', '9787020065394', 6, 19),
('22', NULL, '22', NULL, '2014-03-09', '2', '9787100013239', 4, 69),
('23', NULL, '23', NULL, '2014-03-09', '4', '9780061713569', 100, 48),
('24', NULL, '24', NULL, '2014-03-09', '1', '9787530739488', 53, 15),
('25', NULL, '25', NULL, '2014-03-09', '1', '9787532134366', 3, 29),
('26', NULL, '26', NULL, '2014-03-09', '1', '9787108017031', 20, 25),
('27', NULL, '27', NULL, '2014-03-09', '1', '9781461471370', 100, 480),
('28', NULL, '28', NULL, '2014-03-09', '1', '9780552997041', 10, 60),
('29', NULL, '29', NULL, '2014-03-09', '2', '9787508629643', 34, 42),
('3', NULL, '3', NULL, '2014-03-08', '1', '9781590597255', 5, 270),
('30', NULL, '30', NULL, '2014-03-09', '2', '9780552997041', 35, 60),
('31', NULL, '31', NULL, '2014-03-09', '2', '9787100013239', 30, 69),
('32', NULL, '32', NULL, '2014-03-09', '1', '9787100013239', 5, 69),
('33', NULL, '33', NULL, '2014-03-09', '4', '9781590597255', 5, 270),
('34', NULL, '34', NULL, '2014-03-09', '1', '9780387848570', 100, 540),
('35', NULL, '36', NULL, '2014-03-09', '1', '9787108017031', 4, 25),
('36', NULL, '38', NULL, '2014-03-10', '4', '9781461471370', 20, 480),
('37', NULL, '35', NULL, '2014-03-10', '2', '9780061713569', 35, 48),
('38', NULL, '37', NULL, '2014-03-10', '1', '9787020065394', 100, 19),
('39', NULL, '39', NULL, '2014-03-10', '1', '9787801734143', 5, 28),
('4', NULL, '4', NULL, '2014-03-08', '3', '9787300144382', 2, 32),
('40', NULL, '40', NULL, '2014-03-10', '1', '9780387848570', 10, 540),
('41', NULL, '41', NULL, '2014-03-10', '1', '9787530467558', 34, 79),
('42', NULL, '42', NULL, '2014-03-10', '1', '9787100040945', 50, 38),
('43', NULL, '43', NULL, '2014-03-10', '3', '9780671741907', 3, 48),
('44', NULL, '44', NULL, '2014-03-10', '4', '9787532733095', 42, 16),
('45', NULL, '45', NULL, '2014-03-10', '2', '9787801734143', 12, 28),
('46', NULL, '46', NULL, '2014-03-10', '1', '9787560946689', 3, 32),
('47', NULL, '47', NULL, '2014-03-10', '1', '9787121220371', 5, 55),
('48', NULL, '48', NULL, '2014-03-10', '2', '9787508639789', 1, 98),
('49', NULL, '49', NULL, '2014-03-10', '2', '9787115287960', 5, 99),
('5', NULL, '5', NULL, '2014-03-08', '2', '9780521833783', 3, 540),
('50', NULL, '50', NULL, '2014-03-10', '4', '9787561324233', 1000, 144),
('51', NULL, '51', NULL, '2014-03-10', '3', '9787108017444', 100000, 16),
('52', NULL, '52', NULL, '2014-03-10', '3', '9787802444331', 100000, 48),
('53', NULL, '53', NULL, '2014-03-12', '1', '9787549535644', 3, 39),
('54', NULL, '55', NULL, '2014-03-12', '1', '9787300144382', 6, 32),
('55', NULL, '56', NULL, '2014-03-12', '1', '9780061713569', 30, 48),
('56', NULL, '58', NULL, '2014-03-12', '1', '9787536692930', 5, 23),
('57', NULL, '60', NULL, '2014-03-12', '1', '9787108017031', 200, 25),
('6', NULL, '6', NULL, '2014-03-08', '4', '9787100013239', 2, 69),
('7', NULL, '7', NULL, '2014-03-08', '1', '9787214057846', 5, 26),
('8', NULL, '8', NULL, '2014-03-08', '1', '9787508629643', 3, 42),
('9', NULL, '9', NULL, '2014-03-08', '1', '9781461471370', 4, 480);

-- --------------------------------------------------------

--
-- 表的结构 `purchaseorder`
--

CREATE TABLE IF NOT EXISTS `purchaseorder` (
  `po_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `sl_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `s_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `b_isbn` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `i_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `co_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `po_date` date NOT NULL,
  `po_amount` int(11) NOT NULL,
  `po_price` float NOT NULL,
  `po_status` smallint(6) NOT NULL,
  PRIMARY KEY (`po_id`),
  KEY `FK_Buy` (`i_id`),
  KEY `FK_PurchaseBookQuery` (`b_isbn`),
  KEY `FK_PurchaseQuery` (`sl_id`),
  KEY `FK_Selection` (`s_id`),
  KEY `FK_StockOut2` (`co_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `purchaseorder`
--

INSERT INTO `purchaseorder` (`po_id`, `sl_id`, `s_id`, `b_isbn`, `i_id`, `co_id`, `po_date`, `po_amount`, `po_price`, `po_status`) VALUES
('1', NULL, '3', '9787536692930', NULL, '1', '2014-03-08', 4, 13.8, 1),
('10', NULL, '3', '9780552997041', NULL, '10', '2014-03-08', 3, 36, 1),
('11', NULL, '3', '9787530739488', NULL, '11', '2014-03-08', 1000, 9, 1),
('12', NULL, '3', '9787108017031', NULL, '12', '2014-03-08', 10000, 15, 1),
('13', NULL, '3', '9787300144382', NULL, '13', '2014-03-08', 200, 19.2, 1),
('14', NULL, '3', '9787100013239', NULL, '14', '2014-03-08', 100, 41.94, 1),
('15', NULL, '3', '9787508629643', NULL, '15', '2014-03-08', 47, 25.2, 1),
('16', NULL, '3', '9780521833783', NULL, '16', '2014-03-08', 23, 324, 1),
('17', NULL, '3', '9780521833783', NULL, '17', '2014-03-08', 17, 324, 1),
('18', NULL, '3', '9787214057846', NULL, '18', '2014-03-08', 67, 15.6, 1),
('19', NULL, '3', '9787535537409', NULL, '19', '2014-03-09', 1, 10.38, 1),
('2', NULL, '3', '9787100013239', NULL, '2', '2014-03-08', 1, 41.94, 1),
('20', NULL, '3', '9787532134366', NULL, '20', '2014-03-09', 23, 17.4, 1),
('21', NULL, '3', '9787020065394', NULL, '21', '2014-03-09', 6, 11.4, 1),
('22', NULL, '3', '9787100013239', NULL, '22', '2014-03-09', 4, 41.94, 1),
('23', NULL, '3', '9780061713569', NULL, '23', '2014-03-09', 100, 28.8, 1),
('24', NULL, '3', '9787530739488', NULL, '24', '2014-03-09', 53, 9, 1),
('25', NULL, '3', '9787532134366', NULL, '25', '2014-03-09', 3, 17.4, 1),
('26', NULL, '3', '9787108017031', NULL, '26', '2014-03-09', 20, 15, 1),
('27', NULL, '3', '9781461471370', NULL, '27', '2014-03-09', 100, 288, 1),
('28', NULL, '3', '9780552997041', NULL, '28', '2014-03-09', 10, 36, 1),
('29', NULL, '3', '9787508629643', NULL, '29', '2014-03-09', 34, 25.2, 1),
('3', NULL, '3', '9781590597255', NULL, '3', '2014-03-08', 5, 162, 1),
('30', NULL, '3', '9780552997041', NULL, '30', '2014-03-09', 35, 36, 1),
('31', NULL, '3', '9781590597255', NULL, NULL, '2014-03-09', 8, 162, 1),
('32', NULL, '3', '9787300144382', NULL, NULL, '2014-03-09', 45, 19.2, 1),
('33', NULL, '3', '9787508629643', NULL, NULL, '2014-03-09', 29, 25.2, 1),
('34', NULL, '3', '9787214057846', NULL, NULL, '2014-03-09', 27, 15.6, 1),
('35', NULL, '3', '9787530739488', NULL, NULL, '2014-03-09', 103, 9, 1),
('36', NULL, '3', '9787108017031', NULL, NULL, '2014-03-09', 317, 15, 1),
('37', NULL, '3', '9787532134366', NULL, NULL, '2014-03-09', 16, 17.4, 1),
('38', NULL, '3', '9787536692930', NULL, NULL, '2014-03-09', 6, 13.8, 1),
('39', NULL, '3', '9787020065394', NULL, NULL, '2014-03-09', 8, 11.4, 1),
('4', NULL, '3', '9787300144382', NULL, '4', '2014-03-08', 2, 19.2, 1),
('40', NULL, '3', '9787535537409', NULL, NULL, '2014-03-09', 4, 10.38, 1),
('41', NULL, '3', '9787100013239', NULL, NULL, '2014-03-09', 33, 41.94, 1),
('42', NULL, '3', '9781461471370', NULL, NULL, '2014-03-09', 32, 288, 1),
('43', NULL, '3', '9780521833783', NULL, NULL, '2014-03-09', 21, 324, 1),
('44', NULL, '3', '9780061713569', NULL, NULL, '2014-03-09', 32, 28.8, 1),
('45', NULL, '3', '9780552997041', NULL, NULL, '2014-03-09', 22, 36, 1),
('46', NULL, '3', '9787100013239', NULL, '32', '2014-03-09', 5, 41.94, 1),
('47', NULL, '3', '9780387848570', NULL, '34', '2014-03-09', 100, 324, 1),
('48', NULL, '3', '9780061713569', NULL, '35', '2014-03-09', 35, 28.8, 1),
('49', NULL, '3', '9787020065394', NULL, '37', '2014-03-09', 100, 11.4, 1),
('5', NULL, '3', '9780521833783', NULL, '5', '2014-03-08', 3, 324, 1),
('50', NULL, '3', '9787801734143', NULL, '39', '2014-03-10', 5, 17.28, 1),
('51', NULL, '3', '9780387848570', NULL, '40', '2014-03-10', 10, 324, 1),
('52', NULL, '3', '9787530467558', NULL, '41', '2014-03-10', 34, 47.4, 1),
('53', NULL, '3', '9787100040945', NULL, '42', '2014-03-10', 50, 22.8, 1),
('54', NULL, '3', '9780671741907', NULL, '43', '2014-03-10', 3, 28.8, 1),
('55', NULL, '3', '9787532733095', NULL, '44', '2014-03-10', 42, 10.08, 1),
('56', NULL, '3', '9787801734143', NULL, '45', '2014-03-10', 12, 17.28, 1),
('57', NULL, '3', '9781590597255', NULL, NULL, '2014-03-10', 8, 162, 1),
('58', NULL, '3', '9787508629643', NULL, NULL, '2014-03-10', 18, 25.2, 1),
('59', NULL, '3', '9787532134366', NULL, NULL, '2014-03-10', 16, 17.4, 1),
('6', NULL, '3', '9787100013239', NULL, '6', '2014-03-08', 2, 41.94, 1),
('60', NULL, '3', '9787801734143', NULL, NULL, '2014-03-10', 13, 17.28, 1),
('61', NULL, '3', '9787532733095', NULL, NULL, '2014-03-10', 20, 10.08, 1),
('62', NULL, '3', '9787530467558', NULL, NULL, '2014-03-10', 18, 47.4, 1),
('63', NULL, '3', '9787100040945', NULL, NULL, '2014-03-10', 22, 22.8, 1),
('64', NULL, '3', '9787020065394', NULL, NULL, '2014-03-10', 33, 11.4, 1),
('65', NULL, '3', '9787100013239', NULL, NULL, '2014-03-10', 20, 41.94, 1),
('66', NULL, '3', '9781461471370', NULL, NULL, '2014-03-10', 35, 288, 1),
('67', NULL, '3', '9780387848570', NULL, NULL, '2014-03-10', 33, 324, 1),
('68', NULL, '3', '9780671741907', NULL, NULL, '2014-03-10', 6, 28.8, 1),
('69', NULL, '3', '9780061713569', NULL, NULL, '2014-03-10', 37, 28.8, 1),
('7', NULL, '3', '9787214057846', NULL, '7', '2014-03-08', 5, 15.6, 1),
('70', NULL, '3', '9780552997041', NULL, NULL, '2014-03-10', 21, 36, 1),
('71', NULL, '3', '9787560946689', NULL, '46', '2014-03-10', 3, 19.68, 1),
('72', NULL, '3', '9787121220371', NULL, '47', '2014-03-10', 5, 33, 1),
('73', NULL, '3', '9787508639789', NULL, '48', '2014-03-10', 1, 58.8, 1),
('74', NULL, '3', '9787115287960', NULL, '49', '2014-03-10', 5, 59.4, 1),
('75', NULL, '3', '9787561324233', NULL, '50', '2014-03-10', 1000, 86.4, 1),
('76', NULL, '3', '9787108017444', NULL, '51', '2014-03-10', 100000, 9.6, 1),
('77', NULL, '3', '9787802444331', NULL, '52', '2014-03-10', 100000, 28.8, 1),
('78', NULL, '3', '9787801734143', NULL, NULL, '2014-03-11', 13, 17.28, 1),
('79', NULL, '3', '9787532733095', NULL, NULL, '2014-03-11', 20, 10.08, 1),
('8', NULL, '3', '9787508629643', NULL, '8', '2014-03-08', 3, 25.2, 1),
('80', NULL, '3', '9787530467558', NULL, NULL, '2014-03-11', 18, 47.4, 1),
('81', NULL, '3', '9787100040945', NULL, NULL, '2014-03-11', 22, 22.8, 1),
('82', NULL, '3', '9787020065394', NULL, NULL, '2014-03-11', 32, 11.4, 1),
('83', NULL, '3', '9787560946689', NULL, NULL, '2014-03-11', 6, 19.68, 1),
('84', NULL, '3', '9787508639789', NULL, NULL, '2014-03-11', 4, 58.8, 1),
('85', NULL, '3', '9787121220371', NULL, NULL, '2014-03-11', 8, 33, 1),
('86', NULL, '3', '9787115287960', NULL, NULL, '2014-03-11', 8, 59.4, 1),
('87', NULL, '3', '9787561324233', NULL, NULL, '2014-03-11', 100, 86.4, 1),
('88', NULL, '3', '9787802444331', NULL, NULL, '2014-03-11', 1000, 28.8, 1),
('89', NULL, '3', '9787108017444', NULL, NULL, '2014-03-11', 1000, 9.6, 1),
('9', NULL, '3', '9781461471370', NULL, '9', '2014-03-08', 4, 288, 1),
('90', NULL, '3', '9787549535644', NULL, '53', '2014-03-12', 3, 23.88, 1),
('91', NULL, NULL, '9780307887894', NULL, '54', '2014-03-12', 5, 93.6, 0),
('92', NULL, NULL, '9780521833783', NULL, '57', '2014-03-12', 23, 324, 0),
('93', NULL, NULL, '9787536692930', NULL, '59', '2014-03-12', 3, 13.8, 0);

-- --------------------------------------------------------

--
-- 表的结构 `stocklist`
--

CREATE TABLE IF NOT EXISTS `stocklist` (
  `sl_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `po_id` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `b_isbn` varchar(100) COLLATE utf8_bin NOT NULL,
  `sl_in_all` int(11) NOT NULL,
  `sl_out_all` int(11) NOT NULL,
  `sl_stock` int(11) NOT NULL,
  PRIMARY KEY (`sl_id`),
  KEY `FK_PurchaseQuery2` (`po_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `stocklist`
--

INSERT INTO `stocklist` (`sl_id`, `po_id`, `b_isbn`, `sl_in_all`, `sl_out_all`, `sl_stock`) VALUES
('1', NULL, '9781590597255', 21, 10, 11),
('10', NULL, '9787300144382', 247, 208, 39),
('11', NULL, '9787508629643', 131, 84, 47),
('12', NULL, '9787214057846', 99, 72, 27),
('13', NULL, '9787530739488', 1156, 1053, 103),
('14', NULL, '9787108017031', 10337, 10224, 113),
('15', NULL, '9787532134366', 58, 26, 32),
('16', NULL, '9787801734143', 43, 17, 26),
('17', NULL, '9787532733095', 82, 42, 40),
('18', NULL, '9787530467558', 70, 34, 36),
('19', NULL, '9787100040945', 94, 50, 44),
('2', NULL, '9787536692930', 10, 9, 1),
('20', NULL, '9787020065394', 179, 106, 73),
('21', NULL, '9787535537409', 5, 1, 4),
('22', NULL, '9780307887894', 0, 0, 0),
('23', NULL, '9787560946689', 9, 3, 6),
('24', NULL, '9787508639789', 5, 1, 4),
('25', NULL, '9787121220371', 13, 5, 8),
('26', NULL, '9787115287960', 13, 5, 8),
('27', NULL, '9780470168790', 0, 0, 0),
('28', NULL, '9781579550080', 0, 0, 0),
('29', NULL, '9780387402727', 0, 0, 0),
('3', NULL, '9787100013239', 165, 142, 23),
('30', NULL, '9780971015821', 0, 0, 0),
('31', NULL, '9780486402581', 0, 0, 0),
('32', NULL, '9780521602624', 0, 0, 0),
('33', NULL, '9780521195331', 0, 0, 0),
('34', NULL, '9787561324233', 1100, 1000, 100),
('35', NULL, '9787802444331', 101000, 100000, 1000),
('36', NULL, '9787108017444', 101000, 100000, 1000),
('37', NULL, '9787549535644', 3, 3, 0),
('4', NULL, '9781461471370', 171, 124, 47),
('5', NULL, '9780521833783', 64, 43, 21),
('6', NULL, '9780387848570', 143, 110, 33),
('7', NULL, '9780671741907', 9, 3, 6),
('8', NULL, '9780061713569', 204, 165, 39),
('9', NULL, '9780552997041', 91, 48, 43);

-- --------------------------------------------------------

--
-- 表的结构 `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `s_id` varchar(100) COLLATE utf8_bin NOT NULL,
  `s_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `s_score` int(11) NOT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- 转存表中的数据 `supplier`
--

INSERT INTO `supplier` (`s_id`, `s_name`, `s_score`) VALUES
('1', '陈炜', 9),
('2', '陈文郁', 9),
('3', 'Google', 10),
('4', '小萝莉', 2),
('5', 'Microsoft', 5),
('6', 'Nanjing University Press', 3),
('7', 'Apple', 6),
('8', '戴嘉俊', 10);

--
-- 限制导出的表
--

--
-- 限制表 `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`);

--
-- 限制表 `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- 限制表 `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- 限制表 `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- 限制表 `customerorder`
--
ALTER TABLE `customerorder`
  ADD CONSTRAINT `FK_CustomerBookQuery` FOREIGN KEY (`b_isbn`) REFERENCES `book` (`b_isbn`),
  ADD CONSTRAINT `FK_CustomerBuy` FOREIGN KEY (`c_id`) REFERENCES `customer` (`c_id`),
  ADD CONSTRAINT `FK_Sale` FOREIGN KEY (`o_id`) REFERENCES `outlist` (`o_id`),
  ADD CONSTRAINT `FK_StockOut` FOREIGN KEY (`po_id`) REFERENCES `purchaseorder` (`po_id`);

--
-- 限制表 `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- 限制表 `financialreport`
--
ALTER TABLE `financialreport`
  ADD CONSTRAINT `FK_Analyze` FOREIGN KEY (`sl_id`) REFERENCES `stocklist` (`sl_id`);

--
-- 限制表 `inlist`
--
ALTER TABLE `inlist`
  ADD CONSTRAINT `FK_Buy2` FOREIGN KEY (`po_id`) REFERENCES `purchaseorder` (`po_id`),
  ADD CONSTRAINT `FK_Cost` FOREIGN KEY (`f_id`) REFERENCES `financialreport` (`f_id`),
  ADD CONSTRAINT `FK_InStock` FOREIGN KEY (`sl_id`) REFERENCES `stocklist` (`sl_id`);

--
-- 限制表 `outlist`
--
ALTER TABLE `outlist`
  ADD CONSTRAINT `FK_OutStock` FOREIGN KEY (`sl_id`) REFERENCES `stocklist` (`sl_id`),
  ADD CONSTRAINT `FK_Revenue` FOREIGN KEY (`f_id`) REFERENCES `financialreport` (`f_id`),
  ADD CONSTRAINT `FK_Sale2` FOREIGN KEY (`co_id`) REFERENCES `customerorder` (`co_id`);

--
-- 限制表 `purchaseorder`
--
ALTER TABLE `purchaseorder`
  ADD CONSTRAINT `FK_Buy` FOREIGN KEY (`i_id`) REFERENCES `inlist` (`i_id`),
  ADD CONSTRAINT `FK_PurchaseBookQuery` FOREIGN KEY (`b_isbn`) REFERENCES `book` (`b_isbn`),
  ADD CONSTRAINT `FK_PurchaseQuery` FOREIGN KEY (`sl_id`) REFERENCES `stocklist` (`sl_id`),
  ADD CONSTRAINT `FK_Selection` FOREIGN KEY (`s_id`) REFERENCES `supplier` (`s_id`),
  ADD CONSTRAINT `FK_StockOut2` FOREIGN KEY (`co_id`) REFERENCES `customerorder` (`co_id`);

--
-- 限制表 `stocklist`
--
ALTER TABLE `stocklist`
  ADD CONSTRAINT `FK_PurchaseQuery2` FOREIGN KEY (`po_id`) REFERENCES `purchaseorder` (`po_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
