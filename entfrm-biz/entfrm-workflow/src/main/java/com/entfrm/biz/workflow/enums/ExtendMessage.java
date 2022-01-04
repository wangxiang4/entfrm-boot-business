package com.entfrm.biz.workflow.enums;

import lombok.Getter;
import lombok.Setter;

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

    // 预设任务审核操作扩展信息
    TASK_BEGIN("开始", "_workflow_task_start", "primary"),
    TASK_END("结束", "_workflow_task_end", "primary"),
    TASK_SAVE("暂存", "_workflow_task_save", "primary"),
    TASK_AGREE("同意", "_workflow_task_agree", "success"),
    TASK_REJECT("驳回", "_workflow_task_reject", "danger"),
    TASK_ROLL_BACK("指定回退", "_workflow_task_roll_back", "danger"),
    TASK_ADD_MULTI_INSTANCE("加签", "_workflow_task_add_multi_instance", "primary"),
    TASK_DEL_MULTI_INSTANCE("减签", "_workflow_task_add_multi_instance", "primary"),
    TASK_TRANSFER("转办", "_workflow_task_transfer", "primary"),
    TASK_DELEGATE("委派", "_workflow_task_delegate", "primary"),
    TASK_STOP("终止", "_workflow_task_stop", "info"),
    TASK_PRINT("打印", "_workflow_task_print", "primary"),
    TASK_COMMIT("提交", "_workflow_task_commit", "success"),
    TASK_AUDIT("审批", "_workflow_task_audit", "success"),
    TASK_ADD_BEFORE_MULTI_INSTANCE("前加签", "_workflow_task_before_add_multi_instance", "primary"),
    TASK_ADD_AFTER_MULTI_INSTANCE("后加签", "_workflow_task_after_add_multi_instance", "primary"),

    // 预设流程操作扩展信息
    PROCESS_WAITING("等待审核", "_workflow_process_waiting", "primary"),
    PROCESS_RECOMMIT("重新提交", "_workflow_process_recommit", "warning"),
    PROCESS_DELETED("流程作废", "_workflow_process_delete", "danger"),
    PROCESS_REVOKE("流程撤回", "_workflow_process_revoke", "warning"),
    PROCESS_SUSPENDED("已挂起", "_workflow_process_suspended", "danger"),
    PROCESS_AGREE("审核通过", "_workflow_process_agree", "success"),
    PROCESS_REJECT("审核驳回", "_workflow_process_reject", "danger"),
    PROCESS_STOP("审核终止", "_workflow_process_stop", "info");


    /** 操作名称 */
    @Getter
    private String name;

    /** 操作编码 */
    @Getter
    private String code;

    /** 功能级别,用于控制在前台显示的颜色 */
    @Getter
    private String level;

    ExtendMessage(String name, String code, String level) {
        this.name = name;
        this.code = code;
        this.level = level;
    }

    public String getName(String code) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getCode().equals (code)) {
                return extendMessage.getName();
            }
        }
        return null;
    }

    public String getLevel(String code) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getCode().equals(code)) {
                return extendMessage.getLevel();
            }
        }
        // 如果不存在返回 primary
        return "primary";
    }

    public ExtendMessage getExtendMessage(String code) {
        for (ExtendMessage extendMessage : ExtendMessage.values()) {
            if (extendMessage.getCode().equals(code)) {
                return extendMessage;
            }
        }
        return null;
    }
}
