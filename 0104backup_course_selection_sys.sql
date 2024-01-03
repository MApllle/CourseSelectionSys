/*
 Navicat Premium Data Transfer

 Source Server         : course_selection_sys
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : course_selection_sys

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 04/01/2024 00:51:15
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, '学生');
INSERT INTO `auth_group` VALUES (2, '教师');
INSERT INTO `auth_group` VALUES (3, '管理员');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (14, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (15, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (16, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (17, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (18, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (19, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (20, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (21, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (22, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (23, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (24, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (25, 'Can add department', 7, 'add_department');
INSERT INTO `auth_permission` VALUES (26, 'Can change department', 7, 'change_department');
INSERT INTO `auth_permission` VALUES (27, 'Can delete department', 7, 'delete_department');
INSERT INTO `auth_permission` VALUES (28, 'Can view department', 7, 'view_department');
INSERT INTO `auth_permission` VALUES (29, 'Can add student', 8, 'add_student');
INSERT INTO `auth_permission` VALUES (30, 'Can change student', 8, 'change_student');
INSERT INTO `auth_permission` VALUES (31, 'Can delete student', 8, 'delete_student');
INSERT INTO `auth_permission` VALUES (32, 'Can view student', 8, 'view_student');
INSERT INTO `auth_permission` VALUES (33, 'Can add teacher', 9, 'add_teacher');
INSERT INTO `auth_permission` VALUES (34, 'Can change teacher', 9, 'change_teacher');
INSERT INTO `auth_permission` VALUES (35, 'Can delete teacher', 9, 'delete_teacher');
INSERT INTO `auth_permission` VALUES (36, 'Can view teacher', 9, 'view_teacher');
INSERT INTO `auth_permission` VALUES (37, 'Can add course', 10, 'add_course');
INSERT INTO `auth_permission` VALUES (38, 'Can change course', 10, 'change_course');
INSERT INTO `auth_permission` VALUES (39, 'Can delete course', 10, 'delete_course');
INSERT INTO `auth_permission` VALUES (40, 'Can view course', 10, 'view_course');
INSERT INTO `auth_permission` VALUES (41, 'Can add open_course', 11, 'add_open_course');
INSERT INTO `auth_permission` VALUES (42, 'Can change open_course', 11, 'change_open_course');
INSERT INTO `auth_permission` VALUES (43, 'Can delete open_course', 11, 'delete_open_course');
INSERT INTO `auth_permission` VALUES (44, 'Can view open_course', 11, 'view_open_course');
INSERT INTO `auth_permission` VALUES (45, 'Can add course_selection', 12, 'add_course_selection');
INSERT INTO `auth_permission` VALUES (46, 'Can change course_selection', 12, 'change_course_selection');
INSERT INTO `auth_permission` VALUES (47, 'Can delete course_selection', 12, 'delete_course_selection');
INSERT INTO `auth_permission` VALUES (48, 'Can view course_selection', 12, 'view_course_selection');
INSERT INTO `auth_permission` VALUES (49, 'Can add course_request', 13, 'add_course_request');
INSERT INTO `auth_permission` VALUES (50, 'Can change course_request', 13, 'change_course_request');
INSERT INTO `auth_permission` VALUES (51, 'Can delete course_request', 13, 'delete_course_request');
INSERT INTO `auth_permission` VALUES (52, 'Can view course_request', 13, 'view_course_request');
INSERT INTO `auth_permission` VALUES (53, 'Can add student_comments', 14, 'add_student_comments');
INSERT INTO `auth_permission` VALUES (54, 'Can change student_comments', 14, 'change_student_comments');
INSERT INTO `auth_permission` VALUES (55, 'Can delete student_comments', 14, 'delete_student_comments');
INSERT INTO `auth_permission` VALUES (56, 'Can view student_comments', 14, 'view_student_comments');
INSERT INTO `auth_permission` VALUES (57, 'Can add meeting_room', 15, 'add_meeting_room');
INSERT INTO `auth_permission` VALUES (58, 'Can change meeting_room', 15, 'change_meeting_room');
INSERT INTO `auth_permission` VALUES (59, 'Can delete meeting_room', 15, 'delete_meeting_room');
INSERT INTO `auth_permission` VALUES (60, 'Can view meeting_room', 15, 'view_meeting_room');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 73 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
INSERT INTO `auth_user` VALUES (4, 'pbkdf2_sha256$600000$rsn02IZepKeEKu7pUvIVX7$z5EfOPJJwPQRogEW3tIKizE9yMYhihizWedG8nhOPns=', '2024-01-03 16:45:37.212333', 0, '3', '', '', '', 0, 1, '2023-12-16 11:16:12.082707');
INSERT INTO `auth_user` VALUES (14, 'pbkdf2_sha256$600000$NVBWjuHbG9WWYyd5o2fqu9$YZswbRPThN1jD79xoJbWsrZBAuqMTbPBsATMoGwQ1+Y=', '2023-12-23 15:38:18.594643', 0, '111111', '', '', '', 0, 1, '2023-12-21 16:57:09.736216');
INSERT INTO `auth_user` VALUES (15, 'pbkdf2_sha256$600000$A5yEcfaQ4JbvRDOcbFbmND$aqKg/PAElUEXb0bSG7XC829huTMZOBVAnmOOdNyE3mc=', '2024-01-03 16:41:50.255563', 0, '222222', '', '', '', 0, 1, '2023-12-22 00:58:51.098080');
INSERT INTO `auth_user` VALUES (16, 'pbkdf2_sha256$600000$EKUZQLeOCj6ICltOtrA6DI$ZdMwto9j2nNvQSbfZYrNcFiLA2U8Ks5pr9kExPGdmu4=', NULL, 0, '333333', '', '', '', 0, 1, '2023-12-22 01:52:51.297243');
INSERT INTO `auth_user` VALUES (19, 'pbkdf2_sha256$600000$eT4C55fTUF9hJQ5y4EJBP2$UURCOymYo9w7JtZvDtv9bTYVXBvA27EXe3B3LikpH2g=', '2024-01-03 16:18:16.402620', 0, '20000000', '', '', '', 0, 1, '2023-12-23 15:39:33.972613');
INSERT INTO `auth_user` VALUES (20, 'pbkdf2_sha256$600000$kPEt7MKkeq9xcZeu82aEob$F5uJrbxRqitWLFT0aGb6JXFBSx70fp0bwRqLtuJjcuA=', '2024-01-03 13:49:23.672051', 0, '1', '', '', '', 0, 1, '2024-01-03 13:21:31.216859');
INSERT INTO `auth_user` VALUES (21, 'pbkdf2_sha256$600000$oj4DU9pcFh9TbA48fTV3iU$J0I+nLRz1jOfhoAtewuAXMesr369XW0x6XrDxHXgJLk=', NULL, 0, '2', '', '', '', 0, 1, '2024-01-03 13:26:27.475074');
INSERT INTO `auth_user` VALUES (22, 'pbkdf2_sha256$600000$L4nIdo1fEFne4mOCLENxEm$8ZHQ7zlticwlVuq10tF2ksdbgV4gpQJX+s2+RWz3Zc8=', NULL, 0, '4', '', '', '', 0, 1, '2024-01-03 13:27:35.883040');
INSERT INTO `auth_user` VALUES (23, 'pbkdf2_sha256$600000$PUpUqttkYMiwFzFFmNemfM$bnwmVsbkNgL9Z/cnyYxEaREVpG9z/7jE41BQ1m2MVqs=', NULL, 0, '5', '', '', '', 0, 1, '2024-01-03 13:28:04.139652');
INSERT INTO `auth_user` VALUES (24, 'pbkdf2_sha256$600000$emr5IZ86F2eb8bZlz7EvlL$taq1EUS7OkX42FV8KTHlXzg8ycqBiQ6KfdT6r3s37O0=', NULL, 0, '6', '', '', '', 0, 1, '2024-01-03 13:28:53.019007');
INSERT INTO `auth_user` VALUES (25, 'pbkdf2_sha256$600000$s6QoWga2eNk6c5Y9XsATSX$G/ZB9VOVZSVMZAwbXx7wonEG3Jp00UFFmkWVeDBgHIM=', NULL, 0, '7', '', '', '', 0, 1, '2024-01-03 13:29:23.860870');
INSERT INTO `auth_user` VALUES (26, 'pbkdf2_sha256$600000$Z7O1E59BLLNMSwSXzl0FnD$gdHbF09VrdhIdyjmkaPlcWuuRIpMJd+LPm1x8wDya8w=', NULL, 0, '8', '', '', '', 0, 1, '2024-01-03 13:30:01.992526');
INSERT INTO `auth_user` VALUES (27, 'pbkdf2_sha256$600000$byAscTDgAK4Xy7pGGm7yHo$4uxczO+lQnX0SIO8Ny0b/QjyoZx7NffyQpcn03ofRao=', NULL, 0, '9', '', '', '', 0, 1, '2024-01-03 13:31:59.561177');
INSERT INTO `auth_user` VALUES (28, 'pbkdf2_sha256$600000$ED0yetmpSJI7REREqPaR5x$dJ5WPIOIIlYz8a3Cdn7Pnkko7UOil9x5nF3nIsXc5i8=', NULL, 0, '10', '', '', '', 0, 1, '2024-01-03 13:32:34.463796');
INSERT INTO `auth_user` VALUES (29, 'pbkdf2_sha256$600000$mCPDq2R6Q63QTHoPsOSwNu$BQboJ1avrSe077u95+PKC03jjxbHwDHcMnnvJ4FfShg=', NULL, 0, '11', '', '', '', 0, 1, '2024-01-03 13:33:16.459940');
INSERT INTO `auth_user` VALUES (30, 'pbkdf2_sha256$600000$CWam1160bUfNSFtRLsiFNq$iVWet/9XXYnCNS0dFlwPaEuK0etQ549vNzbUozqdgWA=', NULL, 0, 's1', '', '', '', 0, 1, '2024-01-03 13:50:14.893182');
INSERT INTO `auth_user` VALUES (31, 'pbkdf2_sha256$600000$pAY2f8QgV88tihpZ68i1ps$3C1AuSPvKielFG2g6XwOUERzGYG5TA6jcVXqmmBpqjU=', NULL, 0, 's2', '', '', '', 0, 1, '2024-01-03 13:55:07.640643');
INSERT INTO `auth_user` VALUES (32, 'pbkdf2_sha256$600000$PzafI5hwMkGyzxjGOdXi9a$69aAEUB2f+gzk2a1vmaO2KdpiB54muivUeRp9Eilsdk=', NULL, 0, 's3', '', '', '', 0, 1, '2024-01-03 13:56:04.766412');
INSERT INTO `auth_user` VALUES (33, 'pbkdf2_sha256$600000$GGKO9PgncOQfSBCGIjKdWq$gCvq4Rt7rligGSmP7BpQkvwUgq61/Y8E6Jpn9d3aEls=', NULL, 0, 's4', '', '', '', 0, 1, '2024-01-03 13:56:25.617426');
INSERT INTO `auth_user` VALUES (34, 'pbkdf2_sha256$600000$fDEWja0qUgq1Te57wjRibP$wIdZPDz6PhbbzoR652byV/v1lxdKlMxsc+bQRkUHTwA=', NULL, 0, 's5', '', '', '', 0, 1, '2024-01-03 13:58:28.237955');
INSERT INTO `auth_user` VALUES (35, 'pbkdf2_sha256$600000$8Nz0pN53y5hOkTd9TNoVK0$yd+a4V1YtseNavqtxuo43suTpLXLpxTOxeaJ/UXSzmk=', NULL, 0, 's6', '', '', '', 0, 1, '2024-01-03 13:58:52.993320');
INSERT INTO `auth_user` VALUES (36, 'pbkdf2_sha256$600000$Ixf3z6nbdlksfI8XsNcsmY$p5bVNgOfneX/BXFlOLanv9Q4wPVIfuUK80nrXobSn78=', NULL, 0, 's7', '', '', '', 0, 1, '2024-01-03 13:59:13.897891');
INSERT INTO `auth_user` VALUES (37, 'pbkdf2_sha256$600000$xi09awtjRUd4O6BTgH18IN$86UEloI3MA3n/HlztMt69SNj1LuwVRgXb4vwD4ir59g=', NULL, 0, 's8', '', '', '', 0, 1, '2024-01-03 13:59:37.982386');
INSERT INTO `auth_user` VALUES (38, 'pbkdf2_sha256$600000$QGepreNdacNPkQpBebaGPu$a1TUN4kjUH4lFGZVhRrMwS1d3g2vFHsjdndJGumtuhQ=', NULL, 0, 's9', '', '', '', 0, 1, '2024-01-03 14:00:01.351465');
INSERT INTO `auth_user` VALUES (39, 'pbkdf2_sha256$600000$mHwUqlNmQkS59y9m5wMKS8$eJxkbxIaweuJSeATk2wp4t/bLnyBxs9Z2zvr27qKbiI=', NULL, 0, 's10', '', '', '', 0, 1, '2024-01-03 14:00:39.195321');
INSERT INTO `auth_user` VALUES (40, 'pbkdf2_sha256$600000$dBkX7Z1ZkvQuei0pNEyNNO$bEy/zZE1uhby9ZUgSuKxMtMxUfUnvpyu37ayN54Chr0=', NULL, 0, 's11', '', '', '', 0, 1, '2024-01-03 14:01:17.322757');
INSERT INTO `auth_user` VALUES (41, 'pbkdf2_sha256$600000$SQE8URVFKKaZTEkPP2cCiQ$WpbYOwGI0TgsB9CnllL77BLQK/rV7eQCkG+4tGx4yZs=', NULL, 0, 's12', '', '', '', 0, 1, '2024-01-03 14:01:35.383836');
INSERT INTO `auth_user` VALUES (42, 'pbkdf2_sha256$600000$zvK2vmOoPjX36WgSTQfyGA$BEzXlWpiIRIrSZLtTJ5XJnOwx6vzZjjf+pgOhb4JPBE=', NULL, 0, 's13', '', '', '', 0, 1, '2024-01-03 14:02:35.971070');
INSERT INTO `auth_user` VALUES (43, 'pbkdf2_sha256$600000$fTrDh265RSjYrwVD9HKa4M$4+GxScFYq+AlGf8D9Zh4i0YBHFAPyGQccrxAhqBQwnY=', NULL, 0, 's14', '', '', '', 0, 1, '2024-01-03 14:02:56.488157');
INSERT INTO `auth_user` VALUES (44, 'pbkdf2_sha256$600000$gN8TrvlC46CM9HgcmWukGl$FNTr2Y5LWce9dc8CR9ZyLmAzIfAWSLTdk2LlCq14Z4I=', NULL, 0, 's15', '', '', '', 0, 1, '2024-01-03 14:03:18.076298');
INSERT INTO `auth_user` VALUES (45, 'pbkdf2_sha256$600000$QTKJaKVzBgtmVQTOWpg7y8$+GL4/BO/jPXu9qnVipC1rsq0dMY2sY9XlugL8AwIx6w=', NULL, 0, 's16', '', '', '', 0, 1, '2024-01-03 14:03:44.058583');
INSERT INTO `auth_user` VALUES (46, 'pbkdf2_sha256$600000$vodYGaBfLK2ZjPf59dGgoT$tpK1ShJn5JmMi4GptdCtEDtD5lnPogCWWG53HdHBcTs=', NULL, 0, 's17', '', '', '', 0, 1, '2024-01-03 14:04:14.101158');
INSERT INTO `auth_user` VALUES (47, 'pbkdf2_sha256$600000$ToNtlQQWeCw8DEhlxsvhT4$BP6yt5lF4ZU8fpkUHVnG2j7r2kuf6skytnDpv9Z97Dw=', NULL, 0, 's18', '', '', '', 0, 1, '2024-01-03 14:04:45.903465');
INSERT INTO `auth_user` VALUES (48, 'pbkdf2_sha256$600000$X29SqX8y4VFtdKb3VlaluZ$1VBpDcMVMQmCprPJRgc2gzvagXG4YsNqF2f5wgBXYJk=', NULL, 0, 's19', '', '', '', 0, 1, '2024-01-03 14:05:20.964844');
INSERT INTO `auth_user` VALUES (49, 'pbkdf2_sha256$600000$4zX24cmJhs41txfLg1EhBp$90JSp24VRxroN9PlT+r2nBiNYHE2YGsNvnwLu+www7U=', NULL, 0, 's20', '', '', '', 0, 1, '2024-01-03 14:05:49.428807');
INSERT INTO `auth_user` VALUES (50, 'pbkdf2_sha256$600000$qc8G4QfasYrEUKFBno5B2i$X3cTzWL/hAcfL8BQuVjkl80qTFvjtC6dvBoNX5F5aAk=', NULL, 0, 's21', '', '', '', 0, 1, '2024-01-03 14:06:09.378205');
INSERT INTO `auth_user` VALUES (51, 'pbkdf2_sha256$600000$M9Ftk6h59rC8iZpeHXn7fC$M2crXH0Lr9pAIqMCc2hDvQv8oxyD5oUjJYZfEBo+FUA=', NULL, 0, 's22', '', '', '', 0, 1, '2024-01-03 14:06:28.541154');
INSERT INTO `auth_user` VALUES (52, 'pbkdf2_sha256$600000$MIiiq4gic8h77JeRVPWF6f$ndfeUPPHaTLMzhhd365wXwV2m6cafFOhVLl7kPCzPS0=', NULL, 0, 's23', '', '', '', 0, 1, '2024-01-03 14:06:50.855726');
INSERT INTO `auth_user` VALUES (53, 'pbkdf2_sha256$600000$0AQ96kKrv016PZihq4zJlS$FGLxZ/l7BXZzktfy+2uk09gaPlkHF9m7XsBJw81ufmE=', NULL, 0, 's24', '', '', '', 0, 1, '2024-01-03 14:07:17.104497');
INSERT INTO `auth_user` VALUES (54, 'pbkdf2_sha256$600000$RoDQ2deHXSERPZATTpb7Rq$v7aQNtohQf+K4erHYwalebgGZXGjCzTeR2Tyim9Qg/M=', NULL, 0, 's25', '', '', '', 0, 1, '2024-01-03 14:08:09.309884');
INSERT INTO `auth_user` VALUES (55, 'pbkdf2_sha256$600000$qmn3wA7fwE67IDVCRPXdUv$bxm84GaMEI7AvkQlK4Vs1PEjnUA9omfn76zTjDUS9s0=', NULL, 0, 's26', '', '', '', 0, 1, '2024-01-03 14:08:30.414927');
INSERT INTO `auth_user` VALUES (56, 'pbkdf2_sha256$600000$QGvqx33LZ5i628xOtxcYhp$53v+1KVYAYl4AD3t5Kj5i8bYRkGyJG3uFCwLSjFcQXk=', NULL, 0, 's27', '', '', '', 0, 1, '2024-01-03 14:08:47.963834');
INSERT INTO `auth_user` VALUES (57, 'pbkdf2_sha256$600000$D8RZCbnumghFkjVeCO8IHo$Efc1klCIvedw2szWH1bL1tAt2wL4FcbBpf9annjdUi0=', NULL, 0, 's28', '', '', '', 0, 1, '2024-01-03 14:09:05.891557');
INSERT INTO `auth_user` VALUES (58, 'pbkdf2_sha256$600000$Ow1E9SwUT6i83dfy85agYQ$mwDuKxyij7SJ3S3yeGuLcR2xWsPBL8iZVfpoB+kL+9g=', NULL, 0, 's29', '', '', '', 0, 1, '2024-01-03 14:09:27.894436');
INSERT INTO `auth_user` VALUES (59, 'pbkdf2_sha256$600000$yZBOO3sHCBnuW9GjIadCXy$UwXFsTtKRqhVzxRw1elQWm1pBh20J3DglJW4vDOUqYI=', NULL, 0, 's30', '', '', '', 0, 1, '2024-01-03 14:09:46.817028');
INSERT INTO `auth_user` VALUES (60, 'pbkdf2_sha256$600000$YqX34XETMeHmKQ9Ne5b5MF$Sc4UCEoU/MgWRugJ3PYMvsEpvWi7fs0Z/yifXs2G7tc=', NULL, 0, 's31', '', '', '', 0, 1, '2024-01-03 14:10:11.275708');
INSERT INTO `auth_user` VALUES (61, 'pbkdf2_sha256$600000$QeKgPq5cpTRyJyqoHwSPYy$A65l0cAdVGKpQplPSvedr0eT8rqVDJXMYoQqCePHYSs=', NULL, 0, 's32', '', '', '', 0, 1, '2024-01-03 14:10:31.514718');
INSERT INTO `auth_user` VALUES (62, 'pbkdf2_sha256$600000$lCPBCxWzcPkS0O40ioodI4$hSVNqF2nI+xlKcBRTGhmJtrTxSx5AfA4gPF1/zw2dfE=', NULL, 0, 's33', '', '', '', 0, 1, '2024-01-03 14:10:50.712140');
INSERT INTO `auth_user` VALUES (63, 'pbkdf2_sha256$600000$dwsG5zYX8YQVZyu0j9RrYX$F0qO9HseyA3GSmQGk4aM77HuBzjhL3bMzYgDRoEn4SI=', NULL, 0, 's34', '', '', '', 0, 1, '2024-01-03 14:12:41.358096');
INSERT INTO `auth_user` VALUES (64, 'pbkdf2_sha256$600000$7mtuZlClqcHB4b1ududjpF$YD3d4m0T1mIg+gaNemPsQiIAR+j2oBlIq/sK43v7P5g=', NULL, 0, 's35', '', '', '', 0, 1, '2024-01-03 14:13:07.783982');
INSERT INTO `auth_user` VALUES (65, 'pbkdf2_sha256$600000$f4W2s8p2cQ5oN1W3uUueKD$ytcDFKl14f9KFw7SBYHZC++XOOqde+pRBXvQ7haIJpY=', NULL, 0, 's36', '', '', '', 0, 1, '2024-01-03 14:13:29.608831');
INSERT INTO `auth_user` VALUES (66, 'pbkdf2_sha256$600000$6hFf2awh9pUDQ4EkVUx78L$zdZYq2ZWIUPBeKGKkb6bOi5EN8/+UA9O/4ssijQ56mc=', NULL, 0, 's37', '', '', '', 0, 1, '2024-01-03 14:13:54.486643');
INSERT INTO `auth_user` VALUES (67, 'pbkdf2_sha256$600000$jTcf36XdLjcESzfiJWXMmI$i9w6Rj+9cw8n3L3exlmKlBl9kIG3bZkZVVU2QCfqt84=', NULL, 0, 's38', '', '', '', 0, 1, '2024-01-03 14:14:28.244907');
INSERT INTO `auth_user` VALUES (68, 'pbkdf2_sha256$600000$P4TpBgwYRDVhLxmNtduBN0$c8NxKd4KtASq81PD5IK7ZzSQTn6L8po9nDUQjagWju8=', NULL, 0, 's39', '', '', '', 0, 1, '2024-01-03 14:14:48.779462');
INSERT INTO `auth_user` VALUES (69, 'pbkdf2_sha256$600000$mCpOHd3uhTALNKtze38vlw$Je/cG+alaVbGecnAr4I90nLwjR1SnVEdFILW4KLBjKI=', NULL, 0, 's40', '', '', '', 0, 1, '2024-01-03 14:15:15.833984');
INSERT INTO `auth_user` VALUES (70, 'pbkdf2_sha256$600000$ix9cIeKK6Ca9pIuwyFn8Iu$jEM5m75awt0UpRUAebHLkIN9pkZoN9ujU1WTlQGObCE=', NULL, 0, 's41', '', '', '', 0, 1, '2024-01-03 14:15:43.067980');
INSERT INTO `auth_user` VALUES (71, 'pbkdf2_sha256$600000$m9SlJOT7mM18IKGZ1wY2AE$zoreamlsTA+1tGdSexmd4oAjJ6eFVXmVlmdKwQwawpU=', NULL, 0, 's42', '', '', '', 0, 1, '2024-01-03 14:16:05.534699');
INSERT INTO `auth_user` VALUES (72, 'pbkdf2_sha256$600000$3diCM6xJzls6hfdGzrXFn2$VDQ7+z9wgQa8lvmyvm8xFhIxuwDuhMfvrsoE+wabkEU=', NULL, 0, 's43', '', '', '', 0, 1, '2024-01-03 14:16:56.761542');

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------
INSERT INTO `auth_user_groups` VALUES (2, 4, 3);
INSERT INTO `auth_user_groups` VALUES (4, 14, 3);
INSERT INTO `auth_user_groups` VALUES (5, 15, 2);
INSERT INTO `auth_user_groups` VALUES (6, 16, 2);
INSERT INTO `auth_user_groups` VALUES (8, 19, 1);
INSERT INTO `auth_user_groups` VALUES (9, 20, 2);
INSERT INTO `auth_user_groups` VALUES (10, 21, 2);
INSERT INTO `auth_user_groups` VALUES (11, 22, 2);
INSERT INTO `auth_user_groups` VALUES (12, 23, 2);
INSERT INTO `auth_user_groups` VALUES (13, 24, 2);
INSERT INTO `auth_user_groups` VALUES (14, 25, 2);
INSERT INTO `auth_user_groups` VALUES (15, 26, 2);
INSERT INTO `auth_user_groups` VALUES (16, 27, 2);
INSERT INTO `auth_user_groups` VALUES (17, 28, 2);
INSERT INTO `auth_user_groups` VALUES (18, 29, 2);
INSERT INTO `auth_user_groups` VALUES (19, 30, 1);
INSERT INTO `auth_user_groups` VALUES (20, 31, 1);
INSERT INTO `auth_user_groups` VALUES (21, 32, 1);
INSERT INTO `auth_user_groups` VALUES (22, 33, 1);
INSERT INTO `auth_user_groups` VALUES (23, 34, 1);
INSERT INTO `auth_user_groups` VALUES (24, 35, 1);
INSERT INTO `auth_user_groups` VALUES (25, 36, 1);
INSERT INTO `auth_user_groups` VALUES (26, 37, 1);
INSERT INTO `auth_user_groups` VALUES (27, 38, 1);
INSERT INTO `auth_user_groups` VALUES (28, 39, 1);
INSERT INTO `auth_user_groups` VALUES (29, 40, 1);
INSERT INTO `auth_user_groups` VALUES (30, 41, 1);
INSERT INTO `auth_user_groups` VALUES (31, 42, 1);
INSERT INTO `auth_user_groups` VALUES (32, 43, 1);
INSERT INTO `auth_user_groups` VALUES (33, 44, 1);
INSERT INTO `auth_user_groups` VALUES (34, 45, 1);
INSERT INTO `auth_user_groups` VALUES (35, 46, 1);
INSERT INTO `auth_user_groups` VALUES (36, 47, 1);
INSERT INTO `auth_user_groups` VALUES (37, 48, 1);
INSERT INTO `auth_user_groups` VALUES (38, 49, 1);
INSERT INTO `auth_user_groups` VALUES (39, 50, 1);
INSERT INTO `auth_user_groups` VALUES (40, 51, 1);
INSERT INTO `auth_user_groups` VALUES (41, 52, 1);
INSERT INTO `auth_user_groups` VALUES (42, 53, 1);
INSERT INTO `auth_user_groups` VALUES (43, 54, 1);
INSERT INTO `auth_user_groups` VALUES (44, 55, 1);
INSERT INTO `auth_user_groups` VALUES (45, 56, 1);
INSERT INTO `auth_user_groups` VALUES (46, 57, 1);
INSERT INTO `auth_user_groups` VALUES (47, 58, 1);
INSERT INTO `auth_user_groups` VALUES (48, 59, 1);
INSERT INTO `auth_user_groups` VALUES (49, 60, 1);
INSERT INTO `auth_user_groups` VALUES (50, 61, 1);
INSERT INTO `auth_user_groups` VALUES (51, 62, 1);
INSERT INTO `auth_user_groups` VALUES (52, 63, 1);
INSERT INTO `auth_user_groups` VALUES (53, 64, 1);
INSERT INTO `auth_user_groups` VALUES (54, 65, 1);
INSERT INTO `auth_user_groups` VALUES (55, 66, 1);
INSERT INTO `auth_user_groups` VALUES (56, 67, 1);
INSERT INTO `auth_user_groups` VALUES (57, 68, 1);
INSERT INTO `auth_user_groups` VALUES (58, 69, 1);
INSERT INTO `auth_user_groups` VALUES (59, 70, 1);
INSERT INTO `auth_user_groups` VALUES (60, 71, 1);
INSERT INTO `auth_user_groups` VALUES (61, 72, 1);

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_auth_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (10, 'managementApp', 'course');
INSERT INTO `django_content_type` VALUES (13, 'managementApp', 'course_request');
INSERT INTO `django_content_type` VALUES (12, 'managementApp', 'course_selection');
INSERT INTO `django_content_type` VALUES (7, 'managementApp', 'department');
INSERT INTO `django_content_type` VALUES (15, 'managementApp', 'meeting_room');
INSERT INTO `django_content_type` VALUES (11, 'managementApp', 'open_course');
INSERT INTO `django_content_type` VALUES (8, 'managementApp', 'student');
INSERT INTO `django_content_type` VALUES (14, 'managementApp', 'student_comments');
INSERT INTO `django_content_type` VALUES (9, 'managementApp', 'teacher');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2023-12-20 23:59:08.753005');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2023-12-20 23:59:09.408967');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2023-12-20 23:59:09.554532');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2023-12-20 23:59:09.563553');
INSERT INTO `django_migrations` VALUES (5, 'admin', '0003_logentry_add_action_flag_choices', '2023-12-20 23:59:09.573095');
INSERT INTO `django_migrations` VALUES (6, 'contenttypes', '0002_remove_content_type_name', '2023-12-20 23:59:09.682715');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0002_alter_permission_name_max_length', '2023-12-20 23:59:09.750669');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0003_alter_user_email_max_length', '2023-12-20 23:59:09.774960');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0004_alter_user_username_opts', '2023-12-20 23:59:09.784116');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0005_alter_user_last_login_null', '2023-12-20 23:59:09.845597');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0006_require_contenttypes_0002', '2023-12-20 23:59:09.849888');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0007_alter_validators_add_error_messages', '2023-12-20 23:59:09.859961');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0008_alter_user_username_max_length', '2023-12-20 23:59:10.109587');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0009_alter_user_last_name_max_length', '2023-12-20 23:59:10.174955');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0010_alter_group_name_max_length', '2023-12-20 23:59:10.207342');
INSERT INTO `django_migrations` VALUES (16, 'auth', '0011_update_proxy_permissions', '2023-12-20 23:59:10.230520');
INSERT INTO `django_migrations` VALUES (17, 'auth', '0012_alter_user_first_name_max_length', '2023-12-20 23:59:10.304109');
INSERT INTO `django_migrations` VALUES (18, 'managementApp', '0001_initial', '2023-12-20 23:59:10.479423');
INSERT INTO `django_migrations` VALUES (19, 'managementApp', '0002_rename_t_teacher', '2023-12-20 23:59:10.506339');
INSERT INTO `django_migrations` VALUES (20, 'managementApp', '0003_alter_department_phone_code_and_more', '2023-12-20 23:59:11.116125');
INSERT INTO `django_migrations` VALUES (21, 'managementApp', '0004_course_open_course', '2023-12-20 23:59:11.408129');
INSERT INTO `django_migrations` VALUES (22, 'managementApp', '0005_alter_open_course_unique_together_and_more', '2023-12-20 23:59:11.475211');
INSERT INTO `django_migrations` VALUES (23, 'managementApp', '0006_remove_open_course_unique_constraint_name_and_more', '2023-12-20 23:59:11.512136');
INSERT INTO `django_migrations` VALUES (24, 'managementApp', '0007_course_selection', '2023-12-20 23:59:11.735040');
INSERT INTO `django_migrations` VALUES (25, 'sessions', '0001_initial', '2023-12-20 23:59:11.773820');
INSERT INTO `django_migrations` VALUES (26, 'managementApp', '0008_student_user_id_teacher_user_id', '2023-12-24 09:22:57.617229');
INSERT INTO `django_migrations` VALUES (27, 'managementApp', '0009_alter_student_mobile_phone', '2023-12-24 09:22:57.664158');
INSERT INTO `django_migrations` VALUES (28, 'managementApp', '0010_rename_total_cerdict_student_total_credit', '2023-12-24 09:22:57.687260');
INSERT INTO `django_migrations` VALUES (29, 'managementApp', '0009_course_normal_score_percent_open_course_capacity_and_more', '2023-12-24 09:54:35.665874');
INSERT INTO `django_migrations` VALUES (30, 'managementApp', '0011_merge_20231224_0012', '2023-12-24 09:54:35.670296');
INSERT INTO `django_migrations` VALUES (31, 'managementApp', '0012_course_selection_open_course_id', '2023-12-26 04:31:09.426573');
INSERT INTO `django_migrations` VALUES (32, 'managementApp', '0013_alter_open_course_unique_together', '2023-12-26 04:31:09.495534');
INSERT INTO `django_migrations` VALUES (33, 'managementApp', '0014_course_request', '2024-01-02 12:59:11.118194');
INSERT INTO `django_migrations` VALUES (34, 'managementApp', '0015_alter_course_request_dept_id_and_more', '2024-01-02 12:59:11.343542');
INSERT INTO `django_migrations` VALUES (35, 'managementApp', '0014_student_average_score', '2024-01-02 12:59:11.380904');
INSERT INTO `django_migrations` VALUES (36, 'managementApp', '0016_merge_20231230_1932', '2024-01-02 12:59:11.385717');
INSERT INTO `django_migrations` VALUES (37, 'managementApp', '0017_student_comments', '2024-01-03 07:41:30.517397');
INSERT INTO `django_migrations` VALUES (38, 'managementApp', '0018_meeting_room', '2024-01-03 15:00:50.602268');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0f3u9xrzi3pu83vcqv52otn3wor303le', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeab:NpqAJf8DLEIXPHFO1Jemvgo6Y9f-yr3SawwwPv6TWV4', '2024-01-16 13:13:49.436826');
INSERT INTO `django_session` VALUES ('0sjm99b73ao25ah2own9d3vs74vrhc0l', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKvtt:JiQ-pEauhi67E2DPd-fJxAQuFKSmzFSiJ9Eovp3CwDE', '2024-01-17 07:42:53.078704');
INSERT INTO `django_session` VALUES ('12cizjjvkr864k06tqckeduietq5cxy2', '.eJxVjDsOwjAQBe_iGln-rR0o6TmDtfZucADZUpxUiLuTSCmgfTPz3iLiupS4dp7jROIijDj9bgnzk-sO6IH13mRudZmnJHdFHrTLWyN-XQ_376BgL1ttEwSwzpwZnQ5OAYMlykn7kRi0y2rUHgDdpgx-ILZZoUetORsIicTnC8v0N5Q:1rGh7r:lqYndKws8Z3BFDEudrcjHbvqssEdI5Ys_KJX8VtTSig', '2024-01-05 15:07:47.293419');
INSERT INTO `django_session` VALUES ('1zlcxf3aurcovrvmnwyx4kw2vxg0spn3', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rL3Er:Krt_GVlcPiAUiwpv42eUWtpRDRAAOhW5PvLYYRhbfKo', '2024-01-17 15:33:01.990717');
INSERT INTO `django_session` VALUES ('2ixa8kp3xl04rexs9jvuk9p50yrkzs5v', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKedH:qQOp3_ZnEfGgI7bI-mEnJB8Xd22yWKW9mTBx_D6wxGk', '2024-01-16 13:16:35.114808');
INSERT INTO `django_session` VALUES ('2rkkqrmhfdy10g4c3na649ob5gt5ki2s', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1at:5FrqqMJnZTyKj5P97Zxub5PWRmLu9sl5ppoMmQDBXH4', '2024-01-17 13:47:39.969924');
INSERT INTO `django_session` VALUES ('3esc8qnyjinglhcud1ev76pv7hjj2wco', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKeoa:ukUwrW5SHbxw0XFXhriDp5EQoamzEFcrbl_XUr3a6Sc', '2024-01-16 13:28:16.134163');
INSERT INTO `django_session` VALUES ('3kg2vin46fa22k2uz4eht24ubmmscfhr', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3js:76ltAZwmn5jqslDWkkLDy15Mz4PIpWMeCEeYhgoJsxk', '2024-01-17 16:05:04.988272');
INSERT INTO `django_session` VALUES ('4ludno6efrrzh4zze72iyihzst1bn3nx', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKraj:9n9IjLVnAPLEQFNLho2aIZtuZ3Od_bxl8IOe_96wp-Y', '2024-01-17 03:06:49.952149');
INSERT INTO `django_session` VALUES ('4pdyohs062vk50za03wcvy3mtghmq11a', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL3oT:hLInibxhHanTS7WJ3prNLTZDeFFZu8Vsjm9_RYwP5Rc', '2024-01-17 16:09:49.509153');
INSERT INTO `django_session` VALUES ('4ybr47oiqv1wdycihoy5mb58j62aidat', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rHLtC:HlHYAQ-FydzX_rGp0vRoIj28a2BjT2H2XqbRpC6x3_M', '2024-01-07 10:39:22.752963');
INSERT INTO `django_session` VALUES ('5bmeik8wrpf8hhgr1e6z0i7od65o0h40', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIM3W:7_19O8RxHsWUuYoQ-ujHQIVCJGYJ3fSNZ6Ba9VU2qXE', '2024-01-10 05:02:10.722075');
INSERT INTO `django_session` VALUES ('5cep95f1e7uiv34wtfm6dsx8iuzg0vbx', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1XV:4GGvaxCapczBn_aKN8nbiQu4rXydQawzh_yCkpXUmhY', '2024-01-17 13:44:09.293621');
INSERT INTO `django_session` VALUES ('5zy82d9vmk3k8asetzhdmeng8hwqbbjb', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rI0Ae:IVhwzT935gLw0ZuEF19J9EczcB3ZYiBqUP7A_AHzZOM', '2024-01-09 05:40:04.803084');
INSERT INTO `django_session` VALUES ('6wjn1v9otjb9msgn5kn3q0jg2fbzg1br', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rI1Wd:fTijFDclw-4gK3mov_25A3cP-T6c-9_j8f03QQPicco', '2024-01-09 07:06:51.838398');
INSERT INTO `django_session` VALUES ('8aq2hqavd93e0h7r6tpksqnp6tht204i', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIlRI:71lPmXeQwZvU4P2q4rf4f4qDmXlJy9i4qYxlYy6zoHA', '2024-01-11 08:08:24.307033');
INSERT INTO `django_session` VALUES ('8nmk8gfwesd3cwbglkzesfzv3pofovn7', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1Du:e8Eq1ETjuuDoJqexKdKSFm7kdjZrQf63QKunbhF2nwE', '2024-01-17 13:23:54.693440');
INSERT INTO `django_session` VALUES ('8wx8tedfn1wllmn1g4xbpbkwlys79wd6', '.eJxVjDsOwjAQBe_iGln-xR9Kes4QrXc3OIBsKU4qxN0hUgpo38y8lxhhW8u4dV7GmcRZGCVOv2MGfHDdCd2h3prEVtdlznJX5EG7vDbi5-Vw_w4K9PKtoyalA2THQIONHjUZxpyAg560txxUZPQUAZVKbG3IUwpuAGcQBiLx_gAbQji7:1rL1cZ:vB9peZgfDxMduWWYNPqwJCn7YnMaHJPA8TTbesba-Uk', '2024-01-17 13:49:23.677058');
INSERT INTO `django_session` VALUES ('8yh6fdg2i9ikxlmph4zu62254i214j4o', '.eJxVjDsOwjAQBe_iGln-rR0o6TmDtfZucADZUpxUiLuTSCmgfTPz3iLiupS4dp7jROIijDj9bgnzk-sO6IH13mRudZmnJHdFHrTLWyN-XQ_376BgL1ttEwSwzpwZnQ5OAYMlykn7kRi0y2rUHgDdpgx-ILZZoUetORsIicTnC8v0N5Q:1rG7aZ:cJ7xnDe_GhNozW8G8mc0ZcPMV8p2QSifNe7bDgxXl-Y', '2024-01-04 01:11:03.629332');
INSERT INTO `django_session` VALUES ('9fq0abnbziwlombi6579bnvl0ki1eym0', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL2vQ:f4mA3T0D_GtrXzvG4Mow4oXaUnGyG_SQkt98kGx8kVs', '2024-01-17 15:12:56.825805');
INSERT INTO `django_session` VALUES ('9hhbs8mljigqng21k1k45v0zc2aur7nu', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIfPq:EbOZ74fPjUY5kkD3Oz8q_Fuhnl2_PNYv9ecR5CgbuJQ', '2024-01-11 01:42:30.987138');
INSERT INTO `django_session` VALUES ('9mfgdi0tqhdzhz8vb6eq8zcq873xs2jq', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeeF:Xb2OQBUWrtF0UE6Xfd719Ejx65gaAKhXvnZHbPPs3kc', '2024-01-16 13:17:35.862199');
INSERT INTO `django_session` VALUES ('9yvbga44jdde38w91omtd8ciery0qlug', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3iw:wvOJjxqHBMdb4ICNwTigJ_cSyfsOptjXO6rzvoM2YDM', '2024-01-17 16:04:06.013880');
INSERT INTO `django_session` VALUES ('a37uaf1lao7rf4t838bg4qar08vo30py', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeoQ:muYf5vdtVXCSYMURvamnhDtIwh0wJ4vL9p94tcCovHk', '2024-01-16 13:28:06.434319');
INSERT INTO `django_session` VALUES ('aeibbd02h38lq7bq6vvceznxesj5eyzj', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1bg:KW1ukFzqfHPfOaCRZcYQDlSKoRdT6xB-ygTIvmOsljU', '2024-01-17 13:48:28.571678');
INSERT INTO `django_session` VALUES ('asqg0n733j19prdlbc384qcw7s02k7tw', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIf99:vw6qZvh5t8IX9XWFdo_9oeISqyp5GoHnQt5MA9t_NjM', '2024-01-11 01:25:15.411176');
INSERT INTO `django_session` VALUES ('bej2hx8drm5knijl4iuosi57d894t25s', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL3lK:Y2Wmg6Zk6iktrgdEpB--gC86PfA3zMcSmxVmqsA6utM', '2024-01-17 16:06:34.916561');
INSERT INTO `django_session` VALUES ('c4nignnwj5xp9d3byqcklq4jmn39m0xe', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIMop:vlL6CoO86GfSWasyohmaqM445vtla47a2n9Vw_aH0Q0', '2024-01-10 05:51:03.472304');
INSERT INTO `django_session` VALUES ('cz6auzxu8c0xl2mo3n6ia61cc7j3k4k8', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIeUW:S4grkBSny4s_GkEcdVPyIWQNH0ZXwJ6GvufSkZY3P04', '2024-01-11 00:43:16.322138');
INSERT INTO `django_session` VALUES ('d1xuu8b6o1fth2vqb4en4sehude1yfus', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL4N7:YSLmgTDvgWGKFJUhxmvTVHtblccygsYtAQEIhKFOSFA', '2024-01-17 16:45:37.219253');
INSERT INTO `django_session` VALUES ('dhlfgeeb68pczwrzr1q8edimauv33uzi', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rL3we:5GLVc9I-9FiH0ZmwR6FkANft-Nr467W7hRtiF70mVMg', '2024-01-17 16:18:16.407623');
INSERT INTO `django_session` VALUES ('eepg0j75oqlmi57xh2pq7q3e94ert1k8', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIfE7:K5q3myitghYlA7WZuOXsyg6xxWK5Lgp6u9BGi6v2IAo', '2024-01-11 01:30:23.777069');
INSERT INTO `django_session` VALUES ('et4nia5ofeg706635a772u40meq85ln4', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rL3bW:-Nb3bF_XnMoCOfnY6Rcl7e7UG_d8MPwu4tZDxJZOt00', '2024-01-17 15:56:26.207554');
INSERT INTO `django_session` VALUES ('fg4ajg3sha04lcegv200gjgub0hbmsp3', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rL3mI:vCf_TbnX05JjMDZoPiNXxsPZoP9w8yCKkQVUJk1nCn0', '2024-01-17 16:07:34.335376');
INSERT INTO `django_session` VALUES ('fsipd6emxjqth237ukk6v3mdhomlyvx0', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIMpE:5XF5xBO3VhlVc7s-lEmOaPBxe2KAzff-Ix17S7d5YFg', '2024-01-10 05:51:28.357344');
INSERT INTO `django_session` VALUES ('g5rcp5nd40y9sj6x895eboyq70qsqz31', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKedN:YaS_ufbxJdxMU1IgSoAv_EGiseW6rJBWsNBewwqramI', '2024-01-16 13:16:41.493839');
INSERT INTO `django_session` VALUES ('g97db4lmsdfih3wyfqtpanktojypbagr', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3aZ:MC2OPlK1a4e7nWrzZv3WInbGJMMzEW4Mor0qHYT8wwM', '2024-01-17 15:55:27.186046');
INSERT INTO `django_session` VALUES ('gtbtrvxvx3ai0iczn91hfexq60o6xtfj', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3vv:Zc43kINdsNo2ZLYfHA_eIweii_g-Sbd53RhpyODfCEQ', '2024-01-17 16:17:31.394337');
INSERT INTO `django_session` VALUES ('gxofu1joquwxercjguhfojwtisio380y', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIekd:BHPIUm3DcSNMlfoB4X-KJ81RxM7wnFnJ15W7GgUn4Mc', '2024-01-11 00:59:55.396698');
INSERT INTO `django_session` VALUES ('hztv2mvxirt2v0xyl6xhs55aope6vkyo', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKeO0:UBfERf2ddIGoAhFyHxOM0YePOK1HtGXB9mjNO87nHLc', '2024-01-16 13:00:48.088664');
INSERT INTO `django_session` VALUES ('i68eh3p6ay1ix6eko8d9puv3gc8tekiz', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1FG:1ek1paVvdmuZ2oCPCZOfVcpE5-A5AA804OyU0LU8IgU', '2024-01-17 13:25:18.440542');
INSERT INTO `django_session` VALUES ('ih2hvk31fmo1t0ttsk81qgcn0qjrglgk', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeNi:0V-OhCbdWGoQEs1HaHsCxuOPMbJ-opZmFI0i9XKdzNQ', '2024-01-16 13:00:30.249215');
INSERT INTO `django_session` VALUES ('iq7tvpkoo41xtb7eqv96nts6bnw0s1ws', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIXNM:4Nxycp5EXu1Wtf4bwfcE-zmDSnnlXI4f7N1rH3DeRZM', '2024-01-10 17:07:24.903789');
INSERT INTO `django_session` VALUES ('keb24wnp4rusydhheiy0togj8eu19sgc', '.eJxVjDsOwjAQBe_iGln-xR9Kes4QrXc3OIBsKU4qxN0hUgpo38y8lxhhW8u4dV7GmcRZGCVOv2MGfHDdCd2h3prEVtdlznJX5EG7vDbi5-Vw_w4K9PKtoyalA2THQIONHjUZxpyAg560txxUZPQUAZVKbG3IUwpuAGcQBiLx_gAbQji7:1rL1bH:eVzMkZGph_Bb88LSqQb8u2_091u-s2BJS1kNlpiJitw', '2024-01-17 13:48:03.133754');
INSERT INTO `django_session` VALUES ('kpja5690l8x6mkyacyl7wxi9pz31ua8p', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIeB6:TVBYdlWeZab0aTbTS2fV2Pxaspr2-kSJbTvVh3p2r1o', '2024-01-11 00:23:12.609110');
INSERT INTO `django_session` VALUES ('l3ptsl1vp2c7nfx68caiqrhgj04ick8c', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIelg:NlYiDvS-fPkrxYW9lJrGgCrI5O65wfCGPwzCphk5BwA', '2024-01-11 01:01:00.182078');
INSERT INTO `django_session` VALUES ('ldy2f61psim7e43pgpe05pta236ownas', '.eJxVjDsOwjAQBe_iGln-xR9Kes4QrXc3OIBsKU4qxN0hUgpo38y8lxhhW8u4dV7GmcRZGCVOv2MGfHDdCd2h3prEVtdlznJX5EG7vDbi5-Vw_w4K9PKtoyalA2THQIONHjUZxpyAg560txxUZPQUAZVKbG3IUwpuAGcQBiLx_gAbQji7:1rL1aN:3gIaQANdsmwTzSnsPCLO6b9TSwaUuUyxgCmRWSnDnSg', '2024-01-17 13:47:07.632313');
INSERT INTO `django_session` VALUES ('lon8rkkvtqdmsunhrcwtitsrh9dvmzy6', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL1cj:jC_hzyyLu_ovLV41LqYBKX0biuRx0qiSyGaeve8Fsqw', '2024-01-17 13:49:33.354681');
INSERT INTO `django_session` VALUES ('mfn7mio0bgrkuqbzoosp011nzc11anq3', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL4Jo:Vx3i9QfI3TBEABa_H34zxeULn7vL64ar7WeaXI3-34o', '2024-01-17 16:42:12.672780');
INSERT INTO `django_session` VALUES ('mm71mq4ugz13pqm9id9zn2tgs32go4yb', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIMqC:1o9hIto1IXGxpFu-rjDH2JVa_YXHJ8SMEq_6NKyIfi8', '2024-01-10 05:52:28.946725');
INSERT INTO `django_session` VALUES ('n6iqpkfvjtfmilcep5m579ygaz4qavx7', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKvtK:CwIZ6X6JLPBMsmNJfAaIAYvIyMGDUiL4yW_QKbtCJYY', '2024-01-17 07:42:18.389913');
INSERT INTO `django_session` VALUES ('n9ntbessvsypf28yt8jo8k4j3yeew7ai', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKee3:V3d8WWXwnE_0VGtn_v123H8xZeYQ_9MkU6Ms2zIe1PQ', '2024-01-16 13:17:23.415059');
INSERT INTO `django_session` VALUES ('nnfuv0clibr7ql6necbdxvlc7c2nf6wl', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIW9r:SNhAaRT0p829_CZhR3CqQI5T3HjSpgnwft-vWobm7Jg', '2024-01-10 15:49:23.428149');
INSERT INTO `django_session` VALUES ('nynojj0kd46xvmemlzplunv4kfkt0hkq', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL3ls:zsDAZgv5JoFUV2kESLilavVWMWMoAcMV58b01Txk4VU', '2024-01-17 16:07:08.470800');
INSERT INTO `django_session` VALUES ('obt0uuv0gcoeu08qt61ajy5mbgtq0a3h', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIlhD:xaNSX0xUtcYw5J0fPmaJxeeFPLFBNqosoPCgzulbON4', '2024-01-11 08:24:51.413502');
INSERT INTO `django_session` VALUES ('op896quhqo3o2qg4wk2xe2ghszf2kwcd', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIMAm:uU86vwD3TsexbyEDg0l8vgufw1bLCCXPXVteH8wTvz8', '2024-01-10 05:09:40.859447');
INSERT INTO `django_session` VALUES ('orfgew679rw8seg82safr572tyakl0sw', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIfU2:2j0idaxItKbRec1wV67fq8R63gS3IwaeRJIhmblYHbM', '2024-01-11 01:46:50.197735');
INSERT INTO `django_session` VALUES ('q3sdnefibivq45bpcopznxhnp2dccn5r', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3hH:SreiJve-OSulZShy_qGKjJl2td3oQblavEJhJt1F2fY', '2024-01-17 16:02:23.425605');
INSERT INTO `django_session` VALUES ('r31v6qnav2wmigy8ywrs89a7ax4zr75b', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL48Q:3syYFCUSrXSy_sy9EXXVE3XijNZHjWUOWoOzmHCZ6D8', '2024-01-17 16:30:26.251628');
INSERT INTO `django_session` VALUES ('sap69tt202gpubjpfxh2q2q7mmmmc5w7', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL2Rv:dHeKh1rJ5GTpgVZ3lNp2z512xtQVYpZNoX3NWFMod6E', '2024-01-17 14:42:27.175459');
INSERT INTO `django_session` VALUES ('sr7reuvzqtf9s5nm6nqfxw82jl9y9wi7', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeaw:DaCR6AcuX9vBGF7uGUxmhIgdEQrIcXBuD1yY1rO60nM', '2024-01-16 13:14:10.882348');
INSERT INTO `django_session` VALUES ('strjiwray73yjcp75hp65l6s7elm9smy', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIlpS:BZzfubjVVuWl6HJjDD-1lxz7GYBIs6uJPqS_u0RgCls', '2024-01-11 08:33:22.744302');
INSERT INTO `django_session` VALUES ('t8du1hx2ggt53cevjbjt4v8xm60cbgo7', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rIf3H:I1bHbbD2CoZL4yts00okC5mVO2oEEI2AdSb9AzS7iwc', '2024-01-11 01:19:11.328140');
INSERT INTO `django_session` VALUES ('u255bxexidq775viss8h3j0pfqljkz46', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL4JS:uAKmGd0b0wxcMw3C76dZzanKpGX1ak1C4uxSNk1zwTI', '2024-01-17 16:41:50.261506');
INSERT INTO `django_session` VALUES ('upq24nv06au2kjj93co1zomydcndr6d1', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL102:zRr_-g86MUVP4kUJClipbvRtCBj1G2CPsT9sL4o0uOA', '2024-01-17 13:09:34.684132');
INSERT INTO `django_session` VALUES ('vw8qowg26w9x3ab0spv243pyhm1aiz0n', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIj5S:Oqtj-wO-q2UVr4E0bW2WIt0G4kVyG6DffXVj_rUFD0A', '2024-01-11 05:37:42.189660');
INSERT INTO `django_session` VALUES ('w6nchcmdsp059yp54f0ntmyltbzprnwx', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3jd:1FPOThVxZWDBPw14GIN6mUGGWnZHY4sCBoR27jx51z0', '2024-01-17 16:04:49.932816');
INSERT INTO `django_session` VALUES ('w8qn9nti254enjpvcnhpg8bn8svyrdju', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rIezc:BHpw53iNdZq5hNET6zWDjNliOTdJd1lG2I1snIjK14w', '2024-01-11 01:15:24.982788');
INSERT INTO `django_session` VALUES ('x6q0uo91y82hj8qyufdftji20ag7qmzc', '.eJxVjMsOwiAUBf-FtSGXN7h0328gXB5SNZCUdmX8d9ukC93OzDlv4sO2Vr-NvPg5kSthjlx-IYb4zO0w6RHavdPY27rMSI-EnnbQqaf8up3t30ENo-5rV5IEiCASt4ZzhyBsFgqFRmaELIDZWFa02kEG0AEkKO2wSAbWOEs-X-QlNrU:1rKeOD:ITMirrURkixakMnzhfLsY41-rIjOPrDAHU7J2AziKNI', '2024-01-16 13:01:01.791974');
INSERT INTO `django_session` VALUES ('x8t4dfnmznvi8y8p3iz0rizx21elf4tu', '.eJxVjDEOwjAMRe-SGUVxVNcOIztnqOzEpQXUSk07Ie4OlTrA-t97_-U62dah26ot3Vjc2QG60--okh827aTcZbrNPs_Tuozqd8UftPrrXOx5Ody_g0Hq8K0zSwMYKBIE4hiLITcApiioYBYQW2IyNW4wU2jBgnBKSUx77tW9P-GIN7I:1rL3jW:Lj90e4dmuf409aeo0Ec-SuLH7VT1mKeBrarP2Ctob5U', '2024-01-17 16:04:42.198767');
INSERT INTO `django_session` VALUES ('y4n2ei92rekolhciqavq2d4ugxb4eyyt', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeVp:ymKlIuTc-VTuQa29RLh-oGmlZxdV6EeNMwOaCff2km0', '2024-01-16 13:08:53.365233');
INSERT INTO `django_session` VALUES ('y6nywq8ojfh4givmbry2pzek8j53jgbn', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rKeeg:aypbgNFi5Gfh-xUZtNN-N9PHKnOYNMT371G1527uXsg', '2024-01-16 13:18:02.154389');
INSERT INTO `django_session` VALUES ('yq07kbc8ia6uwudtw6b7zm9xm3a9ft0z', '.eJxVjMEOwiAQRP-FsyELLSv16N1vIAu7SNXQpLQn47_bJj3obTLvzbxVoHUpYW0yh5HVRfXq9NtFSk-pO-AH1fuk01SXeYx6V_RBm75NLK_r4f4dFGplW6N1Fk2GnBLCEDtLvKWIlMmLx4xmwOwdg-3PYJxliJaExSf0QJ1Rny_pcTf3:1rL2KX:BkuUvzmO2qYRKTLRq_cN0GqUZF04hUlq6MxBCSA0qt0', '2024-01-17 14:34:49.400113');
INSERT INTO `django_session` VALUES ('z56utiufr9q15zo5ccrq18vb2hj00odf', '.eJxVjDsOwjAQBe_iGln-xR9Kes4QrXc3OIBsKU4qxN0hUgpo38y8lxhhW8u4dV7GmcRZGCVOv2MGfHDdCd2h3prEVtdlznJX5EG7vDbi5-Vw_w4K9PKtoyalA2THQIONHjUZxpyAg560txxUZPQUAZVKbG3IUwpuAGcQBiLx_gAbQji7:1rL1F5:pboej64UfJByb-YEIVoNrbfm3rWNgg8n334arfbePEY', '2024-01-17 13:25:07.703541');
INSERT INTO `django_session` VALUES ('zj3bikpwd3kxhndgeuq4m7a8g0c4d042', '.eJxVjDsOwjAQBe_iGln-rR0o6TmDtfZucADZUpxUiLuTSCmgfTPz3iLiupS4dp7jROIijDj9bgnzk-sO6IH13mRudZmnJHdFHrTLWyN-XQ_376BgL1ttEwSwzpwZnQ5OAYMlykn7kRi0y2rUHgDdpgx-ILZZoUetORsIicTnC8v0N5Q:1rGa7T:X1ArnMnPdiPwrQ_kdnvlDUcCUcdLnJE-BiuvI6kD5-A', '2024-01-05 07:38:55.524404');

-- ----------------------------
-- Table structure for managementapp_course
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_course`;
CREATE TABLE `managementapp_course`  (
  `course_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `credit` int NOT NULL,
  `credit_hours` int NOT NULL,
  `dept_id_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `normal_score_percent` double NOT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `managementApp_course_dept_id_id_f1971c0b_fk_managemen`(`dept_id_id`) USING BTREE,
  CONSTRAINT `managementApp_course_dept_id_id_f1971c0b_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_course
-- ----------------------------
INSERT INTO `managementapp_course` VALUES ('01', '高级语言程序设计', 1, 20, '01', 0.7);
INSERT INTO `managementapp_course` VALUES ('02', '数理逻辑', 2, 30, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('03', '组合数学', 2, 20, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('04', '计算机组成原理', 4, 20, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('05', '操作系统', 2, 40, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('06', '数据结构与算法', 3, 20, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('07', '人工智能原理', 1, 20, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('08', '编译原理', 2, 30, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('09', '面向对象', 3, 40, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('10', '机器学习', 5, 40, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('11', '模式识别', 5, 25, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('12', '数据挖掘', 1, 25, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('13', '区块链技术', 2, 40, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('14', '计算机安全与保密技术', 1, 20, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('15', '密码学', 1, 25, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('16', '智能控制', 1, 40, '01', 0.6);
INSERT INTO `managementapp_course` VALUES ('17', '电影鉴赏', 2, 40, '02', 0.4);
INSERT INTO `managementapp_course` VALUES ('18', '摄影艺术', 2, 35, '02', 0.3);
INSERT INTO `managementapp_course` VALUES ('19', '西方艺术史', 1, 20, '03', 0.4);
INSERT INTO `managementapp_course` VALUES ('20', '国画鉴赏', 5, 30, '03', 0.4);
INSERT INTO `managementapp_course` VALUES ('21', '美丽人生', 1, 30, '03', 0.2);
INSERT INTO `managementapp_course` VALUES ('22', '统计学', 2, 25, '04', 0.2);
INSERT INTO `managementapp_course` VALUES ('23', '会计学', 3, 40, '04', 0.3);
INSERT INTO `managementapp_course` VALUES ('24', '国际贸易', 3, 25, '04', 0.3);
INSERT INTO `managementapp_course` VALUES ('25', '基础力学', 4, 40, '05', 0.3);
INSERT INTO `managementapp_course` VALUES ('26', '概率论', 2, 20, '05', 0.3);
INSERT INTO `managementapp_course` VALUES ('27', '基础化学', 1, 20, '05', 0.3);
INSERT INTO `managementapp_course` VALUES ('28', '临床医学', 2, 35, '06', 0.3);
INSERT INTO `managementapp_course` VALUES ('29', '解剖学', 5, 40, '06', 0.3);
INSERT INTO `managementapp_course` VALUES ('30', '病理学', 3, 30, '06', 0.3);

-- ----------------------------
-- Table structure for managementapp_course_request
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_course_request`;
CREATE TABLE `managementapp_course_request`  (
  `course_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `credit` int NOT NULL,
  `credit_hours` int NOT NULL,
  `dept_id_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `normal_score_percent` double NOT NULL,
  `staff_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`course_id`) USING BTREE,
  INDEX `managementApp_course_request_dept_id_id_71037720`(`dept_id_id`) USING BTREE,
  INDEX `managementApp_course_request_staff_id_id_39aa7efd`(`staff_id_id`) USING BTREE,
  CONSTRAINT `managementApp_course_dept_id_id_71037720_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_course_staff_id_id_39aa7efd_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_course_request
-- ----------------------------

-- ----------------------------
-- Table structure for managementapp_course_selection
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_course_selection`;
CREATE TABLE `managementapp_course_selection`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `semester` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `normal_score` double NULL DEFAULT NULL,
  `test_score` double NULL DEFAULT NULL,
  `total_score` double NULL DEFAULT NULL,
  `course_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `staff_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `student_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `open_course_id_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `managementApp_course_sel_student_id_id_course_id__4f14cb2b_uniq`(`student_id_id`, `course_id_id`, `semester`) USING BTREE,
  INDEX `managementApp_course_course_id_id_630d117c_fk_managemen`(`course_id_id`) USING BTREE,
  INDEX `managementApp_course_staff_id_id_38d8e48e_fk_managemen`(`staff_id_id`) USING BTREE,
  INDEX `managementApp_course_open_course_id_id_57859093_fk_managemen`(`open_course_id_id`) USING BTREE,
  CONSTRAINT `managementApp_course_course_id_id_630d117c_fk_managemen` FOREIGN KEY (`course_id_id`) REFERENCES `managementapp_course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_course_open_course_id_id_57859093_fk_managemen` FOREIGN KEY (`open_course_id_id`) REFERENCES `managementapp_open_course` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_course_staff_id_id_38d8e48e_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_course_student_id_id_2f0650d4_fk_managemen` FOREIGN KEY (`student_id_id`) REFERENCES `managementapp_student` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_course_selection
-- ----------------------------
INSERT INTO `managementapp_course_selection` VALUES (44, '2023-2024春', NULL, NULL, 0, '01', '3', 's1', 1);
INSERT INTO `managementapp_course_selection` VALUES (45, '2023-2024春', NULL, NULL, 0, '01', '3', 's2', 1);
INSERT INTO `managementapp_course_selection` VALUES (46, '2023-2024春', NULL, NULL, 0, '01', '3', 's3', 1);
INSERT INTO `managementapp_course_selection` VALUES (47, '2023-2024春', NULL, NULL, 0, '01', '3', 's4', 1);
INSERT INTO `managementapp_course_selection` VALUES (48, '2023-2024春', NULL, NULL, 0, '01', '3', 's5', 1);
INSERT INTO `managementapp_course_selection` VALUES (49, '2023-2024春', NULL, NULL, 0, '01', '3', 's6', 1);
INSERT INTO `managementapp_course_selection` VALUES (50, '2023-2024春', NULL, NULL, 0, '01', '3', 's7', 1);
INSERT INTO `managementapp_course_selection` VALUES (51, '2023-2024春', NULL, NULL, 0, '01', '3', 's8', 1);
INSERT INTO `managementapp_course_selection` VALUES (52, '2023-2024春', NULL, NULL, 0, '01', '3', 's9', 1);
INSERT INTO `managementapp_course_selection` VALUES (53, '2023-2024春', NULL, NULL, 0, '01', '3', 's10', 1);
INSERT INTO `managementapp_course_selection` VALUES (54, '2023-2024春', NULL, NULL, 0, '01', '3', 's11', 1);
INSERT INTO `managementapp_course_selection` VALUES (55, '2023-2024春', NULL, NULL, 0, '01', '3', 's12', 1);
INSERT INTO `managementapp_course_selection` VALUES (56, '2023-2024春', NULL, NULL, 0, '01', '3', 's13', 1);
INSERT INTO `managementapp_course_selection` VALUES (57, '2023-2024春', NULL, NULL, 0, '01', '3', 's14', 1);
INSERT INTO `managementapp_course_selection` VALUES (58, '2023-2024春', NULL, NULL, 0, '01', '3', 's15', 1);
INSERT INTO `managementapp_course_selection` VALUES (59, '2023-2024春', NULL, NULL, 0, '01', '3', 's16', 1);
INSERT INTO `managementapp_course_selection` VALUES (60, '2023-2024春', NULL, NULL, 0, '01', '3', 's17', 1);
INSERT INTO `managementapp_course_selection` VALUES (61, '2023-2024春', NULL, NULL, 0, '01', '3', 's18', 1);
INSERT INTO `managementapp_course_selection` VALUES (62, '2023-2024春', NULL, NULL, 0, '01', '3', 's19', 1);
INSERT INTO `managementapp_course_selection` VALUES (63, '2023-2024春', NULL, NULL, 0, '01', '3', 's20', 1);
INSERT INTO `managementapp_course_selection` VALUES (64, '2023-2024春', NULL, NULL, 0, '01', '3', 's21', 1);
INSERT INTO `managementapp_course_selection` VALUES (65, '2023-2024春', NULL, NULL, 0, '01', '3', 's22', 1);
INSERT INTO `managementapp_course_selection` VALUES (66, '2023-2024春', NULL, NULL, 0, '01', '3', 's23', 1);
INSERT INTO `managementapp_course_selection` VALUES (67, '2023-2024春', NULL, NULL, 0, '02', '2', 's33', 4);
INSERT INTO `managementapp_course_selection` VALUES (68, '2023-2024春', NULL, NULL, 0, '02', '2', 's34', 4);
INSERT INTO `managementapp_course_selection` VALUES (69, '2023-2024春', NULL, NULL, 0, '02', '2', 's35', 4);
INSERT INTO `managementapp_course_selection` VALUES (70, '2023-2024春', NULL, NULL, 0, '02', '2', 's36', 4);
INSERT INTO `managementapp_course_selection` VALUES (71, '2023-2024春', NULL, NULL, 0, '03', '1', 's1', 5);
INSERT INTO `managementapp_course_selection` VALUES (72, '2023-2024春', NULL, NULL, 0, '03', '1', 's2', 5);
INSERT INTO `managementapp_course_selection` VALUES (73, '2023-2024春', NULL, NULL, 0, '03', '1', 's7', 5);
INSERT INTO `managementapp_course_selection` VALUES (74, '2023-2024春', NULL, NULL, 0, '04', '1', 's1', 6);

-- ----------------------------
-- Table structure for managementapp_department
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_department`;
CREATE TABLE `managementapp_department`  (
  `dept_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `dept_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`dept_id`) USING BTREE,
  UNIQUE INDEX `address`(`address`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_department
-- ----------------------------
INSERT INTO `managementapp_department` VALUES ('01', '计算机学院', '上大东校区三号楼', '58792042');
INSERT INTO `managementapp_department` VALUES ('02', '电影学院', 'Rt Shanghai', '58927593');
INSERT INTO `managementapp_department` VALUES ('03', '美术学院', '美术馆', '58294752');
INSERT INTO `managementapp_department` VALUES ('04', '经管学院', '经管楼', '59207482');
INSERT INTO `managementapp_department` VALUES ('05', '理学院', '理学院楼', '58827564');
INSERT INTO `managementapp_department` VALUES ('06', '医学院', '校医院', '55999223');

-- ----------------------------
-- Table structure for managementapp_meeting_room
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_meeting_room`;
CREATE TABLE `managementapp_meeting_room`  (
  `room_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `room_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `room_size` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `min_number` int NOT NULL,
  `status` tinyint(1) NOT NULL,
  `time_range` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_meeting_room
-- ----------------------------
INSERT INTO `managementapp_meeting_room` VALUES ('1', 'A', 'large', 15, 0, NULL);
INSERT INTO `managementapp_meeting_room` VALUES ('2', 'B', 'medium', 10, 0, NULL);
INSERT INTO `managementapp_meeting_room` VALUES ('3', 'C', 'medium', 10, 0, NULL);
INSERT INTO `managementapp_meeting_room` VALUES ('4', 'D', 'small', 2, 0, NULL);
INSERT INTO `managementapp_meeting_room` VALUES ('5', 'E', 'small', 2, 0, NULL);
INSERT INTO `managementapp_meeting_room` VALUES ('6', 'F', 'small', 2, 0, NULL);

-- ----------------------------
-- Table structure for managementapp_open_course
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_open_course`;
CREATE TABLE `managementapp_open_course`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `semester` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `class_time` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `staff_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `capacity` int NOT NULL,
  `used_capacity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `managementApp_open_cours_semester_course_id_id_st_678dcbe0_uniq`(`semester`, `course_id_id`, `staff_id_id`, `class_time`) USING BTREE,
  INDEX `managementApp_open_c_course_id_id_5711f03f_fk_managemen`(`course_id_id`) USING BTREE,
  INDEX `managementApp_open_c_staff_id_id_f4f1cfe2_fk_managemen`(`staff_id_id`) USING BTREE,
  CONSTRAINT `managementApp_open_c_course_id_id_5711f03f_fk_managemen` FOREIGN KEY (`course_id_id`) REFERENCES `managementapp_course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_open_c_staff_id_id_f4f1cfe2_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_open_course
-- ----------------------------
INSERT INTO `managementapp_open_course` VALUES (1, '2023-2024春', '一1-2', '01', '3', 27, 23);
INSERT INTO `managementapp_open_course` VALUES (2, '2023-2024春', '二1-2', '01', '3', 23, 1);
INSERT INTO `managementapp_open_course` VALUES (3, '2023-2024春', '三1-2', '01', '2', 35, 0);
INSERT INTO `managementapp_open_course` VALUES (4, '2023-2024春', '四1-2', '02', '2', 25, 4);
INSERT INTO `managementapp_open_course` VALUES (5, '2023-2024春', '五1-2', '03', '1', 22, 3);
INSERT INTO `managementapp_open_course` VALUES (6, '2023-2024春', '一3-4', '04', '1', 36, 1);
INSERT INTO `managementapp_open_course` VALUES (7, '2023-2024春', '二3-4', '05', '1', 29, 0);
INSERT INTO `managementapp_open_course` VALUES (8, '2023-2024春', '四1-2', '06', '1', 21, 0);
INSERT INTO `managementapp_open_course` VALUES (9, '2023-2024春', '四3-4', '07', '2', 38, 0);
INSERT INTO `managementapp_open_course` VALUES (10, '2023-2024春', '五3-4', '08', '2', 23, 0);
INSERT INTO `managementapp_open_course` VALUES (11, '2023-2024春', '一5-6', '09', '3', 25, 0);
INSERT INTO `managementapp_open_course` VALUES (12, '2023-2024春', '二5-6', '10', '3', 37, 0);
INSERT INTO `managementapp_open_course` VALUES (13, '2023-2024春', '三5-6', '11', '3', 26, 0);
INSERT INTO `managementapp_open_course` VALUES (14, '2023-2024春', '四5-6', '12', '1', 22, 0);
INSERT INTO `managementapp_open_course` VALUES (15, '2023-2024春', '五5-6', '13', '2', 31, 0);
INSERT INTO `managementapp_open_course` VALUES (16, '2023-2024春', '一7-8', '14', '2', 29, 0);
INSERT INTO `managementapp_open_course` VALUES (17, '2023-2024春', '二7-8', '15', '2', 34, 0);
INSERT INTO `managementapp_open_course` VALUES (18, '2023-2024春', '二7-8', '16', '2', 22, 0);
INSERT INTO `managementapp_open_course` VALUES (19, '2023-2024秋', '一1-2', '17', '5', 28, 0);
INSERT INTO `managementapp_open_course` VALUES (20, '2023-2024秋', '二1-2', '18', '5', 33, 0);
INSERT INTO `managementapp_open_course` VALUES (21, '2023-2024秋', '三1-2', '19', '6', 21, 0);
INSERT INTO `managementapp_open_course` VALUES (22, '2023-2024秋', '四1-2', '20', '6', 28, 0);
INSERT INTO `managementapp_open_course` VALUES (23, '2023-2024秋', '五1-2', '21', '7', 39, 0);
INSERT INTO `managementapp_open_course` VALUES (24, '2023-2024秋', '一3-4', '22', '8', 26, 0);
INSERT INTO `managementapp_open_course` VALUES (25, '2023-2024秋', '二3-4', '23', '8', 35, 0);
INSERT INTO `managementapp_open_course` VALUES (26, '2023-2024秋', '二3-4', '24', '9', 37, 0);
INSERT INTO `managementapp_open_course` VALUES (27, '2023-2024秋', '三3-4', '25', '10', 38, 0);
INSERT INTO `managementapp_open_course` VALUES (28, '2023-2024秋', '四3-4', '26', '10', 39, 0);
INSERT INTO `managementapp_open_course` VALUES (29, '2023-2024秋', '五3-4', '27', '10', 21, 0);
INSERT INTO `managementapp_open_course` VALUES (30, '2023-2024秋', '一7-8', '27', '11', 32, 0);
INSERT INTO `managementapp_open_course` VALUES (31, '2023-2024秋', '五3-4', '27', '11', 36, 0);
INSERT INTO `managementapp_open_course` VALUES (32, '2023-2024秋', '三7-8', '26', '11', 24, 2);

-- ----------------------------
-- Table structure for managementapp_student
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_student`;
CREATE TABLE `managementapp_student`  (
  `student_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date_of_birth` date NULL DEFAULT NULL,
  `native_place` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `mobile_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `average_gpa` double NULL DEFAULT NULL,
  `total_credit` double NULL DEFAULT NULL,
  `dept_id_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id_id` int NOT NULL,
  `average_score` double NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`) USING BTREE,
  INDEX `managementApp_studen_dept_id_id_08497e27_fk_managemen`(`dept_id_id`) USING BTREE,
  INDEX `managementApp_student_user_id_id_31d3f1d9_fk_auth_user_id`(`user_id_id`) USING BTREE,
  CONSTRAINT `managementApp_studen_dept_id_id_08497e27_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_student_user_id_id_31d3f1d9_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_student
-- ----------------------------
INSERT INTO `managementapp_student` VALUES ('20000000', '测试3', '女', '2023-12-01', '陕西', '19881888188', 5, 100, '01', 19, NULL);
INSERT INTO `managementapp_student` VALUES ('21111111', '测试', '男', '2023-12-21', NULL, '100', 4, 100, '01', 4, NULL);
INSERT INTO `managementapp_student` VALUES ('s1', '张同学', '女', '2002-01-22', '上海', '13393782345', NULL, NULL, '01', 30, NULL);
INSERT INTO `managementapp_student` VALUES ('s10', '卜翔厅', '女', '2023-05-16', '上海', '', NULL, NULL, '01', 39, NULL);
INSERT INTO `managementapp_student` VALUES ('s11', '艾尺帆', '女', '2024-01-03', '上海', '', NULL, NULL, '01', 40, NULL);
INSERT INTO `managementapp_student` VALUES ('s12', '艾氺娇', '女', '2024-01-08', '上海', '', NULL, NULL, '01', 41, NULL);
INSERT INTO `managementapp_student` VALUES ('s13', '艾友西', '女', '2024-01-07', '上海', '', NULL, NULL, '01', 42, NULL);
INSERT INTO `managementapp_student` VALUES ('s14', '艾率格', '男', '2015-01-05', '天津', '', NULL, NULL, '02', 43, NULL);
INSERT INTO `managementapp_student` VALUES ('s15', '艾唐哲', '女', '2015-01-20', '天津', '', NULL, NULL, '02', 44, NULL);
INSERT INTO `managementapp_student` VALUES ('s16', '艾湾', '女', '2024-01-09', '天津', '', NULL, NULL, '02', 45, NULL);
INSERT INTO `managementapp_student` VALUES ('s17', '赵童学', '女', '2011-01-18', '吉林', '', NULL, NULL, '02', 46, NULL);
INSERT INTO `managementapp_student` VALUES ('s18', '或同学', '女', '2006-01-10', '黑龙江', '', NULL, NULL, '03', 47, NULL);
INSERT INTO `managementapp_student` VALUES ('s19', '习同学', '女', '2002-01-16', '浙江', '', NULL, NULL, '04', 48, NULL);
INSERT INTO `managementapp_student` VALUES ('s2', '李同学', '女', '2002-12-27', '上海', '12345678765', NULL, NULL, '01', 31, NULL);
INSERT INTO `managementapp_student` VALUES ('s20', '南通学', '女', '2005-01-11', '浙江', '', NULL, NULL, '04', 49, NULL);
INSERT INTO `managementapp_student` VALUES ('s21', '女童学', '男', '2006-01-23', '浙江', '', NULL, NULL, '03', 50, NULL);
INSERT INTO `managementapp_student` VALUES ('s22', '司同学', '女', '2005-01-18', '浙江', '', NULL, NULL, '03', 51, NULL);
INSERT INTO `managementapp_student` VALUES ('s23', '大同学', '女', '2008-01-14', '北京', '', NULL, NULL, '04', 52, NULL);
INSERT INTO `managementapp_student` VALUES ('s24', '小同学', '男', '2001-01-08', '北京', '', NULL, NULL, '05', 53, NULL);
INSERT INTO `managementapp_student` VALUES ('s25', '中同学', '男', '2003-01-20', '北京', '', NULL, NULL, '05', 54, NULL);
INSERT INTO `managementapp_student` VALUES ('s26', '大大同学', '女', '2005-01-18', '北京', '', NULL, NULL, '06', 55, NULL);
INSERT INTO `managementapp_student` VALUES ('s27', '小小同学', '女', '2015-01-14', '北京', '', NULL, NULL, '06', 56, NULL);
INSERT INTO `managementapp_student` VALUES ('s28', '大小同学', '男', '2012-01-17', '北京', '', NULL, NULL, '06', 57, NULL);
INSERT INTO `managementapp_student` VALUES ('s29', '小大同学', '女', '2009-01-06', '北京', '', NULL, NULL, '01', 58, NULL);
INSERT INTO `managementapp_student` VALUES ('s3', '王同学', '女', '2023-01-09', '上海', '', NULL, NULL, '01', 32, NULL);
INSERT INTO `managementapp_student` VALUES ('s30', '后同学', '女', '2014-01-07', '北京', '', NULL, NULL, '02', 59, NULL);
INSERT INTO `managementapp_student` VALUES ('s31', '就同学', '男', '2007-01-16', '福建', '', NULL, NULL, '02', 60, NULL);
INSERT INTO `managementapp_student` VALUES ('s32', '那同学', '女', '2007-01-15', '黑龙江', '', NULL, NULL, '04', 61, NULL);
INSERT INTO `managementapp_student` VALUES ('s33', '安同学', '女', '2014-01-15', '黑龙江', '', NULL, NULL, '03', 62, NULL);
INSERT INTO `managementapp_student` VALUES ('s34', '娜同学', '女', '2010-01-13', '辽宁', '', NULL, NULL, '01', 63, NULL);
INSERT INTO `managementapp_student` VALUES ('s35', '好同学', '女', '2005-01-04', '河北', '', NULL, NULL, '03', 64, NULL);
INSERT INTO `managementapp_student` VALUES ('s36', '好好同学', '女', '2006-01-12', '河北', '', NULL, NULL, '02', 65, NULL);
INSERT INTO `managementapp_student` VALUES ('s37', '豪同学', '女', '2004-01-30', '河北', '', NULL, NULL, '02', 66, NULL);
INSERT INTO `managementapp_student` VALUES ('s38', '怀同学', '男', '1996-01-01', '缅甸', '', NULL, NULL, '03', 67, NULL);
INSERT INTO `managementapp_student` VALUES ('s39', '从同学', '男', '2010-01-12', '湖北', '', NULL, NULL, '03', 68, NULL);
INSERT INTO `managementapp_student` VALUES ('s4', '迟早早', '女', '2024-01-08', '上海', '', NULL, NULL, '01', 33, NULL);
INSERT INTO `managementapp_student` VALUES ('s40', '分同学', '男', '2006-01-03', '河南', '', NULL, NULL, '01', 69, NULL);
INSERT INTO `managementapp_student` VALUES ('s41', '阿达同学', '男', '2011-12-27', '新建', '', NULL, NULL, '05', 70, NULL);
INSERT INTO `managementapp_student` VALUES ('s42', '是同学', '男', '2013-01-23', '河南', '', NULL, NULL, '06', 71, NULL);
INSERT INTO `managementapp_student` VALUES ('s43', '视同学', '女', '2015-01-12', '上海', '', NULL, NULL, '01', 72, NULL);
INSERT INTO `managementapp_student` VALUES ('s5', '卜翔启', '男', '2024-01-01', '上海', '', NULL, NULL, '01', 34, NULL);
INSERT INTO `managementapp_student` VALUES ('s6', '卜翔尚', '女', '2024-01-12', '', '', NULL, NULL, '01', 35, NULL);
INSERT INTO `managementapp_student` VALUES ('s7', '卜翔学', '女', '2024-01-15', '上海', '', NULL, NULL, '01', 36, NULL);
INSERT INTO `managementapp_student` VALUES ('s8', '卜翔磊', '女', '2024-01-07', '上海', '', NULL, NULL, '01', 37, NULL);
INSERT INTO `managementapp_student` VALUES ('s9', '卜翔霍', '女', '2024-01-08', '上海', '', NULL, NULL, '01', 38, NULL);

-- ----------------------------
-- Table structure for managementapp_student_comments
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_student_comments`;
CREATE TABLE `managementapp_student_comments`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `comments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `course_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `staff_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `student_id_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `managementApp_studen_course_id_id_4fd04253_fk_managemen`(`course_id_id`) USING BTREE,
  INDEX `managementApp_studen_staff_id_id_ad4e3353_fk_managemen`(`staff_id_id`) USING BTREE,
  INDEX `managementApp_studen_student_id_id_505b4784_fk_managemen`(`student_id_id`) USING BTREE,
  CONSTRAINT `managementApp_studen_course_id_id_4fd04253_fk_managemen` FOREIGN KEY (`course_id_id`) REFERENCES `managementapp_course` (`course_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_studen_staff_id_id_ad4e3353_fk_managemen` FOREIGN KEY (`staff_id_id`) REFERENCES `managementapp_teacher` (`staff_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_studen_student_id_id_505b4784_fk_managemen` FOREIGN KEY (`student_id_id`) REFERENCES `managementapp_student` (`student_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_student_comments
-- ----------------------------
INSERT INTO `managementapp_student_comments` VALUES (1, 'asdfsdgasd', '01', '3', '20000000');

-- ----------------------------
-- Table structure for managementapp_teacher
-- ----------------------------
DROP TABLE IF EXISTS `managementapp_teacher`;
CREATE TABLE `managementapp_teacher`  (
  `staff_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `sex` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date_of_birth` date NULL DEFAULT NULL,
  `professional_ranks` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `salary` double NULL DEFAULT NULL,
  `dept_id_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id_id` int NOT NULL,
  PRIMARY KEY (`staff_id`) USING BTREE,
  INDEX `managementApp_t_dept_id_id_d40231fe_fk_managemen`(`dept_id_id`) USING BTREE,
  INDEX `managementApp_teacher_user_id_id_4bc0c57c_fk_auth_user_id`(`user_id_id`) USING BTREE,
  CONSTRAINT `managementApp_t_dept_id_id_d40231fe_fk_managemen` FOREIGN KEY (`dept_id_id`) REFERENCES `managementapp_department` (`dept_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `managementApp_teacher_user_id_id_4bc0c57c_fk_auth_user_id` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of managementapp_teacher
-- ----------------------------
INSERT INTO `managementapp_teacher` VALUES ('1', '华老师', '男', '1984-01-20', '教授', 42930, '01', 20);
INSERT INTO `managementapp_teacher` VALUES ('10', '姬老师', '女', '2002-01-16', '教授', 23412, '05', 28);
INSERT INTO `managementapp_teacher` VALUES ('11', '花老师', '女', '1976-01-01', '教授', 32421, '06', 29);
INSERT INTO `managementapp_teacher` VALUES ('2', '胡老师', '女', '1979-10-30', '副教授', 23420, '01', 21);
INSERT INTO `managementapp_teacher` VALUES ('222222', '测试教师', '女', '2023-12-01', '教授', 0, '01', 15);
INSERT INTO `managementapp_teacher` VALUES ('3', '龙老师', '女', '1977-01-14', '副教授', 39384, '01', 4);
INSERT INTO `managementapp_teacher` VALUES ('333333', '333333', '女', '2023-12-05', '', 0, '01', 16);
INSERT INTO `managementapp_teacher` VALUES ('4', '牛老师', '女', '2000-12-30', '讲师', 19282, '01', 22);
INSERT INTO `managementapp_teacher` VALUES ('5', '张老师', '女', '1998-01-23', '副教授', 13421, '02', 23);
INSERT INTO `managementapp_teacher` VALUES ('6', '李老师', '女', '1990-01-20', '教授', 12353, '03', 24);
INSERT INTO `managementapp_teacher` VALUES ('7', '赵老师', '女', '1992-01-29', '研究员', 12434, '03', 25);
INSERT INTO `managementapp_teacher` VALUES ('8', '王老师', '女', '1988-01-08', '教授', 12424, '04', 26);
INSERT INTO `managementapp_teacher` VALUES ('9', '刘老师', '女', '1978-01-11', '讲师', 12342, '04', 27);

-- ----------------------------
-- Procedure structure for CalculateAllScore
-- ----------------------------
DROP PROCEDURE IF EXISTS `CalculateAllScore`;
delimiter ;;
CREATE PROCEDURE `CalculateAllScore`(IN `thisSemester` varchar(32))
BEGIN
    DECLARE studentId INT;
    DECLARE totalScore DECIMAL(10, 2);
    DECLARE subjectCount INT;
    DECLARE totalGPA DECIMAL(10, 2);
    DECLARE totalCredits INT;  
    DECLARE totalRealCredits INT;
    DECLARE totalCreditGPA DECIMAL(10, 2);

    -- 获取学生ID列表
    DECLARE studentCursor CURSOR FOR
        SELECT DISTINCT student_id_id
        FROM managementapp_course_selection
        WHERE semester=thisSemester;

    -- 声明终止条件
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET studentId = NULL;

    OPEN studentCursor;

    -- 遍历学生列表
    studentLoop: LOOP
        FETCH studentCursor INTO studentId;

        IF studentId IS NULL THEN
            LEAVE studentLoop;
        END IF;

        SET totalScore = 0;
        SET subjectCount = 0;
        SET totalCredits = 0;
        SET totalGPA = 0;
        SET totalCreditGPA = 0;
        SET totalRealCredits = 0;

        -- 计算总分和科目数
        SELECT SUM(cs.total_score), 
            COUNT(cs.id),
            SUM(CASE WHEN cs.total_score > 60 THEN c.credit ELSE 0 END),
            SUM(c.credit),
            SUM(CASE
                    WHEN total_score >= 90 THEN 4.0*c.credit
                    WHEN total_score >= 85 THEN 3.7*c.credit
                    WHEN total_score >= 82 THEN 3.3*c.credit
                    WHEN total_score >= 78 THEN 3.0*c.credit
                    WHEN total_score >= 75 THEN 2.7*c.credit
                    WHEN total_score >= 72 THEN 2.3*c.credit
                    WHEN total_score >= 68 THEN 2.0*c.credit
                    WHEN total_score >= 66 THEN 1.7*c.credit
                    WHEN total_score >= 64 THEN 1.5*c.credit
                    WHEN total_score >= 60 THEN 1.0*c.credit
                    ELSE 0.0
                END)
            
        INTO totalScore, subjectCount, totalCredits, totalRealCredits, totalCreditGPA
        FROM managementapp_course_selection cs,managementapp_course c
        WHERE cs.course_id_id=c.course_id
            AND cs.student_id_id = studentId;

        -- 计算平均成绩
        IF subjectCount > 0 THEN
            UPDATE managementapp_student
            SET average_score = COALESCE(totalScore / NULLIF(subjectCount, 0), 0),average_gpa = COALESCE(totalCreditGPA / NULLIF(totalRealCredits, 0), 0),total_credit = totalCredits
            WHERE student_id = studentId;
        END IF;

    END LOOP;

    CLOSE studentCursor;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for CalculateAverageScore
-- ----------------------------
DROP PROCEDURE IF EXISTS `CalculateAverageScore`;
delimiter ;;
CREATE PROCEDURE `CalculateAverageScore`(in thisSemester varchar(32))
BEGIN
    DECLARE studentId INT;
    DECLARE totalScore DECIMAL(10, 2);
    DECLARE subjectCount INT;
    DECLARE totalGPA DECIMAL(10, 2);
    DECLARE totalCredits INT;  
    -- 包含失学分
    DECLARE totalRealCredits INT;
    DECLARE totalCreditGPA DECIMAL(10, 2);

    -- 获取学生ID列表
    DECLARE studentCursor CURSOR FOR
        SELECT DISTINCT student_id_id
        FROM managementapp_course_selection
        WHERE semester=thisSemester;

    -- 声明终止条件
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET studentId = NULL;

    OPEN studentCursor;

    -- 遍历学生列表
    studentLoop: LOOP
        FETCH studentCursor INTO studentId;

        IF studentId IS NULL THEN
            LEAVE studentLoop;
        END IF;

        SET totalScore = 0;
        SET subjectCount = 0;
        SET totalCredits = 0;
        SET totalGPA = 0;
        SET totalCreditGPA = 0;
        SET totalRealCredits = 0;

        -- 计算总分和科目数
        SELECT SUM(cs.total_score), 
            COUNT(cs.id),
            SUM(CASE WHEN cs.total_score > 60 THEN c.credit ELSE 0 END),
            SUM(c.credit),
            SUM(CASE
                    WHEN total_score >= 90 THEN 4.0*c.credit
                    WHEN total_score >= 85 THEN 3.7*c.credit
                    WHEN total_score >= 82 THEN 3.3*c.credit
                    WHEN total_score >= 78 THEN 3.0*c.credit
                    WHEN total_score >= 75 THEN 2.7*c.credit
                    WHEN total_score >= 72 THEN 2.3*c.credit
                    WHEN total_score >= 68 THEN 2.0*c.credit
                    WHEN total_score >= 66 THEN 1.7*c.credit
                    WHEN total_score >= 64 THEN 1.5*c.credit
                    WHEN total_score >= 60 THEN 1.0*c.credit
                    ELSE 0.0
                END)
            
        INTO totalScore, subjectCount, totalCredits, totalRealCredits, totalCreditGPA
        FROM managementapp_course_selection cs,managementapp_course c
        WHERE cs.course_id_id=c.course_id
            AND cs.student_id_id = studentId;

        -- 计算平均成绩,平均绩点，总学分（不包含失学分）
        IF subjectCount > 0 THEN
            UPDATE managementapp_student
            SET average_score = COALESCE(totalScore / NULLIF(subjectCount, 0), 0),average_gpa = COALESCE(totalCreditGPA / NULLIF(totalRealCredits, 0), 0),total_credit = totalCredits
            WHERE student_id = studentId;
        END IF;

    END LOOP;

    CLOSE studentCursor;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for update_total_score
-- ----------------------------
DROP PROCEDURE IF EXISTS `update_total_score`;
delimiter ;;
CREATE PROCEDURE `update_total_score`(IN course_id_param VARCHAR(32))
BEGIN
    DECLARE normal_score_percent_val DOUBLE;-- 定义变量平时分占比
    
    -- 获取最新的平时分占比
    SELECT normal_score_percent INTO normal_score_percent_val
    FROM managementapp_course
    WHERE course_id = course_id_param;
    
    -- 更新选课表中的total_score
    UPDATE managementapp_course_selection
    SET total_score = normal_score * normal_score_percent_val + test_score * (1 - normal_score_percent_val)
    WHERE managementapp_course_selection.course_id_id = course_id_param;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table managementapp_course
-- ----------------------------
DROP TRIGGER IF EXISTS `update_total_score`;
delimiter ;;
CREATE TRIGGER `update_total_score` AFTER UPDATE ON `managementapp_course` FOR EACH ROW BEGIN
    DECLARE normal_score_percent_val DOUBLE;-- 定义变量平时分占比
    
    -- 获取最新的平时分占比
    SELECT normal_score_percent INTO normal_score_percent_val
    FROM managementapp_course
    WHERE course_id = NEW.course_id;
    
    -- 更新选课表中的total_score
    UPDATE managementapp_course_selection
    SET total_score = normal_score * normal_score_percent_val + test_score * (1 - normal_score_percent_val)
    WHERE managementapp_course_selection.course_id_id = NEW.course_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table managementapp_course_selection
-- ----------------------------
DROP TRIGGER IF EXISTS `caculate_score`;
delimiter ;;
CREATE TRIGGER `caculate_score` BEFORE UPDATE ON `managementapp_course_selection` FOR EACH ROW begin 
    declare percent double;
    select normal_score_percent into percent from managementapp_course where course_id=new.course_id_id;
    set new.total_score=(coalesce(new.normal_score,0)*percent)+coalesce(new.test_score,0)*(1-percent);
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table managementapp_course_selection
-- ----------------------------
DROP TRIGGER IF EXISTS `manage_course_capacity_ondelete`;
delimiter ;;
CREATE TRIGGER `manage_course_capacity_ondelete` AFTER DELETE ON `managementapp_course_selection` FOR EACH ROW begin 
    update managementapp_open_course
    set used_capacity=used_capacity-1
        where id=old.open_course_id_id;
end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table managementapp_course_selection
-- ----------------------------
DROP TRIGGER IF EXISTS `manage_course_capacity`;
delimiter ;;
CREATE TRIGGER `manage_course_capacity` AFTER INSERT ON `managementapp_course_selection` FOR EACH ROW begin 
    update managementapp_open_course
    set used_capacity=used_capacity+1
    where id=new.open_course_id_id;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
