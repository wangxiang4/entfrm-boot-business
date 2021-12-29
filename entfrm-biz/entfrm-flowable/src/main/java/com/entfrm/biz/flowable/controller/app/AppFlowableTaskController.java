package com.entfrm.biz.flowable.controller.app;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.Flow;
import com.entfrm.biz.flowable.entity.TaskComment;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.TaskService;
import org.flowable.task.api.Task;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * APP任务相关 controller
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-12
 */
@RestController
@AllArgsConstructor
@RequestMapping("/app/flowable/task")
@Api(tags = {"APP任务相关接口"})
public class AppFlowableTaskController {


    private final FlowableTaskService flowableTaskService;
    private final TaskService taskService;

    @ApiOperation("代办任务列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "params", value = "查询条件参数", required=true),
    })
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessInsVo> taskIPage = flowableTaskService.list(params);
        return R.ok(taskIPage.getRecords(), taskIPage.getTotal());
    }


    @ApiOperation("获取当前任务图片")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "任务ID", required=true),
    })
    @GetMapping("/track/{id}")
    public ResponseEntity trackImage(@PathVariable String id) {
        InputStream imageStream = flowableTaskService.getTackImage(id);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity(IoUtil.readBytes(imageStream), headers, HttpStatus.CREATED);
    }

    @ApiOperation("获取任务定义数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "flow", value = "工作流通用数据实体", required=true)
    })
    @GetMapping("/getTskDef")
    public R getById(Flow flow){
        return R.ok(flowableTaskService.getTaskDef(flow));
    }


    /** 外置表单:启动流程 */
    @ApiOperation("外置表单:启动流程 ")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "flow", value = "工作流通用数据实体", required=true)
    })
    @PutMapping("/start")
    public R start(@RequestBody Flow flow){
        String procInsId = flowableTaskService
                .startProcess(flow.getProcDefKey(), flow.getBusinessTable(), flow.getBusinessId(), flow.getTitle());
        //指定下一步处理人
        if(StringUtils.isNotBlank(flow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(procInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), flow.getAssignee());
            }
        }
        return R.ok(procInsId,"启动成功");
    }


    /** 外置表单:审批 */
    @ApiOperation("外置表单:审批")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "flow", value = "工作流通用数据实体", required=true)
    })
    @PutMapping("audit")
    public  R auditTask(@RequestBody Flow flow) {
        flowableTaskService.auditTask(flow);
        //指定下一步处理人
        if(StringUtils.isNotBlank(flow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(flow.getProcInsId()).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), flow.getAssignee());
            }
        }
        return R.ok("审批成功");
    }



    /** 获取可退回任务节点 */
    @ApiOperation("获取可退回任务节点")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "taskId", value = "任务ID", required=true)
    })
    @PostMapping(value = "/backNodes")
    public R backNodes(@RequestParam String taskId) {
        List<Flow> nodes = flowableTaskService.getBackNodes(taskId);
        return R.ok(nodes,"获取成功");
    }


    /** 驳回任务到指定节点 */
    @ApiOperation("驳回任务到指定节点")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "backTaskDefKey", value = "驳回任务的定义KEy", required=true),
            @ApiImplicitParam(name = "back", value = "任务ID", required=true),
            @ApiImplicitParam(name = "comment", value = "驳回评论", required=true)
    })
    @PostMapping(value = "/back")
    public R back(String backTaskDefKey, String taskId, TaskComment comment) {
        flowableTaskService.backTask(backTaskDefKey, taskId, comment);
        return R.ok("驳回成功!");
    }


}
