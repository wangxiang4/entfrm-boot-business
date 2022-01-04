package com.entfrm.biz.workflow.constant;

/**
 * <p>
 * 工作流常量
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-12
 */
public interface WorkflowConstant {

    /** 流程状态码 */
    String PROCESS_STATUS_CODE = "_process_status_code";

    /** 流程发起人变量(用户ID) */
    String INITIATOR = "applyUserId";

    /** 流程执行人 */
    String USERNAME = "userName";

    /** 流程标题 */
    String TITLE = "title";

    /** 扩展流程信息分割标识 */
    String EXTEND_MESSAGE = "_EXTEND_MESSAGE_";

    /** 可以并行处理的网关开始定义后缀 */
    String SPECIAL_GATEWAY_BEGIN_SUFFIX = "_begin";

    /** 可以并行处理的网关结束定义后缀 */
    String SPECIAL_GATEWAY_END_SUFFIX = "_end";

    /** 开始事件标签 */
    String START_EVENT_LABEL = "开始";

    /** 开始事件操作备注 */
    String START_EVENT_COMMENT = "发起流程";

    /** 结束事件标签 */
    String END_EVENT_LABEL = "结束";

    /** 结束事件操作备注 */
    String END_EVENT_COMMENT= "结束流程";

    /** 系统操作备注 */
    String SYSTEM_EVENT_COMMENT= "系统执行";

    /** 等待操作备注 */
    String WAITING_EVENT_COMMENT= "等待审核";

    /** 后加签 */
    String AFTER_ADD_SIGN = "after";

    /** 前加签 */
    String BEFORE_ADD_SIGN = "before";

    /** 任务操作备注前缀 */
    String COMMENT_TYPE_PREFIX = "COMMENT_";

}
