package com.entfrm.data.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

/**
 *<p>
 * 树结构模型
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/12/28
 */
@Data
public class TreeEntity<T> extends CommonEntity {

    private static final long serialVersionUID = 1L;

    /** 父级编号 **/
    private Integer parentId;

    /** 名称 */
    protected String name;

    /** 排序 **/
    private Integer sort;

    @TableField(exist = false)
    protected List<T> children = new ArrayList();

}
