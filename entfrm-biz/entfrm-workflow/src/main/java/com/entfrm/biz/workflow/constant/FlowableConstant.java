package com.entfrm.biz.workflow.constant;

/**
 * <p>
 * 流程通用常量
 * 后续有功能变化可填写新常量
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-12
 */
public class FlowableConstant {

    /** 流程状态码 */
    public final static String PROCESS_STATUS_CODE = "_process_status_code";

    /** 流程发起人变量(用户ID) */
    public final static String INITIATOR = "applyUserId";

    /** 流程执行人 */
    public final static String USERNAME = "userName";

    /** 流程标题 */
    public final static String TITLE = "title";

    /** 流程实例操作标识 */
    public final static String FLOW_ACTION = "_FLOW_ACTION_";

    /** 可以并行处理的网关开始定义后缀 */
    public final static String SPECIAL_GATEWAY_BEGIN_SUFFIX = "_begin";

    /** 可以并行处理的网关结束定义后缀 */
    public final static String SPECIAL_GATEWAY_END_SUFFIX = "_end";

    /** 开始事件标签 */
    public final static String START_EVENT_LABEL = "开始";

    /** 开始事件操作备注 */
    public final static String START_EVENT_COMMENT = "发起流程";

    /** 结束事件标签 */
    public final static String END_EVENT_LABEL = "结束";

    /** 结束事件操作备注 */
    public final static String END_EVENT_COMMENT= "结束流程";

    /** 系统操作备注 */
    public final static String SYSTEM_EVENT_COMMENT= "系统执行";

    /** 等待操作备注 */
    public final static String WAITING_EVENT_COMMENT= "等待审核";

    /** 后加签 */
    public static final String AFTER_ADD_SIGN = "after";

    /** 前加签 */
    public static final String BEFORE_ADD_SIGN = "before";

    //TODO

}
