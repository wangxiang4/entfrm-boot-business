package com.entfrm.biz.extension.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.extension.entity.FormDefinition;

/**
 * <p>
 * 表单定义 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-06-21
 */
public interface FormDefinitionService extends IService<FormDefinition> {

    IPage<FormDefinition> findList(Page page, FormDefinition formDefinition);

}
