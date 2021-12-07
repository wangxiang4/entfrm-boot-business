package com.entfrm.biz.intelligent.service;

import com.entfrm.biz.intelligent.dto.Integrated;

import java.util.Map;

/**
 * <p>
 * 表单扩展设计器控件业务表逻辑集成处理
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/3/26
 */
public interface BusinessIntegratedProcessService {

    /**
     * 业务数据映射表逻辑新增处理
     *@Param [type, value]
     *@return T
     * @param integrated
     */
    int businessInsert(Integrated integrated);



    /**
     * 业务数据映射表逻辑修改处理
     *@Param [type, value]
     *@return T
     */
    int businessUpdate(Integrated integrated);


    /**
     * 业务数据映射表逻辑删除处理
     *@Param [type, value]
     *@return T
     */
    int businessDelete(Object[] ids,String formCode,Float version);


    /**
     * 查询当前这一板表单扩展业务数据
     *@Param
     *@return
     */
    Map<String,Object> businessSelect(Object ids,String formCode,Float version);


}
