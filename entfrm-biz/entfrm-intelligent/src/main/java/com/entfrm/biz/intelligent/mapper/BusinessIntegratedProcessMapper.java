package com.entfrm.biz.intelligent.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 业务数据集成处理Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
public interface BusinessIntegratedProcessMapper {


    /**
     * 新增业务数据
     *@Param []
     *@return int
     */
    int businessInsert(@Param("TableName") String tableName,
                       @Param("BusinessTableAllField") List<String> BusinessTableAllField,
                       @Param("BusinessInsertData")Map<String,Object> BusinessInsertData);


    /**
     * 修改业务数据
     *@Param []
     *@return int
     */
    int businessUpdate(@Param("TableName") String tableName,
                       @Param("BusinessTableAllField") List<String> BusinessTableAllField,
                       @Param("BusinessUpdateData")Map<String,Object> BusinessUpdateData,
                       @Param("BusinessId")String businessId,
                       @Param("Version") Float version);

    /**
     * 删除业务数据
     *@Param []
     *@return int
     */
    int businessDelete(@Param("TableName") String tableName,
                       @Param("BusinessIds")String[] businessIds,
                       @Param("Version") Float version);


    /**
     * 查询业务数据
     *@Param [tableName, businessIds, version]
     *@return java.util.Map<java.lang.String,java.lang.Object>
     */
    Map<String,Object> businessSelect(@Param("TableName") String tableName,
                                       @Param("BusinessId")String businessId,
                                       @Param("Version") Float version);

}
