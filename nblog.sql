/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32-0ubuntu0.22.04.2)
 Source Host           : localhost:3306
 Source Schema         : nblog

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32-0ubuntu0.22.04.2)
 File Encoding         : 65001

 Date: 09/02/2023 18:44:04
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for about
-- ----------------------------
DROP TABLE IF EXISTS `about`;
CREATE TABLE `about` (
  `id` bigint NOT NULL,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of about
-- ----------------------------
BEGIN;
INSERT INTO `about` (`id`, `name_en`, `name_zh`, `value`) VALUES (1, 'title', '标题', '关于帅气的 Waitfor');
INSERT INTO `about` (`id`, `name_en`, `name_zh`, `value`) VALUES (2, 'musicId', '网易云歌曲ID', '486999661');
INSERT INTO `about` (`id`, `name_en`, `name_zh`, `value`) VALUES (3, 'content', '正文Markdown', '');
INSERT INTO `about` (`id`, `name_en`, `name_zh`, `value`) VALUES (4, 'commentEnabled', '评论开关', 'true');
COMMIT;

-- ----------------------------
-- Table structure for blog
-- ----------------------------
DROP TABLE IF EXISTS `blog`;
CREATE TABLE `blog` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章标题',
  `first_picture` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章首图，用于随机文章展示',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章正文',
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `is_published` bit(1) NOT NULL COMMENT '公开或私密',
  `is_recommend` bit(1) NOT NULL COMMENT '推荐开关',
  `is_appreciation` bit(1) NOT NULL COMMENT '赞赏开关',
  `is_comment_enabled` bit(1) NOT NULL COMMENT '评论开关',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `views` int NOT NULL COMMENT '浏览次数',
  `words` int NOT NULL COMMENT '文章字数',
  `read_time` int NOT NULL COMMENT '阅读时长(分钟)',
  `category_id` bigint NOT NULL COMMENT '文章分类',
  `is_top` bit(1) NOT NULL COMMENT '是否置顶',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码保护',
  `user_id` bigint DEFAULT NULL COMMENT '文章作者',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `type_id` (`category_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of blog
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `blog_tag`;
CREATE TABLE `blog_tag` (
  `blog_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of blog_tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for city_visitor
-- ----------------------------
DROP TABLE IF EXISTS `city_visitor`;
CREATE TABLE `city_visitor` (
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '城市名称',
  `uv` int NOT NULL COMMENT '独立访客数量',
  PRIMARY KEY (`city`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of city_visitor
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '评论内容',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像(图片路径)',
  `create_time` datetime DEFAULT NULL COMMENT '评论时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '评论者ip地址',
  `is_published` bit(1) NOT NULL COMMENT '公开或回收站',
  `is_admin_comment` bit(1) NOT NULL COMMENT '博主回复',
  `page` int NOT NULL COMMENT '0普通文章，1关于我页面，2友链页面',
  `is_notice` bit(1) NOT NULL COMMENT '接收邮件提醒',
  `blog_id` bigint DEFAULT NULL COMMENT '所属的文章',
  `parent_comment_id` bigint NOT NULL COMMENT '父评论id，-1为根评论',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '个人网站',
  `qq` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '如果评论昵称为QQ号，则将昵称和头像置为QQ昵称和QQ头像，并将此字段置为QQ号备份',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for exception_log
-- ----------------------------
DROP TABLE IF EXISTS `exception_log`;
CREATE TABLE `exception_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '异常信息',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of exception_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for friend
-- ----------------------------
DROP TABLE IF EXISTS `friend`;
CREATE TABLE `friend` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '站点',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
  `is_published` bit(1) NOT NULL COMMENT '公开或隐藏',
  `views` int NOT NULL COMMENT '点击次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of friend
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for login_log
-- ----------------------------
DROP TABLE IF EXISTS `login_log`;
CREATE TABLE `login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名称',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `status` bit(1) DEFAULT NULL COMMENT '登录状态',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `create_time` datetime NOT NULL COMMENT '登录时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of login_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for moment
-- ----------------------------
DROP TABLE IF EXISTS `moment`;
CREATE TABLE `moment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '动态内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `likes` int DEFAULT NULL COMMENT '点赞数量',
  `is_published` bit(1) NOT NULL COMMENT '是否公开',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of moment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for operation_log
-- ----------------------------
DROP TABLE IF EXISTS `operation_log`;
CREATE TABLE `operation_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '操作者用户名',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '请求参数',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作描述',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of operation_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数',
  `cron` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint DEFAULT NULL COMMENT '任务状态',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
BEGIN;
INSERT INTO `schedule_job` (`job_id`, `bean_name`, `method_name`, `params`, `cron`, `status`, `remark`, `create_time`) VALUES (1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', '0 0 1 * * ?', 1, '每天凌晨一点，从Redis将博客浏览量同步到数据库', '2020-11-17 23:45:42');
INSERT INTO `schedule_job` (`job_id`, `bean_name`, `method_name`, `params`, `cron`, `status`, `remark`, `create_time`) VALUES (2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', '0 0 0 * * ?', 1, '清空当天Redis访客标识，记录当天的PV和UV，更新当天所有访客的PV和最后访问时间，更新城市新增访客UV数', '2021-02-05 08:14:28');
COMMIT;

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint NOT NULL COMMENT '任务id',
  `bean_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '方法名',
  `params` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '参数',
  `status` tinyint NOT NULL COMMENT '任务执行结果',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '异常信息',
  `times` int NOT NULL COMMENT '耗时（单位：毫秒）',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
BEGIN;
INSERT INTO `schedule_job_log` (`log_id`, `job_id`, `bean_name`, `method_name`, `params`, `status`, `error`, `times`, `create_time`) VALUES (1, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 88, '2023-02-04 00:00:00');
INSERT INTO `schedule_job_log` (`log_id`, `job_id`, `bean_name`, `method_name`, `params`, `status`, `error`, `times`, `create_time`) VALUES (2, 2, 'visitorSyncScheduleTask', 'syncVisitInfoToDatabase', '', 1, NULL, 39, '2023-02-07 00:00:00');
INSERT INTO `schedule_job_log` (`log_id`, `job_id`, `bean_name`, `method_name`, `params`, `status`, `error`, `times`, `create_time`) VALUES (3, 1, 'redisSyncScheduleTask', 'syncBlogViewsToDatabase', '', 1, NULL, 14, '2023-02-08 01:00:00');
COMMIT;

-- ----------------------------
-- Table structure for site_setting
-- ----------------------------
DROP TABLE IF EXISTS `site_setting`;
CREATE TABLE `site_setting` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name_en` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name_zh` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `type` int DEFAULT NULL COMMENT '1基础设置，2页脚徽标，3资料卡，4友链信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of site_setting
-- ----------------------------
BEGIN;
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (1, 'blogName', '博客名称', 'Waitfor Blog', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (2, 'webTitleSuffix', '网页标题后缀', ' - Waitfor Blog', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (3, 'footerImgTitle', '页脚图片标题', '手机看本站', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (4, 'footerImgUrl', '页脚图片路径', '/img/qr.png', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (5, 'copyright', 'Copyright', '{\"title\":\"Copyright © 2022 - 2023\",\"siteName\":\"WAITFORS‘ BLOG\"}', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (6, 'beian', 'ICP备案号', '', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (7, 'reward', '赞赏码', '/img/reward.jpg', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (8, 'commentAdminFlag', '博主评论标识', '楼主', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (9, 'playlistServer', '播放器平台', 'netease', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (10, 'playlistId', '播放器歌单', '3071528549', 1);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (11, 'avatar', '头像', '/img/avatar.jpg', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (12, 'name', '昵称', 'Waitfor', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (13, 'rollText', '滚动个签', '\"云鹤当归天，天不迎我妙木仙；\",\"游龙当归海，海不迎我自来也。\"', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (14, 'github', 'GitHub', 'https://github.com/busiqiao', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (16, 'qq', 'QQ', 'http://sighttp.qq.com/authd?IDKEY=', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (17, 'bilibili', 'bilibili', 'https://space.bilibili.com/', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (18, 'netease', '网易云音乐', 'https://music.163.com/#/user/home?id=423897234', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (19, 'email', 'email', 'mailto:busiqiao666@gmail.com', 2);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (23, 'badge', '徽标', '{\"title\":\"本博客已开源于 GitHub\",\"url\":\"https://github.com/busiqiao\",\"subject\":\"NBlog\",\"value\":\"Open Source\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (24, 'badge', '徽标', '{\"title\":\"由 Spring Boot 强力驱动\",\"url\":\"https://spring.io/projects/spring-boot/\",\"subject\":\"Powered\",\"value\":\"Spring Boot\",\"color\":\"blue\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (25, 'badge', '徽标', '{\"title\":\"Vue.js 客户端渲染\",\"url\":\"https://cn.vuejs.org/\",\"subject\":\"SPA\",\"value\":\"Vue.js\",\"color\":\"brightgreen\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (26, 'badge', '徽标', '{\"title\":\"UI 框架 Semantic-UI\",\"url\":\"https://semantic-ui.com/\",\"subject\":\"UI\",\"value\":\"Semantic-UI\",\"color\":\"semantic-ui\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (27, 'badge', '徽标', '{\"title\":\"腾讯云提供服务器及域名相关服务\",\"url\":\"https://cloud.tencent.com/\",\"subject\":\"VPS & DNS\",\"value\":\"Tencent\",\"color\":\"blueviolet\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (28, 'badge', '徽标', '{\"title\":\"静态资源托管于 GitHub\",\"url\":\"https://github.com/\",\"subject\":\"OSS\",\"value\":\"Tencent\",\"color\":\"github\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (30, 'badge', '徽标', '{\"color\":\"lightgray\",\"subject\":\"CC\",\"title\":\"本站点采用 CC BY 4.0 国际许可协议进行许可\",\"url\":\"https://creativecommons.org/licenses/by/4.0/\",\"value\":\"BY 4.0\"}', 3);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (31, 'friendContent', '友链页面信息', '随机排序，不分先后。欢迎交换友链~(￣▽￣)~*\n\n* 昵称：Waitfor\n* 一句话：游龙当归海，海不迎我自来也。\n* 网址：[https://waitfor.online](https://waitfor.online)\n* 头像URL：[https://waitfor.online/img/avatar.jpg](https://waitfor.online/img/avatar.jpg)\n\n仅凭个人喜好添加友链，请在收到我的回复邮件后再于贵站添加本站链接。\n\n', 4);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (32, 'friendCommentEnabled', '友链页面评论开关', '1', 4);
INSERT INTO `site_setting` (`id`, `name_en`, `name_zh`, `value`, `type`) VALUES (33, 'telegram', '电报', 'https://t.me/istudys', 2);
COMMIT;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '标签颜色(可选)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tag
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色访问权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` (`id`, `username`, `password`, `nickname`, `avatar`, `email`, `create_time`, `update_time`, `role`) VALUES (1, 'Admin', '$2a$10$q8QjCf2m0l0dOSR6r7pfuemU8Y2ed8BT/FcdQn3fPaHfIhMJTYruG', 'Admin', '/img/avatar.jpg', 'admin@waitfor.online', '2020-09-21 16:47:18', '2020-09-21 16:47:22', 'ROLE_admin');
COMMIT;

-- ----------------------------
-- Table structure for visit_log
-- ----------------------------
DROP TABLE IF EXISTS `visit_log`;
CREATE TABLE `visit_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访客标识码',
  `uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求参数',
  `behavior` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问行为',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '访问内容',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `times` int NOT NULL COMMENT '请求耗时（毫秒）',
  `create_time` datetime NOT NULL COMMENT '访问时间',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of visit_log
-- ----------------------------
BEGIN;
INSERT INTO `visit_log` (`id`, `uuid`, `uri`, `method`, `param`, `behavior`, `content`, `remark`, `ip`, `ip_source`, `os`, `browser`, `times`, `create_time`, `user_agent`) VALUES (2, 'd255bf35-5184-3a70-818e-981c99827e62', '/blogs', 'GET', '{\"pageNum\":1}', '访问页面', '首页', '第1页', '192.168.0.202', '内网IP|内网IP', 'Linux ??', 'Chrome 109', 34, '2023-02-08 20:45:33', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36');
INSERT INTO `visit_log` (`id`, `uuid`, `uri`, `method`, `param`, `behavior`, `content`, `remark`, `ip`, `ip_source`, `os`, `browser`, `times`, `create_time`, `user_agent`) VALUES (3, 'd255bf35-5184-3a70-818e-981c99827e62', '/archives', 'GET', '{}', '访问页面', '归档', '', '192.168.0.202', '内网IP|内网IP', 'Linux ??', 'Chrome 109', 10, '2023-02-08 20:45:36', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36');
INSERT INTO `visit_log` (`id`, `uuid`, `uri`, `method`, `param`, `behavior`, `content`, `remark`, `ip`, `ip_source`, `os`, `browser`, `times`, `create_time`, `user_agent`) VALUES (4, 'd255bf35-5184-3a70-818e-981c99827e62', '/moments', 'GET', '{\"pageNum\":1}', '访问页面', '动态', '第1页', '192.168.0.202', '内网IP|内网IP', 'Linux ??', 'Chrome 109', 9, '2023-02-08 20:45:37', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36');
INSERT INTO `visit_log` (`id`, `uuid`, `uri`, `method`, `param`, `behavior`, `content`, `remark`, `ip`, `ip_source`, `os`, `browser`, `times`, `create_time`, `user_agent`) VALUES (5, 'd255bf35-5184-3a70-818e-981c99827e62', '/friends', 'GET', '{}', '访问页面', '友链', '', '192.168.0.202', '内网IP|内网IP', 'Linux ??', 'Chrome 109', 8, '2023-02-08 20:45:38', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36');
INSERT INTO `visit_log` (`id`, `uuid`, `uri`, `method`, `param`, `behavior`, `content`, `remark`, `ip`, `ip_source`, `os`, `browser`, `times`, `create_time`, `user_agent`) VALUES (6, 'd255bf35-5184-3a70-818e-981c99827e62', '/about', 'GET', '{}', '访问页面', '关于我', '', '192.168.0.202', '内网IP|内网IP', 'Linux ??', 'Chrome 109', 3, '2023-02-08 20:45:40', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36');
COMMIT;

-- ----------------------------
-- Table structure for visit_record
-- ----------------------------
DROP TABLE IF EXISTS `visit_record`;
CREATE TABLE `visit_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `pv` int NOT NULL COMMENT '访问量',
  `uv` int NOT NULL COMMENT '独立用户',
  `date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日期"02-23"',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of visit_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for visitor
-- ----------------------------
DROP TABLE IF EXISTS `visitor`;
CREATE TABLE `visitor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '访客标识码',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ip来源',
  `os` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '首次访问时间',
  `last_time` datetime NOT NULL COMMENT '最后访问时间',
  `pv` int DEFAULT NULL COMMENT '访问页数统计',
  `user_agent` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'user-agent用户代理',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_uuid` (`uuid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of visitor
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
