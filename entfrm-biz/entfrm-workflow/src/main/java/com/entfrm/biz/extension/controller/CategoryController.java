package com.entfrm.biz.extension.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Category;
import com.entfrm.biz.extension.service.CategoryService;
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
@RequestMapping("/workflow/extension/category")
@AllArgsConstructor
public class CategoryController {

    private final CategoryService categoryService;

    @GetMapping("/list")
    public R list() {
        List<Category> result = categoryService.list();
        return R.ok(result);
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(categoryService.getById(id));
    }

    @PostMapping("/save")
    public R save(@RequestBody Category category) {
        // 过滤名称分割字符,后续流程分类有关功能有用到
        category.setName(category.getName().replaceAll(",",""));
        categoryService.save(category);
        return R.ok();
    }

    @PutMapping("/update")
    public R update(@RequestBody Category category) {
        // 过滤名称分割字符,后续流程分类有关功能有用到
        category.setName(category.getName().replaceAll(",",""));
        categoryService.updateById(category);
        return R.ok();
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        categoryService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
