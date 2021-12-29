package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.FormDefinition;
import com.entfrm.biz.extension.mapper.FormDefinitionMapper;
import com.entfrm.biz.extension.service.FormDefinitionService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 表单定义 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-06-21
 */
@Service
public class FormDefinitionServiceImpl extends ServiceImpl<FormDefinitionMapper, FormDefinition> implements FormDefinitionService {

    @Override
    public IPage<FormDefinition> findList(Page page, FormDefinition formDefinition) {
        return baseMapper.findList(page, formDefinition);
    }

}
