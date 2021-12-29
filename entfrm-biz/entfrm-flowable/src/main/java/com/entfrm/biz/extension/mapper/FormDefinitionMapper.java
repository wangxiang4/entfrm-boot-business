package com.entfrm.biz.extension.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.biz.extension.entity.FormDefinition;
import org.apache.ibatis.annotations.Param;

/**
 *<p>
 * 表单定义 Mapper
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/3
 */
public interface FormDefinitionMapper extends BaseMapper<FormDefinition> {

    IPage<FormDefinition> findList(Page page, @Param("formDefinition") FormDefinition formDefinition);

}
