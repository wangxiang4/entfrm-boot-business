package com.entfrm.biz.intelligent.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 *  数据配置
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/2/9
 */

@Data
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@TableName("intelligent_data_conf")
public class DataConf {

    /**
     * 数据配置ID
     */
    private Long id;

    /**
     * 表单扩展id
     */
    private Long formExtendId;

    /**
     * 数据映射表前缀
     */
    private String dataMappingTablePrepend;

    /**
     * 数据映射表名-自定义填写-后缀
     */
    private String dataMappingTable;

    /**
     * 字段数量
     */
    private Long fieldLength;

}
