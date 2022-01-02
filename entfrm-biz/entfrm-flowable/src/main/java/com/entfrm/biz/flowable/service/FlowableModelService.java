package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.entfrm.biz.flowable.entity.FlowableModel;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * <p>
 * 流程模型 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021-05-11
 */
public interface FlowableModelService extends IService<FlowableModel> {

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
     * key: 流程定义key
     */
    void deleteDeployment (String key);

    /**
     * 部署模型
     * id: 模型id
     * category: 模型分类
     */
    String deploy(String id, String category);

    /**
     * 将工作流xml转换json
     * xml: bpmn xml
     */
    String changeXmlToJson (String xml);
}
