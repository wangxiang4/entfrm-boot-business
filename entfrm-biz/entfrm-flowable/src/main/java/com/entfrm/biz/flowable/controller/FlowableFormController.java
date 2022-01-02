package com.entfrm.biz.flowable.controller;

import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.Workflow;
import com.entfrm.biz.flowable.service.FlowableFormService;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.FormService;
import org.flowable.engine.TaskService;
import org.flowable.engine.form.TaskFormData;
import org.flowable.task.api.Task;
import org.springframework.web.bind.annotation.*;


/**
 *<p>
 * 动态表单表单相关 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/flowable/form")
@AllArgsConstructor
public class FlowableFormController {

    private final FlowableFormService flowableFormService;
    private final TaskService taskService;
    private final FormService formService;

    /** 动态表单:获取表单数据 */
    @GetMapping(value = "/getTaskFormData")
    public R getTaskFormData(String taskId) {
        //根据任务ID拿取表单数据
        TaskFormData taskFormData = formService.getTaskFormData(taskId);
        return R.ok(taskFormData.getFormProperties(),"获取表单数据成功");
    }



    /** 动态表单:启动流程 */
    @PutMapping("submitStartFormData")
    public R submitStartFormData(@RequestBody Workflow workFlow){
        String procInsId = flowableFormService.submitStartFormData(workFlow.getProcDefId(), workFlow.getTitle(), workFlow.getFormData());
        //指定下一步处理人
        if(StringUtils.isNotBlank(workFlow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(procInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), workFlow.getAssignee());
            }
        }
        return R.ok(procInsId,"启动成功");
    }




    /** 动态表单:审批 */
    @PutMapping("submitTaskFormData")
    public R submitTaskFormData(@RequestBody Workflow workFlow) {
        flowableFormService.submitTaskFormData(workFlow, workFlow.getFormData());
        //指定下一步处理人
        if(StringUtils.isNotBlank(workFlow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(workFlow.getProcInsId()).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), workFlow.getAssignee());
            }
        }
        return R.ok("审批成功");
    }



}
