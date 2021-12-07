package com.entfrm.data.util;

import com.entfrm.base.util.StrUtil;
import com.entfrm.data.enums.DataTypeEnum;
import lombok.experimental.UtilityClass;

/**
 * @author yong
 * @date 2020/3/24
 * @description 别名 工具类
 */
@UtilityClass
public class AliasUtil {

    //生成别名
    public String genAlias(String driverClassName, String dsName, int id) {
        if (DataTypeEnum.MYSQL.getDriverClassName().equals(driverClassName)) {
            return DataTypeEnum.MYSQL.getType() + "_" + dsName + "_" + id;
        } else if (DataTypeEnum.SQLSERVER.getDriverClassName().equals(driverClassName)) {
            return DataTypeEnum.SQLSERVER.getType() + "_" + dsName + "_" + id;
        } else if (DataTypeEnum.ORACLE.getDriverClassName().equals(driverClassName)) {
            return DataTypeEnum.ORACLE.getType() + "_" + dsName + "_" + id;
        } else if (DataTypeEnum.POSTGRESQL.getDriverClassName().equals(driverClassName)) {
            return DataTypeEnum.POSTGRESQL.getType() + "_" + dsName + "_" + id;
        } else if (DataTypeEnum.SQLITE.getDriverClassName().equals(driverClassName)) {
            return DataTypeEnum.SQLITE.getType() + "_" + dsName + "_" + id;
        } else {
            return dsName;
        }
    }

    //获取数据库类型
    public String getDsType(String aliass) {
        return aliass.substring(0, aliass.indexOf("_"));
    }

    //获取数据库名
    public String getDsName(String aliass) {
        return aliass.substring(aliass.indexOf("_") + 1, aliass.lastIndexOf("_"));
    }

    //获取数据库id
    public int getDsId(String aliass) {
        String dsId = aliass.substring(aliass.lastIndexOf("_") + 1, aliass.length());
        if(StrUtil.isNotBlank(dsId)){
            return Integer.parseInt(dsId);
        }
        return 1;
    }
}
