/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.entfrm.biz.flowable.util;

import cn.hutool.core.convert.Converter;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import lombok.extern.slf4j.Slf4j;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *<p>
 *
 *  自定义日期转换
 *
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@Slf4j
public class DateConverter  implements Converter<Object> {


	private static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

	private static final String DATETIME_PATTERN_NO_SECOND = "yyyy-MM-dd HH:mm";

	private static final String DATE_PATTERN = "yyyy-MM-dd";

	private static final String MONTH_PATTERN = "yyyy-MM";

	@Override
	public Object convert(Object type, Object value) throws IllegalArgumentException {
		Object result = null;
		if (type == Date.class) {
			try {
				result = doConvertToDate(value);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else if (type == String.class) {
			result = doConvertToString(value);
		}
		return result;
	}

	/** Convert String to Date **/
	private Date doConvertToDate(Object value) throws ParseException {
		Date result = null;
		if (value instanceof String) {
			result = DateUtil.parse((String) value,
					new String[] { DATE_PATTERN, DATETIME_PATTERN, DATETIME_PATTERN_NO_SECOND, MONTH_PATTERN });
			//所有格式类型转换都不对,直接使用Date构造转换
			if (result == null && StrUtil.isNotEmpty((String) value)) {
				try {
					result = new Date(new Long((String) value).longValue());
				} catch (Exception e) {
					log.error("Converting from milliseconds to Date fails!");
					e.printStackTrace();
				}
			}
		} else if (value instanceof Object[]) {
			// 解析数组日期字符串进行转换
			Object[] array = (Object[]) value;
			if (array.length >= 1) {
				value = array[0];
				result = doConvertToDate(value);
			}
		} else if (Date.class.isAssignableFrom(value.getClass())) {
			result = (Date) value;
		}
		return result;
	}

	/** Convert Date to String **/
	private String doConvertToString(Object value) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATETIME_PATTERN);
		String result = null;
		if (value instanceof Date) {
			result = simpleDateFormat.format(value);
		}
		return result;
	}

}
