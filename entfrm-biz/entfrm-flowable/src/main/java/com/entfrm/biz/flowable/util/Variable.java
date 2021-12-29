/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.entfrm.biz.flowable.util;

import cn.hutool.core.convert.ConverterRegistry;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.entfrm.biz.flowable.enums.PropertyType;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Map;

/**
 *<p>
 *  流程变量工具对象
 *  提供两种方式来存储流程变量
 *  1.逗号分割符
 *  2.map对象
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
public class Variable {

	private Map<String, Object> map = MapUtil.newHashMap();

	private String keys;
	private String values;
	private String types;

	public Variable(){

	}

	public Variable(Map<String, Object> map){
		this.map = map;
	}

	public String getKeys() {
		return keys;
	}

	public void setKeys(String keys) {
		this.keys = keys;
	}

	public String getValues() {
		return values;
	}

	public void setValues(String values) {
		this.values = values;
	}

	public String getTypes() {
		return types;
	}

	public void setTypes(String types) {
		this.types = types;
	}

	/** 解析逗号分割符流程变量 */
	@JsonIgnore
	public Map<String, Object> getVariableMap() {

		//注册转换器
		ConverterRegistry converterRegistry = ConverterRegistry.getInstance();
		converterRegistry.putCustom(java.util.Date.class,new DateConverter());
		if (StrUtil.isBlank(keys)) {
			return map;
		}
		String[] arrayKey = keys.split(",");
		String[] arrayValue = values.split(",");
		String[] arrayType = types.split(",");
		for (int i = 0; i < arrayKey.length; i++) {
			String key = arrayKey[i];
			String value = arrayValue[i];
			String type = arrayType[i];
			//进行转换
			Class<?> targetType = Enum.valueOf(PropertyType.class, type).getValue();
			Object objectValue = converterRegistry.convert(targetType,value);
			map.put(key, objectValue);
		}
		return map;
	}

	public Map<String, Object> getMap() {
		return map;
	}

}
