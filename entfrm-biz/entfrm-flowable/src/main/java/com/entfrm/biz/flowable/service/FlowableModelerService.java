package com.entfrm.biz.flowable.service;


/**
 *<p>
 *  工作流设计器相关service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
public interface FlowableModelerService {

    /** 获取设计器页面的json */
    Object getStencilset();

    /** 根据modelId获取model */
    Object getEditorJson(String modelId);

    /** 保存model信息 */
    void saveModel(String modelId, String name, String description, String jsonXml, String svgXml);

}
