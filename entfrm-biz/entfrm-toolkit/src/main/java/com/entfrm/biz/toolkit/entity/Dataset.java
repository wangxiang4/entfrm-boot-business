package com.entfrm.biz.toolkit.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.base.annotation.Excel;
import com.entfrm.data.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * @author entfrm
 * @date 2020-06-12 21:56:29
 * @description 数据源对象 Dataset
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("dev_dataset")
public class Dataset extends BaseEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @Excel(name = "编号")
    @TableId
    private Integer id;

    /**
     * 名称
     */
    @Excel(name = "名称")
    private String name;

    /**
     * 格式类型
     */
    @Excel(name = "格式类型")
    private String ftype;

    /**
     * 是否分页
     */
    private String isPage;

    /**
     * 配置数据
     */
    private String cdata;

    /**
     * sql脚本
     */
    @Excel(name = "sql脚本")
    private String scripts;

    /**
     * 数据源别名
     */
    @Excel(name = "数据源别名")
    private String alias;

    /**
     * 编码
     */
    private String code;


}
