package com.entfrm.biz.flowable.controller.extension;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.dto.FormDefinitionDto;
import com.entfrm.biz.flowable.service.FormDefinitionService;
import com.entfrm.biz.flowable.vo.FormDefinitionVo;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *<p>
 * 表单定义 Controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/4
 */
@RestController
@RequestMapping(value = "/flowable/extension/formDefinition")
@AllArgsConstructor
public class FormDefinitionController {

    private final FormDefinitionService FormDefinitionService;

    @GetMapping("/list")
    public R list(Page page, FormDefinitionDto formDefinitionDto) {
        IPage<FormDefinitionVo> buttonIPage = FormDefinitionService.findList(page, formDefinitionDto);
        return R.ok(buttonIPage.getRecords(), buttonIPage.getTotal());
    }

}
