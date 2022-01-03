package com.entfrm.biz.workflow.mapper;

import com.entfrm.biz.workflow.entity.Workflow;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 工作流 Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowMapper {

    /** 获取表单设计器渲染数据 */
    String getFormRenderData(String code);

    /** 修改业务表流程ID */
    int updateProcInsIdByBusinessId(Workflow act);

    /** 查询外置表单数据 */
    Map selectFormData(Workflow act);

    /** 查询动态表单集合 */
    List<Map> selectDynamicFormList();

}
