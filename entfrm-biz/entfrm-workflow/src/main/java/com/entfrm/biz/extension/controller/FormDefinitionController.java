package com.entfrm.biz.extension.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
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
@RequestMapping("/workflow/extension/formDefinition")
@AllArgsConstructor
public class FormDefinitionController {

    private final FormDefinitionService FormDefinitionService;

    @GetMapping("/list")
    public R list(Page page, FormDefinition formDefinition) {
        IPage<FormDefinition> result = FormDefinitionService.findList(page, formDefinition);
        return R.ok(result.getRecords(), result.getTotal());
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

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        FormDefinitionService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
