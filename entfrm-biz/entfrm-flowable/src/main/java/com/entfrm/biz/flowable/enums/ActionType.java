package com.entfrm.biz.flowable.enums;

/**
 *<p>
 * 活动流程实例操作枚举
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
public enum ActionType {


    BEGIN("开始", "_flow_start", "primary"),
    END("结束", "_flow_end", "primary"),
    STOP("终止", "_flow_stop", "info"),
    SAVE("暂存", "_flow_save", "primary"),
    AGREE("同意", "_flow_agree", "success"),
    REJECT("驳回", "_flow_reject", "danger"),
    COMMIT("提交", "_flow_commit", "success"),
    Audit("审批", "_flow_audit", "success"),
    WAITING("等待审核", "_flow_waiting", "primary"),
    RECOMMIT("重新提交", "_flow_recommit", "warning"),
    DELETED("作废流程", "_flow_delete", "danger"),
    REVOKE("撤销流程", "_flow_revoke", "warning");


    /** 评论描述 */
    private String status;

    /** 编码 */
    private String type;

    /** 描述级别 */
    private String level;


    //构造方法
    ActionType(String status, String type, String level) {
        this.type = type;
        this.status = status;
        this.level = level;
    }


    //普通方法
    public static String getStatus(String type) {
        for (ActionType c : ActionType.values()) {
            if (c.getType ().equals (type)) {
                return c.status;
            }
        }
        return null;
    }

    //普通方法
    public static String getLevel(String type) {
        for (ActionType c : ActionType.values()) {
            if (c.getType ().equals (type)) {
                return c.level;
            }
        }
        //如果不存在返回 primary
        return "primary";
    }

    public static ActionType value(String type) {
        for (ActionType c : ActionType.values()) {
            if (c.getType ().equals (type)) {
                return c;
            }
        }
        return null;
    }


    //get set 方法
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }



}
