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
 * @date 2020-04-24 22:18:00
 * @description 接口对象 Apiinfo
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dev_apiinfo")
public class Apiinfo extends CommonEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableId
    private Integer id;

    /**
     * 应用编号
     */
    @Excel(name = "应用编号")
    private Integer applicationId;

    /**
     * 表编号
     */
    private Integer tableId;

    /**
     * 表名称
     */
    @Excel(name = "表名称")
    private String tableName;

    /**
     * 名称
     */
    @Excel(name = "名称")
    private String name;

    /**
     * 自定义编号
     */
    private String code;

    /**
     * 父编号
     */
    private Integer parentId;

    /**
     * 接口类型
     */
    private String type;

    /**
     * 请求方式
     */
    @Excel(name = "请求方式")
    private String requestType;

    /**
     * 请求方法
     */
    @Excel(name = "请求方法")
    private String requestMethod;

    /**
     * 字段数据
     */
    private String fdata;

    /**
     * 字段数据
     */
    private String pdata;

    /**
     * 脚本
     */
    private String scripts;

    /**
     * 机构编号
     */
    private Integer deptId;

    /**
     * 状态（0-正常，1-停用）
     */
    @Excel(name = "状态", convertExp = "0-正常，1-停用")
    private String status;


}
