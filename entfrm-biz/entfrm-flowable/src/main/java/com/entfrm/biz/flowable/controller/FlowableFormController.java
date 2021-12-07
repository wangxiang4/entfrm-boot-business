package com.entfrm.biz.flowable.controller;

import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.model.Flow;
import com.entfrm.biz.flowable.service.FlowableFormService;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.TaskService;
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


    /** 动态表单:获取表单数据 **/
    @GetMapping(value = "/getTaskFormData")
    public R getTaskFormData(String code, String procInsId) {
        return R.ok(flowableFormService.getFormData(code,procInsId),"获取表单数据成功");
    }



    /** 动态表单:启动流程 **/
    @PutMapping("submitStartFormData")
    public R submitStartFormData(@RequestBody Flow flow){
        String procInsId = flowableFormService.submitStartFormData(flow.getProcDefId(),flow.getTitle(),flow.getFormData());
        //指定下一步处理人
        if(StringUtils.isNotBlank(flow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(procInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(),flow.getAssignee());
            }
        }
        return R.ok(procInsId,"启动成功");
    }




    /** 动态表单:审批 **/
    @PutMapping("submitTaskFormData")
    public R submitTaskFormData(@RequestBody Flow flow) {
        flowableFormService.submitTaskFormData(flow, flow.getFormData());
        //指定下一步处理人
        if(StringUtils.isNotBlank(flow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(flow.getProcInsId()).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), flow.getAssignee());
            }
        }
        return R.ok("审批成功");
    }



}
