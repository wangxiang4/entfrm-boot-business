package com.entfrm.biz.flowable.controller;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.base.util.ExcelUtil;
import com.entfrm.biz.flowable.entity.Leave;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.biz.flowable.service.FlowableTaskService;
import com.entfrm.biz.flowable.service.LeaveService;
import com.entfrm.biz.flowable.vo.ProcessInsVo;
import com.entfrm.log.annotation.OperLog;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;


/**
 *<p>
 * 请假流程例子 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@RestController
@AllArgsConstructor
@RequestMapping("/flowable/leave")
public class LeaveController {
    
    
    private final LeaveService leaveService;
    private final FlowableProcessService flowableProcessService;
    private final FlowableTaskService flowableTaskService;



    private QueryWrapper<Leave> getQueryWrapper(Leave leave) {
        return new QueryWrapper<Leave>().like(StrUtil.isNotBlank(leave.getUserName()), "user_name", leave.getUserName()).eq(StrUtil.isNotBlank(leave.getType()), "type", leave.getType())
                .between(StrUtil.isNotBlank(leave.getBeginTime()) && StrUtil.isNotBlank(leave.getEndTime()), "create_time", leave.getBeginTime(), leave.getEndTime()).apply(StrUtil.isNotBlank(leave.getSqlFilter()), leave.getSqlFilter());
    }



    @GetMapping("/list")
    public R list(Page page, Leave leave) {
        IPage<Leave> leaveIPage = leaveService.page(page, getQueryWrapper(leave));
        List<Leave> leaves=leaveIPage.getRecords().stream().map(item->{
            ProcessInsVo processInsVo=flowableProcessService.queryProcessState(item.getProcInsId());
            item.setStatus(ObjectUtil.isNotEmpty(processInsVo)?processInsVo.getCode():-1);
            return item;
        }).collect(Collectors.toList());
        return R.ok(leaves, leaveIPage.getTotal());
    }



    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(leaveService.getById(id));
    }




    @OperLog("请假新增")
    @PreAuthorize("@ps.hasPerm('leave_add')")
    @PostMapping("/save")
    public R save(@RequestBody Leave leave) {
        leave.setUserName(SecurityUtil.getUser().getUsername());
        return R.ok(leaveService.save(leave));
    }



    @OperLog("请假修改 ")
    @PreAuthorize("@ps.hasPerm('leave_edit')")
    @PutMapping("/update")
    public R update(@RequestBody Leave leave) {
        return R.ok(leaveService.updateById(leave));
    }




    @OperLog("请假删除")
    @PreAuthorize("@ps.hasPerm('leave_del')")
    @DeleteMapping("/remove/{id}")
    public R removeById(@PathVariable Integer[] id) {
        return R.ok(leaveService.removeByIds(Arrays.asList(id)));
    }




    @OperLog("启动请假流程")
    @GetMapping("/startProcess/{id}")
    public R startProcess(@PathVariable String id) {
        String procInsId= flowableTaskService.startProcess(
                Leave.class.getSimpleName(),
                Leave.class.getAnnotation(TableName.class).value(),
                String.valueOf(id),"请假审批");
        return R.ok(procInsId,"启动成功");
    }



    @OperLog("请假导出")
    @PreAuthorize("@ps.hasPerm('leave_export')")
    @GetMapping("/export")
    @ResponseBody
    public R export(Leave leave) {
        List<Leave> list = leaveService.list(getQueryWrapper(leave));
        ExcelUtil<Leave> util = new ExcelUtil<Leave>(Leave.class);
        return util.exportExcel(list, "请假数据");
    }





}
