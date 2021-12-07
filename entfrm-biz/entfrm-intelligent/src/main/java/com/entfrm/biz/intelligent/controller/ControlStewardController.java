package com.entfrm.biz.intelligent.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.intelligent.entity.FormExtend;
import com.entfrm.biz.intelligent.entity.ControlSteward;
import com.entfrm.biz.intelligent.mapper.FormExtendDesignMapper;
import com.entfrm.biz.intelligent.service.ControlStewardService;
import com.entfrm.log.annotation.OperLog;
import com.entfrm.security.util.SecurityUtil;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 控件大管家控制层
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/27
 */
@RestController
@AllArgsConstructor
@Transactional(rollbackFor = Exception.class)
@RequestMapping("/intelligent/ControlSteward")
public class ControlStewardController {

    private final ControlStewardService controlStewardService;
    private final FormExtendDesignMapper formExtendDesignMapper;

    private LambdaQueryWrapper<ControlSteward> getQueryWrapper(ControlSteward controlSteward) {
        return new QueryWrapper<ControlSteward>().lambda()
                .like(StrUtil.isNotBlank(controlSteward.getControlLabel()),
                        ControlSteward::getControlLabel, controlSteward.getControlLabel())
                .like(StrUtil.isNotBlank(controlSteward.getControlTagIcon()),
                        ControlSteward::getControlTagIcon, controlSteward.getControlTagIcon())
                .between(StrUtil.isNotBlank(controlSteward.getBeginTime()) && StrUtil.isNotBlank(controlSteward.getEndTime()),
                        ControlSteward::getCreateTime, controlSteward.getBeginTime(), controlSteward.getEndTime());
    }



    @GetMapping("/list")
    public R list(Page page, ControlSteward controlSteward) {
        IPage<FormExtend> roleIPage = controlStewardService.page(page, getQueryWrapper(controlSteward));
        return R.ok(roleIPage.getRecords(), roleIPage.getTotal());
    }



    @GetMapping("/{id}")
    public R getById(@PathVariable("id") Integer id) {
        return R.ok(controlStewardService.getById(id));
    }


    @OperLog("控件大管家新增")
    @PostMapping("/save")
    public R save(@RequestBody ControlSteward controlSteward) {
        controlSteward.setControlMappingTable(controlSteward.getControlMappingTablePrepend().trim().concat(controlSteward.getControlMappingTableSuffix().trim()));
        if(controlStewardService.list(new LambdaQueryWrapper<ControlSteward>()
                .eq(StrUtil.isNotBlank(controlSteward.getControlTagIcon()),
                        ControlSteward::getControlTagIcon, controlSteward.getControlTagIcon())).size()==0 &&
           controlStewardService.list(new LambdaQueryWrapper<ControlSteward>()
               .eq(StrUtil.isNotBlank(controlSteward.getControlMappingTable()),
                       ControlSteward::getControlMappingTable, controlSteward.getControlMappingTable())).size()==0){
            controlStewardService.createControlsTable(controlSteward.getControlMappingTable(), controlSteward.getControlAttribute());
            controlSteward.setCreateBy(SecurityUtil.getUser().getUsername());
            controlSteward.setCreateTime(new Date());
            controlStewardService.save(controlSteward);
        }else{
            return R.error("控件图标或控件映射表名重复,请检测!");
        }
        return R.ok();
    }


    @OperLog("控件大管家修改")
    @PutMapping("/update")
    public R update(@RequestBody ControlSteward controlSteward) {
        controlSteward.setControlMappingTable(controlSteward.getControlMappingTablePrepend().trim().concat(controlSteward.getControlMappingTableSuffix().trim()));

        //控件表名修改
        ControlSteward select= controlStewardService.getBaseMapper().selectById(controlSteward.getId());
        if(StrUtil.compare(controlSteward.getControlMappingTable(),select.getControlMappingTable(),true)!=0){
            formExtendDesignMapper.reTableName(select.getControlMappingTable(), controlSteward.getControlMappingTable());
        }

        controlSteward.setUpdateBy(SecurityUtil.getUser().getUsername());
        controlSteward.setUpdateTime(new Date());
        controlStewardService.update(controlSteward,new LambdaUpdateWrapper<ControlSteward>()
                .eq(ControlSteward::getId, controlSteward.getId()));
        return R.ok();
    }


    @OperLog("控件大管家删除")
    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable Integer[] ids) {
        //校验控件表是否有数据有数据不让删除
        List<ControlSteward> controlStewards= controlStewardService.getBaseMapper().selectList(new LambdaQueryWrapper<ControlSteward>().in(ControlSteward::getId,ids));
        for(ControlSteward e:controlStewards){
            if(controlStewardService.selectControlsTable(e.getControlMappingTable())>0){
                return R.error("目前控件中控件数据表存在数据,不允许删除!");
            }
        }
        controlStewardService.deleteControlsTable(ids);
        controlStewardService.removeByIds(Arrays.asList(ids));
        return R.ok();
    }


}
