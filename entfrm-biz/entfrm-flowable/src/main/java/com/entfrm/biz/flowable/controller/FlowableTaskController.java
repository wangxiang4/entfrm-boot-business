package com.entfrm.biz.flowable.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.Flow;
import com.entfrm.biz.flowable.entity.TaskComment;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
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
 *<p>
 * 任务相关 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
@RestController
@AllArgsConstructor
@RequestMapping("/flowable/task")
public class FlowableTaskController {

    private final FlowableTaskService flowableTaskService;
    private final TaskService taskService;

    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessInsVo> taskIPage = flowableTaskService.list(params);
        return R.ok(taskIPage.getRecords(), taskIPage.getTotal());
    }


    @GetMapping("/track/{id}")
    public ResponseEntity trackImage(@PathVariable String id) {
        InputStream imageStream = flowableTaskService.getTackImage(id);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_PNG);
        return new ResponseEntity(IoUtil.readBytes(imageStream), headers, HttpStatus.CREATED);
    }


    @GetMapping("/getTskDef")
    public R getById(Flow flow){
        return R.ok(flowableTaskService.getTaskDef(flow));
    }


    /** 外置表单:启动流程 */
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
    @PostMapping(value = "/backNodes")
    public R backNodes(@RequestParam String taskId) {
        List<Flow> nodes = flowableTaskService.getBackNodes(taskId);
        return R.ok(nodes,"获取成功");
    }


    /** 驳回任务到指定节点 */
    @PostMapping(value = "/back")
    public R back(String backTaskDefKey, String taskId, TaskComment comment) {
        flowableTaskService.backTask(backTaskDefKey, taskId, comment);
        return R.ok("驳回成功!");
    }


}
