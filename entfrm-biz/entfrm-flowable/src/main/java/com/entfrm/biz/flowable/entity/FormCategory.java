package com.entfrm.biz.flowable.entity;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 表单定义分类管理
 * 功能为树形结构功能,不推荐使用层级码做处理,原因:维护太过于复杂,需要管理一套层级码的操作
 * 后期维护推荐:后端处理简单的操作不到万不得已不要用递归,增加服务器的压力,推荐把递归等复杂逻辑放到客户端做
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/3
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_extension_form_category")
public class FormCategory extends BaseEntity {

	/** id **/
	@TableId
	private Integer id;
	/** 父级编号 **/
	private Integer parentId;
	/** 名称 **/
	private String name;
	/** 排序 **/
	private Integer sort;

}
