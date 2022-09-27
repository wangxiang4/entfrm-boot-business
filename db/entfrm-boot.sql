/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50738 (5.7.38)
 Source Host           : localhost:3306
 Source Schema         : entfrm-boot

 Target Server Type    : MySQL
 Target Server Version : 50738 (5.7.38)
 File Encoding         : 65001

 Date: 27/09/2022 20:14:52
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for act_de_databasechangelog
-- ----------------------------
DROP TABLE IF EXISTS `act_de_databasechangelog`;
CREATE TABLE `act_de_databasechangelog` (
  `ID` varchar(255) NOT NULL,
  `AUTHOR` varchar(255) NOT NULL,
  `FILENAME` varchar(255) NOT NULL,
  `DATEEXECUTED` datetime NOT NULL,
  `ORDEREXECUTED` int(11) NOT NULL,
  `EXECTYPE` varchar(10) NOT NULL,
  `MD5SUM` varchar(35) DEFAULT NULL,
  `DESCRIPTION` varchar(255) DEFAULT NULL,
  `COMMENTS` varchar(255) DEFAULT NULL,
  `TAG` varchar(255) DEFAULT NULL,
  `LIQUIBASE` varchar(20) DEFAULT NULL,
  `CONTEXTS` varchar(255) DEFAULT NULL,
  `LABELS` varchar(255) DEFAULT NULL,
  `DEPLOYMENT_ID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of act_de_databasechangelog
-- ----------------------------
BEGIN;
INSERT INTO `act_de_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('1', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2022-09-27 18:06:54', 1, 'EXECUTED', '8:e70d1d9d3899a734296b2514ccc71501', 'createTable tableName=ACT_DE_MODEL; createIndex indexName=idx_proc_mod_created, tableName=ACT_DE_MODEL; createTable tableName=ACT_DE_MODEL_HISTORY; createIndex indexName=idx_proc_mod_history_proc, tableName=ACT_DE_MODEL_HISTORY; createTable tableN...', '', NULL, '3.8.9', NULL, NULL, '4273213849');
INSERT INTO `act_de_databasechangelog` (`ID`, `AUTHOR`, `FILENAME`, `DATEEXECUTED`, `ORDEREXECUTED`, `EXECTYPE`, `MD5SUM`, `DESCRIPTION`, `COMMENTS`, `TAG`, `LIQUIBASE`, `CONTEXTS`, `LABELS`, `DEPLOYMENT_ID`) VALUES ('3', 'flowable', 'META-INF/liquibase/flowable-modeler-app-db-changelog.xml', '2022-09-27 18:06:54', 2, 'EXECUTED', '8:3a9143bef2e45f2316231cc1369138b6', 'addColumn tableName=ACT_DE_MODEL; addColumn tableName=ACT_DE_MODEL_HISTORY', '', NULL, '3.8.9', NULL, NULL, '4273213849');
COMMIT;

-- ----------------------------
-- Table structure for act_de_databasechangeloglock
-- ----------------------------
DROP TABLE IF EXISTS `act_de_databasechangeloglock`;
CREATE TABLE `act_de_databasechangeloglock` (
  `ID` int(11) NOT NULL,
  `LOCKED` bit(1) NOT NULL,
  `LOCKGRANTED` datetime DEFAULT NULL,
  `LOCKEDBY` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of act_de_databasechangeloglock
-- ----------------------------
BEGIN;
INSERT INTO `act_de_databasechangeloglock` (`ID`, `LOCKED`, `LOCKGRANTED`, `LOCKEDBY`) VALUES (1, b'0', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_de_model
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model`;
CREATE TABLE `act_de_model` (
  `id` varchar(255) NOT NULL,
  `name` varchar(400) NOT NULL,
  `model_key` varchar(400) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `model_comment` varchar(4000) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `last_updated_by` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `model_editor_json` longtext,
  `thumbnail` longblob,
  `model_type` int(11) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_proc_mod_created` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of act_de_model
-- ----------------------------
BEGIN;
INSERT INTO `act_de_model` (`id`, `name`, `model_key`, `description`, `model_comment`, `created`, `created_by`, `last_updated`, `last_updated_by`, `version`, `model_editor_json`, `thumbnail`, `model_type`, `tenant_id`) VALUES ('a3aa14ad-3e58-11ed-8a80-4e744305f12a', '请假流程', 'Process_FaYBwzO9', '', NULL, '2022-09-27 19:36:32.574000', '1', '2022-09-27 19:44:20.601000', '1', 1, '{\"bounds\":{\"lowerRight\":{\"x\":1485.0,\"y\":700.0},\"upperLeft\":{\"x\":0.0,\"y\":0.0}},\"resourceId\":\"canvas\",\"stencil\":{\"id\":\"BPMNDiagram\"},\"stencilset\":{\"namespace\":\"http://b3mn.org/stencilset/bpmn2.0#\",\"url\":\"../editor/stencilsets/bpmn2.0/bpmn2.0.json\"},\"properties\":{\"process_id\":\"Process_FaYBwzO9\",\"name\":\"请假流程\",\"documentation\":\"请假流程\",\"process_namespace\":\"http://www.flowable.org/processdef\",\"iseagerexecutionfetch\":false,\"messages\":[],\"executionlisteners\":{\"executionListeners\":[]},\"eventlisteners\":{\"eventListeners\":[]},\"signaldefinitions\":[],\"messagedefinitions\":[],\"escalationdefinitions\":[]},\"childShapes\":[{\"bounds\":{\"lowerRight\":{\"x\":245.0,\"y\":319.0},\"upperLeft\":{\"x\":209.0,\"y\":283.0}},\"resourceId\":\"Event_95uPJY1M\",\"childShapes\":[],\"stencil\":{\"id\":\"StartNoneEvent\"},\"properties\":{\"overrideid\":\"Event_95uPJY1M\",\"name\":\"开始\",\"initiator\":\"applyUserId\",\"formkeydefinition\":\"2\",\"interrupting\":true,\"formproperties\":{\"formProperties\":[{\"id\":\"input_VyKm9I7H\",\"name\":\"请假人\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_fxwWzgAc\",\"name\":\"请假原因\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_7z86kLKJ\",\"name\":\"请假备注\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_0dd0adn\"}]},{\"bounds\":{\"lowerRight\":{\"x\":400.0,\"y\":341.0},\"upperLeft\":{\"x\":300.0,\"y\":261.0}},\"resourceId\":\"Activity_0sjx0ro\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_0sjx0ro\",\"name\":\"小猫审批\",\"formkeydefinition\":\"2\",\"formproperties\":{\"formProperties\":[{\"id\":\"input_VyKm9I7H\",\"name\":\"请假人\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_fxwWzgAc\",\"name\":\"请假原因\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_7z86kLKJ\",\"name\":\"请假备注\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"formType\":\"1\",\"button\":[{\"name\":\"同意\",\"code\":\"_workflow_activity_agree\",\"isHide\":\"0\",\"sort\":2},{\"name\":\"驳回\",\"code\":\"_workflow_activity_reject\",\"isHide\":\"0\",\"sort\":3},{\"name\":\"指定回退\",\"code\":\"_workflow_activity_roll_back\",\"isHide\":\"0\",\"sort\":4},{\"name\":\"转办\",\"code\":\"_workflow_activity_transfer\",\"isHide\":\"0\",\"sort\":7},{\"name\":\"委派\",\"code\":\"_workflow_activity_delegate\",\"isHide\":\"0\",\"sort\":8},{\"name\":\"终止\",\"code\":\"_workflow_activity_stop\",\"isHide\":\"0\",\"sort\":9},{\"name\":\"打印\",\"code\":\"_workflow_activity_print\",\"isHide\":\"0\",\"sort\":10}],\"assignee\":[{\"type\":\"user\",\"value\":\"7\",\"condition\":\"0\",\"operationType\":\"0\",\"sort\":0}],\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[{\"event\":\"start\",\"className\":\"com.entfrm.biz.workflow.listener.MyExecutionListener\"}]}},\"outgoing\":[{\"resourceId\":\"Flow_1ah4lf6\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0dd0adn\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":18.0,\"y\":18.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_0sjx0ro\"}],\"target\":{\"resourceId\":\"Activity_0sjx0ro\"},\"properties\":{\"overrideid\":\"Flow_0dd0adn\"}},{\"bounds\":{\"lowerRight\":{\"x\":560.0,\"y\":341.0},\"upperLeft\":{\"x\":460.0,\"y\":261.0}},\"resourceId\":\"Activity_0587dk0\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_0587dk0\",\"name\":\"小可爱审批\",\"formkeydefinition\":\"2\",\"formproperties\":{\"formProperties\":[{\"id\":\"input_VyKm9I7H\",\"name\":\"请假人\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_fxwWzgAc\",\"name\":\"请假原因\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_7z86kLKJ\",\"name\":\"请假备注\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"formType\":\"1\",\"button\":[{\"name\":\"同意\",\"code\":\"_workflow_activity_agree\",\"isHide\":\"0\",\"sort\":2},{\"name\":\"驳回\",\"code\":\"_workflow_activity_reject\",\"isHide\":\"0\",\"sort\":3},{\"name\":\"指定回退\",\"code\":\"_workflow_activity_roll_back\",\"isHide\":\"0\",\"sort\":4},{\"name\":\"转办\",\"code\":\"_workflow_activity_transfer\",\"isHide\":\"0\",\"sort\":7},{\"name\":\"委派\",\"code\":\"_workflow_activity_delegate\",\"isHide\":\"0\",\"sort\":8},{\"name\":\"终止\",\"code\":\"_workflow_activity_stop\",\"isHide\":\"0\",\"sort\":9},{\"name\":\"打印\",\"code\":\"_workflow_activity_print\",\"isHide\":\"0\",\"sort\":10}],\"assignee\":[{\"type\":\"user\",\"value\":\"8\",\"condition\":\"0\",\"operationType\":\"0\",\"sort\":0}],\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_0z0j70x\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_1ah4lf6\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_0587dk0\"}],\"target\":{\"resourceId\":\"Activity_0587dk0\"},\"properties\":{\"overrideid\":\"Flow_1ah4lf6\"}},{\"bounds\":{\"lowerRight\":{\"x\":720.0,\"y\":341.0},\"upperLeft\":{\"x\":620.0,\"y\":261.0}},\"resourceId\":\"Activity_1814gm9\",\"childShapes\":[],\"stencil\":{\"id\":\"UserTask\"},\"properties\":{\"overrideid\":\"Activity_1814gm9\",\"name\":\"小猪审批\",\"formkeydefinition\":\"2\",\"formproperties\":{\"formProperties\":[{\"id\":\"input_VyKm9I7H\",\"name\":\"请假人\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_fxwWzgAc\",\"name\":\"请假原因\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true},{\"id\":\"input_7z86kLKJ\",\"name\":\"请假备注\",\"type\":null,\"expression\":null,\"variable\":null,\"default\":null,\"required\":false,\"readable\":true,\"writable\":true}]},\"formType\":\"1\",\"button\":[{\"name\":\"同意\",\"code\":\"_workflow_activity_agree\",\"isHide\":\"0\",\"sort\":2},{\"name\":\"驳回\",\"code\":\"_workflow_activity_reject\",\"isHide\":\"0\",\"sort\":3},{\"name\":\"指定回退\",\"code\":\"_workflow_activity_roll_back\",\"isHide\":\"0\",\"sort\":4},{\"name\":\"转办\",\"code\":\"_workflow_activity_transfer\",\"isHide\":\"0\",\"sort\":7},{\"name\":\"委派\",\"code\":\"_workflow_activity_delegate\",\"isHide\":\"0\",\"sort\":8},{\"name\":\"终止\",\"code\":\"_workflow_activity_stop\",\"isHide\":\"0\",\"sort\":9},{\"name\":\"打印\",\"code\":\"_workflow_activity_print\",\"isHide\":\"0\",\"sort\":10}],\"assignee\":[{\"type\":\"user\",\"value\":\"10\",\"condition\":\"0\",\"operationType\":\"0\",\"sort\":0}],\"asynchronousdefinition\":false,\"exclusivedefinition\":true,\"isforcompensation\":false,\"tasklisteners\":{\"taskListeners\":[]},\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[{\"resourceId\":\"Flow_1xlavbv\"}]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_0z0j70x\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":50.0,\"y\":40.0}],\"outgoing\":[{\"resourceId\":\"Activity_1814gm9\"}],\"target\":{\"resourceId\":\"Activity_1814gm9\"},\"properties\":{\"overrideid\":\"Flow_0z0j70x\"}},{\"bounds\":{\"lowerRight\":{\"x\":818.0,\"y\":319.0},\"upperLeft\":{\"x\":782.0,\"y\":283.0}},\"resourceId\":\"Event_1ec9955\",\"childShapes\":[],\"stencil\":{\"id\":\"EndNoneEvent\"},\"properties\":{\"overrideid\":\"Event_1ec9955\",\"executionlisteners\":{\"executionListeners\":[]}},\"outgoing\":[]},{\"bounds\":{\"lowerRight\":{\"x\":172.0,\"y\":212.0},\"upperLeft\":{\"x\":128.0,\"y\":212.0}},\"resourceId\":\"Flow_1xlavbv\",\"childShapes\":[],\"stencil\":{\"id\":\"SequenceFlow\"},\"dockers\":[{\"x\":50.0,\"y\":40.0},{\"x\":18.0,\"y\":18.0}],\"outgoing\":[{\"resourceId\":\"Event_1ec9955\"}],\"target\":{\"resourceId\":\"Event_1ec9955\"},\"properties\":{\"overrideid\":\"Flow_1xlavbv\"}}]}', 0x89504E470D0A1A0A0000000D49484452000000EF0000002D080600000046503C06000004964944415478DAED9D4B481B5114865DB8ECA28B2E5C76D9858B2EBAE8A20B175D0AEDC2F848E22B8988AF08D5D482081210D7C5824A15912215DC48A152348A464421B8A814940A525382F86A34A221367A7B4EC8581F512789E384B9FF079721C90C977F0EFF3DF731779295050000000000000000000000508710227B6D6D6D646161E1647272524C4C4CDC7BF1783CC2EBF5EE50B14227B402957090676767C5D6D696884422BA95EDED6D313333B34F412F804E68052AE0D699837C100C88EF5F5DB1A38EC18E50ABBDACA54EAE476FAD5AEA944DABD470B78A6FF28F89F65890F9A8676B4D81FEABA5CE4CD1AA954ED9B44A0D8F4FF806AFCE7D8805998F3A9B5768A93353B46AA55336AD302FDDE09F735DB120F3D1E8E6CD04ADF7655EA36B95DEBC1CDCCBC5A8E6CD14ADF7615E19B422F3EA9869F5C8BC46D6299BD644949494BC282E2E6EA6D25E5454F48E8E799A5768B55A3F5B2C96205526CC66F3219541AA3C17E6854E6855E5A1D7E49D65F64F82B24ABFDFED9A734545C5439BCD36565F5FBF373F3F7FBCBBBB2B98C3C3435EE8FE43BF87C8D46F1068E884D6C4E4E5E5655392FBA81895BC74D2DBDB2B464646C4C0C080703A9DD17326FE6432991EDC8971CBCACA7E0D0D0D45A2D1A848442814120D0D0DFB746E03020D9DD07A15C5B8E5E5E5A7636363E2B297F8337F4FBFFF550CCC864FAB5287C3F18D8D2B6EC1EFF70B327984D2FE23041A3AA1F53F64C402C5B84B4B4B37FA686565E5CCC06975A1798C4BE9FCE0BA8C7B99EEEE6EE176BBDF23D0D009AD17CC1B1BE3726655039FA78C8153CEBE76BBFD0B8D71D53997E056A5A9A9690781864E68BD30ABCC63DC53B54990CFABABAB0BF3758585852F53AAB8B4B434140C06D57A3736814529FFE40E5B2B9E46CF357AA015ADB2E89421A6E7F48EB309FBFAFA4432F4F7F71FF375BC8C946AE52259AE99024FAB6462A0A1135A93293CAB9C0C7C7EFCDAF694CC6BB55AF7F5CABCE836A3DB6C04ADF10731042F0B25039D1F8E9BB739D56EF3E0F8F8F8B1DA0A7D3E9F70B95CEB08347442EB99799FB109ABABAB4FC2E1B02A1FF17955555547F16EF3F35407DB4F6C36DB11AFE3AAC1ED769FB6B5B5BD45A0A1135A2F1878968DC8AB316A26AD384BC7B3AE2FADB55E87C3E16A6C6C8CF03AEE4D8C8E8E8ADADADADF692F2CC3BC30AFC1B49ACDE6A764C45837B8A3A3436C6C6C24F4107FDFD9D9A918379C72D63D8FD3E96CB4DBED516E3916171785320EE6312E779529E38A9A9A1A3F55F81881864E68BD0A2FF9504F764799C0A2E1656C065A793C927AACC262B1887857394825FFCE2AA7CA727A7A7A865B5B5BF72B2B2B4F9527465A5A5AB6A83569D322E3C2BC30AF913626F0A3C6E49B2E326938D18C34993B42C70193C994936514605E98D7485B0279D30167D6F85640654B60019B3BCB68C0BC302F36E3C3BC302FCC0BF3C2BCD009ADE056CEBF2634034AF83E5EFD6A649DB269951AAFD7BBA1F79BF59512080486B57A41B72C3A65D32A35535353AFA6A7A7F73637378FF46C9D39C81E8F675DABBFC69045A76C5AA5876E6E3EB58E3EEEDEE8F1A754F17A97B50EB22C3A65D30A00000000000000000000000000000000000000000000400FFE011476C22EAE3A5CA20000000049454E44AE426082, 0, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_de_model_history
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model_history`;
CREATE TABLE `act_de_model_history` (
  `id` varchar(255) NOT NULL,
  `name` varchar(400) NOT NULL,
  `model_key` varchar(400) NOT NULL,
  `description` varchar(4000) DEFAULT NULL,
  `model_comment` varchar(4000) DEFAULT NULL,
  `created` datetime(6) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `last_updated_by` varchar(255) DEFAULT NULL,
  `removal_date` datetime(6) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `model_editor_json` longtext,
  `model_id` varchar(255) NOT NULL,
  `model_type` int(11) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_proc_mod_history_proc` (`model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of act_de_model_history
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_de_model_relation
-- ----------------------------
DROP TABLE IF EXISTS `act_de_model_relation`;
CREATE TABLE `act_de_model_relation` (
  `id` varchar(255) NOT NULL,
  `parent_model_id` varchar(255) DEFAULT NULL,
  `model_id` varchar(255) DEFAULT NULL,
  `relation_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_relation_parent` (`parent_model_id`),
  KEY `fk_relation_child` (`model_id`),
  CONSTRAINT `fk_relation_child` FOREIGN KEY (`model_id`) REFERENCES `act_de_model` (`id`),
  CONSTRAINT `fk_relation_parent` FOREIGN KEY (`parent_model_id`) REFERENCES `act_de_model` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of act_de_model_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_evt_log
-- ----------------------------
DROP TABLE IF EXISTS `act_evt_log`;
CREATE TABLE `act_evt_log` (
  `LOG_NR_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` longblob,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_PROCESSED_` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`LOG_NR_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_evt_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_extension_activity_data
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_activity_data`;
CREATE TABLE `act_extension_activity_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `process_def_id` varchar(64) DEFAULT NULL COMMENT '流程定义id',
  `activity_def_id` varchar(64) DEFAULT NULL COMMENT '任务定义id',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='flowable扩展表';

-- ----------------------------
-- Records of act_extension_activity_data
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_activity_data` (`id`, `process_def_id`, `activity_def_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (10, 'Process_FaYBwzO9', 'Activity_0sjx0ro', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_data` (`id`, `process_def_id`, `activity_def_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (11, 'Process_FaYBwzO9', 'Activity_0587dk0', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_data` (`id`, `process_def_id`, `activity_def_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (12, 'Process_FaYBwzO9', 'Activity_1814gm9', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_extension_activity_property
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_activity_property`;
CREATE TABLE `act_extension_activity_property` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `process_def_id` varchar(64) DEFAULT NULL COMMENT '流程定义id',
  `activity_def_id` varchar(64) DEFAULT NULL COMMENT '节点id',
  `key` varchar(64) DEFAULT NULL COMMENT '变量名',
  `value` varchar(64) DEFAULT NULL COMMENT '变量值',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='表单配置';

-- ----------------------------
-- Records of act_extension_activity_property
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (12, 'Process_FaYBwzO9', 'Event_95uPJY1M', 'formType', '1', 'entfrm', '2022-09-27 19:43:59', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (13, 'Process_FaYBwzO9', 'Event_95uPJY1M', 'formReadOnly', 'false', 'entfrm', '2022-09-27 19:43:59', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (17, 'Process_FaYBwzO9', 'Activity_0sjx0ro', 'formType', '1', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (18, 'Process_FaYBwzO9', 'Activity_0sjx0ro', 'formReadOnly', 'false', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (19, 'Process_FaYBwzO9', 'Activity_0587dk0', 'formType', '1', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (20, 'Process_FaYBwzO9', 'Activity_0587dk0', 'formReadOnly', 'false', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (21, 'Process_FaYBwzO9', 'Activity_1814gm9', 'formType', '1', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
INSERT INTO `act_extension_activity_property` (`id`, `process_def_id`, `activity_def_id`, `key`, `value`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (22, 'Process_FaYBwzO9', 'Activity_1814gm9', 'formReadOnly', 'false', 'entfrm', '2022-09-27 19:44:21', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_extension_button
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_button`;
CREATE TABLE `act_extension_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `code` varchar(64) DEFAULT NULL COMMENT '编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='常用按钮';

-- ----------------------------
-- Records of act_extension_button
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (1, '指定回退', 4, '_workflow_activity_roll_back');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (2, '同意', 2, '_workflow_activity_agree');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (3, '加签', 5, '_workflow_activity_add_multi_instance');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (4, '转办', 7, '_workflow_activity_transfer');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (5, '打印', 10, '_workflow_activity_print');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (6, '暂存', 1, '_workflow_activity_save');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (7, '终止', 9, '_workflow_activity_stop');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (8, '驳回', 3, '_workflow_activity_reject');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (9, '减签', 6, '_workflow_activity_del_multi_instance');
INSERT INTO `act_extension_button` (`id`, `name`, `sort`, `code`) VALUES (10, '委派', 8, '_workflow_activity_delegate');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_category
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_category`;
CREATE TABLE `act_extension_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) DEFAULT '0' COMMENT '父级编号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='工作流分类';

-- ----------------------------
-- Records of act_extension_category
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (1, 0, '人事类', 20, '', NULL, '', NULL, NULL);
INSERT INTO `act_extension_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (2, 0, '财务类', 1, '', NULL, '', NULL, NULL);
INSERT INTO `act_extension_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (3, 0, '办公类', 300, '', NULL, '', NULL, NULL);
INSERT INTO `act_extension_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (4, 2, '财务部门', 10, 'entfrm', '2022-09-27 17:48:42', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_extension_cc
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_cc`;
CREATE TABLE `act_extension_cc` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) DEFAULT NULL COMMENT '抄送用户id',
  `process_def_id` varchar(64) DEFAULT NULL COMMENT '流程定义id',
  `process_ins_id` varchar(64) DEFAULT NULL COMMENT '流程实例id',
  `process_def_name` varchar(64) DEFAULT NULL COMMENT '流程标题',
  `process_ins_name` varchar(64) DEFAULT NULL COMMENT '实例标题',
  `task_name` varchar(64) DEFAULT NULL COMMENT '流程节点',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='流程抄送';

-- ----------------------------
-- Records of act_extension_cc
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_cc` (`id`, `user_id`, `process_def_id`, `process_ins_id`, `process_def_name`, `process_ins_name`, `task_name`, `create_by`, `create_time`) VALUES (1, 10, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '', 'entfrm 在 2022-09-27 19:48 发起了 [请假流程]', '', 'entfrm', '2022-09-27 19:48:51');
INSERT INTO `act_extension_cc` (`id`, `user_id`, `process_def_id`, `process_ins_id`, `process_def_name`, `process_ins_name`, `task_name`, `create_by`, `create_time`) VALUES (2, 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', '', 'entfrm 在 2022-09-27 20:10 发起了 [请假流程]', '', 'entfrm', '2022-09-27 20:12:32');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_condition
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_condition`;
CREATE TABLE `act_extension_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `expression` varchar(500) DEFAULT NULL COMMENT '表达式',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='流程表达式';

-- ----------------------------
-- Records of act_extension_condition
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_condition` (`id`, `name`, `expression`, `remarks`) VALUES (1, '不同意', '${disagree}', '不同意');
INSERT INTO `act_extension_condition` (`id`, `name`, `expression`, `remarks`) VALUES (2, '强制结束', '${end}', '强制结束');
INSERT INTO `act_extension_condition` (`id`, `name`, `expression`, `remarks`) VALUES (3, '同意', '${agree}', '同意');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_form_category
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_form_category`;
CREATE TABLE `act_extension_form_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` int(11) DEFAULT '0' COMMENT '父级编号',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='流程表单分类';

-- ----------------------------
-- Records of act_extension_form_category
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_form_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, 0, '基础表单', 10, 'entfrm', '2022-09-27 18:35:39', '', NULL, NULL, '0');
INSERT INTO `act_extension_form_category` (`id`, `parent_id`, `name`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, 0, '高级表单', 20, 'entfrm', '2022-09-27 18:54:50', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_form_def
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_form_def`;
CREATE TABLE `act_extension_form_def` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` int(11) DEFAULT NULL COMMENT '表单定义分类管理id',
  `name` varchar(50) DEFAULT NULL COMMENT '表单定义名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='流程表单';

-- ----------------------------
-- Records of act_extension_form_def
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_form_def` (`id`, `category_id`, `name`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, 7, '请假表单', 'entfrm', '2022-09-27 18:55:11', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_form_def_json
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_form_def_json`;
CREATE TABLE `act_extension_form_def_json` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `form_definition_id` int(11) DEFAULT NULL COMMENT '表单定义id',
  `json` longtext COMMENT '表单设计json数据',
  `version` int(11) DEFAULT NULL COMMENT '版本号',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `is_primary` varchar(64) DEFAULT NULL COMMENT '是否主版本',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='表单定义json';

-- ----------------------------
-- Records of act_extension_form_def_json
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_form_def_json` (`id`, `form_definition_id`, `json`, `version`, `status`, `is_primary`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (1, 1, '{\n  \"enter\": true,\n  \"size\": \"small\",\n  \"labelWidth\": 90,\n  \"labelPosition\": \"right\",\n  \"styleSheets\": \"\",\n  \"column\": [{\n    \"type\": \"input\",\n    \"label\": \"单行文本\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_VyKm9I7H\"\n  }, {\n    \"type\": \"input\",\n    \"label\": \"单行文本\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_fxwWzgAc\"\n  }, {\n    \"type\": \"input\",\n    \"label\": \"单行文本\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_7z86kLKJ\"\n  }],\n  \"customClass\": [],\n  \"eventScript\": [{\n    \"key\": \"mounted\",\n    \"name\": \"mounted\",\n    \"func\": \"\"\n  }],\n  \"dataSource\": [{\n    \"key\": \"upload\",\n    \"name\": \"Get Upload Token\",\n    \"url\": \"http://tools-server.making.link/api/uptoken\",\n    \"method\": \"GET\",\n    \"auto\": true,\n    \"thirdPartyAxios\": false,\n    \"headers\": {},\n    \"params\": {},\n    \"requestFunc\": \"return config;\",\n    \"responseFunc\": \"return res.uptoken;\",\n    \"errorFunc\": \"\"\n  }, {\n    \"key\": \"options\",\n    \"name\": \"Get Options\",\n    \"url\": \"http://tools-server.making.link/api/new/options\",\n    \"method\": \"GET\",\n    \"auto\": true,\n    \"thirdPartyAxios\": false,\n    \"headers\": {},\n    \"params\": {},\n    \"requestFunc\": \"return config;\",\n    \"responseFunc\": \"return res.data;\",\n    \"errorFunc\": \"\"\n  }]\n}\n', 0, '1', '0', 'entfrm', '2022-09-27 19:27:59', 'entfrm', '2022-09-27 19:42:20', '0');
INSERT INTO `act_extension_form_def_json` (`id`, `form_definition_id`, `json`, `version`, `status`, `is_primary`, `create_by`, `create_time`, `update_by`, `update_time`, `del_flag`) VALUES (2, 1, '{\n  \"enter\": true,\n  \"size\": \"small\",\n  \"labelWidth\": 90,\n  \"labelPosition\": \"right\",\n  \"styleSheets\": \"\",\n  \"column\": [{\n    \"type\": \"input\",\n    \"label\": \"请假人\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_VyKm9I7H\"\n  }, {\n    \"type\": \"input\",\n    \"label\": \"请假原因\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_fxwWzgAc\"\n  }, {\n    \"type\": \"input\",\n    \"label\": \"请假备注\",\n    \"labelWidth\": \"\",\n    \"hide\": false,\n    \"hideLabel\": false,\n    \"customClass\": [],\n    \"validateConfig\": {\n      \"required\": false,\n      \"type\": false,\n      \"pattern\": false\n    },\n    \"events\": {\n      \"change\": \"\",\n      \"focus\": \"\",\n      \"blur\": \"\"\n    },\n    \"plugin\": {\n      \"type\": \"text\",\n      \"value\": \"\",\n      \"prepend\": \"\",\n      \"append\": \"\",\n      \"maxlength\": \"\",\n      \"placeholder\": \"\",\n      \"readonly\": false,\n      \"showWordLimit\": false,\n      \"disabled\": false,\n      \"showPassword\": false,\n      \"customizeStyle\": {\n        \"width\": \"100%\"\n      }\n    },\n    \"prop\": \"input_7z86kLKJ\"\n  }],\n  \"customClass\": [],\n  \"eventScript\": [{\n    \"key\": \"mounted\",\n    \"name\": \"mounted\",\n    \"func\": \"\"\n  }],\n  \"dataSource\": [{\n    \"key\": \"upload\",\n    \"name\": \"Get Upload Token\",\n    \"url\": \"http://tools-server.making.link/api/uptoken\",\n    \"method\": \"GET\",\n    \"auto\": true,\n    \"thirdPartyAxios\": false,\n    \"headers\": {},\n    \"params\": {},\n    \"requestFunc\": \"return config;\",\n    \"responseFunc\": \"return res.uptoken;\",\n    \"errorFunc\": \"\"\n  }, {\n    \"key\": \"options\",\n    \"name\": \"Get Options\",\n    \"url\": \"http://tools-server.making.link/api/new/options\",\n    \"method\": \"GET\",\n    \"auto\": true,\n    \"thirdPartyAxios\": false,\n    \"headers\": {},\n    \"params\": {},\n    \"requestFunc\": \"return config;\",\n    \"responseFunc\": \"return res.data;\",\n    \"errorFunc\": \"\"\n  }]\n}\n', 1, '1', '1', 'entfrm', '2022-09-27 19:27:59', '', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_listener
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_listener`;
CREATE TABLE `act_extension_listener` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `listener_type` varchar(64) DEFAULT NULL COMMENT '监听器类型',
  `event` varchar(64) DEFAULT NULL COMMENT '事件',
  `value_type` varchar(64) DEFAULT NULL COMMENT '值类型',
  `value` varchar(500) DEFAULT NULL COMMENT '值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='监听器';

-- ----------------------------
-- Records of act_extension_listener
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_listener` (`id`, `name`, `listener_type`, `event`, `value_type`, `value`) VALUES (1, 'take', '1', 'take', '1', 'com.entfrm.biz.workflow.listener.MyExecutionListener');
INSERT INTO `act_extension_listener` (`id`, `name`, `listener_type`, `event`, `value_type`, `value`) VALUES (2, 'end', '1', 'end', '1', 'com.entfrm.biz.workflow.listener.MyExecutionListener');
INSERT INTO `act_extension_listener` (`id`, `name`, `listener_type`, `event`, `value_type`, `value`) VALUES (3, 'start', '1', 'start', '1', 'com.entfrm.biz.workflow.listener.MyExecutionListener');
COMMIT;

-- ----------------------------
-- Table structure for act_extension_workflow_assignee
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_workflow_assignee`;
CREATE TABLE `act_extension_workflow_assignee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(64) DEFAULT NULL COMMENT '用户类型',
  `value` longtext COMMENT '用户来自值',
  `condition` varchar(255) DEFAULT NULL COMMENT '附加条件',
  `operation_type` varchar(64) DEFAULT NULL COMMENT '运算类型',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `activity_extension_data_id` int(11) DEFAULT NULL COMMENT '活动扩展数据id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='审核人';

-- ----------------------------
-- Records of act_extension_workflow_assignee
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_workflow_assignee` (`id`, `type`, `value`, `condition`, `operation_type`, `sort`, `activity_extension_data_id`) VALUES (10, 'user', '7', '0', '0', 0, 10);
INSERT INTO `act_extension_workflow_assignee` (`id`, `type`, `value`, `condition`, `operation_type`, `sort`, `activity_extension_data_id`) VALUES (11, 'user', '8', '0', '0', 0, 11);
INSERT INTO `act_extension_workflow_assignee` (`id`, `type`, `value`, `condition`, `operation_type`, `sort`, `activity_extension_data_id`) VALUES (12, 'user', '10', '0', '0', 0, 12);
COMMIT;

-- ----------------------------
-- Table structure for act_extension_workflow_button
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_workflow_button`;
CREATE TABLE `act_extension_workflow_button` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '按钮名称',
  `code` varchar(64) DEFAULT NULL COMMENT '编码',
  `is_hide` char(1) DEFAULT '0' COMMENT '是否隐藏',
  `next` varchar(255) DEFAULT NULL COMMENT '下一节点审核人',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `activity_extension_data_id` int(11) DEFAULT NULL COMMENT '活动扩展数据id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COMMENT='按钮设置';

-- ----------------------------
-- Records of act_extension_workflow_button
-- ----------------------------
BEGIN;
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (64, '同意', '_workflow_activity_agree', '0', NULL, 2, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (65, '驳回', '_workflow_activity_reject', '0', NULL, 3, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (66, '指定回退', '_workflow_activity_roll_back', '0', NULL, 4, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (67, '转办', '_workflow_activity_transfer', '0', NULL, 7, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (68, '委派', '_workflow_activity_delegate', '0', NULL, 8, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (69, '终止', '_workflow_activity_stop', '0', NULL, 9, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (70, '打印', '_workflow_activity_print', '0', NULL, 10, 10);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (71, '同意', '_workflow_activity_agree', '0', NULL, 2, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (72, '驳回', '_workflow_activity_reject', '0', NULL, 3, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (73, '指定回退', '_workflow_activity_roll_back', '0', NULL, 4, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (74, '转办', '_workflow_activity_transfer', '0', NULL, 7, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (75, '委派', '_workflow_activity_delegate', '0', NULL, 8, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (76, '终止', '_workflow_activity_stop', '0', NULL, 9, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (77, '打印', '_workflow_activity_print', '0', NULL, 10, 11);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (78, '同意', '_workflow_activity_agree', '0', NULL, 2, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (79, '驳回', '_workflow_activity_reject', '0', NULL, 3, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (80, '指定回退', '_workflow_activity_roll_back', '0', NULL, 4, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (81, '转办', '_workflow_activity_transfer', '0', NULL, 7, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (82, '委派', '_workflow_activity_delegate', '0', NULL, 8, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (83, '终止', '_workflow_activity_stop', '0', NULL, 9, 12);
INSERT INTO `act_extension_workflow_button` (`id`, `name`, `code`, `is_hide`, `next`, `sort`, `activity_extension_data_id`) VALUES (84, '打印', '_workflow_activity_print', '0', NULL, 10, 12);
COMMIT;

-- ----------------------------
-- Table structure for act_extension_workflow_condition
-- ----------------------------
DROP TABLE IF EXISTS `act_extension_workflow_condition`;
CREATE TABLE `act_extension_workflow_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `field` varchar(64) DEFAULT NULL COMMENT '变量名',
  `compare` varchar(64) DEFAULT NULL COMMENT '比较类型',
  `value` varchar(64) DEFAULT NULL COMMENT '比较值',
  `logic` varchar(64) DEFAULT NULL COMMENT '运算类型',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `activity_extension_data_id` varchar(64) DEFAULT NULL COMMENT '活动扩展数据id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流程条件';

-- ----------------------------
-- Records of act_extension_workflow_condition
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ge_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_bytearray`;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_bytearray
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('0a2d5df7-3e59-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.bpmn20.xml', '0a2d5df6-3e59-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E6B581E7A88B5F46615942777A4F392220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3064643061646E2220736F757263655265663D224576656E745F393575504A59314D22207461726765745265663D2241637469766974795F30736A7830726F223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F316168346C66362220736F757263655265663D2241637469766974795F30736A7830726F22207461726765745265663D2241637469766974795F30353837646B30223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D3922206E616D653D22E5B08FE78CAAE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F307A306A3730782220736F757263655265663D2241637469766974795F30353837646B3022207461726765745265663D2241637469766974795F31383134676D39223E3C2F73657175656E6365466C6F773E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31786C617662762220736F757263655265663D2241637469766974795F31383134676D3922207461726765745265663D224576656E745F31656339393535223E3C2F73657175656E6365466C6F773E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F31786C61766276222069643D2242504D4E456467655F466C6F775F31786C61766276223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223731392E3934393939393939393937382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223738322E302220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F3064643061646E222069643D2242504D4E456467655F466C6F775F3064643061646E223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223234342E39343939393835343937303035352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239392E393939393939393939393535372220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F316168346C6636222069643D2242504D4E456467655F466C6F775F316168346C6636223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223339392E39353030303030303030303030352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223435392E39393939393939393939353138352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F307A306A373078222069643D2242504D4E456467655F466C6F775F307A306A373078223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223535392E393439393939393939383431392220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223631392E393939393939393939393531382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('0a43f338-3e59-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.Process_FaYBwzO9.png', '0a2d5df6-3e59-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C9330000187C4944415478DAEDDD0B905775D90770BA5B59515959D96465E54C16566F65935D751A354AA62064C1D0A50D5342BC2065E02B64128A50AC8E999468162F83032A39BDAF8BC8255C8C770C4182C40BAF5C566E8A5C12013DEF79CE70768E0BAB20BBFBFF9FE5F3997966FD5FD85D77BF7B9EF33BE7777EA74B170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080039124C96B1F7BECB1A90B162C78FE9E7BEE491A1A1A5407D7CC993393B973E76E4CAB9FFCC983FCC99FFC01401B8A663F6FDEBC64FDFAF5C973CF3DA72A541B366C48E6CC99F34CDAFC7BCA9F923FF9933F006823716453B3AF9AA6FF5C4343C332F953F2277FF207006D24A67168B6D55369C3DF257F4AFEE44FFE00A08DC41C6A8DB6AA1A7E227F4AFEE44FFE00A0831BFEB6CD4DC9630B6F4A96CE1C9555FC773CA7496BF8F2277FF2A7E40F805237FCAD4FAF491EFA9F11C983770D7D51C573F19A46ADE1CB9FFCC99F923F004ADBF0572DBD73AF669FD7EAA533346A0D5FFEE44FFE94FC0150DE86BFECDE31AD36FC784DA3D6F0E54FFEE44FC91F00A56DF80F355CDE6AC38FD7346A0D5FFEE44FFE94FC01A0E12B0D5FFEE44FFE94FC01506D0D3F56256AADE1C76B1AB5862F7FF2277F4AFE00286DC35F31FFDA561B7EBCA6516BF8F2277FF2A7E40F80D236FC4D6B16270FDDFD9F7B4FE7489F8BD7346A0D5FFEE44FFE94FC0150DA861FF5F8FFDEB257C38FE734690D5FFEE44FFE94FC0150EE86BF6347B2E2BEEBF79ECE913E17AF69D41ABEFCC99FFC29F903A0940D3FEE24FEF0FCFA56E7B0C76BEE36AEE1CB9FFCC99F923F00CAD5F077EC489A56CC4A96FCF7A5AD36FBBCE23DF15E473B357CF9933FF953F20740D537FC973BAAE968A7862F7FF2277FF2277F0094B6E1EFCF51CD973ADAA9716BF8F2277FF2A7E40F80AA6DF8AFB4D9E7A5716BF8F2277FF2A7E40F80AA6DF84AC3973FF9933F257FD5E9ACB3CEEA7AC61967F44CAB3EADC6B49AD24A0A158F1B7BF7EE7D639F3E7DFAA575849F1A7402AB57AFEE367DFAF45F5F77DD750F0D1F3E7CEBA041839EEFDBB76FF31F7F5D5DDDCE8B2EBA68D3C89123E78E1D3BF69C746371989F9A86AFE1CB9F923FBF77F92B8B7400D33DDDA799910E6076B718E0BC6CA5FFA621AD1E5FFBDAD75EEB2709259224C96B1B1B1B2F99306142533AA049468F1E9D4C9B362D59B46851B266CD9A64F7EEDD496ED3A64DC9E2C58B93DB6FBF3DB9F6DA6B9374C0B37BE8D0A1F7D5D6D67633E0D1F0357CF953F2A7E4AF5AA50396FF48072B0B0E7490D34A2D4C3FD7297EAA500273E6CCA91D3F7EFCD673CF3D37993A756AD2D4D4941C88A79F7E3ADBB09E77DE79BB060F1E3C3FDD001C6DC0A3347CF9933FF953F2572DE26C4C3A3819BDAF333AC3860DCBF67FE6CF9F9F3CF1C413C9B3CF3E9BEDDFECDCB9337BBC60C182EC20F08811235A1BF8D49BED02557C5667CA94294B6A6B6B93C9932737FF81BF52711628CEFA9C79E699BB060C1830CC804769F8F2277FF2A7E4AFD2FAF6ED7B54CBB33AE9BE4A72D34D371DF041DE952B572613274E8CD92D2D073D4BE2EBF869431549FFC08FAEAFAF5F3F64C890EC8FB72DC5E7BBE0820B9EADABABBBF5503BE2A1E16BF8F2A7E44FC95FF548073AC7D6D4D4AC2D0E4E62DAFEFAF5EB0F6A5F27A6F78F1A35AAE5A067D5A13CCB05AA6EB01353D8E2D46C4C476B0F71B6E897BFFCE5F6010306FCF550BAA84FC3D7F0E54FC99F92BFEA39B3531CECC4599DD9B367BFE8BAE483356FDEBCECF31AF4401589696C716627063B073B856D7FA6B85D71C5155BD20DC1440D5F69F8F2277FF2A7E4AFA3ECB966A7791A5BAC36BB7CF9F276D9DF896B7C5A4C715BD2AB57AFC3ED754285C4353B318D6DCB962D49478841D5E0C183B7A41B9A4B347CA5E1CB9FFCC99F92BF8E100B1414CFECB4D760A738E829DEC2231632B0D709153077EEDCBA58A0A0ADAFD9D99F6B7AD28DC0B3BD7AF53A46C3571ABEFCC99FFC29F96B4F7B969E6E5E8D2DA6B1758498DED6E27E3D96AC868E1453D9AEB9E69A6DB11A5B254C9B366D733AE899A6E12B0D5FFEE44FFE94FCB5F3D99D05C5050ADAF29A9D97D3622183856E4E0A1D286E2A1AF7D969EFEB765EEA7A9EDADADA75353535C76BF84AC3973FF9933F257FEDA177EFDEDD8B53D90E7635B657B27A5BF17A9E74F0D5C35E28749071E3C635C54DB52A69C68C19B172C91F357CA5E1CB9FFCC99F92BFF690EE67CCC8071B719F9D4AB8F5D65B8B039E067BA1D00156AF5EDDADAEAEEE806FAED5D66209EC9A9A9AA73AF3BD79347C0D5FFE94FC29F9AB8C74FFA26BF1DA9D4AEDF7C459A5E20206E9F77484BD516867D3A74FFFF555575D9554839FFDEC670BE37473D97E86718426AD13357C0D5FFE94FCC99FFC55670ED3C145CF7C90316CD8B08AEEEFC4ED3F0A039E7EF646A19D4D983061E9B469D3AA62C03369D2A425655CAAB1786A3A1DB09DA0E16BF8F2A7E44FFEE4AFBA7218FB17F9FB2A3D8D3FF6BBF2EF25FD7E6FB4370AED6CF8F0E15B172D5A5415039E071E786045FAC7DF58D60D6DA1FEBAAF234D1ABE862F7F4AFE94FC552687B17F91BF3E7FFEFC8AEEEFC47D790ADF6B6317A07D0D1A34E8F94A5FBF93DBB871E3B6F40FBFA9136C689B8F341537B81ABE862F7F4AFE94FC552687B17F913FFFC4134F54747F67CD9A35C5EFB3A90BD0BEE2C2B98E5C83FEE5C41F7F67D9D0168F34C529760D5FC3973F257F4AFE2A93C3E2E39D3B7756745F27BE7EF1FBB1370A1DB091A826FBB1D12A6D69F8D5559D396BF2277FF2A7E4AFF5AAB6FD1D7BA370689DE1D9DAC9CEF064ABCEE57752AE74C3DFB06143326BD6ACE4C9279FDCE7EB8F3FFE78F671C58A15D9C73BEEB82379F8E18793D5AB5727B7DD765BB27DFBF67DFEBB980BFD9BDFFCA6D5AFBB6CD9B264FAF4E9D97F3FF0C003D9E7DBB1634772FFFDF727EBD6AD7384B313E6EFE5B27630B575EBD664E5CA9559EE6EB8E186ECEB943197F2575DDBBFFC771EBFFFFCFD37DE7863968B97FABCB67FE5C961F1F94ADD68DD191EA8901FFFF8C7CF55CB353CE9C6FFA14E720DCF8B1A7DAED20D7FF6ECD9B1518D9BBCEEF5DADD77DF9DBCE10D6F88A5C1B38F31D079CF7BDE935C77DD757963CC7600B66CD9923436362683060D4ACE3FFFFCAC8E3DF6D8ECF573CE39A7F9B978FDBEFBEECB3EF7F5D75F9F74EDDA35FBEF0F7EF083C995575E99FDF7EB5FFFFAE4CF7FFEB386DF09F3F752598B9DC3B7BEF5ADC9BBDEF5AE562BF2926E9B92CD9B37271FFBD8C792238F3C327B2EB2199FB758353535D90E64D972297FD5B3FD5BBE7C7972F8E1872743870E4D5EF39AD7641FFFF297BF64EFBFF9E69B937FFEF39FC9E73EF7B9ECC08FED5F797358BC86270E9AB886070E21975C72C993D5B24A5BDA4866977C95B6C63E7DFAF468D9E82BDDF0FFF5AF7F6547C5E3886234E6F83E9E7AEAA96C5093BF67D3A64DCD8DFB94534E493EF0810F648D3F763EDFFBDEF766CFC773E79D775E3279F2E4E455AF7A553260C080AC4E3FFDF4EC7D6973697EEED5AF7E757637E93973E624679F7D76B6333165CA94E4E31FFF7872F5D557675FF34D6F7A53B634E7BC79F392C58B176BF89D207FFB93B5254B966477389F34695272CB2DB764153B95F1313212FF6EE0C081592E366EDC98E5EDD39FFE74F2D5AF7E35193B766CF3E7FDCA57BE920D86962E5DDAFCBE32E552FEAA67FB1737BE3EF1C413B3D77FFAD39F26DFFEF6B793CF7EF6B3D9E36EDDBA6503960F7FF8C3C9238F3C62FB57E21C5AA50D0E61A3468DBABB5AEEC3336EDCB81925BD0FCF3E8F685643C35FBB766DD69CAFB9E69AE4EF7FFF7B73C3BFE8A28BB2261D47C6E37D3FF9C94FB2014DBC1E3B080F3EF8603600FAD5AF7E95FCE94F7FCADE1B472CE3887B4C6D4B07CAC9D7BFFEF5E4A4934ECA8E7CC6BFFBD297BE943DFEC637BE91ED34C44EC6EDB7DF9E7CEF7BDFCB9A7B1CD98F86FFF9CF7F3E3B0A1ACFF5EBD72F79DDEB5E97D4D7D76BF825CFDFFE662D2A3F7ADEF24C4DBC16FF1D83A1F8EFD8698CC7EF7BDFFB5AADD8B9FCC31FFE50BA5CCA5FF56CFFE2404E6CFF626073C105172431D53BDD69CEDE9F0F7C2243698FB2FD2B710E8BF7E18901A8FBF0C02164CC9831678F1D3BF6856A18F00C1C3870466CB03AEBCFBA120D3FA66044338EA35979C39F397366F30E677EFD43CC6B8FA3E4D1F063DE7ACB9DD1BC625A48BC3F8EC01F7DF4D1D9DDAA7FF0831F64AF9D7BEEB9D9E3783EA677E4DFC3EF7EF7BBE49DEF7C67766D5034FC38521A1BF968F8F1EF6267C3948EF2E76F7FB356F8D96747C0FFF18F7F64676BFAF7EFBFD78027CEFABCED6D6FCBAE278B23E8A79E7A6A3625A9586F7FFBDB93891327962E97F2573DDBBF58A23806479FFAD4A792E38E3B2EF9E637BF997CF9CB5FCEDE73C4114764677C4E3BEDB4E417BFF885ED5FB907453DF34146FCAE2A69C48811C5A5B3FBD91B857676D659671D565B5BBB33A63455F81E3C71FDCE86F87E34FCB6ABBABABA6C87318E4A161BFEB66DDBB21DC5EEDDBB37BF77C28409D9EB31E5223EC6D1F5988E118D3EA63DC673F9BCF468E8EF7FFFFB93343BD9EBF15A6CB8E3711C75CF1B7EECCCC6D1D2783D9A7DCB291D3FFCE10FCD61EF24F93B90ACE5039EFC02F2EF7CE73BFB1CF0C445DD9191F8F7F1FC9BDFFCE66C0734AFD8918CDCE5177F972997F2575DDBBF380313AFC7A03AAEAD79F7BBDF9D3DFED6B7BE950C1932243BAB93BFD7F6AFB4FB3B5DD3DFD3AE7CA0F1E8A38F56647F67FDFAF57146FB85C280E7087BA3D001860D1B766F1C29ADA4FAFAFA9BD33FFC3F6AF86D57B1EA5A5CE41D0D371E171B7E3C4E37FED9E3787EFCF8F1D9D48FD8A18C234FF17C4CC5886B27E23A89B880BCE580E7A8A38ECA3E7EF7BBDFCD5E8BE919C5E7F31D8E782D9AFBDFFEF6B77DCE612F4E75D2F0CB99BF03C95A71C0135379623ADA673EF3997D0E78F28A1D9398BA16EFF9ED6F7FDB5CB14A5BACB654DC112D4B2EE5AF7AB67FB1B040E4EB431FFAD08BCE68C73630A6B67DE10B5FC816CE2863CEE46FAFB33C33F281466C3F2A210E26166F8C6A2F143A486D6D6DB71FFDE847BB2BB54CE3EEDDBB57A57FF48FD4D4D41CAFE1B75DC5148B68B60B172EDC67C38FB336B130418F1E3D923BEFBC335BA12DE69FC7C778DF17BFF8C56C0720162D88850C5A0E788E39E698E4F2CB2FCF2ED28DD7625E7C3CFEC8473ED2DCF063F5A3B8D03C8EC4C7E37D35FC2BAEB8221B6469F8E5CDDF8164AD38E079CB5BDE92ADD8161F636A506B039E91234736EF847EE2139FC8AE9B8823F7F138AE9328EE88962597F2573DDBBF9FFFFCE7C985175E98ADCE16D3DA2EBEF8E2E6EBCAE2AC4D4C6F8B333A65CC99FCBD584C9BCF071B679E796676B6A523C56C9AFEFDFB17CFEEF4B0170A1DE8FCF3CF9F53A9C50BAEBCF2CA49E91FFE540DBF6D2B8E5EF5ECD9B3F971CB869FCF458FF7E58FE302DD68DAF9FBE2E2DAEF7FFFFBD9AA46C5014F34F968E231D7FD84134EC85E8BEB30E2713C5F9CAA91CF61CF1B7E4C938B269F37FCB84838BE86865FDEFC1D68D6EEBAEBAE6C4A512C89DFF273B51CF0C492C031288A8535E2FA8A18F0C445E171F4FEB2CB2E7BD1BF2D532EE5AF7AB67FCF3CF34CF32029A6B4E5EF8D4CC4E02556082C0E786CFF4A7F96A779B5B651A34675E8BD08E3EB1597CE7EB9C53E8036D6AB57AF23D30DF1731DBD367DBA333327FDA3DF9A7EFD6334FCF6A9980E1417DD4643EE525878A05831DD2276220F3BECB06C67B3CB9E65A8DFF18E776447DF3FFAD18F66CFC5FBE2FDB1946A7EC16FFC77BC96DFB834FE3FF381517C8CA36871BD450C9EDEF8C6376653E7629A482CD57AF2C92767F7A68823AC1A7EF9F3B73F59DB57C551CFC85F7E2627BF3F495C6C1E53892287718D452C5C10AF4786F255AE468F1E9DDDD0B16CB994BFEAD9FEC5820271A027161C884504F225AC63F0136780626A6F5C9B93BFDFF6AFDCD201E6C9C57BF644263A4264A5F875D31C9C62EF132AA0A6A666F0902143FEDD5153DBB66FDFBE34FD9A4BD33FFC8B35FCF6ABF87DC691CE38FA18471EE3E6A12DDF130D3E7608620A47DC102D063B71F43CEE97121547416367201FF0B4BCA15F1CC18C23F12D5FFBFDEF7F9F4D8B8B6B80860F1F9E2D731DF7B288D7AEBAEAAAEC82E09832B26AD52A0DBF13E46F7FB2D65A45FE3EF9C94F66CBFDE6677EE2004CEC1CDE7BEFBDD9FD50E29A8898C21603A4B81F4A1C693FFEF8E39B3355A65CCA5FF56CFF629B175378E37A9F1820C5EA8171A0278EC68F1933263B03130393D66E686AFB57CAB33C57E7038FF8BDC760A4BDEFBBD3AF5FBF170A039EFA2E40E5A43B10B78C1C39B2DD073DBB77EF5E996EE867A57FF4D76BF8CA45BBF2277FF2A7E4AFA3C454B2E2D4B618F4B4D7CD4863B0D3BF7FFFE70B839D25BD7AF53ADC1E27547823900E44EEB8ECB2CBB6B4D7A027CEECA403AB7BE3BA9DCEBC0CB586AFE1CB9F923FF993BFEA940E728E4AF7435614073D71C6AE2DAFE98933472DCEECAC4AEB687B9B5025839E9A9A9A1B060F1EBCA5ADAFE9896B76F64C63BBFE501AEC68F81ABEFC29F9F37B97BFEA12838FE2A0275FC8E060576F8B69B72D162830D8816AD5BB77EF417DFBF6DD3665CA94A777EEDC79D04B4FEF598D6DEBA172CD8E86AFE1CB9F923FF993BF529CE9692C0E4E62B189B87E35AE273CD09B8AC67D768A4B4FE7D3D80C76A08AC5EA6D7DFAF4B92DFDE3DD3C75EAD447376DDAB4EB40FEF8376EDCF850DC5434FD1CCB630A5BFAF1D843F567A9E16BF8F2A7E44FC95FF589992DBD7BF71EDF629092D5A5975E9A4C993225BBC62766BDE40780E3632C7811D7E8C4622A713FA59A9A9A17F6F139EA5DB303E539DB735C5A37A67FCC5B2EBCF0C24513274E5C74FFFDF73FBA76EDDAED85F1CDD618E0343636CE1E376EDC8C810307C61D8D37A4839CC99DFDA6A21ABE862F7F4AFEE44FFECA6DCF92D58DFB1AF8BC825A68E96928A9B8EE66CF062196748C85071E4F6B57E10FBC69CFC6A23EEE687CA85DA7A3E16BF8F2A7E44FFEE4AFF40779BBA7FB31335AECDFEC57A5839C86B47AB8A92860C0A3347CF9933FF953F257ED0779BBA6839F33E220EE9E83B94D2D0638D941DE9801930E72FAC565007E6A80018F46ABE1CB9F923F257F0068F84AC3973FF9933F257F0068F84AC3973FF9933F257F0068F8CA0EA7DFBBFCC99F32E00140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257F7EEFF2078086AF347CF9933FF953F2078086AF347CF9933FF953F2078086AF347CF9933FF953063C0068F81ABEFC29F9933FF903000D5FC3973F257FF2277F00A0E16BF8F2A7E44FFEE40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5FC3B7C3A9E44FFEE40F00DACA3DF7DCA3D1564F3D9B36FC5DF2A7E44FFEE40F00DAC8DCB9739BD6AF5FAFD95641AD59B3E6BFD286BF4CFE94FCC99FFC01401B99356BD6E9B367CFDEBC6EDDBA7F6BBA953BB219CD7EE6CC99FF97564FF953F2277FF207006D286D32DD1B1A1A16C674829843AD3ABCE2E7BEEC506DF6F2277FF2277F063B00000000000000000000000000000000000000000000000000000000006DE0FF019B4266A3D06D18040000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3c869e6b-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.bpmn20.xml', '3c869e6a-3e59-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E8AFB7E58187E6B581E7A88B2220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3064643061646E2220736F757263655265663D224576656E745F393575504A59314D22207461726765745265663D2241637469766974795F30736A7830726F223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F316168346C66362220736F757263655265663D2241637469766974795F30736A7830726F22207461726765745265663D2241637469766974795F30353837646B30223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D3922206E616D653D22E5B08FE78CAAE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F307A306A3730782220736F757263655265663D2241637469766974795F30353837646B3022207461726765745265663D2241637469766974795F31383134676D39223E3C2F73657175656E6365466C6F773E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31786C617662762220736F757263655265663D2241637469766974795F31383134676D3922207461726765745265663D224576656E745F31656339393535223E3C2F73657175656E6365466C6F773E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F31786C61766276222069643D2242504D4E456467655F466C6F775F31786C61766276223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223731392E3934393939393939393937382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223738322E302220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F3064643061646E222069643D2242504D4E456467655F466C6F775F3064643061646E223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223234342E39343939393835343937303035352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239392E393939393939393939393535372220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F316168346C6636222069643D2242504D4E456467655F466C6F775F316168346C6636223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223339392E39353030303030303030303030352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223435392E39393939393939393939353138352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F307A306A373078222069643D2242504D4E456467655F466C6F775F307A306A373078223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223535392E393439393939393939383431392220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223631392E393939393939393939393531382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('3c9d81cc-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.Process_FaYBwzO9.png', '3c869e6a-3e59-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C9330000187C4944415478DAEDDD0B905775D90770BA5B59515959D96465E54C16566F65935D751A354AA62064C1D0A50D5342BC2065E02B64128A50AC8E999468162F83032A39BDAF8BC8255C8C770C4182C40BAF5C566E8A5C12013DEF79CE70768E0BAB20BBFBFF9FE5F3997966FD5FD85D77BF7B9EF33BE7777EA74B170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080039124C96B1F7BECB1A90B162C78FE9E7BEE491A1A1A5407D7CC993393B973E76E4CAB9FFCC983FCC99FFC01401B8A663F6FDEBC64FDFAF5C973CF3DA72A541B366C48E6CC99F34CDAFC7BCA9F923FF9933F006823716453B3AF9AA6FF5C4343C332F953F2277FF207006D24A67168B6D55369C3DF257F4AFEE44FFE00A08DC41C6A8DB6AA1A7E227F4AFEE44FFE00A0831BFEB6CD4DC9630B6F4A96CE1C9555FC773CA7496BF8F2277FF2A7E40F805237FCAD4FAF491EFA9F11C983770D7D51C573F19A46ADE1CB9FFCC99F923F004ADBF0572DBD73AF669FD7EAA533346A0D5FFEE44FFE94FC0150DE86BFECDE31AD36FC784DA3D6F0E54FFEE44FC91F00A56DF80F355CDE6AC38FD7346A0D5FFEE44FFE94FC01A0E12B0D5FFEE44FFE94FC01506D0D3F56256AADE1C76B1AB5862F7FF2277F4AFE00286DC35F31FFDA561B7EBCA6516BF8F2277FF2A7E40F80D236FC4D6B16270FDDFD9F7B4FE7489F8BD7346A0D5FFEE44FFE94FC0150DA861FF5F8FFDEB257C38FE734690D5FFEE44FFE94FC0150EE86BF6347B2E2BEEBF79ECE913E17AF69D41ABEFCC99FFC29F903A0940D3FEE24FEF0FCFA56E7B0C76BEE36AEE1CB9FFCC99F923F00CAD5F077EC489A56CC4A96FCF7A5AD36FBBCE23DF15E473B357CF9933FF953F20740D537FC973BAAE968A7862F7FF2277FF2277F0094B6E1EFCF51CD973ADAA9716BF8F2277FF2A7E40F80AA6DF8AFB4D9E7A5716BF8F2277FF2A7E40F80AA6DF84AC3973FF9933F257FD5E9ACB3CEEA7AC61967F44CAB3EADC6B49AD24A0A158F1B7BF7EE7D639F3E7DFAA575849F1A7402AB57AFEE367DFAF45F5F77DD750F0D1F3E7CEBA041839EEFDBB76FF31F7F5D5DDDCE8B2EBA68D3C89123E78E1D3BF69C746371989F9A86AFE1CB9F923FBF77F92B8B7400D33DDDA799910E6076B718E0BC6CA5FFA621AD1E5FFBDAD75EEB2709259224C96B1B1B1B2F99306142533AA049468F1E9D4C9B362D59B46851B266CD9A64F7EEDD496ED3A64DC9E2C58B93DB6FBF3DB9F6DA6B9374C0B37BE8D0A1F7D5D6D67633E0D1F0357CF953F2A7E4AF5AA50396FF48072B0B0E7490D34A2D4C3FD7297EAA500273E6CCA91D3F7EFCD673CF3D37993A756AD2D4D4941C88A79F7E3ADBB09E77DE79BB060F1E3C3FDD001C6DC0A3347CF9933FF953F2572DE26C4C3A3819BDAF333AC3860DCBF67FE6CF9F9F3CF1C413C9B3CF3E9BEDDFECDCB9337BBC60C182EC20F08811235A1BF8D49BED02557C5667CA94294B6A6B6B93C9932737FF81BF52711628CEFA9C79E699BB060C1830CC804769F8F2277FF2A7E4AFD2FAF6ED7B54CBB33AE9BE4A72D34D371DF041DE952B572613274E8CD92D2D073D4BE2EBF869431549FFC08FAEAFAF5F3F64C890EC8FB72DC5E7BBE0820B9EADABABBBF5503BE2A1E16BF8F2A7E44FC95FF548073AC7D6D4D4AC2D0E4E62DAFEFAF5EB0F6A5F27A6F78F1A35AAE5A067D5A13CCB05AA6EB01353D8E2D46C4C476B0F71B6E897BFFCE5F6010306FCF550BAA84FC3D7F0E54FC99F92BFEA39B3531CECC4599DD9B367BFE8BAE483356FDEBCECF31AF4401589696C716627063B073B856D7FA6B85D71C5155BD20DC1440D5F69F8F2277FF2A7E4AFA3ECB966A7791A5BAC36BB7CF9F276D9DF896B7C5A4C715BD2AB57AFC3ED754285C4353B318D6DCB962D49478841D5E0C183B7A41B9A4B347CA5E1CB9FFCC99F92BF8E100B1414CFECB4D760A738E829DEC2231632B0D709153077EEDCBA58A0A0ADAFD9D99F6B7AD28DC0B3BD7AF53A46C3571ABEFCC99FFC29F96B4F7B969E6E5E8D2DA6B1758498DED6E27E3D96AC868E1453D9AEB9E69A6DB11A5B254C9B366D733AE899A6E12B0D5FFEE44FFE94FCB5F3D99D05C5050ADAF29A9D97D3622183856E4E0A1D286E2A1AF7D969EFEB765EEA7A9EDADADA75353535C76BF84AC3973FF9933F257FEDA177EFDEDD8B53D90E7635B657B27A5BF17A9E74F0D5C35E28749071E3C635C54DB52A69C68C19B172C91F357CA5E1CB9FFCC99F92BFF690EE67CCC8071B719F9D4AB8F5D65B8B039E067BA1D00156AF5EDDADAEAEEE806FAED5D66209EC9A9A9AA73AF3BD79347C0D5FFE94FC29F9AB8C74FFA26BF1DA9D4AEDF7C459A5E20206E9F77484BD516867D3A74FFFF555575D9554839FFDEC670BE37473D97E86718426AD13357C0D5FFE94FCC99FFC55670ED3C145CF7C90316CD8B08AEEEFC4ED3F0A039E7EF646A19D4D983061E9B469D3AA62C03369D2A425655CAAB1786A3A1DB09DA0E16BF8F2A7E44FFEE4AFBA7218FB17F9FB2A3D8D3FF6BBF2EF25FD7E6FB4370AED6CF8F0E15B172D5A5415039E071E786045FAC7DF58D60D6DA1FEBAAF234D1ABE862F7F4AFE94FC552687B17F91BF3E7FFEFC8AEEEFC47D790ADF6B6317A07D0D1A34E8F94A5FBF93DBB871E3B6F40FBFA9136C689B8F341537B81ABE862F7F4AFE94FC552687B17F913FFFC4134F54747F67CD9A35C5EFB3A90BD0BEE2C2B98E5C83FEE5C41F7F67D9D0168F34C529760D5FC3973F257F4AFE2A93C3E2E39D3B7756745F27BE7EF1FBB1370A1DB091A826FBB1D12A6D69F8D5559D396BF2277FF2A7E4AFF5AAB6FD1D7BA370689DE1D9DAC9CEF064ABCEE57752AE74C3DFB06143326BD6ACE4C9279FDCE7EB8F3FFE78F671C58A15D9C73BEEB82379F8E18793D5AB5727B7DD765BB27DFBF67DFEBB980BFD9BDFFCA6D5AFBB6CD9B264FAF4E9D97F3FF0C003D9E7DBB1634772FFFDF727EBD6AD7384B313E6EFE5B27630B575EBD664E5CA9559EE6EB8E186ECEB943197F2575DDBBFFC771EBFFFFCFD37DE7863968B97FABCB67FE5C961F1F94ADD68DD191EA8901FFFF8C7CF55CB353CE9C6FFA14E720DCF8B1A7DAED20D7FF6ECD9B1518D9BBCEEF5DADD77DF9DBCE10D6F88A5C1B38F31D079CF7BDE935C77DD757963CC7600B66CD9923436362683060D4ACE3FFFFCAC8E3DF6D8ECF573CE39A7F9B978FDBEFBEECB3EF7F5D75F9F74EDDA35FBEF0F7EF083C995575E99FDF7EB5FFFFAE4CF7FFEB386DF09F3F752598B9DC3B7BEF5ADC9BBDEF5AE562BF2926E9B92CD9B37271FFBD8C792238F3C327B2EB2199FB758353535D90E64D972297FD5B3FD5BBE7C7972F8E1872743870E4D5EF39AD7641FFFF297BF64EFBFF9E69B937FFEF39FC9E73EF7B9ECC08FED5F797358BC86270E9AB886070E21975C72C993D5B24A5BDA4866977C95B6C63E7DFAF468D9E82BDDF0FFF5AF7F6547C5E3886234E6F83E9E7AEAA96C5093BF67D3A64DCD8DFB94534E493EF0810F648D3F763EDFFBDEF766CFC773E79D775E3279F2E4E455AF7A553260C080AC4E3FFDF4EC7D6973697EEED5AF7E757637E93973E624679F7D76B6333165CA94E4E31FFF7872F5D557675FF34D6F7A53B634E7BC79F392C58B176BF89D207FFB93B5254B966477389F34695272CB2DB764153B95F1313212FF6EE0C081592E366EDC98E5EDD39FFE74F2D5AF7E35193B766CF3E7FDCA57BE920D86962E5DDAFCBE32E552FEAA67FB1737BE3EF1C413B3D77FFAD39F26DFFEF6B793CF7EF6B3D9E36EDDBA6503960F7FF8C3C9238F3C62FB57E21C5AA50D0E61A3468DBABB5AEEC3336EDCB81925BD0FCF3E8F685643C35FBB766DD69CAFB9E69AE4EF7FFF7B73C3BFE8A28BB2261D47C6E37D3FF9C94FB2014DBC1E3B080F3EF8603600FAD5AF7E95FCE94F7FCADE1B472CE3887B4C6D4B07CAC9D7BFFEF5E4A4934ECA8E7CC6BFFBD297BE943DFEC637BE91ED34C44EC6EDB7DF9E7CEF7BDFCB9A7B1CD98F86FFF9CF7F3E3B0A1ACFF5EBD72F79DDEB5E97D4D7D76BF825CFDFFE662D2A3F7ADEF24C4DBC16FF1D83A1F8EFD8698CC7EF7BDFFB5AADD8B9FCC31FFE50BA5CCA5FF56CFFE2404E6CFF626073C105172431D53BDD69CEDE9F0F7C2243698FB2FD2B710E8BF7E18901A8FBF0C02164CC9831678F1D3BF6856A18F00C1C3870466CB03AEBCFBA120D3FA66044338EA35979C39F397366F30E677EFD43CC6B8FA3E4D1F063DE7ACB9DD1BC625A48BC3F8EC01F7DF4D1D9DDAA7FF0831F64AF9D7BEEB9D9E3783EA677E4DFC3EF7EF7BBE49DEF7C67766D5034FC38521A1BF968F8F1EF6267C3948EF2E76F7FB356F8D96747C0FFF18F7F64676BFAF7EFBFD78027CEFABCED6D6FCBAE278B23E8A79E7A6A3625A9586F7FFBDB93891327962E97F2573DDBBF58A23806479FFAD4A792E38E3B2EF9E637BF997CF9CB5FCEDE73C4114764677C4E3BEDB4E417BFF885ED5FB907453DF34146FCAE2A69C48811C5A5B3FBD91B857676D659671D565B5BBB33A63455F81E3C71FDCE86F87E34FCB6ABBABABA6C87318E4A161BFEB66DDBB21DC5EEDDBB37BF77C28409D9EB31E5223EC6D1F5988E118D3EA63DC673F9BCF468E8EF7FFFFB93343BD9EBF15A6CB8E3711C75CF1B7EECCCC6D1D2783D9A7DCB291D3FFCE10FCD61EF24F93B90ACE5039EFC02F2EF7CE73BFB1CF0C445DD9191F8F7F1FC9BDFFCE66C0734AFD8918CDCE5177F972997F2575DDBBF380313AFC7A03AAEAD79F7BBDF9D3DFED6B7BE950C1932243BAB93BFD7F6AFB4FB3B5DD3DFD3AE7CA0F1E8A38F56647F67FDFAF57146FB85C280E7087BA3D001860D1B766F1C29ADA4FAFAFA9BD33FFC3F6AF86D57B1EA5A5CE41D0D371E171B7E3C4E37FED9E3787EFCF8F1D9D48FD8A18C234FF17C4CC5886B27E23A89B880BCE580E7A8A38ECA3E7EF7BBDFCD5E8BE919C5E7F31D8E782D9AFBDFFEF6B77DCE612F4E75D2F0CB99BF03C95A71C0135379623ADA673EF3997D0E78F28A1D9398BA16EFF9ED6F7FDB5CB14A5BACB654DC112D4B2EE5AF7AB67FB1B040E4EB431FFAD08BCE68C73630A6B67DE10B5FC816CE2863CEE46FAFB33C33F281466C3F2A210E26166F8C6A2F143A486D6D6DB71FFDE847BB2BB54CE3EEDDBB57A57FF48FD4D4D41CAFE1B75DC5148B68B60B172EDC67C38FB336B130418F1E3D923BEFBC335BA12DE69FC7C778DF17BFF8C56C0720162D88850C5A0E788E39E698E4F2CB2FCF2ED28DD7625E7C3CFEC8473ED2DCF063F5A3B8D03C8EC4C7E37D35FC2BAEB8221B6469F8E5CDDF8164AD38E079CB5BDE92ADD8161F636A506B039E91234736EF847EE2139FC8AE9B8823F7F138AE9328EE88962597F2573DDBBF9FFFFCE7C985175E98ADCE16D3DA2EBEF8E2E6EBCAE2AC4D4C6F8B333A65CC99FCBD584C9BCF071B679E796676B6A523C56C9AFEFDFB17CFEEF4B0170A1DE8FCF3CF9F53A9C50BAEBCF2CA49E91FFE540DBF6D2B8E5EF5ECD9B3F971CB869FCF458FF7E58FE302DD68DAF9FBE2E2DAEF7FFFFBD9AA46C5014F34F968E231D7FD84134EC85E8BEB30E2713C5F9CAA91CF61CF1B7E4C938B269F37FCB84838BE86865FDEFC1D68D6EEBAEBAE6C4A512C89DFF273B51CF0C492C031288A8535E2FA8A18F0C445E171F4FEB2CB2E7BD1BF2D532EE5AF7AB67FCF3CF34CF32029A6B4E5EF8D4CC4E02556082C0E786CFF4A7F96A779B5B651A34675E8BD08E3EB1597CE7EB9C53E8036D6AB57AF23D30DF1731DBD367DBA333327FDA3DF9A7EFD6334FCF6A9980E1417DD4643EE525878A05831DD2276220F3BECB06C67B3CB9E65A8DFF18E776447DF3FFAD18F66CFC5FBE2FDB1946A7EC16FFC77BC96DFB834FE3FF381517C8CA36871BD450C9EDEF8C6376653E7629A482CD57AF2C92767F7A68823AC1A7EF9F3B73F59DB57C551CFC85F7E2627BF3F495C6C1E53892287718D452C5C10AF4786F255AE468F1E9DDDD0B16CB994BFEAD9FEC5820271A027161C884504F225AC63F0136780626A6F5C9B93BFDFF6AFDCD201E6C9C57BF644263A4264A5F875D31C9C62EF132AA0A6A666F0902143FEDD5153DBB66FDFBE34FD9A4BD33FFC8B35FCF6ABF87DC691CE38FA18471EE3E6A12DDF130D3E7608620A47DC102D063B71F43CEE97121547416367201FF0B4BCA15F1CC18C23F12D5FFBFDEF7F9F4D8B8B6B80860F1F9E2D731DF7B288D7AEBAEAAAEC82E09832B26AD52A0DBF13E46F7FB2D65A45FE3EF9C94F66CBFDE6677EE2004CEC1CDE7BEFBDD9FD50E29A8898C21603A4B81F4A1C693FFEF8E39B3355A65CCA5FF56CFF629B175378E37A9F1820C5EA8171A0278EC68F1933263B03130393D66E686AFB57CAB33C57E7038FF8BDC760A4BDEFBBD3AF5FBF170A039EFA2E40E5A43B10B78C1C39B2DD073DBB77EF5E996EE867A57FF4D76BF8CA45BBF2277FF2A7E4AFA3C454B2E2D4B618F4B4D7CD4863B0D3BF7FFFE70B839D25BD7AF53ADC1E27547823900E44EEB8ECB2CBB6B4D7A027CEECA403AB7BE3BA9DCEBC0CB586AFE1CB9F923FF993BFEA940E728E4AF7435614073D71C6AE2DAFE98933472DCEECAC4AEB687B9B5025839E9A9A9A1B060F1EBCA5ADAFE9896B76F64C63BBFE501AEC68F81ABEFC29F9F37B97BFEA12838FE2A0275FC8E060576F8B69B72D162830D8816AD5BB77EF417DFBF6DD3665CA94A777EEDC79D04B4FEF598D6DEBA172CD8E86AFE1CB9F923FF993BF529CE9692C0E4E62B189B87E35AE273CD09B8AC67D768A4B4FE7D3D80C76A08AC5EA6D7DFAF4B92DFDE3DD3C75EAD447376DDAB4EB40FEF8376EDCF850DC5434FD1CCB630A5BFAF1D843F567A9E16BF8F2A7E44FC95FF589992DBD7BF71EDF629092D5A5975E9A4C993225BBC62766BDE40780E3632C7811D7E8C4622A713FA59A9A9A17F6F139EA5DB303E539DB735C5A37A67FCC5B2EBCF0C24513274E5C74FFFDF73FBA76EDDAED85F1CDD618E0343636CE1E376EDC8C810307C61D8D37A4839CC99DFDA6A21ABE862F7F4AFEE44FFECA6DCF92D58DFB1AF8BC825A68E96928A9B8EE66CF062196748C85071E4F6B57E10FBC69CFC6A23EEE687CA85DA7A3E16BF8F2A7E44FFEE4AFF40779BBA7FB31335AECDFEC57A5839C86B47AB8A92860C0A3347CF9933FF953F257ED0779BBA6839F33E220EE9E83B94D2D0638D941DE9801930E72FAC565007E6A80018F46ABE1CB9F923F257F0068F84AC3973FF9933F257F0068F84AC3973FF9933F257F0068F8CA0EA7DFBBFCC99F32E00140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257F7EEFF2078086AF347CF9933FF953F2078086AF347CF9933FF953F2078086AF347CF9933FF953063C0068F81ABEFC29F9933FF903000D5FC3973F257FF2277F00A0E16BF8F2A7E44FFEE40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5FC3B7C3A9E44FFEE40F00DACA3DF7DCA3D1564F3D9B36FC5DF2A7E44FFEE40F00DAC8DCB9739BD6AF5FAFD95641AD59B3E6BFD286BF4CFE94FCC99FFC01401B99356BD6E9B367CFDEBC6EDDBA7F6BBA953BB219CD7EE6CC99FF97564FF953F2277FF207006D286D32DD1B1A1A16C674829843AD3ABCE2E7BEEC506DF6F2277FF2277F063B00000000000000000000000000000000000000000000000000000000006DE0FF019B4266A3D06D18040000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('a3e65a5f-3e58-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.bpmn20.xml', 'a3e65a5e-3e58-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E6B581E7A88B5F46615942777A4F392220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D392220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('a4164400-3e58-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.Process_FaYBwzO9.png', 'a3e65a5e-3e58-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C933000016FE4944415478DAEDDD0D909575BD07702A2B2B2D2A9BAC6CD4B272261BACAE4D4D3369E6385A944C822B0B862E6D98226A5E250DBCC298F88290AC8E99A468163138A09273EF7511790917E38E214890F8C29597950594CB4B22A0FFFBFC9EE1EC1C175641CE9E17F87C667EB3EC39CB2EAEDF737EFFFFF3FC9FFFD3AD1B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C0DE48291DF4FCF3CF4F9E376FDEEB8F3EFA686A6E6E5665AEE9D3A7A7D9B367AFCBAABFFCC983FCC99FFC01400945B39F33674E6A6B6B4BAFBDF69AAA50AD5DBB36CD9A35EBFFB2E6DF5BFE94FCC99FFC014089C4914DCDBE6A9AFE6BCDCDCD4BE44FC99FFCC91F0094482CE3D06CABA7B286BF5DFE94FCC99FFC014089C41A6A8DB6AA1A7E923F257FF2277F0050E686BF79436B7A7EFEDD69F1F49179C59FE3314D5AC3973FF9933F257F00D474C3DFF4CAAAF4F47F0F4F4F3D7CF99B2A1E8BE7346A0D5FFEE44FFE94FC0150B30D7FC5E2877669F6855AB9789A46ADE1CB9FFCC99F923F006AB7E12F79EC864E1B7E3CA7516BF8F2277FF2A7E40F809A6DF84F375FD369C38FE7346A0D5FFEE44FFE94FC01A0E12B0D5FFEE44FFE94FC01506D0D3F7625EAACE1C7731AB5862F7FF2277F4AFE00A8D986BF6CEEAD9D36FC784EA3D6F0E54FFEE44FC91F0035DBF0D7AF5A989E7EE43F765DCE913D16CF69D41ABEFCC99FFC29F903A0661B7ED40BFF73EF2E0D3F1ED3A4357CF9933FF953F207406D37FCAD5BD3B2C76FDF753947F6583CA7516BF8F2277FF2A7E40F809A6CF87127F167E63675BA863D9E73B7710D5FFEE44FFE94FC01505B0D7FEBD6D4BA6C465AF45F5775DAEC0B155F135FEB68A7862F7FF2277F4AFE00A8FA86FF7647351DEDD4F0E54FFEE44FFEE40F809A6DF87B7254F3AD8E766ADC1ABEFCC99FFC29F903A06A1BFE3B6DF685D2B8357CF9933FF953F20740D5367CA5E1CB9FFCC99F92BFEA74EEB9E7763FFBECB37B67D594554B56AD59A5A28ACF5BEAEAEAEEECDBB76FFFAC0EF35B83FDC0CA952B7B4C9D3AF537B7DD76DBD3C3860DDB3478F0E0D7FBF5EBD7FEE26F6C6CDC76D96597AD1F3162C4ECD1A3479F9FBD591CECB7A6E16BF8F2A7E4CFFF77F9AB15D904A66736A699964D60767498E0BC6D657FA739AB5E279D74D2417E935043524A07B5B4B45C316EDCB8D66C4293468D1A95A64C9992162C589056AD5A9576ECD8910AD6AF5F9F162E5C981E78E08174EBADB7A66CC2B3E3F2CB2F7FBCA1A1A187098F86AFE1CB9F923F257FD52A9BB0FC5B365999B7B7939C4E6A7EF6BD4EF35B851A306BD6AC86B163C76EBAE0820BD2E4C993536B6B6BDA1BAFBCF24AFEC67AE185176E1F3264C8DCEC0DE028131EA5E1CB9FFCC99F92BF6A116763B2C9C9A8DD9DD1193A74683EFE993B776E7AF1C517D3ABAFBE9A8F6FB66DDB967F3E6FDEBCFC20F0F0E1C33B9BF83459ED02557C5667D2A4498B1A1A1AD2C48913DB5FE0EF549C058AB33EE79C73CEF68103070E35E1511ABEFCC99FFC29F9ABB47EFDFA1DD1F1AC4E36564977DF7DF75E1FE45DBE7C791A3F7E7CAC6EE938E959143FC76F1BAA48F6023FAAA9A9A9ED924B2EC95FBCA514DFEFD24B2F7DB5B1B1F1BE03ED888786AFE1CB9F923F257FD5239BE81C5B5F5FBFBA787212CBF6DBDADAF669AC13CBFB478E1CD971D2B3E2405EE5025537D989256C716A3696A37585385BF4EB5FFF7ACBC08103FFF340BAA84FC3D7F0E54FC99F92BFEA39B3533CD989B33A3367CE7CD375C9FB6ACE9C39F9F735E9812A12CBD8E2CC4E4C76F67509DB9E2C71BBF6DA6B37666F04E3357CA5E1CB9FFCC99F92BF72D979CD4EFB32B6D86D76E9D2A55D32DE896B7C3A2C715BD4A74F9F438C3AA142E29A9D58C6B671E3C6540E31A91A3264C8C6EC8DE60A0D5F69F8F2277FF2A7E4AF1C628382E2333B5D35D9299EF414DFC223363230EA840A983D7B76636C5050EA6B76F6E49A9EEC4DE0D53E7DFA1CA3E12B0D5FFEE44FFE94FC75A59D5B4FB7EFC616CBD8CA2196B775B85F8F2DABA19C6229DBCD37DFBC397663AB842953A66CC8263D53347CA5E1CB9FFCC99F92BF2E3EBB33AF788382525EB3F3763A6C6430DFCD49A18CE2A6A2719F9DAEBE6EE7ADAEE769686858535F5F7FBC86AF347CF9933FF953F2D715EAEAEA7A162F65DBD7DDD8DEC9EE6DC5D7F36493AF5E46A1502663C68C698D9B6A55D2B469D362E7923F68F84AC3973FF9933F257F5D211B674C2B4C36E23E3B9570DF7DF7154F789A8D42A10C56AE5CD9A3B1B171AF6FAE556AB105767D7DFDCBFBF3BD79347C0D5FFE94FC29F9AB8C6C7CD1BDF8DA9D4A8D7BE2AC52F10606D9BFE930A351E86253A74EFDCD8D37DE98AAC195575E393F4E376BF84AC3973FF9933F257F253EBBD3BB30C9183A746845C73B71FB8FA2094F7FA351E862E3C68D5B3C65CA94AA98F04C983061D1FEBC55A386AFE1CB9F923F257F159BF034152619955EC61FE3AEC2BFA5AEAEEE4EA351E862C3860DDBB460C182AA98F03CF9E493CBB2177F8B86AF347CF9933FF953F257E2094F4B61923177EEDC8A8E77E2BE3C45BBB5B57403BAD6E0C1835FAFF4F53B05EBD6ADDB9CBDF05B357CA5E1CB9FFCC99F92BF124F785A0B938C175F7CB1A2E39D55AB56154F785ABB015D2B2E9C2BE71EF46F275EFC1ABED2F0E54FFEE44FC95F89273CED938C6DDBB65574AC133FBFF8DF63340A657803A826263C4AC3973FF9933F257F5D39E1A996F18E090F1C9867783699F0745DAD5DBB36CD983123BDF4D24BBB7DFE85175EC83F2E5BB62CFFF8E0830FA6679E7926AD5CB932DD7FFFFD69CB962DBBFD7BB116FA965B6EE9F4E72E59B2244D9D3A35FFF3934F3E997FBFAD5BB7A6279E7822AD59B346C3DF0FF3F77659DB97DAB469535ABE7C799EBB3BEEB823FF39B5984BF953263C959BF054EA46EBCEF04085FCFCE73F7FAD5AAEE1C906194FBB86A7EB6AE6CC99F1A61A3779DDE5B9471E7924BDFFFDEF8FADC1F38F31D1F9E4273F996EBBEDB64263CC07B11B376E4C2D2D2D69F0E0C1E9E28B2FCEEBD8638FCD9F3FFFFCF3DB1F8BE71F7FFCF1FC7BDF7EFBEDA97BF7EEF99F8F3CF2C874DD75D7E57F7EDFFBDE97FEF4A73F69F8FB61FEDE2A6B3109F9F0873F9C3EF1894F745A9197ECBD296DD8B0217DF18B5F4C871F7E78FE586433BE6F71D5D7D7E713955ACBA5FC29139EB24F78DAAFE1898326AEE18103C815575CF152B5ECD2960D5866DAA5ADF4F5CF7FFE333F2A1E47AE630018FF8E975F7E399FD414BE66FDFAF5ED03C4D34E3B2D7DF6B39F4DEF79CF7BF2C1E7A73EF5A9FCF178ECC20B2F4C13274E4CEF7AD7BBD2C08103F33AE38C33F2AFABABAB6B7FECDDEF7E777E37E959B366A5F3CE3B2F1D72C82169D2A449E94B5FFA52BAE9A69BF29FF9C10F7E30DF9A73CE9C3969E1C2851AFE7E90BF3DC9DAA2458BF23B9C4F983021DD7BEFBD79DD73CF3DF9C7C848FCBD418306E5B958B76E5D9EB7AF7EF5ABE9C4134F4CA3478F6EFFBEDFF9CE77F2C9D0E2C58BDBBFAE9672297FCA84A7EC131EBBB4C1816AE4C8918F54CB7D78C68C1933CD7D784A5BAB57AFCE078137DF7C73FADBDFFED63E58BCECB2CBF2C1601C198FAFBBE8A28BF2094D3C1F83D6A79E7A2A9F005D7FFDF5E98F7FFC63FEB571643C8EB8C7D2B66CA29CBEFBDDEFA6EF7DEF7BE984134EC8FFDEB7BFFDEDFCF3934F3E39FDF297BFCC07BE0F3CF0403AF3CC33F341641CD98F81E537BEF18DFC687B3CD6BF7FFFF4DEF7BE3735353569F8359EBF3DCD5AD45FFEF297DD9EA989E7E2CF31198A3FC7E4243EFFF4A73FDD69C524E6AEBBEEAAB95CCA9F32E129FB84A7FD3E3C71A0C37D78E00072C30D379C377AF4E837AA61C23368D0A069D90BBFA7865FBA8A6B6F62D01747B30A83D0E9D3A7B70F380BD73FC4B51671943C96F8DC79E79DBB0C460B154B95E2EBE308FC51471D95DFADFA273FF949FEDC05175C907F1E8FC732A2C2BFE177BFFB5DFAF8C73F9E5F1B1403CBCF7DEE73F99B7C0C2CE3EFC559230DBFF6F3B7A7592BFADDE7675AFEFEF7BFE7676B060C18B0CB8427CEFA7CE4231FC9AF278B3335A79F7E7ABE4CAEB83EFAD18FA6F1E3C7D75C2EE54F99F0947DC2D3BB30C988F7844A1A3E7C78FB84A76FDFBEFD8D46A18B9D7BEEB9073734346C8B254D15BE074F5CBFB336FE3D1A7EE9AAB1B1311F30C6D1EFE241E8E6CD9BF38162CF9E3DDBBF76DCB871F9F3B1B4273EC6D1F558F6F3FDEF7F3FC5B2C778AC70FD430C1C3FF399CFA42C3BF9F3F15CBC71C7E771D4BD30B08CC16C6C8C11CFC7A0B2E3D2A19FFEF4A71AFE7E92BFBDC95A61C253D8D4E0473FFAD16E273CB179406424FE7E3CFEA10F7D281D76D861ED151396C85D6193815ACAA5FC29139EB28F77BA67EF07DB0B138DE79E7BAE22E39DB6B6B638A3FD46D184E730A3512883A143873E16474A2BA9A9A9E99EEC85FF070DBF7415BBAEC545DE31B08BCF8B07A1F179F6E69F7F1E8F8F1D3B365F8E1403CA38F2148FC7929FB87622AE93880BC83B4E788E38E288FCE38F7FFCE3FCB9580654FC7861101CCFC520F2AF7FFDEB6EAF95285EEAA4E1D766FEF6266BC5139E583216CBD1BEF6B5AFED76C253A81898C4D2B5F89ADFFEF6B7ED15BBB4C56E4B85AFABA55CCA9F32E1A9C8599E69858946BC7F54421C4C2C9AEC341B854299343434F4F8D9CF7EB6A352DB34EED8B16345F6A27FB6BEBEFE780DBF74154B796250377FFEFCDD0E42E3AC4D6C4CD0AB57AFF4D0430FE53BB4C5750EF131BEEE5BDFFA563AFAE8A3F34D0B6223838E139E638E39265D73CD35F9C5E0F15C5CAB119F7FFEF39F6F1F582E5DBA34BFD03C8EC4C7E7BB1B585E7BEDB5F9244BC3AFDDFCED4DD68A273C871E7A68BE635B7C8C25689D4D78468C18D1BEACF2CB5FFE727E7D4E9C4D8ACFE37A9CE2094FADE452FE94094FF9C5B2F9C264E39C73CEC9CFB69453ACA619306040F1D99D5E46A15046175F7CF1AC4A6D5E70DD75D74DC85EF89335FCD2561CBDEADDBB77FBE71D07A1856B1EE2EB0A9F7FFDEB5FCF078785AF8B8BB8CF3AEBAC7CA7ADE2094F0C2663B078EAA9A7A66F7EF39BF973711D467C1E8F172F092A5C2B511858C632B9184C160696975E7A69FE3334FCDACDDFDE66EDE1871FCE97A9C596F81DBF57C709CF3FFEF18F7C52141B6B1C77DC71F98427361F88334A575F7DF59BFE6E2DE552FE94094FC5CEF2B4EFD63672E4C8B2DE8B307E5ED1EE6CF34F3AE9A4838C40A18CFAF4E97378D6F05F2BF7DEF4D9606656F6A2DF94FDFC6334FCAEA9580EF4C31FFE301FF8752BDA78A0B862594F0C220F3EF8E07CB0D96DE736D41FFBD8C7F2A3EF5FF8C217F2C7E2EBE2EB63CBDEC245E8F1E778AE70E3D2F8EF2C4C8CE2631C458BEB2D62F2F4810F7C205F3AD7B76FDF7C4BE0534E3925BF07CAAF7EF52B0D7F3FC8DF9E646D7715473D237F85333985FBE0C40608710F9EC861ECA6161B17C4F391A1C26E6AA3468DCA6F1C5A6BB9943F65C25319679D75D629C537FD8CF7A97288F7A4E29F9BBDDF9C66F40915505F5F3FE4924B2EF957B996B66DD9B26571F63317672FFC7FD7F0BBAEE2FF671C7D8FA3DC71843B6E1EDAF16BE2BE2931488DAD81E3866831D989A3E771BF94A838321FBB5C15263C1D6F321947CAE3487CC7E77EFFFBDFE7CBE2E21AA061C386E5DB5C3FFBECB3F97337DE7863FAC10F7E905F50BE62C50A0D7F3FC8DF9E64ADB38AFC7DE52B5FC9B7952E9CF9890330310979ECB1C7528F1E3DF26B6F62095B4C90E2BE3B7146E7F8E38F6FCF542DE552FE94094F45CFF2DC549878C4B5873119E9EAFBEEF4EFDFFF8DA2094F5337A072B201C4BD23468CE8F249CF8E1D3B9667038A19D98BFE760D5F69F8F2277FF2A7E4AF5C622959F1D2B698F474D5CD4863B23360C080D78B263B8BFAF4E97388112754F84D209B883C78F5D5576FECAA494F9CD9C926568FC5753BFBF336D41ABE862F7F4AFEE44FFEAA5336C939221B872C2B9EF4C499E1525ED313678E3A9CD95991D551469B5025939EFAFAFA3B860C19B2B1D4D7F4C4353B3B97B1DD7E204D76347C0D5FFE94FCF9FF2E7FD525261FC5939EC24606FBBA7B5B2CBBEDB04181C90E54ABBABABAC1FDFAF5DB3C69D2A457B66DDBB6CF5B4FEFDC8D6DD38172CD8E86AFE1CB9F923FF993BF9A38D3D3523C39894D4DE2FAD5B89E706F6F2A1AF7D929DE7ABAB08CCD6407AA58ECDED6B76FDFFBB317EF86C993273FB77EFDFAED7BF3E25FB76EDDD37153D1EC7B2C8D256CD9C7630FD4DFA586AFE1CB9F923F257FD52756B6D4D5D58DED3049C9EBAAABAE4A93264DCAAFF189552F8503C0F13136F9896B74623395B86F577D7DFD1BBBF91E4DAED981DA39DB735C5677662FE68DBFF8C52F168C1F3F7EC1134F3CF1DCEAD5ABB714CD6F36C504A7A5A565E6983163A60D1A3428EE68BC369BE44CDCDF6F2AAAE16BF8F2A7E44FFEE4AFB6EDDCB2BA6577139F7750F36D3D0D352AAEBBD9F986105B3AC6C6032F64B5BDE805DEBAF3CDA229EE687CA05DA7A3E16BF8F2A7E44FFEE4AFE60FF2F6CCC631D33A8C6FF6A8B2494E7356BDDC541430E1511ABEFCC99FFC29F9ABF683BCDDB3C9CFD9711077E7C1DCD60E139CFC206FAC80C92639FDE33200BF35C08447A3D5F0E54FC99F923F00347CA5E1CB9FFCC99F923F00347CA5E1CB9FFCC99F923F00347C65C0E9FFBBFCC99F32E10140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257FFEBFCB1F001ABED2F0E54FFEE44FC91F001ABED2F0E54FFEE44FC91F001ABED2F0E54FFEE44F99F000A0E16BF8F2A7E44FFEE40F00347C0D5FFE94FCC99FFC018086AFE1CB9F923FF9933F00347CA5E1CB9FFCC99F923F00347CA5E1CB9FFCC99F923F00347CA5E1CB9FFCC99F923F00347C0DDF8053C99FFCC91F0094CAA38F3EAAD1564FBD9A35FCEDF2A7E44FFEE40F004A64F6ECD9AD6D6D6D9A6D15D4AA55ABFE9C35FC25F2A7E44FFEE40F004A64C68C1967CC9C3973C39A356BFEA5E956EEC86634FBE9D3A7FF6F56BDE54FC99FFCC91F009450D6647A363737CF8FE504B1865A95BDE2F7BEE4406DF6F2277FF2277F263B000000000000000000000000000000000000000000000000000000000025F0FF3338904DA7537A030000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('acaaf65f-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.bpmn20.xml', 'acaaf65e-3e59-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E8AFB7E58187E6B581E7A88B2220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2232223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E8AFB7E58187E4BABA223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E8AFB7E58187E58E9FE59BA0223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E8AFB7E58187E5A487E6B3A8223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3064643061646E2220736F757263655265663D224576656E745F393575504A59314D22207461726765745265663D2241637469766974795F30736A7830726F223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F316168346C66362220736F757263655265663D2241637469766974795F30736A7830726F22207461726765745265663D2241637469766974795F30353837646B30223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D3922206E616D653D22E5B08FE78CAAE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F307A306A3730782220736F757263655265663D2241637469766974795F30353837646B3022207461726765745265663D2241637469766974795F31383134676D39223E3C2F73657175656E6365466C6F773E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31786C617662762220736F757263655265663D2241637469766974795F31383134676D3922207461726765745265663D224576656E745F31656339393535223E3C2F73657175656E6365466C6F773E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F31786C61766276222069643D2242504D4E456467655F466C6F775F31786C61766276223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223731392E3934393939393939393937382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223738322E302220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F3064643061646E222069643D2242504D4E456467655F466C6F775F3064643061646E223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223234342E39343939393835343937303035352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239392E393939393939393939393535372220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F316168346C6636222069643D2242504D4E456467655F466C6F775F316168346C6636223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223339392E39353030303030303030303030352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223435392E39393939393939393939353138352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F307A306A373078222069643D2242504D4E456467655F466C6F775F307A306A373078223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223535392E393439393939393939383431392220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223631392E393939393939393939393531382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('acb7a090-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.Process_FaYBwzO9.png', 'acaaf65e-3e59-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C9330000187C4944415478DAEDDD0B905775D90770BA5B59515959D96465E54C16566F65935D751A354AA62064C1D0A50D5342BC2065E02B64128A50AC8E999468162F83032A39BDAF8BC8255C8C770C4182C40BAF5C566E8A5C12013DEF79CE70768E0BAB20BBFBFF9FE5F3997966FD5FD85D77BF7B9EF33BE7777EA74B170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080039124C96B1F7BECB1A90B162C78FE9E7BEE491A1A1A5407D7CC993393B973E76E4CAB9FFCC983FCC99FFC01401B8A663F6FDEBC64FDFAF5C973CF3DA72A541B366C48E6CC99F34CDAFC7BCA9F923FF9933F006823716453B3AF9AA6FF5C4343C332F953F2277FF207006D24A67168B6D55369C3DF257F4AFEE44FFE00A08DC41C6A8DB6AA1A7E227F4AFEE44FFE00A0831BFEB6CD4DC9630B6F4A96CE1C9555FC773CA7496BF8F2277FF2A7E40F805237FCAD4FAF491EFA9F11C983770D7D51C573F19A46ADE1CB9FFCC99F923F004ADBF0572DBD73AF669FD7EAA533346A0D5FFEE44FFE94FC0150DE86BFECDE31AD36FC784DA3D6F0E54FFEE44FC91F00A56DF80F355CDE6AC38FD7346A0D5FFEE44FFE94FC01A0E12B0D5FFEE44FFE94FC01506D0D3F56256AADE1C76B1AB5862F7FF2277F4AFE00286DC35F31FFDA561B7EBCA6516BF8F2277FF2A7E40F80D236FC4D6B16270FDDFD9F7B4FE7489F8BD7346A0D5FFEE44FFE94FC0150DA861FF5F8FFDEB257C38FE734690D5FFEE44FFE94FC0150EE86BF6347B2E2BEEBF79ECE913E17AF69D41ABEFCC99FFC29F903A0940D3FEE24FEF0FCFA56E7B0C76BEE36AEE1CB9FFCC99F923F00CAD5F077EC489A56CC4A96FCF7A5AD36FBBCE23DF15E473B357CF9933FF953F20740D537FC973BAAE968A7862F7FF2277FF2277F0094B6E1EFCF51CD973ADAA9716BF8F2277FF2A7E40F80AA6DF8AFB4D9E7A5716BF8F2277FF2A7E40F80AA6DF84AC3973FF9933F257FD5E9ACB3CEEA7AC61967F44CAB3EADC6B49AD24A0A158F1B7BF7EE7D639F3E7DFAA575849F1A7402AB57AFEE367DFAF45F5F77DD750F0D1F3E7CEBA041839EEFDBB76FF31F7F5D5DDDCE8B2EBA68D3C89123E78E1D3BF69C746371989F9A86AFE1CB9F923FBF77F92B8B7400D33DDDA799910E6076B718E0BC6CA5FFA621AD1E5FFBDAD75EEB2709259224C96B1B1B1B2F99306142533AA049468F1E9D4C9B362D59B46851B266CD9A64F7EEDD496ED3A64DC9E2C58B93DB6FBF3DB9F6DA6B9374C0B37BE8D0A1F7D5D6D67633E0D1F0357CF953F2A7E4AF5AA50396FF48072B0B0E7490D34A2D4C3FD7297EAA500273E6CCA91D3F7EFCD673CF3D37993A756AD2D4D4941C88A79F7E3ADBB09E77DE79BB060F1E3C3FDD001C6DC0A3347CF9933FF953F2572DE26C4C3A3819BDAF333AC3860DCBF67FE6CF9F9F3CF1C413C9B3CF3E9BEDDFECDCB9337BBC60C182EC20F08811235A1BF8D49BED02557C5667CA94294B6A6B6B93C9932737FF81BF52711628CEFA9C79E699BB060C1830CC804769F8F2277FF2A7E4AFD2FAF6ED7B54CBB33AE9BE4A72D34D371DF041DE952B572613274E8CD92D2D073D4BE2EBF869431549FFC08FAEAFAF5F3F64C890EC8FB72DC5E7BBE0820B9EADABABBBF5503BE2A1E16BF8F2A7E44FC95FF548073AC7D6D4D4AC2D0E4E62DAFEFAF5EB0F6A5F27A6F78F1A35AAE5A067D5A13CCB05AA6EB01353D8E2D46C4C476B0F71B6E897BFFCE5F6010306FCF550BAA84FC3D7F0E54FC99F92BFEA39B3531CECC4599DD9B367BFE8BAE483356FDEBCECF31AF4401589696C716627063B073B856D7FA6B85D71C5155BD20DC1440D5F69F8F2277FF2A7E4AFA3ECB966A7791A5BAC36BB7CF9F276D9DF896B7C5A4C715BD2AB57AFC3ED754285C4353B318D6DCB962D49478841D5E0C183B7A41B9A4B347CA5E1CB9FFCC99F92BF8E100B1414CFECB4D760A738E829DEC2231632B0D709153077EEDCBA58A0A0ADAFD9D99F6B7AD28DC0B3BD7AF53A46C3571ABEFCC99FFC29F96B4F7B969E6E5E8D2DA6B1758498DED6E27E3D96AC868E1453D9AEB9E69A6DB11A5B254C9B366D733AE899A6E12B0D5FFEE44FFE94FCB5F3D99D05C5050ADAF29A9D97D3622183856E4E0A1D286E2A1AF7D969EFEB765EEA7A9EDADADA75353535C76BF84AC3973FF9933F257FEDA177EFDEDD8B53D90E7635B657B27A5BF17A9E74F0D5C35E28749071E3C635C54DB52A69C68C19B172C91F357CA5E1CB9FFCC99F92BFF690EE67CCC8071B719F9D4AB8F5D65B8B039E067BA1D00156AF5EDDADAEAEEE806FAED5D66209EC9A9A9AA73AF3BD79347C0D5FFE94FC29F9AB8C74FFA26BF1DA9D4AEDF7C459A5E20206E9F77484BD516867D3A74FFFF555575D9554839FFDEC670BE37473D97E86718426AD13357C0D5FFE94FCC99FFC55670ED3C145CF7C90316CD8B08AEEEFC4ED3F0A039E7EF646A19D4D983061E9B469D3AA62C03369D2A425655CAAB1786A3A1DB09DA0E16BF8F2A7E44FFEE4AFBA7218FB17F9FB2A3D8D3FF6BBF2EF25FD7E6FB4370AED6CF8F0E15B172D5A5415039E071E786045FAC7DF58D60D6DA1FEBAAF234D1ABE862F7F4AFE94FC552687B17F91BF3E7FFEFC8AEEEFC47D790ADF6B6317A07D0D1A34E8F94A5FBF93DBB871E3B6F40FBFA9136C689B8F341537B81ABE862F7F4AFE94FC552687B17F913FFFC4134F54747F67CD9A35C5EFB3A90BD0BEE2C2B98E5C83FEE5C41F7F67D9D0168F34C529760D5FC3973F257F4AFE2A93C3E2E39D3B7756745F27BE7EF1FBB1370A1DB091A826FBB1D12A6D69F8D5559D396BF2277FF2A7E4AFF5AAB6FD1D7BA370689DE1D9DAC9CEF064ABCEE57752AE74C3DFB06143326BD6ACE4C9279FDCE7EB8F3FFE78F671C58A15D9C73BEEB82379F8E18793D5AB5727B7DD765BB27DFBF67DFEBB980BFD9BDFFCA6D5AFBB6CD9B264FAF4E9D97F3FF0C003D9E7DBB1634772FFFDF727EBD6AD7384B313E6EFE5B27630B575EBD664E5CA9559EE6EB8E186ECEB943197F2575DDBBFFC771EBFFFFCFD37DE7863968B97FABCB67FE5C961F1F94ADD68DD191EA8901FFFF8C7CF55CB353CE9C6FFA14E720DCF8B1A7DAED20D7FF6ECD9B1518D9BBCEEF5DADD77DF9DBCE10D6F88A5C1B38F31D079CF7BDE935C77DD757963CC7600B66CD9923436362683060D4ACE3FFFFCAC8E3DF6D8ECF573CE39A7F9B978FDBEFBEECB3EF7F5D75F9F74EDDA35FBEF0F7EF083C995575E99FDF7EB5FFFFAE4CF7FFEB386DF09F3F752598B9DC3B7BEF5ADC9BBDEF5AE562BF2926E9B92CD9B37271FFBD8C792238F3C327B2EB2199FB758353535D90E64D972297FD5B3FD5BBE7C7972F8E1872743870E4D5EF39AD7641FFFF297BF64EFBFF9E69B937FFEF39FC9E73EF7B9ECC08FED5F797358BC86270E9AB886070E21975C72C993D5B24A5BDA4866977C95B6C63E7DFAF468D9E82BDDF0FFF5AF7F6547C5E3886234E6F83E9E7AEAA96C5093BF67D3A64DCD8DFB94534E493EF0810F648D3F763EDFFBDEF766CFC773E79D775E3279F2E4E455AF7A553260C080AC4E3FFDF4EC7D6973697EEED5AF7E757637E93973E624679F7D76B6333165CA94E4E31FFF7872F5D557675FF34D6F7A53B634E7BC79F392C58B176BF89D207FFB93B5254B966477389F34695272CB2DB764153B95F1313212FF6EE0C081592E366EDC98E5EDD39FFE74F2D5AF7E35193B766CF3E7FDCA57BE920D86962E5DDAFCBE32E552FEAA67FB1737BE3EF1C413B3D77FFAD39F26DFFEF6B793CF7EF6B3D9E36EDDBA6503960F7FF8C3C9238F3C62FB57E21C5AA50D0E61A3468DBABB5AEEC3336EDCB81925BD0FCF3E8F685643C35FBB766DD69CAFB9E69AE4EF7FFF7B73C3BFE8A28BB2261D47C6E37D3FF9C94FB2014DBC1E3B080F3EF8603600FAD5AF7E95FCE94F7FCADE1B472CE3887B4C6D4B07CAC9D7BFFEF5E4A4934ECA8E7CC6BFFBD297BE943DFEC637BE91ED34C44EC6EDB7DF9E7CEF7BDFCB9A7B1CD98F86FFF9CF7F3E3B0A1ACFF5EBD72F79DDEB5E97D4D7D76BF825CFDFFE662D2A3F7ADEF24C4DBC16FF1D83A1F8EFD8698CC7EF7BDFFB5AADD8B9FCC31FFE50BA5CCA5FF56CFFE2404E6CFF626073C105172431D53BDD69CEDE9F0F7C2243698FB2FD2B710E8BF7E18901A8FBF0C02164CC9831678F1D3BF6856A18F00C1C3870466CB03AEBCFBA120D3FA66044338EA35979C39F397366F30E677EFD43CC6B8FA3E4D1F063DE7ACB9DD1BC625A48BC3F8EC01F7DF4D1D9DDAA7FF0831F64AF9D7BEEB9D9E3783EA677E4DFC3EF7EF7BBE49DEF7C67766D5034FC38521A1BF968F8F1EF6267C3948EF2E76F7FB356F8D96747C0FFF18F7F64676BFAF7EFBFD78027CEFABCED6D6FCBAE278B23E8A79E7A6A3625A9586F7FFBDB93891327962E97F2573DDBBF58A23806479FFAD4A792E38E3B2EF9E637BF997CF9CB5FCEDE73C4114764677C4E3BEDB4E417BFF885ED5FB907453DF34146FCAE2A69C48811C5A5B3FBD91B857676D659671D565B5BBB33A63455F81E3C71FDCE86F87E34FCB6ABBABABA6C87318E4A161BFEB66DDBB21DC5EEDDBB37BF77C28409D9EB31E5223EC6D1F5988E118D3EA63DC673F9BCF468E8EF7FFFFB93343BD9EBF15A6CB8E3711C75CF1B7EECCCC6D1D2783D9A7DCB291D3FFCE10FCD61EF24F93B90ACE5039EFC02F2EF7CE73BFB1CF0C445DD9191F8F7F1FC9BDFFCE66C0734AFD8918CDCE5177F972997F2575DDBBF380313AFC7A03AAEAD79F7BBDF9D3DFED6B7BE950C1932243BAB93BFD7F6AFB4FB3B5DD3DFD3AE7CA0F1E8A38F56647F67FDFAF57146FB85C280E7087BA3D001860D1B766F1C29ADA4FAFAFA9BD33FFC3F6AF86D57B1EA5A5CE41D0D371E171B7E3C4E37FED9E3787EFCF8F1D9D48FD8A18C234FF17C4CC5886B27E23A89B880BCE580E7A8A38ECA3E7EF7BBDFCD5E8BE919C5E7F31D8E782D9AFBDFFEF6B77DCE612F4E75D2F0CB99BF03C95A71C0135379623ADA673EF3997D0E78F28A1D9398BA16EFF9ED6F7FDB5CB14A5BACB654DC112D4B2EE5AF7AB67FB1B040E4EB431FFAD08BCE68C73630A6B67DE10B5FC816CE2863CEE46FAFB33C33F281466C3F2A210E26166F8C6A2F143A486D6D6DB71FFDE847BB2BB54CE3EEDDBB57A57FF48FD4D4D41CAFE1B75DC5148B68B60B172EDC67C38FB336B130418F1E3D923BEFBC335BA12DE69FC7C778DF17BFF8C56C0720162D88850C5A0E788E39E698E4F2CB2FCF2ED28DD7625E7C3CFEC8473ED2DCF063F5A3B8D03C8EC4C7E37D35FC2BAEB8221B6469F8E5CDDF8164AD38E079CB5BDE92ADD8161F636A506B039E91234736EF847EE2139FC8AE9B8823F7F138AE9328EE88962597F2573DDBBF9FFFFCE7C985175E98ADCE16D3DA2EBEF8E2E6EBCAE2AC4D4C6F8B333A65CC99FCBD584C9BCF071B679E796676B6A523C56C9AFEFDFB17CFEEF4B0170A1DE8FCF3CF9F53A9C50BAEBCF2CA49E91FFE540DBF6D2B8E5EF5ECD9B3F971CB869FCF458FF7E58FE302DD68DAF9FBE2E2DAEF7FFFFBD9AA46C5014F34F968E231D7FD84134EC85E8BEB30E2713C5F9CAA91CF61CF1B7E4C938B269F37FCB84838BE86865FDEFC1D68D6EEBAEBAE6C4A512C89DFF273B51CF0C492C031288A8535E2FA8A18F0C445E171F4FEB2CB2E7BD1BF2D532EE5AF7AB67FCF3CF34CF32029A6B4E5EF8D4CC4E02556082C0E786CFF4A7F96A779B5B651A34675E8BD08E3EB1597CE7EB9C53E8036D6AB57AF23D30DF1731DBD367DBA333327FDA3DF9A7EFD6334FCF6A9980E1417DD4643EE525878A05831DD2276220F3BECB06C67B3CB9E65A8DFF18E776447DF3FFAD18F66CFC5FBE2FDB1946A7EC16FFC77BC96DFB834FE3FF381517C8CA36871BD450C9EDEF8C6376653E7629A482CD57AF2C92767F7A68823AC1A7EF9F3B73F59DB57C551CFC85F7E2627BF3F495C6C1E53892287718D452C5C10AF4786F255AE468F1E9DDDD0B16CB994BFEAD9FEC5820271A027161C884504F225AC63F0136780626A6F5C9B93BFDFF6AFDCD201E6C9C57BF644263A4264A5F875D31C9C62EF132AA0A6A666F0902143FEDD5153DBB66FDFBE34FD9A4BD33FFC8B35FCF6ABF87DC691CE38FA18471EE3E6A12DDF130D3E7608620A47DC102D063B71F43CEE97121547416367201FF0B4BCA15F1CC18C23F12D5FFBFDEF7F9F4D8B8B6B80860F1F9E2D731DF7B288D7AEBAEAAAEC82E09832B26AD52A0DBF13E46F7FB2D65A45FE3EF9C94F66CBFDE6677EE2004CEC1CDE7BEFBDD9FD50E29A8898C21603A4B81F4A1C693FFEF8E39B3355A65CCA5FF56CFF629B175378E37A9F1820C5EA8171A0278EC68F1933263B03130393D66E686AFB57CAB33C57E7038FF8BDC760A4BDEFBBD3AF5FBF170A039EFA2E40E5A43B10B78C1C39B2DD073DBB77EF5E996EE867A57FF4D76BF8CA45BBF2277FF2A7E4AFA3C454B2E2D4B618F4B4D7CD4863B0D3BF7FFFE70B839D25BD7AF53ADC1E27547823900E44EEB8ECB2CBB6B4D7A027CEECA403AB7BE3BA9DCEBC0CB586AFE1CB9F923FF993BFEA940E728E4AF7435614073D71C6AE2DAFE98933472DCEECAC4AEB687B9B5025839E9A9A9A1B060F1EBCA5ADAFE9896B76F64C63BBFE501AEC68F81ABEFC29F9F37B97BFEA12838FE2A0275FC8E060576F8B69B72D162830D8816AD5BB77EF417DFBF6DD3665CA94A777EEDC79D04B4FEF598D6DEBA172CD8E86AFE1CB9F923FF993BF529CE9692C0E4E62B189B87E35AE273CD09B8AC67D768A4B4FE7D3D80C76A08AC5EA6D7DFAF4B92DFDE3DD3C75EAD447376DDAB4EB40FEF8376EDCF850DC5434FD1CCB630A5BFAF1D843F567A9E16BF8F2A7E44FC95FF589992DBD7BF71EDF629092D5A5975E9A4C993225BBC62766BDE40780E3632C7811D7E8C4622A713FA59A9A9A17F6F139EA5DB303E539DB735C5A37A67FCC5B2EBCF0C24513274E5C74FFFDF73FBA76EDDAED85F1CDD618E0343636CE1E376EDC8C810307C61D8D37A4839CC99DFDA6A21ABE862F7F4AFEE44FFECA6DCF92D58DFB1AF8BC825A68E96928A9B8EE66CF062196748C85071E4F6B57E10FBC69CFC6A23EEE687CA85DA7A3E16BF8F2A7E44FFEE4AFF40779BBA7FB31335AECDFEC57A5839C86B47AB8A92860C0A3347CF9933FF953F257ED0779BBA6839F33E220EE9E83B94D2D0638D941DE9801930E72FAC565007E6A80018F46ABE1CB9F923F257F0068F84AC3973FF9933F257F0068F84AC3973FF9933F257F0068F8CA0EA7DFBBFCC99F32E00140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257F7EEFF2078086AF347CF9933FF953F2078086AF347CF9933FF953F2078086AF347CF9933FF953063C0068F81ABEFC29F9933FF903000D5FC3973F257FF2277F00A0E16BF8F2A7E44FFEE40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5FC3B7C3A9E44FFEE40F00DACA3DF7DCA3D1564F3D9B36FC5DF2A7E44FFEE40F00DAC8DCB9739BD6AF5FAFD95641AD59B3E6BFD286BF4CFE94FCC99FFC01401B99356BD6E9B367CFDEBC6EDDBA7F6BBA953BB219CD7EE6CC99FF97564FF953F2277FF207006D286D32DD1B1A1A16C674829843AD3ABCE2E7BEEC506DF6F2277FF2277F063B00000000000000000000000000000000000000000000000000000000006DE0FF019B4266A3D06D18040000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b658a4a3-3e58-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.bpmn20.xml', 'b658a4a2-3e58-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E6B581E7A88B5F46615942777A4F392220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D3922206E616D653D22E5B08FE78CAAE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22312220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E58D95E8A18CE69687E69CAC223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b6772924-3e58-11ed-8a80-4e744305f12a', 1, '流程_FaYBwzO9.Process_FaYBwzO9.png', 'b658a4a2-3e58-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C933000018354944415478DAEDDD0D905675BD07702A2B2B2B2A2B2B9BACAC9CC9C2EAF636BD59398D152553D0CA82A14B1BA684F882948157C82414A1581D3329D12C2E83032A39F75E1791977031EE188204892F5C7959594091972B027AEEF9FD87B3F3B8B00AB2BBCFF3C0E733F39BE5796157D9EF737EE77FCEFFFC4FB76E00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000722CBB2231E7DF4D1690B172E7CEEEEBBEFCE1A1B1B5517D7AC59B3B279F3E66DCCABBFFCC983FCC99FFC0140078A663F7FFEFCACA5A5257BF6D96755996AC3860DD9DCB9739FCE9B7F6FF953F2277FF207001D248E6C6AF615D3F49F6D6C6C5C2E7F4AFEE44FFE00A083C4340ECDB6722A6FF8BBE44FC99FFCC91F0074909843ADD15654C3CFE44FC99FFCC91F007471C3DFB6B9397B74D18DD9B259A353C59FE3394D5AC3973FF9933F257F005475C3DFFAD4DAECC1FF1E993D70E7B017543C17AF69D41ABEFCC99FFC29F903A06A1BFEEA6577ECD5EC8B5AB36CA646ADE1CB9FFCC99F923F00AAB7E12FBF676CBB0D3F5ED3A8357CF9933FF953F20740D536FC071B2F6BB7E1C76B1AB5862F7FF2277F4AFE00D0F095862F7FF2277F4AFE00A8B4861FAB12B5D7F0E3358D5AC3973FF9933F257F00546DC35FB9E09A761B7EBCA6516BF8F2277FF2A7E40F80AA6DF89BD62EC91EBCEBDFF79ECE913F17AF69D41ABEFCC99FFC29F903A06A1B7ED463FF73F35E0D3F9ED3A4357CF9933FF953F207407537FC1D3BB295F75EB7F7748EFCB9784DA3D6F0E54FFEE44FC91F0055D9F0E34EE20F2D6868770E7BBCE66EE31ABEFCC99FFC29F903A0BA1AFE8E1D59F3CAD9D9D2FFBAA4DD665F54BC27DEEB68A7862F7FF2277F4AFE00A8F886FF5247351DEDD4F0E54FFEE44FFEE40F80AA6DF8FB7354F3C58E766ADC1ABEFCC99FFC29F903A0621BFECB6DF64569DC1ABEFCC99FFC29F903A0621BBED2F0E54FFEE44FC95F653AF3CC33BB9F7EFAE9BDF36AC8AB29AFE6BCB2928AC74D35353537F4EDDBB77F5E47FB578343C09A356B7ACC9831E337D75E7BED8323468CD83A78F0E0E7FAF5EBD7FAE1AFAFAFDF79E185176E1A356AD4BC71E3C69D9D6F2C8EF4AFA6E16BF8F2A7E4CFEF5DFEAA453E80E999EFD3CCCC0730BBDB0C705EB2F2BFD39857AF934F3EF908FF925045B22C3BA2A9A9E9E289132736E7039A6CCC9831D9F4E9D3B3C58B17676BD7AECD76EFDE9D15366DDA942D59B224BBEDB6DBB26BAEB926CB073CBB870D1B766F5D5D5D0F031E0D5FC3973F257F4AFE2A553E60F9B77CB0B2F0400739EDD4A2FC7B9DEA5F15AAC0DCB973EB264C98B0F59C73CEC9A64D9B963537376707E2A9A79E4A1BD673CF3D77D790214316E41B80E30C7894862F7FF2277F4AFE2A459C8DC9072763F6754667F8F0E169FF67C18205D9E38F3F9E3DF3CC3369FF66E7CE9DE9F1C2850BD341E0912347B637F06930DB052AF8ACCED4A95397D6D5D56553A64C69FD80BF5C711628CEFA9C71C619BB060E1C38DC804769F8F2277FF2A7E4AFDCFAF5EB776CDBB33AF9BE4A76E38D371EF041DE55AB566593264D8AD92D6D073D4BE3E7F8D7860A927FC08F6B686868193A7468FAF076A4F87EE79F7FFE33F5F5F5B71C6E473C347C0D5FFE94FC29F9AB1CF940E784DADADA75A5839398B6DFD2D27250FB3A31BD7FF4E8D16D073DAB0FE7592E5071839D98C216A766633A5A6788B345BFFAD5AFB60F1C38F03F0FA78BFA347C0D5FFE94FC29F9AB9C333BA5839D38AB3367CE9C175C977CB0E6CF9F9FBEAF410F549098C616677662B073B053D8F6678ADBE5975FBE25DF104CD2F095862F7FF2277F4AFEBACA9E6B765AA7B1C56AB32B56ACE894FD9DB8C6A7CD14B7A57DFAF439CA5E2794495CB313D3D8B66CD992758518540D1932644BBEA1B958C3571ABEFCC99FFC29F9EB0AB14041E9999DCE1AEC940E7A4A6FE1110B19D8EB843298376F5E7D2C50D0D1D7ECECCF353DF946E0993E7DFA1CAFE12B0D5FFEE44FFE94FC75A63D4B4FB7AEC616D3D8BA424C6F6B73BF1E4B5643578AA96C575F7DF5B6588DAD1CA64F9FBE391FF44CD7F095862F7FF2277F4AFE3AF9ECCEC2D2050A3AF29A9D97D2662183456E4E0A5D286E2A1AF7D9E9ECEB765EEC7A9EBABABAF5B5B5B52769F84AC3973FF9933F257F9DA1A6A6A667E954B6835D8DEDE5ACDE567A3D4F3EF8EA652F14BAC8F8F1E39BE3A65AE53473E6CC58B9E44F1ABED2F0E54FFEE44FC95F67C8F7336616838DB8CF4E39DC72CB2DA5039E467BA1D005D6AC59D3A3BEBEFE806FAED5D16209ECDADADA270FE57BF368F81ABEFC29F953F2571EF9FE45F7D26B77CAB5DF1367954A1730C8FF9B8EB6370A9D6CC68C19BFB9F2CA2BB34AF0F39FFF7C519C6ED6F095862F7FF2277F4AFE3AF8EC4EEF6290317CF8F0B2EEEFC4ED3F4A063CFDED8D42279B3871E2B2E9D3A757C48067F2E4C94B0FE5A51A357C0D5FFE94FC29F92BDB80A7A11864947B1A7FEC7715FF2D35353537D81B854E3662C488AD8B172FAE8801CFFDF7DFBF32FFF03769F84AC3973FF9933F257F1D3CE0692A06190B162C28EBFE4EDC97A764B5B6A66E40E71A3C78F073E5BE7EA7B071E3C66DF907BF59C3571ABEFCC99FFC29F9EBE0014F7331C878FCF1C7CBBABFB376EDDAD2014F7337A073C585735DB906FD4B890FBF86AF347CF9933FF953F2D7C1039ED641C6CE9D3BCBBAAF133FBFF4BFC7DE2874C106A09218F0280D5FFEE44FFE94FC75E680A752F6770C78E0F03CC3B3D580A7F36AC3860DD9ECD9B3B3279E78629FAF3FF6D863E9EBCA952BD3D7DB6FBF3D7BE8A187B2356BD664B7DE7A6BB67DFBF67DFEBD980BFDDBDFFEB6DD9FBB7CF9F26CC68C19E9CFF7DF7F7FFA7E3B76ECC8EEBBEFBE6CFDFAF51AFE2198BF97CADAC1D4D6AD5BB355AB56A5DC5D7FFDF5E9E754632EE5AFB2B67FC5EF3C7EFFC5FB6FB8E186948B17FBBEB67FD539E029D78DD69DE18132F9C94F7EF26CA55CC3936FFC1F740D4FE7D59C397362A31A3779DDEBB5BBEEBA2B7BED6B5F1B4B83A7AF31D079E73BDF995D7BEDB545634C3B005BB66CC99A9A9AB2C1830767E79D775EAA134E3821BD7EF6D967B73E17AFDF7BEFBDE97B5F77DD7559F7EEDDD39FDFF7BEF765575C7145FAF36B5EF39AEC2F7FF98B867F08E6EFC5B2163B876F7AD39BB2B7BFFDEDED56E425DF36659B376FCE3EFCE10F67C71C734C7A2EB219DFB7B46A6B6BD30E64B5E552FE2A67FBB762C58AECA8A38ECA860D1B96BDEA55AF4A5FFFFAD7BFA6F7DF74D34DD93FFFF9CFECD39FFE743AF063FB57D5039ED66B78E2A0896B78E03072F1C5173F5129ABB4E58D648E55DA3ABEFEF5AF7FA5A3E27144311A73FC773CF9E493695053BC67D3A64DAD8DFBD4534FCDDEFBDEF7A6C61F3B9FEF7AD7BBD2F3F1DCB9E79E9B4D9932257BC52B5E910D1C3830D569A79D96DE575353D3FADC2B5FF9CA7437E9B973E766679D7556DA99983A756AF6918F7C24BBEAAAABD2CF7CFDEB5F9F96E69C3F7F7EB664C9120DFF10C8DFFE646DE9D2A5E90EE793274FCE6EBEF9E654B153195F2323F1F7060D1A9472B171E3C694B74F7CE213D957BEF2956CDCB871ADDFF7CB5FFE721A0C2D5BB6ACF57DD5944BF9AB9CED5FDCF8FA8B5FFC627AFD673FFB59F69DEF7C27FBD4A73E951EF7E8D1230D583EF0810F640F3FFCB0ED5F750F78ACD20687ABD1A347DF5529F7E1193F7EFC4CF7E1E9D85AB76E5D6ACE575F7D75F6F7BFFFBDB5E15F78E185A949C791F178DF4F7FFAD334A089D76307E181071E4803A05FFFFAD7D99FFFFCE7F4DE38621947DC636A5B3E50CEBEFAD5AF665FFFFAD7D391CFF87B5FF8C217D2E3AF7DED6B69A72176326EBBEDB6ECFBDFFF7E6AEE71643F1AFE673EF3997414349EEBDFBF7FF6EA57BF3A6B6868D0F0AB3C7FFB9BB5A8E2E879DB3335F15AFC390643F1E7D8698CC7EF7EF7BBDBADD8B9FCE31FFF5875B994BFCAD9FEC5819CD8FEC5C0E6FCF3CFCF62AA77DFBE7DD3FB8B814F6428EF51B67FD53DE069BD0F4F0C40DD87070E2363C78E3D6BDCB871CF57C28067D0A04133F30F7E4F0DBFE32AA66044338EA35945C39F356B56EB0E6771FD43CC6B8FA3E4D1F063DE7ADB9DD1A2625A48BC3F8EC01F77DC71E96ED53FFCE10FD36BE79C734E7A1CCFC7F48EE2BFE1F7BFFF7DF6B6B7BD2D5D1B140D3F8E94C6463E1A7EFCBDD8D930A5A3FAF3B7BF592BF9B74F47C0FFF18F7FA4B33503060CD86BC013677DDEFCE637A7EBC9E208FA37BFF9CD3425A9B4DEF296B76493264DAABA5CCA5FE56CFF6289E2181C7DFCE31FCF4E3CF1C4EC1BDFF846F6A52F7D29BDE7E8A38F4E677CBEF5AD6F65BFFCE52F6DFFAA7BC0D3BB1864C4EFAA9C468E1CD93AE0C907D7FDED8D42273BF3CC338FACABABDB19539ACA7C0F9EB87E6743FCF768F81D57F5F5F56987318E4A9636FC6DDBB6A51DC59E3D7BB6BE77E2C489E9F59872115FE3E87A4CC788461FD31EE3B9625E7A34F4F7BCE73D599E9DF47ABC161BEE781C47DD8B861F3BB371B4345E8F66DF764AC78F7EF42373D80F91FC1D48D68A014F7101F977BFFBDD7D0E78E2A2EEC848FCFD78FE0D6F7843DA012D2A76242377C5C5DFD5944BF9ABACED5F9C8189D763501DD7D6BCE31DEF488FBFFDED6F6743870E4D67758AF7DAFE55EDFE4EF7FCF7B4AB18683CF2C82365D9DF6969698933DACF970C788EB6370A5D60F8F0E1F7C491D2726A6868B829FFE0FF49C3EFB88A55D7E222EF68B8F1B8B4E1C7E37CE39F1EC7F313264C48533F6287328E3CC5F3311523AE9D88EB24E202F2B6039E638F3D367DFDDEF7BE975E8BE919A5CF173B1CF15A34F7BFFDED6FFB9CC35E3AD549C3AFCEFC1D48D64A073C319527A6A37DF2939FDCE780A7A8D83189A96BF19EDFFDEE77AD15ABB4C56A4BA53BA2D5924BF9AB9CED5F2C2C10F97AFFFBDFFF8233DAB10D8CA96D9FFDEC67D3C219D59833F9DBEB2CCFCC62A011DB8F7288838925839D467BA1D045EAEAEA7AFCF8C73FDE5DAE651A77EFDEBD3AFFD03F5C5B5B7B9286DF7115532CA2D92E5AB4689F0D3FCEDAC4C204BD7AF5CAEEB8E38EB4425BCC3F8FAFF1BECF7FFEF3690720162D88850CDA0E788E3FFEF8ECB2CB2E4B17E9C66B312F3E1E7FF0831F6C6DF8B1FA515C681E47E2E3F1BE1AFEE5975F9E06591A7EF5E6EF40B2563AE079E31BDF98566C8BAF3135A8BD01CFA851A35A77423FFAD18FA6EB26E2C87D3C8EEB244A7744AB2597F25739DBBF5FFCE217D905175C9056678B696D175D7451EB756571D626A6B7C5199D6ACC99FCBD504C9B2F061B679C71463ADBD2956236CD8001034ACFEEF4B2170A5DE8BCF3CE9B5BAEC50BAEB8E28AC9F9077F9A86DFB11547AF7AF7EEDDFAB86DC32FE6A2C7FB8AC771816E34EDE27D7171ED0F7EF083B4AA51E980279A7C34F198EBFEB9CF7D2EBD16D761C4E378BE74AA463187BD68F8314D2E9A7CD1F0E322E1F8191A7EF5E6EF40B376E79D77A62945B1247EDBEFD576C0134B02C7A02816D688EB2B62C0131785C7D1FB4B2FBDF4057FB79A72297F95B3FD7BFAE9A75B074931A5AD786F6422062FB14260E980C7F6AFEACFF2B4AED6367AF4E82EBD1761FCBC92D5D9169D7CF2C947D803852ED4A74F9F63F20DF1B35DBD367DBE333337FFD06FCD7FFEF11A7EE7544C078A8B6EA321772B5978A0B462BA45EC441E79E4916967B3DB9E65A8DFFAD6B7A6A3EF1FFAD087D273F1BE787F2CA55A5CF01B7F8ED78A1B97C6FF6731308AAF71142DAEB788C1D3EB5EF7BA34752EA689C452ADA79C724ABA37451C61D5F0AB3F7FFB93B57D551CF58CFC1567728AFB93C4C5E63195287218D758C4C205F17A64A858E56ACC9831E9868ED5964BF9AB9CED5F2C2810077A62C1815844A058C23A063F710628A6F6C6B539C5FB6DFFAA5B3EC03CA5F4A69F9189AE105929FDB9790E4EB5F70965505B5B3B64E8D0A1FFD75553DBB66FDFBE2CFF99CBF20FFE451A7EE755FC3EE348671C7D8C238F71F3D0B6EF89061F3B043185236E8816839D387A1EF74B898AA3A0B133500C78DADED02F8E60C691F8B6AFFDE10F7F48D3E2E21AA0112346A465AEE35E16F1DA95575E992E088E2923AB57AFD6F00F81FCED4FD6DAABC8DFC73EF6B1B4DC6F71E6270EC0C4CEE13DF7DC93EE8712D744C414B61820C5FD50E248FB49279DD49AA96ACAA5FC55CEF62FB679318537AEF7890152AC1E18077AE268FCD8B163D319981898B4774353DBBFAA3CCB735531F088DF7B0C463AFBBE3BFDFBF77FBE64C0D3D00D289F7C07E2E651A34675FAA067F7EEDDABF20DFDECFC437F9D86AF5CB42B7FF2277F4AFEBA4A4C252B9DDA16839ECEBA19690C76060C18F05CC96067699F3E7D8EB2C70965DE08E40391DB2FBDF4D22D9D35E889333BF9C0EA9EB86EE7505E865AC3D7F0E54FC99FFCC95F65CA0739C7E6FB212B4B073D71C6AE23AFE98933476DCEECACCEEB387B9B5021839EDADADAEB870C19B2A5A3AFE9896B76F64C63BBEE701AEC68F81ABEFC29F9F37B97BFCA12838FD2414FB190C1C1AEDE16D36EDB2C5060B00395AAA6A66670BF7EFDB64D9D3AF5A99D3B771EF4D2D37B5663DB7AB85CB3A3E16BF8F2A7E44FFEE4AF2ACEF434950E4E62B189B87E35AE273CD09B8AC67D764A979E2EA6B119EC40058BD5DBFAF6ED7B6BFEE1DD3C6DDAB447366DDAB4EB403EFC1B376E7C306E2A9A7F8F1531852DFF7AC2E1FA6FA9E16BF8F2A7E44FC95FE589992D35353513DA0C52525D72C925D9D4A953D3353E31EBA538001C5F63C18BB84627165389FB29D5D6D63EBF8FEFD1E09A1DA89EB33D27E67543FE61DE72C105172C9E3469D2E2FBEEBBEF9175EBD66D2F19DF6C8D014E5353D39CF1E3C7CF1C346850DCD178433EC89972A8DF5454C3D7F0E54FC99FFCC95F75DBB36475D3BE063E2FA316597A1AAA545C77B36783104B3AC6C2038FE5B5ABE403DEBC6763D11077343EDCAED3D1F0357CF953F2277FF257F507797BE6FB3133DBECDFEC57E5839CC6BC7AB9A92860C0A3347CF9933FF953F257E90779BBE7839FD3E320EE9E83B9CD6D0638E9206FCC80C90739FDE33200FF6A80018F46ABE1CB9F923F257F0068F84AC3973FF9933F257F0068F84AC3973FF9933F257F0068F8CA0EA7DFBBFCC99F32E00140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257F7EEFF2078086AF347CF9933FF953F2078086AF347CF9933FF953F2078086AF347CF9933FF953063C0068F81ABEFC29F9933FF903000D5FC3973F257FF2277F00A0E16BF8F2A7E44FFEE40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5FC3B7C3A9E44FFEE40F003ACADD77DFADD1564E3D9337FC5DF2A7E44FFEE40F003AC8BC79F39A5B5A5A34DB0AA8B56BD7FE47DEF097CB9F923FF9933F00E820B367CF3E6DCE9C399BD7AF5FFF7F9A6EF98E6C46B39F356BD6FFE6D55BFE94FCC99FFC014007CA9B4CCFC6C6C645319D20E650AB2EAFF8775F7EB8367BF9933FF9933F831D00000000000000000000000000000000000000000000000000000000800EF0FFD66A164269EFF9270000000049454E44AE426082, 1);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b9bfa803-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.bpmn20.xml', 'b9bfa802-3e59-11ed-8a80-4e744305f12a', 0x3C3F786D6C2076657273696F6E3D22312E302220656E636F64696E673D225554462D38223F3E0A3C646566696E6974696F6E7320786D6C6E733D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F4D4F44454C2220786D6C6E733A7873693D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612D696E7374616E63652220786D6C6E733A7873643D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D612220786D6C6E733A666C6F7761626C653D22687474703A2F2F666C6F7761626C652E6F72672F62706D6E2220786D6C6E733A62706D6E64693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F42504D4E2F32303130303532342F44492220786D6C6E733A6F6D6764633D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44432220786D6C6E733A6F6D6764693D22687474703A2F2F7777772E6F6D672E6F72672F737065632F44442F32303130303532342F44492220747970654C616E67756167653D22687474703A2F2F7777772E77332E6F72672F323030312F584D4C536368656D61222065787072657373696F6E4C616E67756167653D22687474703A2F2F7777772E77332E6F72672F313939392F585061746822207461726765744E616D6573706163653D22687474703A2F2F7777772E666C6F7761626C652E6F72672F70726F63657373646566223E0A20203C70726F636573732069643D2250726F636573735F46615942777A4F3922206E616D653D22E8AFB7E58187E6B581E7A88B2220697345786563757461626C653D2274727565223E0A202020203C646F63756D656E746174696F6E3EE8AFB7E58187E6B581E7A88B3C2F646F63756D656E746174696F6E3E0A202020203C73746172744576656E742069643D224576656E745F393575504A59314D22206E616D653D22E5BC80E5A78B2220666C6F7761626C653A696E69746961746F723D226170706C795573657249642220666C6F7761626C653A666F726D4B65793D2232223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E8AFB7E58187E4BABA223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E8AFB7E58187E58E9FE59BA0223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E8AFB7E58187E5A487E6B3A8223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F73746172744576656E743E0A202020203C757365725461736B2069643D2241637469766974795F30736A7830726F22206E616D653D22E5B08FE78CABE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22322220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E8AFB7E58187E4BABA223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E8AFB7E58187E58E9FE59BA0223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E8AFB7E58187E5A487E6B3A8223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A657865637574696F6E4C697374656E6572206576656E743D2273746172742220636C6173733D22636F6D2E656E7466726D2E62697A2E776F726B666C6F772E6C697374656E65722E4D79457865637574696F6E4C697374656E6572223E3C2F666C6F7761626C653A657865637574696F6E4C697374656E65723E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22372220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F3064643061646E2220736F757263655265663D224576656E745F393575504A59314D22207461726765745265663D2241637469766974795F30736A7830726F223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F30353837646B3022206E616D653D22E5B08FE58FAFE788B1E5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22322220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E8AFB7E58187E4BABA223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E8AFB7E58187E58E9FE59BA0223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E8AFB7E58187E5A487E6B3A8223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D22382220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F316168346C66362220736F757263655265663D2241637469766974795F30736A7830726F22207461726765745265663D2241637469766974795F30353837646B30223E3C2F73657175656E6365466C6F773E0A202020203C757365725461736B2069643D2241637469766974795F31383134676D3922206E616D653D22E5B08FE78CAAE5AEA1E689B92220666C6F7761626C653A666F726D4B65793D22322220666C6F7761626C653A666F726D547970653D2231223E0A2020202020203C657874656E73696F6E456C656D656E74733E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F56794B6D3949374822206E616D653D22E8AFB7E58187E4BABA223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F667877577A67416322206E616D653D22E8AFB7E58187E58E9FE59BA0223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A666F726D50726F70657274792069643D22696E7075745F377A38366B4C4B4A22206E616D653D22E8AFB7E58187E5A487E6B3A8223E3C2F666C6F7761626C653A666F726D50726F70657274793E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F616772656522206E616D653D22E5908CE6848F22206973486964653D22302220736F72743D2232223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F72656A65637422206E616D653D22E9A9B3E59B9E22206973486964653D22302220736F72743D2233223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F726F6C6C5F6261636B22206E616D653D22E68C87E5AE9AE59B9EE9808022206973486964653D22302220736F72743D2234223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7472616E7366657222206E616D653D22E8BDACE58A9E22206973486964653D22302220736F72743D2237223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F64656C656761746522206E616D653D22E5A794E6B4BE22206973486964653D22302220736F72743D2238223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F73746F7022206E616D653D22E7BB88E6ADA222206973486964653D22302220736F72743D2239223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A427574746F6E20636F64653D225F776F726B666C6F775F61637469766974795F7072696E7422206E616D653D22E68993E58DB022206973486964653D22302220736F72743D223130223E3C2F666C6F7761626C653A427574746F6E3E0A20202020202020203C666C6F7761626C653A41737369676E656520747970653D2275736572222076616C75653D2231302220636F6E646974696F6E3D223022206F7065726174696F6E547970653D22302220736F72743D2230223E3C2F666C6F7761626C653A41737369676E65653E0A2020202020203C2F657874656E73696F6E456C656D656E74733E0A202020203C2F757365725461736B3E0A202020203C73657175656E6365466C6F772069643D22466C6F775F307A306A3730782220736F757263655265663D2241637469766974795F30353837646B3022207461726765745265663D2241637469766974795F31383134676D39223E3C2F73657175656E6365466C6F773E0A202020203C656E644576656E742069643D224576656E745F31656339393535223E3C2F656E644576656E743E0A202020203C73657175656E6365466C6F772069643D22466C6F775F31786C617662762220736F757263655265663D2241637469766974795F31383134676D3922207461726765745265663D224576656E745F31656339393535223E3C2F73657175656E6365466C6F773E0A20203C2F70726F636573733E0A20203C62706D6E64693A42504D4E4469616772616D2069643D2242504D4E4469616772616D5F50726F636573735F46615942777A4F39223E0A202020203C62706D6E64693A42504D4E506C616E652062706D6E456C656D656E743D2250726F636573735F46615942777A4F39222069643D2242504D4E506C616E655F50726F636573735F46615942777A4F39223E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F393575504A59314D222069643D2242504D4E53686170655F4576656E745F393575504A59314D223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223230392E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30736A7830726F222069643D2242504D4E53686170655F41637469766974795F30736A7830726F223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223330302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F30353837646B30222069643D2242504D4E53686170655F41637469766974795F30353837646B30223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223436302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D2241637469766974795F31383134676D39222069643D2242504D4E53686170655F41637469766974795F31383134676D39223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2238302E30222077696474683D223130302E302220783D223632302E302220793D223236312E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E53686170652062706D6E456C656D656E743D224576656E745F31656339393535222069643D2242504D4E53686170655F4576656E745F31656339393535223E0A20202020202020203C6F6D6764633A426F756E6473206865696768743D2233362E30222077696474683D2233362E302220783D223738322E302220793D223238332E30223E3C2F6F6D6764633A426F756E64733E0A2020202020203C2F62706D6E64693A42504D4E53686170653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F31786C61766276222069643D2242504D4E456467655F466C6F775F31786C61766276223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223731392E3934393939393939393937382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223738322E302220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F3064643061646E222069643D2242504D4E456467655F466C6F775F3064643061646E223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223234342E39343939393835343937303035352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223239392E393939393939393939393535372220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F316168346C6636222069643D2242504D4E456467655F466C6F775F316168346C6636223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223339392E39353030303030303030303030352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223435392E39393939393939393939353138352220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A2020202020203C62706D6E64693A42504D4E456467652062706D6E456C656D656E743D22466C6F775F307A306A373078222069643D2242504D4E456467655F466C6F775F307A306A373078223E0A20202020202020203C6F6D6764693A776179706F696E7420783D223535392E393439393939393939383431392220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A20202020202020203C6F6D6764693A776179706F696E7420783D223631392E393939393939393939393531382220793D223330312E30223E3C2F6F6D6764693A776179706F696E743E0A2020202020203C2F62706D6E64693A42504D4E456467653E0A202020203C2F62706D6E64693A42504D4E506C616E653E0A20203C2F62706D6E64693A42504D4E4469616772616D3E0A3C2F646566696E6974696F6E733E, 0);
INSERT INTO `act_ge_bytearray` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES ('b9ce9c24-3e59-11ed-8a80-4e744305f12a', 1, '请假流程.Process_FaYBwzO9.png', 'b9bfa802-3e59-11ed-8a80-4e744305f12a', 0x89504E470D0A1A0A0000000D494844520000033C0000015F08060000008B09C9330000187C4944415478DAEDDD0B905775D90770BA5B59515959D96465E54C16566F65935D751A354AA62064C1D0A50D5342BC2065E02B64128A50AC8E999468162F83032A39BDAF8BC8255C8C770C4182C40BAF5C566E8A5C12013DEF79CE70768E0BAB20BBFBFF9FE5F3997966FD5FD85D77BF7B9EF33BE7777EA74B170000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080039124C96B1F7BECB1A90B162C78FE9E7BEE491A1A1A5407D7CC993393B973E76E4CAB9FFCC983FCC99FFC01401B8A663F6FDEBC64FDFAF5C973CF3DA72A541B366C48E6CC99F34CDAFC7BCA9F923FF9933F006823716453B3AF9AA6FF5C4343C332F953F2277FF207006D24A67168B6D55369C3DF257F4AFEE44FFE00A08DC41C6A8DB6AA1A7E227F4AFEE44FFE00A0831BFEB6CD4DC9630B6F4A96CE1C9555FC773CA7496BF8F2277FF2A7E40F805237FCAD4FAF491EFA9F11C983770D7D51C573F19A46ADE1CB9FFCC99F923F004ADBF0572DBD73AF669FD7EAA533346A0D5FFEE44FFE94FC0150DE86BFECDE31AD36FC784DA3D6F0E54FFEE44FC91F00A56DF80F355CDE6AC38FD7346A0D5FFEE44FFE94FC01A0E12B0D5FFEE44FFE94FC01506D0D3F56256AADE1C76B1AB5862F7FF2277F4AFE00286DC35F31FFDA561B7EBCA6516BF8F2277FF2A7E40F80D236FC4D6B16270FDDFD9F7B4FE7489F8BD7346A0D5FFEE44FFE94FC0150DA861FF5F8FFDEB257C38FE734690D5FFEE44FFE94FC0150EE86BF6347B2E2BEEBF79ECE913E17AF69D41ABEFCC99FFC29F903A0940D3FEE24FEF0FCFA56E7B0C76BEE36AEE1CB9FFCC99F923F00CAD5F077EC489A56CC4A96FCF7A5AD36FBBCE23DF15E473B357CF9933FF953F20740D537FC973BAAE968A7862F7FF2277FF2277F0094B6E1EFCF51CD973ADAA9716BF8F2277FF2A7E40F80AA6DF8AFB4D9E7A5716BF8F2277FF2A7E40F80AA6DF84AC3973FF9933F257FD5E9ACB3CEEA7AC61967F44CAB3EADC6B49AD24A0A158F1B7BF7EE7D639F3E7DFAA575849F1A7402AB57AFEE367DFAF45F5F77DD750F0D1F3E7CEBA041839EEFDBB76FF31F7F5D5DDDCE8B2EBA68D3C89123E78E1D3BF69C746371989F9A86AFE1CB9F923FBF77F92B8B7400D33DDDA799910E6076B718E0BC6CA5FFA621AD1E5FFBDAD75EEB2709259224C96B1B1B1B2F99306142533AA049468F1E9D4C9B362D59B46851B266CD9A64F7EEDD496ED3A64DC9E2C58B93DB6FBF3DB9F6DA6B9374C0B37BE8D0A1F7D5D6D67633E0D1F0357CF953F2A7E4AF5AA50396FF48072B0B0E7490D34A2D4C3FD7297EAA500273E6CCA91D3F7EFCD673CF3D37993A756AD2D4D4941C88A79F7E3ADBB09E77DE79BB060F1E3C3FDD001C6DC0A3347CF9933FF953F2572DE26C4C3A3819BDAF333AC3860DCBF67FE6CF9F9F3CF1C413C9B3CF3E9BEDDFECDCB9337BBC60C182EC20F08811235A1BF8D49BED02557C5667CA94294B6A6B6B93C9932737FF81BF52711628CEFA9C79E699BB060C1830CC804769F8F2277FF2A7E4AFD2FAF6ED7B54CBB33AE9BE4A72D34D371DF041DE952B572613274E8CD92D2D073D4BE2EBF869431549FFC08FAEAFAF5F3F64C890EC8FB72DC5E7BBE0820B9EADABABBBF5503BE2A1E16BF8F2A7E44FC95FF548073AC7D6D4D4AC2D0E4E62DAFEFAF5EB0F6A5F27A6F78F1A35AAE5A067D5A13CCB05AA6EB01353D8E2D46C4C476B0F71B6E897BFFCE5F6010306FCF550BAA84FC3D7F0E54FC99F92BFEA39B3531CECC4599DD9B367BFE8BAE483356FDEBCECF31AF4401589696C716627063B073B856D7FA6B85D71C5155BD20DC1440D5F69F8F2277FF2A7E4AFA3ECB966A7791A5BAC36BB7CF9F276D9DF896B7C5A4C715BD2AB57AFC3ED754285C4353B318D6DCB962D49478841D5E0C183B7A41B9A4B347CA5E1CB9FFCC99F92BF8E100B1414CFECB4D760A738E829DEC2231632B0D709153077EEDCBA58A0A0ADAFD9D99F6B7AD28DC0B3BD7AF53A46C3571ABEFCC99FFC29F96B4F7B969E6E5E8D2DA6B1758498DED6E27E3D96AC868E1453D9AEB9E69A6DB11A5B254C9B366D733AE899A6E12B0D5FFEE44FFE94FCB5F3D99D05C5050ADAF29A9D97D3622183856E4E0A1D286E2A1AF7D969EFEB765EEA7A9EDADADA75353535C76BF84AC3973FF9933F257FEDA177EFDEDD8B53D90E7635B657B27A5BF17A9E74F0D5C35E28749071E3C635C54DB52A69C68C19B172C91F357CA5E1CB9FFCC99F92BFF690EE67CCC8071B719F9D4AB8F5D65B8B039E067BA1D00156AF5EDDADAEAEEE806FAED5D66209EC9A9A9AA73AF3BD79347C0D5FFE94FC29F9AB8C74FFA26BF1DA9D4AEDF7C459A5E20206E9F77484BD516867D3A74FFFF555575D9554839FFDEC670BE37473D97E86718426AD13357C0D5FFE94FCC99FFC55670ED3C145CF7C90316CD8B08AEEEFC4ED3F0A039E7EF646A19D4D983061E9B469D3AA62C03369D2A425655CAAB1786A3A1DB09DA0E16BF8F2A7E44FFEE4AFBA7218FB17F9FB2A3D8D3FF6BBF2EF25FD7E6FB4370AED6CF8F0E15B172D5A5415039E071E786045FAC7DF58D60D6DA1FEBAAF234D1ABE862F7F4AFE94FC552687B17F91BF3E7FFEFC8AEEEFC47D790ADF6B6317A07D0D1A34E8F94A5FBF93DBB871E3B6F40FBFA9136C689B8F341537B81ABE862F7F4AFE94FC552687B17F913FFFC4134F54747F67CD9A35C5EFB3A90BD0BEE2C2B98E5C83FEE5C41F7F67D9D0168F34C529760D5FC3973F257F4AFE2A93C3E2E39D3B7756745F27BE7EF1FBB1370A1DB091A826FBB1D12A6D69F8D5559D396BF2277FF2A7E4AFF5AAB6FD1D7BA370689DE1D9DAC9CEF064ABCEE57752AE74C3DFB06143326BD6ACE4C9279FDCE7EB8F3FFE78F671C58A15D9C73BEEB82379F8E18793D5AB5727B7DD765BB27DFBF67DFEBB980BFD9BDFFCA6D5AFBB6CD9B264FAF4E9D97F3FF0C003D9E7DBB1634772FFFDF727EBD6AD7384B313E6EFE5B27630B575EBD664E5CA9559EE6EB8E186ECEB943197F2575DDBBFFC771EBFFFFCFD37DE7863968B97FABCB67FE5C961F1F94ADD68DD191EA8901FFFF8C7CF55CB353CE9C6FFA14E720DCF8B1A7DAED20D7FF6ECD9B1518D9BBCEEF5DADD77DF9DBCE10D6F88A5C1B38F31D079CF7BDE935C77DD757963CC7600B66CD9923436362683060D4ACE3FFFFCAC8E3DF6D8ECF573CE39A7F9B978FDBEFBEECB3EF7F5D75F9F74EDDA35FBEF0F7EF083C995575E99FDF7EB5FFFFAE4CF7FFEB386DF09F3F752598B9DC3B7BEF5ADC9BBDEF5AE562BF2926E9B92CD9B37271FFBD8C792238F3C327B2EB2199FB758353535D90E64D972297FD5B3FD5BBE7C7972F8E1872743870E4D5EF39AD7641FFFF297BF64EFBFF9E69B937FFEF39FC9E73EF7B9ECC08FED5F797358BC86270E9AB886070E21975C72C993D5B24A5BDA4866977C95B6C63E7DFAF468D9E82BDDF0FFF5AF7F6547C5E3886234E6F83E9E7AEAA96C5093BF67D3A64DCD8DFB94534E493EF0810F648D3F763EDFFBDEF766CFC773E79D775E3279F2E4E455AF7A553260C080AC4E3FFDF4EC7D6973697EEED5AF7E757637E93973E624679F7D76B6333165CA94E4E31FFF7872F5D557675FF34D6F7A53B634E7BC79F392C58B176BF89D207FFB93B5254B966477389F34695272CB2DB764153B95F1313212FF6EE0C081592E366EDC98E5EDD39FFE74F2D5AF7E35193B766CF3E7FDCA57BE920D86962E5DDAFCBE32E552FEAA67FB1737BE3EF1C413B3D77FFAD39F26DFFEF6B793CF7EF6B3D9E36EDDBA6503960F7FF8C3C9238F3C62FB57E21C5AA50D0E61A3468DBABB5AEEC3336EDCB81925BD0FCF3E8F685643C35FBB766DD69CAFB9E69AE4EF7FFF7B73C3BFE8A28BB2261D47C6E37D3FF9C94FB2014DBC1E3B080F3EF8603600FAD5AF7E95FCE94F7FCADE1B472CE3887B4C6D4B07CAC9D7BFFEF5E4A4934ECA8E7CC6BFFBD297BE943DFEC637BE91ED34C44EC6EDB7DF9E7CEF7BDFCB9A7B1CD98F86FFF9CF7F3E3B0A1ACFF5EBD72F79DDEB5E97D4D7D76BF825CFDFFE662D2A3F7ADEF24C4DBC16FF1D83A1F8EFD8698CC7EF7BDFFB5AADD8B9FCC31FFE50BA5CCA5FF56CFFE2404E6CFF626073C105172431D53BDD69CEDE9F0F7C2243698FB2FD2B710E8BF7E18901A8FBF0C02164CC9831678F1D3BF6856A18F00C1C3870466CB03AEBCFBA120D3FA66044338EA35979C39F397366F30E677EFD43CC6B8FA3E4D1F063DE7ACB9DD1BC625A48BC3F8EC01F7DF4D1D9DDAA7FF0831F64AF9D7BEEB9D9E3783EA677E4DFC3EF7EF7BBE49DEF7C67766D5034FC38521A1BF968F8F1EF6267C3948EF2E76F7FB356F8D96747C0FFF18F7F64676BFAF7EFBFD78027CEFABCED6D6FCBAE278B23E8A79E7A6A3625A9586F7FFBDB93891327962E97F2573DDBBF58A23806479FFAD4A792E38E3B2EF9E637BF997CF9CB5FCEDE73C4114764677C4E3BEDB4E417BFF885ED5FB907453DF34146FCAE2A69C48811C5A5B3FBD91B857676D659671D565B5BBB33A63455F81E3C71FDCE86F87E34FCB6ABBABABA6C87318E4A161BFEB66DDBB21DC5EEDDBB37BF77C28409D9EB31E5223EC6D1F5988E118D3EA63DC673F9BCF468E8EF7FFFFB93343BD9EBF15A6CB8E3711C75CF1B7EECCCC6D1D2783D9A7DCB291D3FFCE10FCD61EF24F93B90ACE5039EFC02F2EF7CE73BFB1CF0C445DD9191F8F7F1FC9BDFFCE66C0734AFD8918CDCE5177F972997F2575DDBBF380313AFC7A03AAEAD79F7BBDF9D3DFED6B7BE950C1932243BAB93BFD7F6AFB4FB3B5DD3DFD3AE7CA0F1E8A38F56647F67FDFAF57146FB85C280E7087BA3D001860D1B766F1C29ADA4FAFAFA9BD33FFC3F6AF86D57B1EA5A5CE41D0D371E171B7E3C4E37FED9E3787EFCF8F1D9D48FD8A18C234FF17C4CC5886B27E23A89B880BCE580E7A8A38ECA3E7EF7BBDFCD5E8BE919C5E7F31D8E782D9AFBDFFEF6B77DCE612F4E75D2F0CB99BF03C95A71C0135379623ADA673EF3997D0E78F28A1D9398BA16EFF9ED6F7FDB5CB14A5BACB654DC112D4B2EE5AF7AB67FB1B040E4EB431FFAD08BCE68C73630A6B67DE10B5FC816CE2863CEE46FAFB33C33F281466C3F2A210E26166F8C6A2F143A486D6D6DB71FFDE847BB2BB54CE3EEDDBB57A57FF48FD4D4D41CAFE1B75DC5148B68B60B172EDC67C38FB336B130418F1E3D923BEFBC335BA12DE69FC7C778DF17BFF8C56C0720162D88850C5A0E788E39E698E4F2CB2FCF2ED28DD7625E7C3CFEC8473ED2DCF063F5A3B8D03C8EC4C7E37D35FC2BAEB8221B6469F8E5CDDF8164AD38E079CB5BDE92ADD8161F636A506B039E91234736EF847EE2139FC8AE9B8823F7F138AE9328EE88962597F2573DDBBF9FFFFCE7C985175E98ADCE16D3DA2EBEF8E2E6EBCAE2AC4D4C6F8B333A65CC99FCBD584C9BCF071B679E796676B6A523C56C9AFEFDFB17CFEEF4B0170A1DE8FCF3CF9F53A9C50BAEBCF2CA49E91FFE540DBF6D2B8E5EF5ECD9B3F971CB869FCF458FF7E58FE302DD68DAF9FBE2E2DAEF7FFFFBD9AA46C5014F34F968E231D7FD84134EC85E8BEB30E2713C5F9CAA91CF61CF1B7E4C938B269F37FCB84838BE86865FDEFC1D68D6EEBAEBAE6C4A512C89DFF273B51CF0C492C031288A8535E2FA8A18F0C445E171F4FEB2CB2E7BD1BF2D532EE5AF7AB67FCF3CF34CF32029A6B4E5EF8D4CC4E02556082C0E786CFF4A7F96A779B5B651A34675E8BD08E3EB1597CE7EB9C53E8036D6AB57AF23D30DF1731DBD367DBA333327FDA3DF9A7EFD6334FCF6A9980E1417DD4643EE525878A05831DD2276220F3BECB06C67B3CB9E65A8DFF18E776447DF3FFAD18F66CFC5FBE2FDB1946A7EC16FFC77BC96DFB834FE3FF381517C8CA36871BD450C9EDEF8C6376653E7629A482CD57AF2C92767F7A68823AC1A7EF9F3B73F59DB57C551CFC85F7E2627BF3F495C6C1E53892287718D452C5C10AF4786F255AE468F1E9DDDD0B16CB994BFEAD9FEC5820271A027161C884504F225AC63F0136780626A6F5C9B93BFDFF6AFDCD201E6C9C57BF644263A4264A5F875D31C9C62EF132AA0A6A666F0902143FEDD5153DBB66FDFBE34FD9A4BD33FFC8B35FCF6ABF87DC691CE38FA18471EE3E6A12DDF130D3E7608620A47DC102D063B71F43CEE97121547416367201FF0B4BCA15F1CC18C23F12D5FFBFDEF7F9F4D8B8B6B80860F1F9E2D731DF7B288D7AEBAEAAAEC82E09832B26AD52A0DBF13E46F7FB2D65A45FE3EF9C94F66CBFDE6677EE2004CEC1CDE7BEFBDD9FD50E29A8898C21603A4B81F4A1C693FFEF8E39B3355A65CCA5FF56CFF629B175378E37A9F1820C5EA8171A0278EC68F1933263B03130393D66E686AFB57CAB33C57E7038FF8BDC760A4BDEFBBD3AF5FBF170A039EFA2E40E5A43B10B78C1C39B2DD073DBB77EF5E996EE867A57FF4D76BF8CA45BBF2277FF2A7E4AFA3C454B2E2D4B618F4B4D7CD4863B0D3BF7FFFE70B839D25BD7AF53ADC1E27547823900E44EEB8ECB2CBB6B4D7A027CEECA403AB7BE3BA9DCEBC0CB586AFE1CB9F923FF993BFEA940E728E4AF7435614073D71C6AE2DAFE98933472DCEECAC4AEB687B9B5025839E9A9A9A1B060F1EBCA5ADAFE9896B76F64C63BBFE501AEC68F81ABEFC29F9F37B97BFEA12838FE2A0275FC8E060576F8B69B72D162830D8816AD5BB77EF417DFBF6DD3665CA94A777EEDC79D04B4FEF598D6DEBA172CD8E86AFE1CB9F923FF993BF529CE9692C0E4E62B189B87E35AE273CD09B8AC67D768A4B4FE7D3D80C76A08AC5EA6D7DFAF4B92DFDE3DD3C75EAD447376DDAB4EB40FEF8376EDCF850DC5434FD1CCB630A5BFAF1D843F567A9E16BF8F2A7E44FC95FF589992DBD7BF71EDF629092D5A5975E9A4C993225BBC62766BDE40780E3632C7811D7E8C4622A713FA59A9A9A17F6F139EA5DB303E539DB735C5A37A67FCC5B2EBCF0C24513274E5C74FFFDF73FBA76EDDAED85F1CDD618E0343636CE1E376EDC8C810307C61D8D37A4839CC99DFDA6A21ABE862F7F4AFEE44FFECA6DCF92D58DFB1AF8BC825A68E96928A9B8EE66CF062196748C85071E4F6B57E10FBC69CFC6A23EEE687CA85DA7A3E16BF8F2A7E44FFEE4AFF40779BBA7FB31335AECDFEC57A5839C86B47AB8A92860C0A3347CF9933FF953F257ED0779BBA6839F33E220EE9E83B94D2D0638D941DE9801930E72FAC565007E6A80018F46ABE1CB9F923F257F0068F84AC3973FF9933F257F0068F84AC3973FF9933F257F0068F8CA0EA7DFBBFCC99F32E00140C3D7F0E54FC99FFCC91F0068F81ABEFC29F9933FF903000D5FC3973F257F7EEFF2078086AF347CF9933FF953F2078086AF347CF9933FF953F2078086AF347CF9933FF953063C0068F81ABEFC29F9933FF903000D5FC3973F257FF2277F00A0E16BF8F2A7E44FFEE40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5F69F8F2277FF2A7E40F000D5FC3B7C3A9E44FFEE40F00DACA3DF7DCA3D1564F3D9B36FC5DF2A7E44FFEE40F00DAC8DCB9739BD6AF5FAFD95641AD59B3E6BFD286BF4CFE94FCC99FFC01401B99356BD6E9B367CFDEBC6EDDBA7F6BBA953BB219CD7EE6CC99FF97564FF953F2277FF207006D286D32DD1B1A1A16C674829843AD3ABCE2E7BEEC506DF6F2277FF2277F063B00000000000000000000000000000000000000000000000000000000006DE0FF019B4266A3D06D18040000000049454E44AE426082, 1);
COMMIT;

-- ----------------------------
-- Table structure for act_ge_property
-- ----------------------------
DROP TABLE IF EXISTS `act_ge_property`;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ge_property
-- ----------------------------
BEGIN;
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.execution-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('cfg.task-related-entities-count', 'true', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('common.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('entitylink.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('eventsubscription.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('identitylink.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('job.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('next.dbid', '1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.history', 'create(6.5.0.1)', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('task.schema.version', '6.5.0.1', 1);
INSERT INTO `act_ge_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('variable.schema.version', '6.5.0.1', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_actinst`;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_EXEC` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_actinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', 'Event_95uPJY1M', NULL, NULL, '开始', 'startEvent', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('26b1fa09-3e5a-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', 'Flow_0dd0adn', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('26b2211a-3e5a-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', '26b2211b-3e5a-11ed-8a80-4e744305f12a', NULL, '小猫审批', 'userTask', '7', '2022-09-27 19:47:23.554', '2022-09-27 20:01:55.833', 872279, 'Change activity to Event_1ec9955', '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('2e9e8f25-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '2e9e8f24-3e5c-11ed-8a80-4e744305f12a', 'Event_1ec9955', NULL, NULL, NULL, 'endEvent', NULL, '2022-09-27 20:01:55.841', '2022-09-27 20:01:55.842', 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('36653889-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', '36653888-3e5c-11ed-8a80-4e744305f12a', 'Event_1ec9955', NULL, NULL, NULL, 'endEvent', NULL, '2022-09-27 20:02:08.887', '2022-09-27 20:02:08.887', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('5aac8e72-3e5a-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Event_95uPJY1M', NULL, NULL, '开始', 'startEvent', NULL, '2022-09-27 19:48:50.759', '2022-09-27 19:48:50.760', 1, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('5aacb48d-3e5a-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Flow_0dd0adn', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 19:48:50.760', '2022-09-27 19:48:50.760', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('5aacb48e-3e5a-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', '5aacb48f-3e5a-11ed-8a80-4e744305f12a', NULL, '小猫审批', 'userTask', '7', '2022-09-27 19:48:50.760', '2022-09-27 20:05:12.870', 982110, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a40ef38c-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Flow_1ah4lf6', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 20:05:12.871', '2022-09-27 20:05:12.871', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a40ef38d-3e5c-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Activity_0587dk0', 'a40ef38e-3e5c-11ed-8a80-4e744305f12a', NULL, '小可爱审批', 'userTask', '8', '2022-09-27 20:05:12.871', '2022-09-27 20:06:00.459', 47588, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa61f-3e5d-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Event_95uPJY1M', NULL, NULL, '开始', 'startEvent', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa62a-3e5d-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Flow_0dd0adn', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa62b-3e5d-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', 'a98aa62c-3e5d-11ed-8a80-4e744305f12a', NULL, '小猫审批', 'userTask', '9', '2022-09-27 20:12:31.567', NULL, NULL, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c06c4dd3-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Flow_0z0j70x', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 20:06:00.459', '2022-09-27 20:06:00.459', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('c06c4dd4-3e5c-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Activity_1814gm9', 'c06c74e5-3e5c-11ed-8a80-4e744305f12a', NULL, '小猪审批', 'userTask', '10', '2022-09-27 20:06:00.459', '2022-09-27 20:06:38.216', 37757, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d6ed90a9-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Flow_1xlavbv', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 20:06:38.216', '2022-09-27 20:06:38.216', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('d6ed90aa-3e5c-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', 'Event_1ec9955', NULL, NULL, NULL, 'endEvent', NULL, '2022-09-27 20:06:38.216', '2022-09-27 20:06:38.216', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('e257f5ba-3e59-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', 'Event_95uPJY1M', NULL, NULL, '开始', 'startEvent', NULL, '2022-09-27 19:45:28.878', '2022-09-27 19:45:28.887', 9, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('e259ca85-3e59-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', 'Flow_0dd0adn', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 19:45:28.890', '2022-09-27 19:45:28.890', 0, NULL, '');
INSERT INTO `act_hi_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('e259ca86-3e59-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', 'e25bc657-3e59-11ed-8a80-4e744305f12a', NULL, '小猫审批', 'userTask', '7', '2022-09-27 19:45:28.890', '2022-09-27 20:02:08.886', 999996, 'Change activity to Event_1ec9955', '');
COMMIT;

-- ----------------------------
-- Table structure for act_hi_attachment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_attachment`;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_attachment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_comment
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_comment`;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_comment
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('2e9a4962-3e5c-11ed-8a80-4e744305f12a', 'COMMENT__workflow_process_revoke', '2022-09-27 20:01:55.813', NULL, '26b2211b-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', 'AddComment', '流程撤回_EXTEND_MESSAGE_流程撤回', 0xE6B581E7A88BE692A4E59B9E5F455854454E445F4D4553534147455FE6B581E7A88BE692A4E59B9E);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('365e81c6-3e5c-11ed-8a80-4e744305f12a', 'COMMENT__workflow_process_revoke', '2022-09-27 20:02:08.843', NULL, 'e25bc657-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'AddComment', '流程撤回_EXTEND_MESSAGE_流程撤回', 0xE6B581E7A88BE692A4E59B9E5F455854454E445F4D4553534147455FE6B581E7A88BE692A4E59B9E);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('a40ad4da-3e5c-11ed-8a80-4e744305f12a', 'COMMENT__workflow_activity_agree', '2022-09-27 20:05:12.844', '1', '5aacb48f-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', 'AddComment', '同意_EXTEND_MESSAGE_', 0xE5908CE6848F5F455854454E445F4D4553534147455F);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('a98f1301-3e5d-11ed-8a80-4e744305f12a', 'event', '2022-09-27 20:12:31.596', '1', 'a98aa62c-3e5d-11ed-8a80-4e744305f12a', NULL, 'AddUserLink', '9_|_assignee', NULL);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('c06548f1-3e5c-11ed-8a80-4e744305f12a', 'COMMENT__workflow_activity_agree', '2022-09-27 20:06:00.413', '1', 'a40ef38e-3e5c-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', 'AddComment', '同意_EXTEND_MESSAGE_', 0xE5908CE6848F5F455854454E445F4D4553534147455F);
INSERT INTO `act_hi_comment` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES ('d6eca648-3e5c-11ed-8a80-4e744305f12a', 'COMMENT__workflow_activity_agree', '2022-09-27 20:06:38.210', NULL, 'c06c74e5-3e5c-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', 'AddComment', '同意_EXTEND_MESSAGE_', 0xE5908CE6848F5F455854454E445F4D4553534147455F);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_detail
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_detail`;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime(3) NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_detail
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('26b1f9ff-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, '26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 'input_fxwWzgAc', NULL, NULL, '2022-09-27 19:47:23.553', NULL, NULL, NULL, '破案', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('26b1fa00-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, '26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 'input_7z86kLKJ', NULL, NULL, '2022-09-27 19:47:23.553', NULL, NULL, NULL, '真项只有一个', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('26b1fa01-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, '26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 'input_VyKm9I7H', NULL, NULL, '2022-09-27 19:47:23.553', NULL, NULL, NULL, '福尔摩斯', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('26b1fa02-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, '26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 'userName', NULL, NULL, '2022-09-27 19:47:23.553', NULL, NULL, NULL, 'entfrm', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('26b1fa03-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, '26b1f9fe-3e5a-11ed-8a80-4e744305f12a', 'title', NULL, NULL, '2022-09-27 19:47:23.553', NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:46 发起了 [请假流程]', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('5aac8e73-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, '5aac8e72-3e5a-11ed-8a80-4e744305f12a', 'input_fxwWzgAc', NULL, NULL, '2022-09-27 19:48:50.759', NULL, NULL, NULL, '破案', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('5aac8e74-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, '5aac8e72-3e5a-11ed-8a80-4e744305f12a', 'input_7z86kLKJ', NULL, NULL, '2022-09-27 19:48:50.759', NULL, NULL, NULL, '真相只有一个', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('5aac8e75-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, '5aac8e72-3e5a-11ed-8a80-4e744305f12a', 'input_VyKm9I7H', NULL, NULL, '2022-09-27 19:48:50.759', NULL, NULL, NULL, '福尔摩斯', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('5aac8e76-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, '5aac8e72-3e5a-11ed-8a80-4e744305f12a', 'userName', NULL, NULL, '2022-09-27 19:48:50.759', NULL, NULL, NULL, 'entfrm', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('5aac8e77-3e5a-11ed-8a80-4e744305f12a', 'FormProperty', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, '5aac8e72-3e5a-11ed-8a80-4e744305f12a', 'title', NULL, NULL, '2022-09-27 19:48:50.759', NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:48 发起了 [请假流程]', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa620-3e5d-11ed-8a80-4e744305f12a', 'FormProperty', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61f-3e5d-11ed-8a80-4e744305f12a', 'input_fxwWzgAc', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, NULL, '去自律', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa621-3e5d-11ed-8a80-4e744305f12a', 'FormProperty', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61f-3e5d-11ed-8a80-4e744305f12a', 'input_7z86kLKJ', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, NULL, '今天跑步500公里', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa622-3e5d-11ed-8a80-4e744305f12a', 'FormProperty', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61f-3e5d-11ed-8a80-4e744305f12a', 'input_VyKm9I7H', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, NULL, '彭于晏', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa623-3e5d-11ed-8a80-4e744305f12a', 'FormProperty', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61f-3e5d-11ed-8a80-4e744305f12a', 'userName', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, NULL, 'entfrm', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa624-3e5d-11ed-8a80-4e744305f12a', 'FormProperty', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61f-3e5d-11ed-8a80-4e744305f12a', 'title', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, NULL, 'entfrm 在 2022-09-27 20:10 发起了 [请假流程]', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('e257f5bb-3e59-11ed-8a80-4e744305f12a', 'FormProperty', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, 'e257f5ba-3e59-11ed-8a80-4e744305f12a', 'input_fxwWzgAc', NULL, NULL, '2022-09-27 19:45:28.878', NULL, NULL, NULL, '破案', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('e257f5bc-3e59-11ed-8a80-4e744305f12a', 'FormProperty', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, 'e257f5ba-3e59-11ed-8a80-4e744305f12a', 'input_7z86kLKJ', NULL, NULL, '2022-09-27 19:45:28.878', NULL, NULL, NULL, '帮助他人', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('e257f5bd-3e59-11ed-8a80-4e744305f12a', 'FormProperty', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, 'e257f5ba-3e59-11ed-8a80-4e744305f12a', 'input_VyKm9I7H', NULL, NULL, '2022-09-27 19:45:28.878', NULL, NULL, NULL, '福尔摩斯', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('e257f5be-3e59-11ed-8a80-4e744305f12a', 'FormProperty', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, 'e257f5ba-3e59-11ed-8a80-4e744305f12a', 'userName', NULL, NULL, '2022-09-27 19:45:28.878', NULL, NULL, NULL, 'entfrm', NULL);
INSERT INTO `act_hi_detail` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('e257f5bf-3e59-11ed-8a80-4e744305f12a', 'FormProperty', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, 'e257f5ba-3e59-11ed-8a80-4e744305f12a', 'title', NULL, NULL, '2022-09-27 19:45:28.878', NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:44 发起了 [请假流程]', NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_entitylink`;
CREATE TABLE `act_hi_entitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_HI_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_identitylink`;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_identitylink
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('26b1f9fc-3e5a-11ed-8a80-4e744305f12a', NULL, 'starter', '1', NULL, '2022-09-27 19:47:23.553', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('26b41cec-3e5a-11ed-8a80-4e744305f12a', NULL, 'assignee', '7', '26b2211b-3e5a-11ed-8a80-4e744305f12a', '2022-09-27 19:47:23.567', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('26b41ced-3e5a-11ed-8a80-4e744305f12a', NULL, 'participant', '7', NULL, '2022-09-27 19:47:23.567', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('5aac8e70-3e5a-11ed-8a80-4e744305f12a', NULL, 'starter', '1', NULL, '2022-09-27 19:48:50.759', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('5aae8950-3e5a-11ed-8a80-4e744305f12a', NULL, 'assignee', '7', '5aacb48f-3e5a-11ed-8a80-4e744305f12a', '2022-09-27 19:48:50.772', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('5aae8951-3e5a-11ed-8a80-4e744305f12a', NULL, 'participant', '7', NULL, '2022-09-27 19:48:50.772', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a40e574b-3e5c-11ed-8a80-4e744305f12a', NULL, 'participant', '1', NULL, '2022-09-27 20:05:12.867', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a4107a2f-3e5c-11ed-8a80-4e744305f12a', NULL, 'assignee', '8', 'a40ef38e-3e5c-11ed-8a80-4e744305f12a', '2022-09-27 20:05:12.881', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a4107a30-3e5c-11ed-8a80-4e744305f12a', NULL, 'participant', '8', NULL, '2022-09-27 20:05:12.881', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98aa61d-3e5d-11ed-8a80-4e744305f12a', NULL, 'starter', '1', NULL, '2022-09-27 20:12:31.567', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98c05bd-3e5d-11ed-8a80-4e744305f12a', NULL, 'assignee', '7', 'a98aa62c-3e5d-11ed-8a80-4e744305f12a', '2022-09-27 20:12:31.576', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98c05be-3e5d-11ed-8a80-4e744305f12a', NULL, 'participant', '7', NULL, '2022-09-27 20:12:31.576', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98eebef-3e5d-11ed-8a80-4e744305f12a', NULL, 'assignee', '9', 'a98aa62c-3e5d-11ed-8a80-4e744305f12a', '2022-09-27 20:12:31.595', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98f1300-3e5d-11ed-8a80-4e744305f12a', NULL, 'participant', '9', NULL, '2022-09-27 20:12:31.596', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('c06bffb2-3e5c-11ed-8a80-4e744305f12a', NULL, 'participant', '1', NULL, '2022-09-27 20:06:00.457', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('c06dfb86-3e5c-11ed-8a80-4e744305f12a', NULL, 'assignee', '10', 'c06c74e5-3e5c-11ed-8a80-4e744305f12a', '2022-09-27 20:06:00.470', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('c06dfb87-3e5c-11ed-8a80-4e744305f12a', NULL, 'participant', '10', NULL, '2022-09-27 20:06:00.470', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('e257a798-3e59-11ed-8a80-4e744305f12a', NULL, 'starter', '1', NULL, '2022-09-27 19:45:28.877', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('e25f6fd8-3e59-11ed-8a80-4e744305f12a', NULL, 'assignee', '7', 'e25bc657-3e59-11ed-8a80-4e744305f12a', '2022-09-27 19:45:28.927', NULL, NULL, NULL, NULL);
INSERT INTO `act_hi_identitylink` (`ID_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `CREATE_TIME_`, `PROC_INST_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('e25f6fd9-3e59-11ed-8a80-4e744305f12a', NULL, 'participant', '7', NULL, '2022-09-27 19:45:28.927', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_procinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_procinst`;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_procinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('26b1f9fa-3e5a-11ed-8a80-4e744305f12a', 2, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '2022-09-27 19:47:23.553', '2022-09-27 20:01:55.847', 872294, '1', 'Event_95uPJY1M', 'Event_1ec9955', NULL, NULL, '', NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('5aac8e6e-3e5a-11ed-8a80-4e744305f12a', 2, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '2022-09-27 19:48:50.759', '2022-09-27 20:06:38.220', 1067461, '1', 'Event_95uPJY1M', 'Event_1ec9955', NULL, NULL, '', NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('a98aa61b-3e5d-11ed-8a80-4e744305f12a', 1, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '2022-09-27 20:12:31.567', NULL, NULL, '1', 'Event_95uPJY1M', NULL, NULL, NULL, '', NULL, NULL, NULL);
INSERT INTO `act_hi_procinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `DELETE_REASON_`, `TENANT_ID_`, `NAME_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('e2573266-3e59-11ed-8a80-4e744305f12a', 2, 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', '2022-09-27 19:45:28.873', '2022-09-27 20:02:08.890', 1000017, '1', 'Event_95uPJY1M', 'Event_1ec9955', NULL, NULL, '', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_hi_taskinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_taskinst`;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_TASK_INST_PROCINST` (`PROC_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_taskinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('26b2211b-3e5a-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_0sjx0ro', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fd-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小猫审批', NULL, NULL, NULL, '7', '2022-09-27 19:47:23.554', NULL, '2022-09-27 20:01:55.835', 872281, 'Change activity to Event_1ec9955', 50, NULL, '2', NULL, '', '2022-09-27 20:01:55.835');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('5aacb48f-3e5a-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_0sjx0ro', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小猫审批', NULL, NULL, NULL, '7', '2022-09-27 19:48:50.760', NULL, '2022-09-27 20:05:12.868', 982108, NULL, 50, NULL, '2', NULL, '', '2022-09-27 20:05:12.868');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('a40ef38e-3e5c-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_0587dk0', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小可爱审批', NULL, NULL, NULL, '8', '2022-09-27 20:05:12.871', NULL, '2022-09-27 20:06:00.458', 47587, NULL, 50, NULL, '2', NULL, '', '2022-09-27 20:06:00.458');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa62c-3e5d-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_0sjx0ro', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小猫审批', NULL, NULL, NULL, '9', '2022-09-27 20:12:31.567', NULL, NULL, NULL, NULL, 50, NULL, '2', NULL, '', '2022-09-27 20:12:31.594');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('c06c74e5-3e5c-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_1814gm9', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e71-3e5a-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小猪审批', NULL, NULL, NULL, '10', '2022-09-27 20:06:00.460', NULL, '2022-09-27 20:06:38.214', 37754, NULL, 50, NULL, '2', NULL, '', '2022-09-27 20:06:38.214');
INSERT INTO `act_hi_taskinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `CLAIM_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FORM_KEY_`, `CATEGORY_`, `TENANT_ID_`, `LAST_UPDATED_TIME_`) VALUES ('e25bc657-3e59-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'Activity_0sjx0ro', 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e257f5b9-3e59-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, '小猫审批', NULL, NULL, NULL, '7', '2022-09-27 19:45:28.894', NULL, '2022-09-27 20:02:08.887', 999993, 'Change activity to Event_1ec9955', 50, NULL, '2', NULL, '', '2022-09-27 20:02:08.887');
COMMIT;

-- ----------------------------
-- Table structure for act_hi_tsk_log
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_tsk_log`;
CREATE TABLE `act_hi_tsk_log` (
  `ID_` bigint(20) NOT NULL AUTO_INCREMENT,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TIME_STAMP_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DATA_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_tsk_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_hi_varinst
-- ----------------------------
DROP TABLE IF EXISTS `act_hi_varinst`;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LAST_UPDATED_TIME_` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_EXE` (`EXECUTION_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_hi_varinst
-- ----------------------------
BEGIN;
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1f9fb-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'applyUserId', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1fa04-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_VyKm9I7H', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '福尔摩斯', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1fa05-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_fxwWzgAc', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '破案', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1fa06-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_7z86kLKJ', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '真项只有一个', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1fa07-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'userName', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('26b1fa08-3e5a-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, 'title', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:46 发起了 [请假流程]', NULL, '2022-09-27 19:47:23.553', '2022-09-27 19:47:23.553');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('2e9abe93-3e5c-11ed-8a80-4e744305f12a', 0, '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', '26b1f9fa-3e5a-11ed-8a80-4e744305f12a', NULL, '_process_status_code', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '_workflow_process_revoke', NULL, '2022-09-27 20:01:55.816', '2022-09-27 20:01:55.816');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('365ea8d7-3e5c-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, '_process_status_code', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '_workflow_process_revoke', NULL, '2022-09-27 20:02:08.844', '2022-09-27 20:02:08.844');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e6f-3e5a-11ed-8a80-4e744305f12a', 0, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'applyUserId', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2022-09-27 19:48:50.759', '2022-09-27 19:48:50.759');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e78-3e5a-11ed-8a80-4e744305f12a', 3, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_VyKm9I7H', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '福尔摩斯', NULL, '2022-09-27 19:48:50.759', '2022-09-27 20:06:38.214');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e79-3e5a-11ed-8a80-4e744305f12a', 3, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_fxwWzgAc', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '破案', NULL, '2022-09-27 19:48:50.759', '2022-09-27 20:06:38.213');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e7a-3e5a-11ed-8a80-4e744305f12a', 3, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'input_7z86kLKJ', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '真相只有一个', NULL, '2022-09-27 19:48:50.759', '2022-09-27 20:06:38.214');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e7b-3e5a-11ed-8a80-4e744305f12a', 0, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'userName', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm', NULL, '2022-09-27 19:48:50.759', '2022-09-27 19:48:50.759');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('5aac8e7c-3e5a-11ed-8a80-4e744305f12a', 0, '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', '5aac8e6e-3e5a-11ed-8a80-4e744305f12a', NULL, 'title', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:48 发起了 [请假流程]', NULL, '2022-09-27 19:48:50.759', '2022-09-27 19:48:50.759');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa61c-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'applyUserId', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa625-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'input_VyKm9I7H', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '彭于晏', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa626-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'input_fxwWzgAc', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '去自律', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa627-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'input_7z86kLKJ', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '今天跑步500公里', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa628-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'userName', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('a98aa629-3e5d-11ed-8a80-4e744305f12a', 0, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'title', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm 在 2022-09-27 20:10 发起了 [请假流程]', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2573267-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'applyUserId', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL, '2022-09-27 19:45:28.875', '2022-09-27 19:45:28.875');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2581cd0-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'input_VyKm9I7H', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '福尔摩斯', NULL, '2022-09-27 19:45:28.879', '2022-09-27 19:45:28.879');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2581cd1-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'input_fxwWzgAc', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '破案', NULL, '2022-09-27 19:45:28.879', '2022-09-27 19:45:28.879');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2581cd2-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'input_7z86kLKJ', 'string', NULL, NULL, NULL, NULL, NULL, NULL, '帮助他人', NULL, '2022-09-27 19:45:28.879', '2022-09-27 19:45:28.879');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2581cd3-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'userName', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm', NULL, '2022-09-27 19:45:28.879', '2022-09-27 19:45:28.879');
INSERT INTO `act_hi_varinst` (`ID_`, `REV_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `CREATE_TIME_`, `LAST_UPDATED_TIME_`) VALUES ('e2581cd4-3e59-11ed-8a80-4e744305f12a', 0, 'e2573266-3e59-11ed-8a80-4e744305f12a', 'e2573266-3e59-11ed-8a80-4e744305f12a', NULL, 'title', 'string', NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm 在 2022-09-27 19:44 发起了 [请假流程]', NULL, '2022-09-27 19:45:28.879', '2022-09-27 19:45:28.879');
COMMIT;

-- ----------------------------
-- Table structure for act_id_bytearray
-- ----------------------------
DROP TABLE IF EXISTS `act_id_bytearray`;
CREATE TABLE `act_id_bytearray` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_bytearray
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_group
-- ----------------------------
DROP TABLE IF EXISTS `act_id_group`;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_info
-- ----------------------------
DROP TABLE IF EXISTS `act_id_info`;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_membership
-- ----------------------------
DROP TABLE IF EXISTS `act_id_membership`;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_membership
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv`;
CREATE TABLE `act_id_priv` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PRIV_NAME` (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_priv_mapping
-- ----------------------------
DROP TABLE IF EXISTS `act_id_priv_mapping`;
CREATE TABLE `act_id_priv_mapping` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PRIV_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_PRIV_MAPPING` (`PRIV_ID_`),
  KEY `ACT_IDX_PRIV_USER` (`USER_ID_`),
  KEY `ACT_IDX_PRIV_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_PRIV_MAPPING` FOREIGN KEY (`PRIV_ID_`) REFERENCES `act_id_priv` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_priv_mapping
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_property
-- ----------------------------
DROP TABLE IF EXISTS `act_id_property`;
CREATE TABLE `act_id_property` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_property
-- ----------------------------
BEGIN;
INSERT INTO `act_id_property` (`NAME_`, `VALUE_`, `REV_`) VALUES ('schema.version', '6.5.0.1', 1);
COMMIT;

-- ----------------------------
-- Table structure for act_id_token
-- ----------------------------
DROP TABLE IF EXISTS `act_id_token`;
CREATE TABLE `act_id_token` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TOKEN_VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATE_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `IP_ADDRESS_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_AGENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TOKEN_DATA_` varchar(2000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_token
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_id_user
-- ----------------------------
DROP TABLE IF EXISTS `act_id_user`;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DISPLAY_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_id_user
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_procdef_info
-- ----------------------------
DROP TABLE IF EXISTS `act_procdef_info`;
CREATE TABLE `act_procdef_info` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `INFO_JSON_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INFO_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_INFO_JSON_BA` (`INFO_JSON_ID_`),
  CONSTRAINT `ACT_FK_INFO_JSON_BA` FOREIGN KEY (`INFO_JSON_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_INFO_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_procdef_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_deployment
-- ----------------------------
DROP TABLE IF EXISTS `act_re_deployment`;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `DEPLOY_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_DEPLOYMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_deployment
-- ----------------------------
BEGIN;
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('0a2d5df6-3e59-11ed-8a80-4e744305f12a', '流程_FaYBwzO9', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:39:26.211', NULL, NULL, NULL, NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('3c869e6a-3e59-11ed-8a80-4e744305f12a', '请假流程', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:40:50.680', NULL, NULL, NULL, NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('a3e65a5e-3e58-11ed-8a80-4e744305f12a', '流程_FaYBwzO9', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:36:34.618', NULL, NULL, NULL, NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('acaaf65e-3e59-11ed-8a80-4e744305f12a', '请假流程', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:43:58.825', NULL, NULL, NULL, NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('b658a4a2-3e58-11ed-8a80-4e744305f12a', '流程_FaYBwzO9', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:37:05.566', NULL, NULL, NULL, NULL);
INSERT INTO `act_re_deployment` (`ID_`, `NAME_`, `CATEGORY_`, `KEY_`, `TENANT_ID_`, `DEPLOY_TIME_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `PARENT_DEPLOYMENT_ID_`, `ENGINE_VERSION_`) VALUES ('b9bfa802-3e59-11ed-8a80-4e744305f12a', '请假流程', NULL, 'Process_FaYBwzO9', '', '2022-09-27 19:44:20.771', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_re_model
-- ----------------------------
DROP TABLE IF EXISTS `act_re_model`;
CREATE TABLE `act_re_model` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LAST_UPDATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `VERSION_` int(11) DEFAULT NULL,
  `META_INFO_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EDITOR_SOURCE_EXTRA_VALUE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_MODEL_SOURCE` (`EDITOR_SOURCE_VALUE_ID_`),
  KEY `ACT_FK_MODEL_SOURCE_EXTRA` (`EDITOR_SOURCE_EXTRA_VALUE_ID_`),
  KEY `ACT_FK_MODEL_DEPLOYMENT` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_MODEL_DEPLOYMENT` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE` FOREIGN KEY (`EDITOR_SOURCE_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_MODEL_SOURCE_EXTRA` FOREIGN KEY (`EDITOR_SOURCE_EXTRA_VALUE_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_model
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_re_procdef
-- ----------------------------
DROP TABLE IF EXISTS `act_re_procdef`;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `HAS_GRAPHICAL_NOTATION_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `ENGINE_VERSION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_FROM_ROOT_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DERIVED_VERSION_` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`,`DERIVED_VERSION_`,`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_re_procdef
-- ----------------------------
BEGIN;
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:1:a41cd3b1-3e58-11ed-8a80-4e744305f12a', 2, '未分类', '流程_FaYBwzO9', 'Process_FaYBwzO9', 1, 'a3e65a5e-3e58-11ed-8a80-4e744305f12a', '流程_FaYBwzO9.bpmn20.xml', '流程_FaYBwzO9.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:2:b6779e55-3e58-11ed-8a80-4e744305f12a', 2, '未分类', '流程_FaYBwzO9', 'Process_FaYBwzO9', 2, 'b658a4a2-3e58-11ed-8a80-4e744305f12a', '流程_FaYBwzO9.bpmn20.xml', '流程_FaYBwzO9.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:3:0a444159-3e59-11ed-8a80-4e744305f12a', 3, '3,办公类', '流程_FaYBwzO9', 'Process_FaYBwzO9', 3, '0a2d5df6-3e59-11ed-8a80-4e744305f12a', '流程_FaYBwzO9.bpmn20.xml', '流程_FaYBwzO9.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:4:3c9eba4d-3e59-11ed-8a80-4e744305f12a', 3, '3,办公类', '请假流程', 'Process_FaYBwzO9', 4, '3c869e6a-3e59-11ed-8a80-4e744305f12a', '请假流程.bpmn20.xml', '请假流程.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:5:acb7c7a1-3e59-11ed-8a80-4e744305f12a', 2, '未分类', '请假流程', 'Process_FaYBwzO9', 5, 'acaaf65e-3e59-11ed-8a80-4e744305f12a', '请假流程.bpmn20.xml', '请假流程.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
INSERT INTO `act_re_procdef` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `DESCRIPTION_`, `HAS_START_FORM_KEY_`, `HAS_GRAPHICAL_NOTATION_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `ENGINE_VERSION_`, `DERIVED_FROM_`, `DERIVED_FROM_ROOT_`, `DERIVED_VERSION_`) VALUES ('Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 2, '未分类', '请假流程', 'Process_FaYBwzO9', 6, 'b9bfa802-3e59-11ed-8a80-4e744305f12a', '请假流程.bpmn20.xml', '请假流程.Process_FaYBwzO9.png', '请假流程', 1, 1, 1, '', NULL, NULL, NULL, 0);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_actinst
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_actinst`;
CREATE TABLE `act_ru_actinst` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT '1',
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) NOT NULL,
  `END_TIME_` datetime(3) DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_ACTI_START` (`START_TIME_`),
  KEY `ACT_IDX_RU_ACTI_END` (`END_TIME_`),
  KEY `ACT_IDX_RU_ACTI_PROC` (`PROC_INST_ID_`),
  KEY `ACT_IDX_RU_ACTI_PROC_ACT` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC` (`EXECUTION_ID_`),
  KEY `ACT_IDX_RU_ACTI_EXEC_ACT` (`EXECUTION_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_actinst
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa61f-3e5d-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Event_95uPJY1M', NULL, NULL, '开始', 'startEvent', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567', 0, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa62a-3e5d-11ed-8a80-4e744305f12a', 1, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Flow_0dd0adn', NULL, NULL, NULL, 'sequenceFlow', NULL, '2022-09-27 20:12:31.567', '2022-09-27 20:12:31.567', 0, NULL, '');
INSERT INTO `act_ru_actinst` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `TENANT_ID_`) VALUES ('a98aa62b-3e5d-11ed-8a80-4e744305f12a', 2, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', 'a98aa62c-3e5d-11ed-8a80-4e744305f12a', NULL, '小猫审批', 'userTask', '9', '2022-09-27 20:12:31.567', NULL, NULL, NULL, '');
COMMIT;

-- ----------------------------
-- Table structure for act_ru_deadletter_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_deadletter_job`;
CREATE TABLE `act_ru_deadletter_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_DEADLETTER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_DJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_DJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_DEADLETTER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_DEADLETTER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_DEADLETTER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_deadletter_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_entitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_entitylink`;
CREATE TABLE `act_ru_entitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CREATE_TIME_` datetime(3) DEFAULT NULL,
  `LINK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REF_SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HIERARCHY_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`),
  KEY `ACT_IDX_ENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`,`LINK_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_entitylink
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_event_subscr
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_event_subscr`;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_event_subscr
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_execution
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_execution`;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_MI_ROOT_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime(3) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LOCK_TIME_` timestamp(3) NULL DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `EVT_SUBSCR_COUNT_` int(11) DEFAULT NULL,
  `TASK_COUNT_` int(11) DEFAULT NULL,
  `JOB_COUNT_` int(11) DEFAULT NULL,
  `TIMER_JOB_COUNT_` int(11) DEFAULT NULL,
  `SUSP_JOB_COUNT_` int(11) DEFAULT NULL,
  `DEADLETTER_JOB_COUNT_` int(11) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  `CALLBACK_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CALLBACK_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDC_EXEC_ROOT` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE,
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_execution
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('a98aa61b-3e5d-11ed-8a80-4e744305f12a', 1, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 1, 0, 1, 0, 0, 1, NULL, '', NULL, 'Event_95uPJY1M', '2022-09-27 20:12:31.567', '1', NULL, 1, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL);
INSERT INTO `act_ru_execution` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `ROOT_PROC_INST_ID_`, `ACT_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `IS_MI_ROOT_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`, `TENANT_ID_`, `NAME_`, `START_ACT_ID_`, `START_TIME_`, `START_USER_ID_`, `LOCK_TIME_`, `IS_COUNT_ENABLED_`, `EVT_SUBSCR_COUNT_`, `TASK_COUNT_`, `JOB_COUNT_`, `TIMER_JOB_COUNT_`, `SUSP_JOB_COUNT_`, `DEADLETTER_JOB_COUNT_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `CALLBACK_ID_`, `CALLBACK_TYPE_`) VALUES ('a98aa61e-3e5d-11ed-8a80-4e744305f12a', 1, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'Activity_0sjx0ro', 1, 0, 0, 0, 0, 1, NULL, '', NULL, NULL, '2022-09-27 20:12:31.567', NULL, NULL, 1, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_history_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_history_job`;
CREATE TABLE `act_ru_history_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ADV_HANDLER_CFG_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_history_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_identitylink
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_identitylink`;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_IDENT_LNK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  KEY `ACT_FK_IDL_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_IDL_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_identitylink
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98aa61d-3e5d-11ed-8a80-4e744305f12a', 1, NULL, 'starter', '1', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98c05be-3e5d-11ed-8a80-4e744305f12a', 1, NULL, 'participant', '7', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL);
INSERT INTO `act_ru_identitylink` (`ID_`, `REV_`, `GROUP_ID_`, `TYPE_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`) VALUES ('a98f1300-3e5d-11ed-8a80-4e744305f12a', 1, NULL, 'participant', '9', NULL, 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_job`;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_JOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_JOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_suspended_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_suspended_job`;
CREATE TABLE `act_ru_suspended_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_SUSPENDED_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_SJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_SJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_SUSPENDED_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_SUSPENDED_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_SUSPENDED_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_suspended_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_task
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_task`;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `DUE_DATE_` datetime(3) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  `FORM_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CLAIM_TIME_` datetime(3) DEFAULT NULL,
  `IS_COUNT_ENABLED_` tinyint(4) DEFAULT NULL,
  `VAR_COUNT_` int(11) DEFAULT NULL,
  `ID_LINK_COUNT_` int(11) DEFAULT NULL,
  `SUB_TASK_COUNT_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TASK_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_task
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_task` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `TASK_DEF_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `SCOPE_DEFINITION_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `CATEGORY_`, `SUSPENSION_STATE_`, `TENANT_ID_`, `FORM_KEY_`, `CLAIM_TIME_`, `IS_COUNT_ENABLED_`, `VAR_COUNT_`, `ID_LINK_COUNT_`, `SUB_TASK_COUNT_`) VALUES ('a98aa62c-3e5d-11ed-8a80-4e744305f12a', 2, 'a98aa61e-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'Process_FaYBwzO9:6:b9ceea45-3e59-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, '小猫审批', NULL, NULL, 'Activity_0sjx0ro', NULL, '9', NULL, 50, '2022-09-27 20:12:31.567', NULL, NULL, 1, '', '2', NULL, 1, 0, 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for act_ru_timer_job
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_timer_job`;
CREATE TABLE `act_ru_timer_job` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp(3) NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ELEMENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_DEFINITION_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp(3) NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CUSTOM_VALUES_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp(3) NULL DEFAULT NULL,
  `TENANT_ID_` varchar(255) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TIMER_JOB_EXCEPTION_STACK_ID` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_TIMER_JOB_CUSTOM_VALUES_ID` (`CUSTOM_VALUES_ID_`),
  KEY `ACT_IDX_TJOB_SCOPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SUB_SCOPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_TJOB_SCOPE_DEF` (`SCOPE_DEFINITION_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_TIMER_JOB_EXECUTION` (`EXECUTION_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_TIMER_JOB_PROC_DEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_CUSTOM_VALUES` FOREIGN KEY (`CUSTOM_VALUES_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_EXECUTION` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROCESS_INSTANCE` FOREIGN KEY (`PROCESS_INSTANCE_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TIMER_JOB_PROC_DEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_timer_job
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for act_ru_variable
-- ----------------------------
DROP TABLE IF EXISTS `act_ru_variable`;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUB_SCOPE_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SCOPE_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_RU_VAR_SCOPE_ID_TYPE` (`SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_IDX_RU_VAR_SUB_ID_TYPE` (`SUB_SCOPE_ID_`,`SCOPE_TYPE_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Records of act_ru_variable
-- ----------------------------
BEGIN;
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa61c-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'applyUserId', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1', NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa625-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'input_VyKm9I7H', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '彭于晏', NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa626-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'input_fxwWzgAc', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '去自律', NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa627-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'input_7z86kLKJ', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '今天跑步500公里', NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa628-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'userName', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm', NULL);
INSERT INTO `act_ru_variable` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `TASK_ID_`, `SCOPE_ID_`, `SUB_SCOPE_ID_`, `SCOPE_TYPE_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES ('a98aa629-3e5d-11ed-8a80-4e744305f12a', 1, 'string', 'title', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', 'a98aa61b-3e5d-11ed-8a80-4e744305f12a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'entfrm 在 2022-09-27 20:10 发起了 [请假流程]', NULL);
COMMIT;

-- ----------------------------
-- Table structure for dev_apiinfo
-- ----------------------------
DROP TABLE IF EXISTS `dev_apiinfo`;
CREATE TABLE `dev_apiinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `application_id` int(11) DEFAULT NULL COMMENT '应用编号',
  `table_id` int(11) DEFAULT NULL COMMENT '表编号',
  `table_name` varchar(60) DEFAULT NULL COMMENT '表名',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `code` varchar(32) DEFAULT NULL COMMENT '自定义编号',
  `parent_id` int(11) DEFAULT NULL COMMENT '父编号',
  `type` varchar(10) DEFAULT NULL COMMENT '接口类型',
  `request_type` varchar(10) DEFAULT NULL COMMENT '请求方式',
  `request_method` varchar(30) DEFAULT NULL COMMENT '请求方法',
  `fdata` text COMMENT '字段数据',
  `pdata` text COMMENT '参数数据',
  `scripts` varchar(255) DEFAULT NULL COMMENT '脚本',
  `dept_id` int(11) DEFAULT NULL COMMENT '机构编号',
  `status` char(1) DEFAULT '0' COMMENT '状态（0-正常，1-停用）',
  `create_by` varchar(60) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='接口信息';

-- ----------------------------
-- Records of dev_apiinfo
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for dev_column
-- ----------------------------
DROP TABLE IF EXISTS `dev_column`;
CREATE TABLE `dev_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT 'JAVA字段名',
  `def_value` varchar(120) DEFAULT NULL COMMENT '默认值',
  `is_pk` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否必填（1是）',
  `is_add` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否为新增字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '是否查询字段（1是）',
  `query_type` varchar(20) CHARACTER SET utf8mb4 DEFAULT 'eq' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dev_column
-- ----------------------------
BEGIN;
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '1', 'id', '编号', 'int(11)', 'Integer', 'id', NULL, '1', '1', '0', '0', '0', '1', '0', 'eq', 'input', '', NULL, '小狗', '2021-05-11 10:00:49', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '1', 'user_name', '请假人', 'varchar(60)', 'String', 'userName', NULL, '0', '0', '0', '1', '1', '1', '1', 'like', 'input', '', NULL, '小狗', '2021-05-11 10:00:49', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (3, '1', 'type', '请假类型', 'varchar(60)', 'String', 'type', NULL, '0', '0', '0', '1', '1', '1', '0', 'eq', 'input', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (4, '1', 'cause', '请假事由', 'varchar(255)', 'String', 'cause', NULL, '0', '0', '0', '1', '1', '0', '0', 'eq', 'textarea', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (5, '1', 'create_by', '创建人', 'varchar(60)', 'String', 'createBy', NULL, '0', '0', '0', '0', '0', '0', '0', 'eq', 'input', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (6, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', NULL, '0', '0', '0', '0', '0', '1', '1', 'between', 'datetime', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, '1', 'update_by', '更新人', 'varchar(60)', 'String', 'updateBy', NULL, '0', '0', '0', '0', '0', '0', '0', 'eq', 'input', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', NULL, '0', '0', '0', '0', '0', '0', '0', 'between', 'datetime', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (9, '1', 'remarks', '备注', 'varchar(255)', 'String', 'remarks', NULL, '0', '0', '0', '1', '1', '0', '0', 'eq', 'textarea', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
INSERT INTO `dev_column` (`id`, `table_id`, `column_name`, `column_comment`, `column_type`, `java_type`, `java_field`, `def_value`, `is_pk`, `is_increment`, `is_required`, `is_add`, `is_edit`, `is_list`, `is_query`, `query_type`, `html_type`, `dict_type`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (10, '1', 'del_flag', '删除标识（0-正常，1-删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', '0', '0', '0', '0', '0', 'eq', 'input', '', NULL, '小狗', '2021-05-11 10:00:50', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for dev_dataset
-- ----------------------------
DROP TABLE IF EXISTS `dev_dataset`;
CREATE TABLE `dev_dataset` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `code` varchar(64) DEFAULT NULL COMMENT '编码',
  `name` varchar(60) DEFAULT NULL COMMENT '名称',
  `alias` varchar(120) DEFAULT NULL COMMENT '数据源别名',
  `ftype` varchar(10) DEFAULT 'json' COMMENT '格式类型',
  `cdata` text COMMENT '配置数据',
  `is_page` char(1) DEFAULT '0' COMMENT '是否分页',
  `scripts` text COMMENT 'sql脚本',
  `create_by` varchar(60) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据源';

-- ----------------------------
-- Records of dev_dataset
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for dev_form
-- ----------------------------
DROP TABLE IF EXISTS `dev_form`;
CREATE TABLE `dev_form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL COMMENT '表单名称',
  `code` varchar(30) DEFAULT NULL COMMENT '表单标识',
  `type` char(1) DEFAULT '0' COMMENT '表单类型',
  `ds_alias` varchar(30) DEFAULT NULL COMMENT '数据库别名',
  `table_name` varchar(60) DEFAULT NULL COMMENT '表名',
  `data` text COMMENT '表单数据',
  `auto_create` char(1) DEFAULT '0' COMMENT '自动创建',
  `version` varchar(30) DEFAULT NULL COMMENT '版本号',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dev_form
-- ----------------------------
BEGIN;
INSERT INTO `dev_form` (`id`, `name`, `code`, `type`, `ds_alias`, `table_name`, `data`, `auto_create`, `version`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '测试表单', 'test', '0', '1', 'test', '\"{column:[{type:\'input\',label:\'单行文本\',span:24,display:true,prop:\'1616808322555_61191\'},{type:\'textarea\',label:\'多行文本\',span:24,display:true,prop:\'1616818908722_16715\'},{type:\'radio\',label:\'单选框组\',dicData:[{label:\'选项一\',value:\'0\'},{label:\'选项二\',value:\'1\'},{label:\'选项三\',value:\'2\'}],span:12,display:true,props:{label:\'label\',value:\'value\'},prop:\'1616808328794_21064\'},{type:\'timerange\',label:\'时间范围\',span:12,display:true,format:\'HH:mm:ss\',valueFormat:\'HH:mm:ss\',prop:\'1616808492078_95952\'},{type:\'upload\',label:\'上传\',span:24,display:true,showFileList:true,multiple:true,limit:10,propsHttp:{},canvasOption:{},prop:\'1616818404413_51309\'},{type:\'icon\',label:\'图标\',component:\'avue-input-icon\',span:24,display:true,params:{iconList:[{label:\'基本图标\',list:[\'el-icon-info\',\'el-icon-error\',\'el-icon-error\',\'el-icon-success\',\'el-icon-warning\',\'el-icon-question\']},{label:\'方向图标\',list:[\'el-icon-info\',\'el-icon-back\',\'el-icon-arrow-left\',\'el-icon-arrow-down\',\'el-icon-arrow-right\',\'el-icon-arrow-up\']},{label:\'符号图标\',list:[\'el-icon-plus\',\'el-icon-minus\',\'el-icon-close\',\'el-icon-check\']}]},prop:\'1616828635931_82028\'}],labelPosition:\'left\',labelSuffix:\'：\',labelWidth:120,gutter:0,menuBtn:true,submitBtn:true,submitText:\'提交\',emptyBtn:true,emptyText:\'清空\',menuPosition:\'center\'}\"', '0', '1.0', '0', 'entfrm', '2021-03-26 23:32:55', '', '2021-03-27 11:55:19', NULL, '0');
INSERT INTO `dev_form` (`id`, `name`, `code`, `type`, `ds_alias`, `table_name`, `data`, `auto_create`, `version`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '请假工作流表单', 'form1', '1', NULL, NULL, '{\"column\":[{\"type\":\"input\",\"label\":\"请假人\",\"span\":24,\"display\":true,\"prop\":\"userName\"},{\"type\":\"input\",\"label\":\"请假类型\",\"span\":24,\"display\":true,\"prop\":\"type\"},{\"type\":\"textarea\",\"label\":\"请假事由\",\"span\":24,\"display\":true,\"prop\":\"cause\"}],\"labelPosition\":\"left\",\"labelSuffix\":\"：\",\"labelWidth\":90,\"gutter\":0,\"menuBtn\":false,\"submitBtn\":true,\"submitText\":\"提交\",\"emptyBtn\":true,\"emptyText\":\"清空\",\"menuPosition\":\"center\",\"disabled\":true}', '0', '1.0', '0', '小狗', '2021-05-11 09:56:13', '', '2021-05-11 10:00:52', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for dev_table
-- ----------------------------
DROP TABLE IF EXISTS `dev_table`;
CREATE TABLE `dev_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '表描述',
  `class_name` varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '生成功能作者',
  `cols` varchar(2) DEFAULT '24' COMMENT '分栏',
  `gen_api` char(1) DEFAULT NULL COMMENT '生成API',
  `gen_way` char(1) DEFAULT '0' COMMENT '生成方式',
  `options` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '其它生成选项',
  `menu_id` int(11) DEFAULT NULL COMMENT '父级菜单',
  `gen_path` varchar(255) DEFAULT NULL COMMENT '生成路径',
  `sub_table_name` varchar(120) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_field` varchar(120) DEFAULT NULL COMMENT '关联子表的外键名',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of dev_table
-- ----------------------------
BEGIN;
INSERT INTO `dev_table` (`id`, `table_name`, `table_comment`, `class_name`, `tpl_category`, `package_name`, `module_name`, `business_name`, `function_name`, `function_author`, `cols`, `gen_api`, `gen_way`, `options`, `menu_id`, `gen_path`, `sub_table_name`, `sub_table_field`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, 'entfrm_null', '请假工作流表单', '', 'crud', 'com.entfrm.biz.form', NULL, NULL, NULL, 'entfrm', '12', '0', '0', '{}', NULL, NULL, NULL, NULL, '小狗', '2021-05-11 10:00:49', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_business_demo
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_business_demo`;
CREATE TABLE `intelligent_business_demo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `business_id` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `business_version` float(11,2) NOT NULL,
  `field1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field2` text COLLATE utf8mb4_unicode_ci,
  `field3` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field4` int(11) DEFAULT NULL,
  `field5` double(16,2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_business_demo
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_business_demo` (`id`, `business_id`, `business_version`, `field1`, `field2`, `field3`, `field4`, `field5`) VALUES (1, '20', 1.10, '测试单行文本数据', '测试多行文本数据', '123456', 10, NULL);
COMMIT;

-- ----------------------------
-- Table structure for intelligent_control_steward
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_control_steward`;
CREATE TABLE `intelligent_control_steward` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `control_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件唯一Label',
  `control_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件图标',
  `control_mapping_table` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件映射表名',
  `control_field_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件映射字段类型',
  `control_field_length` int(11) DEFAULT NULL COMMENT '控件映射字段长度',
  `control_attribute` text COLLATE utf8mb4_unicode_ci COMMENT '控件详细属性',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `control_mapping_table_prepend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件表面前缀',
  `control_mapping_table_suffix` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '控件表面后缀',
  `control_precision` int(11) DEFAULT NULL COMMENT '控件精度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='控件大管家';

-- ----------------------------
-- Records of intelligent_control_steward
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (7, 'el-input', 'input', 'intelligent_controls_input', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"单行文本\",\n      \"labelWidth\": null,\n      \"showLabel\": true,\n      \"changeTag\": true,\n      \"tag\": \"el-input\",\n      \"tagIcon\": \"input\",\n      \"defaultValue\": \"1001\",\n      \"required\": true,\n      \"layout\": \"colFormItem\",\n      \"span\": 24,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/input\",\n      \"regList\": [],\n      \"formId\": 101,\n      \"renderKey\": \"1011616968959836\",\n      \"vModel\": \"field101\"\n    },\n    \"slot\": {\n      \"prepend\": \"\",\n      \"append\": \"\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"请输入单行文本\",\n      \"clearable\": true,\n      \"prefix-icon\": \"\",\n      \"suffix-icon\": \"\",\n      \"maxlength\": null,\n      \"show-word-limit\": false,\n      \"readonly\": false,\n      \"disabled\": false\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', NULL, NULL, NULL, NULL, '单行文本控件', 'intelligent_controls_', 'input', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (8, 'el-textarea', 'textarea', 'intelligent_controls_textarea', 'text', 0, '{\n    \"config\": {\n      \"label\": \"多行文本\",\n      \"labelWidth\": null,\n      \"showLabel\": true,\n      \"tag\": \"el-input\",\n      \"tagIcon\": \"textarea\",\n      \"required\": true,\n      \"layout\": \"colFormItem\",\n      \"span\": 24,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/input\",\n      \"formId\": 102,\n      \"renderKey\": \"1021616968962388\",\n      \"vModel\": \"field102\"\n    },\n    \"attrs\": {\n      \"type\": \"textarea\",\n      \"placeholder\": \"请输入多行文本\",\n      \"autosize\": {\n        \"minRows\": 4,\n        \"maxRows\": 4\n      },\n      \"maxlength\": null,\n      \"show-word-limit\": false,\n      \"readonly\": false,\n      \"disabled\": false\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', 'entfrm', '2021-03-29 06:13:26', NULL, NULL, '多行文本控件', 'intelligent_controls_', 'textarea', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (9, 'el-password', 'password', 'intelligent_controls_password', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"密码\",\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"changeTag\": true,\n      \"tag\": \"el-input\",\n      \"tagIcon\": \"password\",\n      \"defaultValue\": \"86228228\",\n      \"layout\": \"colFormItem\",\n      \"span\": 24,\n      \"required\": true,\n      \"regList\": [],\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/input\",\n      \"formId\": 103,\n      \"renderKey\": \"1031616968963517\",\n      \"vModel\": \"field103\"\n    },\n    \"slot\": {\n      \"prepend\": \"\",\n      \"append\": \"\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"请输入密码\",\n      \"show-password\": true,\n      \"clearable\": true,\n      \"prefix-icon\": \"\",\n      \"suffix-icon\": \"\",\n      \"maxlength\": null,\n      \"show-word-limit\": false,\n      \"readonly\": false,\n      \"disabled\": false\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', 'entfrm', '2021-03-29 06:15:10', NULL, NULL, '密码控件', 'intelligent_controls_', 'password', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (10, 'el-number', 'number', 'intelligent_controls_number', 'int', 11, '{\n    \"config\": {\n      \"label\": \"计数器\",\n      \"showLabel\": true,\n      \"changeTag\": true,\n      \"labelWidth\": null,\n      \"tag\": \"el-input-number\",\n      \"tagIcon\": \"number\",\n      \"span\": 24,\n      \"layout\": \"colFormItem\",\n      \"required\": true,\n      \"regList\": [],\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/input-number\",\n      \"formId\": 104,\n      \"renderKey\": \"1041616968965203\",\n      \"vModel\": \"field104\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"计数器\",\n      \"step\": 1,\n      \"step-strictly\": false,\n      \"controls-position\": \"\",\n      \"disabled\": false\n    }\n  }', 'entfrm', '2021-03-29 06:16:34', NULL, NULL, '计数器控件', 'intelligent_controls_', 'number', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (11, 'el-select', 'select', 'intelligent_controls_select', 'varchar', 225, '{\n    \"config\": {\n      \"label\": \"下拉选择\",\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"tag\": \"el-select\",\n      \"tagIcon\": \"select\",\n      \"layout\": \"colFormItem\",\n      \"span\": 24,\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/select\",\n      \"formId\": 105,\n      \"renderKey\": \"1051616971076818\",\n      \"vModel\": \"field105\"\n    },\n    \"slot\": {\n      \"options\": [{\n        \"label\": \"选项一\",\n        \"value\": 1\n      }, {\n        \"label\": \"选项二\",\n        \"value\": 2\n      }]\n    },\n    \"attrs\": {\n      \"placeholder\": \"请选择下拉选择\",\n      \"clearable\": true,\n      \"disabled\": false,\n      \"filterable\": false,\n      \"multiple\": false\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', 'entfrm', '2021-03-29 06:39:47', NULL, NULL, '下拉选择控件', 'intelligent_controls_', 'select', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (12, 'el-cascader', 'cascader', 'intelligent_controls_cascader', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"级联选择\",\n      \"url\": \"https://www.fastmock.site/mock/f8d7a54fb1e60561e2f720d5a810009d/fg/cascaderList\",\n      \"method\": \"get\",\n      \"dataKey\": \"list\",\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"tag\": \"el-cascader\",\n      \"tagIcon\": \"cascader\",\n      \"layout\": \"colFormItem\",\n      \"defaultValue\": [],\n      \"dataType\": \"dynamic\",\n      \"span\": 24,\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/cascader\",\n      \"formId\": 107,\n      \"renderKey\": \"1071616995731384\",\n      \"vModel\": \"field107\"\n    },\n    \"class\": {\n      \"props\": {\n        \"multiple\": false,\n        \"label\": \"label\",\n        \"value\": \"value\",\n        \"children\": \"children\"\n      }\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"请选择级联选择\",\n      \"show-all-levels\": true,\n      \"disabled\": false,\n      \"clearable\": true,\n      \"filterable\": false,\n      \"separator\": \"/\",\n      \"options\": [{\n        \"id\": 1,\n        \"value\": 1,\n        \"label\": \"选项1\",\n        \"children\": [{\n          \"id\": 2,\n          \"value\": 2,\n          \"label\": \"选项1-1\"\n        }]\n      }]\n    }\n  }', 'entfrm', '2021-03-29 13:31:02', NULL, NULL, '级联选择控件', 'intelligent_controls_', 'cascader', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (13, 'el-radio', 'radio', 'intelligent_controls_radio', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"单选框组\",\n      \"labelWidth\": null,\n      \"showLabel\": true,\n      \"tag\": \"el-radio-group\",\n      \"tagIcon\": \"radio\",\n      \"changeTag\": true,\n      \"layout\": \"colFormItem\",\n      \"span\": 24,\n      \"optionType\": \"default\",\n      \"regList\": [],\n      \"required\": true,\n      \"border\": false,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/radio\",\n      \"formId\": 108,\n      \"renderKey\": \"1081616997562143\",\n      \"vModel\": \"field108\"\n    },\n    \"slot\": {\n      \"options\": [{\n        \"label\": \"选项一\",\n        \"value\": 1\n      }, {\n        \"label\": \"选项二\",\n        \"value\": 2\n      }]\n    },\n    \"style\": {},\n    \"attrs\": {\n      \"size\": \"medium\",\n      \"disabled\": false\n    }\n  }', 'entfrm', '2021-03-29 14:04:55', 'entfrm', '2021-03-29 15:23:49', '单选框组控件', 'intelligent_controls_', 'radio', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (14, 'el-checkbox', 'checkbox', 'intelligent_controls_checkbox', 'varchar', 225, '{\n    \"config\": {\n      \"label\": \"多选框组\",\n      \"tag\": \"el-checkbox-group\",\n      \"tagIcon\": \"checkbox\",\n      \"defaultValue\": [1, 2],\n      \"span\": 24,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"layout\": \"colFormItem\",\n      \"optionType\": \"default\",\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"border\": false,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/checkbox\",\n      \"formId\": 109,\n      \"renderKey\": \"1091616998068178\",\n      \"vModel\": \"field109\"\n    },\n    \"slot\": {\n      \"options\": [{\n        \"label\": \"选项一\",\n        \"value\": 1\n      }, {\n        \"label\": \"选项二\",\n        \"value\": 2\n      }]\n    },\n    \"style\": {},\n    \"attrs\": {\n      \"size\": \"medium\",\n      \"min\": null,\n      \"disabled\": false\n    }\n  }', 'entfrm', '2021-03-29 14:09:54', 'entfrm', '2021-03-30 06:50:59', '多选框组控件', 'intelligent_controls_', 'checkbox', 0);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (15, 'el-switch', 'switch', 'intelligent_controls_switch', 'tinyint', 1, '{\n    \"config\": {\n      \"label\": \"开关\",\n      \"tag\": \"el-switch\",\n      \"tagIcon\": \"switch\",\n      \"defaultValue\": false,\n      \"span\": 24,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"layout\": \"colFormItem\",\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/switch\",\n      \"formId\": 109,\n      \"renderKey\": \"1091616998223676\",\n      \"vModel\": \"field109\"\n    },\n    \"style\": {},\n    \"attrs\": {\n      \"disabled\": false,\n      \"active-text\": \"\",\n      \"inactive-text\": \"\",\n      \"active-color\": null,\n      \"inactive-color\": null,\n      \"active-value\": true,\n      \"inactive-value\": false\n    }\n  }', 'entfrm', '2021-03-29 14:11:23', NULL, NULL, '开关控件', 'intelligent_controls_', 'switch', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (16, 'el-slider', 'slider', 'intelligent_controls_slider', 'int', 11, '{\n    \"config\": {\n      \"label\": \"滑块\",\n      \"tag\": \"el-slider\",\n      \"tagIcon\": \"slider\",\n      \"defaultValue\": 0,\n      \"span\": 24,\n      \"showLabel\": true,\n      \"layout\": \"colFormItem\",\n      \"labelWidth\": null,\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/slider\",\n      \"formId\": 109,\n      \"renderKey\": \"1091616998293487\",\n      \"vModel\": \"field109\"\n    },\n    \"attrs\": {\n      \"disabled\": false,\n      \"min\": 0,\n      \"max\": 100,\n      \"step\": 1,\n      \"show-stops\": false,\n      \"range\": false\n    }\n  }', 'entfrm', '2021-03-29 14:12:37', NULL, NULL, '滑块控件', 'intelligent_controls_', 'slider', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (17, 'el-time', 'time', 'intelligent_controls_time', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"时间选择\",\n      \"tag\": \"el-time-picker\",\n      \"tagIcon\": \"time\",\n      \"defaultValue\": null,\n      \"span\": 24,\n      \"showLabel\": true,\n      \"layout\": \"colFormItem\",\n      \"labelWidth\": null,\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/time-picker\",\n      \"formId\": 109,\n      \"renderKey\": \"1091616998504572\",\n      \"vModel\": \"field109\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"请选择时间选择\",\n      \"disabled\": false,\n      \"clearable\": true,\n      \"picker-options\": {\n        \"selectableRange\": \"00:00:00-23:59:59\"\n      },\n      \"format\": \"HH:mm:ss\",\n      \"value-format\": \"HH:mm:ss\"\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', 'entfrm', '2021-03-29 14:16:51', 'entfrm', '2021-03-29 18:07:11', '时间选择控件', 'intelligent_controls_', 'time', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (18, 'el-time-range', 'time-range', 'intelligent_controls_time_range', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"时间范围\",\n      \"tag\": \"el-time-picker\",\n      \"tagIcon\": \"time-range\",\n      \"span\": 24,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"layout\": \"colFormItem\",\n      \"defaultValue\": null,\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/time-picker\",\n      \"formId\": 110,\n      \"renderKey\": \"1101616998507819\",\n      \"vModel\": \"field110\"\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    },\n    \"attrs\": {\n      \"disabled\": false,\n      \"clearable\": true,\n      \"is-range\": true,\n      \"range-separator\": \"至\",\n      \"start-placeholder\": \"开始时间\",\n      \"end-placeholder\": \"结束时间\",\n      \"format\": \"HH:mm:ss\",\n      \"value-format\": \"HH:mm:ss\"\n    }\n  }', 'entfrm', '2021-03-29 14:18:10', 'entfrm', '2021-03-29 17:59:25', '时间范围控件', 'intelligent_controls_', 'time_range', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (19, 'el-date', 'date', 'intelligent_controls_date', 'datetime', 0, '{\n    \"config\": {\n      \"label\": \"日期选择\",\n      \"tag\": \"el-date-picker\",\n      \"tagIcon\": \"date\",\n      \"defaultValue\": null,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"span\": 24,\n      \"layout\": \"colFormItem\",\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/date-picker\",\n      \"formId\": 111,\n      \"renderKey\": \"1111616998509005\",\n      \"vModel\": \"field111\"\n    },\n    \"attrs\": {\n      \"placeholder\": \"请选择日期选择\",\n      \"type\": \"date\",\n      \"disabled\": false,\n      \"clearable\": true,\n      \"format\": \"yyyy-MM-dd\",\n      \"value-format\": \"yyyy-MM-dd\",\n      \"readonly\": false\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    }\n  }', 'entfrm', '2021-03-29 14:19:25', NULL, NULL, '日期选择控件', 'intelligent_controls_', 'date', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (20, 'el-date-range', 'date-range', 'intelligent_controls_date_range', 'varchar', 255, '{\n    \"config\": {\n      \"label\": \"日期范围\",\n      \"tag\": \"el-date-picker\",\n      \"tagIcon\": \"date-range\",\n      \"defaultValue\": null,\n      \"span\": 24,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"required\": true,\n      \"layout\": \"colFormItem\",\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/date-picker\",\n      \"formId\": 112,\n      \"renderKey\": \"1121616998510073\",\n      \"vModel\": \"field112\"\n    },\n    \"style\": {\n      \"width\": \"100%\"\n    },\n    \"attrs\": {\n      \"type\": \"daterange\",\n      \"range-separator\": \"至\",\n      \"start-placeholder\": \"开始日期\",\n      \"end-placeholder\": \"结束日期\",\n      \"disabled\": false,\n      \"clearable\": true,\n      \"format\": \"yyyy-MM-dd\",\n      \"value-format\": \"yyyy-MM-dd\",\n      \"readonly\": false\n    }\n  }', 'entfrm', '2021-03-29 14:20:34', 'entfrm', '2021-03-29 17:59:40', '日期范围控件', 'intelligent_controls_', 'date_range', NULL);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (21, 'el-rate', 'rate', 'intelligent_controls_rate', 'double', 16, '{\n    \"config\": {\n      \"label\": \"评分\",\n      \"tag\": \"el-rate\",\n      \"tagIcon\": \"rate\",\n      \"defaultValue\": 0,\n      \"span\": 24,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"layout\": \"colFormItem\",\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/rate\",\n      \"formId\": 113,\n      \"renderKey\": \"1131616998511488\",\n      \"vModel\": \"field113\"\n    },\n    \"style\": {},\n    \"attrs\": {\n      \"max\": 5,\n      \"allow-half\": false,\n      \"show-text\": false,\n      \"show-score\": false,\n      \"disabled\": false\n    }\n  }', 'entfrm', '2021-03-29 14:22:02', 'entfrm', '2021-03-29 18:45:03', '评分组件', 'intelligent_controls_', 'rate', 2);
INSERT INTO `intelligent_control_steward` (`id`, `control_label`, `control_tag_icon`, `control_mapping_table`, `control_field_type`, `control_field_length`, `control_attribute`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `control_mapping_table_prepend`, `control_mapping_table_suffix`, `control_precision`) VALUES (22, 'el-color', 'color', 'intelligent_controls_color', 'varchar', 225, '{\n    \"config\": {\n      \"label\": \"颜色选择\",\n      \"tag\": \"el-color-picker\",\n      \"tagIcon\": \"color\",\n      \"span\": 24,\n      \"defaultValue\": null,\n      \"showLabel\": true,\n      \"labelWidth\": null,\n      \"layout\": \"colFormItem\",\n      \"required\": true,\n      \"regList\": [],\n      \"changeTag\": true,\n      \"document\": \"https://element.eleme.cn/#/zh-CN/component/color-picker\",\n      \"formId\": 114,\n      \"renderKey\": \"1141616998513045\",\n      \"vModel\": \"field114\"\n    },\n    \"attrs\": {\n      \"show-alpha\": false,\n      \"color-format\": \"\",\n      \"disabled\": false,\n      \"size\": \"medium\"\n    }\n  }', 'entfrm', '2021-03-29 14:22:49', NULL, NULL, '颜色选择控件', 'intelligent_controls_', 'color', NULL);
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_cascader
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_cascader`;
CREATE TABLE `intelligent_controls_cascader` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_options` text COLLATE utf8mb4_unicode_ci,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `class_props_children` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_default_value` text COLLATE utf8mb4_unicode_ci,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `config_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_data_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_filterable` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_separator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_data_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class_props_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `class_props_multiple` tinyint(1) DEFAULT NULL,
  `attrs_show_all_levels` tinyint(1) DEFAULT NULL,
  `class_props_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_cascader
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_checkbox
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_checkbox`;
CREATE TABLE `intelligent_controls_checkbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` text COLLATE utf8mb4_unicode_ci,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `slot_options` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_min` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_border` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_option_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_checkbox
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_color
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_color`;
CREATE TABLE `intelligent_controls_color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_show_alpha` tinyint(1) DEFAULT NULL,
  `attrs_color_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_color
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_date
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_date`;
CREATE TABLE `intelligent_controls_date` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_value_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_readonly` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_date
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_date_range
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_date_range`;
CREATE TABLE `intelligent_controls_date_range` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_value_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_readonly` tinyint(1) DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_start_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_range_separator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_end_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_date_range
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_input
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_input`;
CREATE TABLE `intelligent_controls_input` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_readonly` tinyint(1) DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_suffix_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_maxlength` int(11) DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `attrs_prefix_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slot_prepend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `slot_append` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_show_word_limit` tinyint(1) DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_input
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_controls_input` (`id`, `attrs_placeholder`, `attrs_readonly`, `config_tag`, `config_document`, `config_render_key`, `config_v_model`, `config_show_label`, `config_required`, `attrs_clearable`, `config_tag_icon`, `attrs_suffix_icon`, `config_label`, `config_default_value`, `config_reg_list`, `attrs_maxlength`, `config_label_width`, `config_form_id`, `config_layout`, `config_span`, `attrs_prefix_icon`, `attrs_disabled`, `style_width`, `slot_prepend`, `config_change_tag`, `slot_append`, `attrs_show_word_limit`, `field_length`, `field_current`, `data_mapping_table`, `create_by`, `create_time`, `form_extend_id`, `data_mapping_table_prefix`, `data_mapping_table_suffix`) VALUES (93, '请输入单行文本', 0, 'el-input', 'https://element.eleme.cn/#/zh-CN/component/input', '1011617062740739', 'field101', 1, 1, 1, 'input', NULL, '单行文本', '1001', NULL, NULL, NULL, 101, 'colFormItem', 24, NULL, 0, '100%', NULL, 1, NULL, 0, 5, 'field1', 'intelligent_business_demo', 'entfrm', '2021-03-30 08:05:59', 36, 'intelligent_business_', 'demo');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_number
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_number`;
CREATE TABLE `intelligent_controls_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_step_strictly` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `attrs_controls_position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_step` int(11) DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_number
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_controls_number` (`id`, `attrs_placeholder`, `config_reg_list`, `config_label_width`, `config_form_id`, `attrs_step_strictly`, `config_layout`, `config_tag`, `config_document`, `config_span`, `attrs_controls_position`, `config_render_key`, `attrs_disabled`, `config_v_model`, `config_show_label`, `config_required`, `config_change_tag`, `config_tag_icon`, `attrs_step`, `config_label`, `field_length`, `field_current`, `data_mapping_table`, `create_by`, `create_time`, `form_extend_id`, `data_mapping_table_prefix`, `data_mapping_table_suffix`) VALUES (5, '计数器', NULL, NULL, 104, 0, 'colFormItem', 'el-input-number', 'https://element.eleme.cn/#/zh-CN/component/input-number', 24, NULL, '1041617062744859', 0, 'field104', 1, 1, 1, 'number', 1, '计数器', 5, 'field4', 'intelligent_business_demo', 'entfrm', '2021-03-30 08:05:59', 36, 'intelligent_business_', 'demo');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_password
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_password`;
CREATE TABLE `intelligent_controls_password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_readonly` tinyint(1) DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_suffix_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_maxlength` int(11) DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `attrs_prefix_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slot_prepend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `attrs_show_password` tinyint(1) DEFAULT NULL,
  `slot_append` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_show_word_limit` tinyint(1) DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_password
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_controls_password` (`id`, `attrs_placeholder`, `attrs_readonly`, `config_tag`, `config_document`, `config_render_key`, `config_v_model`, `config_show_label`, `config_required`, `attrs_clearable`, `config_tag_icon`, `attrs_suffix_icon`, `config_label`, `config_default_value`, `config_reg_list`, `attrs_maxlength`, `config_label_width`, `config_form_id`, `config_layout`, `config_span`, `attrs_prefix_icon`, `attrs_disabled`, `style_width`, `slot_prepend`, `config_change_tag`, `attrs_show_password`, `slot_append`, `attrs_show_word_limit`, `field_length`, `field_current`, `data_mapping_table`, `create_by`, `create_time`, `form_extend_id`, `data_mapping_table_prefix`, `data_mapping_table_suffix`) VALUES (21, '请输入密码', 0, 'el-input', 'https://element.eleme.cn/#/zh-CN/component/input', '1031617062743482', 'field103', 1, 1, 1, 'password', NULL, '密码', '86228228', NULL, NULL, NULL, 103, 'colFormItem', 24, NULL, 0, '100%', NULL, 1, 1, NULL, 0, 5, 'field3', 'intelligent_business_demo', 'entfrm', '2021-03-30 08:05:59', 36, 'intelligent_business_', 'demo');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_radio
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_radio`;
CREATE TABLE `intelligent_controls_radio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `slot_options` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_border` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_size` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_option_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_radio
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_rate
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_rate`;
CREATE TABLE `intelligent_controls_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` int(11) DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_show_score` tinyint(1) DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_allow_half` tinyint(1) DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_max` int(11) DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_show_text` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_rate
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_controls_rate` (`id`, `config_default_value`, `config_reg_list`, `config_label_width`, `config_form_id`, `config_layout`, `config_tag`, `attrs_show_score`, `config_document`, `config_span`, `config_render_key`, `attrs_allow_half`, `attrs_disabled`, `config_v_model`, `attrs_max`, `config_show_label`, `config_required`, `attrs_show_text`, `config_change_tag`, `config_tag_icon`, `config_label`, `field_length`, `field_current`, `data_mapping_table`, `create_by`, `create_time`, `form_extend_id`, `data_mapping_table_prefix`, `data_mapping_table_suffix`) VALUES (1, 0, NULL, NULL, 105, 'colFormItem', 'el-rate', 0, 'https://element.eleme.cn/#/zh-CN/component/rate', 24, '1051619173289621', 0, 0, 'field105', 5, 1, 1, 0, 1, 'rate', '评分', 5, 'field5', 'intelligent_business_demo', '小狗', '2021-04-23 18:21:31', 36, 'intelligent_business_', 'demo');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_select
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_select`;
CREATE TABLE `intelligent_controls_select` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `slot_options` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_filterable` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_multiple` tinyint(1) DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_select
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_slider
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_slider`;
CREATE TABLE `intelligent_controls_slider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` int(11) DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_show_stops` tinyint(1) DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_min` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_max` int(11) DEFAULT NULL,
  `attrs_range` tinyint(1) DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_step` int(11) DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_slider
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_switch
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_switch`;
CREATE TABLE `intelligent_controls_switch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` tinyint(1) DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `config_label_width` int(11) DEFAULT NULL,
  `attrs_active_value` tinyint(1) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_active_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_active_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `attrs_inactive_color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_inactive_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_inactive_value` tinyint(1) DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_switch
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_textarea
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_textarea`;
CREATE TABLE `intelligent_controls_textarea` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_maxlength` int(11) DEFAULT NULL,
  `attrs_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `attrs_readonly` tinyint(1) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_autosize_min_rows` int(11) DEFAULT NULL,
  `attrs_autosize_max_rows` int(11) DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_show_word_limit` tinyint(1) DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_textarea
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_controls_textarea` (`id`, `attrs_placeholder`, `config_reg_list`, `attrs_maxlength`, `attrs_type`, `config_label_width`, `config_form_id`, `attrs_readonly`, `config_layout`, `config_tag`, `config_document`, `config_span`, `config_render_key`, `attrs_autosize_min_rows`, `attrs_autosize_max_rows`, `attrs_disabled`, `style_width`, `config_v_model`, `config_show_label`, `config_required`, `config_change_tag`, `config_tag_icon`, `attrs_show_word_limit`, `config_label`, `field_length`, `field_current`, `data_mapping_table`, `create_by`, `create_time`, `form_extend_id`, `data_mapping_table_prefix`, `data_mapping_table_suffix`) VALUES (24, '请输入多行文本', NULL, NULL, 'textarea', NULL, 102, 0, 'colFormItem', 'el-input', 'https://element.eleme.cn/#/zh-CN/component/input', 24, '1021617062742139', 4, 4, 0, '100%', 'field102', 1, 1, 1, 'textarea', 0, '多行文本', 5, 'field2', 'intelligent_business_demo', 'entfrm', '2021-03-30 08:05:59', 36, 'intelligent_business_', 'demo');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_time
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_time`;
CREATE TABLE `intelligent_controls_time` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_picker_options_selectable_range` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_value_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_time
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_controls_time_range
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_controls_time_range`;
CREATE TABLE `intelligent_controls_time_range` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_default_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_reg_list` text COLLATE utf8mb4_unicode_ci,
  `attrs_value_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label_width` int(11) DEFAULT NULL,
  `config_form_id` int(11) DEFAULT NULL,
  `config_layout` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_tag` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_range_separator` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_start_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_document` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_span` int(11) DEFAULT NULL,
  `config_render_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_disabled` tinyint(1) DEFAULT NULL,
  `style_width` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_v_model` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_end_placeholder` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_show_label` tinyint(1) DEFAULT NULL,
  `config_required` tinyint(1) DEFAULT NULL,
  `attrs_clearable` tinyint(1) DEFAULT NULL,
  `config_change_tag` tinyint(1) DEFAULT NULL,
  `config_tag_icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_format` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `config_label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attrs_is_range` tinyint(1) DEFAULT NULL,
  `field_length` int(11) DEFAULT NULL,
  `field_current` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `form_extend_id` int(11) DEFAULT NULL,
  `data_mapping_table_prefix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_mapping_table_suffix` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_controls_time_range
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for intelligent_data_conf
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_data_conf`;
CREATE TABLE `intelligent_data_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '数据配置ID',
  `form_extend_id` int(11) DEFAULT NULL COMMENT '表单扩展id',
  `data_mapping_table_prepend` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据映射表前缀',
  `data_mapping_table` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据映射表名-自定义填写-后缀',
  `field_length` int(11) DEFAULT NULL COMMENT '字段数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_data_conf
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_data_conf` (`id`, `form_extend_id`, `data_mapping_table_prepend`, `data_mapping_table`, `field_length`) VALUES (20, 36, 'intelligent_business_', 'demo', 5);
COMMIT;

-- ----------------------------
-- Table structure for intelligent_demo_user
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_demo_user`;
CREATE TABLE `intelligent_demo_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nick_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `remarks` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of intelligent_demo_user
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_demo_user` (`id`, `nick_name`, `phone`, `remarks`) VALUES (20, '测试用户', 123456789, '测试');
COMMIT;

-- ----------------------------
-- Table structure for intelligent_form_extend
-- ----------------------------
DROP TABLE IF EXISTS `intelligent_form_extend`;
CREATE TABLE `intelligent_form_extend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表单扩展模板编码',
  `code` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表单扩展编码',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '表单扩展模板名称',
  `drawing_controls` text COLLATE utf8mb4_unicode_ci COMMENT '渲染控件数据集合',
  `id_global` int(11) DEFAULT NULL COMMENT '记录目前控件全局ID-自增长',
  `tree_node_id` text COLLATE utf8mb4_unicode_ci COMMENT '级联下拉树形选项局部ID-内部标识-目前实现控件独立',
  `create_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表单扩展创建用户',
  `create_time` datetime DEFAULT NULL COMMENT '表单扩展插件时间',
  `update_by` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表单扩展修改用户\n',
  `update_time` datetime DEFAULT NULL COMMENT '表单扩展修改时间',
  `remarks` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表单扩展备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='表单扩展表';

-- ----------------------------
-- Records of intelligent_form_extend
-- ----------------------------
BEGIN;
INSERT INTO `intelligent_form_extend` (`id`, `code`, `name`, `drawing_controls`, `id_global`, `tree_node_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (36, 'form1', '表单案例模板', '[{\"slot\":{\"prepend\":\"\",\"append\":\"\"},\"attrs\":{\"clearable\":true,\"prefix-icon\":\"\",\"readonly\":false,\"disabled\":false,\"placeholder\":\"请输入单行文本\",\"show-word-limit\":false,\"suffix-icon\":\"\"},\"style\":{\"width\":\"100%\"},\"config\":{\"formId\":101,\"defaultValue\":\"1001\",\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"label\":\"单行文本\",\"showLabel\":true,\"required\":true,\"renderKey\":\"1011617062740739\",\"layout\":\"colFormItem\",\"tagIcon\":\"input\",\"changeTag\":true,\"tag\":\"el-input\",\"regList\":[],\"span\":24,\"vModel\":\"field101\"}},{\"attrs\":{\"type\":\"textarea\",\"readonly\":false,\"disabled\":false,\"placeholder\":\"请输入多行文本\",\"show-word-limit\":false,\"autosize\":{\"minRows\":4,\"maxRows\":4}},\"style\":{\"width\":\"100%\"},\"config\":{\"formId\":102,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"label\":\"多行文本\",\"showLabel\":true,\"required\":true,\"renderKey\":\"1021617062742139\",\"layout\":\"colFormItem\",\"tagIcon\":\"textarea\",\"changeTag\":true,\"tag\":\"el-input\",\"regList\":[],\"span\":24,\"vModel\":\"field102\"}},{\"slot\":{\"prepend\":\"\",\"append\":\"\"},\"attrs\":{\"clearable\":true,\"prefix-icon\":\"\",\"show-password\":true,\"readonly\":false,\"disabled\":false,\"placeholder\":\"请输入密码\",\"show-word-limit\":false,\"suffix-icon\":\"\"},\"style\":{\"width\":\"100%\"},\"config\":{\"formId\":103,\"defaultValue\":\"86228228\",\"document\":\"https://element.eleme.cn/#/zh-CN/component/input\",\"label\":\"密码\",\"showLabel\":true,\"required\":true,\"renderKey\":\"1031617062743482\",\"layout\":\"colFormItem\",\"tagIcon\":\"password\",\"changeTag\":true,\"tag\":\"el-input\",\"regList\":[],\"span\":24,\"vModel\":\"field103\"}},{\"attrs\":{\"step-strictly\":false,\"controls-position\":\"\",\"step\":1,\"disabled\":false,\"placeholder\":\"计数器\"},\"config\":{\"formId\":104,\"document\":\"https://element.eleme.cn/#/zh-CN/component/input-number\",\"label\":\"计数器\",\"showLabel\":true,\"required\":true,\"renderKey\":\"1041617062744859\",\"layout\":\"colFormItem\",\"tagIcon\":\"number\",\"changeTag\":true,\"tag\":\"el-input-number\",\"regList\":[],\"span\":24,\"vModel\":\"field104\"}},{\"attrs\":{\"show-score\":false,\"max\":5,\"show-text\":false,\"allow-half\":false,\"disabled\":false},\"style\":{},\"config\":{\"formId\":105,\"defaultValue\":0,\"document\":\"https://element.eleme.cn/#/zh-CN/component/rate\",\"label\":\"评分\",\"showLabel\":true,\"required\":true,\"renderKey\":\"1051619173289621\",\"layout\":\"colFormItem\",\"tagIcon\":\"rate\",\"changeTag\":true,\"tag\":\"el-rate\",\"regList\":[],\"span\":24,\"vModel\":\"field105\"}}]', 105, '', 'entfrm', '2021-03-30 08:04:19', '小狗', '2021-04-23 18:21:32', '表单扩展模板');
INSERT INTO `intelligent_form_extend` (`id`, `code`, `name`, `drawing_controls`, `id_global`, `tree_node_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (37, 'form2', '表单模板备用', NULL, NULL, NULL, 'entfrm', '2021-03-30 08:05:08', NULL, NULL, '表单模板备用');
INSERT INTO `intelligent_form_extend` (`id`, `code`, `name`, `drawing_controls`, `id_global`, `tree_node_id`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`) VALUES (38, 'form3', '表单模板测试', NULL, NULL, NULL, 'entfrm', '2021-03-30 08:05:29', NULL, NULL, '表单模板测试');
COMMIT;

-- ----------------------------
-- Table structure for oauth_client_details
-- ----------------------------
DROP TABLE IF EXISTS `oauth_client_details`;
CREATE TABLE `oauth_client_details` (
  `client_id` varchar(48) NOT NULL,
  `resource_ids` varchar(256) DEFAULT NULL,
  `client_secret` varchar(256) DEFAULT NULL,
  `scope` varchar(256) DEFAULT NULL,
  `authorized_grant_types` varchar(256) DEFAULT NULL,
  `web_server_redirect_uri` varchar(256) DEFAULT NULL,
  `authorities` varchar(256) DEFAULT NULL,
  `access_token_validity` int(11) DEFAULT NULL,
  `refresh_token_validity` int(11) DEFAULT NULL,
  `additional_information` varchar(4096) DEFAULT NULL,
  `autoapprove` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`client_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of oauth_client_details
-- ----------------------------
BEGIN;
INSERT INTO `oauth_client_details` (`client_id`, `resource_ids`, `client_secret`, `scope`, `authorized_grant_types`, `web_server_redirect_uri`, `authorities`, `access_token_validity`, `refresh_token_validity`, `additional_information`, `autoapprove`) VALUES ('entfrm', '', '$2a$10$IYtF5Qg/TBtau1pT.q4LLu8OdtutvopkxCc4nnV4n.KaadVmeodKK', 'server', 'password,refresh_token', '', NULL, NULL, NULL, NULL, 'true');
INSERT INTO `oauth_client_details` (`client_id`, `resource_ids`, `client_secret`, `scope`, `authorized_grant_types`, `web_server_redirect_uri`, `authorities`, `access_token_validity`, `refresh_token_validity`, `additional_information`, `autoapprove`) VALUES ('test', NULL, '$2a$10$q0DT1hteQMt7LSdmR5GANekY.YYCpxHQh21OCyGDAamxHjiCJaa86', 'test', 'password,refresh_token', NULL, NULL, NULL, NULL, NULL, 'true');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_cron_triggers` (`sched_name`, `trigger_name`, `trigger_group`, `cron_expression`, `time_zone_id`) VALUES ('clusteredScheduler', '测试任务', 'demo', '0 * * * * ? *', 'Asia/Shanghai');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_job_details` (`sched_name`, `job_name`, `job_group`, `description`, `job_class_name`, `is_durable`, `is_nonconcurrent`, `is_update_data`, `requests_recovery`, `job_data`) VALUES ('clusteredScheduler', '测试任务', 'demo', NULL, 'com.cetccq.platform.biz.quartz.config.TmQuartzFactory', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000B7363686564756C654A6F627372002E636F6D2E70696734636C6F75642E706967782E6461656D6F6E2E71756172747A2E656E746974792E5379734A6F6200000000000000010200174C0009636C6173734E616D657400124C6A6176612F6C616E672F537472696E673B4C0008637265617465427971007E00094C000A63726561746554696D657400194C6A6176612F74696D652F4C6F63616C4461746554696D653B4C000E63726F6E45787072657373696F6E71007E00094C000B657865637574655061746871007E00094C00106A6F624578656375746553746174757371007E00094C00086A6F6247726F757071007E00094C00056A6F6249647400134C6A6176612F6C616E672F496E74656765723B4C00076A6F624E616D6571007E00094C00086A6F624F7264657271007E00094C00096A6F6253746174757371007E00094C000D6A6F6254656E616E745479706571007E00094C00076A6F625479706571007E00094C000A6D6574686F644E616D6571007E00094C00116D6574686F64506172616D7356616C756571007E00094C000D6D697366697265506F6C69637971007E00094C00086E65787454696D6571007E000A4C000C70726576696F757354696D6571007E000A4C000672656D61726B71007E00094C0009737461727454696D6571007E000A4C000874656E616E74496471007E000B4C0008757064617465427971007E00094C000A75706461746554696D6571007E000A78720035636F6D2E62616F6D69646F752E6D796261746973706C75732E657874656E73696F6E2E6163746976657265636F72642E4D6F64656C0000000000000001020000787074000464656D6F74000561646D696E7372000D6A6176612E74696D652E536572955D84BA1B2248B20C00007870770A05000007E303190E00F17874000D30202A202A202A202A203F202A7400007400013074000464656D6F737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B02000078700000000174000CE6B58BE8AF95E4BBBBE58AA17400013574000133740001317400013274000A64656D6F4D6574686F6474000970696734636C6F7564740001337371007E0010770905000007E3031916E2787371007E0010770A05000007E30319161CCD78740020E6BC94E7A4BA537072696E67204265616EE79A84E5AE9AE697B6E4BBBBE58AA17371007E0010770A05000007E303191600DE7871007E001874000561646D696E7371007E0010770A05000007E303190E00F1787800);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_locks` (`sched_name`, `lock_name`) VALUES ('clusteredScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` (`sched_name`, `lock_name`) VALUES ('clusteredScheduler', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_scheduler_state` (`sched_name`, `instance_name`, `last_checkin_time`, `checkin_interval`) VALUES ('clusteredScheduler', 'lengleng1553564320591', 1553568907589, 10000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_IBFK_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_IBFK_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`) USING BTREE,
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`, `job_name`, `job_group`, `description`, `next_fire_time`, `prev_fire_time`, `priority`, `trigger_state`, `trigger_type`, `start_time`, `end_time`, `calendar_name`, `misfire_instr`, `job_data`) VALUES ('clusteredScheduler', '测试任务', 'demo', '测试任务', 'demo', NULL, 1553568960000, 1553568900000, 5, 'WAITING', 'CRON', 1553564598000, 0, NULL, 2, '');
COMMIT;

-- ----------------------------
-- Table structure for sys_application
-- ----------------------------
DROP TABLE IF EXISTS `sys_application`;
CREATE TABLE `sys_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(30) DEFAULT NULL COMMENT '应用名称',
  `type` char(1) DEFAULT '0' COMMENT '应用类型',
  `is_sys` char(1) DEFAULT '1' COMMENT '系统',
  `industry` varchar(2) DEFAULT NULL COMMENT '行业',
  `cover` varchar(255) DEFAULT NULL COMMENT '封面',
  `version` varchar(20) DEFAULT NULL COMMENT '版本',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `dept_id` int(11) DEFAULT NULL COMMENT '机构编号',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `create_by` varchar(60) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(60) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标识（0-正常，1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用管理';

-- ----------------------------
-- Records of sys_application
-- ----------------------------
BEGIN;
INSERT INTO `sys_application` (`id`, `name`, `type`, `is_sys`, `industry`, `cover`, `version`, `description`, `sort`, `dept_id`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '通用管理', '1', '0', '通用', NULL, '1.0.1', '通用管理', 1, 1, '1', 'entfrm', '2020-04-23 19:20:29', 'entfrm', '2020-04-23 20:06:36', NULL, '0');
INSERT INTO `sys_application` (`id`, `name`, `type`, `is_sys`, `industry`, `cover`, `version`, `description`, `sort`, `dept_id`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '开发工具', '1', '1', '其他', NULL, '1.0.0', '开发工具', 1, 1, '1', 'entfrm', '2020-05-15 22:55:31', 'entfrm', '2020-05-15 23:09:16', NULL, '1');
COMMIT;

-- ----------------------------
-- Table structure for sys_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_area`;
CREATE TABLE `sys_area` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `ancestors` varchar(255) DEFAULT NULL COMMENT '所有父级编号',
  `name` varchar(30) DEFAULT NULL COMMENT '区域名称',
  `code` varchar(100) DEFAULT NULL COMMENT '区域编码',
  `sort` int(4) DEFAULT '0' COMMENT '显示顺序',
  `type` char(1) DEFAULT NULL COMMENT '区域类型',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_area
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_backup
-- ----------------------------
DROP TABLE IF EXISTS `sys_backup`;
CREATE TABLE `sys_backup` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(120) DEFAULT NULL COMMENT '名称',
  `path` varchar(255) DEFAULT NULL COMMENT '路径',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(30) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remarks` varchar(255) DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_backup
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '参数名称',
  `key` varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '参数键名',
  `value` varchar(500) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '参数键值',
  `is_sys` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '系统内置 0-是|1-否',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` (`id`, `name`, `key`, `value`, `is_sys`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '初始密码', 'user.initPassword', '123456', '0', 'entfrm', '2020-03-15 21:51:13', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_datasource
-- ----------------------------
DROP TABLE IF EXISTS `sys_datasource`;
CREATE TABLE `sys_datasource` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `driver_class_name` varchar(255) DEFAULT NULL COMMENT '数据驱动',
  `url` varchar(255) DEFAULT NULL COMMENT 'url地址',
  `username` varchar(255) DEFAULT NULL COMMENT '用户',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `alias` varchar(120) DEFAULT NULL COMMENT '别名',
  `create_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT '' COMMENT '备注',
  `del_flag` char(50) DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_datasource
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '机构编码',
  `name` varchar(60) CHARACTER SET utf8 DEFAULT NULL COMMENT '机构名称',
  `parent_id` int(11) DEFAULT '0' COMMENT '父级编号',
  `ancestors` varchar(120) CHARACTER SET utf8 DEFAULT '0' COMMENT '祖级列表',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `contacts` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系人',
  `phone` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系地址',
  `email` varchar(60) CHARACTER SET utf8 DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8 DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `create_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` (`dept_id`, `code`, `name`, `parent_id`, `ancestors`, `sort`, `contacts`, `phone`, `address`, `email`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '100001', '重庆总公司', 0, '0', 1, 'entfrm', '15688888888', NULL, NULL, '0', 'entfrm', '2020-02-13 20:55:57', NULL, '2020-03-19 20:49:29', NULL, '0');
INSERT INTO `sys_dept` (`dept_id`, `code`, `name`, `parent_id`, `ancestors`, `sort`, `contacts`, `phone`, `address`, `email`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '10000101', '北京分公司', 1, '0,1', 1, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, '2020-03-15 20:22:11', NULL, '0');
INSERT INTO `sys_dept` (`dept_id`, `code`, `name`, `parent_id`, `ancestors`, `sort`, `contacts`, `phone`, `address`, `email`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (3, '10000102', '昆明分公司', 1, '0,1', 2, '123', '', NULL, NULL, '0', NULL, NULL, 'entfrm', '2020-03-15 20:37:02', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `is_sys` char(1) NOT NULL DEFAULT '0' COMMENT '0-是|1-否',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(30) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remarks` varchar(255) DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '用户性别', 'user_sex', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:40', '用户性别列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '菜单状态', 'menu_status', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:41', '菜单状态列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (3, '是否', 'yes_no', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:42', '是否列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (4, '状态', 'status', '0', '0', 'admin', '2018-03-16 11:33:00', 'admin', '2020-03-17 14:19:42', '状态列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (5, '成功失败', 'success_fail', '0', '0', 'admin', '2019-08-24 10:02:57', 'admin', '2020-03-17 14:19:43', '成功失败列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (6, '文件类别', 'file_type', '0', '0', 'entfrm', '2020-03-17 13:57:44', 'entfrm', '2020-03-20 22:48:19', '文件类别列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, '数据库类型', 'datasource_type', '0', '0', 'entfrm', '2020-03-21 11:33:14', 'entfrm', '2020-03-22 09:56:10', '数据库类型列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, '任务类型', 'job_type', '0', '0', 'entfrm', '2020-03-21 21:21:46', NULL, NULL, '任务类型列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (9, '登录类型', 'login_type', '0', '0', 'entfrm', '2020-03-22 09:55:59', NULL, NULL, '登录类型列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (10, '快捷方式类型', 'shortcut_type', '0', '0', 'entfrm', '2020-03-27 09:48:05', 'entfrm', '2020-03-27 10:14:27', '快捷方式类型列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (11, '模型分类', 'model_category', '0', '0', 'entfrm', '2020-04-04 22:09:36', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (12, '请假类型', 'leave_type', '0', '0', 'entfrm', '2020-04-05 10:08:18', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (13, '任务状态', 'job_status', '0', '0', 'entfrm', '2020-04-11 18:54:20', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (14, 'Activiti流程状态', 'process_status', '0', '0', 'entfrm', '2020-04-12 14:30:52', 'entfrm', '2021-05-12 01:37:16', 'Activiti流程状态', '1');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (15, '应用类型', 'application_type', '0', '0', 'entfrm', '2020-04-23 18:54:07', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (16, '消息类型', 'msg_type', '0', '0', 'entfrm', '2020-05-10 16:02:20', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (17, '应用状态', 'application_status', '0', '0', 'entfrm', '2020-05-15 22:56:49', NULL, NULL, '应用状态列表', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (18, '消息通知类型', 'content_type', '0', '0', 'entfrm', '2020-05-25 15:45:41', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (19, '数据格式类型', 'data_type', '0', '0', 'entfrm', '2020-06-13 08:51:07', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (20, '表单类型', 'form_type', '0', '0', 'entfrm', '2021-03-26 23:30:49', NULL, NULL, '', '0');
INSERT INTO `sys_dict` (`id`, `name`, `type`, `is_sys`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (21, 'Activiti流程状态', 'process_status', '1', '0', 'entfrm', '2021-05-12 01:37:30', NULL, NULL, 'Activiti流程状态', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `dict_id` int(11) DEFAULT NULL COMMENT '字典编号',
  `dict_type` varchar(100) NOT NULL COMMENT '类型',
  `label` varchar(100) NOT NULL COMMENT '标签名',
  `value` varchar(100) NOT NULL COMMENT '数据值',
  `sort` int(10) NOT NULL COMMENT '排序（升序）',
  `create_by` varchar(30) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(30) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(255) DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, 1, 'user_sex', '男', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-13 18:33:40', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, 1, 'user_sex', '女', '1', 2, NULL, '2019-08-13 18:34:03', NULL, '2019-08-13 18:34:07', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (3, 2, 'menu_status', '隐藏', '1', 2, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:29', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (4, 2, 'menu_status', '显示', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:28', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (5, 3, 'yes_no', '是', '0', 1, NULL, '2019-08-13 18:33:37', 'admin', '2020-03-17 12:05:05', '', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (6, 3, 'yes_no', '否', '1', 2, NULL, '2019-08-13 18:33:37', 'admin', '2020-03-17 12:05:06', '', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, 4, 'status', '停用', '1', 2, NULL, '2019-08-13 18:34:03', 'admin', '2019-08-19 15:43:00', '', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, 4, 'status', '正常', '0', 1, NULL, '2019-08-13 18:33:37', NULL, '2019-08-19 15:42:59', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (9, NULL, 'success_fail', '成功', '0', 10, 'admin', '2019-08-24 11:48:18', 'entfrm', '2019-08-24 11:48:17', '', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (10, NULL, 'success_fail', '失败', '1', 20, 'admin', '2019-08-24 11:48:27', NULL, '2019-08-24 11:48:26', '', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (11, NULL, 'file_type', '图片', 'image', 1, 'entfrm', '2020-03-20 22:48:39', NULL, '2020-03-28 16:27:48', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (12, NULL, 'file_type', '媒体', 'media', 2, 'entfrm', '2020-03-20 22:48:48', 'entfrm', '2020-03-28 16:28:32', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (13, NULL, 'file_type', '文档', 'file', 3, 'entfrm', '2020-03-20 22:49:03', NULL, '2020-03-28 16:28:21', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (14, NULL, 'datasource_type', 'Mysql', 'com.mysql.cj.jdbc.Driver', 1, 'entfrm', '2020-03-21 11:33:59', 'entfrm', '2020-03-21 11:33:59', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (15, NULL, 'datasource_type', 'Sqlserver', 'com.microsoft.sqlserver.jdbc.SQLServerDriver', 2, 'entfrm', '2020-03-21 11:34:59', 'entfrm', '2020-03-21 11:34:58', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (16, NULL, 'datasource_type', 'Postgresql', 'org.postgresql.Driver', 3, 'entfrm', '2020-03-21 11:36:16', NULL, '2020-03-21 11:36:15', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (17, NULL, 'job_type', 'Java类', '1', 1, 'entfrm', '2020-03-21 21:22:35', NULL, '2020-03-21 21:22:35', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (18, NULL, 'job_type', 'Spring bean名称', '2', 2, 'entfrm', '2020-03-21 21:22:50', NULL, '2020-03-21 21:22:50', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (19, NULL, 'job_type', 'Rest调用', '3', 3, 'entfrm', '2020-03-21 21:23:06', NULL, '2020-03-21 21:23:05', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (20, NULL, 'job_type', 'Jar调用', '4', 4, 'entfrm', '2020-03-21 21:23:19', NULL, '2020-03-21 21:23:18', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (21, NULL, 'job_type', '其他', '5', 0, 'entfrm', '2020-03-21 21:23:24', NULL, '2020-03-21 21:23:24', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (22, NULL, 'login_type', '登录', '0', 1, 'entfrm', '2020-03-22 09:56:41', NULL, '2020-03-22 09:56:40', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (23, NULL, 'login_type', '退出', '1', 2, 'entfrm', '2020-03-22 09:56:51', NULL, '2020-03-22 09:56:51', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (24, NULL, 'shortcut_type', '顶部', '1', 1, 'entfrm', '2020-03-27 09:48:24', NULL, '2020-03-27 09:48:23', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (25, NULL, 'shortcut_type', '首页', '2', 2, 'entfrm', '2020-03-27 09:48:38', NULL, '2020-03-27 09:48:38', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (26, NULL, 'model_category', '办公流程', 'office', 1, 'entfrm', '2020-04-04 22:10:14', NULL, '2020-04-04 22:10:13', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (27, NULL, 'model_category', '项目流程', 'project', 2, 'entfrm', '2020-04-04 22:10:27', NULL, '2020-04-04 22:10:26', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (28, NULL, 'leave_type', '事假', '1', 1, 'entfrm', '2020-04-05 10:08:52', NULL, '2020-04-05 10:08:52', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (29, NULL, 'leave_type', '病假', '2', 2, 'entfrm', '2020-04-05 10:09:05', NULL, '2020-04-05 10:09:05', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (30, NULL, 'leave_type', '产假', '3', 3, 'entfrm', '2020-04-05 10:09:37', 'entfrm', '2020-04-05 10:09:37', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (31, NULL, 'job_status', '未发布', '1', 1, 'entfrm', '2020-04-11 18:54:37', NULL, '2020-04-11 18:54:37', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (32, NULL, 'job_status', '运行中', '2', 2, 'entfrm', '2020-04-11 18:54:48', NULL, '2020-04-11 18:54:47', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (33, NULL, 'job_status', '暂停', '3', 3, 'entfrm', '2020-04-11 18:54:57', NULL, '2020-04-11 18:54:57', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (34, NULL, 'leave_status', '未提交', '0', 0, 'entfrm', '2020-04-12 14:31:12', NULL, '2020-04-12 14:31:11', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (35, NULL, 'leave_status', '未审批', '1', 1, 'entfrm', '2020-04-12 14:31:29', NULL, '2020-04-12 14:31:28', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (36, NULL, 'leave_status', '批准', '2', 2, 'entfrm', '2020-04-12 14:31:38', NULL, '2020-04-12 14:31:38', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (37, NULL, 'leave_status', '驳回', '9', 3, 'entfrm', '2020-04-12 14:31:51', '小狗', '2020-04-12 14:31:51', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (38, NULL, 'application_type', 'PC', '1', 1, 'entfrm', '2020-04-23 18:54:36', NULL, '2020-04-23 18:54:36', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (39, NULL, 'application_type', 'APP', '2', 2, 'entfrm', '2020-04-23 18:54:44', NULL, '2020-04-23 18:54:44', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (40, NULL, 'application_type', '小程序', '3', 3, 'entfrm', '2020-04-23 18:54:58', NULL, '2020-04-23 18:54:57', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (41, NULL, 'msg_type', '短信', '0', 0, 'entfrm', '2020-05-10 16:02:40', NULL, '2020-05-10 16:02:40', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (42, NULL, 'msg_type', '邮件', '1', 1, 'entfrm', '2020-05-10 16:02:50', NULL, '2020-05-10 16:02:50', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (43, NULL, 'application_status', '未发布', '0', 0, 'entfrm', '2020-05-15 22:57:27', NULL, '2020-05-15 22:57:27', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (44, NULL, 'application_status', '已发布', '1', 1, 'entfrm', '2020-05-15 22:57:36', NULL, '2020-05-15 22:57:35', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (45, NULL, 'msg_type', 'PC', '2', 2, 'entfrm', '2020-05-25 15:44:18', NULL, '2020-05-25 15:44:17', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (46, NULL, 'msg_type', 'APP', '3', 3, 'entfrm', '2020-05-25 15:44:44', NULL, '2020-05-25 15:44:43', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (47, NULL, 'msg_type', '微信', '4', 4, 'entfrm', '2020-05-25 15:44:56', NULL, '2020-05-25 15:44:56', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (48, NULL, 'content_type', '通知', '0', 0, 'entfrm', '2020-05-25 15:46:28', NULL, '2020-05-25 15:46:28', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (49, NULL, 'content_type', '公告', '1', 1, 'entfrm', '2020-05-25 15:46:38', NULL, '2020-05-25 15:46:38', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (50, NULL, 'content_type', '其他', '2', 2, 'entfrm', '2020-05-25 15:46:46', NULL, '2020-05-25 15:46:45', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (51, NULL, 'data_type', 'json', 'json', 1, 'entfrm', '2020-06-13 08:51:24', NULL, '2020-06-13 08:51:24', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (52, NULL, 'form_type', '普通表单', '0', 0, 'entfrm', '2021-03-26 23:31:12', NULL, '2021-03-26 23:31:12', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (53, NULL, 'form_type', '工作流表单', '1', 1, 'entfrm', '2021-03-26 23:31:20', NULL, '2021-03-26 23:31:19', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (54, NULL, 'leave_status', '作废', '8', 4, '小狗', '2021-04-15 01:03:15', NULL, '2021-04-15 01:03:14', '作废流程', '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (55, NULL, 'application_type', '已挂起', '0', 0, 'entfrm', '2021-05-12 01:37:45', NULL, '2021-05-12 01:37:45', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (56, NULL, 'process_status', '已挂起', '0', 0, 'entfrm', '2021-05-12 01:38:51', NULL, '2021-05-12 01:38:50', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (57, NULL, 'process_status', '等待审核', '1', 1, 'entfrm', '2021-05-12 01:38:59', 'entfrm', '2021-05-12 01:38:59', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (58, NULL, 'process_status', '审核通过', '2', 2, 'entfrm', '2021-05-12 01:39:08', 'entfrm', '2021-05-12 01:39:07', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (59, NULL, 'process_status', '流程撤回', '3', 3, 'entfrm', '2021-05-12 01:39:14', 'entfrm', '2021-05-12 01:39:14', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (60, NULL, 'process_status', '审核驳回', '4', 4, 'entfrm', '2021-05-12 01:39:22', 'entfrm', '2021-05-12 01:39:21', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (61, NULL, 'process_status', '审核终止', '5', 5, 'entfrm', '2021-05-12 01:39:32', 'entfrm', '2021-05-12 01:39:31', NULL, '0');
INSERT INTO `sys_dict_data` (`id`, `dict_id`, `dict_type`, `label`, `value`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (62, NULL, 'process_status', '流程作废', '6', 6, 'entfrm', '2021-05-12 01:39:52', 'entfrm', '2021-05-12 01:39:51', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(120) DEFAULT NULL COMMENT '文件名称',
  `type` varchar(10) DEFAULT NULL COMMENT '文件类型',
  `format` varchar(30) DEFAULT NULL COMMENT '文件格式',
  `size` varchar(30) DEFAULT NULL COMMENT '文件大小',
  `path` varchar(255) DEFAULT NULL COMMENT '文件保存路径',
  `thumbnail` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `dept_id` int(11) DEFAULT NULL COMMENT '机构编号',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `remarks` varchar(255) DEFAULT '' COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_file_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `job_name` varchar(64) NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) NOT NULL COMMENT '任务组名',
  `job_order` char(1) DEFAULT NULL COMMENT '组内执行顺利，值越大执行优先级越高，最大值9，最小值1',
  `job_type` char(1) NOT NULL DEFAULT '1' COMMENT '1、java类;2、spring bean名称;3、rest调用;4、jar调用;9其他',
  `execute_path` varchar(500) DEFAULT NULL COMMENT 'job_type=3时，rest调用地址，仅支持rest get协议,需要增加String返回值，0成功，1失败;job_type=4时，jar路径;其它值为空',
  `params_value` varchar(2000) DEFAULT NULL COMMENT '参数值',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) DEFAULT '3' COMMENT '错误策略（1立即执行 2执行一次 3放弃执行）',
  `job_tenant_type` char(1) DEFAULT '1' COMMENT '1、多租户任务;2、非多租户任务',
  `job_status` char(1) DEFAULT '0' COMMENT '状态（1、未发布;2、运行中;3、暂停;4、删除;）',
  `job_execute_status` char(1) DEFAULT '0' COMMENT '状态（0正常 1异常）',
  `start_time` datetime DEFAULT NULL COMMENT '初次执行时间',
  `previous_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `next_time` datetime DEFAULT NULL COMMENT '下次执行时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `remarks` varchar(500) DEFAULT '' COMMENT '备注信息',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='定时任务调度表';

-- ----------------------------
-- Records of sys_job
-- ----------------------------
BEGIN;
INSERT INTO `sys_job` (`id`, `job_name`, `job_group`, `job_order`, `job_type`, `execute_path`, `params_value`, `cron_expression`, `misfire_policy`, `job_tenant_type`, `job_status`, `job_execute_status`, `start_time`, `previous_time`, `next_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, 'demoMethod', 'demo', '5', '2', 'demo.demoMethod', '1', '0 * * * * ? *', '3', '1', '3', '0', '2020-05-21 16:17:11', '2020-06-02 10:37:00', '2020-06-02 10:38:00', 'admin', '2019-03-25 14:00:14', 'entfrm', '2021-04-04 17:20:50', '演示Spring Bean的定时任务', '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_id` int(11) NOT NULL COMMENT '任务id',
  `job_name` varchar(64) DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(64) DEFAULT NULL COMMENT '任务组名',
  `job_order` char(1) DEFAULT NULL COMMENT '组内执行顺利，值越大执行优先级越高，最大值9，最小值1',
  `job_type` char(1) NOT NULL DEFAULT '1' COMMENT '1、java类;2、spring bean名称;3、rest调用;4、jar调用;9其他',
  `execute_path` varchar(500) DEFAULT NULL COMMENT 'job_type=3时，rest调用地址，仅支持post协议;job_type=4时，jar路径;其它值为空',
  `params_value` varchar(2000) DEFAULT NULL COMMENT '参数值',
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron执行表达式',
  `job_message` varchar(500) DEFAULT NULL COMMENT '日志信息',
  `job_log_status` char(1) DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `execute_time` varchar(30) DEFAULT NULL COMMENT '执行时间',
  `exception_info` varchar(2000) DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='定时任务执行日志表';

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `login_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '登录账号',
  `login_type` char(1) DEFAULT '0' COMMENT '登录类型',
  `login_ip` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '登录IP地址',
  `login_addr` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '登录地点',
  `user_agent` text CHARACTER SET utf8mb4 COMMENT '用户代理',
  `status` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '提示消息',
  `login_time` datetime DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=678 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (638, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', '0', '', '2021-04-23 18:08:27');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (639, 'entfrm', '1', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', '0', '', '2021-04-23 18:17:14');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (640, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', '0', '', '2021-04-23 18:17:26');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (641, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-04-30 05:09:39');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (642, '小可爱', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.27 Safari/537.36', '0', '', '2021-04-30 05:50:11');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (643, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-04-30 07:52:22');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (644, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-04-30 07:53:00');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (645, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-01 21:05:18');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (646, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-01 21:26:23');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (647, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-01 21:26:58');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (648, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '1', '登录失败，异常：Bad credentials', '2021-05-08 04:15:08');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (649, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '1', '登录失败，异常：Bad credentials', '2021-05-08 04:15:22');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (650, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-08 04:16:27');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (651, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-08 08:35:16');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (652, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-09 01:22:45');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (653, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-10 00:25:29');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (654, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-10 07:43:54');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (655, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-11 08:58:02');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (656, '小可爱', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.38 Safari/537.36', '0', '', '2021-05-11 11:01:40');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (657, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-11 14:23:20');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (658, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-12 01:34:28');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (659, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '0', '', '2021-05-12 02:40:35');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (660, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-14 01:46:19');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (661, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-14 05:13:22');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (662, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-14 05:52:05');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (663, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-21 13:35:30');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (664, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-21 16:21:59');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (665, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-21 17:07:35');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (666, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '0', '', '2021-05-21 20:24:48');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (667, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '0', '', '2021-05-21 20:25:12');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (668, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '0', '', '2021-05-21 22:29:15');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (669, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '0', '', '2021-05-21 22:29:46');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (670, '小狗', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-21 22:50:49');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (671, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '0', '', '2021-05-21 23:29:34');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (672, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '0', '', '2022-09-27 16:51:19');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (673, 'entfrm', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', '0', '', '2022-09-27 17:44:49');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (674, '小猫', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15', '0', '', '2022-09-27 20:01:07');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (675, '小可爱', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15', '0', '', '2022-09-27 20:05:50');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (676, '小猪', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15', '0', '', '2022-09-27 20:06:18');
INSERT INTO `sys_login_log` (`id`, `login_name`, `login_type`, `login_ip`, `login_addr`, `user_agent`, `status`, `msg`, `login_time`) VALUES (677, '小可爱', '0', '127.0.0.1', 'XX XX', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15', '0', '', '2022-09-27 20:09:22');
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '菜单名称',
  `parent_id` int(11) DEFAULT NULL COMMENT '父菜单ID',
  `parent_ids` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '父菜单IDS',
  `application_id` int(11) DEFAULT '1' COMMENT '应用编号',
  `type` char(1) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单类型 ',
  `path` varchar(128) CHARACTER SET utf8 DEFAULT NULL COMMENT '前端URL',
  `component` varchar(64) CHARACTER SET utf8 DEFAULT '#' COMMENT 'VUE页面',
  `perms` varchar(60) CHARACTER SET utf8 DEFAULT NULL COMMENT '菜单权限标识',
  `icon` varchar(60) CHARACTER SET utf8 DEFAULT NULL COMMENT '图标',
  `no_cache` char(1) DEFAULT '1' COMMENT '路由缓存',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `status` char(1) CHARACTER SET utf8 DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `create_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=266 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '系统管理', 0, NULL, 1, 'M', 'system', '#', '', 'system', '0', 10, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2020-03-16 20:45:21', '系统管理模块', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '运维监控', 0, NULL, 1, 'M', 'monitor', '#', '', 'monitor', '0', 20, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2020-03-17 19:14:27', '运维监控模块', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (3, '开发工具', 0, NULL, 1, 'M', 'toolkit', '#', '', 'tool', '0', 30, '0', 'admin', '2019-03-16 11:33:00', 'admin', '2021-03-26 22:01:59', '开发工具模块', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (4, '机构管理', 1, NULL, 1, 'C', 'dept', 'system/dept/index', '', 'tree', '0', 1, '0', NULL, '2020-03-13 19:31:20', NULL, '2020-03-14 20:55:41', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (5, '角色管理', 1, NULL, 1, 'C', 'role', 'system/role/index', '', 'peoples', '0', 2, '0', NULL, '2020-03-13 19:32:09', NULL, '2020-03-16 22:11:57', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (6, '用户管理', 1, NULL, 1, 'C', 'user', 'system/user/index', '', 'user', '0', 3, '0', NULL, '2020-03-13 19:32:30', NULL, '2020-03-16 22:11:59', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, '菜单管理', 1, NULL, 1, 'C', 'menu', 'system/menu/index', '', 'tree-table', '0', 4, '0', NULL, '2020-03-13 19:33:24', NULL, '2020-03-16 22:12:01', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, '机构新增', 4, NULL, 1, 'F', NULL, '#', 'dept_add', NULL, '0', 1, '0', NULL, '2020-03-12 20:42:47', NULL, '2020-03-16 20:42:51', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (9, '机构修改', 4, NULL, 1, 'F', NULL, '#', 'dept_edit', NULL, '0', 2, '0', NULL, '2020-03-12 20:42:52', NULL, '2020-03-16 20:42:56', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (10, '机构删除', 4, NULL, 1, 'F', NULL, '#', 'dept_del', NULL, '0', 3, '0', NULL, '2020-03-12 20:42:57', NULL, '2020-03-16 20:43:02', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (11, '机构查看', 4, NULL, 1, 'F', NULL, '#', 'dept_view', NULL, '0', 4, '0', NULL, '2020-03-12 20:43:03', NULL, '2020-03-16 20:43:06', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (12, '机构导入', 4, NULL, 1, 'F', NULL, '#', 'dept_import', NULL, '0', 5, '0', 'entfrm', '2020-03-16 20:40:08', 'entfrm', '2020-03-16 20:42:10', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (13, '角色新增', 5, NULL, 1, 'F', NULL, '#', 'role_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 11:50:24', NULL, '2020-03-16 20:41:51', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (14, '角色修改', 5, NULL, 1, 'F', NULL, '#', 'role_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 11:51:05', NULL, '2020-03-16 20:41:44', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (15, '角色删除', 5, NULL, 1, 'F', NULL, '#', 'role_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 11:51:21', NULL, '2020-03-16 20:41:41', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (16, '角色查看', 5, NULL, 1, 'F', NULL, '#', 'role_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 11:51:40', NULL, '2020-03-16 20:41:37', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (17, '数据权限', 5, NULL, 1, 'F', NULL, '#', 'role_data', NULL, '0', 5, '0', 'entfrm', '2020-03-16 12:15:50', NULL, '2020-03-16 20:41:34', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (18, '用户添加', 6, NULL, 1, 'F', NULL, '#', 'user_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:31:15', NULL, '2020-03-16 20:41:31', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (19, '用户修改', 6, NULL, 1, 'F', NULL, '#', 'user_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:32:19', 'entfrm', '2020-03-16 20:41:28', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (20, '用户删除', 6, NULL, 1, 'F', NULL, '#', 'user_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:32:41', NULL, '2020-03-16 20:41:25', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (21, '用户查看', 6, NULL, 1, 'F', NULL, '#', 'user_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:33:11', NULL, '2020-03-16 20:41:20', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (22, '重置密码', 6, NULL, 1, 'F', NULL, '#', 'user_reset', NULL, '0', 5, '0', 'entfrm', '2020-03-16 20:34:22', 'entfrm', '2020-03-16 20:41:17', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (23, '用户导入', 6, NULL, 1, 'F', NULL, '#', 'user_import', NULL, '0', 6, '0', 'entfrm', '2020-03-16 20:34:49', NULL, '2020-03-16 20:41:14', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (24, '用户导出', 6, NULL, 1, 'F', NULL, '#', 'user_export', NULL, '0', 7, '0', 'entfrm', '2020-03-16 20:35:12', NULL, '2020-03-16 20:41:12', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (25, '菜单新增', 7, NULL, 1, 'F', NULL, '#', 'menu_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:38:18', NULL, '2020-03-16 20:41:10', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (26, '菜单修改', 7, NULL, 1, 'F', NULL, '#', 'menu_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:38:41', 'entfrm', '2020-03-16 20:41:07', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (27, '菜单删除', 7, NULL, 1, 'F', NULL, '#', 'menu_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:39:04', NULL, '2020-03-16 20:41:04', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (28, '菜单查看', 7, NULL, 1, 'F', NULL, '#', 'menu_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:39:39', NULL, '2020-03-16 20:41:01', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (29, '字典管理', 1, '6', 1, 'C', 'dict', 'system/dict/index', '', 'dict', '0', 5, '0', 'entfrm', '2020-03-16 11:33:00', '', '2020-03-16 11:33:00', '字典管理菜单', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (30, '字典新增', 29, NULL, 1, 'F', NULL, '#', 'dict_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 20:50:45', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (31, '字典修改', 29, NULL, 1, 'F', NULL, '#', 'dict_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 20:51:01', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (32, '字典删除', 29, NULL, 1, 'F', NULL, '#', 'dict_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 20:52:18', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (33, '字典查看', 29, NULL, 1, 'F', NULL, '#', 'dict_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 20:52:38', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (34, '数据增加', 29, NULL, 1, 'F', NULL, '#', 'dictData_add', NULL, '0', 5, '0', 'entfrm', '2020-03-16 21:49:18', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (35, '数据修改', 29, NULL, 1, 'F', NULL, '#', 'dictData_edit', NULL, '0', 6, '0', 'entfrm', '2020-03-16 21:49:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (36, '数据删除', 29, NULL, 1, 'F', NULL, '#', 'dictData_del', NULL, '0', 7, '0', 'entfrm', '2020-03-16 21:50:00', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (37, '数据查看', 29, NULL, 1, 'F', NULL, '#', 'dictData_view', NULL, '0', 8, '0', 'entfrm', '2020-03-16 21:50:19', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (38, '参数管理', 1, NULL, 1, 'C', 'config', 'system/config/index', NULL, 'list', '0', 6, '0', 'entfrm', '2020-03-16 22:06:52', NULL, '2020-03-16 22:11:13', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (39, '参数新增', 38, NULL, 1, 'F', NULL, '#', 'config_add', NULL, '0', 1, '0', 'entfrm', '2020-03-16 22:07:16', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (40, '参数修改', 38, NULL, 1, 'F', NULL, '#', 'config_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-16 22:07:30', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (41, '参数删除', 38, NULL, 1, 'F', NULL, '#', 'config_del', NULL, '0', 3, '0', 'entfrm', '2020-03-16 22:07:43', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (42, '参数查看', 38, NULL, 1, 'F', NULL, '#', 'config_view', NULL, '0', 4, '0', 'entfrm', '2020-03-16 22:08:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (43, '快捷方式', 1, NULL, 1, 'C', 'shortcut', 'system/shortcut/index', NULL, 'link', '0', 7, '0', 'entfrm', '2020-03-17 17:53:08', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (44, '文件管理', 1, NULL, 1, 'C', 'fileInfo', 'system/fileInfo/index', NULL, 'zip', '0', 8, '0', 'entfrm', '2020-03-17 17:56:28', 'entfrm', '2020-03-20 22:33:35', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (45, '终端管理', 1, NULL, 1, 'C', 'clientDetails', 'system/clientDetails/index', NULL, 'phone', '0', 9, '0', 'entfrm', '2020-03-17 17:57:46', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (46, '数据备份', 1, NULL, 1, 'C', 'backup', 'system/backup/index', NULL, 'date-range', '0', 11, '0', 'entfrm', '2020-03-17 18:02:21', NULL, '2020-03-18 22:20:28', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (47, '令牌管理', 2, NULL, 1, 'C', 'token', 'monitor/token/index', NULL, 'post', '0', 1, '0', 'entfrm', '2020-03-17 17:59:55', 'entfrm', '2020-05-10 22:32:05', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (48, '定时任务', 2, NULL, 1, 'C', 'job', 'monitor/job/index', NULL, 'time-range', '0', 2, '0', 'entfrm', '2020-03-17 18:08:23', NULL, '2020-03-18 22:20:23', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (49, '数据监控', 2, NULL, 1, 'C', 'druid', 'monitor/druid/index', NULL, 'druid', '0', 3, '0', 'entfrm', '2020-03-17 18:08:56', NULL, '2020-03-20 18:53:07', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (50, '服务监控', 2, NULL, 1, 'C', 'server', 'monitor/server/index', NULL, 'server', '0', 4, '0', 'entfrm', '2020-03-17 18:09:39', 'entfrm', '2020-03-20 19:23:24', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (51, 'API监控', 2, NULL, 1, 'C', 'apiStat', 'monitor/apiStat/index', 'apiStat_view', 'chart', '0', 6, '0', 'entfrm', '2020-03-17 18:15:13', 'entfrm', '2020-05-17 16:48:20', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (52, '日志监控', 2, NULL, 1, 'M', 'log', '#', NULL, 'monitor', '0', 7, '0', 'entfrm', '2020-03-17 18:12:01', NULL, '2020-05-17 16:48:23', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (53, '登录日志', 52, NULL, 1, 'C', 'loginLog', 'monitor/loginLog/index', NULL, 'logininfor', '0', 1, '0', 'entfrm', '2020-03-17 18:12:56', NULL, '2020-03-18 22:31:53', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (54, '操作日志', 52, NULL, 1, 'C', 'operLog', 'monitor/operLog/index', NULL, 'log', '0', 2, '0', 'entfrm', '2020-03-17 18:13:52', 'entfrm', '2020-03-18 22:31:36', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (55, '接口文档', 3, NULL, 2, 'C', 'swagger', 'toolkit/swagger/index', NULL, 'swagger', '0', 4, '0', 'entfrm', '2020-03-17 18:18:38', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (56, '模板管理', 3, NULL, 2, 'M', 'template', '#', NULL, 'drag', '0', 5, '0', 'entfrm', '2020-03-17 18:19:52', 'entfrm', '2021-03-26 21:59:08', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (57, '表单构建', 3, NULL, 2, 'C', 'build', 'toolkit/build/index', NULL, 'form', '0', 6, '0', 'entfrm', '2020-03-17 18:21:32', 'entfrm', '2021-03-27 09:12:17', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (58, '工作流', 0, NULL, 2, 'M', 'flowable', '#', NULL, 'skill', '1', 4, '0', 'entfrm', '2020-03-17 18:22:36', 'entfrm', '2022-09-27 17:01:41', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (59, '终端新增', 45, NULL, 1, 'F', NULL, '#', 'clientDetails_add', NULL, '0', 1, '0', 'entfrm', '2020-03-18 15:18:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (60, '终端修改', 45, NULL, 1, 'F', NULL, '#', 'clientDetails_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-18 15:18:53', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (61, '终端删除', 45, NULL, 1, 'F', NULL, '#', 'clientDetails_del', NULL, '0', 3, '0', 'entfrm', '2020-03-18 15:19:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (62, '终端查看', 45, NULL, 1, 'F', NULL, '#', 'clientDetails_view', NULL, '0', 4, '0', 'entfrm', '2020-03-18 15:19:29', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (63, '登录日志删除', 53, NULL, 1, 'F', NULL, '#', 'loginLog_del', NULL, '0', 1, '0', 'entfrm', '2020-03-19 11:50:34', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (64, '登录日志查看', 53, NULL, 1, 'F', NULL, '#', 'loginLog_view', NULL, '0', 2, '0', 'entfrm', '2020-03-19 11:50:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (65, '登录日志导出', 53, NULL, 1, 'F', NULL, '#', 'loginLog_export', NULL, '0', 3, '0', 'entfrm', '2020-03-19 11:52:05', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (66, '操作日志删除', 54, NULL, 1, 'F', NULL, '#', 'operLog_del', NULL, '0', 1, '0', 'entfrm', '2020-03-19 11:52:25', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (67, '操作日志查看', 54, NULL, 1, 'F', NULL, '#', 'operLog_view', NULL, '0', 2, '0', 'entfrm', '2020-03-19 11:52:45', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (68, '操作日志导出', 54, NULL, 1, 'F', NULL, '#', 'operLog_export', NULL, '0', 3, '0', 'entfrm', '2020-03-19 11:53:09', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (69, '备份新增', 46, NULL, 1, 'F', NULL, '#', 'backup_add', NULL, '0', 1, '0', 'entfrm', '2020-03-20 21:59:58', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (70, '备份还原', 46, NULL, 1, 'F', NULL, '#', 'backup_restore', NULL, '0', 2, '0', 'entfrm', '2020-03-20 22:00:23', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (71, '备份删除', 46, NULL, 1, 'F', NULL, '#', 'backup_del', NULL, '0', 3, '0', 'entfrm', '2020-03-20 22:00:41', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (72, '备份查看', 46, NULL, 1, 'F', NULL, '#', 'backup_view', NULL, '0', 4, '0', 'entfrm', '2020-03-20 22:44:05', NULL, '2020-03-20 22:44:39', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (73, '文件上传', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_add', NULL, '0', 1, '0', 'entfrm', '2020-03-20 22:41:42', NULL, '2020-03-20 22:44:35', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (74, '文件启用', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-20 22:42:07', 'entfrm', '2020-03-20 22:44:32', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (75, '文件删除', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_del', NULL, '0', 3, '0', 'entfrm', '2020-03-20 22:42:30', NULL, '2020-03-20 22:44:29', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (76, '文件查看', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_view', NULL, '0', 4, '0', 'entfrm', '2020-03-20 22:43:06', NULL, '2020-03-20 22:44:26', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (77, '文件分享', 44, NULL, 1, 'F', NULL, '#', 'fileInfo_share', NULL, '0', 5, '0', 'entfrm', '2020-03-20 22:43:37', 'entfrm', '2020-03-20 22:44:23', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (78, '数据库管理', 3, NULL, 2, 'C', 'datasource', 'toolkit/datasource/index', NULL, 'druid', '0', 1, '0', 'entfrm', '2020-03-21 11:05:47', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (79, '数据表管理', 3, NULL, 2, 'C', 'datatable', 'toolkit/datatable/index', NULL, 'table', '0', 2, '0', 'entfrm', '2020-03-21 11:07:23', 'entfrm', '2021-03-26 21:59:08', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (81, '数据库新增', 78, NULL, 1, 'F', NULL, '#', 'datasource_add', NULL, '0', 1, '0', 'entfrm', '2020-03-21 11:27:26', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (82, '数据库修改', 78, NULL, 1, 'F', NULL, '#', 'datasource_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-21 11:27:46', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (83, '数据库删除', 78, NULL, 1, 'F', NULL, '#', 'datasource_del', NULL, '0', 3, '0', 'entfrm', '2020-03-21 11:27:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (84, '数据库查看', 78, NULL, 1, 'F', NULL, '#', 'datasource_view', NULL, '0', 4, '0', 'entfrm', '2020-03-21 11:28:11', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (85, '模型管理', 248, NULL, 1, 'C', 'model', 'flowable/model/index', NULL, 'edit', '1', 1, '0', 'entfrm', '2020-03-24 12:48:54', 'entfrm', '2022-09-27 17:01:37', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (86, '模型新增', 85, NULL, 1, 'F', NULL, '#', 'model_add', NULL, '1', 1, '0', 'entfrm', '2020-03-24 12:52:47', NULL, '2022-09-27 17:01:32', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (87, '模型删除', 85, NULL, 1, 'F', NULL, '#', 'model_del', NULL, '1', 2, '0', 'entfrm', '2020-03-24 12:53:43', NULL, '2022-09-27 17:01:30', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (88, '模型查看', 85, NULL, 1, 'F', NULL, '#', 'model_view', NULL, '1', 3, '0', 'entfrm', '2020-03-24 12:53:56', NULL, '2022-09-27 17:01:33', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (89, '模型部署', 85, NULL, 1, 'F', NULL, '#', 'model_deploy', NULL, '1', 4, '0', 'entfrm', '2020-03-24 12:54:19', NULL, '2022-09-27 17:01:35', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (90, '表新增', 79, NULL, 1, 'F', NULL, '#', 'datatable_add', NULL, '0', 1, '0', 'entfrm', '2020-03-25 14:59:45', 'entfrm', '2020-03-25 15:00:14', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (91, '表修改', 79, NULL, 1, 'F', NULL, '#', 'datatable_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-25 15:00:31', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (92, '表删除', 79, NULL, 1, 'F', NULL, '#', 'datatable_del', NULL, '0', 3, '0', 'entfrm', '2020-03-25 15:00:49', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (93, '表查看', 79, NULL, 1, 'F', NULL, '#', 'datatable_view', NULL, '0', 4, '0', 'entfrm', '2020-03-25 15:01:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (94, '表配置', 79, NULL, 1, 'F', NULL, '#', 'datatable_config', NULL, '0', 5, '0', 'entfrm', '2020-03-25 15:02:39', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (95, '代码生成', 79, NULL, 1, 'F', NULL, '#', 'datatable_gen', NULL, '0', 6, '0', 'entfrm', '2020-03-25 15:03:06', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (96, '任务新增', 48, NULL, 1, 'F', NULL, '#', 'job_add', NULL, '0', 1, '0', 'entfrm', '2020-03-26 15:34:44', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (97, '任务编辑', 48, NULL, 1, 'F', NULL, '#', 'job_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-26 15:34:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (98, '任务删除', 48, NULL, 1, 'F', NULL, '#', 'job_del', NULL, '0', 3, '0', 'entfrm', '2020-03-26 15:35:17', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (99, '任务查看', 48, NULL, 1, 'F', NULL, '#', 'job_view', NULL, '0', 4, '0', 'entfrm', '2020-03-26 15:35:32', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (100, '任务暂定', 48, NULL, 1, 'F', NULL, '#', 'job_stop', NULL, '0', 5, '0', 'entfrm', '2020-03-26 15:37:16', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (101, '任务启动', 48, NULL, 1, 'F', NULL, '#', 'job_start', NULL, '0', 6, '0', 'entfrm', '2020-03-26 15:37:35', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (102, '任务重置', 48, NULL, 1, 'F', NULL, '#', 'job_refresh', NULL, '0', 7, '0', 'entfrm', '2020-03-26 15:37:56', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (103, '任务日志查看', 48, NULL, 1, 'F', NULL, '#', 'jobLog_view', NULL, '0', 8, '0', 'entfrm', '2020-03-26 15:38:19', 'entfrm', '2020-03-26 15:38:35', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (104, '任务日志删除', 48, NULL, 1, 'F', NULL, '#', 'jobLog_del', NULL, '0', 9, '0', 'entfrm', '2020-03-26 15:38:51', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (105, '快捷方式新增', 43, NULL, 1, 'F', NULL, '#', 'shortcut_add', NULL, '0', 1, '0', 'entfrm', '2020-03-27 09:44:13', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (106, '快捷方式修改', 43, NULL, 1, 'F', NULL, '#', 'shortcut_edit', NULL, '0', 2, '0', 'entfrm', '2020-03-27 09:44:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (107, '快捷方式删除', 43, NULL, 1, 'F', NULL, '#', 'shortcut_del', NULL, '0', 3, '0', 'entfrm', '2020-03-27 09:44:57', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (108, '快捷方式查看', 43, NULL, 1, 'F', NULL, '#', 'shortcut_view', NULL, '0', 4, '0', 'entfrm', '2020-03-27 09:45:16', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (109, '数据源管理', 3, NULL, 2, 'C', 'dataset', 'toolkit/dataset/index', NULL, 'star', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2021-03-26 22:17:28', '数据源菜单', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (110, '数据源新增', 109, NULL, 1, 'F', NULL, '#', 'dataset_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (111, '数据源修改', 109, NULL, 1, 'F', NULL, '#', 'dataset_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (112, '数据源删除', 109, NULL, 1, 'F', NULL, '#', 'dataset_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (113, '数据源查询', 109, NULL, 1, 'F', NULL, '#', 'dataset_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (114, '数据源导出', 109, NULL, 1, 'F', NULL, '#', 'dataset_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (121, '流程定义', 248, NULL, 1, 'C', 'process', 'flowable/process/index', NULL, 'list', '0', 2, '0', 'entfrm', '2020-04-04 22:33:12', 'entfrm', '2022-09-27 17:01:26', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (122, '模型设计', 85, NULL, 1, 'F', NULL, '#', 'model_design', NULL, '0', 4, '0', 'entfrm', '2020-04-04 22:36:13', NULL, '2022-09-27 17:01:28', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (123, '流程图', 121, NULL, 1, 'F', NULL, '#', 'process_img', NULL, '0', 1, '0', 'entfrm', '2020-04-04 22:49:07', NULL, '2022-09-27 17:01:24', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (124, '流程状态改变', 121, NULL, 1, 'F', NULL, '#', 'process_change', NULL, '0', 2, '0', 'entfrm', '2020-04-04 22:49:46', NULL, '2022-09-27 17:01:22', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (125, '流程删除', 121, NULL, 1, 'F', NULL, '#', 'process_del', NULL, '0', 3, '0', 'entfrm', '2020-04-04 22:50:05', NULL, '2022-09-27 17:01:20', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (126, '流程查看', 121, NULL, 1, 'F', NULL, '#', 'process_view', NULL, '0', 4, '0', 'entfrm', '2020-04-04 22:50:30', 'entfrm', '2022-09-27 17:01:18', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (127, '请假管理', 58, NULL, 1, 'C', 'leave', 'flowable/leave/index', NULL, 'tree-table', '0', 3, '0', 'entfrm', '2020-04-04 22:51:56', 'entfrm', '2022-09-27 17:00:26', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (128, '请假新增', 127, NULL, 1, 'F', NULL, '#', 'leave_add', NULL, '0', 1, '0', 'entfrm', '2020-04-04 22:52:44', NULL, '2022-09-27 17:00:24', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (129, '请假修改', 127, NULL, 1, 'F', NULL, '#', 'leave_edit', NULL, '0', 2, '0', 'entfrm', '2020-04-04 22:53:01', NULL, '2022-09-27 17:00:23', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (130, '请假删除', 127, NULL, 1, 'F', NULL, '#', 'leave_del', NULL, '0', 3, '0', 'entfrm', '2020-04-04 22:53:13', NULL, '2022-09-27 17:00:21', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (131, '请假查看', 127, NULL, 1, 'F', NULL, '#', 'leave_view', NULL, '0', 4, '0', 'entfrm', '2020-04-04 22:53:26', NULL, '2022-09-27 17:00:19', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (132, '请假导出', 127, NULL, 1, 'F', NULL, '#', 'leave_export', NULL, '0', 5, '0', 'entfrm', '2020-04-04 22:53:45', NULL, '2022-09-27 17:00:17', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (133, '待办任务', 247, NULL, 1, 'C', 'task', 'flowable/task/index', NULL, 'checkbox', '0', 1, '0', 'entfrm', '2020-04-04 22:55:03', 'entfrm', '2022-09-27 17:00:38', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (134, '审批', 133, NULL, 1, 'F', NULL, '#', 'task_check', NULL, '0', 1, '0', 'entfrm', '2020-04-04 22:56:31', 'entfrm', '2022-09-27 17:00:35', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (135, '批注', 133, NULL, 1, 'F', NULL, '#', 'task_comment', NULL, '0', 2, '0', 'entfrm', '2020-04-04 22:56:46', 'entfrm', '2022-09-27 17:00:34', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (136, '流程追踪', 133, NULL, 1, 'F', NULL, '#', 'task_track', NULL, '0', 3, '0', 'entfrm', '2020-04-04 22:57:19', 'entfrm', '2022-09-27 17:00:32', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (137, '任务查看', 133, NULL, 1, 'F', NULL, '#', 'task_view', NULL, '0', 4, '0', 'entfrm', '2020-04-04 22:57:19', 'entfrm', '2022-09-27 17:00:31', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (138, '模板新增', 56, NULL, 1, 'F', NULL, '#', 'template_add', NULL, '1', 1, '0', 'entfrm', '2020-04-12 16:28:51', NULL, '2020-12-11 23:10:15', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (139, '应用管理', 1, NULL, 1, 'C', 'application', 'system/application/index', NULL, 'tool', '1', 0, '0', 'entfrm', '2020-04-23 18:35:21', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (140, '应用新增', 139, NULL, 1, 'F', NULL, '#', 'application_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (141, '应用修改', 139, NULL, 1, 'F', NULL, '#', 'application_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (142, '应用删除', 139, NULL, 1, 'F', NULL, '#', 'application_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (143, '应用查询', 139, NULL, 1, 'F', NULL, '#', 'application_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (144, '应用导出', 139, NULL, 1, 'F', NULL, '#', 'application_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (145, 'redis监控', 2, NULL, 1, 'C', 'redis', 'monitor/redis/index', NULL, 'component', '1', 5, '0', 'entfrm', '2020-04-24 22:26:31', 'entfrm', '2020-05-17 16:49:59', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (146, '接口构建', 3, NULL, 2, 'C', 'apiinfo', 'toolkit/apiinfo/index', NULL, 'star', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2021-03-26 21:59:08', '接口菜单', '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (147, '接口新增', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (148, '接口修改', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (149, '接口删除', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (150, '接口查询', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (151, '接口导出', 146, NULL, 1, 'F', NULL, '#', 'apiinfo_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2020-02-02 00:00:00', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (159, '令牌删除', 47, NULL, 1, 'F', NULL, '#', 'token_del', NULL, '1', 1, '0', 'entfrm', '2020-04-21 12:28:59', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (160, '令牌查看', 47, NULL, 1, 'F', NULL, '#', 'token_view', NULL, '1', 2, '0', 'entfrm', '2020-04-21 12:29:19', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (229, '表单管理', 3, NULL, 1, 'C', 'form', 'toolkit/form/index', '', 'build', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:56:09', '表单管理菜单', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (230, '表单管理新增', 229, NULL, 1, 'F', '', '#', 'form_add', '#', '1', 1, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:55:50', '', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (231, '表单管理修改', 229, NULL, 1, 'F', '', '#', 'form_edit', '#', '1', 2, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:55:54', '', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (232, '表单管理删除', 229, NULL, 1, 'F', '', '#', 'form_del', '#', '1', 3, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:55:59', '', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (233, '表单管理查询', 229, NULL, 1, 'F', '', '#', 'form_view', '#', '1', 4, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:56:02', '', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (234, '表单管理导出', 229, NULL, 1, 'F', '', '#', 'form_export', '#', '1', 5, '0', 'entfrm', '2020-02-02 00:00:00', 'entfrm', '2022-09-27 16:56:06', '', '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (235, '表单设计', 229, NULL, 2, 'F', NULL, '#', 'form_design', NULL, '1', 6, '0', 'entfrm', '2021-03-26 23:33:55', NULL, '2022-09-27 16:55:47', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (236, '智能化配置', 0, NULL, 1, 'M', 'intelligent', '#', NULL, 'intelligent', '1', 5, '0', 'entfrm', '2021-03-30 04:58:39', 'entfrm', '2021-03-30 04:58:52', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (237, '控件大管家', 236, NULL, 2, 'C', 'steward', 'intelligent/controlSteward/index', NULL, 'controls', '1', 1, '0', 'entfrm', '2021-03-30 05:07:43', 'entfrm', '2021-03-30 05:08:12', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (238, '表单扩展模板', 236, NULL, 2, 'C', 'formExtend', 'intelligent/formExtend/index', NULL, 'template', '1', 2, '0', 'entfrm', '2021-03-30 05:09:20', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (239, '表单扩展模板查看', 238, NULL, 2, 'F', NULL, '#', 'form_extend_view', NULL, '1', 1, '0', 'entfrm', '2021-03-30 05:10:24', 'entfrm', '2021-03-30 05:11:19', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (240, '表单扩展模板新增', 238, NULL, 1, 'F', NULL, '#', 'form_extend_add', NULL, '1', 2, '0', 'entfrm', '2021-03-30 05:11:07', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (241, '表单扩展模板编辑', 238, NULL, 2, 'F', '表单扩展模板编辑', '#', 'form_extend_edit', NULL, '1', 3, '0', 'entfrm', '2021-03-30 05:11:58', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (242, '表单扩展模板删除', 238, NULL, 2, 'F', NULL, '#', 'form_extend_del', NULL, '1', 4, '0', 'entfrm', '2021-03-30 05:12:18', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (243, '表单集成案例', 236, NULL, 1, 'C', 'demoUser', 'intelligent/demoUser/index', NULL, 'demo', '1', 3, '0', 'entfrm', '2021-03-30 05:13:37', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (244, '设计模板', 238, NULL, 2, 'F', NULL, '#', 'form_extend_design', NULL, '1', 5, '0', 'entfrm', '2021-03-30 05:21:32', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (245, '我发起流程', 58, NULL, 2, 'C', 'iInitiatedProcess', 'activiti/iInitiatedProcess/index', NULL, 'initiate', '1', 0, '0', '小狗', '2021-04-14 19:28:25', '小狗', '2021-05-11 08:59:20', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (246, '表单引擎', 58, NULL, 2, 'C', 'formActivitiEngine', 'activiti/formActivitiEngine/index', NULL, 'form', '1', 0, '0', '小狗', '2021-04-19 23:26:38', '小狗', '2021-05-11 08:59:23', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (247, '我的事务', 58, NULL, 2, 'M', 'affairs', '#', NULL, 'build', '1', 10, '0', 'entfrm', '2021-05-21 19:40:14', 'entfrm', '2022-09-27 17:01:12', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (248, '流程管理', 58, NULL, 2, 'M', 'manage', '#', NULL, 'chart', '1', 20, '0', 'entfrm', '2021-05-21 19:40:49', 'entfrm', '2022-09-27 17:01:39', NULL, '1');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (249, '流程应用', 0, NULL, 1, 'M', 'workflow', '#', NULL, 'workflow', '1', 0, '0', 'entfrm', '2022-09-27 17:09:47', 'entfrm', '2022-09-27 17:10:01', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (250, '我的事务', 249, NULL, 2, 'M', 'transaction', '#', NULL, 'transaction', '1', 10, '0', 'entfrm', '2022-09-27 17:12:13', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (251, '流程管理', 249, NULL, 2, 'M', 'processManage', '#', NULL, 'process-manage', '1', 20, '0', 'entfrm', '2022-09-27 17:13:14', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (252, '流程监控', 249, NULL, 2, 'M', 'processMonit', '#', NULL, 'process-monit', '1', 30, '0', 'entfrm', '2022-09-27 17:13:44', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (253, '流程表单', 249, NULL, 2, 'C', 'flowForm', 'workflow/extension/form/index', NULL, 'flow-form', '1', 40, '0', 'entfrm', '2022-09-27 17:15:02', 'entfrm', '2022-09-27 17:15:13', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (254, '未完成', 252, NULL, 2, 'C', 'undone', 'workflow/workflow/process/runProcess', NULL, 'undone', '1', 10, '0', 'entfrm', '2022-09-27 17:19:11', 'entfrm', '2022-09-27 17:20:05', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (255, '已完成', 252, NULL, 2, 'C', 'done', 'workflow/workflow/process/historyProcess', NULL, 'done', '1', 20, '0', 'entfrm', '2022-09-27 17:21:52', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (256, '流程设计', 251, NULL, 2, 'C', 'processDesign', 'workflow/workflow/model/index', NULL, 'process-design', '1', 10, '0', 'entfrm', '2022-09-27 17:23:03', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (257, '流程表达式', 251, NULL, 2, 'C', 'expression', 'workflow/extension/condition/index', NULL, 'expression', '1', 20, '0', 'entfrm', '2022-09-27 17:25:29', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (258, '常用按钮', 251, NULL, 2, 'C', 'button', 'workflow/extension/button/index', NULL, 'button', '1', 30, '0', 'entfrm', '2022-09-27 17:26:34', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (259, '流程分类', 251, NULL, 2, 'C', 'classification', 'workflow/extension/category/index', NULL, 'classification', '1', 40, '0', 'entfrm', '2022-09-27 17:27:52', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (260, '流程监听器', 251, NULL, 2, 'C', 'listener', 'workflow/extension/listener/index', NULL, 'listener', '1', 50, '0', 'entfrm', '2022-09-27 17:28:57', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (261, '待办任务', 250, NULL, 2, 'C', 'todo', 'workflow/workflow/task/index', NULL, 'todo', '1', 10, '0', 'entfrm', '2022-09-27 17:39:49', 'entfrm', '2022-09-27 19:59:55', NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (262, '已办任务', 250, NULL, 2, 'C', 'doneTodo', 'workflow/workflow/task/historyTask', NULL, 'doneTodo', '1', 20, '0', 'entfrm', '2022-09-27 17:40:36', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (263, '发起流程', 250, NULL, 2, 'C', 'initiate', 'workflow/workflow/process/index', NULL, 'initiate', '1', 30, '0', 'entfrm', '2022-09-27 17:41:32', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (264, '我发起的', 250, NULL, 2, 'C', 'mylnitiation', 'workflow/workflow/process/applyProcess', NULL, 'myInitiation', '1', 40, '0', 'entfrm', '2022-09-27 17:46:27', NULL, NULL, NULL, '0');
INSERT INTO `sys_menu` (`id`, `name`, `parent_id`, `parent_ids`, `application_id`, `type`, `path`, `component`, `perms`, `icon`, `no_cache`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (265, '流程抄送', 250, NULL, 2, 'C', 'cc', 'workflow/extension/workflowCopy/index', NULL, 'cc', '1', 50, '0', 'entfrm', '2022-09-27 17:47:21', NULL, NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志编号',
  `type` varchar(10) DEFAULT '1' COMMENT '日志类型',
  `title` varchar(255) DEFAULT '' COMMENT '日志标题',
  `method` varchar(100) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '方法名称',
  `user_agent` text COMMENT '用户代理',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '操作人员',
  `client_id` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '终端',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(50) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '主机地址',
  `oper_addr` varchar(255) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '操作地点',
  `oper_param` text CHARACTER SET utf8mb4 COMMENT '请求参数',
  `status` int(1) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` text CHARACTER SET utf8mb4 COMMENT '错误消息',
  `execute_time` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '执行时间',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2015 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1806, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-04-23 18:09:06');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1807, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '144', '2021-04-23 18:10:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1808, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B2509%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A2%3A2512%5D', 0, '', '480', '2021-04-23 18:25:43');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1809, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B2509%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A2%3A2512%5D', 0, '', '12', '2021-04-23 18:25:43');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1810, '1', '模型新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-04-30 05:10:37');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1811, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/deploy/57e42acd-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '763', '2021-04-30 05:14:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1812, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '5565', '2021-04-30 05:15:11');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1813, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 0, '', '177', '2021-04-30 05:15:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1814, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5Bd90ac240-a92f-11eb-b215-00ff08753f51%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A1%3Adb953db3-a92f-11eb-b215-00ff08753f51%5D', 0, '', '4060', '2021-04-30 05:15:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1815, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5Bd90ac240-a92f-11eb-b215-00ff08753f51%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A1%3Adb953db3-a92f-11eb-b215-00ff08753f51%5D', 0, '', '115', '2021-04-30 05:15:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1816, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/deploy/57e42acd-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '7', '2021-04-30 05:36:22');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1817, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '881', '2021-04-30 05:39:43');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1818, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/2', '127.0.0.1', 'XX XX', '', 0, '', '76', '2021-04-30 05:39:45');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1819, '1', '任务审批', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/task/checkTask', '127.0.0.1', 'XX XX', '', 0, '', '915', '2021-04-30 05:45:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1820, '1', '任务审批', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.27 Safari/537.36', '小可爱', 'entfrm', '/activiti/task/checkTask', '127.0.0.1', 'XX XX', '', 0, '', '795', '2021-04-30 05:50:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1821, '1', '流程追踪图片获取', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/6a04d5ed-a933-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '1014', '2021-04-30 06:04:03');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1822, '1', '流程追踪图片获取', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '125', '2021-04-30 06:04:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1823, '1', '流程追踪图片获取', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fd721074-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '9', '2021-04-30 06:05:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1824, '1', '流程追踪图片获取', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fd721074-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '121', '2021-04-30 06:20:17');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1825, '1', '流程追踪图片获取', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fd721074-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '873906', '2021-04-30 06:20:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1826, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fda57c8d-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-04-30 07:54:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1827, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fda57c8d-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '2252', '2021-04-30 07:54:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1828, '1', '任务审批意见', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/task/commitList/fda57c8d-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '214', '2021-04-30 07:54:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1829, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fda57c8d-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '8', '2021-04-30 07:58:04');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1830, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/fda57c8d-a92f-11eb-b215-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '288', '2021-04-30 07:58:04');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1831, '1', '用户头像修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/user/updateAvatar', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-01 23:01:39');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1832, '1', '用户信息修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/user/updateProfile', '127.0.0.1', 'XX XX', '', 0, '', '639', '2021-05-01 23:01:44');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1833, '1', '用户头像修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/user/updateAvatar', '127.0.0.1', 'XX XX', '', 0, '', '72', '2021-05-01 23:02:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1834, '1', '模型新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-08 04:17:35');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1835, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/deploy/2502', '127.0.0.1', 'XX XX', '', 0, '', '880', '2021-05-08 04:19:23');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1836, '1', '用户头像修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/user/updateAvatar', '127.0.0.1', 'XX XX', '', 0, '', '2383', '2021-05-08 04:20:19');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1837, '1', '用户信息修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/user/updateProfile', '127.0.0.1', 'XX XX', '', 0, '', '116', '2021-05-08 04:20:21');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1838, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '64', '2021-05-08 04:21:00');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1839, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/3', '127.0.0.1', 'XX XX', '', 0, '', '217', '2021-05-08 04:21:03');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1840, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/deploy/2502', '127.0.0.1', 'XX XX', '', 0, '', '665', '2021-05-08 04:47:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1841, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '832', '2021-05-08 04:48:15');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1842, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/4', '127.0.0.1', 'XX XX', '', 0, '', '82', '2021-05-08 04:48:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1843, '1', '任务审批', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/task/checkTask', '127.0.0.1', 'XX XX', '', 0, '', '1003', '2021-05-08 04:48:43');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1844, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '611', '2021-05-08 04:49:19');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1845, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '266', '2021-05-08 04:50:50');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1846, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '225', '2021-05-08 04:52:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1847, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '425', '2021-05-08 04:54:49');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1848, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '59', '2021-05-08 04:55:27');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1849, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '162', '2021-05-08 05:02:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1850, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '108', '2021-05-08 05:02:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1851, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '56', '2021-05-08 05:21:09');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1852, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-08 05:30:09');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1853, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '443', '2021-05-08 05:40:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1854, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-08 09:00:43');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1855, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '95', '2021-05-08 09:03:50');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1856, '1', '任务追踪', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/task/track/2516', '127.0.0.1', 'XX XX', '', 0, '', '41', '2021-05-08 09:04:39');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1857, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/menu/remove/245', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-11 08:58:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1858, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '76', '2021-05-11 08:58:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1859, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/menu/remove/245', '127.0.0.1', 'XX XX', '', 0, '', '2618', '2021-05-11 08:59:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1860, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/system/menu/remove/246', '127.0.0.1', 'XX XX', '', 0, '', '75', '2021-05-11 08:59:23');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1861, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B2517%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A2%3A2519%5D', 1, 'resourceName is null', '86', '2021-05-11 08:59:36');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1862, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B2517%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A2%3A2519%5D', 1, 'resourceName is null', '86', '2021-05-11 09:01:21');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1863, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B2517%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A2%3A2519%5D', 1, 'resourceName is null', '86', '2021-05-11 09:13:40');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1864, '1', '模型删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/remove/2502', '127.0.0.1', 'XX XX', '', 0, '', '86', '2021-05-11 09:13:42');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1865, '1', '模型新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/save', '127.0.0.1', 'XX XX', '', 0, '', '1285', '2021-05-11 09:14:08');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1866, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/model/deploy/27502', '127.0.0.1', 'XX XX', '', 0, '', '534', '2021-05-11 09:16:29');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1867, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B27505%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A3%3A27507%5D', 1, 'resourceName is null', '4294', '2021-05-11 09:16:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1868, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B27505%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A3%3A27507%5D', 0, '', '0', '2021-05-11 09:42:03');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1869, '1', '读取资源', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'anonymousUser', NULL, '/activiti/process/resource', '127.0.0.1', 'XX XX', 'procInsId=%5B27505%5D&resType=%5Bimage%5D&procDefId=%5BLeave%3A3%3A27507%5D', 0, '', '2777', '2021-05-11 09:43:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1870, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '36', '2021-05-11 09:43:59');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1871, '1', '启动请假流程', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess', '127.0.0.1', 'XX XX', '', 0, '', '117', '2021-05-11 09:44:02');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1872, '1', '表单新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/toolkit/form/save', '127.0.0.1', 'XX XX', '', 0, '', '886', '2021-05-11 09:56:13');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1873, '1', '表单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/toolkit/form/update', '127.0.0.1', 'XX XX', '', 0, '', '49', '2021-05-11 10:00:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1874, '1', '表单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/toolkit/form/update', '127.0.0.1', 'XX XX', '', 0, '', '2802', '2021-05-11 10:02:59');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1875, '1', '表单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/toolkit/form/update', '127.0.0.1', 'XX XX', '', 0, '', '157', '2021-05-11 10:04:06');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1876, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-11 10:29:08');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1877, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/6', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-11 10:31:22');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1878, '1', '表单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/toolkit/form/update', '127.0.0.1', 'XX XX', '', 0, '', '17570', '2021-05-11 10:59:27');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1879, '1', '任务审批', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/task/checkTask', '127.0.0.1', 'XX XX', '', 0, '', '131', '2021-05-11 11:00:56');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1880, '1', '任务审批', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.38 Safari/537.36', '小可爱', 'entfrm', '/activiti/task/checkTask', '127.0.0.1', 'XX XX', '', 0, '', '478', '2021-05-11 11:01:53');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1881, '1', '字典修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dict/update', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-12 01:36:24');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1882, '1', '字典删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dict/remove/14', '127.0.0.1', 'XX XX', '', 0, '', '237', '2021-05-12 01:37:16');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1883, '1', '字典新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dict/save', '127.0.0.1', 'XX XX', '', 0, '', '140', '2021-05-12 01:37:30');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1884, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '140', '2021-05-12 01:37:45');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1885, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '124', '2021-05-12 01:38:50');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1886, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '152', '2021-05-12 01:38:59');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1887, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '146', '2021-05-12 01:39:07');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1888, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '133', '2021-05-12 01:39:14');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1889, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '123', '2021-05-12 01:39:21');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1890, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '176', '2021-05-12 01:39:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1891, '1', '字典数据新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/save', '127.0.0.1', 'XX XX', '', 0, '', '150', '2021-05-12 01:39:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1892, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '70', '2021-05-12 01:40:06');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1893, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '62', '2021-05-12 01:40:12');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1894, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '58', '2021-05-12 01:40:16');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1895, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '126', '2021-05-12 01:40:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1896, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '146', '2021-05-12 01:40:25');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1897, '1', '字典数据修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', 'entfrm', 'entfrm', '/system/dictData/update', '127.0.0.1', 'XX XX', '', 0, '', '45', '2021-05-12 01:40:29');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1898, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/6', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-12 02:40:55');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1899, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36', '小狗', 'entfrm', '/activiti/leave/startProcess/5', '127.0.0.1', 'XX XX', '', 0, '', '766', '2021-05-12 02:41:02');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1900, '1', '用户头像修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/user/updateAvatar', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-14 06:48:46');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1901, '1', '用户信息修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/user/updateProfile', '127.0.0.1', 'XX XX', '', 0, '', '245', '2021-05-14 06:55:49');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1902, '1', '模型新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/model/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 16:24:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1903, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/model/deploy/f7518d24-ba0d-11eb-ba55-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 17:08:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1904, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/model/deploy/f7518d24-ba0d-11eb-ba55-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 18:02:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1905, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 19:40:14');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1906, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '482', '2021-05-21 19:40:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1907, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '96', '2021-05-21 19:41:30');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1908, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '172', '2021-05-21 19:41:59');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1909, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '141', '2021-05-21 19:42:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1910, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '104', '2021-05-21 19:43:04');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1911, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '82', '2021-05-21 19:43:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1912, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '114', '2021-05-21 19:43:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1913, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '125', '2021-05-21 19:44:09');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1914, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '445', '2021-05-21 19:44:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1915, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '504', '2021-05-21 19:45:39');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1916, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '57', '2021-05-21 19:49:05');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1917, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '215', '2021-05-21 19:49:13');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1918, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '118', '2021-05-21 19:56:03');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1919, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '140', '2021-05-21 19:56:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1920, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '73', '2021-05-21 19:56:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1921, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '41', '2021-05-21 19:56:54');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1922, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '133', '2021-05-21 19:57:03');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1923, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '127', '2021-05-21 19:57:13');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1924, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '149', '2021-05-21 19:59:17');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1925, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\r\n### The error may exist in file [C:\\Users\\LENOVO\\Desktop\\openSource\\entfrm\\entfrm-boot\\entfrm-biz\\entfrm-flowable\\target\\classes\\mapper\\flowable\\FlowMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE act_leave SET             proc_ins_id = ?         WHERE id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\n; Data truncation: Data too long for column \'proc_ins_id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1', '40', '2021-05-21 20:13:38');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1926, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\r\n### The error may exist in file [C:\\Users\\LENOVO\\Desktop\\openSource\\entfrm\\entfrm-boot\\entfrm-biz\\entfrm-flowable\\target\\classes\\mapper\\flowable\\FlowMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE act_leave SET             proc_ins_id = ?         WHERE id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\n; Data truncation: Data too long for column \'proc_ins_id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1', '40', '2021-05-21 20:15:36');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1927, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\r\n### The error may exist in file [C:\\Users\\LENOVO\\Desktop\\openSource\\entfrm\\entfrm-boot\\entfrm-biz\\entfrm-flowable\\target\\classes\\mapper\\flowable\\FlowMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE act_leave SET             proc_ins_id = ?         WHERE id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\n; Data truncation: Data too long for column \'proc_ins_id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1', '40', '2021-05-21 20:18:12');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1928, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\r\n### The error may exist in file [C:\\Users\\LENOVO\\Desktop\\openSource\\entfrm\\entfrm-boot\\entfrm-biz\\entfrm-flowable\\target\\classes\\mapper\\flowable\\FlowMapper.xml]\r\n### The error may involve defaultParameterMap\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE act_leave SET             proc_ins_id = ?         WHERE id = ?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1\n; Data truncation: Data too long for column \'proc_ins_id\' at row 1; nested exception is com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'proc_ins_id\' at row 1', '40', '2021-05-21 20:20:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1929, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 0, '', '40', '2021-05-21 20:22:56');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1930, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/1', '127.0.0.1', 'XX XX', '', 0, '', '143357', '2021-05-21 20:23:19');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1931, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/2', '127.0.0.1', 'XX XX', '', 0, '', '9644', '2021-05-21 20:46:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1932, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/3', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 20:49:54');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1933, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/4', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 20:57:04');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1934, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/5', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 21:23:40');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1935, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.69 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/6', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 21:49:58');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1936, '1', '模型部署', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/model/deploy/f7518d24-ba0d-11eb-ba55-00ff08753f51', '127.0.0.1', 'XX XX', '', 0, '', '826', '2021-05-21 22:15:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1937, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '6962', '2021-05-21 22:16:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1938, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/startProcess/7', '127.0.0.1', 'XX XX', '', 0, '', '246', '2021-05-21 22:16:15');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1939, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 23:00:42');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1940, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/8', '127.0.0.1', 'XX XX', '', 0, '', '169', '2021-05-21 23:00:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1941, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/8', '127.0.0.1', 'XX XX', '', 0, '', '894', '2021-05-21 23:15:58');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1942, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/8', '127.0.0.1', 'XX XX', '', 0, '', '1127', '2021-05-21 23:17:53');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1943, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/8', '127.0.0.1', 'XX XX', '', 0, '', '835', '2021-05-21 23:20:57');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1944, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/8', '127.0.0.1', 'XX XX', '', 0, '', '980', '2021-05-21 23:22:58');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1945, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '581', '2021-05-21 23:25:34');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1946, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/9', '127.0.0.1', 'XX XX', '', 0, '', '78', '2021-05-21 23:25:38');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1947, '1', '启动请假流程', 'GET', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', '小狗', 'entfrm', '/flowable/leave/startProcess/9', '127.0.0.1', 'XX XX', '', 0, '', '1084', '2021-05-21 23:25:53');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1948, '1', '请假新增', 'POST', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/save', '127.0.0.1', 'XX XX', '', 0, '', '797', '2021-05-21 23:30:21');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1949, '1', '请假修改 ', 'PUT', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/update', '127.0.0.1', 'XX XX', '', 0, '', '104', '2021-05-21 23:30:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1950, '1', '请假删除', 'DELETE', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36', 'entfrm', 'entfrm', '/flowable/leave/remove/10', '127.0.0.1', 'XX XX', '', 0, '', '0', '2021-05-21 23:33:46');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1951, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/230', '127.0.0.1', 'XX XX', '', 0, '', '0', '2022-09-27 16:55:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1952, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '12', '2022-09-27 16:55:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1953, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/235', '127.0.0.1', 'XX XX', '', 0, '', '128', '2022-09-27 16:55:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1954, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/230', '127.0.0.1', 'XX XX', '', 0, '', '9', '2022-09-27 16:55:50');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1955, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/231', '127.0.0.1', 'XX XX', '', 0, '', '11', '2022-09-27 16:55:54');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1956, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/229', '127.0.0.1', 'XX XX', '', 0, '', '49', '2022-09-27 16:55:56');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1957, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/232', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 16:55:59');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1958, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/233', '127.0.0.1', 'XX XX', '', 0, '', '32', '2022-09-27 16:56:02');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1959, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/234', '127.0.0.1', 'XX XX', '', 0, '', '45', '2022-09-27 16:56:06');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1960, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/229', '127.0.0.1', 'XX XX', '', 0, '', '47', '2022-09-27 16:56:09');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1961, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/126', '127.0.0.1', 'XX XX', '', 0, '', '46', '2022-09-27 16:59:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1962, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 16:59:56');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1963, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/132', '127.0.0.1', 'XX XX', '', 0, '', '71', '2022-09-27 17:00:17');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1964, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/131', '127.0.0.1', 'XX XX', '', 0, '', '47', '2022-09-27 17:00:19');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1965, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/130', '127.0.0.1', 'XX XX', '', 0, '', '8', '2022-09-27 17:00:21');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1966, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/129', '127.0.0.1', 'XX XX', '', 0, '', '7', '2022-09-27 17:00:23');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1967, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/128', '127.0.0.1', 'XX XX', '', 0, '', '47', '2022-09-27 17:00:24');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1968, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/127', '127.0.0.1', 'XX XX', '', 0, '', '9', '2022-09-27 17:00:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1969, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/137', '127.0.0.1', 'XX XX', '', 0, '', '26', '2022-09-27 17:00:31');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1970, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/136', '127.0.0.1', 'XX XX', '', 0, '', '6', '2022-09-27 17:00:32');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1971, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/135', '127.0.0.1', 'XX XX', '', 0, '', '11', '2022-09-27 17:00:34');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1972, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/134', '127.0.0.1', 'XX XX', '', 0, '', '7', '2022-09-27 17:00:35');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1973, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/133', '127.0.0.1', 'XX XX', '', 0, '', '46', '2022-09-27 17:00:38');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1974, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/247', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 17:01:12');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1975, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/126', '127.0.0.1', 'XX XX', '', 0, '', '7', '2022-09-27 17:01:18');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1976, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/125', '127.0.0.1', 'XX XX', '', 0, '', '47', '2022-09-27 17:01:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1977, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/124', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 17:01:22');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1978, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/123', '127.0.0.1', 'XX XX', '', 0, '', '26', '2022-09-27 17:01:24');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1979, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/121', '127.0.0.1', 'XX XX', '', 0, '', '7', '2022-09-27 17:01:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1980, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/122', '127.0.0.1', 'XX XX', '', 0, '', '45', '2022-09-27 17:01:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1981, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/87', '127.0.0.1', 'XX XX', '', 0, '', '48', '2022-09-27 17:01:30');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1982, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/86', '127.0.0.1', 'XX XX', '', 0, '', '8', '2022-09-27 17:01:32');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1983, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/88', '127.0.0.1', 'XX XX', '', 0, '', '6', '2022-09-27 17:01:33');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1984, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/89', '127.0.0.1', 'XX XX', '', 0, '', '6', '2022-09-27 17:01:35');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1985, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/85', '127.0.0.1', 'XX XX', '', 0, '', '8', '2022-09-27 17:01:37');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1986, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/248', '127.0.0.1', 'XX XX', '', 0, '', '8', '2022-09-27 17:01:39');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1987, '1', '菜单删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/remove/58', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 17:01:41');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1988, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '0', '2022-09-27 17:09:47');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1989, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '10', '2022-09-27 17:10:01');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1990, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 17:12:12');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1991, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '21', '2022-09-27 17:13:13');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1992, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '45', '2022-09-27 17:13:44');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1993, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:15:01');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1994, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '5', '2022-09-27 17:15:13');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1995, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '34', '2022-09-27 17:19:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1996, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '40', '2022-09-27 17:20:05');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1997, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:21:52');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1998, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '2', '2022-09-27 17:23:02');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (1999, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:25:29');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2000, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:26:33');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2001, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '45', '2022-09-27 17:27:52');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2002, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:28:56');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2003, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '2', '2022-09-27 17:39:48');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2004, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '4', '2022-09-27 17:40:35');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2005, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 17:41:32');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2006, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '2', '2022-09-27 17:46:26');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2007, '1', '菜单新增', 'POST', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/save', '127.0.0.1', 'XX XX', '', 0, '', '39', '2022-09-27 17:47:20');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2008, '1', '角色修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/role/update', '127.0.0.1', 'XX XX', '', 0, '', '44', '2022-09-27 17:47:28');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2009, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '0', '2022-09-27 19:59:54');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2010, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '49', '2022-09-27 20:02:51');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2011, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '43', '2022-09-27 20:03:10');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2012, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '43', '2022-09-27 20:03:35');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2013, '1', '菜单修改', 'PUT', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/menu/update', '127.0.0.1', 'XX XX', '', 0, '', '44', '2022-09-27 20:04:05');
INSERT INTO `sys_oper_log` (`id`, `type`, `title`, `method`, `user_agent`, `oper_name`, `client_id`, `oper_url`, `oper_ip`, `oper_addr`, `oper_param`, `status`, `error_msg`, `execute_time`, `oper_time`) VALUES (2014, '1', '应用删除', 'DELETE', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'entfrm', 'entfrm', '/system/application/remove/2', '127.0.0.1', 'XX XX', '', 0, '', '3', '2022-09-27 20:04:43');
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '角色代码',
  `applications` varchar(255) DEFAULT NULL COMMENT '所属应用',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '2' COMMENT '数据权限范围',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `create_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '删除标识（0-正常,1-删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` (`id`, `name`, `code`, `applications`, `data_scope`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '管理员', 'admin', 'app1,app2', '1', 1, '0', 'entfrm', '2020-03-13 20:54:34', 'entfrm', '2020-08-02 21:44:58', NULL, '0');
INSERT INTO `sys_role` (`id`, `name`, `code`, `applications`, `data_scope`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '测试角色', 'test', 'app1', '2', 1, '0', 'entfrm', '2020-03-14 18:15:51', 'entfrm', '2020-08-02 21:44:57', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `dept_id` int(11) NOT NULL COMMENT '部门ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_dept` (`role_id`, `dept_id`) VALUES (2, 2);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 11);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 16);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 7);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 25);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 26);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 27);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 28);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 33);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 78);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 81);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 82);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 83);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 84);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 79);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 90);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 91);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 92);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 93);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 94);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 95);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 55);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 57);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 4);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 5);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 29);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (2, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (3, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 249);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 250);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 261);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 262);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 263);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 264);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 265);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 251);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 256);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 257);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 258);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 259);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 260);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 252);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 254);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 255);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 253);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 1);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 139);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 140);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 141);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 142);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 143);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 144);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 4);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 8);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 9);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 10);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 11);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 12);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 5);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 13);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 14);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 15);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 16);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 17);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 6);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 18);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 19);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 20);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 21);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 22);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 23);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 24);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 7);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 25);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 26);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 27);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 28);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 29);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 30);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 31);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 32);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 33);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 34);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 35);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 36);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 37);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 38);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 39);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 40);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 41);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 42);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 43);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 105);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 106);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 107);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 108);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 44);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 73);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 74);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 75);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 76);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 77);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 45);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 59);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 60);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 61);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 62);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 46);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 69);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 70);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 71);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 72);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 2);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 47);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 159);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 160);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 48);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 96);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 97);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 98);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 99);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 100);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 101);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 102);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 103);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 104);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 49);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 50);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 145);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 51);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 52);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 53);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 63);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 64);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 65);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 54);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 66);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 67);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 68);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 3);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 78);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 81);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 82);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 83);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 84);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 79);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 90);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 91);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 92);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 93);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 94);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 95);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 109);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 110);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 111);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 112);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 113);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 114);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 55);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 146);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 147);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 148);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 149);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 150);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 151);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 236);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 237);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 238);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 239);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 240);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 241);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 242);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 244);
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) VALUES (1, 243);
COMMIT;

-- ----------------------------
-- Table structure for sys_shortcut
-- ----------------------------
DROP TABLE IF EXISTS `sys_shortcut`;
CREATE TABLE `sys_shortcut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL COMMENT '名称',
  `region` varchar(20) DEFAULT NULL COMMENT '区域',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `bg_color` varchar(10) DEFAULT '#409EFF' COMMENT '背景颜色',
  `path` varchar(120) DEFAULT NULL COMMENT '路径',
  `sort` int(11) DEFAULT NULL COMMENT '顺序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_shortcut
-- ----------------------------
BEGIN;
INSERT INTO `sys_shortcut` (`id`, `name`, `region`, `icon`, `bg_color`, `path`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, '登录日志', '2', 'form', '#2883CD', 'monitor/log/loginLog', 1, 'entfrm', '2020-03-27 10:09:11', '', '2020-03-27 10:12:39', '1', '0');
INSERT INTO `sys_shortcut` (`id`, `name`, `region`, `icon`, `bg_color`, `path`, `sort`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, '内容管理', '2', 'edit', '#EB7024', '/cms/article', 2, 'entfrm', '2020-04-15 22:44:58', '', '2020-06-02 08:59:06', NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `nick_name` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `dept_id` int(11) DEFAULT NULL COMMENT '机构ID',
  `dept_name` varchar(120) DEFAULT NULL COMMENT '机构名称',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `qq` varchar(30) DEFAULT NULL COMMENT 'QQ',
  `phone` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(50) DEFAULT '' COMMENT '最后登陆IP',
  `login_time` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(500) DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (1, 'entfrm', '管理员', '00', '$2a$10$N0EAFRVjSYipHK/HDqzuEuVJZBabVTD7Z.NrXrnas984.1wjkaLK.', 1, '重庆总公司', '111@qq.com', NULL, '15611111111', '0', '/profile/avatar/avatar1620946126129.png', '0', '', NULL, 'entfrm', '2020-03-13 20:56:44', '', NULL, '全栈工程师', '0');
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (2, 'test', '测试01', '00', '$2a$10$Yq7NRB8VO4n1AxcThlwJweM1WE8fwvFRl0krQkNihGxiCRW/Gfp/.', 1, '重庆总公司', '', NULL, '', '0', '', '0', '', NULL, 'entfrm', '2020-03-14 18:14:11', '', NULL, NULL, '1');
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (7, '小猫', '小猫', '00', '$2a$10$algx6IS1lUK6sQX6OakbVOq7dXrShIr2IMrEh8JguRw7VhDy5FwBS', 1, '', '1827945911@qq.com', NULL, '13272461811', '0', '', '0', '', NULL, 'entfrm', '2021-04-04 17:24:07', '', '2021-04-04 17:24:17', NULL, '0');
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (8, '小可爱', '小可爱', '00', '$2a$10$/ofeR7BxtYaRkmuU6S4Jq.lJ.lLUTN3UPYULqbhcYiOkcQcUQur3q', 1, '', '1827945911@qq.com', NULL, '13272461811', '0', '', '0', '', NULL, 'entfrm', '2021-04-04 17:25:02', '', NULL, NULL, '0');
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (9, '小狗', '小狗', '00', '$2a$10$W3qfJHogHT3NHtLbasw6gO9iNADkJWsrbczvgNb8H09rhLXAzGA5i', 1, '', '1827945911@qq.com', NULL, '13272461811', '0', '/profile/avatar/avatar1620418819379.png', '0', '', NULL, 'entfrm', '2021-04-04 17:27:49', '', NULL, NULL, '0');
INSERT INTO `sys_user` (`id`, `user_name`, `nick_name`, `type`, `password`, `dept_id`, `dept_name`, `email`, `qq`, `phone`, `sex`, `avatar`, `status`, `login_ip`, `login_time`, `create_by`, `create_time`, `update_by`, `update_time`, `remarks`, `del_flag`) VALUES (10, '小猪', '小猪', '00', '$2a$10$iLAi75SNyPu5BPFhHk6Os.QyCdl7EqrOpHIOgPlmr3f89EHFK/pRi', 1, '', '1827945911@qq.com', NULL, '13272461811', '0', '', '0', '', NULL, 'entfrm', '2021-04-04 17:28:34', '', NULL, NULL, '0');
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (2, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (4, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (3, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (5, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (8, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (9, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (3, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (4, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (5, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (6, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (7, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (8, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (9, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (10, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
