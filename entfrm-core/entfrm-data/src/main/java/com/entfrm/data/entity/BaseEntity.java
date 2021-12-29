package com.entfrm.data.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.security.entity.EntfrmUser;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 *<p>
 * 基础模型
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/28
 */
@Data
public class BaseEntity implements Serializable {

    protected static final long serialVersionUID = 1L;

    /** 当前用户 */
    protected EntfrmUser currentUser;

    /** 自定义sql过滤 */
    @TableField(exist = false)
    @JsonIgnore
    private String sqlFilter;

}
