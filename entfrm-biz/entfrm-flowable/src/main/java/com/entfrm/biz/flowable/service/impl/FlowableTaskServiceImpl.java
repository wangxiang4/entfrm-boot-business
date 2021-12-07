package com.entfrm.biz.flowable.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.flowable.constant.FlowableConstant;
import com.entfrm.biz.flowable.enums.ProcessStatus;
import com.entfrm.biz.flowable.execution.cmd.BackUserTaskCmd;
import com.entfrm.biz.flowable.mapper.FlowMapper;
import com.entfrm.biz.flowable.model.Flow;
import com.entfrm.biz.flowable.model.TaskComment;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.biz.flowable.util.FlowableUtil;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
import com.entfrm.biz.flowable.vo.TaskVo;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.constants.BpmnXMLConstants;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.FlowNode;
import org.flowable.bpmn.model.Process;
import org.flowable.engine.*;
import org.flowable.engine.history.HistoricActivityInstance;
import org.flowable.engine.history.HistoricProcessInstance;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ActivityInstance;
import org.flowable.engine.runtime.ProcessInstance;
import org.flowable.image.ProcessDiagramGenerator;
import org.flowable.spring.ProcessEngineFactoryBean;
import org.flowable.task.api.DelegationState;
import org.flowable.task.api.Task;
import org.flowable.task.api.TaskQuery;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 *<p>
 * 任务相关 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
@Slf4j
@Service
@AllArgsConstructor
public class FlowableTaskServiceImpl implements FlowableTaskService {

    private final TaskService taskService;
    private final RuntimeService runtimeService;
    private final RepositoryService repositoryService;
    private final HistoryService historyService;
    private final FlowableProcessService flowableProcessServices;
    private final ProcessEngineFactoryBean processEngine;
    private final FormService formService;
    private final FlowMapper flowMapper;
    private final ManagementService managementService;
    private final IdentityService identityService;

    /** 代办任务列表 **/
    @Override
    public IPage list(Map<String, Object> params) {
        TaskQuery taskQuery = taskService.createTaskQuery()
                .taskCandidateOrAssigned(SecurityUtil.getUser().getUsername()).active()
                .includeProcessVariables().orderByTaskCreateTime().desc ();

        String taskName = (String) params.get("taskName");
        if (StrUtil.isNotBlank(taskName)) {
            taskQuery.taskNameLike(taskName);
        }

        int page = MapUtil.getInt(params, CommonConstants.CURRENT);
        int limit = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(page, limit);
        result.setTotal(taskQuery.count());

        List<ProcessInsVo> taskDTOList = taskQuery.orderByTaskCreateTime().desc()
                .listPage((page - 1) * limit, limit).stream().map(task -> {
                    ProcessDefinition pd=repositoryService.createProcessDefinitionQuery().processDefinitionId(task.getProcessDefinitionId()).singleResult();
                    ProcessInsVo processInsVo = new ProcessInsVo();
                    TaskVo taskVo = new TaskVo (task);
                    taskVo.setProcessDefKey(pd.getKey());
                    processInsVo.setTask(taskVo);
                    processInsVo.setVars(task.getProcessVariables());
                    processInsVo.setProcessDefinitionName(pd.getName());
                    processInsVo.setVersion(pd.getVersion());
                    return processInsVo;
                }).collect(Collectors.toList());
        result.setRecords(taskDTOList);
        return result;
    }


    /** 获取任务定义数据 **/
    @Override
    public Flow getTaskDef(Flow flow) {

        // 获取流程XML上的表单KEY
        String formKey = getFormKey(flow.getProcDefId(), flow.getTaskDefKey());
        //如果存在404直接跳转外置表单404组件
        if(formKey.indexOf("/")>=0){
            flow.setFormType("2");
            flow.setFormUrl(formKey);
        }else{
            //预定格式(类型,表单地址),类型只能有两种动态表单,跟外置表单
            String[] formSplit=formKey.split(",");
            String formType=formSplit[0],formUrl=formSplit[1];
            flow.setFormType(formType);
            flow.setFormUrl(formUrl);
        }

        // 获取流程实例对象
        if (flow.getProcInsId() != null) {
            if (flowableProcessServices.getProcIns(flow.getProcInsId()) != null) {
                flow.setProcIns(flowableProcessServices.getProcIns(flow.getProcInsId()));
            } else {
                flow.setFinishedProcIns(flowableProcessServices.getFinishedProcIns(flow.getProcInsId()));
            }
        }

        return flow;
    }



    /**  获取流程表单数据(首先获取任务节点表单KEY,如果没有则取流程开始节点表单KEY）**/
    public String getFormKey(String procDefId, String taskDefKey) {
        String formKey = "";
        if (StrUtil.isNotBlank(procDefId)) {
            if (StrUtil.isNotBlank(taskDefKey)) {
                try {
                    formKey = formService.getTaskFormKey(procDefId, taskDefKey);
                } catch (Exception e) {
                    formKey = "";
                }
            }
            if (StrUtil.isBlank (formKey)) {
                formKey = formService.getStartFormKey(procDefId);
            }
            if (StrUtil.isBlank (formKey)) {
                formKey = "/404";
            }
        }
        log.debug ("getFormKey: {}", formKey);
        return formKey;
    }




    /** 获取当前任务图片 **/
    @Override
    public InputStream getTackImage(String taskId) {
        //使用当前任务ID，获取当前任务对象
        Task task = taskService.createTaskQuery()
                .taskId(taskId)
                .singleResult();

        String processInstanceId = task.getProcessInstanceId();
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
        String processDefinitionId = null;
        List<String> executedActivityIdList = new ArrayList<>();
        if (processInstance != null) {
            processDefinitionId = processInstance.getProcessDefinitionId();
            executedActivityIdList = this.runtimeService.getActiveActivityIds(processInstance.getId());
        } else if (historicProcessInstance != null) {
            processDefinitionId = historicProcessInstance.getProcessDefinitionId();
            executedActivityIdList = historyService.createHistoricActivityInstanceQuery()
            .processInstanceId(processInstanceId)
            .orderByHistoricActivityInstanceId().asc().list()
            .stream().map(HistoricActivityInstance::getActivityId)
            .collect(Collectors.toList());
        }

        BpmnModel bpmnModel = repositoryService.getBpmnModel(processDefinitionId);
        ProcessEngineConfiguration processEngineConfiguration = processEngine.getProcessEngineConfiguration();
        ProcessDiagramGenerator diagramGenerator = processEngineConfiguration.getProcessDiagramGenerator();

        return diagramGenerator.generateDiagram(
                bpmnModel, "png" ,
                executedActivityIdList,
                Collections.emptyList(),
                processEngine.getProcessEngineConfiguration().getActivityFontName(),
                processEngine.getProcessEngineConfiguration().getLabelFontName(),
                processEngine.getProcessEngineConfiguration().getAnnotationFontName(),
                null,
                1.0,false);


    }




    /** 提交任务,并保存意见 **/
    @Override
    public void complete(Flow flow){

        //添加意见
        if(StrUtil.isNotBlank(flow.getProcInsId())){
            taskService.addComment (flow.getTaskId(), flow.getProcInsId(), flow.getComment().getCommentType(), flow.getComment().getFullMessage());
        }

        // 设置流程变量
        Map<String,Object> vars = flow.getVars().getMap();

        // 设置流程标题
        if (StrUtil.isNotBlank(flow.getTitle())) {
            vars.put (FlowableConstant.TITLE, flow.getTitle());
        }

        // todo: owner不为空说明可能存在委托任务,后期添加委托功能
        Task task = taskService.createTaskQuery().taskId(flow.getTaskId()).singleResult();
        if (StrUtil.isNotBlank(task.getOwner())){
            DelegationState delegationState = task.getDelegationState ();
            switch (delegationState) {
                case PENDING:
                    taskService.resolveTask (flow.getTaskId ());
                    taskService.complete (flow.getTaskId (), vars);
                    break;

                case RESOLVED:
                    System.out.println("委托任务已经完成");
                    break;

                default:
                    //不是委托任务
                    taskService.complete (flow.getTaskId(),vars);
                    break;
            }
            // 未签收任务
        } else if(StrUtil.isBlank(task.getAssignee())){
            // 签收任务
            taskService.claim (flow.getTaskId(),SecurityUtil.getUser().getUsername());
            // 提交任务
            taskService.complete (flow.getTaskId (), vars);
        } else  {
            // 提交任务
            taskService.complete (flow.getTaskId (), vars);
        }

    }




    /** 外置表单审核专用 **/
    @Override
    public void auditTask(Flow flow) {
        complete(flow);
    }



    /** 启动流程专用 **/
    @Override
    public String startProcess(String procDefKey, String businessTable,
                               String businessId, String title,Map<String,Object> vars){
        //设置流程变量
        if(vars==null){
            vars= MapUtil.newHashMap();
        }
        //可由外部提供流程发起人
        String userId = (String) vars.get(FlowableConstant.INITIATOR);
        if(userId==null){
            userId= SecurityUtil.getUser().getUsername();
        }
        //设置流程执行人
        String userName = SecurityUtil.getUser().getUsername();
        vars.put (FlowableConstant.USERNAME, userName);
        //设置流程发起人
        identityService.setAuthenticatedUserId(userId);

        // 设置流程标题
        if (StrUtil.isNotBlank(title)) {
            vars.put(FlowableConstant.TITLE, title);
        }

        //启动流程实例
        String procInsId=runtimeService.startProcessInstanceByKey(procDefKey,
                String.join(":",businessTable,businessId),vars).getProcessInstanceId();

        //更新业务表流程实例ID,确保业务表字段proc_ins_id存在
        Flow act = new Flow();
        act.setBusinessTable (businessTable);
        act.setBusinessId (businessId);
        act.setProcInsId (procInsId);
        flowMapper.updateProcInsIdByBusinessId(act);

        return procInsId;
    }



    /** 外置表单启动流程专用 **/
    @Override
    public String startProcess(String procDefKey, String businessTable,
                               String businessId, String title) {
        Map<String, Object> vars = MapUtil.newHashMap();
        return startProcess(procDefKey, businessTable, businessId, title, vars);
    }



    /** 获取可驳回节点 **/
    @Override
    public List<Flow> getBackNodes(String taskId) {
        Task taskEntity = taskService.createTaskQuery().taskId(taskId).singleResult();
        String processInstanceId = taskEntity.getProcessInstanceId();
        String currActId = taskEntity.getTaskDefinitionKey();
        String processDefinitionId = taskEntity.getProcessDefinitionId();
        Process process = repositoryService.getBpmnModel(processDefinitionId).getMainProcess();
        FlowNode currentFlowElement = (FlowNode) process.getFlowElement(currActId, true);
        //获取已经完成的活动节点
        List<ActivityInstance> activitys=
                runtimeService.createActivityInstanceQuery().processInstanceId(processInstanceId).finished().orderByActivityInstanceStartTime().asc().list();
        //获取已经完成节点的活动ID
        List<String> activityIds =
                activitys.stream().filter(activity -> activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_TASK_USER) || activity.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START))
                        .filter(activity ->!activity.getActivityId().equals (currActId))
                        .map(ActivityInstance::getActivityId).distinct().collect(Collectors.toList());
        List<Flow> result = new ArrayList<> ();
        for (String activityId : activityIds) {
            FlowNode toBackFlowElement = (FlowNode) process.getFlowElement (activityId, true);
            //目标节点是否可以到达
            if (FlowableUtil.isReachable(process, toBackFlowElement, currentFlowElement)){
                Flow vo = new Flow ();
                vo.setTaskDefKey (activityId);
                vo.setTaskName (toBackFlowElement.getName ());
                vo.setTaskId (activityId);
                result.add (vo);
            }
        }
        return result;
    }



    /** 驳回任务,驳回到指定节点 **/
    @Override
    public void backTask(String backTaskDefKey, String taskId, TaskComment comment) {
        Task task = taskService.createTaskQuery ().taskId (taskId).singleResult ();
        if(StrUtil.isBlank(task.getAssignee())){
            //代理人为空自己签收任务
            taskService.claim (taskId, SecurityUtil.getUser().getUsername());
        }
        // 退回发起者处理,退回到发起者,默认设置任务执行人为发起者
        ActivityInstance targetRealActivityInstance = runtimeService.createActivityInstanceQuery ().processInstanceId (task.getProcessInstanceId ()).activityId (backTaskDefKey).list ().get (0);
        if (targetRealActivityInstance.getActivityType().equals(BpmnXMLConstants.ELEMENT_EVENT_START)) {
            flowableProcessServices.stopProcessInstanceById (task.getProcessInstanceId (), ProcessStatus.REJECT, comment.getMessage ());
        }else {
            taskService.addComment (taskId,task.getProcessInstanceId(),comment.getCommentType(),comment.getFullMessage());
            managementService.executeCommand (new BackUserTaskCmd(runtimeService,taskId, backTaskDefKey));
        }
    }



}
