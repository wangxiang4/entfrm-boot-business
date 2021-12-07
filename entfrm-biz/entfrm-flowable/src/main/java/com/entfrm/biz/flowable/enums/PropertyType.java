/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.entfrm.biz.flowable.enums;

import java.util.Date;

/**
 *<p>
 * 属性数据类型
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
public enum PropertyType {

	S(String.class),
	I(Integer.class),
	L(Long.class),
	F(Float.class),
	N(Double.class),
	D(Date.class),
	SD(java.sql.Date.class),
	B(Boolean.class);

	private Class<?> clazz;

	PropertyType(Class<?> clazz) {
		this.clazz = clazz;
	}

	public Class<?> getValue() {
		return clazz;
	}
}
