package com.entfrm.biz.flowable.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 *<p>
 * 表单定义设计数据
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/4
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_form_def_design_data")
public class FormDefinitionDesignData {

	/** id **/
	@TableId
	private Integer id;
	private String createBy;
	private Date createTime;
	private String updateBy;
	private Date updateTime;
	/** 表单定义id **/
	private Integer formDefinitionId;
	/** 表单设计json数据 **/
	private String json;
	/** 版本号 **/
	private Integer version;
	/** 状态 **/
	private String status;
	/** 是否主版本 **/
	private String isPrimary;

}
