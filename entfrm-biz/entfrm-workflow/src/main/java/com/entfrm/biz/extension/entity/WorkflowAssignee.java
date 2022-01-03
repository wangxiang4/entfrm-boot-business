package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 工作流审核者
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/2
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_workflow_assignee")
public class WorkflowAssignee extends Condition{

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 用户类型 */
	private String type;

	/** 用户来自 */
	private String value;

	/** 附加条件 */
	private String condition;

	/** 运算类型 */
	private String operationType;

	/** 排序 */
	private Integer sort;

	/** 任务扩展数据id */
	private Integer TaskExtensionDataId;

}
