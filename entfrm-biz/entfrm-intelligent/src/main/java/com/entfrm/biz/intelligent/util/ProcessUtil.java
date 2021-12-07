package com.entfrm.biz.intelligent.util;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.json.JSONUtil;
import lombok.experimental.UtilityClass;

import java.util.Map;

/**
 * <p>
 * 处理一些逻辑工具类
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/22
 */
@UtilityClass
public class ProcessUtil {

    /**
     * 手动转换#{}做的事情 
     * 动态获取参数-sql注入框架内置xss拦截
     *@Param [origin, key]
     @return java.lang.Object
     */
    public String insertSiphonValue(Map<String,Object> origin, String key){
        if(ObjectUtil.isEmpty(origin.get(key))){
            return "null";
        }
        switch(origin.get(key).getClass().getSimpleName()){
            case "String"  :
                return String.join("","'",origin.get(key).toString(),"'");
            case "ArrayList"  :
                return String.join("",key,"=","'",JSONUtil.toJsonStr(origin.get(key)),"'");
            default :
                return origin.get(key).toString();
        }
    }


    /**
     * 手动转换#{}做的事情
     * 动态获取参数-sql注入框架内置xss拦截
     *@Param [origin, key]
     @return java.lang.Object
     */
    public String updateSiphonValue(Map<String,Object> origin, String key){
        if(ObjectUtil.isEmpty(origin.get(key))){
            return "";
        }
        switch(origin.get(key).getClass().getSimpleName()){
            case "String"  :
                return String.join("",key,"=","'",origin.get(key).toString(),"'");
            case "ArrayList"  :
                return String.join("",key,"=","'",JSONUtil.toJsonStr(origin.get(key)),"'");
            default :
                return String.join("",key,"=",origin.get(key).toString());
        }
    }


    /** 
     * 设置目前所用到的数据类型
     *@Param [] JSON转换::创建控件表
     *@return java.lang.String
     */ 
    public DataBaseType fetchFieldType(Object value){
        switch(value.getClass().getSimpleName()){
            case "JSONArray":
                return DataBaseType.TEXT;
            case "Boolean":
                return DataBaseType.TINYINT;
            case "Integer":
                return DataBaseType.INT;
            default:
                return DataBaseType.VARCHAR;
        }
    }



}
