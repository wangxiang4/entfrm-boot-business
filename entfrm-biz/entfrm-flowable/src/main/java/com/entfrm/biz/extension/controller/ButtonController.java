package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
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

    private LambdaQueryWrapper<Button> getLambdaQueryWrapper(Button button) {
        return new LambdaQueryWrapper<Button>()
                .eq(StrUtil.isNotBlank(button.getName()), Button::getName, button.getName())
                .eq(StrUtil.isNotBlank(button.getCode()), Button::getCode, button.getCode())
                .orderByAsc(Button::getSort);
    }

    @GetMapping("/list")
    public R list(Page page, Button button) {
        IPage<Button> result = buttonService.page(page, getLambdaQueryWrapper(button));
        return R.ok(result.getRecords(), result.getTotal());
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

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        buttonService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
