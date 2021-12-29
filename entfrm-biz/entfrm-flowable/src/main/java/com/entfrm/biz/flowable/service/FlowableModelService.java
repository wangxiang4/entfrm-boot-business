package com.entfrm.biz.flowable.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.flowable.engine.repository.Model;

import java.util.Map;


/**
 *<p>
 * 工作流模型相关Service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
public interface FlowableModelService {


    /** 流程分页查询 */
    IPage<Model> list(Map<String, Object> params);


    /** 创建流程 */
    Model save(String name, String key, String desc, String category);


    /** 删除流程 */
    void removeById(String id);


    /** 部署流程 */
    String deploy(String id);

}
