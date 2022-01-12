package com.entfrm.biz.extension.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.extension.entity.Button;
import com.entfrm.biz.extension.entity.WorkflowCopy;
import com.entfrm.biz.extension.service.WorkflowCopyService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 *<p>
 * 流程抄送 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/workflow/extension/workflowCopy")
@AllArgsConstructor
public class WorkflowCopyController {

    private final WorkflowCopyService workflowCopyService;

    @GetMapping("/list")
    public R list(Page page, WorkflowCopy workflowCopy) {
        IPage<WorkflowCopy> result = workflowCopyService.findList(page, workflowCopy);
        return R.ok(result.getRecords(), result.getTotal());
    }

    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(workflowCopyService.getById(id));
    }

    @PostMapping("/save/{userIds}")
    public R save(@PathVariable Integer[] userIds, @RequestBody WorkflowCopy workflowCopy) {
        if (userIds != null) {
            for(Integer userId: userIds){
                workflowCopy.setId(null);
                workflowCopy.setUserId(userId);
                workflowCopyService.save(workflowCopy);
            }
        }
        return R.ok("保存流程抄送成功");
    }

    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        workflowCopyService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }

}
