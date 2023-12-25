-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.25 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 导出  表 course_selection_sys.auth_group 结构
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.auth_group 的数据：~3 rows (大约)
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` (`id`, `name`) VALUES
	(1, '学生'),
	(2, '教师'),
	(3, '管理员');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- 导出  表 course_selection_sys.auth_user 结构
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.auth_user 的数据：~5 rows (大约)
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(4, 'pbkdf2_sha256$600000$rsn02IZepKeEKu7pUvIVX7$z5EfOPJJwPQRogEW3tIKizE9yMYhihizWedG8nhOPns=', '2023-12-21 16:55:52.254591', 0, '3', '', '', '', 0, 1, '2023-12-16 11:16:12.082707'),
	(14, 'pbkdf2_sha256$600000$NVBWjuHbG9WWYyd5o2fqu9$YZswbRPThN1jD79xoJbWsrZBAuqMTbPBsATMoGwQ1+Y=', '2023-12-23 15:38:18.594643', 0, '111111', '', '', '', 0, 1, '2023-12-21 16:57:09.736216'),
	(15, 'pbkdf2_sha256$600000$A5yEcfaQ4JbvRDOcbFbmND$aqKg/PAElUEXb0bSG7XC829huTMZOBVAnmOOdNyE3mc=', NULL, 0, '222222', '', '', '', 0, 1, '2023-12-22 00:58:51.098080'),
	(16, 'pbkdf2_sha256$600000$EKUZQLeOCj6ICltOtrA6DI$ZdMwto9j2nNvQSbfZYrNcFiLA2U8Ks5pr9kExPGdmu4=', NULL, 0, '333333', '', '', '', 0, 1, '2023-12-22 01:52:51.297243'),
	(17, 'ceshi', NULL, 0, '1', '1', '1', '1', 0, 1, '2023-12-22 09:53:50.000000'),
	(19, 'pbkdf2_sha256$600000$eT4C55fTUF9hJQ5y4EJBP2$UURCOymYo9w7JtZvDtv9bTYVXBvA27EXe3B3LikpH2g=', '2023-12-23 15:48:38.976636', 0, '20000000', '', '', '', 0, 1, '2023-12-23 15:39:33.972613');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- 导出  表 course_selection_sys.auth_user_groups 结构
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.auth_user_groups 的数据：~4 rows (大约)
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` (`id`, `user_id`, `group_id`) VALUES
	(2, 4, 3),
	(4, 14, 3),
	(5, 15, 2),
	(6, 16, 2),
	(8, 19, 1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- 导出  表 course_selection_sys.auth_user_user_permissions 结构
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.auth_user_user_permissions 的数据：~0 rows (大约)
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_course 结构
CREATE TABLE IF NOT EXISTS `managementapp_course` (
  `course_id` varchar(32) NOT NULL,
  `course_name` varchar(32) NOT NULL,
  `credit` int NOT NULL,
  `credit_hours` int NOT NULL,
  `dept_id_id` varchar(8) NOT NULL,
  `normal_score_percent` double NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `FK_managementapp_course_managementapp_department` (`dept_id_id`),
  CONSTRAINT `FK_managementapp_course_managementapp_department` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_course 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `managementapp_course` DISABLE KEYS */;
INSERT INTO `managementapp_course` (`course_id`, `course_name`, `credit`, `credit_hours`, `dept_id_id`, `normal_score_percent`) VALUES
	('01', '测试课程', 4, 40, '01', 0.5);
/*!40000 ALTER TABLE `managementapp_course` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_course_selection 结构
CREATE TABLE IF NOT EXISTS `managementapp_course_selection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `semester` varchar(32) NOT NULL,
  `normal_score` double DEFAULT NULL,
  `test_score` double DEFAULT NULL,
  `total_score` double DEFAULT NULL,
  `course_id_id` varchar(32) NOT NULL,
  `staff_id_id` varchar(32) NOT NULL,
  `student_id_id` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `managementApp_course_sel_student_id_id_course_id__4f14cb2b_uniq` (`student_id_id`,`course_id_id`,`semester`),
  KEY `managementApp_course_course_id_id_630d117c_fk_managemen` (`course_id_id`),
  KEY `managementApp_course_staff_id_id_38d8e48e_fk_managemen` (`staff_id_id`),
  CONSTRAINT `managementApp_course_course_id_id_630d117c_fk_managemen` FOREIGN KEY (`course_id_id`) REFERENCES `managementapp_course` (`course_id`),
  CONSTRAINT `managementApp_course_staff_id_id_38d8e48e_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`),
  CONSTRAINT `managementApp_course_student_id_id_2f0650d4_fk_managemen` FOREIGN KEY (`student_id_id`) REFERENCES `managementapp_student` (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_course_selection 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `managementapp_course_selection` DISABLE KEYS */;
INSERT INTO `managementapp_course_selection` (`id`, `semester`, `normal_score`, `test_score`, `total_score`, `course_id_id`, `staff_id_id`, `student_id_id`) VALUES
	(1, '2021-2022春季学期', NULL, NULL, NULL, '01', '333333', 'ceshi'),
	(2, '2021-2022春季学期', NULL, NULL, NULL, '01', '333333', '21111111');
/*!40000 ALTER TABLE `managementapp_course_selection` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_department 结构
CREATE TABLE IF NOT EXISTS `managementapp_department` (
  `dept_id` varchar(8) NOT NULL,
  `dept_name` varchar(32) NOT NULL,
  `address` varchar(32) NOT NULL,
  `phone_code` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `address` (`address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_department 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `managementapp_department` DISABLE KEYS */;
INSERT INTO `managementapp_department` (`dept_id`, `dept_name`, `address`, `phone_code`) VALUES
	('01', '计算机学院', '上大东校区三号楼', '65347567'),
	('02', '电影xy', 'Rt Shanghai', '00');
/*!40000 ALTER TABLE `managementapp_department` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_open_course 结构
CREATE TABLE IF NOT EXISTS `managementapp_open_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `semester` varchar(32) NOT NULL,
  `class_time` varchar(32) NOT NULL,
  `course_id_id` varchar(32) NOT NULL,
  `staff_id_id` varchar(32) NOT NULL,
  `capacity` int NOT NULL,
  `used_capacity` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `managementApp_open_cours_semester_course_id_id_st_2e1e3204_uniq` (`semester`,`course_id_id`,`staff_id_id`),
  KEY `managementApp_open_c_course_id_id_5711f03f_fk_managemen` (`course_id_id`),
  KEY `managementApp_open_c_staff_id_id_f4f1cfe2_fk_managemen` (`staff_id_id`),
  CONSTRAINT `managementApp_open_c_course_id_id_5711f03f_fk_managemen` FOREIGN KEY (`course_id_id`) REFERENCES `managementapp_course` (`course_id`),
  CONSTRAINT `managementApp_open_c_staff_id_id_f4f1cfe2_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_open_course 的数据：~1 rows (大约)
/*!40000 ALTER TABLE `managementapp_open_course` DISABLE KEYS */;
INSERT INTO `managementapp_open_course` (`id`, `semester`, `class_time`, `course_id_id`, `staff_id_id`, `capacity`, `used_capacity`) VALUES
	(3, '2021-2022春季学期', '三2-3', '01', '222222', 30, 0);
/*!40000 ALTER TABLE `managementapp_open_course` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_student 结构
CREATE TABLE IF NOT EXISTS `managementapp_student` (
  `student_id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `sex` varchar(4) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `native_place` varchar(32) DEFAULT NULL,
  `mobile_phone` varchar(32) DEFAULT NULL,
  `average_gpa` double DEFAULT NULL,
  `total_credit` double DEFAULT NULL,
  `dept_id_id` varchar(8) NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`student_id`),
  KEY `managementApp_studen_dept_id_id_08497e27_fk_managemen` (`dept_id_id`),
  KEY `managementApp_student_user_id_id_31d3f1d9_fk_auth_user_id` (`user_id_id`),
  CONSTRAINT `managementApp_studen_dept_id_id_08497e27_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`),
  CONSTRAINT `managementApp_student_user_id_id_31d3f1d9_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_student 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `managementapp_student` DISABLE KEYS */;
INSERT INTO `managementapp_student` (`student_id`, `name`, `sex`, `date_of_birth`, `native_place`, `mobile_phone`, `average_gpa`, `total_credit`, `dept_id_id`, `user_id_id`) VALUES
	('20000000', '测试3', '女', '2023-12-01', '陕西', '19881888188', 4, 100, '01', 19),
	('21111111', '测试', '男', '2023-12-21', NULL, '100', 4, 100, '01', 4),
	('ceshi', '测试选课学生', NULL, '2023-12-23', NULL, '11111', 1, 0, '01', 17);
/*!40000 ALTER TABLE `managementapp_student` ENABLE KEYS */;

-- 导出  表 course_selection_sys.managementapp_teacher 结构
CREATE TABLE IF NOT EXISTS `managementapp_teacher` (
  `staff_id` varchar(32) NOT NULL,
  `name` varchar(32) NOT NULL,
  `sex` varchar(4) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `professional_ranks` varchar(32) DEFAULT NULL,
  `salary` double DEFAULT NULL,
  `dept_id_id` varchar(8) NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`staff_id`),
  KEY `managementApp_t_dept_id_id_d40231fe_fk_managemen` (`dept_id_id`),
  KEY `managementApp_teacher_user_id_id_4bc0c57c_fk_auth_user_id` (`user_id_id`),
  CONSTRAINT `managementApp_t_dept_id_id_d40231fe_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`),
  CONSTRAINT `managementApp_teacher_user_id_id_4bc0c57c_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- 正在导出表  course_selection_sys.managementapp_teacher 的数据：~2 rows (大约)
/*!40000 ALTER TABLE `managementapp_teacher` DISABLE KEYS */;
INSERT INTO `managementapp_teacher` (`staff_id`, `name`, `sex`, `date_of_birth`, `professional_ranks`, `salary`, `dept_id_id`, `user_id_id`) VALUES
	('222222', '测试教师', '女', '2023-12-01', '教授', 0, '01', 15),
	('333333', '333333', '女', '2023-12-05', '', 0, '01', 16);
/*!40000 ALTER TABLE `managementapp_teacher` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
