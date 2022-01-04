package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 *<p>
 * 流程表达式
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/6/20
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_condition")
public class Condition implements Serializable {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 名称 */
	private String name;

	/** 表达式 */
	private String expression;

	/** 表达式 */
	private String remarks;

}
