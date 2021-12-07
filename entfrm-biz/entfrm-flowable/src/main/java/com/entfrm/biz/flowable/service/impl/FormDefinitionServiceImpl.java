package com.entfrm.biz.flowable.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.flowable.dto.FormDefinitionDto;
import com.entfrm.biz.flowable.entity.FormCategory;
import com.entfrm.biz.flowable.entity.FormDefinition;
import com.entfrm.biz.flowable.mapper.FormCategoryMapper;
import com.entfrm.biz.flowable.mapper.FormDefinitionMapper;
import com.entfrm.biz.flowable.service.FormCategoryService;
import com.entfrm.biz.flowable.service.FormDefinitionService;
import com.entfrm.biz.flowable.vo.FormDefinitionVo;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public IPage<FormDefinitionVo> findList(Page page, FormDefinitionDto formDefinitionDto) {
        return baseMapper.findList(page, formDefinitionDto);
    }

}
