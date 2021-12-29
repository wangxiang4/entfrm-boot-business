package com.entfrm.biz.flowable.mapper;

import com.entfrm.biz.flowable.entity.Flow;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 工作流 Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-11
 */
public interface FlowMapper {

    /** 获取表单设计器渲染数据 */
    String getFormRenderData(String code);

    /** 修改业务表流程ID */
    int updateProcInsIdByBusinessId(Flow act);

    /** 查询外置表单数据 */
    Map selectFormData(Flow act);

    /** 查询动态表单集合 */
    List<Map> selectDynamicFormList();

}
