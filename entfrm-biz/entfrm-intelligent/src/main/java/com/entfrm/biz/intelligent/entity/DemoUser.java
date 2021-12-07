package com.entfrm.biz.intelligent.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户表单集成简单例子
 * </p>
 * @Author: wx
 * @Date 2021/03/26 
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("intelligent_demo_user")
public class DemoUser {

	private static final long serialVersionUID =  8538670307791577203L;

	@TableId
	private Long id;

	private String nickName;

	private Long phone;

	private String remarks;

}
