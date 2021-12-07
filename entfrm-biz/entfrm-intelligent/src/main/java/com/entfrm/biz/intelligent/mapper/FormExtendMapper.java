package com.entfrm.biz.intelligent.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.entfrm.biz.intelligent.entity.FormExtend;

/**
 * <p>
 * 表单扩展mapper操作
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/1/21
 */
public interface FormExtendMapper extends BaseMapper<FormExtend> {

    /**
     * 级联查询
     *@Param [id]
     *@return com.entfrm.biz.intelligent.entity.FormExtend
     */
    FormExtend selectSingle(Integer id);

    /**
     * 获取表单扩展模板
     *@Param [cod]
     *@return java.lang.String
     */
    String findByCodeOne(String cod);


}
