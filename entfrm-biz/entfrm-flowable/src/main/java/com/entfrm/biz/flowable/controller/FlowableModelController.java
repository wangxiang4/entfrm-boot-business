package com.entfrm.biz.flowable.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.entfrm.base.api.R;
import com.entfrm.biz.flowable.entity.FlowableModel;
import com.entfrm.biz.flowable.service.FlowableModelService;
import com.entfrm.biz.flowable.service.FlowableProcessService;
import com.entfrm.security.entity.EntfrmUser;
import com.entfrm.security.util.SecurityUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.idm.api.User;
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

import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;


/**
 *<p>
 * 模型相关 controller
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/13
 */
@RestController
@RequestMapping("/flowable/model")
@AllArgsConstructor
public class FlowableModelController {

    private final ObjectMapper objectMapper;

    protected final ModelService modelService;

    private final FlowableModelService flowableModelService;

    private final FlowableProcessService flowableProcessService;

    private final RepositoryService repositoryService;

    private LambdaQueryWrapper<FlowableModel> getLambdaQueryWrapper(FlowableModel flowableModel) {
        return new LambdaQueryWrapper<FlowableModel>()
                .like(StrUtil.isNotBlank(flowableModel.getName()), FlowableModel::getName, flowableModel.getName());
    }

    /** 流程模型列表 */
    @GetMapping("/list")
    public R list(Page page, FlowableModel flowableModel) {
        IPage<FlowableModel> result = flowableModelService.page(page, getLambdaQueryWrapper(flowableModel));
        // 存储流程实例
        result.getRecords().forEach(item -> {
            ProcessDefinition processDefinition = flowableProcessService.getProcessDefinitionByKey(item.getModelKey());
            if(processDefinition != null){
                String deploymentId = processDefinition.getDeploymentId();
                Deployment deployment = repositoryService.createDeploymentQuery().deploymentId(deploymentId).singleResult();
                item.getProcessInstanceVo()
                        .setId(processDefinition.getId())
                        .setCategory(processDefinition.getCategory())
                        .setKey(processDefinition.getKey())
                        .setName(processDefinition.getName())
                        .setVersion("V:" + processDefinition.getVersion())
                        .setResourceName(processDefinition.getResourceName())
                        .setDiagramResourceName(processDefinition.getDiagramResourceName())
                        .setDeploymentId(processDefinition.getDeploymentId())
                        .setSuspend(processDefinition.isSuspended())
                        .setDeploymentTime(deployment.getDeploymentTime());
            }
        });
        return R.ok(result.getRecords(), result.getTotal());
    }

    /** 导出model的xml文件 */
    @GetMapping("/getBpmnXml")
    public String export(String id) {
        return flowableModelService.export(id);
    }

    /** 更新Model分类 */
    @PostMapping("/updateCategory")
    public R updateCategory(String id, String category) {
        repositoryService.setProcessDefinitionCategory(id, category);
        return R.ok("设置成功，模块ID=" + id);
    }

    /** 删除模型 */
    @DeleteMapping("/remove/{id}")
    public R remove(@PathVariable String[] ids) {
        Arrays.asList(ids).forEach(id -> flowableModelService.remove(id));
        return R.ok("删除成功");
    }

    /** 复制模型 */
    @PostMapping("/copy")
    public R copy(String id) throws Exception {
        Model sourceModel = modelService.getModel(id);
        ModelRepresentation modelRepresentation = new ModelRepresentation ();
        modelRepresentation.setKey ("Process_"+ UUID.randomUUID ());
        modelRepresentation.setName (sourceModel.getName ()+"_copy");
        modelRepresentation.setModelType (0);
        modelRepresentation.setDescription ("");
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
        String modelId = newModel.getId ();
        ObjectNode sourceObjectNode = (ObjectNode) objectMapper.readTree(sourceModel.getModelEditorJson());
        ObjectNode editorNode = sourceObjectNode.deepCopy();
        ObjectNode properties = objectMapper.createObjectNode();
        properties.put("process_id", newModel.getKey());
        properties.put("name", newModel.getName());
        editorNode.set("properties", properties);
        newModel.setModelEditorJson (editorNode.toString());
        modelService.saveModel(modelId, newModel.getName (), newModel.getKey (), newModel.getDescription (), newModel.getModelEditorJson (), true, "", modelUser);
        return  R.ok("拷贝成功!");
    }

    /** 部署流程 */
    @PostMapping("/deploy")
    public R deploy(String id, String category) {
        String result = flowableModelService.deploy(id, category);
        return  R.ok(result);
    }

    /** 保存模型 */
    @PostMapping("saveModel/{modelId}")
    public ModelRepresentation saveModel(@PathVariable String modelId, @RequestBody MultiValueMap<String, String> values) {
        long lastUpdated;
        String lastUpdatedString = values.getFirst("lastUpdated");
        if (lastUpdatedString == null) {
            throw new BadRequestException("不存在上次更新日期");
        } else {
            try {
                Date readValue = this.objectMapper.getDeserializationConfig().getDateFormat().parse(lastUpdatedString);
                lastUpdated = readValue.getTime();
            } catch (ParseException e) {
                throw new BadRequestException("无效的上次更新日期: '" + e + "'");
            }

            // 查询模型进行比较处理
            Model model = this.modelService.getModel(modelId);
            EntfrmUser currentUser = SecurityUtil.getUser();
            boolean currentUserIsOwner = model.getLastUpdatedBy().equals(currentUser.getId());
            String resolveAction = values.getFirst("conflictResolveAction");
            // 版本校验(如果此时你在修改模型时别人提交了你的模型版本,如果没有版本校验就会出问题)
            if (model.getLastUpdated().getTime() != lastUpdated) {
                String isNewVersionString;
                if ("saveAs".equals(resolveAction)) {
                    isNewVersionString = values.getFirst("saveAs");
                    String json = values.getFirst("json_xml");
                    return this.createNewModel(isNewVersionString, model.getDescription(), model.getModelType(), json);
                } else if ("overwrite".equals(resolveAction)) {
                    return this.updateModel(model, values, false);
                } else if ("newVersion".equals(resolveAction)) {
                    return this.updateModel(model, values, true);
                } else {
                    if (currentUserIsOwner && "true".equals(values.getFirst("newVersion"))) {
                        return this.updateModel(model, values, true);
                    } else {
                        ConflictingRequestException exception = new ConflictingRequestException("别人更新了你的流程模型");
                        exception.addCustomData("userFullName", model.getLastUpdatedBy());
                        exception.addCustomData("newVersionAllowed", currentUserIsOwner);
                        throw exception;
                    }
                }
            } else {
                return this.updateModel(model, values, false);
            }
        }
    }

    /** 创建模型 */
    private ModelRepresentation createNewModel(String name, String description, Integer modelType, String editorJson) {
        ModelRepresentation model = new ModelRepresentation();
        model.setName(name);
        model.setDescription(description);
        model.setModelType(modelType);
        Model newModel = this.modelService.createModel(model, editorJson, SecurityUtils.getCurrentUserObject());
        return new ModelRepresentation(newModel);
    }

    /** 修改模型 */
    private ModelRepresentation updateModel(Model model, MultiValueMap<String, String> values, boolean forceNewVersion) {
        String name = values.getFirst("name"),
               key = values.getFirst("key").replaceAll(" ", ""),
               description = values.getFirst("description"),
               isNewVersionString = values.getFirst("newVersion"),
               newVersionComment = null;
        ModelKeyRepresentation modelKeyInfo = this.modelService.validateModelKey(model, model.getModelType(), key);
        if (modelKeyInfo.isKeyAlreadyExists()) {
            throw new BadRequestException("所提供的模型key已经存在: " + key);
        } else {
            boolean newVersion = false;
            if (forceNewVersion) {
                newVersion = true;
                newVersionComment = values.getFirst("comment");
            } else if (isNewVersionString != null) {
                newVersion = "true".equals(isNewVersionString);
                newVersionComment = values.getFirst("comment");
            }
            String json = values.getFirst("json_xml");
            json = this.flowableModelService.changeXmlToJson(json);
            try {
                ObjectNode editorJsonNode = (ObjectNode)this.objectMapper.readTree(json);
                ObjectNode propertiesNode = (ObjectNode)editorJsonNode.get("properties");
                propertiesNode.put("process_id", key);
                propertiesNode.put("name", name);
                if (StringUtils.isNotEmpty(description)) {
                    propertiesNode.put("documentation", description);
                }
                editorJsonNode.set("properties", propertiesNode);
                model = this.modelService.saveModel(model.getId(), name, key, description, editorJsonNode.toString(), newVersion, newVersionComment, SecurityUtils.getCurrentUserObject());
                return new ModelRepresentation(model);
            } catch (Exception var15) {
                throw new BadRequestException("无法保存流程模型: " + model.getId());
            }
        }
    }

    /** 校验是否存在重复的模型key */
    private void checkForDuplicateKey(ModelRepresentation modelRepresentation) {
        ModelKeyRepresentation modelKeyInfo = this.modelService.validateModelKey(null, modelRepresentation.getModelType(), modelRepresentation.getKey());
        if (modelKeyInfo.isKeyAlreadyExists()) throw new ConflictingRequestException("所提供的模型key已经存在: " + modelRepresentation.getKey());
    }

}
