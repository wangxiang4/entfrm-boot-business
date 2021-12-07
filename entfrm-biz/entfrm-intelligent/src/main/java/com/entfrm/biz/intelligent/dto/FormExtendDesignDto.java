package com.entfrm.biz.intelligent.dto;

import lombok.Data;
import lombok.experimental.Accessors;

/**
 * <p>
 * 表单扩展设计器
 * 数据传输封装(便于后期转换-后期扩展)
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
@Data
@Accessors(chain = true)
public class FormExtendDesignDto {

    /**
     * 表单扩展ID
     */
    private Long formExtendId;
    /**
     * 整体表单的json数据
     */
    private JsonMode jsonMode;
    /**
     * 没有做过扁平化处理的源数据
     */
    private JsonMode originJsonMode;
    /**
     * 控件全局ID-区分
     */
    private Long idGlobal;
    /**
     * 级联下拉控件独立区分-局域[Tree-Key]ID数据
     */
    private String treeNodeId;


}
