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

    /**
     * 本来打算不写此接口直接使用mybatis-plus继承接口selectPage的,经过查看内部源码
     * com.baomidou.mybatisplus.core.injector.AbstractMethod.sqlWhereEntityWrapper(boolean newLine, TableInfo table)
     * 发现EntityWrapper(简称ew)如果在xml中使用是不会做任何处理的,只有类似于这种@select()增删改查的注解与使用mybatis-plus内部的crud方法做了处理
     * 所以就导致无法使用ew,只能采用实体类往内部传值了
     *
     * @Param
     * @return
     */
    IPage<FormDefinition> findList(Page page, @Param("ew") FormDefinition formDefinition);

}
