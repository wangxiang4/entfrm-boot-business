package com.entfrm.biz.flowable.controller.extension;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.Button;
import com.entfrm.biz.flowable.entity.Listener;
import com.entfrm.biz.flowable.service.ListenerService;
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
@RequestMapping("/flowable/extension/listener")
@AllArgsConstructor
public class ListenerController {

    private final ListenerService listenerService;


    private QueryWrapper<Listener> getQueryWrapper(Listener listener) {
        return new QueryWrapper<Listener>()
                .eq(StrUtil.isNotBlank(listener.getName()), "name", listener.getName())
                .eq(ObjectUtil.isNotNull(listener.getListenerType()), "listener_type", listener.getListenerType());
    }


    @GetMapping("/list")
    public R list(Page page, Listener listener) {
        IPage<Button> buttonIPage = listenerService.page(page, getQueryWrapper(listener));
        return R.ok(buttonIPage.getRecords(), buttonIPage.getTotal());
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



    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable Integer[] id) {
        listenerService.removeByIds(Arrays.asList(id));
        return R.ok();
    }


}
