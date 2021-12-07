package com.entfrm.biz.flowable.service.impl;

import cn.hutool.core.io.IoUtil;
import cn.hutool.json.JSONUtil;
import com.entfrm.biz.flowable.service.FlowableModelerService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Model;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

import static org.flowable.editor.constants.ModelDataJsonConstants.*;

/**
 *<p>
 * 工作流设计器相关service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Slf4j
@Service
@AllArgsConstructor
public class FlowableModelerServiceImpl implements FlowableModelerService {


	private final RepositoryService repositoryService;
	private final ObjectMapper objectMapper;



	@Override
	public Object getStencilset() {
		InputStream stencilsetStream = this.getClass().getClassLoader().getResourceAsStream("static/stencilset.json");
		try {
			return IoUtil.read(stencilsetStream, StandardCharsets.UTF_8);
		} catch (Exception e) {
			log.error("Error while loading stencil set", e);
			throw new FlowableException("Error while loading stencil set", e);
		}
	}



	@Override
	public Object getEditorJson(String modelId) {
		ObjectNode modelNode;
		Model model = repositoryService.getModel(modelId);
		if (model != null) {
			try {
				if (StringUtils.isNotEmpty(model.getMetaInfo())) {
					modelNode = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
				} else {
					modelNode = objectMapper.createObjectNode();
					modelNode.put(MODEL_NAME, model.getName());
				}
				byte[] source = repositoryService.getModelEditorSource(model.getId());
				modelNode.put(MODEL_ID, model.getId());
				ObjectNode editorJsonNode = (ObjectNode) objectMapper.readTree(new String(source, StandardCharsets.UTF_8));
				modelNode.set("model", editorJsonNode);
				log.info("Model JSON: {}", JSONUtil.toJsonStr(modelNode));
				return modelNode;
			} catch (Exception e) {
				log.error("Error creating model JSON", e);
				throw new FlowableException("Error creating model JSON", e);
			}
		}
		return null;
	}



	@Override
	public void saveModel(String modelId, String name, String description, String jsonXml, String svgXml) {
		try {
			Model model = repositoryService.getModel(modelId);
			ObjectNode modelJson = (ObjectNode) objectMapper.readTree(model.getMetaInfo());
			modelJson.put(MODEL_NAME, name);
			modelJson.put(MODEL_DESCRIPTION, description);
			model.setMetaInfo(modelJson.toString());
			model.setName(name);
			repositoryService.saveModel(model);
			repositoryService.addModelEditorSource(model.getId(), jsonXml.getBytes(StandardCharsets.UTF_8));
			ByteArrayOutputStream outStream = new ByteArrayOutputStream();
			final byte[] result = outStream.toByteArray();
			repositoryService.addModelEditorSourceExtra(model.getId(), result);
			outStream.close();
		} catch (Exception e) {
			log.error("Error saving model", e);
			throw new FlowableException("Error saving model", e);
		}
	}


}
