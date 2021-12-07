package com.entfrm.biz.flowable.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 表单定义
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/3
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_form_def")
public class FormDefinition extends BaseEntity {

	/** id **/
	@TableId
	private Integer id;
	/** 表单定义分类管理id **/
	private String categoryId;
	/** 表单定义名称 **/
	private String name;

}
