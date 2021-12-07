package com.entfrm.biz.intelligent.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;
import java.util.Map;

/**
 * @Author entfrm开发团队-王翔
 * @Date 2020-12-24 
 * @Description  用户表单扩展实体类
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("intelligent_form_extend")
public class FormExtend{

	private static final long serialVersionUID =  2594155690092294644L;

	/**
	 * 表单扩展模板编码
	 */
	@TableId
	private Long id;

	/**
	 * 表单扩展编码
	 */
	private String code;

	/**
	 * 表单扩展模板名称
	 */
	private String name;


	/**
	 * 渲染控件数据集合
	 */
	private String drawingControls;


	/**
	 * 级联下拉树形选项局部ID-内部标识-目前实现控件独立
	 */
	private String treeNodeId;
	

	/**
	 * 记录目前控件全局ID-自增长
	 */
	private Long idGlobal;
	/**
	 * 创建人
	 */
	private  String createBy;

	/**
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 更新者
	 */
	private String updateBy;

	/**
	 * 更新时间
	 */
	private Date updateTime;

	/**
	 * 备注
	 */
	private String remarks;

	/** 开始时间 */
	@TableField(exist = false)
	@JsonIgnore
	private String beginTime;

	/** 结束时间 */
	@TableField(exist = false)
	@JsonIgnore
	private String endTime;

	@TableField(exist = false)
	private Map<String,Object> dataConf;

}
