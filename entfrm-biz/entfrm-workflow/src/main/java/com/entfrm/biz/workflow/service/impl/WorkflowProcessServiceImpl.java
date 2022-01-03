package com.entfrm.biz.workflow.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.workflow.constant.FlowableConstant;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.mapper.WorkflowMapper;
import com.entfrm.biz.workflow.vo.ProcessDefinitionVo;
import com.entfrm.biz.workflow.enums.ActionType;
import com.entfrm.biz.workflow.enums.ProcessStatus;
import com.entfrm.biz.workflow.vo.TaskCommentVo;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.vo.ProcessInstanceVo;
import com.entfrm.biz.workflow.vo.TaskVo;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.EndEvent;
import org.flowable.bpmn.model.FlowNode;
import org.flowable.bpmn.model.Process;
import org.flowable.engine.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.history.HistoricProcessInstanceQuery;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.repository.ProcessDefinitionQuery;
import org.flowable.engine.runtime.Execution;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.engine.runtime.ProcessInstanceQuery;
import org.flowable.identitylink.api.IdentityLink;
import org.flowable.task.api.Task;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 *<p>
 * 流程定义 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Service
@AllArgsConstructor
@Transactional(rollbackFor = Exception.class)
public class WorkflowProcessServiceImpl implements WorkflowProcessService {

    private final RepositoryService repositoryService;

    private final RuntimeService runtimeService;

    private final HistoryService historyService;

    private final TaskService taskService;

    private final WorkflowBpmnModelServiceImpl WorkflowBpmnModelService;

    private final WorkflowMapper workflowMapper;

    private final IdentityService identityService;

    @Override
    public IPage<ProcessDefinitionVo> list(Map<String, Object> params) {
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery()
                .active().latestVersion().orderByProcessDefinitionKey().asc();

        String name = MapUtil.getStr(params, "name"),
               category = MapUtil.getStr(params, "category");

        if (StrUtil.isNotBlank(name)) {
            query.processDefinitionNameLike(name);
        }
        if (StrUtil.isNotBlank(category)) {
            query.processDefinitionCategory(category);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<ProcessDefinition> processDefinitionList = query.listPage((current - 1) * size, size);
        for (ProcessDefinition processDefinition : processDefinitionList) {
            if(this.validateProcessAuth(SecurityUtil.getUser(), processDefinition.getId())){
                Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(processDefinition.getDeploymentId()).singleResult();
                ProcessDefinitionVo processDefinitionVo =new ProcessDefinitionVo();
                processDefinitionVo.setId(processDefinition.getId());
                processDefinitionVo.setCategory(processDefinition.getCategory());
                processDefinitionVo.setKey(processDefinition.getKey());
                processDefinitionVo.setName(processDefinition.getName());
                processDefinitionVo.setVersion("V:" + processDefinition.getVersion());
                processDefinitionVo.setResourceName(processDefinition.getResourceName());
                processDefinitionVo.setDiagramResourceName(processDefinition.getDiagramResourceName());
                processDefinitionVo.setDeploymentId(processDefinition.getDeploymentId());
                processDefinitionVo.setSuspend(processDefinition.isSuspended());
                processDefinitionVo.setDeploymentTime(deployment.getDeploymentTime());
                result.getRecords().add(processDefinitionVo);
            }
        }
        return result;
    }

    @Override
    public IPage<ProcessInstanceVo> runList(Map<String, Object> params) {
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().includeProcessVariables();

        String procInsId = MapUtil.getStr(params, "procInsId"),
               procDefKey = MapUtil.getStr(params, "procDefKey");

        if (StrUtil.isNotBlank(procInsId)) {
            query.processInstanceId(procInsId);
        }
        if (StrUtil.isNotBlank(procDefKey)) {
            query.processDefinitionKey(procDefKey);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<ProcessInstance> processInstanceList = query.listPage((current - 1) * size, size);

        for (ProcessInstance processInstance : processInstanceList) {
            ProcessInstanceVo processInstanceVo  = queryProcessState(processInstance.getId());
            processInstanceVo.setProcessInstanceId (processInstance.getProcessInstanceId());
            processInstanceVo.setProcessDefinitionId (processInstance.getProcessDefinitionId());
            processInstanceVo.setProcessDefinitionName (processInstance.getProcessDefinitionName ());
            processInstanceVo.setActivityId (processInstance.getActivityId ());
            processInstanceVo.setVars (processInstance.getProcessVariables());
            result.getRecords().add(processInstance);
        }
        return result;
    }

    @Override
    public IPage<ProcessInstanceVo> historyList(Map<String, Object> params) {
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().includeProcessVariables().finished()
                .orderByProcessInstanceEndTime().desc();

        String procInsId = MapUtil.getStr(params, "procInsId"),
               procDefKey = MapUtil.getStr(params, "procDefKey");

        if (StrUtil.isNotBlank(procInsId)) {
            query.processInstanceId(procInsId);
        }

        if (StrUtil.isNotBlank(procDefKey)) {
            query.processDefinitionKey(procDefKey);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<HistoricProcessInstance> historicProcessInstanceList = query.listPage((current - 1) * size, size);

        for (HistoricProcessInstance historicProcessInstance : historicProcessInstanceList) {
            ProcessInstanceVo processInstanceVo = queryProcessState(historicProcessInstance.getId ());
            processInstanceVo.setVars(historicProcessInstance.getProcessVariables());
            processInstanceVo.setProcessDefinitionName(historicProcessInstance.getProcessDefinitionName());
            processInstanceVo.setStartTime(historicProcessInstance.getStartTime());
            processInstanceVo.setEndTime(historicProcessInstance.getEndTime());
            processInstanceVo.setProcessInstanceId(historicProcessInstance.getId());
            processInstanceVo.setProcessDefinitionId(historicProcessInstance.getProcessDefinitionId());
            processInstanceVo.setDeleteReason(historicProcessInstance.getDeleteReason());
            result.getRecords().add(processInstanceVo);
        }
        return result;
    }

    @Override
    public InputStream readResource(String processInsId, String processDefId, String fileType) {
        if (StrUtil.isBlank(processDefId)) {
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                    .processInstanceId(processInsId).singleResult();
            processDefId = processInstance.getProcessDefinitionId();
        }

        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                .processDefinitionId(processDefId).singleResult();
        String resourceName = "";

        if ("image".equals(fileType)) {
            resourceName = processDefinition.getDiagramResourceName();
        } else if ("xml".equals(fileType)) {
            resourceName = processDefinition.getResourceName();
        }

        InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
        return resourceAsStream;
    }

    @Override
    public void setProcessInstanceCategory(String processDefId, String category) {
        repositoryService.setProcessDefinitionCategory(processDefId, category);
    }

    @Override
    public void setProcessInstanceStatus(String processDefId, String status) {
        if ("active".equals(status)) {
            repositoryService.activateProcessDefinitionById(processDefId, true, null);
        } else if ("suspend".equals(status)) {
            repositoryService.suspendProcessDefinitionById(processDefId, true, null);
        }
    }

    @Override
    public void deleteDeployment(String deploymentId) {
        repositoryService.deleteDeployment(deploymentId, true);
    }

    @Override
    public void stopProcessInstance(String processInsId, ProcessStatus processStatus, String comment) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
        if (processInstance != null) {
            Task currentTask = taskService.createTaskQuery().processInstanceId(processInsId).list().get(0);

            // 设置审批记录
            TaskCommentVo taskCommentVo = new TaskCommentVo();
            switch (processStatus) {
                case REVOKE:
                    taskCommentVo.setType(ActionType.REVOKE.getType());
                    taskCommentVo.setStatus(ActionType.REVOKE.getStatus());
                    break;
                case STOP:
                    taskCommentVo.setType(ActionType.STOP.getType());
                    taskCommentVo.setStatus(ActionType.STOP.getStatus());
                    break;
                case REJECT:
                    taskCommentVo.setType(ActionType.REJECT.getType());
                    taskCommentVo.setStatus(ActionType.REJECT.getStatus());
                    break;
                case DELETED:
                    taskCommentVo.setType(ActionType.DELETED.getType());
                    taskCommentVo.setStatus(ActionType.DELETED.getStatus());
                    break;
                default:
                    taskCommentVo.setMessage (comment);
            }

            // 添加审批记录
            taskService.addComment(currentTask.getId(), processInsId, taskCommentVo.getCommentType(), taskCommentVo.getFullMessage());

            // 处理未签收任务,未领取就让当前用户领取
            if (StrUtil.isBlank(currentTask.getAssignee())) {
                taskService.claim(currentTask.getId(), SecurityUtil.getUser().getId() + "");
            }
            runtimeService.setVariable(processInsId, FlowableConstant.PROCESS_STATUS_CODE, processStatus.getCode());
            List<EndEvent> endNodes = WorkflowBpmnModelService.findEndFlowElement(processInstance.getProcessDefinitionId());
            String endId = endNodes.get(0).getId();

            // 执行终止流程
            List<Execution> executions = runtimeService.createExecutionQuery().parentId(processInsId).list();
            List<String> executionIds = new ArrayList<>();
            executions.forEach(execution -> executionIds.add(execution.getId()));
            this.moveExecutionsToSingleActivityId(executionIds, endId);
        }
    }

    @Override
    public void deleteProcessInstance(String processInsId, String deleteReason) {
        this.stopProcessInstance(processInsId, ProcessStatus.DELETED, deleteReason);
    }

    @Override
    public void undoProcessInstance(String processInsId) {
        this.stopProcessInstance(processInsId, ProcessStatus.REVOKE, ProcessStatus.REVOKE.getStatus());
    }

    @Override
    public void moveExecutionsToSingleActivityId(List<String> executionIds, String activityId) {
        runtimeService.createChangeActivityStateBuilder().moveExecutionsToSingleActivityId(executionIds, activityId).changeState();
    }

    @Override
    public void delHistoryProcessInstance(String processInsId) {
        historyService.deleteHistoricProcessInstance(processInsId);
    }

    @Override
    public ProcessInstanceVo queryProcessState(String processInstanceId) {
        ProcessInstanceVo processInstanceVo = new ProcessInstanceVo();
        // 通过流程实例ID查询流程实例
        ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId (processInstanceId).singleResult();
        if (pi != null) {
            if (pi.isSuspended ()) {
                //挂起实例
                processInstanceVo.setProcessStatus(ProcessStatus.SUSPENDED);
            } else {
                //执行实例
                processInstanceVo.setProcessStatus(ProcessStatus.WAITING);
                Task currentTask = taskService.createTaskQuery().processInstanceId(processInstanceId).list().get(0);
                processInstanceVo.setTask(new TaskVo(currentTask));
                processInstanceVo.setTaskName (currentTask.getName ());
            }
            return processInstanceVo;
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
                    processInstanceVo.setProcessStatus(ProcessStatus.AGREE);
                    processInstanceVo.setTaskName(flowElement.getName());
                    return processInstanceVo;
                    //流程删除存在出错视为审核终止
                } else if (pi2.getDeleteReason () != null) {
                    processInstanceVo.setProcessStatus (ProcessStatus.STOP);
                    processInstanceVo.setTaskName (flowElement.getName ());
                    processInstanceVo.setDeleteReason (pi2.getDeleteReason ());
                    return processInstanceVo;
                    //自定义流程状态
                } else {
                    int code =Integer.valueOf (processStatusInstance.getValue().toString ());
                    ProcessStatus processStatus = ProcessStatus.value (code);
                    processInstanceVo.setProcessStatus(processStatus);
                    processInstanceVo.setTaskName(flowElement.getName ());
                    return processInstanceVo;
                }
                //如果历史中查询不到视为流程作废
            } else {
                processInstanceVo.setProcessStatus (ProcessStatus.DELETED);
                processInstanceVo.setTaskName (flowElement.getName ());
                processInstanceVo.setDeleteReason (pi2.getDeleteReason ());
                return processInstanceVo;
            }
        }
    }

    @Override
    public ProcessDefinition getProcessDefinition(String processDefId) {
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .latestVersion().orderByProcessDefinitionKey().asc();
        if (StrUtil.isNotBlank(processDefId)) {
            processDefinitionQuery.processDefinitionId(processDefId);
        }
        ProcessDefinition processDefinition = processDefinitionQuery.singleResult();
        return processDefinition;
    }

    public ProcessDefinition getProcessDefinitionByKey(String processDefKey) {
        ProcessDefinitionQuery processDefinitionQuery = repositoryService.createProcessDefinitionQuery()
                .latestVersion().orderByProcessDefinitionKey().asc();
        if (StrUtil.isNotBlank(processDefKey)) {
            processDefinitionQuery.processDefinitionKey(processDefKey);
        }
        ProcessDefinition processDefinition = processDefinitionQuery.singleResult();
        return processDefinition;
    }

    @Override
    public ProcessInstance getProcessInstance(String processInsId) {
        return runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
    }

    @Override
    public HistoricProcessInstance getFinishedProcessInstance(String processInsId) {
        return historyService.createHistoricProcessInstanceQuery().processInstanceId(processInsId).singleResult();
    }

    @Override
    public IPage<ProcessInstanceVo> selfProcessInstanceList(Map<String, Object> params) {
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery()
                .startedBy(SecurityUtil.getUser().getId() + "").includeProcessVariables().orderByProcessInstanceStartTime().desc();

        String title = MapUtil.getStr(params, " title");
        Date beginDate = MapUtil.getDate(params, "beginDate"),
                endDate = MapUtil.getDate(params, "endDate");

        if (StrUtil.isNotBlank (title)) {
            query.variableValueLike(FlowableConstant.TITLE, "%" + title + "%");
        }
        if (beginDate != null) {
            query.startedAfter(beginDate);
        }
        if (endDate != null) {
            query.startedBefore(endDate);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<HistoricProcessInstance> historicProcessInstanceList = query.involvedUser(SecurityUtil.getUser().getId() + "").listPage((current - 1) * size, size);

        for (HistoricProcessInstance historicProcessInstance : historicProcessInstanceList) {
            ProcessInstanceVo processInstanceVo = this.queryProcessState(historicProcessInstance.getId());
            processInstanceVo.setEndTime (historicProcessInstance.getEndTime ());
            processInstanceVo.setStartTime (historicProcessInstance.getStartTime ());
            processInstanceVo.setProcessDefinitionId (historicProcessInstance.getProcessDefinitionId ());
            processInstanceVo.setProcessInstanceId (historicProcessInstance.getId ());
            processInstanceVo.setVars (historicProcessInstance.getProcessVariables ());
            processInstanceVo.setProcessDefinitionName (historicProcessInstance.getProcessDefinitionName ());
            processInstanceVo.setVersion ( historicProcessInstance.getProcessDefinitionVersion ());
            result.getRecords().add(processInstanceVo);
        }
        return result;
    }

    @Override
    public String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title, Map<String, Object> processVars) {
        // 设置流程变量
        if(processVars == null){
            processVars = MapUtil.newHashMap();
        }

        // 可由外部提供流程发起人
        String userId = MapUtil.getStr(processVars, FlowableConstant.INITIATOR);
        if(userId == null){
            userId= SecurityUtil.getUser().getId() + "";
        }

        // 设置流程执行人
        String userName = SecurityUtil.getUser().getUsername();
        processVars.put(FlowableConstant.USERNAME, userName);

        // 设置流程发起人
        identityService.setAuthenticatedUserId(userId);

        // 设置流程标题
        if (StrUtil.isNotBlank(title)) {
            processVars.put(FlowableConstant.TITLE, title);
        }

        // 启动流程实例
        String processInsId = runtimeService
                .startProcessInstanceByKey(processDefKey, String.join(":",businessTable,businessId), processVars)
                .getProcessInstanceId();

        // 更新业务表流程实例ID,确保业务表字段process_ins_id存在
        Workflow act = new Workflow();
        act.setBusinessTable (businessTable);
        act.setBusinessId (businessId);
        act.setProcInsId (processInsId);
        workflowMapper.updateProcInsIdByBusinessId(act);
        return processInsId;
    }

    @Override
    public String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title) {
        Map<String, Object> processVars = MapUtil.newHashMap();
        return startProcessDefinition(processDefKey, businessTable, businessId, title, processVars);
    }

    /** 流程权限校验 */
    private boolean validateProcessAuth(EntfrmUser user, String processDefId) {
        List<IdentityLink> identityLinks = repositoryService.getIdentityLinksForProcessDefinition(processDefId);
        if(identityLinks.size() == 0){
            return true;
        }
        for (IdentityLink identityLink : identityLinks ) {
            if((user.getId()+"").equals(identityLink.getUserId())){
                return true;
            }
            if((","+user.getRoleIds()+",").contains(","+identityLink.getGroupId()+",")) {
                return true;
            }
        }
        return false;
    }

}

