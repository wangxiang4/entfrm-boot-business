package com.entfrm.biz.workflow.mapper;

import com.entfrm.biz.workflow.entity.Workflow;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 工作流核心 Mapper
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowMapper {

    /** 修改业务表流程ID */
    int updateProcInsIdByBusinessId(Workflow workflow);

}
