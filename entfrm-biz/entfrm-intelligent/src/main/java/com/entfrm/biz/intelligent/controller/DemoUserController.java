package com.entfrm.biz.intelligent.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.convert.Convert;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.intelligent.dto.Integrated;
import com.entfrm.biz.intelligent.entity.DemoUser;
import com.entfrm.biz.intelligent.service.BusinessIntegratedProcessService;
import com.entfrm.biz.intelligent.service.DemoUserService;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * <p>
 * 用户例子控制层
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
@RestController
@AllArgsConstructor
@Transactional(rollbackFor = Exception.class)
@RequestMapping("/intelligent/DemoUser")
public class DemoUserController {


    private final DemoUserService demoUserService;

    private final BusinessIntegratedProcessService businessIntegratedProcessService;

    private QueryWrapper<DemoUser> getQueryWrapper(DemoUser demoUser) {
        return new QueryWrapper<DemoUser>()
                .like(StrUtil.isNotBlank(demoUser.getNickName()), "nick_name", demoUser.getNickName());
    }

    @GetMapping("/list")
    public R list(Page page, DemoUser demoUser) {
        IPage<DemoUser> userIPage = demoUserService.page(page, getQueryWrapper(demoUser));
        return R.ok(userIPage.getRecords(), userIPage.getTotal());
    }



    @GetMapping("/getById/{id}/{formCode}/{version}")
    public R getById(@PathVariable Integer id,@PathVariable String formCode,@PathVariable Float version) {
        DemoUser demoUser = demoUserService.getById(id);
        Map<String,Object> businessData=businessIntegratedProcessService.businessSelect(id,formCode,version);
        BeanUtil.copyProperties(demoUser,businessData);
        return R.ok(businessData);
    }


    @PostMapping("/save")
    public R save(@RequestBody Integrated integrated) {
        DemoUser demoUser = Convert.convert(DemoUser.class,integrated.getFormData());
        demoUserService.save(demoUser);
        integrated.setBusinessId(demoUser.getId());
        businessIntegratedProcessService.businessInsert(integrated);
        return R.ok();
    }


    @PutMapping("/update")
    public R update(@RequestBody Integrated integrated) {
        DemoUser demoUser = Convert.convert(DemoUser.class,integrated.getFormData());
        demoUserService.update(demoUser,
                Wrappers.<DemoUser>lambdaUpdate().eq(DemoUser::getId, demoUser.getId()));
        integrated.setBusinessId(demoUser.getId());
        businessIntegratedProcessService.businessUpdate(integrated);
        return R.ok();
    }


    @DeleteMapping("/remove/{ids}/{formCode}/{version}")
    public R remove(@PathVariable Integer[] ids,@PathVariable String formCode,@PathVariable Float version) {
        demoUserService.removeByIds(Arrays.asList(ids));
        businessIntegratedProcessService.businessDelete(ids,formCode,version);
        return R.ok();
    }


}
