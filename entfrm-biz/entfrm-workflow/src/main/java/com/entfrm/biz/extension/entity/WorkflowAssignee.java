package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;

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
public class WorkflowAssignee implements Serializable {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 用户类型 */
	private String type;

	/** 用户来自 */
	private String value;

	/** 附加条件 */
	@TableField("`condition`")
	private String condition;

	/** 运算类型 */
	private String operationType;

	/** 排序 */
	private Integer sort;

	/** 活动扩展数据id */
	private Integer activityExtensionDataId;

}
