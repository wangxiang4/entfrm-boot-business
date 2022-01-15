package com.entfrm.biz.workflow.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.vo.ActivityCommentInfoVo;
import com.entfrm.biz.workflow.vo.HistoryTaskInfoVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceInfoVo;

import java.util.List;
import java.util.Map;


/**
 *<p>
 * 流程任务 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowTaskService {

    /**
     * 代办任务列表
     * params:查询条件参数
     */
    IPage<ProcessInstanceInfoVo> list(Map<String, Object> params);

    /**
     * 已办任务列表
     * params:查询条件参数
     */
    IPage<HistoryTaskInfoVo> historyList(Map<String, Object> params);

    /**
     * 已办流转任务列表
     * processInsId:流程实例ID
     */
    List<Workflow>  historyFlowChangeList(String processInsId);

    /**
     * 获取任务表单:首先获取任务节点表单KEY,如果没有则取流程开始节点表单KEY
     * processDefId:流程定义ID
     * taskDefKey:任务定义key
     */
    String getTaskFormKey(String processDefId, String taskDefKey);

    /**
     * 删除任务
     * taskId:任务ID
     * reason:删除原因
     */
    void removeTask(String taskId, String reason);

    /**
     * 签收任务
     * taskId:任务ID
     * userId:用户ID
     */
    void claim(String taskId, String userId);

    /**
     * 提交任务
     * workFlow:工作流业务实体
     * **/
    void complete(Workflow workFlow);


    /**
     * 获取bpmn.js绘制颜色xml
     * processInsId:流程实例ID
     */
    Map getPaintDiagramXml(String processInsId);


    /**
     * 审批任务
     * workFlow:工作流业务实体
     */
    void auditTask(Workflow workFlow);

    /**
     * 回滚任务
     * rejectTaskDefKey:驳回任务定义key,可驳回到指定节点
     * currentTaskId:当前任务ID
     * activityCommentInfo:活动备注业务实体
     */
    void rollBackTask(String rollBackTaskDefKey, String currentTaskId, ActivityCommentInfoVo activityCommentInfo);

    /**
     * 可回滚任务列表
     * taskId:任务ID
     */
    List<Workflow> rollBackTaskList(String taskId);

    /**
     * 加签任务
     * taskId:任务ID
     * userIds:加签人列表
     * comment:备注
     * mark:标记(true:后加签,false:前加签)
     */
    void addSignTask(String taskId, List<String> userIds, String comment, Boolean mark) throws Exception;


    /**
     * 读取流程历史数据,用于渲染流程图
     * processInsId:流程实例ID
     */
    Map getDiagram(String processInsId);

}
