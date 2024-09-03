-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 03, 2024 at 07:10 PM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add product', 7, 'add_product'),
(26, 'Can change product', 7, 'change_product'),
(27, 'Can delete product', 7, 'delete_product'),
(28, 'Can view product', 7, 'view_product'),
(29, 'Can add user interaction', 8, 'add_userinteraction'),
(30, 'Can change user interaction', 8, 'change_userinteraction'),
(31, 'Can delete user interaction', 8, 'delete_userinteraction'),
(32, 'Can view user interaction', 8, 'view_userinteraction'),
(33, 'Can add user profile', 9, 'add_userprofile'),
(34, 'Can change user profile', 9, 'change_userprofile'),
(35, 'Can delete user profile', 9, 'delete_userprofile'),
(36, 'Can view user profile', 9, 'view_userprofile'),
(37, 'Can add favorite', 10, 'add_favorite'),
(38, 'Can change favorite', 10, 'change_favorite'),
(39, 'Can delete favorite', 10, 'delete_favorite'),
(40, 'Can view favorite', 10, 'view_favorite');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$lzDJSWPmZcd36OVMoRyEzW$bMQZ/ttLs54o1JegzAz3Rr87qGwViOLgJSSVa5va1MI=', '2024-09-01 11:25:53.498320', 0, 'medou', '', '', 'medou.med.bouk@gmail.com', 0, 1, '2024-09-01 11:25:53.244871'),
(2, 'pbkdf2_sha256$870000$X5pRjeapEwwq6x4YZwUDaj$FYAcu+In6lJpO80wWyCUpprvBLFSExg6d8VISM6XCtw=', '2024-09-01 16:13:40.343047', 0, 'vlan', '', '', '23083@esp.mr', 0, 1, '2024-09-01 16:13:39.851133'),
(3, 'pbkdf2_sha256$870000$qWpnnPXIf3nnLqxSSHqwmw$LstwO18SEf8JZ5HoIubN8QhI6P0fxS9Hxj8nOGQ+lpU=', '2024-09-01 18:48:26.896694', 0, 'admin', '', '', '23083@esp.mr', 0, 1, '2024-09-01 18:22:43.575551'),
(4, 'pbkdf2_sha256$870000$GtNpq5cPWnaqybkDhFsgdk$ikBBUIvI0OBEOntXtKMKhxB7VHdOK4XhjZT4+QtXpBs=', '2024-09-03 18:51:36.520418', 0, 'Mohamedou', '', '', 'bouk@esp.mr', 0, 1, '2024-09-02 07:39:16.526072'),
(5, 'pbkdf2_sha256$870000$Y4x3HtluDo2tkL8VmwKZLr$vI5vXRWG0mkJKPNsz1UGUu1swjDKFH8I4V/iSCci3lE=', '2024-09-02 18:04:15.328591', 0, 'ahmed', '', '', 'medou@esp.com', 0, 1, '2024-09-02 18:04:14.586254');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'recommendations', 'product'),
(8, 'recommendations', 'userinteraction'),
(9, 'recommendations', 'userprofile'),
(10, 'recommendations', 'favorite');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-09-01 11:21:31.924684'),
(2, 'auth', '0001_initial', '2024-09-01 11:21:32.278014'),
(3, 'admin', '0001_initial', '2024-09-01 11:21:32.428112'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-09-01 11:21:32.433113'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-09-01 11:21:32.438199'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-09-01 11:21:32.497990'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-09-01 11:21:32.533641'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-09-01 11:21:32.566282'),
(9, 'auth', '0004_alter_user_username_opts', '2024-09-01 11:21:32.574554'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-09-01 11:21:32.607321'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-09-01 11:21:32.608320'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-09-01 11:21:32.616317'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-09-01 11:21:32.651808'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-09-01 11:21:32.681542'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-09-01 11:21:32.710506'),
(16, 'auth', '0011_update_proxy_permissions', '2024-09-01 11:21:32.719020'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-09-01 11:21:32.749543'),
(18, 'recommendations', '0001_initial', '2024-09-01 11:21:32.854703'),
(19, 'recommendations', '0002_remove_product_category_alter_product_name_and_more', '2024-09-01 11:21:33.001329'),
(20, 'sessions', '0001_initial', '2024-09-01 11:21:33.032653'),
(21, 'recommendations', '0003_userprofile', '2024-09-01 18:09:33.480666'),
(22, 'recommendations', '0004_favorite_delete_userprofile', '2024-09-01 18:43:31.335117'),
(23, 'recommendations', '0005_userinteraction_interaction_type_delete_favorite', '2024-09-02 07:32:44.016230'),
(24, 'recommendations', '0006_alter_userinteraction_interaction_type', '2024-09-02 07:53:32.834758');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('l9lqp4i0ky3sbtj9ws8gmysqnejknyoa', '.eJxVjEEOwiAQRe_C2hAGaAGX7j0DmYFBqoYmpV0Z765NutDtf-_9l4i4rTVunZc4ZXEWVpx-N8L04LaDfMd2m2Wa27pMJHdFHrTL65z5eTncv4OKvX5r4MLakHU6WwJFxZniB8fJAOuSjB99CJiKDsqPlkiBKhDYoAUYGLR4fwDrGzeb:1slYcq:e9VHxEKVosrz_jnaakoNTcrqer894CuKCgGmROmjvME', '2024-09-17 18:51:36.521520'),
('c5krs4v8mkszx17zr1hllzc60n6ub37s', '.eJxVjEEOwiAQRe_C2hAKAwWX7nsGMgNTqRqalHZlvLsh6UK3_7333yLisZd4NN7iksVVWHH53QjTk2sH-YH1vsq01n1bSHZFnrTJac38up3u30HBVnqdfB4dWp1QGfYERIEYQDE4rU3g2XpSKhszmJnBgEMeLCStcQxKW_H5AvJrN5E:1slBPT:Slo1XlORmuKe3-70GB8e9QQ97dqIme6JnJtT5NhT5oU', '2024-09-16 18:04:15.330898');

-- --------------------------------------------------------

--
-- Table structure for table `recommendations_product`
--

DROP TABLE IF EXISTS `recommendations_product`;
CREATE TABLE IF NOT EXISTS `recommendations_product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `recommendations_product`
--

INSERT INTO `recommendations_product` (`id`, `name`) VALUES
(1, 'Product 1'),
(2, 'Product 2'),
(3, 'Product 3'),
(4, 'Product 4'),
(5, 'Product 5'),
(6, 'Product 6'),
(7, 'Product 7'),
(8, 'Product 8'),
(9, 'Product 9'),
(10, 'Product 10');

-- --------------------------------------------------------

--
-- Table structure for table `recommendations_userinteraction`
--

DROP TABLE IF EXISTS `recommendations_userinteraction`;
CREATE TABLE IF NOT EXISTS `recommendations_userinteraction` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `timestamp` datetime(6) NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `interaction_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recommendations_userinteraction_product_id_19f141fd` (`product_id`),
  KEY `recommendations_userinteraction_user_id_a92ee9d6` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `recommendations_userinteraction`
--

INSERT INTO `recommendations_userinteraction` (`id`, `timestamp`, `product_id`, `user_id`, `interaction_type`) VALUES
(1, '2024-09-01 11:29:37.300217', 1, 1, 'click'),
(2, '2024-09-01 11:31:34.014097', 1, 1, 'click'),
(3, '2024-09-01 16:14:02.408961', 3, 2, 'click'),
(4, '2024-09-01 16:14:06.213237', 8, 2, 'click'),
(5, '2024-09-01 16:14:11.584318', 10, 2, 'click'),
(6, '2024-09-02 07:39:23.201088', 1, 4, 'click'),
(7, '2024-09-02 07:39:25.893639', 1, 4, 'favorite'),
(8, '2024-09-02 07:39:27.772294', 2, 4, 'click'),
(9, '2024-09-02 07:39:29.694906', 2, 4, 'favorite'),
(10, '2024-09-02 07:39:31.248459', 3, 4, 'click'),
(11, '2024-09-02 07:39:33.061808', 8, 4, 'click'),
(12, '2024-09-02 07:39:33.663212', 8, 4, 'click'),
(13, '2024-09-02 07:39:34.821498', 9, 4, 'click'),
(14, '2024-09-02 07:39:35.238496', 9, 4, 'click'),
(15, '2024-09-03 19:06:11.181590', 1, 4, 'click'),
(16, '2024-09-03 19:06:12.860626', 8, 4, 'click'),
(17, '2024-09-03 19:06:14.228765', 2, 4, 'click'),
(18, '2024-09-03 19:06:15.393647', 3, 4, 'click'),
(19, '2024-09-03 19:06:16.583056', 9, 4, 'click'),
(20, '2024-09-03 19:06:22.284601', 7, 4, 'click'),
(21, '2024-09-03 19:06:23.707010', 6, 4, 'click'),
(22, '2024-09-03 19:06:25.039387', 5, 4, 'click'),
(23, '2024-09-03 19:06:28.516666', 4, 4, 'favorite'),
(24, '2024-09-03 19:06:34.168466', 10, 4, 'favorite'),
(25, '2024-09-03 19:06:36.378690', 10, 4, 'click'),
(26, '2024-09-03 19:06:38.570014', 10, 4, 'click'),
(27, '2024-09-03 19:06:40.296807', 10, 4, 'click'),
(28, '2024-09-03 19:06:41.696471', 10, 4, 'click'),
(29, '2024-09-03 19:06:42.974077', 10, 4, 'click');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
