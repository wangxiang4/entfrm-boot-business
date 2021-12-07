package com.entfrm.biz.flowable.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.entfrm.base.annotation.Excel;
import com.entfrm.data.entity.BaseEntity;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.util.Date;


/**
 *<p>
 * 请假流程例子
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("act_leave")
public class Leave extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * ID
     */
    @TableId
    private Integer id;
    /**
     * 申请人
     */
    @Excel(name = "申请人")
    private String userName;
    /**
     * 类型
     */
    @Excel(name = "请假类型", convertExp = "0=事假,1=病假,2=产假")
    private String type;
    /**
     * 事由
     */
    @Excel(name = "请假事由")
    private String cause;
    /**
     * 请假时间
     */
    @Excel(name = "请假时间")
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date leaveTime;
    /**
     * 天数
     */
    @Excel(name = "天数")
    private Integer days;

    /**
     * 关联流程实例获取流程实例数据
     */
    @Excel(name = "流程实例ID")
    private String procInsId;


    @TableField(exist = false)
    private int status;

}
