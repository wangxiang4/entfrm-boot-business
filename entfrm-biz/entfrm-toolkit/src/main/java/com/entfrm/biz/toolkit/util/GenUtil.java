package com.entfrm.biz.toolkit.util;

import cn.hutool.core.util.StrUtil;
import com.entfrm.biz.toolkit.config.GenConfig;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Table;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 代码生成器 工具类
 */
public class GenUtil {
    /**
     * 初始化表信息
     */
    public static void initTable(Table table, String operName) {
        if("true".equals(GenConfig.getAutoRemovePre()) && StrUtil.isNotBlank(GenConfig.getTablePrefix())){
            table.setClassName(StrUtil.upperFirst(StrUtil.toCamelCase(StrUtil.replace(table.getTableName(), GenConfig.getTablePrefix(), ""))));
        }else {
            table.setClassName(StrUtil.upperFirst(StrUtil.toCamelCase(table.getTableName())));
        }
        table.setPackageName(GenConfig.getPackageName());
        table.setModuleName(getModuleName(GenConfig.getPackageName()));
        table.setBusinessName(StrUtil.lowerFirst(table.getClassName()));
        table.setFunctionName(replaceText(table.getTableComment()));
        table.setFunctionAuthor(GenConfig.getAuthor());
        table.setCreateBy(operName);
    }

    /**
     * 初始化列属性字段
     */
    public static void initColumnField(Column column, Table table) {

    }

    /**
     * 校验数组是否包含指定值
     *
     * @param arr         数组
     * @param targetValue 值
     * @return 是否包含
     */
    public static boolean arraysContains(String[] arr, String targetValue) {
        return Arrays.asList(arr).contains(targetValue);
    }

    /**
     * 获取模块名
     *
     * @param packageName 包名
     * @return 模块名
     */
    public static String getModuleName(String packageName) {
        int lastIndex = packageName.lastIndexOf(".");
        int nameLength = packageName.length();
        String moduleName = StrUtil.sub(packageName, lastIndex + 1, nameLength);
        return moduleName;
    }

    /**
     * 关键字替换
     *
     * @param text 需要被替换的名字
     * @return 替换后的名字
     */
    public static String replaceText(String text) {
        return text.replaceAll("(?:表|tm)", "");
    }

    /**
     * 获取数据库类型字段
     *
     * @param columnType 列类型
     * @return 截取后的列类型
     */
    public static String getDbType(String columnType) {
        if (StrUtil.indexOf(columnType, '(') > 0) {
            return StrUtil.subBefore(columnType, "(", false);
        } else {
            return columnType;
        }
    }

    /**
     * 获取字段长度
     *
     * @param columnType 列类型
     * @return 截取后的列类型
     */
    public static Integer getColumnLength(String columnType) {
        if (StrUtil.indexOf(columnType, '(') > 0) {
            String length = StrUtil.subBetween(columnType, "(", ")");
            return Integer.valueOf(length);
        } else {
            return 0;
        }
    }

    public static List<Column> initColumns(){
        List<Column> list = new ArrayList<>();
        Column column1 = new Column();
        column1.setColumnName("id");
        column1.setColumnComment("编号");
        column1.setColumnType("int(11)");
        column1.setJavaType("Integer");
        column1.setJavaField("id");
        column1.setIsPk("1");
        column1.setIsIncrement("1");
        column1.setIsList("1");
        column1.setQueryType("eq");
        column1.setHtmlType("input");
        column1.setId(1);
        list.add(column1);
        Column column2 = new Column();
        column2.setColumnName("create_by");
        column2.setColumnComment("创建人");
        column2.setColumnType("varchar(60)");
        column2.setJavaType("String");
        column2.setJavaField("createBy");
        column2.setQueryType("eq");
        column2.setHtmlType("input");
        column2.setId(2);
        list.add(column2);
        Column column3 = new Column();
        column3.setColumnName("create_time");
        column3.setColumnComment("创建时间");
        column3.setColumnType("datetime");
        column3.setJavaType("Date");
        column3.setJavaField("createTime");
        column3.setIsQuery("1");
        column3.setIsList("1");
        column3.setQueryType("between");
        column3.setHtmlType("datetime");
        column3.setId(3);
        list.add(column3);
        Column column4 = new Column();
        column4.setColumnName("update_by");
        column4.setColumnComment("更新人");
        column4.setColumnType("varchar(60)");
        column4.setJavaType("String");
        column4.setJavaField("updateBy");
        column4.setQueryType("eq");
        column4.setHtmlType("input");
        column4.setId(4);
        list.add(column4);
        Column column5 = new Column();
        column5.setColumnName("update_time");
        column5.setColumnComment("更新时间");
        column5.setColumnType("datetime");
        column5.setJavaType("Date");
        column5.setJavaField("updateTime");
        column5.setQueryType("between");
        column5.setHtmlType("datetime");
        column5.setId(5);
        list.add(column5);
        Column column6 = new Column();
        column6.setColumnName("remarks");
        column6.setColumnComment("备注");
        column6.setColumnType("varchar(255)");
        column6.setJavaType("String");
        column6.setJavaField("remarks");
        column6.setIsAdd("1");
        column6.setIsEdit("1");
        column6.setQueryType("eq");
        column6.setHtmlType("textarea");
        column6.setId(6);
        list.add(column6);
        Column column7 = new Column();
        column7.setColumnName("del_flag");
        column7.setColumnComment("删除标识（0-正常，1-删除）");
        column7.setColumnType("char(1)");
        column7.setJavaType("String");
        column7.setJavaField("delFlag");
        column7.setDefValue("0");
        column7.setQueryType("eq");
        column7.setHtmlType("input");
        column7.setId(7);
        list.add(column7);
        return list;
    }
}
