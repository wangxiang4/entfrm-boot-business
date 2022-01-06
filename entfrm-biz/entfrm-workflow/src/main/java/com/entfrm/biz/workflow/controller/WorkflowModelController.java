package com.entfrm.biz.workflow.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.workflow.entity.WorkflowModel;
import com.entfrm.biz.workflow.service.WorkflowModelService;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.entfrm.biz.workflow.vo.ProcessDefinitionInfoVo;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.idm.engine.impl.persistence.entity.UserEntity;
import org.flowable.idm.engine.impl.persistence.entity.UserEntityImpl;
import org.flowable.ui.common.security.SecurityUtils;
import org.flowable.ui.common.service.exception.BadRequestException;
import org.flowable.ui.common.service.exception.ConflictingRequestException;
import org.flowable.ui.modeler.domain.Model;
import org.flowable.ui.modeler.model.ModelKeyRepresentation;
import org.flowable.ui.modeler.model.ModelRepresentation;
import org.flowable.ui.modeler.serviceapi.ModelService;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;


/**
 *<p>
 * 流程模型 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@RestController
@RequestMapping("/workflow/model")
@AllArgsConstructor
public class WorkflowModelController {

    private final ObjectMapper objectMapper;

    protected final ModelService modelService;

    private final WorkflowModelService workflowModelService;

    private final WorkflowProcessService workflowProcessService;

    private final RepositoryService repositoryService;

    private LambdaQueryWrapper<WorkflowModel> getLambdaQueryWrapper(WorkflowModel workflowModel) {
        return new LambdaQueryWrapper<WorkflowModel>()
                .like(StrUtil.isNotBlank(workflowModel.getName()), WorkflowModel::getName, workflowModel.getName());
    }

    /** 流程模型列表 */
    @GetMapping("/list")
    public R list(Page page, WorkflowModel workflowModel) {
        IPage<WorkflowModel> result = workflowModelService.page(page, getLambdaQueryWrapper(workflowModel));
        // 存储流程实例
        result.getRecords().forEach(item -> {
            ProcessDefinition processDefinition = workflowProcessService.getProcessDefinitionByKey(item.getModelKey());
            if(processDefinition != null){
                String deploymentId = processDefinition.getDeploymentId();
                Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
                item.setProcessDefinition(new ProcessDefinitionInfoVo()
                        .setId(processDefinition.getId())
                        .setCategory(processDefinition.getCategory())
                        .setKey(processDefinition.getKey())
                        .setName(processDefinition.getName())
                        .setVersion("V:" + processDefinition.getVersion())
                        .setResourceName(processDefinition.getResourceName())
                        .setDiagramResourceName(processDefinition.getDiagramResourceName())
                        .setDeploymentId(processDefinition.getDeploymentId())
                        .setSuspend(processDefinition.isSuspended())
                        .setDeploymentTime(deployment.getDeploymentTime()));

            }
        });
        return R.ok(result.getRecords(), result.getTotal());
    }

    /** 导出model的xml文件 */
    @GetMapping("/getBpmnXml/{id}")
    public String getBpmnXml(@PathVariable String id) {
        return workflowModelService.getBpmnXml(id);
    }

    /** 更新Model分类 */
    @PutMapping("/setCategory")
    public R setCategory(String id, String category) {
        repositoryService.setProcessDefinitionCategory(id, category);
        return R.ok("设置成功，模块ID=" + id);
    }

    /** 删除模型 */
    @DeleteMapping("/remove/{ids}")
    public R remove(@PathVariable String[] ids) {
        Arrays.asList(ids).forEach(id -> workflowModelService.remove(id));
        return R.ok("删除成功");
    }

    /** 复制模型 */
    @PostMapping("/copy/{id}")
    public R copy(@PathVariable String id) throws Exception {
        Model sourceModel = modelService.getModel(id);
        ModelRepresentation modelRepresentation = new ModelRepresentation();
        modelRepresentation.setKey("Process_"+ UUID.randomUUID());
        modelRepresentation.setName(sourceModel.getName()+"_copy");
        modelRepresentation.setModelType(0);
        modelRepresentation.setDescription("");
        modelRepresentation.setKey(modelRepresentation.getKey().replaceAll(" ", ""));
        this.checkForDuplicateKey(modelRepresentation);
        String modelJson = modelService.createModelJson(modelRepresentation);
        // 设置模型用户信息
        EntfrmUser user = SecurityUtil.getUser();
        UserEntity modelUser = new UserEntityImpl();
        modelUser.setId(user.getId() + "");
        modelUser.setFirstName(user.getUsername());
        modelUser.setLastName("");
        // 创建新模型
        Model newModel = modelService.createModel(modelRepresentation, modelJson, modelUser);
        String modelId = newModel.getId();
        ObjectNode sourceObjectNode = (ObjectNode) objectMapper.readTree(sourceModel.getModelEditorJson());
        ObjectNode editorNode = sourceObjectNode.deepCopy();
        ObjectNode properties = objectMapper.createObjectNode();
        properties.put("process_id", newModel.getKey());
        properties.put("name", newModel.getName());
        editorNode.set("properties", properties);
        newModel.setModelEditorJson(editorNode.toString());
        modelService.saveModel(modelId, newModel.getName(), newModel.getKey(), newModel.getDescription(), newModel.getModelEditorJson(), true, "", modelUser);
        return  R.ok("拷贝成功!");
    }

    /** 部署流程 */
    @PostMapping("/deploy")
    public R deploy(String id, String category) {
        String result = workflowModelService.deploy(id, category);
        return  R.ok(result);
    }

    /** 校验是否存在重复的模型key */
    private void checkForDuplicateKey(ModelRepresentation modelRepresentation) {
        ModelKeyRepresentation modelKeyInfo = this.modelService.validateModelKey(null, modelRepresentation.getModelType(), modelRepresentation.getKey());
        if (modelKeyInfo.isKeyAlreadyExists()) throw new ConflictingRequestException("所提供的模型key已经存在: " + modelRepresentation.getKey());
    }

}
