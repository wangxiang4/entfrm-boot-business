package com.entfrm.biz.extension.entity;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
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
@TableName(value = "act_extension_form_def", excludeProperty = { "formCategory", "formDefinitionJson" })
public class FormDefinition extends CommonEntity {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 表单定义分类管理id */
	private Integer categoryId;

	/** 表单定义名称 */
	private String name;

	/** 表单定义分类 */
	private FormCategory formCategory = new FormCategory();

	/** 表单定义json */
	private FormDefinitionJson formDefinitionJson = new FormDefinitionJson();

}
