package com.entfrm.biz.intelligent.mapper;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 表单扩展设计器mapper操作
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
public interface FormExtendDesignMapper {

    /**
     * 构建动态sql新增[根据数据库的字段名数据构建修改字段]
     *@Param [TableFields, Table, TableValues]
     *@return int
     */
    int insertControlsMappingTable(@Param("TableFields") List<String> tableFields,
                                   @Param("Table") String table,
                                   @Param("TableValues") Map<String,Object> tableValues);


    /**
     * 构建动态sql修改[根据前端的数据的字段名构建修改字段]
     *@Param [TableFields, Table, TableValues]
     *@return int
     */
    int updateControlsMappingTable(@Param("TableFields") List<String> tableFields,
                                   @Param("Table") String table,
                                   @Param("TableValues") Map<String,Object> tableValues,
                                   @Param("FormExtendId") Long formExtendId,
                                   @Param("ConfigFormId") Long configFormId);

    /**
     * 构建动态sql删除[根据前端的数据的字段名构建修改字段]-单个控件
     *@Param [TableFields, Table, TableValues]
     *@return int
     */
    int deleteSingleControlsMappingTable(@Param("Table") String table,
                                   @Param("FormExtendId") Long formExtendId,
                                   @Param("ConfigFormId") Long configFormId);

    /**
     * 查当前表所有字段-控件数据映射表
     *@Param [Table]
     *@return java.util.List<java.lang.String>
     */
    List<String> selectTableFields(@Param("Table") String table);


    /**
     * 查当前表所有字段-业务数据映射表
     *@Param [Table]
     *@return java.util.List<java.lang.String>
     */
    List<String> selectBusinessTableFields(@Param("Table") String table);

    /**
     * 查当前表所有字段-业务数据映射表-全部字段
     *@Param [Table]
     *@return java.util.List<java.lang.String>
     */
    List<String> selectBusinessTableFieldsAll(@Param("Table") String table);


    /**
     * 查询所有控件映射表-field_current字段数据
     *@Param [Table]
     *@return java.util.List<java.lang.String>
     */
    List<String> selectAllControlsMappingTableFieldCurrent(@Param("TableName") String tableName,
                                                           @Param("FormExtendId") Long formExtendId);

    /**
     * 查询所有控件映射表数据
     *@Param [Table]
     *@return java.util.List<java.lang.String>
     */
    List<Map<String,Object>> selectAllControlsMappingTableData(@Param("TableName") String tableName,
                                                               @Param("FormExtendId") Long formExtendId);

    /**
     * 创建业务数据映射表
     *@Param [TableName, SqlCode]
     *@return int
     */
    int createTable(@Param("TableName") String tableName,
                    @Param("SqlCode") String sqlCode);


    /**
     * 动态查询控件映射数据表-全部控件
     *@Param [formExtendId, TableName]
     *@return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    List<Map<String,Object>> selectControlsMappingTable(@Param("TableName") String tableName,
                                                        @Param("FormExtendId") Long formExtendId);


    /**
     * 修改业务映射表字段类型
     *@Param [TableName, SqlCode]
     *@return int
     */
    int updateFieldType(@Param("TableName") String tableName,
                        @Param("SqlCode") String sqlCode);


    /**
     * 新增业务映射表字段类型
     *@Param [TableName, SqlCode]
     *@return int
     */
    int insertFieldType(@Param("TableName") String tableName,
                        @Param("SqlCode") String sqlCode);


    /**
     * 重新命名业务映射表名称
     *@Param [oldTableName, newTableName]
     *@return int
     */
    int reTableName(@Param("OldTableName") String oldTableName,
                    @Param("NewTableName") String newTableName);



    /**
     * 设置业务数据映射表字段为空{一般跟控件删除有关}
     *@Param [TableName, Field]
     *@return int
     */
    int settingsFieldNull(@Param("TableName") String tableName,@Param("Field") String field);



    /**
     * 动态查询控件映射数据表-单个控件
     *@Param [formExtendId, TableName]
     *@return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    List<Map<String,Object>> selectSingleControlsMappingTable(@Param("TableName") String tableName,
                                                        @Param("FormExtendId") Long formExtendId,
                                                        @Param("ConfigFormId") Long configFormId);



    /**
     * 删除业务数据映射表
     *@Param [tableName]
     *@return int
     */
    int deleteTable(@Param("TableName") String tableName);



    /**
     * 动态删除控件映射数据-全部控件
     *@Param [formExtendId, TableName]
     *@return java.util.List<java.util.Map<java.lang.String,java.lang.Object>>
     */
    int deleteControlsMappingTable(@Param("TableName") String tableName,
                                   @Param("FormExtendId") Long formExtendId);


    /**
     * 校验数据库中是否有Business数据映射表
     *@Param
     *@return
     */
    int validatorBusinessTable(@Param("TableName") String tableName);

}
