package com.entfrm.biz.intelligent.util;

/**
 * <p>
 * 自定义字段类型
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/27
 */
public enum CustomizeFieldType {


    CONFIG_LABEL_WIDTH("config_label_width",DataBaseType.INT),
    ATTRS_MAXLENGTH("attrs_maxlength",DataBaseType.INT);


    private String field;
    private DataBaseType dataBaseType;

    CustomizeFieldType(String field, DataBaseType dataBaseType) {
        this.field = field;
        this.dataBaseType = dataBaseType;
    }

    public String getField() {
        return field;
    }
    public DataBaseType getDataBaseType() {
        return dataBaseType;
    }

}
