package com.entfrm.biz.extension.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.ActCategory;
import com.entfrm.biz.extension.entity.Button;
import com.entfrm.biz.extension.service.ActCategoryService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;


/**
 *<p>
 * 流程分类管理 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/flowable/extension/actCategory")
@AllArgsConstructor
public class ActCategoryController {

    private final ActCategoryService actCategoryService;

    private LambdaQueryWrapper<ActCategory> getLambdaQueryWrapper() {
        return new LambdaQueryWrapper<ActCategory>().orderByAsc(ActCategory::getSort);
    }

    @GetMapping("/list")
    public R list() {
        List<ActCategory> actCategories = actCategoryService.list(getLambdaQueryWrapper());
        return R.ok(actCategories);
    }


    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(actCategoryService.getById(id));
    }


    @PostMapping("/save")
    public R save(@RequestBody ActCategory actCategory) {
        actCategoryService.save(actCategory);
        return R.ok();
    }


    @PutMapping("/update")
    public R update(@RequestBody ActCategory actCategory) {
        actCategoryService.updateById(actCategory);
        return R.ok();
    }


    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable Integer[] id) {
        actCategoryService.removeByIds(Arrays.asList(id));
        return R.ok();
    }


}
