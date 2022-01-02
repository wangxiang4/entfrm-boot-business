package com.entfrm.biz.flowable.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.Workflow;
import com.entfrm.biz.flowable.vo.TaskCommentVo;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.biz.flowable.vo.ProcessInstanceVo;
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
 * 任务 controller
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
        IPage<ProcessInstanceVo> taskIPage = flowableTaskService.list(params);
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
    public R getById(Workflow workFlow){
        return R.ok(flowableTaskService.getTaskDef(workFlow));
    }


    /** 外置表单:启动流程 */
    @PutMapping("/start")
    public R start(@RequestBody Workflow workFlow){
        String procInsId = flowableTaskService
                .startProcess(workFlow.getProcDefKey(), workFlow.getBusinessTable(), workFlow.getBusinessId(), workFlow.getTitle());
        //指定下一步处理人
        if(StringUtils.isNotBlank(workFlow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(procInsId).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), workFlow.getAssignee());
            }
        }
        return R.ok(procInsId,"启动成功");
    }


    /** 外置表单:审批 */
    @PutMapping("audit")
    public  R auditTask(@RequestBody Workflow workFlow) {
        flowableTaskService.auditTask(workFlow);
        //指定下一步处理人
        if(StringUtils.isNotBlank(workFlow.getAssignee())){
            Task task = taskService.createTaskQuery().processInstanceId(workFlow.getProcInsId()).active().singleResult();
            if(task != null){
                taskService.setAssignee(task.getId(), workFlow.getAssignee());
            }
        }
        return R.ok("审批成功");
    }



    /** 获取可退回任务节点 */
    @PostMapping(value = "/backNodes")
    public R backNodes(@RequestParam String taskId) {
        List<Workflow> nodes = flowableTaskService.getBackNodes(taskId);
        return R.ok(nodes,"获取成功");
    }


    /** 驳回任务到指定节点 */
    @PostMapping(value = "/back")
    public R back(String backTaskDefKey, String taskId, TaskCommentVo comment) {
        flowableTaskService.backTask(backTaskDefKey, taskId, comment);
        return R.ok("驳回成功!");
    }


}
