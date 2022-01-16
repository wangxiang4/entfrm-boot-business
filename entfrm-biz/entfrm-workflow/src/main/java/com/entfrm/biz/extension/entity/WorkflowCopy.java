package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 流程抄送
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName(value = "act_extension_cc", excludeProperty = { "remarks", "delFlag", "updateTime", "updateBy" })
public class WorkflowCopy extends CommonEntity {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 抄送用户id */
	private Integer userId;

	/** 流程定义id */
	private String processDefId;

	/** 流程实例id */
	private String processInsId;

	/** 流程标题 */
	private String processDefName;

	/** 实例标题 */
	private String processInsName;

	/** 流程节点名称 */
	private String taskName;

}
