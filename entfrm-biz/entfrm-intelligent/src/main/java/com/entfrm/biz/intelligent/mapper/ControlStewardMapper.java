package com.entfrm.biz.intelligent.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.entfrm.biz.intelligent.entity.ControlSteward;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 控件表映射关联管理Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
public interface ControlStewardMapper extends BaseMapper<ControlSteward> {


    /**
     * 创建表
     *@Param [TableName, map]
     *@return int
     */
    int createControlsTable(@Param("TableName") String TableName,
                            @Param("FieldList") List<String> FieldList);


    /**
     * 一次删除多张表
     *@Param [TableName]
     *@return int
     */
    int deleteControlsTable(@Param("Tables") List<String> Tables);

    /**
     * 查询控件表数据
     */
    int selectControlsTable(@Param("TableName") String tableName);


}
