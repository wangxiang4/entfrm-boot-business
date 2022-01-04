package com.entfrm.biz.workflow.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.flowable.task.api.TaskInfo;

import java.util.Date;

/**
 *<p>
 * 任务信息
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class TaskInfoVo {

    /** 任务ID */
    private String id;

    /** 任务名称 */
    private String name;

    /** 任务处理人 */
    private String assignee;

    /** 当前任务流程执行分支ID */
    private String executionId;

    /** 任务定义key */
    private String taskDefKey;

    /** 任务创建时间 */
    private Date createTime;

    /** 流程定义ID */
    private String processDefId;

    /** 流程实例ID */
    private String processInsId;

    /** 流程定义key */
    private String processDefKey;

    public TaskInfoVo(TaskInfo taskInfo){
        this.id = taskInfo.getId();
        this.name = taskInfo.getName();
        this.assignee = taskInfo.getAssignee();
        this.executionId = taskInfo.getExecutionId();
        this.taskDefKey = taskInfo.getTaskDefinitionKey();
        this.createTime = taskInfo.getCreateTime();
        this.processDefId = taskInfo.getProcessDefinitionId();
        this.processInsId = taskInfo.getProcessInstanceId();
    }

}
