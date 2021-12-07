package com.entfrm.biz.intelligent.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.intelligent.entity.FormExtend;
import com.entfrm.biz.intelligent.service.FormExtendDesignService;
import com.entfrm.biz.intelligent.service.FormExtendService;
import com.entfrm.log.annotation.OperLog;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;

/**
 *<p>
 * 表单扩展控制
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2020/12/25
 */
@RestController
@AllArgsConstructor
@Transactional(rollbackFor = Exception.class)
@RequestMapping("/intelligent/formExtend")
public class FormExtendController {
   
    private final FormExtendService formExtendService;

    private final FormExtendDesignService formExtendDesignService;

    private QueryWrapper<FormExtend> getQueryWrapper(FormExtend formExtend) {
        return new QueryWrapper<FormExtend>()
                .like(StrUtil.isNotBlank(formExtend.getCode()),"code", formExtend.getCode())
                .like(StrUtil.isNotBlank(formExtend.getName()), "name", formExtend.getName())
                .between(StrUtil.isNotBlank(formExtend.getBeginTime()) && StrUtil.isNotBlank(formExtend.getEndTime()), "create_time", formExtend.getBeginTime(), formExtend.getEndTime());
    }

    @PreAuthorize("@ps.hasPerm('form_extend_view')")
    @GetMapping("/list")
    public R list(Page page, FormExtend formExtend) {
        IPage<FormExtend> roleIPage = formExtendService.page(page, getQueryWrapper(formExtend));
        return R.ok(roleIPage.getRecords(), roleIPage.getTotal());
    }


    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(formExtendService.getById(id));
    }


    @GetMapping("cascade/{id}")
    public R getSelectSingle(@PathVariable("id") Integer id) {
        return R.ok(formExtendService.selectSingle(id));
    }


    @GetMapping("fetchFormExtend/{code}")
    public R fetchFormExtend(@PathVariable("code") String code) {
        formExtendService.fetchFormExtend(code);
        return R.ok(formExtendService.fetchFormExtend(code));
    }


    @OperLog("扩展模板新增")
    @PreAuthorize("@ps.hasPerm('form_extend_add')")
    @PostMapping("/save")
    public R save(@RequestBody FormExtend formExtend) {
        if(formExtendService.list(new QueryWrapper<FormExtend>()
                .eq(StrUtil.isNotBlank(formExtend.getCode()),"code", formExtend.getCode())).size()==0){
            formExtend.setCreateBy(SecurityUtil.getUser().getUsername());
            formExtend.setCreateTime(new Date());
            formExtendService.save(formExtend);
        }else{
            return R.error("编码重复!");
        }
        return R.ok();
    }

    @OperLog("扩展模板修改")
    @PreAuthorize("@ps.hasPerm('form_extend_edit')")
    @PutMapping("/update")
    public R update(@RequestBody FormExtend formExtend) {
        formExtend.setUpdateBy(SecurityUtil.getUser().getUsername());
        formExtend.setUpdateTime(new Date());
        formExtendService.update(formExtend,new UpdateWrapper<FormExtend>().eq("id", formExtend.getId()));
        return R.ok();
    }


    @OperLog("扩展模板删除")
    @PreAuthorize("@ps.hasPerm('form_extend_del')")
    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        formExtendService.removeByIds(Arrays.asList(ids));
        Arrays.asList(ids).forEach(item->{
            formExtendDesignService.delete(Long.valueOf(item));
        });
        return R.ok();
    }




}
