package com.entfrm.biz.toolkit.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.base.annotation.Excel;
import com.entfrm.data.entity.CommonEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author entfrm
 * @date 2021-03-11 21:57:03
 *
 * @description 表单管理对象 Form
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dev_form")
public class Form extends CommonEntity {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    @TableId
    private Integer id;

    /** 表单名称 */
    @Excel(name = "表单名称")
    private String name;

    /** 表单编码 */
    @Excel(name = "表单编码")
    private String code;

    /** 表单类型 */
    @Excel(name = "表单类型")
    private String type;

    /** 数据库连接 */
    private String dsAlias;

    /** 表名 */
    @Excel(name = "表名")
    private String tableName;

    /** 表单数据 */
    @Excel(name = "表单数据")
    private String data;

    /** 是否自动建表 */
    @Excel(name = "是否自动建表")
    private String autoCreate;

    /** 版本号 */
    @Excel(name = "版本号")
    private String version;

    /** 状态 */
    private String status;
}
