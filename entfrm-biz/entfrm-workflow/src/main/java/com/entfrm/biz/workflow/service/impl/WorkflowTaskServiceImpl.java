package com.entfrm.biz.workflow.service.impl;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.workflow.cmd.RollBackUserTaskCmd;
import com.entfrm.biz.workflow.constant.SqlConstants;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.enums.ExtendMessage;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.service.WorkflowTaskService;
import com.entfrm.biz.workflow.util.WorkflowUtil;
import com.entfrm.biz.workflow.vo.ActivityCommentInfoVo;
import com.entfrm.biz.workflow.vo.HistoryTaskInfoVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceInfoVo;
import com.entfrm.biz.workflow.vo.TaskInfoVo;
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
    public IPage<ProcessInstanceInfoVo> list(Map<String, Object> params) {
        // =============== 已经签收或者等待签收的任务  ===============
        TaskQuery query = taskService.createTaskQuery()
                .taskCandidateOrAssigned(SecurityUtil.getUser().getId() + "").active()
                .includeProcessVariables().orderByTaskCreateTime().desc();

        // 设置查询条件
        String processDefKey = MapUtil.getStr(params, "processDefKey"),
               title = MapUtil.getStr(params, " title");
        Date beginTime = MapUtil.getDate(params, "beginTime"),
             endTime = MapUtil.getDate(params, "endTime");

        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }
        if (StrUtil.isNotBlank(title)) {
            query.processVariableValueLike(WorkflowConstant.TITLE, "%" + title + "%");
        }
        if (beginTime != null) {
            query.taskCreatedAfter(beginTime);
        }
        if (endTime != null) {
            query.taskCreatedBefore(endTime);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<Task> taskList = query.listPage((current - 1) * size, size);

        for (Task task : taskList) {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(task.getProcessDefinitionId()).singleResult();
            ProcessInstanceInfoVo processInstanceInfo = new ProcessInstanceInfoVo();
            TaskInfoVo taskInfo = new TaskInfoVo(task);
            taskInfo.setProcessDefKey(processDefinition.getKey());
            processInstanceInfo.setTaskInfo(taskInfo);
            processInstanceInfo.setVars(task.getProcessVariables());
            processInstanceInfo.setProcessDefName(processDefinition.getName());
            processInstanceInfo.setVersion(processDefinition.getVersion());
            processInstanceInfo.setMesName("todo");
            result.getRecords().add(processInstanceInfo);
        }

        return result;
    }

    @Override
    public IPage<HistoryTaskInfoVo> historyList(Map<String, Object> params) {
        HistoricTaskInstanceQuery query = historyService.createHistoricTaskInstanceQuery()
                .taskAssignee(SecurityUtil.getUser().getId() + "").finished()
                .includeProcessVariables().orderByHistoricTaskInstanceEndTime().desc();

        // 设置查询条件
        String processDefKey = MapUtil.getStr(params, "processDefKey"),
                title = MapUtil.getStr(params, " title");
        Date beginTime = MapUtil.getDate(params, "beginTime"),
                endTime = MapUtil.getDate(params, "endTime");

        if (StrUtil.isNotBlank(processDefKey)) {
            query.processDefinitionKey(processDefKey);
        }
        if (StrUtil.isNotBlank(title)) {
            query.processVariableValueLike(WorkflowConstant.TITLE, "%" + title + "%");
        }
        if (beginTime != null) {
            query.taskCreatedAfter(beginTime);
        }
        if (endTime != null) {
            query.taskCreatedBefore(endTime);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(query.count());
        result.setRecords(CollectionUtil.newArrayList());
        List<HistoricTaskInstance> historicTaskList = query.listPage((current - 1) * size, size);

        for (HistoricTaskInstance historicTask : historicTaskList) {
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(historicTask.getProcessDefinitionId()).singleResult();
            HistoryTaskInfoVo HistoryTaskInfo = new HistoryTaskInfoVo();
            HistoryTaskInfo.setProcessDefName(processDefinition.getName());
            HistoryTaskInfo.setRollBack(this.rollBackTask(historicTask));
            List<Task> taskList = taskService.createTaskQuery().processInstanceId(historicTask.getProcessInstanceId()).list();
            if (taskList.size() > 0) {
                TaskInfoVo taskInfo = new TaskInfoVo(taskList.get(0));
                HistoryTaskInfo.setTaskInfo(taskInfo);
            }
            // 获取意见评论内容
            List<ActivityCommentInfoVo> activityCommentInfoList = this.getTaskComments(historicTask.getId());
            if (activityCommentInfoList.size() > 0) {
                ActivityCommentInfoVo activityCommentInfo = activityCommentInfoList.get(activityCommentInfoList.size()-1);
                HistoryTaskInfo.setComment(activityCommentInfo.getMessage());
                HistoryTaskInfo.setMesLevel(activityCommentInfo.getMesLevel());
                HistoryTaskInfo.setMesCode(activityCommentInfo.getMesCode());
                HistoryTaskInfo.setMesName(activityCommentInfo.getMesName());
            }
            result.getRecords().add(HistoryTaskInfo);
        }
        return result;
    }

    @Override
    public List<Workflow> historyFlowChangeList(String processInsId) {
        List<HistoricActivityInstance> historicActivityInstances = historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInsId).orderByHistoricActivityInstanceStartTime().asc()
                .orderByHistoricActivityInstanceEndTime().asc().list();

        List<Workflow> historicFlowChangeList = new ArrayList();
        for (int i = 0; i < historicActivityInstances.size(); i++) {
            HistoricActivityInstance historicActivityInstance = historicActivityInstances.get(i);
            // 只显示开始节点和结束节点,并且执行人不为空的任务
            if (StrUtil.isNotBlank(historicActivityInstance.getAssignee())
                    && historyService.createHistoricTaskInstanceQuery().taskId(historicActivityInstance.getTaskId()).count() != 0
                    || BpmnXMLConstants.ELEMENT_TASK_USER.equals(historicActivityInstance.getActivityType())
                    && historicActivityInstance.getEndTime() == null
                    || BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())
                    || BpmnXMLConstants.ELEMENT_EVENT_END.equals(historicActivityInstance.getActivityType())) {
                // 获取流程发起人名称
                Workflow workflow = this.queryTaskState(historicActivityInstance);
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
            if (StrUtil.isBlank(formKey)) {
                formKey = formService.getStartFormKey(processDefId);
            }
            if (StrUtil.isBlank(formKey)) {
                formKey = "/404";
            }
        }
        return formKey;
    }

    @Override
    public void removeTask(String taskId, String reason) {
        taskService.deleteTask(taskId, reason);
    }

    @Override
    public void claim(String taskId, String userId) {
        taskService.claim(taskId, userId);
    }

    @Override
    public void complete(Workflow workFlow){
        //添加意见
        if(StrUtil.isNotBlank(workFlow.getProcessInsId())){
            taskService.addComment(
                    workFlow.getTaskId(),
                    workFlow.getProcessInsId(),
                    workFlow.getActivityCommentInfo().getExtendMessage(),
                    workFlow.getActivityCommentInfo().getCombinationMessage());
        }

        // 设置流程变量
        Map<String,Object> processVars = workFlow.getVars();

        // 设置流程标题
        if (StrUtil.isNotBlank(workFlow.getTitle())) {
            processVars.put(WorkflowConstant.TITLE, workFlow.getTitle());
        }

        Task task = taskService.createTaskQuery().taskId(workFlow.getTaskId()).singleResult();
        // owner不为空说明可能存在委托任务
        if (StrUtil.isNotBlank(task.getOwner())){
            DelegationState delegationState = task.getDelegationState();
            switch (delegationState) {
                case PENDING:
                    taskService.resolveTask(workFlow.getTaskId());
                    taskService.complete(workFlow.getTaskId(), processVars);
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
            taskService.claim(workFlow.getTaskId(),SecurityUtil.getUser().getId() + "");
            // 提交任务
            taskService.complete(workFlow.getTaskId(), processVars);
        } else  {
            // 提交任务
            taskService.complete(workFlow.getTaskId(), processVars);
        }
    }

    @Override
    public Map getPaintDiagramXml(String processInsId) {
        Map result = CollectionUtil.newHashMap();
        String processDefId;
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
        // 获取流程定义ID
        if(processInstance == null) {
            processDefId = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInsId).singleResult().getProcessDefinitionId();
        } else {
            processDefId = processInstance.getProcessDefinitionId();
        }
        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefId);
        List<HistoricActivityInstance> historicActivityInstanceList =  historyService.createHistoricActivityInstanceQuery()
                .processInstanceId(processInsId).finished()
                .orderByHistoricActivityInstanceEndTime().asc().list();

        // 收集需要涂抹颜色的活动与流转线
        Set<String> activityIds = new LinkedHashSet();
        List<String> flows = new ArrayList();
        for (HistoricActivityInstance historicActivityInstance : historicActivityInstanceList) {
            String activityType = historicActivityInstance.getActivityType();
            if (activityType.equals(BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW) || activityType.equals(BpmnXMLConstants.ELEMENT_GATEWAY_EXCLUSIVE)) {
                flows.add(historicActivityInstance.getActivityId());
            } else if (StrUtil.isNotBlank(historicActivityInstance.getAssignee())
                    && historyService.createHistoricTaskInstanceQuery().taskId(historicActivityInstance.getTaskId()).count() != 0
                    || BpmnXMLConstants.ELEMENT_TASK_USER.equals(historicActivityInstance.getActivityType()) && historicActivityInstance.getEndTime() == null
                    || BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())
                    || BpmnXMLConstants.ELEMENT_EVENT_END.equals(historicActivityInstance.getActivityType())) {
                activityIds.add(historicActivityInstance.getActivityId());
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
    public void rollBackTask(String rollBackTaskDefKey, String currentTaskId, ActivityCommentInfoVo activityCommentInfo) {
        Task task = taskService.createTaskQuery().taskId(currentTaskId).singleResult();
        if(StrUtil.isBlank(task.getAssignee())){
            //代理人为空自己签收任务
            taskService.claim(currentTaskId, SecurityUtil.getUser().getId() + "");
        }
        // 退回发起者处理,退回到发起者,默认设置任务执行人为发起者
        ActivityInstance targetRealActivityInstance = runtimeService.createActivityInstanceQuery()
                .processInstanceId(task.getProcessInstanceId()).activityId(rollBackTaskDefKey).list().get(0);
        if (targetRealActivityInstance.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START)) {
            workflowProcessServices.stopProcessInstance(task.getProcessInstanceId(), ExtendMessage.PROCESS_REJECT, activityCommentInfo.getMessage());
        } else {
            taskService.addComment(currentTaskId,task.getProcessInstanceId(), activityCommentInfo.getExtendMessage(), activityCommentInfo.getCombinationMessage());
            managementService.executeCommand(new RollBackUserTaskCmd(runtimeService, currentTaskId, rollBackTaskDefKey));
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
                .filter(activity ->!activity.getActivityId().equals(currentActivityId))
                .map(ActivityInstance::getActivityId).distinct().collect(Collectors.toList());

        List<Workflow> result = CollectionUtil.newArrayList();
        for (String activityId : activityIds) {
            FlowNode rollBackFlowElement = (FlowNode) process.getFlowElement(activityId, true);

            //目标节点是否可以到达
            if (WorkflowUtil.isReachable(process, rollBackFlowElement, currentFlowElement)){
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
    public Map getDiagram(String processInsId) {
        Map m = new HashMap ();
        try {
            String processDefId;
            ProcessInstance pi = runtimeService.createProcessInstanceQuery().processInstanceId(processInsId).singleResult();
            //流程走完的不显示图
            if (pi == null) {
                processDefId = historyService.createHistoricProcessInstanceQuery ().processInstanceId (processInsId).singleResult ().getProcessDefinitionId ();
            } else {
                processDefId = pi.getProcessDefinitionId ();
            }
            BpmnModel bpmnModel = repositoryService.getBpmnModel (processDefId);
            List<HistoricActivityInstance> historyProcess = historyService // 历史相关Service
                    .createHistoricActivityInstanceQuery () // 创建历史活动实例查询
                    .processInstanceId (processInsId) // 执行流程实例id
                    .finished ().orderByHistoricActivityInstanceEndTime ().asc ()
                    .list ();
            Set<String> activityIds = new LinkedHashSet<> ();
            List<String> flows = new ArrayList<> ();
            for (HistoricActivityInstance hi : historyProcess) {
                String activityType = hi.getActivityType ();
                if (activityType.equals (BpmnXMLConstants.ELEMENT_SEQUENCE_FLOW) || activityType.equals (BpmnXMLConstants.ELEMENT_GATEWAY_EXCLUSIVE)) {
                    flows.add (hi.getActivityId ());
                } else  if (StrUtil.isNotBlank (hi.getAssignee ())
                        && historyService.createHistoricTaskInstanceQuery ().taskId (hi.getTaskId ()).count () != 0
                        || BpmnXMLConstants.ELEMENT_TASK_USER.equals (hi.getActivityType ()) && hi.getEndTime () == null
                        || BpmnXMLConstants.ELEMENT_EVENT_START.equals (hi.getActivityType ())
                        || BpmnXMLConstants.ELEMENT_EVENT_END.equals (hi.getActivityType ())) {
                    activityIds.add (hi.getActivityId ());
                }
            }
            List<Task> tasks = taskService.createTaskQuery ().processInstanceId (processInsId).list ();
            for (Task task : tasks) {
                activityIds.add (task.getTaskDefinitionKey ());
            }
            byte[] bpmnBytes = modelService.getBpmnXML(bpmnModel);
            m.put ("bpmnXml", new String (bpmnBytes));
            m.put ("flows", flows);
            m.put ("activityIds", activityIds);
            return m;
        } catch (Exception e) {
            e.printStackTrace ();
        }
        return null;
    }

    @Override
    public void addSignTask(String taskId, List<String> userIds, String comment, Boolean mark) throws Exception {
        TaskEntityImpl taskEntity = (TaskEntityImpl) taskService.createTaskQuery().taskId(taskId).singleResult();
        if (taskEntity != null) {
            String parentTaskId = taskEntity.getParentTaskId();
            // 加签任务是没有父任务ID的,如果是加签节点创建的话,在加一个父节点
            if (StrUtil.isBlank(parentTaskId)) {
                taskEntity.setOwner(SecurityUtil.getUser().getId() + "");
                taskEntity.setAssignee(null);
                taskEntity.setCountEnabled(true);
                if (mark) {
                    taskEntity.setScopeType(WorkflowConstant.AFTER_ADD_SIGN);
                } else {
                    taskEntity.setScopeType(WorkflowConstant.BEFORE_ADD_SIGN);
                }
                taskService.saveTask(taskEntity);
            }
            this.createAddSignSubTasks(userIds, taskEntity);
            String type = mark ? ExtendMessage.ACTIVITY_ADD_AFTER_MULTI_INSTANCE.toString() : ExtendMessage.ACTIVITY_ADD_BEFORE_MULTI_INSTANCE.toString();
            taskService.addComment(taskId, taskEntity.getProcessInstanceId(), type, comment);
        } else {
            throw  new Exception("不存在任务实例,请确认!");
        }
    }

    /** 是否可以回滚任务 */
    private boolean rollBackTask(HistoricTaskInstance historicTaskInstance) {
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery()
                .processInstanceId(historicTaskInstance.getProcessInstanceId()).singleResult();
        if (processInstance != null) {
            if (!processInstance.isSuspended()) {
                Task currentTask = taskService.createTaskQuery().processInstanceId(historicTaskInstance.getProcessInstanceId()).list().get(0);
                HistoricTaskInstance lastHisTask = historyService.createHistoricTaskInstanceQuery()
                        .processInstanceId(historicTaskInstance.getProcessInstanceId()).finished().includeProcessVariables().orderByHistoricTaskInstanceEndTime().desc().list().get(0);
                // 用户已签收
                if (currentTask.getClaimTime() != null) return false;
                if (historicTaskInstance.getId().equals(lastHisTask.getId())) return true;
            }
        }
        return false;
    }

    /** 获取任务意见评论内容 */
    private List<ActivityCommentInfoVo> getTaskComments(String taskId) {
        return jdbcTemplate.query(SqlConstants.QUERY_ACT_HI_COMMENT, new String[]{ WorkflowConstant.COMMENT_TYPE_PREFIX + "%", taskId } ,(ResultSet rs, int rowNum) -> {
            ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
            activityCommentInfo.setExtendMessage(rs.getString("TYPE_"));
            activityCommentInfo.setCombinationMessage(new String(rs.getBytes("FULL_MSG_")));
            return activityCommentInfo;
        });
    }

    /** 获取任务节点状态 */
    public Workflow queryTaskState(HistoricActivityInstance historicActivityInstance) {
        Workflow workflow = new Workflow();
        workflow.setHistoricActivityInstance(historicActivityInstance);

        // 获取开始事件流程发起人名称
        if (BpmnXMLConstants.ELEMENT_EVENT_START.equals(historicActivityInstance.getActivityType())) {
            List<HistoricProcessInstance> historicProcessInstanceList = historyService.createHistoricProcessInstanceQuery()
                    .processInstanceId(historicActivityInstance.getProcessInstanceId())
                    .orderByProcessInstanceStartTime().asc().list();
            if (historicProcessInstanceList.size() > 0) {
                if (StrUtil.isNotBlank(historicProcessInstanceList.get(0).getStartUserId())) {
                    Map<String, Object> user = jdbcTemplate.queryForMap(SqlConstants.QUERY_USER_BY_ID, historicProcessInstanceList.get(0).getStartUserId());
                    if (user != null) {
                        workflow.setAssignee(historicActivityInstance.getAssignee());
                        workflow.setAssigneeName(MapUtil.getStr(user, "userName"));
                    }
                }
            }
            ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
            activityCommentInfo.setMesName(WorkflowConstant.START_EVENT_LABEL);
            activityCommentInfo.setMessage(WorkflowConstant.START_EVENT_COMMENT);
            workflow.setActivityCommentInfo(activityCommentInfo);
            return workflow;
        }

        // 获取结束事件信息
        if (BpmnXMLConstants.ELEMENT_EVENT_END.equals(historicActivityInstance.getActivityType())) {
            ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
            activityCommentInfo.setMesName(WorkflowConstant.END_EVENT_LABEL);
            activityCommentInfo.setMessage(WorkflowConstant.END_EVENT_COMMENT);
            workflow.setAssigneeName(WorkflowConstant.SYSTEM_EVENT_COMMENT);
            workflow.setActivityCommentInfo(activityCommentInfo);
            return workflow;
        }

        // 获取任务执行人名称
        if (StrUtil.isNotEmpty(historicActivityInstance.getAssignee())) {
            Map<String, Object> user = jdbcTemplate.queryForMap(SqlConstants.QUERY_USER_BY_ID,historicActivityInstance.getAssignee());
            if (user != null) {
                workflow.setAssignee(historicActivityInstance.getAssignee());
                workflow.setAssigneeName(MapUtil.getStr(user, "userName"));
            }
        }

        // 获取意见评论内容
        if (StrUtil.isNotBlank(historicActivityInstance.getTaskId())) {
            List<ActivityCommentInfoVo> activityCommentInfoList = this.getTaskComments(historicActivityInstance.getTaskId());
            if (activityCommentInfoList.size() > 0) {
                ActivityCommentInfoVo activityCommentInfo = activityCommentInfoList.get(activityCommentInfoList.size()-1);
                workflow.setActivityCommentInfo((activityCommentInfo));
            }
        }

        // 获取等待执行的任务
        if(historicActivityInstance.getEndTime() == null) {
            ActivityCommentInfoVo activityCommentInfo = new ActivityCommentInfoVo();
            activityCommentInfo.setMesName(ExtendMessage.PROCESS_WAITING.getMesName());
            activityCommentInfo.setMessage(WorkflowConstant.WAITING_EVENT_COMMENT);
            workflow.setActivityCommentInfo(activityCommentInfo);
        }
        return workflow;
    }

    /** 创建加签子任务 */
    private void createAddSignSubTasks(List<String> userIds, TaskEntity taskEntity) {
        if (CollectionUtils.isNotEmpty(userIds)) {
            String parentTaskId = taskEntity.getParentTaskId();
            if (StrUtil.isBlank(parentTaskId)) {
                parentTaskId = taskEntity.getId();
            }
            String finalParentTaskId = parentTaskId;
            userIds.forEach(assignee -> {
                if (ObjectUtil.isNotEmpty(assignee)) {
                    this.createSubTask(taskEntity, finalParentTaskId, assignee);
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
