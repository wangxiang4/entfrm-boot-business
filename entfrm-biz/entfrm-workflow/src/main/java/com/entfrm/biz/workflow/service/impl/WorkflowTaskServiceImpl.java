package com.entfrm.biz.workflow.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.workflow.constant.FlowableConstant;
import com.entfrm.biz.workflow.constant.SqlConstants;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.enums.ActionType;
import com.entfrm.biz.workflow.enums.ProcessStatus;
import com.entfrm.biz.workflow.execution.cmd.RollBackUserTaskCmd;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.service.WorkflowTaskService;
import com.entfrm.biz.workflow.util.workflowUtil;
import com.entfrm.biz.workflow.vo.HistoricTaskVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceVo;
import com.entfrm.biz.workflow.vo.TaskCommentVo;
import com.entfrm.biz.workflow.vo.TaskVo;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.FlowNode;
import org.flowable.bpmn.model.Process;
import org.flowable.editor.language.json.converter.util.CollectionUtils;
import org.flowable.engine.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.TaskQuery;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.api.history.HistoricTaskInstanceQuery;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.flowable.task.service.impl.persistence.entity.TaskEntityImpl;
import org.flowable.ui.modeler.serviceapi.ModelService;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.util.*;
import java.util.stream.Collectors;


/**
 *<p>
 * 流程任务 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Slf4j
@Service
@AllArgsConstructor
public class WorkflowTaskServiceImpl implements WorkflowTaskService {

    private final TaskService taskService;

    private final RuntimeService runtimeService;

    private final RepositoryService repositoryService;

    private final HistoryService historyService;

    private final WorkflowProcessService workflowProcessServices;

    private final FormService formService;

    private final ManagementService managementService;

    private final JdbcTemplate jdbcTemplate;

    private final ModelService modelService;

    @Override
    public IPage<ProcessInstanceVo> list(Map<String, Object> params) {
        // =============== 已经签收或者等待签收的任务  ===============
        TaskQuery query = taskService.createTaskQuery()
                .taskCandidateOrAssigned(SecurityUtil.getUser().getId() + "").active()
                .includeProcessVariables().orderByTaskCreateTime().desc();

        // 设置查询条件
        String processDefKey = MapUtil.getStr(params, "processDefKey"),
               title = MapUtil.getStr(params, " title");
        Date beginDate = MapUtil.getDate(params, "beginDate"),
             endDate = MapUtil.getDate(params, "endDate");

        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }
        if (StrUtil.isNotBlank (title)) {
            query.processVariableValueLike(FlowableConstant.TITLE, "%" + title + "%");
        }
        if (beginDate != null) {
            query.taskCreatedAfter(beginDate);
        }
        if (endDate != null) {
            query.taskCreatedBefore(endDate);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<Task> taskList = query.listPage((current - 1) * size, size);

        for (Task task : taskList) {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId()).singleResult();
            ProcessInstanceVo processInstanceVo = new ProcessInstanceVo();
            TaskVo taskVo = new TaskVo (task);
            taskVo.setProcessDefKey(processDefinition.getKey());
            processInstanceVo.setTask(taskVo);
            processInstanceVo.setVars(task.getProcessVariables());
            processInstanceVo.setProcessDefinitionName(processDefinition.getName());
            processInstanceVo.setVersion(processDefinition.getVersion());
            processInstanceVo.setStatus ("todo");
            result.getRecords().add(processInstanceVo);
        }

        return result;
    }

    @Override
    public IPage<HistoricTaskVo> historicList(Map<String, Object> params) {
        HistoricTaskInstanceQuery query = historyService.createHistoricTaskInstanceQuery()
                .taskAssignee(SecurityUtil.getUser().getId() + "").finished()
                .includeProcessVariables().orderByHistoricTaskInstanceEndTime().desc();

        // 设置查询条件
        String processDefKey = MapUtil.getStr(params, "processDefKey"),
                title = MapUtil.getStr(params, " title");
        Date beginDate = MapUtil.getDate(params, "beginDate"),
                endDate = MapUtil.getDate(params, "endDate");

        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }
        if (StrUtil.isNotBlank (title)) {
            query.processVariableValueLike(FlowableConstant.TITLE, "%" + title + "%");
        }
        if (beginDate != null) {
            query.taskCreatedAfter(beginDate);
        }
        if (endDate != null) {
            query.taskCreatedBefore(endDate);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        List<HistoricTaskInstance> historicTaskList = query.listPage((current - 1) * size, size);

        for (HistoricTaskInstance historicTask : historicTaskList) {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(historicTask.getProcessDefinitionId()).singleResult();
            HistoricTaskVo historicTaskVo = new HistoricTaskVo();
            historicTaskVo.setProcessDefinitionName(processDefinition.getName());
            historicTaskVo.setRollBack(this.rollBackTask(historicTask));
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(historicTask.getProcessInstanceId()).list();
            if (taskList.size() > 0) {
                TaskVo currentTaskVo = new TaskVo(taskList.get(0));
                historicTaskVo.setCurrentTask(currentTaskVo);
            }
            // 获取意见评论内容
            List<TaskCommentVo> commentList = this.getTaskComments(historicTask.getId());
            if (commentList.size () > 0) {
                TaskCommentVo comment = commentList.get(commentList.size()-1);
                historicTaskVo.setComment(comment.getMessage());
                historicTaskVo.setLevel(comment.getLevel());
                historicTaskVo.setType(comment.getType());
                historicTaskVo.setStatus(comment.getStatus());
            }
            result.getRecords().add(historicTaskVo);
        }
        return result;
    }

    @Override
    public List<Workflow> historicFlowChangeList(String processInsId) {
        List<HistoricActivityInstance> historicActivityInstances = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId (processInsId).orderByHistoricActivityInstanceStartTime().asc()
                .orderByHistoricActivityInstanceEndTime().asc().list();

        List<Workflow> historicFlowChangeList = new ArrayList();
        for (int i = 0; i < historicActivityInstances.size (); i++) {
            HistoricActivityInstance historicActivityInstance = historicActivityInstances.get(i);
            // 只显示开始节点和结束节点,并且执行人不为空的任务
            if (StrUtil.isNotBlank(historicActivityInstance.getAssignee())
                    && historyService.createHistoricTaskInstanceQuery().taskId(historicActivityInstance.getTaskId()).count() != 0
                    || BpmnXMLConstants.ELEMENT_TASK_USER.equals(historicActivityInstance.getActivityType())
                    && historicActivityInstance.getEndTime() == null
                    || BpmnXMLConstants.ELEMENT_EVENT_START.equals (historicActivityInstance.getActivityType())
                    || BpmnXMLConstants.ELEMENT_EVENT_END.equals (historicActivityInstance.getActivityType())) {
                // 获取流程发起人名称
                Workflow workflow = this.queryTaskState (historicActivityInstance);
                historicFlowChangeList.add(workflow);
            }
        }
        return historicFlowChangeList;
    }

    @Override
    public String getTaskFormKey(String processDefId, String taskDefKey) {
        String formKey = "";
        if (StrUtil.isNotBlank(processDefId)) {
            if (StrUtil.isNotBlank(taskDefKey)) {
                try {
                    formKey = formService.getTaskFormKey(processDefId, taskDefKey);
                } catch (Exception e) {
                    formKey = "";
                }
            }
            if (StrUtil.isBlank (formKey)) {
                formKey = formService.getStartFormKey(processDefId);
            }
            if (StrUtil.isBlank (formKey)) {
                formKey = "/404";
            }
        }
        return formKey;
    }

    @Override
    public void removeTask(String taskId, String reason) {
        taskService.deleteTask (taskId, reason);
    }

    @Override
    public void claim(String taskId, String userId) {
        taskService.claim (taskId, userId);
    }

    @Override
    public void complete(Workflow workFlow){
        //添加意见
        if(StrUtil.isNotBlank(workFlow.getProcInsId())){
            taskService.addComment(
                    workFlow.getTaskId(),
                    workFlow.getProcInsId(),
                    workFlow.getComment().getCommentType(),
                    workFlow.getComment().getFullMessage());
        }

        // 设置流程变量
        Map<String,Object> processVars = workFlow.getProcessVars().getMap();

        // 设置流程标题
        if (StrUtil.isNotBlank(workFlow.getTitle())) {
            processVars.put(FlowableConstant.TITLE, workFlow.getTitle());
        }

        Task task = taskService.createTaskQuery().taskId(workFlow.getTaskId()).singleResult();
        // owner不为空说明可能存在委托任务
        if (StrUtil.isNotBlank(task.getOwner())){
            DelegationState delegationState = task.getDelegationState ();
            switch (delegationState) {
                case PENDING:
                    taskService.resolveTask(workFlow.getTaskId());
                    taskService.complete (workFlow.getTaskId(), processVars);
                    break;
                case RESOLVED:
                    System.out.println("委托任务已经完成");
                    break;
                default:
                    //不是委托任务
                    taskService.complete(workFlow.getTaskId(), processVars);
                    break;
            }
            // 未签收任务
        } else if(StrUtil.isBlank(task.getAssignee())){
            // 签收任务
            taskService.claim (workFlow.getTaskId(),SecurityUtil.getUser().getId() + "");
            // 提交任务
            taskService.complete (workFlow.getTaskId (), processVars);
        } else  {
            // 提交任务
            taskService.complete (workFlow.getTaskId (), processVars);
        }
    }

    @Override
    public Map getPaintDiagramXml(String processInsId) {
        Map result = new HashMap ();
        String processDefId;
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
        // 获取流程定义ID
        if (processInstance == null) {
            processDefId = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInsId).singleResult().getProcessDefinitionId();
        } else {
            processDefId = processInstance.getProcessDefinitionId();
        }
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefId);
        List<HistoricActivityInstance> historicActivityInstanceList =  historyService.createHistoricActivityInstanceQuery()
                .processInstanceId (processInsId).finished()
                .orderByHistoricActivityInstanceEndTime().asc().list();

        // 收集需要涂抹颜色的活动与流转线
        Set<String> activityIds = new LinkedHashSet();
        List<String> flows = new ArrayList();
        for (HistoricActivityInstance historicActivityInstance : historicActivityInstanceList) {
            String activityType = historicActivityInstance.getActivityType();
            if (activityType.equals(BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW) || activityType.equals(BpmnXMLConstants.ELEMENT_GATEWAY_EXCLUSIVE)) {
                flows.add (historicActivityInstance.getActivityId());
            } else if (StrUtil.isNotBlank(historicActivityInstance.getAssignee())
                    && historyService.createHistoricTaskInstanceQuery().taskId(historicActivityInstance.getTaskId()).count() != 0
                    || BpmnXMLConstants.ELEMENT_TASK_USER.equals(historicActivityInstance.getActivityType()) && historicActivityInstance.getEndTime() == null
                    || BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())
                    || BpmnXMLConstants.ELEMENT_EVENT_END.equals (historicActivityInstance.getActivityType())) {
                activityIds.add (historicActivityInstance.getActivityId());
            }
        }
        List<Task> tasks = taskService.createTaskQuery().processInstanceId(processInsId).list();
        for (Task task : tasks) {
            activityIds.add(task.getTaskDefinitionKey());
        }
        byte[] bpmnBytes = modelService.getBpmnXML(bpmnModel);
        result.put("bpmnXml", new String(bpmnBytes));
        result.put("flows", flows);
        result.put("activityIds", activityIds);
        return result;
    }

    @Override
    public void auditTask(Workflow workFlow) {
        complete(workFlow);
    }

    @Override
    public void rollBackTask(String rollBackTaskDefKey, String currentTaskId, TaskCommentVo taskCommentVo) {
        Task task = taskService.createTaskQuery().taskId(currentTaskId).singleResult();
        if(StrUtil.isBlank(task.getAssignee())){
            //代理人为空自己签收任务
            taskService.claim (currentTaskId, SecurityUtil.getUser().getUsername());
        }
        // 退回发起者处理,退回到发起者,默认设置任务执行人为发起者
        ActivityInstance targetRealActivityInstance = runtimeService.createActivityInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).activityId(rollBackTaskDefKey).list().get(0);
        if (targetRealActivityInstance.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START)) {
            workflowProcessServices.stopProcessInstance(task.getProcessInstanceId(), ProcessStatus.REJECT, taskCommentVo.getMessage());
        } else {
            taskService.addComment (currentTaskId,task.getProcessInstanceId(), taskCommentVo.getCommentType(), taskCommentVo.getFullMessage());
            managementService.executeCommand (new RollBackUserTaskCmd(runtimeService, currentTaskId, rollBackTaskDefKey));
        }
    }

    @Override
    public List<Workflow> rollBackTaskList(String taskId) {
        Task task = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = task.getProcessInstanceId();
        String currentActivityId = task.getTaskDefinitionKey();
        String processDefinitionId = task.getProcessDefinitionId();
        Process process = repositoryService.getBpmnModel(processDefinitionId).getMainProcess();
        FlowNode currentFlowElement = (FlowNode) process.getFlowElement(currentActivityId, true);

        //获取已经完成的活动节点
        List<ActivityInstance> activityInstanceList = runtimeService.createActivityInstanceQuery()
                .processInstanceId(processInstanceId).finished().orderByActivityInstanceStartTime().asc().list();

        //获取已经完成节点的活动ID
        List<String> activityIds = activityInstanceList.stream().filter(activity -> activity.getActivityType()
                .equals(BpmnXMLConstants.ELEMENT_TASK_USER) || activity.getActivityType()
                .equals(BpmnXMLConstants.ELEMENT_EVENT_START))
                .filter(activity ->!activity.getActivityId().equals (currentActivityId))
                .map(ActivityInstance::getActivityId).distinct().collect(Collectors.toList());

        List<Workflow> result = new ArrayList<> ();
        for (String activityId : activityIds) {
            FlowNode rollBackFlowElement = (FlowNode) process.getFlowElement(activityId, true);

            //目标节点是否可以到达
            if (workflowUtil.isReachable(process, rollBackFlowElement, currentFlowElement)){
                Workflow workflow = new Workflow();
                workflow.setTaskDefKey(activityId);
                workflow.setTaskName(rollBackFlowElement.getName());
                workflow.setTaskId(activityId);
                result.add(workflow);
            }
        }
        return result;
    }

    @Override
    public void addSignTask(String taskId, List<Integer> userIds, String comment, Boolean mark) throws Exception {
        TaskEntityImpl taskEntity = (TaskEntityImpl) taskService.createTaskQuery().taskId(taskId).singleResult();
        if (taskEntity != null) {
            String parentTaskId = taskEntity.getParentTaskId();
            // 加签任务是没有父任务ID的,如果是加签节点创建的话,在加一个父节点
            if (StrUtil.isBlank(parentTaskId)) {
                taskEntity.setOwner(SecurityUtil.getUser().getId() + "");
                taskEntity.setAssignee(null);
                taskEntity.setCountEnabled(true);
                if (mark) {
                    taskEntity.setScopeType(FlowableConstant.AFTER_ADD_SIGN);
                } else {
                    taskEntity.setScopeType(FlowableConstant.BEFORE_ADD_SIGN);
                }
                taskService.saveTask(taskEntity);
            }
            this.createAddSignSubTasks(userIds, taskEntity);
            String type = mark ? ActionType.ADD_AFTER_MULTI_INSTANCE.toString() : ActionType.ADD_BEFORE_MULTI_INSTANCE.toString();
            taskService.addComment (taskId, taskEntity.getProcessInstanceId (), type, comment);
        } else {
            throw  new Exception ("不存在任务实例,请确认!");
        }
    }

    /** 是否可以回滚任务 */
    private boolean rollBackTask(HistoricTaskInstance historicTask) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(historicTask.getProcessInstanceId()).singleResult();
        if (processInstance != null) {
            if (!processInstance.isSuspended()) {
                Task currentTask = taskService.createTaskQuery().processInstanceId(historicTask.getProcessInstanceId()).list().get(0);
                HistoricTaskInstance lastHisTask = historyService.createHistoricTaskInstanceQuery()
                        .processInstanceId(historicTask.getProcessInstanceId()).finished().includeProcessVariables().orderByHistoricTaskInstanceEndTime().desc().list().get(0);
                // 用户已签收
                if (currentTask.getClaimTime() != null) return false;
                if (historicTask.getId().equals(lastHisTask.getId())) return true;
            }
        }
        return false;
    }

    /** 获取任务意见评论内容 */
    private List<TaskCommentVo> getTaskComments(String taskId) {
        return jdbcTemplate.query(SqlConstants.QUERY_ACT_HI_COMMENT, new String[]{ TaskCommentVo.prefix + "%", taskId } ,(ResultSet rs, int rowNum) -> {
            TaskCommentVo taskComment = new TaskCommentVo();
            taskComment.setCommentType (rs.getString ("TYPE_"));
            taskComment.setFullMessage (new String(rs.getBytes ("FULL_MSG_")));
            return taskComment;
        });
    }

    /** 获取任务节点状态 */
    public Workflow queryTaskState(HistoricActivityInstance historicActivityInstance) {
        Workflow workflow = new Workflow();
        workflow.setHistIns(historicActivityInstance);

        // 获取开始事件流程发起人名称
        if (BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())) {
            List<HistoricProcessInstance> historicProcessInstanceList = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(historicActivityInstance.getProcessInstanceId())
                    .orderByProcessInstanceStartTime().asc().list();
            if (historicProcessInstanceList.size() > 0) {
                if (StrUtil.isNotBlank(historicProcessInstanceList.get(0).getStartUserId())) {
                    Map<String, Object> user = jdbcTemplate.queryForMap(SqlConstants.QUERY_USER, historicProcessInstanceList.get(0).getStartUserId());
                    if (user != null) {
                        workflow.setAssignee(historicActivityInstance.getAssignee());
                        workflow.setAssigneeName(MapUtil.getStr(user, "name"));
                    }
                }
            }
            TaskCommentVo taskCommentVo = new TaskCommentVo();
            taskCommentVo.setStatus(FlowableConstant.START_EVENT_LABEL);
            taskCommentVo.setMessage (FlowableConstant.START_EVENT_COMMENT);
            workflow.setComment(taskCommentVo);
            return workflow;
        }

        // 获取结束事件信息
        if (BpmnXMLConstants.ELEMENT_EVENT_END.equals(historicActivityInstance.getActivityType())) {
            TaskCommentVo taskCommentVo = new TaskCommentVo();
            taskCommentVo.setStatus(FlowableConstant.END_EVENT_LABEL);
            taskCommentVo.setMessage(FlowableConstant.END_EVENT_COMMENT);
            workflow.setAssigneeName(FlowableConstant.SYSTEM_EVENT_COMMENT);
            workflow.setComment(taskCommentVo);
            return workflow;
        }

        // 获取任务执行人名称
        if (StrUtil.isNotEmpty(historicActivityInstance.getAssignee())) {
            Map<String, Object> user = jdbcTemplate.queryForMap(SqlConstants.QUERY_USER,historicActivityInstance.getAssignee());
            if (user != null) {
                workflow.setAssignee(historicActivityInstance.getAssignee());
                workflow.setAssigneeName(MapUtil.getStr(user, "name"));
            }
        }

        // 获取意见评论内容
        if (StrUtil.isNotBlank(historicActivityInstance.getTaskId())) {
            List<TaskCommentVo> commentList = this.getTaskComments(historicActivityInstance.getTaskId());
            if (commentList.size () > 0) {
                TaskCommentVo comment = commentList.get(commentList.size ()-1);
                workflow.setComment(comment);
            }
        }

        // 获取等待执行的任务
        if(historicActivityInstance.getEndTime () == null) {
            TaskCommentVo taskComment = new TaskCommentVo();
            taskComment.setStatus(ActionType.WAITING.getStatus());
            taskComment.setMessage(FlowableConstant.WAITING_EVENT_COMMENT);
            workflow.setComment (taskComment);
        }
        return workflow;
    }

    /** 创建加签子任务 */
    private void createAddSignSubTasks(List<Integer> userIds, TaskEntity taskEntity) {
        if (CollectionUtils.isNotEmpty(userIds)) {
            String parentTaskId = taskEntity.getParentTaskId();
            if (StrUtil.isBlank(parentTaskId)) {
                parentTaskId = taskEntity.getId();
            }
            String finalParentTaskId = parentTaskId;
            userIds.forEach(assignee -> {
                if (ObjectUtil.isNotEmpty(assignee)) {
                    this.createSubTask(taskEntity, finalParentTaskId, assignee + "");
                }
            });
            String taskId = taskEntity.getId();
            if (StrUtil.isBlank(taskEntity.getParentTaskId())) {
                Task task = this.createSubTask(taskEntity, finalParentTaskId, SecurityUtil.getUser().getId() + "");
                taskId = task.getId();
            }
            Task taskInfo = taskService.createTaskQuery().taskId(taskId).singleResult();
            if (null != taskInfo) {
                taskService.complete(taskId);
            }
            long candidateCount = taskService.createTaskQuery().taskId(parentTaskId).taskCandidateUser(SecurityUtil.getUser().getId() + "").count();
            if (candidateCount > 0) taskService.deleteCandidateUser(parentTaskId, SecurityUtil.getUser().getId() + "");
        }
    }

    /** 创建加签子任务 */
    private TaskEntity createSubTask(TaskEntity taskEntity, String parentTaskId, String assignee) {
        TaskEntity task = null;
        if (taskEntity != null) {
            task = (TaskEntity) taskService.newTask(UUID.randomUUID().toString());
            task.setCategory(taskEntity.getCategory());
            task.setDescription(taskEntity.getDescription());
            task.setTenantId(taskEntity.getTenantId());
            task.setAssignee(assignee);
            task.setName(taskEntity.getName());
            task.setParentTaskId(parentTaskId);
            task.setProcessDefinitionId(taskEntity.getProcessDefinitionId());
            task.setProcessInstanceId(taskEntity.getProcessInstanceId());
            task.setTaskDefinitionKey(taskEntity.getTaskDefinitionKey());
            task.setTaskDefinitionId(taskEntity.getTaskDefinitionId());
            task.setPriority(taskEntity.getPriority());
            task.setCreateTime(new Date());
            taskService.saveTask(task);
        }
        return task;
    }

}
