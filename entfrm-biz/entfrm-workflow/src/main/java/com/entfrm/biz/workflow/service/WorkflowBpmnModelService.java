package com.entfrm.biz.workflow.service;

import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.EndEvent;

import java.util.List;

/**
 * <p>
 * bpmn模型 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowBpmnModelService {

    /**
     * 获取Bpmn模型
     * processDefId:流程定义ID
     */
    BpmnModel getBpmnModelByProcessDefId(String processDefId);

    /**
     * 查找流程中结束事件的元素
     * processDefId:流程定义ID
     */
    List<EndEvent> findEndFlowElement(String processDefId);

}
