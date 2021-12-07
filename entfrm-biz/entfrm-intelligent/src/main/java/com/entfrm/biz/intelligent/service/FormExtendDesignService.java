package com.entfrm.biz.intelligent.service;

import com.entfrm.biz.intelligent.dto.FormExtendDesignDto;

import java.util.Map;

/**
 * <p>
 * 表单扩展设计器业务接口
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
public interface FormExtendDesignService {

    /**
     * 表单设计器数据保存-并发编程
     *@Param [formExtendDesignDto]
     *@return int
     */
    int insert(FormExtendDesignDto formExtendDesignDto);


    /**
     * 表单设计器数据修改-并发编程
     *@Param [formExtendDesignDto]
     *@return int
     */
    int update(FormExtendDesignDto formExtendDesignDto);


    /**
     * 表单设计器数据删除-并发编程
     *@Param [formExtendId]
     *@return int
     */
    int delete(Long formExtendId);

    /**
     * 校验数据库中是否有Business数据映射表
     *@Param [tableName]
     *@return int
     */
    int validatorBusinessTable(String tableName);



    /**
     * todo 格式化json数据成扁平化
     * 螺旋钻头递归[处理Json模型]
     * 内部做了去key去下划线处理
     * 演示: {__config__:{w_x:{val:123}}}
     * Key = config_wx_val, Value = 123
     *@Param [TempJsonMode, ProcessJsonMode, ProcessKey]
     *@return void
     */
    void ProcessJsonMode(Map<String,Object> TempJsonMode, Map<String,Object> ProcessJsonMode,String ProcessKey);


}
