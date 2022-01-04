package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.ActivityExtensionProperty;
import com.entfrm.biz.extension.service.ActivityExtensionPropertyService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 *<p>
 * 活动扩展属性 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/activityExtensionProperty")
@AllArgsConstructor
public class ActivityExtensionPropertyController {

    private final ActivityExtensionPropertyService activityExtensionPropertyService;

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(activityExtensionPropertyService.getById(id));
    }

    @GetMapping("findByDefIdAndTaskIdAndKey")
    public  R findByDefIdAndTaskIdAndKey(ActivityExtensionProperty activityExtensionProperty) {
        ActivityExtensionProperty model = activityExtensionPropertyService.getOne(new LambdaUpdateWrapper<ActivityExtensionProperty>()
                .eq(StrUtil.isNotBlank(activityExtensionProperty.getProcessDefId()), ActivityExtensionProperty::getProcessDefId, activityExtensionProperty.getProcessDefId())
                .eq(StrUtil.isNotBlank(activityExtensionProperty.getActivityDefId()), ActivityExtensionProperty::getActivityDefId, activityExtensionProperty.getActivityDefId())
                .eq(StrUtil.isNotBlank(activityExtensionProperty.getKey()), ActivityExtensionProperty::getKey, activityExtensionProperty.getKey()));
        return R.ok(model);
    }

    @PostMapping("/save")
    public R save(@RequestBody List<ActivityExtensionProperty> activityExtensionPropertyList) {
        activityExtensionPropertyList.forEach(taskExtensionProperty -> {
            activityExtensionPropertyService.remove(new LambdaUpdateWrapper<ActivityExtensionProperty>()
                    .eq(ActivityExtensionProperty::getProcessDefId,taskExtensionProperty.getProcessDefId())
                    .eq(ActivityExtensionProperty::getActivityDefId,taskExtensionProperty.getActivityDefId()));
        });
        activityExtensionPropertyList.forEach(taskExtensionProperty -> activityExtensionPropertyService.save(taskExtensionProperty));
        return R.ok();
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        activityExtensionPropertyService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
