package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Listener;
import com.entfrm.biz.extension.entity.TaskExtensionData;
import com.entfrm.biz.extension.entity.TaskExtensionProperty;
import com.entfrm.biz.extension.service.ListenerService;
import com.entfrm.biz.extension.service.TaskExtensionDataService;
import com.entfrm.biz.extension.service.TaskExtensionPropertyService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 *<p>
 * 任务扩展属性 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/taskExtensionProperty")
@AllArgsConstructor
public class TaskExtensionPropertyController {

    private final TaskExtensionPropertyService taskExtensionPropertyService;

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(taskExtensionPropertyService.getById(id));
    }

    @GetMapping("findByDefIdAndTaskIdAndKey")
    public  R findByDefIdAndTaskIdAndKey(TaskExtensionProperty taskExtensionProperty) {
        TaskExtensionProperty model = taskExtensionPropertyService.getOne(new LambdaUpdateWrapper<TaskExtensionProperty>()
                .eq(StrUtil.isNotBlank(taskExtensionProperty.getProcessDefId()), TaskExtensionProperty::getProcessDefId, taskExtensionProperty.getProcessDefId())
                .eq(StrUtil.isNotBlank(taskExtensionProperty.getTaskDefId()), TaskExtensionProperty::getTaskDefId, taskExtensionProperty.getTaskDefId())
                .eq(StrUtil.isNotBlank(taskExtensionProperty.getKey()), TaskExtensionProperty::getKey, taskExtensionProperty.getKey()));
        return R.ok(model);
    }

    @PostMapping("/save")
    public R save(@RequestBody List<TaskExtensionProperty> taskExtensionPropertyList) {
        taskExtensionPropertyList.forEach(taskExtensionProperty -> {
            taskExtensionPropertyService.remove(new LambdaUpdateWrapper<TaskExtensionProperty>()
                    .eq(TaskExtensionProperty::getProcessDefId,taskExtensionProperty.getProcessDefId())
                    .eq(TaskExtensionProperty::getTaskDefId,taskExtensionProperty.getTaskDefId()));
        });
        taskExtensionPropertyList.forEach(taskExtensionProperty -> taskExtensionPropertyService.save(taskExtensionProperty));
        return R.ok();
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        taskExtensionPropertyService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }
}
