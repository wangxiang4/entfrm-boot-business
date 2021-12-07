package com.entfrm.biz.flowable.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.dto.ModelDto;
import com.entfrm.biz.flowable.service.FlowableModelService;
import com.entfrm.log.annotation.OperLog;
import lombok.AllArgsConstructor;
import org.flowable.engine.repository.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;


/**
 *<p>
 * 模型相关 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/flowable/model")
@AllArgsConstructor
public class FlowableModelController {


    private final FlowableModelService flowableModelService;



    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        IPage<Model> modelPage = flowableModelService.list(params);
        return R.ok(modelPage.getRecords(), modelPage.getTotal());
    }


    @OperLog("模型新增")
    @PostMapping("/save")
    public R save(@RequestBody ModelDto form) {
        flowableModelService.save(form.getName(), form.getCategory(), form.getKey(), form.getDescription());
        return R.ok();
    }


    @OperLog("模型删除")
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable("id") String id) {
        flowableModelService.removeById(id);
        return R.ok();
    }


    @OperLog("模型部署")
    @PostMapping("/deploy/{id}")
    public R deploy(@PathVariable("id") String id) {
        return R.ok(flowableModelService.deploy(id));
    }


}
