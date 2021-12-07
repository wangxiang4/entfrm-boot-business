package com.entfrm.biz.toolkit.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.toolkit.entity.Table;

import java.util.Map;

/**
 * 业务 服务层
 */
public interface TableService extends IService<Table> {

    /**
     * 生成表、列数据
     *
     * @param tableName  表名
     */
    public Table getGenTable(String tableName, String tableComment);

    /**
     * 修改保存参数校验
     *
     * @param table 业务信息
     */
    public void validateEdit(Table table);

    /**
     * 修改业务
     *
     * @param table 业务信息
     * @return 结果
     */
    public void updateTable(Table table);

    /**
     * 删除业务信息
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    public void deleteTableByIds(String ids);


    /**
     * 预览代码
     *
     * @param tableName 表名
     * @return 预览数据列表
     */
    public Map<String, String> previewCode(String tableName);

    /**
     * 批量生成代码到本地
     *
     * @param tableNames 表数组
     * @return 数据
     */
    public String genToLocal(String[] tableNames);

    /**
     * 批量生成代码
     *
     * @param tableNames 表数组
     * @return 数据
     */
    public byte[] genCode(String[] tableNames);


}
