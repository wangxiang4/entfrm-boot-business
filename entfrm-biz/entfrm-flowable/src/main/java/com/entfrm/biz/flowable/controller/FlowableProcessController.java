package com.entfrm.biz.flowable.controller;

import cn.hutool.core.io.IoUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.dto.ProcessDefDto;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.Map;

/**
 *<p>
 * 流程定义相关 controller
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


    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<ProcessDefDto> processIPage = flowableProcessService.list(params);
        return R.ok(processIPage.getRecords(), processIPage.getTotal());
    }


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



    @PutMapping("/changeStatus")
    public R changeStatus(@RequestParam String procDefId, @RequestParam String status) {
        return R.ok(flowableProcessService.changeStatus(procDefId, status));
    }



    @DeleteMapping("/remove/{deployId}")
    public R removeProcIns(@PathVariable String deployId) {
        return R.ok(flowableProcessService.removeProcIns(deployId));
    }




}
