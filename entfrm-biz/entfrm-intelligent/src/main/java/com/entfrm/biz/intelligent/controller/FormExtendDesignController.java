package com.entfrm.biz.intelligent.controller;

import com.entfrm.base.api.R;
import com.entfrm.biz.intelligent.dto.FormExtendDesignDto;
import com.entfrm.biz.intelligent.service.FormExtendDesignService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 表单扩展设计器控制
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
@RestController
@AllArgsConstructor
@RequestMapping("/intelligent/FormExtendDesign")
public class FormExtendDesignController {

    private final FormExtendDesignService formExtendDesignService;

    @PostMapping("/save")
    public R save(@RequestBody FormExtendDesignDto formExtendDesignDto) {
        formExtendDesignService.insert(formExtendDesignDto);
        return R.ok();
    }


    @PutMapping("/update")
    public R update(@RequestBody FormExtendDesignDto formExtendDesignDto) {
        formExtendDesignService.update(formExtendDesignDto);
        return R.ok();
    }


    @GetMapping("/tableValidator/{table}")
    public R validatorBusinessTable(@PathVariable String table) {
        return R.ok(formExtendDesignService.validatorBusinessTable(table));
    }

}
