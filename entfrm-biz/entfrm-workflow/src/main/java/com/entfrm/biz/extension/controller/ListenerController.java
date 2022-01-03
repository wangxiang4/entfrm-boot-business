package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Button;
import com.entfrm.biz.extension.entity.Condition;
import com.entfrm.biz.extension.entity.Listener;
import com.entfrm.biz.extension.service.ListenerService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;


/**
 *<p>
 * 监听器 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/listener")
@AllArgsConstructor
public class ListenerController {

    private final ListenerService listenerService;

    private LambdaQueryWrapper<Listener> getLambdaQueryWrapper(Listener listener) {
        return new LambdaQueryWrapper<Listener>()
                .eq(StrUtil.isNotBlank(listener.getName()), Listener::getName, listener.getName())
                .eq(ObjectUtil.isNotNull(listener.getListenerType()), Listener::getListenerType, listener.getListenerType());
    }

    @GetMapping("/list")
    public R list(Page page, Listener listener) {
        IPage<Listener> result = listenerService.page(page, getLambdaQueryWrapper(listener));
        return R.ok(result.getRecords(), result.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(listenerService.getById(id));
    }

    @PostMapping("/save")
    public R save(@RequestBody Listener listener) {
        listenerService.save(listener);
        return R.ok();
    }

    @PutMapping("/update")
    public R update(@RequestBody Listener listener) {
        listenerService.updateById(listener);
        return R.ok();
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        listenerService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
