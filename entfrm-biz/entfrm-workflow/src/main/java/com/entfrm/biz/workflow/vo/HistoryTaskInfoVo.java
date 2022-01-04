package com.entfrm.biz.workflow.vo;

import lombok.Data;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.Map;

/**
 *<p>
 * 历史任务
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/3
 */
@Data
@Accessors(chain = true)
public class HistoryTaskInfoVo {

    private String id;
    private String name;
    private String assignee;
    private String executionId;
    private String taskDefinitionKey;
    private Date createTime;
    private Date endTime;
    private String processDefinitionId;
    private String processInstanceId;
    private String processDefinitionName; // 流程名称
    private boolean rollBack; // 流程是否可以驳回到该节点
    private String code; //任务办理状态：1，2
    private String comment; //任务评论
    private String type; // 操作类型编码
    private String status; // 任务办理描述： 同意，驳回
    private String level; // 文字颜色
    private Map vars;
    // 当前流程还未结束的节点任务
    private TaskInfoVo currentTask;


}
