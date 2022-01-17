package com.entfrm.biz.workflow.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.entity.WorkflowModel;
import com.entfrm.biz.workflow.enums.ExtendMessage;
import com.entfrm.biz.workflow.mapper.WorkflowMapper;
import com.entfrm.biz.workflow.mapper.WorkflowModelMapper;
import com.entfrm.biz.workflow.service.WorkflowBpmnModelService;
import com.entfrm.biz.workflow.service.WorkflowModelService;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.vo.ActivityCommentInfoVo;
import com.entfrm.biz.workflow.vo.ProcessDefinitionInfoVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceInfoVo;
import com.entfrm.biz.workflow.vo.TaskInfoVo;
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
import org.springframework.context.annotation.Lazy;
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

    private final WorkflowBpmnModelService workflowBpmnModelService;

    private final WorkflowMapper workflowMapper;

    private final IdentityService identityService;

    private final WorkflowModelMapper workflowModelMapper;

    @Override
    public IPage<ProcessDefinitionInfoVo> list(Map<String, Object> params) {
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery()
                .active().latestVersion().orderByProcessDefinitionKey().asc();

        String name = MapUtil.getStr(params, "name"),
               categoryId = MapUtil.getStr(params, "categoryId");

        if (StrUtil.isNotBlank(name)) {
            query.processDefinitionNameLike("%"+name+"%");
        }
        if (StrUtil.isNotBlank(categoryId)) {
            query.processDefinitionCategoryLike(categoryId+"%");
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<ProcessDefinition> processDefinitionList = query.listPage((current - 1) * size, size);
        for (ProcessDefinition processDefinition : processDefinitionList) {
            if(this.validateProcessAuth(SecurityUtil.getUser(), processDefinition.getId())){
                Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(processDefinition.getDeploymentId()).singleResult();
                ProcessDefinitionInfoVo processDefinitionInfo =new ProcessDefinitionInfoVo();
                processDefinitionInfo.setId(processDefinition.getId());
                processDefinitionInfo.setCategory(processDefinition.getCategory());
                processDefinitionInfo.setKey(processDefinition.getKey());
                processDefinitionInfo.setName(processDefinition.getName());
                // 校验协助池也称泳道池,如果流程名称未填写,获取模型名称补充
                if (StrUtil.isBlank(processDefinition.getName())) {
                    WorkflowModel workflowModel = workflowModelMapper.selectOne(
                            new LambdaQueryWrapper<WorkflowModel>().like(WorkflowModel::getModelKey,"%" + processDefinition.getKey() + "%"));
                    processDefinitionInfo.setName(workflowModel != null ? workflowModel.getName() : null);
                }
                processDefinitionInfo.setVersion("V:" + processDefinition.getVersion());
                processDefinitionInfo.setResourceName(processDefinition.getResourceName());
                processDefinitionInfo.setDiagramResourceName(processDefinition.getDiagramResourceName());
                processDefinitionInfo.setDeploymentId(processDefinition.getDeploymentId());
                processDefinitionInfo.setSuspend(processDefinition.isSuspended());
                processDefinitionInfo.setDeploymentTime(deployment.getDeploymentTime());
                result.getRecords().add(processDefinitionInfo);
            }
        }
        return result;
    }

    @Override
    public IPage<ProcessInstanceInfoVo> runList(Map<String, Object> params) {
        ProcessInstanceQuery query = runtimeService.createProcessInstanceQuery().includeProcessVariables();

        String processInsId = MapUtil.getStr(params, "processInsId"),
                processDefKey = MapUtil.getStr(params, "processDefKey");

        if (StrUtil.isNotBlank(processInsId)) {
            query.processInstanceId(processInsId);
        }
        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<ProcessInstance> processInstanceList = query.listPage((current - 1) * size, size);

        for (ProcessInstance processInstance : processInstanceList) {
            ProcessInstanceInfoVo processInstanceInfo = queryProcessState(processInstance.getId());
            processInstanceInfo.setProcessInsId(processInstance.getProcessInstanceId());
            processInstanceInfo.setProcessDefId(processInstance.getProcessDefinitionId());
            processInstanceInfo.setProcessDefName(processInstance.getProcessDefinitionName());
            processInstanceInfo.setActivityId(processInstance.getActivityId());
            processInstanceInfo.setVars(processInstance.getProcessVariables());
            result.getRecords().add(processInstanceInfo);
        }
        return result;
    }

    @Override
    public IPage<ProcessInstanceInfoVo> historyList(Map<String, Object> params) {
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().includeProcessVariables().finished()
                .orderByProcessInstanceEndTime().desc();

        String processInsId = MapUtil.getStr(params, "processInsId"),
                processDefKey = MapUtil.getStr(params, "processDefKey");

        if (StrUtil.isNotBlank(processInsId)) {
            query.processInstanceId(processInsId);
        }

        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<HistoricProcessInstance> historicProcessInstanceList = query.listPage((current - 1) * size, size);

        for (HistoricProcessInstance historicProcessInstance : historicProcessInstanceList) {
            ProcessInstanceInfoVo processInstanceInfo = queryProcessState(historicProcessInstance.getId());
            processInstanceInfo.setVars(historicProcessInstance.getProcessVariables());
            processInstanceInfo.setProcessDefName(historicProcessInstance.getProcessDefinitionName());
            processInstanceInfo.setStartTime(historicProcessInstance.getStartTime());
            processInstanceInfo.setEndTime(historicProcessInstance.getEndTime());
            processInstanceInfo.setProcessInsId(historicProcessInstance.getId());
            processInstanceInfo.setProcessDefId(historicProcessInstance.getProcessDefinitionId());
            processInstanceInfo.setDeleteReason(historicProcessInstance.getDeleteReason());
            result.getRecords().add(processInstanceInfo);
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
    public void stopProcessInstance(String processInsId, ExtendMessage extendMessage, String comment) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
        if (processInstance != null) {
            Task task = taskService.createTaskQuery().processInstanceId(processInsId).list().get(0);

            // 设置审批记录
            ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
            activityCommentInfo.setMesCode(extendMessage.getMesCode());
            activityCommentInfo.setMesName(extendMessage.getMesName());
            activityCommentInfo.setMessage(comment);

            // 添加审批记录
            taskService.addComment(task.getId(), processInsId, activityCommentInfo.getExtendMessage(), activityCommentInfo.getCombinationMessage());

            // 处理未签收任务,未领取就让当前用户领取
            if (StrUtil.isBlank(task.getAssignee())) {
                taskService.claim(task.getId(), SecurityUtil.getUser().getId() + "");
            }
            runtimeService.setVariable(processInsId, WorkflowConstant.PROCESS_STATUS_CODE, extendMessage.getMesCode());
            List<EndEvent> endNodes = workflowBpmnModelService.findEndFlowElement(processInstance.getProcessDefinitionId());
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
        this.stopProcessInstance(processInsId, ExtendMessage.PROCESS_DELETED, deleteReason);
    }

    @Override
    public void undoProcessInstance(String processInsId) {
        this.stopProcessInstance(processInsId, ExtendMessage.PROCESS_REVOKE, ExtendMessage.PROCESS_REVOKE.getMesName());
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
    public ProcessInstanceInfoVo queryProcessState(String processInstanceId) {
        ProcessInstanceInfoVo processInstanceInfo = new ProcessInstanceInfoVo();
        // 通过流程实例ID查询流程实例
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        if (processInstance != null) {
            if (processInstance.isSuspended()) {
                //挂起实例
                processInstanceInfo.setExtendMessage(ExtendMessage.PROCESS_SUSPENDED);
            } else {
                //执行实例
                processInstanceInfo.setExtendMessage(ExtendMessage.PROCESS_WAITING);
                Task task = taskService.createTaskQuery().processInstanceId(processInstanceId).list().get(0);
                processInstanceInfo.setTaskInfo(new TaskInfoVo(task));
                processInstanceInfo.setTaskName(task.getName());
            }
            return processInstanceInfo;
        } else {
            HistoricProcessInstance historicProcessInstance =
                    historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            //查询历史流程完整历史活动
            HistoricActivityInstance historicActivityInstance = historyService.createHistoricActivityInstanceQuery()
                    .processInstanceId(processInstanceId).finished()
                    .orderByHistoricActivityInstanceEndTime().desc().list().stream()
                    .filter(activity ->
                            activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_TASK_USER) ||
                                    activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_END) ||
                                    activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START))
                    .distinct().collect(Collectors.toList()).get(0);
            Process process = repositoryService.getBpmnModel(historicActivityInstance.getProcessDefinitionId()).getMainProcess();
            FlowNode flowElement = (FlowNode)process.getFlowElement(historicActivityInstance.getActivityId(), true);
            if (historicProcessInstance != null) {
                HistoricVariableInstance processStatusInstance = historyService.createHistoricVariableInstanceQuery()
                        .processInstanceId(processInstanceId).variableName(WorkflowConstant.PROCESS_STATUS_CODE).singleResult();
                //流程删除没有出错,以及没有自定义流程状态视为审核通过
                if (historicProcessInstance.getDeleteReason() == null && processStatusInstance == null) {
                    processInstanceInfo.setExtendMessage(ExtendMessage.PROCESS_AGREE);
                    processInstanceInfo.setTaskName(flowElement.getName());
                    return processInstanceInfo;
                //流程删除存在出错视为审核终止
                } else if (historicProcessInstance.getDeleteReason() != null) {
                    processInstanceInfo.setExtendMessage(ExtendMessage.PROCESS_STOP);
                    processInstanceInfo.setTaskName(flowElement.getName());
                    processInstanceInfo.setDeleteReason(historicProcessInstance.getDeleteReason());
                    return processInstanceInfo;
                //自定义流程状态
                } else {
                    ExtendMessage extendMessage = ExtendMessage.getExtendMessage(processStatusInstance.getValue().toString());
                    processInstanceInfo.setExtendMessage(extendMessage);
                    processInstanceInfo.setTaskName(flowElement.getName());
                    return processInstanceInfo;
                }
                //如果历史中查询不到视为流程作废
            } else {
                processInstanceInfo.setExtendMessage(ExtendMessage.PROCESS_DELETED);
                processInstanceInfo.setTaskName(flowElement.getName());
                processInstanceInfo.setDeleteReason(historicProcessInstance.getDeleteReason());
                return processInstanceInfo;
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
    public IPage<ProcessInstanceInfoVo> selfProcessInstanceList(Map<String, Object> params) {
        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery()
                .startedBy(SecurityUtil.getUser().getId() + "").includeProcessVariables().orderByProcessInstanceStartTime().desc();

        String title = MapUtil.getStr(params, " title");
        Date beginTime = MapUtil.getDate(params, "beginTime"),
                endTime = MapUtil.getDate(params, "endTime");

        if (StrUtil.isNotBlank(title)) {
            query.variableValueLike(WorkflowConstant.TITLE, "%" + title + "%");
        }
        if (beginTime != null) {
            query.startedAfter(beginTime);
        }
        if (endTime != null) {
            query.startedBefore(endTime);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<HistoricProcessInstance> historicProcessInstanceList = query.involvedUser(SecurityUtil.getUser().getId() + "").listPage((current - 1) * size, size);

        for (HistoricProcessInstance historicProcessInstance : historicProcessInstanceList) {
            ProcessInstanceInfoVo processInstanceInfo = this.queryProcessState(historicProcessInstance.getId());
            processInstanceInfo.setEndTime(historicProcessInstance.getEndTime());
            processInstanceInfo.setStartTime(historicProcessInstance.getStartTime());
            processInstanceInfo.setProcessDefId(historicProcessInstance.getProcessDefinitionId());
            processInstanceInfo.setProcessInsId(historicProcessInstance.getId());
            processInstanceInfo.setProcessDefKey(historicProcessInstance.getProcessDefinitionKey());
            processInstanceInfo.setVars(historicProcessInstance.getProcessVariables());
            processInstanceInfo.setProcessDefName(historicProcessInstance.getProcessDefinitionName());
            processInstanceInfo.setVersion( historicProcessInstance.getProcessDefinitionVersion());
            result.getRecords().add(processInstanceInfo);
        }
        return result;
    }

    @Override
    public String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title, Map<String, Object> vars) {
        // 设置流程变量
        if(vars == null){
            vars = CollectionUtil.newHashMap();
        }

        // 可由外部提供流程发起人
        String userId = MapUtil.getStr(vars, WorkflowConstant.INITIATOR);
        if(userId == null){
            userId= SecurityUtil.getUser().getId() + "";
        }

        // 设置流程执行人
        vars.put(WorkflowConstant.USERNAME, SecurityUtil.getUser().getUsername());

        // 设置流程发起人
        identityService.setAuthenticatedUserId(userId);

        // 设置流程标题
        if (StrUtil.isNotBlank(title)) {
            vars.put(WorkflowConstant.TITLE, title);
        }

        // 启动流程实例
        String processInsId = runtimeService
                .startProcessInstanceByKey(processDefKey, String.join(":",businessTable,businessId), vars)
                .getProcessInstanceId();

        // 更新业务表流程实例ID,确保业务表字段process_ins_id存在
        Workflow workflow = new Workflow();
        workflow.setBusinessTable(businessTable);
        workflow.setBusinessId(businessId);
        workflow.setProcessInsId(processInsId);
        workflowMapper.updateProcessInsIdByBusinessId(workflow);
        return processInsId;
    }

    @Override
    public String startProcessDefinition(String processDefKey, String businessTable, String businessId, String title) {
        Map<String, Object> vars = CollectionUtil.newHashMap();
        return startProcessDefinition(processDefKey, businessTable, businessId, title, vars);
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

