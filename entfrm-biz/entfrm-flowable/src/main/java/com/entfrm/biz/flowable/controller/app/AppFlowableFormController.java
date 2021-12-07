package com.entfrm.biz.flowable.controller.app;

import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.model.Flow;
import com.entfrm.biz.flowable.service.FlowableFormService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.TaskService;
import org.flowable.task.api.Task;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * APP动态表单表单相关 controller
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-12
 */
@RestController
@AllArgsConstructor
@RequestMapping("/app/flowable/form")
@Api(tags = {"APP动态表单表单相关接口"})
public class AppFlowableFormController {

    private final FlowableFormService flowableFormService;
    private final TaskService taskService;


    /** 动态表单:获取表单数据 **/
    @ApiOperation("动态表单:获取表单数据")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "code", value = "动态表单编码", required=true),
        @ApiImplicitParam(name = "procInsId", value = "流程实例ID", required=true)
    })
    @GetMapping(value = "/getTaskFormData")
    public R getTaskFormData(String code, String procInsId) {
        return R.ok(flowableFormService.getFormData(code,procInsId),"获取表单数据成功");
    }



    /** 动态表单:启动流程 **/
    @ApiOperation("动态表单:启动流程")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "flow", value = "工作流通用数据实体", required=true)
    })
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
    @ApiOperation("动态表单:审批")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "flow", value = "工作流通用数据实体", required=true),
    })
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
