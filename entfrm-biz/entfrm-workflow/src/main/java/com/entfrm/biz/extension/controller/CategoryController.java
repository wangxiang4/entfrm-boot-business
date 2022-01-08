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
        if (categoryService.list(new LambdaQueryWrapper<Category>().eq(Category::getName, category.getName())).size() > 0) {
            return R.error("当前不支持名字有重复,强行添加流程分类查询会有问题,后期需要改工作流内部表添加冗余字段解决");
        }
        categoryService.save(category);
        return R.ok();
    }

    @PutMapping("/update")
    public R update(@RequestBody Category category) {
        if (categoryService.list(new LambdaQueryWrapper<Category>().eq(Category::getName, category.getName())).size() > 0) {
            return R.error("当前不支持名字有重复,强行添加流程分类查询会有问题,后期需要改工作流内部表添加冗余字段解决");
        }
        categoryService.updateById(category);
        return R.ok();
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        categoryService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
