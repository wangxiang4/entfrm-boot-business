package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 *<p>
 * 监听器
 * 任务监听器|执行监听器
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/6/25
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_listener")
public class Listener implements Serializable {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 名称 */
	private String name;

	/** 监听器类型 */
	private Integer listenerType;

	/** 事件 */
	private String event;

	/** 值类型 */
	private Integer valueType;

	/** 值 */
	private String value;

}
