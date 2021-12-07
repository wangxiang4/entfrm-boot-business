package com.entfrm.biz.flowable.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.biz.flowable.dto.FormDefinitionDto;
import com.entfrm.biz.flowable.entity.FormCategory;
import com.entfrm.biz.flowable.entity.FormDefinition;
import com.entfrm.biz.flowable.vo.FormDefinitionVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *<p>
 * 表单定义 Mapper
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/3
 */
public interface FormDefinitionMapper extends BaseMapper<FormDefinition> {

    IPage<FormDefinitionVo> findList(Page page, @Param("formDefinitionVo") FormDefinitionVo formDefinitionVo);

}
