package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.flowable.dto.FormDefinitionDto;
import com.entfrm.biz.flowable.entity.FormCategory;
import com.entfrm.biz.flowable.entity.FormDefinition;
import com.entfrm.biz.flowable.vo.FormDefinitionVo;

import java.util.List;

/**
 * <p>
 * 表单定义 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-06-21
 */
public interface FormDefinitionService extends IService<FormDefinition> {

    IPage<FormDefinitionVo> findList(Page page, FormDefinitionDto formDefinitionDto);

}
