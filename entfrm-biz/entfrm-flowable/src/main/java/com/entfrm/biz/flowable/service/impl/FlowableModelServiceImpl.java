package com.entfrm.biz.flowable.service.impl;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.constant.CommonConstants;
import com.entfrm.biz.flowable.service.FlowableModelService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.editor.constants.ModelDataJsonConstants;
import org.flowable.editor.language.json.converter.BpmnJsonConverter;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.Model;
import org.flowable.engine.repository.ModelQuery;
import org.flowable.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;


/**
 *<p>
 * 模型相关 Service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Slf4j
@Service
@AllArgsConstructor
public class FlowableModelServiceImpl implements FlowableModelService {

    private final RepositoryService repositoryService;
    private final ObjectMapper objectMapper;


    @Override
    public IPage<Model> list(Map<String, Object> params) {
        ModelQuery modelQuery = repositoryService.createModelQuery()
                .latestVersion().orderByLastUpdateTime().desc();

        String name = (String) params.get("name");
        if (StrUtil.isNotBlank(name)) {
            modelQuery.modelNameLike(name);
        }

        String category = (String) params.get("category");
        if (StrUtil.isNotBlank(category)) {
            modelQuery.modelCategory(category);
        }

        int current = MapUtil.getInt(params, CommonConstants.CURRENT);
        int size = MapUtil.getInt(params, CommonConstants.SIZE);

        IPage result = new Page(current, size);
        result.setTotal(modelQuery.count());
        result.setRecords(modelQuery.listPage((current - 1) * size, size));
        return result;
    }


    @Override
    public Model save(String name, String category, String key, String description) {
        try {
            ObjectNode editorNode = objectMapper.createObjectNode();
            editorNode.put("id" , "canvas");
            editorNode.put("resourceId" , "canvas");
            ObjectNode properties = objectMapper.createObjectNode();
            properties.put("process_author" , CommonConstants.AUTHOR);
            properties.put("process_id" , key);
            properties.put("name" , name);
            editorNode.set("properties" , properties);
            ObjectNode stencilset = objectMapper.createObjectNode();
            stencilset.put("namespace" , "http://b3mn.org/stencilset/bpmn2.0#");
            editorNode.set("stencilset" , stencilset);

            Model model = repositoryService.newModel();
            model.setKey(key);
            model.setName(name);
            model.setCategory(category);
            model.setVersion(Integer.parseInt(String.valueOf(repositoryService.createModelQuery().modelKey(model.getKey()).count() + 1)));

            ObjectNode modelObjectNode = objectMapper.createObjectNode();
            modelObjectNode.put(ModelDataJsonConstants.MODEL_NAME, name);
            modelObjectNode.put(ModelDataJsonConstants.MODEL_REVISION, model.getVersion());
            modelObjectNode.put(ModelDataJsonConstants.MODEL_DESCRIPTION, description);
            model.setMetaInfo(modelObjectNode.toString());

            repositoryService.saveModel(model);
            repositoryService.addModelEditorSource(model.getId(), editorNode.toString().getBytes("utf-8"));
            return model;
        } catch (UnsupportedEncodingException e) {
            log.error("UnsupportedEncodingException" , e);
        }
        return null;
    }


    @Override
    public void removeById(String id) {
        repositoryService.deleteModel(id);
    }


    @Override
    public String deploy(String id) {
        String message = "";
        try {
            // 获取模型
            Model model = repositoryService.getModel(id);
            ObjectNode objectNode = (ObjectNode) new ObjectMapper().readTree(repositoryService.getModelEditorSource(model.getId()));
            BpmnModel bpmnModel = new BpmnJsonConverter().convertToBpmnModel(objectNode);

            String processName = model.getName();
            if (!StrUtil.endWithIgnoreCase(processName, ".bpmn20.xml")) {
                processName += ".bpmn20.xml";
            }

            // 部署流程
            Deployment deployment = repositoryService
                    .createDeployment()
                    .name(model.getName())
                    .addBpmnModel(processName, bpmnModel)
                    .key(model.getKey())
                    .deploy();
            log.debug("流程部署--------deploy：" + deployment );

            // 设置流程分类
            List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery()
                    .deploymentId(deployment.getId())
                    .list();

            list.stream().forEach(processDefinition ->
                    repositoryService.setProcessDefinitionCategory(processDefinition.getId(), model.getCategory()));

            if (list.size() == 0) {
                message = "部署失败，没有流程。";
            }

        } catch (Exception e) {
            throw new FlowableException("设计模型图不正确，检查模型正确性，模型ID=" + id, e);
        }
        return message;
    }


}
