package com.entfrm.biz.workflow.enums;

import lombok.Getter;

/**
 *<p>
 * 扩展流程信息
 * 通过评论存储自定义的流程字段
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
public enum ExtendMessage {

    // 预设活动审核操作扩展信息
    ACTIVITY_BEGIN("开始", "_workflow_activity_start", "primary"),
    ACTIVITY_END("结束", "_workflow_activity_end", "primary"),
    ACTIVITY_SAVE("暂存", "_workflow_activity_save", "primary"),
    ACTIVITY_AGREE("同意", "_workflow_activity_agree", "success"),
    ACTIVITY_REJECT("驳回", "_workflow_activity_reject", "danger"),
    ACTIVITY_ROLL_BACK("指定回退", "_workflow_activity_roll_back", "danger"),
    ACTIVITY_ADD_MULTI_INSTANCE("加签", "_workflow_activity_add_multi_instance", "primary"),
    ACTIVITY_DEL_MULTI_INSTANCE("减签", "_workflow_activity_del_multi_instance", "primary"),
    ACTIVITY_TRANSFER("转办", "_workflow_activity_transfer", "primary"),
    ACTIVITY_DELEGATE("委派", "_workflow_activity_delegate", "primary"),
    ACTIVITY_STOP("终止", "_workflow_activity_stop", "info"),
    ACTIVITY_PRINT("打印", "_workflow_activity_print", "primary"),
    ACTIVITY_COMMIT("提交", "_workflow_activity_commit", "success"),
    ACTIVITY_AUDIT("审批", "_workflow_activity_audit", "success"),
    ACTIVITY_ADD_BEFORE_MULTI_INSTANCE("前加签", "_workflow_activity_before_add_multi_instance", "primary"),
    ACTIVITY_ADD_AFTER_MULTI_INSTANCE("后加签", "_workflow_activity_after_add_multi_instance", "primary"),

    // 预设流程操作扩展信息
    PROCESS_SUSPENDED("已挂起", "_workflow_process_suspended", "danger"),
    PROCESS_WAITING("等待审核", "_workflow_process_waiting", "primary"),
    PROCESS_AGREE("审核通过", "_workflow_process_agree", "success"),
    PROCESS_REVOKE("流程撤回", "_workflow_process_revoke", "warning"),
    PROCESS_REJECT("审核驳回", "_workflow_process_reject", "danger"),
    PROCESS_STOP("审核终止", "_workflow_process_stop", "info"),
    PROCESS_DELETED("流程作废", "_workflow_process_deleted", "danger"),
    PROCESS_RECOMMIT("重新提交", "_workflow_process_recommit", "warning");

    /** 操作名称 */
    @Getter
    private String mesName;

    /** 操作编码,用于控制在前台流程实例状态 */
    @Getter
    private String mesCode;

    /** 操作级别,用于控制在前台显示的颜色 */
    @Getter
    private String mesLevel;

    ExtendMessage(String mesName, String mesCode, String mesLevel) {
        this.mesName = mesName;
        this.mesCode = mesCode;
        this.mesLevel = mesLevel;
    }

    public static String getMesName(String mesCode) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getMesCode().equals (mesCode)) {
                return extendMessage.getMesName();
            }
        }
        return null;
    }

    public static String getMesLevel(String mesCode) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getMesCode().equals(mesCode)) {
                return extendMessage.getMesLevel();
            }
        }
        // 如果不存在返回 primary
        return "primary";
    }

    public static ExtendMessage getExtendMessage(String mesCode) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getMesCode().equals(mesCode)) {
                return extendMessage;
            }
        }
        return null;
    }
}
