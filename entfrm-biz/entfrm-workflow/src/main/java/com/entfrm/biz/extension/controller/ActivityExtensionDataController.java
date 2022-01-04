package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.ActivityExtensionData;
import com.entfrm.biz.extension.service.ActivityExtensionDataService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 *<p>
 * 活动扩展数据 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/activityExtensionData")
@AllArgsConstructor
public class ActivityExtensionDataController {

	private final ActivityExtensionDataService activityExtensionDataService;

	@GetMapping("/{id}")
	public R getById(@PathVariable("id") Integer id) {
		return R.ok(activityExtensionDataService.findById(id));
	}

	@GetMapping("findByDefIdAndTaskId")
	public R findByDefIdAndTaskId(ActivityExtensionData activityExtensionData) throws Exception {
		if(StrUtil.isBlank(activityExtensionData.getProcessDefId()) || StrUtil.isBlank(activityExtensionData.getActivityDefId())){
			return R.error("ProcessDefId || askDefId 为空");
		}
		List<ActivityExtensionData> list = activityExtensionDataService.list(new LambdaQueryWrapper<ActivityExtensionData>()
				.eq(StrUtil.isNotBlank(activityExtensionData.getProcessDefId()), ActivityExtensionData::getProcessDefId, activityExtensionData.getProcessDefId())
				.eq(StrUtil.isNotBlank(activityExtensionData.getActivityDefId()), ActivityExtensionData::getActivityDefId, activityExtensionData.getActivityDefId()));
		if(list.size() > 1){
			throw new Exception("重复的task id定义!");
		}
		return R.ok(activityExtensionDataService.findById(list.get(0).getId()));
	}

	@PostMapping("/save")
	public R save(@RequestBody List<ActivityExtensionData> activityExtensionDataList) {
		for(ActivityExtensionData activityExtensionData : activityExtensionDataList){
			List<ActivityExtensionData> list = activityExtensionDataService.list(new LambdaQueryWrapper<ActivityExtensionData>()
					.eq(StrUtil.isNotBlank(activityExtensionData.getProcessDefId()), ActivityExtensionData::getProcessDefId, activityExtensionData.getProcessDefId())
					.eq(StrUtil.isNotBlank(activityExtensionData.getActivityDefId()), ActivityExtensionData::getActivityDefId, activityExtensionData.getActivityDefId()));
			list.forEach(item -> activityExtensionDataService.delete(item.getId()));
			activityExtensionDataService.save(activityExtensionData);
		}
		return R.ok();
	}

	@DeleteMapping("/remove/{ids}")
	public R remove(@PathVariable Integer[] ids) {
		Arrays.asList(ids).forEach(id -> activityExtensionDataService.delete(id));
		return R.ok();
	}

}
