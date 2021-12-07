package com.entfrm.biz.flowable.vo;

import com.entfrm.biz.flowable.entity.FormCategory;
import com.entfrm.biz.flowable.entity.FormDefinition;
import com.entfrm.biz.flowable.entity.FormDefinitionDesignData;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 *<p>
 * 表单定义vo
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/4
 */
@Data
public class FormDefinitionVo {

    private FormCategory formCategory;
    private FormDefinition formDefinition;
    private FormDefinitionDesignData  formDefinitionDesignData;
    
}
