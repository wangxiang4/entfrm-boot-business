package com.entfrm.biz.extension.entity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.ArrayList;
import java.util.List;

/**
 *<p>
 * 任务扩展数据
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/2
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_task_data")
public class TaskExtensionData extends CommonEntity {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 流程定义id */
	private String processDefId;

	/** 任务定义id */
	private String taskDefId;

	/** 存储任务扩展数据 */
	@TableField(exist = false)
	private List<WorkflowAssignee> workflowAssigneeList = new ArrayList();
	@TableField(exist = false)
	private List<WorkflowButton> workflowButtonList = new ArrayList();
	@TableField(exist = false)
	private List<WorkflowCondition> workflowConditionList = new ArrayList();

}
