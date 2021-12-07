package com.entfrm.biz.flowable.controller;

import com.entfrm.biz.flowable.service.FlowableModelerService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;


/**
 *<p>
 * 设计器相关 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@AllArgsConstructor
@RequestMapping("/flowable/service")
public class FlowableModelerController {


	private final FlowableModelerService flowableModelerService;


	@GetMapping("/editor/stencilset")
	public Object getStencilset() {
		return flowableModelerService.getStencilset();
	}


	@GetMapping(value = "/model/{modelId}/json")
	public Object getEditorJson(@PathVariable(value = "modelId") String modelId) {
		return flowableModelerService.getEditorJson(modelId);
	}


	@PutMapping("/model/{modelId}/save")
	public void saveModel(@PathVariable(value = "modelId") String modelId, String name, String description,
						  @RequestParam("json_xml") String jsonXml, @RequestParam("svg_xml") String svgXml) {
		flowableModelerService.saveModel(modelId, name, description, jsonXml, svgXml);
	}


}
