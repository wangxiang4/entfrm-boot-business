package com.entfrm.biz.flowable.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.enums.ProcessStatus;
import com.entfrm.biz.flowable.vo.ProcessDefinitionVo;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.biz.flowable.vo.ProcessInstanceVo;
import lombok.AllArgsConstructor;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.engine.runtime.ProcessInstance;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Map;

/**
 *<p>
 * 流程定义 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/11
 */
@RestController
@AllArgsConstructor
@RequestMapping("/flowable/process")
public class FlowableProcessController {

    private final FlowableProcessService flowableProcessService;

    /** 流程定义列表 */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessDefinitionVo> processIPage = flowableProcessService.list(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }

    /** 流程定义是否存在 */
    @GetMapping("/exist")
    public R processDefinitionExist(String processDefKey) {
        ProcessDefinition processDefinition = flowableProcessService.getProcessDefinitionByKey(processDefKey);
        return R.ok(processDefinition == null ? "0" : "1");
    }

    /** 运行中的流程实例列表 */
    @GetMapping("/runList")
    public R runList(@RequestParam Map<String, Object> params) {
        IPage<ProcessInstanceVo> processIPage = flowableProcessService.runList(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }

    /** 历史流程列表 */
    @GetMapping("/historyList")
    public R historyList(@RequestParam Map<String, Object> params) {
        IPage<ProcessInstanceVo> processIPage = flowableProcessService.historyList(params);
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

        InputStream resourceAsStream = flowableProcessService.readResource(processInsId, processDefId, fileType);
        return new ResponseEntity(IoUtil.readBytes(resourceAsStream), headers, HttpStatus.CREATED);
    }

    /** 获取bpmn.js建模器流程图xml */
    @GetMapping("/getFlowChart")
    public R getFlowChart(String processDefId) {
        InputStream resourceAsStream = flowableProcessService.readResource(null, processDefId, "xml");
        return R.ok(new String(IoUtil.readBytes(resourceAsStream)));
    }

    /** 设置流程分类 */
    @PostMapping("/setProcessCategory")
    public R setProcessCategory(String processDefId, String category) {
        flowableProcessService.setProcessInstanceCategory(processDefId, category);
        return R.ok("流程分类设置成功!");
    }

    /** 挂起、激活流程实例 */
    @PutMapping("/setProcessInstanceStatus")
    public R setProcessInstanceStatus(String processDefId, String status) {
        flowableProcessService.setProcessInstanceStatus(processDefId, status);
        return R.ok();
    }

    /** 删除部署的流程 */
    @DeleteMapping("/removeDeployment/{deploymentIds}")
    public R removeDeployment(String[] deploymentIds) {
        Arrays.asList(deploymentIds).forEach(id -> flowableProcessService.deleteDeployment(id));
        return R.ok("删除成功");
    }

    /** 删除流程实例 */
    @DeleteMapping("/removeProcessInstance")
    public R removeProcessInstance(String[] processInsIds, String reason) {
        Arrays.asList(processInsIds).forEach(id -> flowableProcessService.deleteProcessInstance(id, reason));
        return R.ok("删除成功");
    }

    /** 流程撤回 */
    @PutMapping("/undoProcessInstance")
    public R undoProcessInstance(String processInsId) {
        flowableProcessService.undoProcessInstance(processInsId);
        return R.ok("流程撤销成功!");
    }

    /** 流程终止 */
    @PutMapping("/stopProcessInstance")
    public R stopProcessInstance(String processInsId, String message) {
        flowableProcessService.stopProcessInstance(processInsId, ProcessStatus.STOP, message);
        return R.ok("终止流程成功!");
    }

    /** 查询流程状态 */
    @GetMapping("queryProcessStatus")
    public R queryProcessStatus(String processInsId) {
        ProcessInstanceVo processInstanceVo = flowableProcessService.queryProcessState(processInsId);
        return R.ok(processInstanceVo);

    }

}
