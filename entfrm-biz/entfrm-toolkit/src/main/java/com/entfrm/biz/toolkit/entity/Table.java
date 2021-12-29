package com.entfrm.biz.toolkit.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.List;
import java.util.Map;

/**
 * @author entfrm
 * @date 2019/8/9
 * @description 业务表信息
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dev_table")
public class Table extends CommonEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableId
    private Integer id;

    /**
     * 表名称
     */
    private String tableName;

    /**
     * 表描述
     */
    private String tableComment;

    /**
     * 实体类名称(首字母大写)
     */
    private String className;

    /**
     * 使用的模板（crud单表操作 tree树表操作）
     */
    private String tplCategory;

    /**
     * 生成包路径
     */
    private String packageName;

    /**
     * 生成模块名
     */
    private String moduleName;

    /**
     * 生成业务名
     */
    private String businessName;

    /**
     * 生成功能名
     */
    private String functionName;

    /**
     * 生成作者
     */
    private String functionAuthor;

    /**
     * 主键信息
     */
    @TableField(exist = false)
    private Column pkColumn;

    /**
     * 其它生成选项
     */
    private String options;

    /**
     * 分栏
     */
    private String cols;

    /**
     * 生成API
     */
    private String genApi;

    /**
     * 生成方式
     */
    private String genWay;

    /**
     * 父级菜单编号
     */
    private Integer menuId;

    /**
     * 生成路径
     */
    private String genPath;

    /** 关联子表的表名 */
    private String subTableName;

    /** 关联子表的外键名 */
    private String subTableField;

    /** 子表信息 */
    @TableField(exist = false)
    private Table subTable;

    /**
     * 树编码字段
     */
    @TableField(exist = false)
    private String treeId;

    /**
     * 树父编码字段
     */
    @TableField(exist = false)
    private String treeParentId;

    /**
     * 树名称字段
     */
    @TableField(exist = false)
    private String treeName;

    /**
     * 表信息
     */
    @TableField(exist = false)
    private List<Table> tables;
    /**
     * 表列信息
     */
    @TableField(exist = false)
    private List<Column> columns;

    /**
     * 其他参数
     */
    @TableField(exist = false)
    private Map<String, Object> params;

    /**
     * 删除表字段名
     */
    @TableField(exist = false)
    private String delNames;

    /**
     * 菜单信息
     */
    @TableField(exist = false)
    private List<Map<String, Object>> menus;
}
