package com.entfrm.biz.workflow.controller;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.map.MapUtil;
import com.entfrm.base.api.R;
import com.entfrm.biz.workflow.constant.WorkflowConstant;
import com.entfrm.biz.workflow.entity.Workflow;
import com.entfrm.biz.workflow.service.WorkflowTaskService;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.FormService;
import org.flowable.engine.IdentityService;
import org.flowable.engine.TaskService;
import org.flowable.engine.form.FormProperty;
import org.flowable.engine.form.StartFormData;
import org.flowable.engine.form.TaskFormData;
import org.flowable.task.api.Task;
import org.springframework.web.bind.annotation.*;

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

}
