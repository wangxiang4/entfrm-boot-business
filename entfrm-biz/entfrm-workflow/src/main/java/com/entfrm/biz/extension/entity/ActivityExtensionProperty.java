package com.entfrm.biz.extension.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 活动扩展属性
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/2
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_activity_property")
public class ActivityExtensionProperty extends CommonEntity {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

	/** 流程定义id */
	private String processDefId;

	/** 活动定义id */
	private String activityDefId;

	/** 变量名 */
	private String key;

	/** 变量值 */
	private String value;

}
