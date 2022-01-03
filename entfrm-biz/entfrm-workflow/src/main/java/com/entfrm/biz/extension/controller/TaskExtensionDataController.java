package com.entfrm.biz.extension.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.TaskExtensionData;
import com.entfrm.biz.extension.service.TaskExtensionDataService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 *<p>
 * 任务扩展数据 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/taskExtensionData")
@AllArgsConstructor
public class TaskExtensionDataController {

	private final TaskExtensionDataService taskExtensionDataService;

	@GetMapping("/{id}")
	public R getById(@PathVariable("id") Integer id) {
		return R.ok(taskExtensionDataService.findById(id));
	}


	@GetMapping("findByDefIdAndTaskId")
	public R findByDefIdAndTaskId(TaskExtensionData taskExtensionData) throws Exception {
		if(StrUtil.isBlank(taskExtensionData.getProcessDefId()) || StrUtil.isBlank(taskExtensionData.getTaskDefId())){
			return R.error("ProcessDefId || askDefId 为空");
		}
		List<TaskExtensionData> list = taskExtensionDataService.list(new LambdaQueryWrapper<TaskExtensionData>()
				.eq(StrUtil.isNotBlank(taskExtensionData.getProcessDefId()), TaskExtensionData::getProcessDefId, taskExtensionData.getProcessDefId())
				.eq(StrUtil.isNotBlank(taskExtensionData.getTaskDefId()), TaskExtensionData::getTaskDefId, taskExtensionData.getTaskDefId()));
		if(list.size() > 1){
			throw new Exception("重复的task id定义!");
		}
		return R.ok(taskExtensionDataService.findById(list.get(0).getId()));
	}

	@PostMapping("/save")
	public R save(@RequestBody List<TaskExtensionData> taskExtensionDataList) {
		for(TaskExtensionData taskExtensionData: taskExtensionDataList){
			List<TaskExtensionData> list = taskExtensionDataService.list(new LambdaQueryWrapper<TaskExtensionData>()
					.eq(StrUtil.isNotBlank(taskExtensionData.getProcessDefId()), TaskExtensionData::getProcessDefId, taskExtensionData.getProcessDefId())
					.eq(StrUtil.isNotBlank(taskExtensionData.getTaskDefId()), TaskExtensionData::getTaskDefId, taskExtensionData.getTaskDefId()));
			list.forEach(item -> taskExtensionDataService.delete(item.getId()));
			taskExtensionDataService.save(taskExtensionData);
		}
		return R.ok();
	}

	@DeleteMapping("/remove/{ids}")
	public R remove(@PathVariable Integer[] ids) {
		Arrays.asList(ids).forEach(id -> taskExtensionDataService.delete(id));
		return R.ok();
	}

}
