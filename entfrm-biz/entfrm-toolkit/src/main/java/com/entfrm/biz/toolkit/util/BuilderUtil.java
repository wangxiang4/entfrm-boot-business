package com.entfrm.biz.toolkit.util;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.base.constant.GenConstants;
import com.entfrm.base.util.StrUtil;
import com.entfrm.biz.toolkit.entity.Column;
import com.entfrm.biz.toolkit.entity.Form;
import com.entfrm.biz.toolkit.entity.Table;

import java.util.ArrayList;
import java.util.List;

/**
 * @author entfrm
 * @date 2020/4/11
 * @description sql 脚本构成器
 */
public class BuilderUtil {

    public static Table createForm(Form form) {
        Table table = new Table();
        table.setTableName(CommonConstants.PREFIX + form.getTableName());
        table.setTableComment(form.getName());
        table.setClassName(StrUtil.upperFirst(form.getTableName()));
        table.setTplCategory("crud");
        table.setPackageName("com.entfrm.biz.form");
        table.setModuleName(form.getTableName());
        table.setBusinessName(form.getTableName());
        table.setFunctionName(form.getTableName());
        table.setFunctionAuthor("entfrm");
        table.setCols("12");
        table.setGenApi("0");
        table.setGenWay("0");
        table.setOptions("{}");
        table.setColumns(createColumns(form.getData()));
        return table;
    }

    public static List<Column> createColumns(String data) {
        JSONObject jsonObject = JSONUtil.parseObj(data);
        JSONArray jsonArray = jsonObject.getJSONArray("column");
        List<Column> columnList = new ArrayList<>();
        if(jsonArray != null && jsonArray.size() > 0){
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
            columnList.add(column1);

            for (int i = 0; i < jsonArray.size(); i++) {
                JSONObject jsonObject1 = jsonArray.getJSONObject(i);
                switch (jsonObject1.getStr("type")){
                    case "input":
                        Column c = new Column();
                        c.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c.setColumnComment(jsonObject1.getStr("label"));
                        c.setColumnType("varchar(60)");
                        c.setJavaType("String");
                        c.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        if (StrUtil.endWithIgnoreCase(jsonObject1.getStr("prop"), "name")) {
                            c.setQueryType(GenConstants.QUERY_LIKE);
                            c.setIsQuery("1");
                        }else {
                            c.setQueryType("eq");
                        }
                        c.setIsAdd("1");
                        c.setIsEdit("1");
                        c.setIsList("1");
                        c.setHtmlType("input");
                        columnList.add(c);
                        break;
                    case "password":
                        Column c1 = new Column();
                        c1.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c1.setColumnComment(jsonObject1.getStr("label"));
                        c1.setColumnType("varchar(30)");
                        c1.setJavaType("String");
                        c1.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c1.setIsAdd("1");
                        c1.setQueryType("eq");
                        c1.setHtmlType("input");
                        columnList.add(c1);
                        break;
                    case "textarea":
                        Column c2 = new Column();
                        c2.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c2.setColumnComment(jsonObject1.getStr("label"));
                        c2.setColumnType("varchar(255)");
                        c2.setJavaType("String");
                        c2.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c2.setIsAdd("1");
                        c2.setIsEdit("1");
                        c2.setQueryType("eq");
                        c2.setHtmlType("textarea");
                        columnList.add(c2);
                        break;
                    case "number":
                        Column c3 = new Column();
                        c3.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c3.setColumnComment(jsonObject1.getStr("label"));
                        c3.setColumnType("int(11)");
                        c3.setJavaType("Integer");
                        c3.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c3.setIsAdd("1");
                        c3.setIsEdit("1");
                        c3.setIsList("1");
                        c3.setQueryType("eq");
                        c3.setHtmlType("input");
                        columnList.add(c3);
                        break;
                    case "radio":
                        Column c4 = new Column();
                        c4.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c4.setColumnComment(jsonObject1.getStr("label"));
                        c4.setColumnType("varchar(30)");
                        c4.setJavaType("String");
                        c4.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c4.setIsAdd("1");
                        c4.setIsEdit("1");
                        c4.setIsList("1");
                        c4.setQueryType("eq");
                        c4.setHtmlType("radio");
                        columnList.add(c4);
                        break;
                    case "checkbox":
                        Column c5 = new Column();
                        c5.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c5.setColumnComment(jsonObject1.getStr("label"));
                        c5.setColumnType("varchar(30)");
                        c5.setJavaType("String");
                        c5.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c5.setIsAdd("1");
                        c5.setIsEdit("1");
                        c5.setIsList("1");
                        c5.setQueryType("eq");
                        c5.setHtmlType("checkbox");
                        columnList.add(c5);
                        break;
                    case "select":
                        Column c6 = new Column();
                        c6.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c6.setColumnComment(jsonObject1.getStr("label"));
                        c6.setColumnType("varchar(60)");
                        c6.setJavaType("String");
                        c6.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c6.setIsAdd("1");
                        c6.setIsEdit("1");
                        c6.setIsList("1");
                        c6.setQueryType("eq");
                        c6.setHtmlType("select");
                        columnList.add(c6);
                        break;
                    case "upload":
                        Column c7 = new Column();
                        c7.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c7.setColumnComment(jsonObject1.getStr("label"));
                        c7.setColumnType("varchar(120)");
                        c7.setJavaType("String");
                        c7.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c7.setIsAdd("1");
                        c7.setIsEdit("1");
                        c7.setQueryType("eq");
                        c7.setHtmlType("upload");
                        columnList.add(c7);
                        break;
                    case "datetime":
                        Column c8 = new Column();
                        c8.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c8.setColumnComment(jsonObject1.getStr("label"));
                        c8.setColumnType("datetime(0)");
                        c8.setJavaType("Date");
                        c8.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c8.setIsAdd("1");
                        c8.setIsEdit("1");
                        c8.setIsList("1");
                        c8.setQueryType("eq");
                        c8.setHtmlType("datetime");
                        columnList.add(c8);
                        break;
                    case "date":
                        Column c9 = new Column();
                        c9.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c9.setColumnComment(jsonObject1.getStr("label"));
                        c9.setColumnType("datetime(0)");
                        c9.setJavaType("Date");
                        c9.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c9.setIsAdd("1");
                        c9.setIsEdit("1");
                        c9.setIsList("1");
                        c9.setQueryType("eq");
                        c9.setHtmlType("datetime");
                        columnList.add(c9);
                        break;
                    case "time":
                        Column c10 = new Column();
                        c10.setColumnName(StrUtil.toUnderlineCase(jsonObject1.getStr("prop")));
                        c10.setColumnComment(jsonObject1.getStr("label"));
                        c10.setColumnType("varchar(10)");
                        c10.setJavaType("String");
                        c10.setJavaField(StrUtil.toCamelCase(jsonObject1.getStr("prop")));
                        c10.setIsAdd("1");
                        c10.setIsEdit("1");
                        c10.setIsList("1");
                        c10.setQueryType("eq");
                        c10.setHtmlType("input");
                        columnList.add(c10);
                        break;
                }
            }

            Column column2 = new Column();
            column2.setColumnName("create_by");
            column2.setColumnComment("创建人");
            column2.setColumnType("varchar(60)");
            column2.setJavaType("String");
            column2.setJavaField("createBy");
            column2.setQueryType("eq");
            column2.setHtmlType("input");
            columnList.add(column2);
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
            columnList.add(column3);
            Column column4 = new Column();
            column4.setColumnName("update_by");
            column4.setColumnComment("更新人");
            column4.setColumnType("varchar(60)");
            column4.setJavaType("String");
            column4.setJavaField("updateBy");
            column4.setQueryType("eq");
            column4.setHtmlType("input");
            columnList.add(column4);
            Column column5 = new Column();
            column5.setColumnName("update_time");
            column5.setColumnComment("更新时间");
            column5.setColumnType("datetime");
            column5.setJavaType("Date");
            column5.setJavaField("updateTime");
            column5.setQueryType("between");
            column5.setHtmlType("datetime");
            columnList.add(column5);
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
            columnList.add(column6);
            Column column7 = new Column();
            column7.setColumnName("del_flag");
            column7.setColumnComment("删除标识（0-正常，1-删除）");
            column7.setColumnType("char(1)");
            column7.setJavaType("String");
            column7.setJavaField("delFlag");
            column7.setDefValue("0");
            column7.setQueryType("eq");
            column7.setHtmlType("input");
            columnList.add(column7);

        }
        return columnList;
    }


    //创建表
    public static String createTable(Table table) {
        StringBuilder sb = new StringBuilder();
        sb.append("CREATE TABLE `" + table.getTableName() + "`  (");
        if (table.getColumns() != null && table.getColumns().size() > 0) {
            for (int i = 0; i < table.getColumns().size(); i++) {
                Column column = table.getColumns().get(i);
                if (i == table.getColumns().size() - 1) {
                    sb.append(fieldCreateScript(column));
                } else {
                    sb.append(fieldCreateScript(column) + ",");
                }
            }
        }
        sb.append(")ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci" + (StrUtil.isNotEmpty(table.getTableComment()) ? " COMMENT '" + table.getTableComment() + "' " : " ") + "ROW_FORMAT = Dynamic;");
        return sb.toString();
    }

    //字段信息转sql脚本(创建)
    private static String fieldCreateScript(Column column) {
        String script = column.getColumnName() + " " + column.getColumnType() + " " + ((("1").equals(column.getIsRequired()) || "1".equals(column.getIsPk())) ? "NOT NULL" : "NULL");
        script += (StrUtil.isNotEmpty(column.getColumnComment()) ? " COMMENT '" + column.getColumnComment() + "'" : " ");
        script += (StrUtil.isNotEmpty(column.getDefValue()) ? " DEFAULT " + column.getDefValue() : " ");
        if ("id".equalsIgnoreCase(column.getColumnName()) && "1".equals(column.getIsPk())) {
            script += " primary key AUTO_INCREMENT";
        }
        return script;
    }

    //更新表
    public static String updateTable(Table table) {
        StringBuilder sb = new StringBuilder();
        if (StrUtil.isNotEmpty(table.getTableName())) {
            sb.append("alter table " + table.getTableName() + " comment '" + table.getTableComment() + "';");
        }
        if (table.getColumns() != null && table.getColumns().size() > 0) {
            for (Column column : table.getColumns()) {
                if (StrUtil.isBlankIfStr(column.getId())) {
                    sb.append("alter table " + table.getTableName() + " add " + column.getColumnName() + " " + column.getColumnType()
                            + (StrUtil.isNotEmpty(column.getDefValue()) ? " default '" + column.getDefValue() + "' " : " ") + (("1").equals(column.getIsRequired()) ? "NOT NULL " : "NULL ") + (StrUtil.isNotEmpty(column.getColumnComment()) ? "comment '" + column.getColumnComment() + "';" : ";"));
                } else {
                    if ("id".equalsIgnoreCase(column.getColumnName()) && "1".equals(column.getIsPk())) {
                        sb.append("alter table " + table.getTableName() + " modify " + column.getColumnName() + " " + column.getColumnType()
                                + (StrUtil.isNotEmpty(column.getDefValue()) ? " default '" + column.getDefValue() + "' " : " ") + (StrUtil.isNotEmpty(column.getColumnComment()) ? "comment '" + column.getColumnComment() + "' auto_increment;" : " auto_increment;"));
                    } else {
                        sb.append("alter table " + table.getTableName() + " modify " + column.getColumnName() + " " + column.getColumnType()
                                + (StrUtil.isNotEmpty(column.getDefValue()) ? " default '" + column.getDefValue() + "' " : " ") + (("1").equals(column.getIsRequired()) ? "NOT NULL " : "NULL ") + (StrUtil.isNotEmpty(column.getColumnComment()) ? "comment '" + column.getColumnComment() + "';" : ";"));
                    }
                }
            }
        }
        return sb.toString();
    }

    //根据sql脚本获得表名
    public static String getTableName(String scripts) {
        String tableName = "";
        if (scripts.indexOf("from") != -1) {
            tableName = scripts.substring(scripts.indexOf("from") + 4);

            if (tableName.indexOf("where") != -1) {
                tableName = tableName.substring(0, tableName.indexOf("where"));
            }

            tableName = tableName.replace(" ", "");
        }
        return tableName;
    }

}
