package com.entfrm.biz.intelligent.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;

/**
 * <p>
 *  控件大管家
 * </p>
 * @Author: entfrm开发团队-王翔
 * @Date 2021/01/21 
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("intelligent_control_steward")
public class ControlSteward {

	private static final long serialVersionUID =  8374948829358663780L;

	@TableId
	private Long id;

	/**
	 * 控件名称
	 */
	private String controlLabel;

	/**
	 * 控件唯一图标
	 */
	private String controlTagIcon;

	/**
	 * 控件映射表面
	 */
	private String controlMappingTable;

	/**
	 * 控件字段类型
	 */
	private String controlFieldType;

	/**
	 * 控件字段长度
	 */
	private Long controlFieldLength;

	/**
	 * 控件字段精度
	 */
	private Long controlPrecision;

	/**
	 * 控件详细属性
	 */
	private String controlAttribute;

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

	/**
	 * 控件表面前缀
	 */
	private String controlMappingTablePrepend;

	/**
	 * 控件表面后缀
	 */
	private String controlMappingTableSuffix;


	/** 开始时间 */
	@TableField(exist = false)
	@JsonIgnore
	private String beginTime;

	/** 结束时间 */
	@TableField(exist = false)
	@JsonIgnore
	private String endTime;


}
