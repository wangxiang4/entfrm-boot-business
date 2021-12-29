package com.entfrm.biz.extension.controller;

import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.FormCategory;
import com.entfrm.biz.extension.service.FormCategoryService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

/**
 *<p>
 * 表单定义分类管理 Controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/3
 */
@RestController
@RequestMapping(value = "/flowable/extension/formCategory")
@AllArgsConstructor
public class FormCategoryController {

	private final FormCategoryService formCategoryService;

	@GetMapping("/list")
	public R list() {
		List<FormCategory> actCategories = formCategoryService.list();
		return R.ok(actCategories);
	}

	@GetMapping("/{id}")
	public R getById(@PathVariable("id") Integer id) {
		return R.ok(formCategoryService.getById(id));
	}

	@PostMapping("/save")
	public R save(@RequestBody FormCategory  formCategory) {
		formCategoryService.save(formCategory);
		return R.ok();
	}

	@PutMapping("/update")
	public R update(@RequestBody FormCategory formCategory) {
		formCategoryService.updateById(formCategory);
		return R.ok();
	}

	@DeleteMapping("/remove/{id}")
	public R remove(@PathVariable Integer[] id) {
		formCategoryService.removeByIds(Arrays.asList(id));
		return R.ok();
	}

}
