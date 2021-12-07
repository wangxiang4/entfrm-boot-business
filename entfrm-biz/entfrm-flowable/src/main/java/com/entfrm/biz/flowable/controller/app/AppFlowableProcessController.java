package com.entfrm.biz.flowable.controller.app;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.dto.ProcessDefDto;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.Map;

/**
 * <p>
 * APP流流程定义相关  controller
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-12
 */
@RestController
@AllArgsConstructor
@RequestMapping("/app/flowable/process")
@Api(tags = {"APP流流程定义相关接口"})
public class AppFlowableProcessController {

    private final FlowableProcessService flowableProcessService;


    @ApiOperation("流程定义列表")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "params", value = "查询条件参数", required=true),
    })
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessDefDto> processIPage = flowableProcessService.list(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }


    @ApiOperation("读取xml/image资源")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "procInsId", value = "流程实例ID", required=true),
            @ApiImplicitParam(name = "procDefId", value = "流程定义ID", required=true),
            @ApiImplicitParam(name = "resType", value = "获取资源类型", required=true),
    })
    @GetMapping(value = "/resource")
    public ResponseEntity resource(@RequestParam String procInsId, @RequestParam String procDefId, @RequestParam String resType) {

        HttpHeaders headers = new HttpHeaders();

        if ("xml".equals(resType)) {
            headers.setContentType(MediaType.APPLICATION_XML);
        } else {
            headers.setContentType(MediaType.TEXT_XML);
        }

        InputStream resourceAsStream = flowableProcessService.readResource(procInsId, procDefId, resType);
        return new ResponseEntity(IoUtil.readBytes(resourceAsStream), headers, HttpStatus.CREATED);
    }


    @ApiOperation("挂起/激活")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "procDefId", value = "流程定义ID", required=true),
            @ApiImplicitParam(name = "status", value = "激活挂起状态", required=true)
    })
    @PutMapping("/changeStatus")
    public R changeStatus(@RequestParam String procDefId, @RequestParam String status) {
        return R.ok(flowableProcessService.changeStatus(procDefId, status));
    }


    @ApiOperation("删除流程实例")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "deployId", value = "流程部署ID", required=true),
    })
    @DeleteMapping("/remove/{deployId}")
    public R removeProcIns(@PathVariable String deployId) {
        return R.ok(flowableProcessService.removeProcIns(deployId));
    }


}
