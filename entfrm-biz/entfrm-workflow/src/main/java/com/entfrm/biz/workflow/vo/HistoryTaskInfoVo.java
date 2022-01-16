package com.entfrm.biz.workflow.vo;

import cn.hutool.core.collection.CollectionUtil;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import org.flowable.task.api.history.HistoricTaskInstance;

import java.util.Date;
import java.util.Map;

/**
 *<p>
 * 历史任务信息
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/3
 */
@Data
@Accessors(chain = true)
@AllArgsConstructor
@NoArgsConstructor
public class HistoryTaskInfoVo {

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

    /** 流程定义ID */
    private String processDefId;

    /** 流程实例ID */
    private String processInsId;

    /** 流程定义名称 */
    private String processDefName;

    /** 流程是否可以回滚到该节点 */
    private boolean rollBack;

    /** 任务备注 */
    private String comment;

    /** 流程操作名称 */
    private String mesName;

    /** 流程操作编码 */
    private String mesCode;

    /** 流程操作级别 */
    private String mesLevel;

    /** 任务创建时间 */
    private Date createTime;

    /** 任务结束时间 */
    private Date endTime;

    /** 流程当前任务 */
    private TaskInfoVo taskInfo;

    /** 流程变量 */
    private Map<String, Object> vars = CollectionUtil.newHashMap();

    public HistoryTaskInfoVo(HistoricTaskInstance historicTaskInstance){
        this.id = historicTaskInstance.getId ();
        this.name = historicTaskInstance.getName ();
        this.assignee = historicTaskInstance.getAssignee ();
        this.executionId = historicTaskInstance.getExecutionId ();
        this.taskDefKey = historicTaskInstance.getTaskDefinitionKey ();
        this.createTime = historicTaskInstance.getCreateTime ();
        this.endTime = historicTaskInstance.getEndTime ();
        this.executionId = historicTaskInstance.getExecutionId ();
        this.processDefId = historicTaskInstance.getProcessDefinitionId ();
        this.vars = historicTaskInstance.getProcessVariables ();
        this.processInsId = historicTaskInstance.getProcessInstanceId ();
    }

}
