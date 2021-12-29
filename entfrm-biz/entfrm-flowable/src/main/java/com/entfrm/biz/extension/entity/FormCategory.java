package com.entfrm.biz.extension.entity;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.TreeEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 *<p>
 * 表单定义分类管理
 * 开发经验: 树形结构功能一般不做分页处理,会破坏分页结构导致树形结构不完整
 * 要么采用数据库查询第一级数据分页,然后在根据第一级去匹配所有子级,但是数据库需要做递归sql操作比较消耗性能而且太过于复杂不好维护
 * 目前暂时没有一个比较好的处理树形结构分页的方案,后期数据量大可以打算实现数据库递归sql操作,但是目前数据量小没必要
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
@TableName(value = "act_extension_form_category")
public class FormCategory extends TreeEntity<FormCategory> {

	/** 反序列化密钥 */
	private static final long serialVersionUID = 1L;

	@TableId
	private Integer id;

}
