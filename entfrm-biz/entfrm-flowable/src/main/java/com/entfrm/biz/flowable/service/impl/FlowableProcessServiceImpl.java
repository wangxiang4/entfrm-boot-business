package com.entfrm.biz.flowable.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.flowable.constant.FlowableConstant;
import com.entfrm.biz.flowable.vo.ProcessInstanceVo;
import com.entfrm.biz.flowable.enums.ActionType;
import com.entfrm.biz.flowable.enums.ProcessStatus;
import com.entfrm.biz.flowable.vo.TaskCommentVo;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
import com.entfrm.biz.flowable.vo.TaskVo;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.EndEvent;
import org.flowable.bpmn.model.FlowNode;
import org.flowable.bpmn.model.Process;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.TaskService;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.Task;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 *<p>
 * 流程定义相关 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
@Service
@AllArgsConstructor
@Transactional(rollbackFor = Exception.class)
public class FlowableProcessServiceImpl implements FlowableProcessService {

    private final RepositoryService repositoryService;
    private final RuntimeService runtimeService;
    private final HistoryService historyService;
    private final TaskService taskService;
    private final FlowableBpmnModelServiceImpl flowableBpmnModelService;

    /** 流程定义列表 */
    @Override
    public IPage<ProcessInstanceVo> list(Map<String, Object> params) {
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery().latestVersion();
        String name = (String) params.get("name");
        if (StrUtil.isNotBlank(name)) {
            query.processDefinitionNameLike(name);
        }

        String category = MapUtil.getStr(params, "category");
        if (StrUtil.isNotBlank(category)) {
            query.processDefinitionCategory(category);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<ProcessInstanceVo> deploymentList = query.listPage((current - 1) * size, size)
        .stream().map(processDefinition -> {
            Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(processDefinition.getDeploymentId()).singleResult();
            ProcessInstanceVo processInstanceVo =new ProcessInstanceVo();
            processInstanceVo.setId(processDefinition.getId());
            processInstanceVo.setCategory(processDefinition.getCategory());
            processInstanceVo.setKey(processDefinition.getKey());
            processInstanceVo.setName(processDefinition.getName());
            processInstanceVo.setVersion("V:" + processDefinition.getVersion());
            processInstanceVo.setResourceName(processDefinition.getResourceName());
            processInstanceVo.setDiagramResourceName(processDefinition.getDiagramResourceName());
            processInstanceVo.setDeploymentId(processDefinition.getDeploymentId());
            processInstanceVo.setSuspend(processDefinition.isSuspended());
            processInstanceVo.setDeploymentTime(deployment.getDeploymentTime());
            return processInstanceVo;
        }).collect(Collectors.toList());
        result.setRecords(deploymentList);
        return result;
    }


    /** 读取xml/image资源 */
    @Override
    public InputStream readResource(String procInsId, String procDefId, String resType) {

        if (StrUtil.isBlank(procDefId)) {
            ProcessInstance processInstance =
                    runtimeService.createProcessInstanceQuery().processInstanceId(procInsId).singleResult();
            procDefId = processInstance.getProcessDefinitionId();
        }
        ProcessDefinition processDefinition =
                repositoryService.createProcessDefinitionQuery().processDefinitionId(procDefId).singleResult();
        String resourceName = "";
        if ("image".equals(resType)) {
            resourceName = processDefinition.getDiagramResourceName();
        } else if ("xml".equals(resType)) {
            resourceName = processDefinition.getResourceName();
        }
        InputStream resourceAsStream = repositoryService
                .getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
        return resourceAsStream;

    }



    /** 挂起/激活 */
    @Override
    public Boolean changeStatus(String procDefId, String status) {
        if ("active".equals(status)) {
            repositoryService.activateProcessDefinitionById(procDefId, true, null);
        } else if ("suspend".equals(status)) {
            repositoryService.suspendProcessDefinitionById(procDefId, true, null);
        }
        return Boolean.TRUE;
    }


    /** 删除流程实例 */
    @Override
    public Boolean removeProcIns(String deployId) {
        repositoryService.deleteDeployment(deployId, true);
        return Boolean.TRUE;
    }


    /** 获取正在运行的流程实例对象专用 */
    @Override
    public ProcessInstance getProcIns(String procInsId) {
        return runtimeService.createProcessInstanceQuery().processInstanceId(procInsId).singleResult();
    }

    /** 获取已经结束流程实例对象专用 */
    @Override
    public HistoricProcessInstance getFinishedProcIns(String procInsId) {
        return historyService.createHistoricProcessInstanceQuery().processInstanceId(procInsId).singleResult();
    }


    /** 查询流程实例状态专用 */
    @Override
    public ProcessInsVo queryProcessState(String processInstanceId) {
        try {
            ProcessInsVo processInsVo = new ProcessInsVo();
            // 通过流程实例ID查询流程实例
            ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId (processInstanceId).singleResult();
            if (pi != null) {
                if (pi.isSuspended ()) {
                    //挂起实例
                    processInsVo.setProcessStatus(ProcessStatus.SUSPENDED);
                    return processInsVo;
                } else {
                    //执行实例
                    processInsVo.setProcessStatus(ProcessStatus.WAITING);
                    Task currentTask = taskService.createTaskQuery().processInstanceId(processInstanceId).list().get(0);
                    processInsVo.setTask(new TaskVo(currentTask));
                    processInsVo.setTaskName (currentTask.getName ());
                    return processInsVo;
                }
            } else {
                HistoricProcessInstance pi2 =
                        historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult ();
                //查询历史流程完整历史活动
                HistoricActivityInstance historicActivityInstance = historyService.createHistoricActivityInstanceQuery()
                        .processInstanceId(processInstanceId).finished()
                        .orderByHistoricActivityInstanceEndTime().desc().list().stream()
                        .filter(activity ->
                                activity.getActivityType().equals (BpmnXMLConstants.ELEMENT_TASK_USER) ||
                                activity.getActivityType().equals (BpmnXMLConstants.ELEMENT_EVENT_END) ||
                                activity.getActivityType().equals (BpmnXMLConstants.ELEMENT_EVENT_START))
                        .distinct().collect(Collectors.toList ()).get(0);
                Process process = repositoryService.getBpmnModel (historicActivityInstance.getProcessDefinitionId()).getMainProcess();
                FlowNode flowElement = (FlowNode)process.getFlowElement(historicActivityInstance.getActivityId(), true);
                if (pi2 != null) {
                    HistoricVariableInstance processStatusInstance = historyService.createHistoricVariableInstanceQuery()
                            .processInstanceId(processInstanceId).variableName(FlowableConstant.PROCESS_STATUS_CODE).singleResult ();
                    //流程删除没有出错,以及没有自定义流程状态视为审核通过
                    if (pi2.getDeleteReason() == null && processStatusInstance == null) {
                        processInsVo.setProcessStatus(ProcessStatus.AGREE);
                        processInsVo.setTaskName(flowElement.getName());
                        return processInsVo;
                        //流程删除存在出错视为审核终止
                    } else if (pi2.getDeleteReason () != null) {
                        processInsVo.setProcessStatus (ProcessStatus.STOP);
                        processInsVo.setTaskName (flowElement.getName ());
                        processInsVo.setDeleteReason (pi2.getDeleteReason ());
                        return processInsVo;
                        //自定义流程状态
                    } else {
                        int code =Integer.valueOf (processStatusInstance.getValue().toString ());
                        ProcessStatus processStatus = ProcessStatus.value (code);
                        processInsVo.setProcessStatus(processStatus);
                        processInsVo.setTaskName(flowElement.getName ());
                        return processInsVo;
                    }
                    //如果历史中查询不到视为流程作废
                } else {
                    processInsVo.setProcessStatus (ProcessStatus.DELETED);
                    processInsVo.setTaskName (flowElement.getName ());
                    processInsVo.setDeleteReason (pi2.getDeleteReason ());
                    return processInsVo;
                }

            }
        } catch (Exception e) {}
        return null;
    }


    /** 根据key获取流程定义 */
    @Override
    public ProcessDefinition getProcessDefinitionByKey(String key) {
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .latestVersion().orderByProcessDefinitionKey().asc();
        processDefinitionQuery.processDefinitionKey(key);
        List<ProcessDefinition> processDefinitionList = processDefinitionQuery.list();
        if(processDefinitionList.size() > 0){
            return  processDefinitionList.get(0);
        }else {
            return null;
        }
    }

    /** 终止流程实例 */
    @Override
    public void stopProcessInstanceById(String procInsId, ProcessStatus processStatus, String comment) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(procInsId).singleResult();
        if (processInstance != null) {
            Task currentTask = taskService.createTaskQuery ().processInstanceId (procInsId).list ().get (0);
            //1、添加审批记录
            TaskCommentVo taskCommentVo = new TaskCommentVo();
            if(processStatus == ProcessStatus.REVOKE){
                taskCommentVo.setType (ActionType.REVOKE.getType ());
                taskCommentVo.setStatus (ActionType.REVOKE.getStatus ());
                taskCommentVo.setMessage (comment);
            }else if(processStatus == ProcessStatus.STOP){
                taskCommentVo.setType (ActionType.STOP.getType ());
                taskCommentVo.setStatus (ActionType.STOP.getStatus ());
                taskCommentVo.setMessage (comment);
            }else if(processStatus == ProcessStatus.REJECT){
                taskCommentVo.setType (ActionType.REJECT.getType ());
                taskCommentVo.setStatus (ActionType.REJECT.getStatus ());
                taskCommentVo.setMessage (comment);
            }else if(processStatus == ProcessStatus.DELETED){
                taskCommentVo.setType (ActionType.DELETED.getType ());
                taskCommentVo.setStatus (ActionType.DELETED.getStatus ());
                taskCommentVo.setMessage (comment);
            }


            taskService.addComment(currentTask.getId (),procInsId, taskCommentVo.getCommentType(), taskCommentVo.getFullMessage());
            // 未签收任务
            if(StrUtil.isBlank(currentTask.getAssignee ()))  {
                taskService.claim (currentTask.getId (), SecurityUtil.getUser().getUsername());
            }
            runtimeService.setVariable(procInsId, FlowableConstant.PROCESS_STATUS_CODE, processStatus.getCode ());
            List<EndEvent> endNodes = flowableBpmnModelService.findEndFlowElement(processInstance.getProcessDefinitionId());
            String endId = endNodes.get(0).getId();
            //2、执行终止
            List<Execution> executions = runtimeService.createExecutionQuery().parentId(procInsId).list();
            List<String> executionIds = new ArrayList<>();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            moveExecutionsToSingleActivityId(executionIds, endId);

        }
    }


    /** 节点跳转 */
    @Override
    public void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId) {
        runtimeService.createChangeActivityStateBuilder()
                .moveExecutionsToSingleActivityId(executionIds, activityId).changeState();
    }



}
