package com.entfrm.biz.workflow.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.map.MapUtil;
import com.entfrm.base.api.R;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.service.WorkflowTaskService;
import com.entfrm.security.util.SecurityUtil;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.bpmn.model.UserTask;
import org.flowable.engine.*;
import org.flowable.engine.form.FormProperty;
import org.flowable.engine.form.StartFormData;
import org.flowable.engine.form.TaskFormData;
import org.flowable.task.api.Task;
import org.flowable.variable.api.history.HistoricVariableInstance;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 *<p>
 * 动态表单 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@RestController
@RequestMapping("/workflow/form")
@AllArgsConstructor
public class WorkflowFormController {

    private final TaskService taskService;

    private final FormService formService;

    private final IdentityService identityService;

    private final WorkflowTaskService workflowTaskService;

    private final HistoryService historyService;

    private final RepositoryService repositoryService;

    /** 启动流程定义 */
    @PostMapping("/startProcessDefinition")
    public R startProcessDefinition(@RequestBody Workflow workflow) {
        String assignee = workflow.getAssignee(),
               processDefId= workflow.getProcessDefId(),
               title = workflow.getTitle();
        Map<String,Object> formData =workflow.getVars();

        // 获取流程开始事件动态表单
        StartFormData startFormData = formService.getStartFormData(processDefId);
        // 获取表单字段值
        List<FormProperty> formProperties = startFormData.getFormProperties();
        // 设置流程变量
        Map<String,String> formProcessVars = CollectionUtil.newHashMap();
        formProcessVars.put(WorkflowConstant.USERNAME, SecurityUtil.getUser().getUsername());
        // 设置流程发起人
        identityService.setAuthenticatedUserId(SecurityUtil.getUser().getId() + "");
        // 设置流程标题
        if (StringUtils.isNotBlank(title)) {
            formProcessVars.put("title", title);
        }
        // 设置动态表单默认值
        for (FormProperty formProperty:formProperties) {
            if (formProperty.isWritable()) {
                if(formData.containsKey(formProperty.getId())){
                    formProcessVars.put(formProperty.getId(), MapUtil.getStr(formData, formProperty.getId()));
                }
            }
        }

        // 启动流程，提交表单
        String processInsId = formService.submitStartFormData(processDefId, formProcessVars).getId();

        // 指定下一步处理人
        if(StringUtils.isNotBlank(assignee)){
            Task task = taskService.createTaskQuery().processInstanceId(processInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), assignee);
            }
        }
        return R.ok(processInsId, "启动成功");
    }

    /** 获取任务节点表单数据 */
    @GetMapping("/getTaskFormData/{taskId}")
    public R getTaskFormData(@PathVariable String taskId) {
        // 根据任务ID获取表单数据
        TaskFormData taskFormData = formService.getTaskFormData(taskId);
        return R.ok(taskFormData.getFormProperties());
    }

    /** 获取流程开始事件表单数据 */
    @GetMapping("/getProcessStartEventFormData/{processDefId}")
    public R getProcessStartEventFormData(@PathVariable String processDefId) {
        // 根据流程定义ID获取表单数据
        StartFormData startFormData = formService.getStartFormData(processDefId);
        return R.ok(startFormData.getFormProperties());
    }

    /** 审核任务 */
    @PostMapping("/auditTask")
    public R auditTask(@RequestBody Workflow workflow) {
        String assignee = workflow.getAssignee(),
               processInsId= workflow.getProcessInsId(),
               taskId = workflow.getTaskId();
        Map<String,Object> formData =workflow.getVars();

        // 根据任务ID获取动态表单
        TaskFormData taskFormData = formService.getTaskFormData(taskId);
        // 获取表单字段值
        List<FormProperty> formProperties = taskFormData.getFormProperties();

        Map<String, Object> formProcessVars = CollectionUtil.newHashMap();
        // 设置动态表单默认值
        for (FormProperty formProperty:formProperties) {
            if (formProperty.isWritable()) {
                if(formData.containsKey(formProperty.getId())){
                    formProcessVars.put(formProperty.getId(), MapUtil.getStr(formData, formProperty.getId()));
                }
            }
        }
        workflow.setVars(formProcessVars);

        // 提交用户任务表单并且完成任务
        workflowTaskService.complete(workflow);

        // 指定下一步处理人
        if(StringUtils.isNotBlank(assignee)){
            Task task = taskService.createTaskQuery().processInstanceId(processInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), assignee);
            }
        }
        return R.ok("提交成功");
    }

    /** 获取历史表单任务数据 */
    @GetMapping("/getHistoryFormTaskData")
    public R getHistoryFormTaskData(String processInsId, String processDefId, String taskDefKey) {
        List<HistoricVariableInstance> historicVariableInstances = historyService.createHistoricVariableInstanceQuery()
                .processInstanceId(processInsId).list();
        HashMap<String,Object> historicVariableMap = new HashMap<>();
        for(HistoricVariableInstance historicVariableInstance: historicVariableInstances){
            historicVariableMap.put(historicVariableInstance.getVariableName(), historicVariableInstance.getValue());
        }
        List<Map> list = Lists.newArrayList();
        FlowElement node = repositoryService.getBpmnModel(processDefId).getFlowElement(taskDefKey);
        if(node != null){
            List<org.flowable.bpmn.model.FormProperty> formPropertyList = CollectionUtil.newArrayList();
            if(node instanceof UserTask){
                formPropertyList = ((UserTask) node).getFormProperties();
            }else if(node instanceof StartEvent){
                formPropertyList = ((StartEvent) node).getFormProperties();
            }
            for(org.flowable.bpmn.model.FormProperty formProperty : formPropertyList){
                try {
                    HashMap<String,Object> formPropertyMap = new HashMap<>();
                    Field field =  formProperty.getClass().getDeclaredField("readable");
                    field.setAccessible(true);
                    boolean readable =(boolean) field.get(formProperty);
                    if(readable){
                        formPropertyMap.put("id", formProperty.getId());
                        formPropertyMap.put("name", formProperty.getName());
                        formPropertyMap.put("value", historicVariableMap.get(formProperty.getId()));
                        formPropertyMap.put("readable", true);
                        formPropertyMap.put("writable", false);
                        list.add(formPropertyMap);
                    }
                }catch (Exception e){ e.printStackTrace(); }
            }
        }else{
            List<FormProperty> formPropertyList = formService.getStartFormData(processDefId).getFormProperties();
            for(FormProperty formProperty : formPropertyList){
                try {
                    HashMap<String,Object> formPropertyMap = new HashMap<>();

                    boolean readable = formProperty.isReadable();
                    if(readable){
                        formPropertyMap.put("id", formProperty.getId());
                        formPropertyMap.put("name", formProperty.getName());
                        formPropertyMap.put("value", historicVariableMap.get(formProperty.getId()));
                        formPropertyMap.put("readable", true);
                        formPropertyMap.put("writable", false);
                        list.add(formPropertyMap);
                    }
                }catch (Exception e){ e.printStackTrace(); }
            }
        }
        return R.ok(list);
    }


}
