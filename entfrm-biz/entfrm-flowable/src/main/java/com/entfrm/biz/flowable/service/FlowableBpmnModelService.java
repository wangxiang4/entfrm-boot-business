package com.entfrm.biz.flowable.service;

import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.EndEvent;

import java.util.List;

/**
 * <p>
 * bpmn模型相关 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-17
 */
public interface FlowableBpmnModelService {

    /**
     * 查找结束事件的元素
     * processDefId:流程定义ID
     */
    List<EndEvent> findEndFlowElement(String processDefId);


    /**
     * 获取Bpmn模型
     * processDefId:流程定义ID
     */
    BpmnModel getBpmnModelByProcessDefId(String processDefId);

}
