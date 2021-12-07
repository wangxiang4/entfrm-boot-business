package com.entfrm.biz.intelligent.util;

/**
 * <p>
 * 字段类型
 * todo: 后续可自行添加
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/27
 */
public enum DataBaseType {

    VARCHAR(1,"varchar",255),
    TINYINT(2,"tinyint",1),
    TEXT(3,"text",0),
    INT(4,"int",11);


    /** key值 **/
    private Integer key;
    
    private String fieldType;

    private Integer fieldLength;

    DataBaseType(Integer key, String fieldType, Integer fieldLength) {
        this.key = key;
        this.fieldType = fieldType;
        this.fieldLength = fieldLength;
    }

    public Integer getKey() {
        return key;
    }

    public String getFieldType() {
        return fieldType;
    }

    public Integer getFieldLength() {
        return fieldLength;
    }

    /**根据属性值获取枚举对象**/
    public static DataBaseType getEnum(Integer key) {
        DataBaseType[] types;
        int typeLen = (types = values()).length;
        //先赋值,后运算
        for(int i = 0; i < typeLen; ++i) {
            DataBaseType dataBaseType = types[i];
            if (key.equals(dataBaseType.getKey())) {
                return dataBaseType;
            }
        }
        return null;
    }


}
