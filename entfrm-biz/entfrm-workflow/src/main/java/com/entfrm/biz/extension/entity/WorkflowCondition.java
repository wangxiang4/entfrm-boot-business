package com.entfrm.biz.extension.entity;


import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

/**
 *<p>
 * 工作流流程条件
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/2
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_workflow_condition")
public class WorkflowCondition implements Serializable {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 变量名 */
	private String field;

	/** 比较类型 */
	private String compare;

	/** 比较值 */
	private String value;

	/** 运算类型 */
	private String logic;

	/** 排序 */
	private Integer sort;

	/** 任务扩展数据id */
	private Integer activityExtensionDataId;

}
