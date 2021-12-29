package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Button;
import com.entfrm.biz.extension.service.ButtonService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;


/**
 *<p>
 * 常用按钮 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/flowable/extension/button")
@AllArgsConstructor
public class ButtonController {

    private final ButtonService buttonService;

    private QueryWrapper<Button> getQueryWrapper(Button button) {
        return new QueryWrapper<Button>()
                .eq(StrUtil.isNotBlank(button.getName()), "name", button.getName())
                .eq(StrUtil.isNotBlank(button.getCode()), "code", button.getCode());
    }


    @GetMapping("/list")
    public R list(Page page, Button button) {
        IPage<Button> buttonIPage = buttonService.page(page, getQueryWrapper(button));
        return R.ok(buttonIPage.getRecords(), buttonIPage.getTotal());
    }


    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(buttonService.getById(id));
    }


    @PostMapping("/save")
    public R save(@RequestBody Button button) {
        buttonService.save(button);
        return R.ok();
    }


    @PutMapping("/update")
    public R update(@RequestBody Button button) {
        buttonService.updateById(button);
        return R.ok();
    }


    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable Integer[] id) {
        buttonService.removeByIds(Arrays.asList(id));
        return R.ok();
    }


}
