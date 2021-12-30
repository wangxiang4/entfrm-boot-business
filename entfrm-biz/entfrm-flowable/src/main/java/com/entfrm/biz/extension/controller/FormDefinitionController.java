package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Button;
import com.entfrm.biz.extension.entity.FormCategory;
import com.entfrm.biz.extension.entity.FormDefinition;
import com.entfrm.biz.extension.service.FormDefinitionService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 *<p>
 * 表单定义 Controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/4
 */
@RestController
@RequestMapping(value = "/flowable/extension/formDefinition")
@AllArgsConstructor
public class FormDefinitionController {

    private final FormDefinitionService FormDefinitionService;

    @GetMapping("/list")
    public R list(Page page, FormDefinition formDefinition) {
        IPage<FormDefinition> buttonIPage = FormDefinitionService.findList(page, formDefinition);
        return R.ok(buttonIPage.getRecords(), buttonIPage.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(FormDefinitionService.getById(id));
    }

    @PostMapping("/save")
    public R save(@RequestBody FormDefinition formDefinition) {
        FormDefinitionService.save(formDefinition);
        return R.ok();
    }

    @PutMapping("/update")
    public R update(@RequestBody FormDefinition formDefinition) {
        FormDefinitionService.updateById(formDefinition);
        return R.ok();
    }

    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable Integer[] id) {
        FormDefinitionService.removeByIds(Arrays.asList(id));
        return R.ok();
    }

}
