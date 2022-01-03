package com.entfrm.biz.workflow.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.workflow.enums.ProcessStatus;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.vo.ProcessDefinitionVo;
import com.entfrm.biz.workflow.vo.ProcessInstanceVo;
import lombok.AllArgsConstructor;
import org.flowable.engine.repository.ProcessDefinition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.Arrays;
import java.util.Map;

/**
 *<p>
 * 流程定义 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@RestController
@AllArgsConstructor
@RequestMapping("/workflow/process")
public class WorkflowProcessController {

    private final WorkflowProcessService workflowProcessService;

    /** 流程定义列表 */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessDefinitionVo> processIPage = workflowProcessService.list(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }

    /** 流程定义是否存在 */
    @GetMapping("/exist/{processDefKey}")
    public R processDefinitionExist(@PathVariable String processDefKey) {
        ProcessDefinition processDefinition = workflowProcessService.getProcessDefinitionByKey(processDefKey);
        return R.ok(processDefinition == null ? "0" : "1");
    }

    /** 运行中的流程实例列表 */
    @GetMapping("/runList")
    public R runList(@RequestParam Map<String, Object> params) {
        IPage<ProcessInstanceVo> processIPage = workflowProcessService.runList(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }

    /** 历史流程列表 */
    @GetMapping("/historyList")
    public R historyList(@RequestParam Map<String, Object> params) {
        IPage<ProcessInstanceVo> processIPage = workflowProcessService.historyList(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }

    /** 读取xml/image资源 */
    @GetMapping("/resource")
    public ResponseEntity resource(String processInsId, String processDefId, String fileType) {

        HttpHeaders headers = new HttpHeaders();

        if ("xml".equals(fileType)) {
            headers.setContentType(MediaType.APPLICATION_XML);
        } else {
            headers.setContentType(MediaType.TEXT_XML);
        }

        InputStream resourceAsStream = workflowProcessService.readResource(processInsId, processDefId, fileType);
        return new ResponseEntity(IoUtil.readBytes(resourceAsStream), headers, HttpStatus.CREATED);
    }

    /** 获取bpmn.js建模器流程图xml */
    @GetMapping("/getFlowChart/{processDefId}")
    public R getFlowChart(@PathVariable String processDefId) {
        InputStream resourceAsStream = workflowProcessService.readResource(null, processDefId, "xml");
        return R.ok(new String(IoUtil.readBytes(resourceAsStream)));
    }

    /** 设置流程分类 */
    @PutMapping("/setProcessCategory")
    public R setProcessCategory(String processDefId, String category) {
        workflowProcessService.setProcessInstanceCategory(processDefId, category);
        return R.ok("流程分类设置成功!");
    }

    /** 挂起、激活流程实例 */
    @PutMapping("/setProcessInstanceStatus")
    public R setProcessInstanceStatus(String processDefId, String status) {
        workflowProcessService.setProcessInstanceStatus(processDefId, status);
        return R.ok();
    }

    /** 删除部署的流程 */
    @DeleteMapping("/removeDeployment/{deploymentIds}")
    public R removeDeployment(@PathVariable String[] deploymentIds) {
        Arrays.asList(deploymentIds).forEach(id -> workflowProcessService.deleteDeployment(id));
        return R.ok("删除成功");
    }

    /** 删除流程实例 */
    @DeleteMapping("/removeProcessInstance")
    public R removeProcessInstance(String[] processInsIds, String reason) {
        Arrays.asList(processInsIds).forEach(id -> workflowProcessService.deleteProcessInstance(id, reason));
        return R.ok("删除成功");
    }

    /** 流程撤回 */
    @PutMapping("/undoProcessInstance/{processInsId}")
    public R undoProcessInstance(@PathVariable String processInsId) {
        workflowProcessService.undoProcessInstance(processInsId);
        return R.ok("流程撤销成功!");
    }

    /** 流程终止 */
    @PutMapping("/stopProcessInstance")
    public R stopProcessInstance(String processInsId, String message) {
        workflowProcessService.stopProcessInstance(processInsId, ProcessStatus.STOP, message);
        return R.ok("终止流程成功!");
    }

    /** 查询流程状态 */
    @GetMapping("/queryProcessStatus/{processInsId}")
    public R queryProcessStatus(@PathVariable String processInsId) {
        ProcessInstanceVo processInstanceVo = workflowProcessService.queryProcessState(processInsId);
        return R.ok(processInstanceVo);

    }

    /** 自己发起流程实例列表 */
    @GetMapping("/selfProcessInstanceList")
    public R selfProcessInstanceList(@RequestParam Map<String, Object> params) {
        IPage<ProcessInstanceVo> taskIPage = workflowProcessService.selfProcessInstanceList(params);
        return R.ok(taskIPage.getRecords(), taskIPage.getTotal());
    }

}
