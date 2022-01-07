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
 * 工作流按钮
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/2
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_workflow_button")
public class WorkflowButton implements Serializable {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 按钮名称 */
	private String name;

	/** 编码 */
	private String code;

	/** 是否隐藏 */
	private String isHide;

	/** 下一节点审核人 */
	private String next;

	/** 排序 */
	private Integer sort;

	/** 任务扩展数据id */
	private Integer activityExtensionDataId;

}
