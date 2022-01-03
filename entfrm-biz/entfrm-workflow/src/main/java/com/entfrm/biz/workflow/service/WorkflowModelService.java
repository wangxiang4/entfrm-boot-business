package com.entfrm.biz.workflow.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.workflow.entity.WorkflowModel;

/**
 * <p>
 * 流程模型 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public interface WorkflowModelService extends IService<WorkflowModel> {

    /**
     * 导出bpmn.xml
     * id: 模型id
     */
    String export(String id);

    /**
     * 移除模型
     * id: 模型id
     */
    void remove (String id);

    /**
     * 移除部署
     * processDefKey: 流程定义key
     */
    void deleteDeployment (String processDefKey);

    /**
     * 部署模型
     * id: 模型id
     * category: 模型分类
     */
    String deploy(String id, String category);

    /**
     * 将工作流xml转换json
     * xml: bpmn.xml
     */
    String changeXmlToJson (String xml);
}
