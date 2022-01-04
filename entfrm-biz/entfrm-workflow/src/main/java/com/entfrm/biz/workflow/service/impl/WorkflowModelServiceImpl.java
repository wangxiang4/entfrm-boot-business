package com.entfrm.biz.workflow.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.ActivityExtensionProperty;
import com.entfrm.biz.extension.service.ActivityExtensionDataService;
import com.entfrm.biz.extension.service.ActivityExtensionPropertyService;
import com.entfrm.biz.workflow.entity.WorkflowModel;
import com.entfrm.biz.workflow.mapper.WorkflowModelMapper;
import com.entfrm.biz.workflow.service.WorkflowModelService;
import com.entfrm.biz.workflow.service.WorkflowProcessService;
import com.fasterxml.jackson.databind.node.ObjectNode;
import lombok.AllArgsConstructor;
import org.apache.commons.lang3.StringUtils;
import org.flowable.bpmn.BpmnAutoLayout;
import org.flowable.bpmn.converter.BpmnXMLConverter;
import org.flowable.bpmn.model.BpmnModel;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.editor.language.json.converter.BpmnJsonConverter;
import org.flowable.editor.language.json.converter.util.CollectionUtils;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.repository.Deployment;
import org.flowable.engine.repository.ProcessDefinition;
import org.flowable.ui.common.service.exception.BadRequestException;
import org.flowable.ui.common.util.XmlUtil;
import org.flowable.ui.modeler.domain.Model;
import org.flowable.ui.modeler.serviceapi.ModelService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;
import java.io.ByteArrayInputStream;
import java.io.InputStreamReader;
import java.util.List;

/**
 * <p>
 * 流程模型 service
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@Service
@Transactional
@AllArgsConstructor
public class WorkflowModelServiceImpl extends ServiceImpl<WorkflowModelMapper, WorkflowModel> implements WorkflowModelService {

    private final ModelService modelService;

    private final WorkflowProcessService workflowProcessService;

    private final RepositoryService repositoryService;

    private final ActivityExtensionDataService activityExtensionDataService;

    private final ActivityExtensionPropertyService activityExtensionPropertyService;

    private BpmnXMLConverter bpmnXmlConverter;

    private BpmnJsonConverter bpmnJsonConverter;

    @Override
    public String export(String id) {
        try {
            Model model = modelService.getModel(id);
            byte[] bpmnBytes = modelService.getBpmnXML(model);
            return new String(bpmnBytes);
        } catch (Exception e) {
            throw new FlowableException("导出model的xml文件失败，模型ID=" + id, e);
        }
    }

    @Override
    public void remove(String id) {
        Model model = modelService.getModel(id);
        try {
            this.deleteDeployment(model.getKey());
            this.modelService.deleteModel(model.getId());
            activityExtensionDataService.deleteByProcessDefId(model.getKey());
            activityExtensionPropertyService.remove(new LambdaUpdateWrapper<ActivityExtensionProperty>()
                    .eq(ActivityExtensionProperty::getProcessDefId, model.getKey()));
        } catch (Exception e) {
            throw new BadRequestException("不能删除模型: " + id);
        }
    }

    @Override
    public void deleteDeployment(String processDefKey) {
        ProcessDefinition processDefinition = workflowProcessService.getProcessDefinitionByKey(processDefKey);
        if (processDefinition != null) {
            try {
                repositoryService.deleteDeployment(processDefinition.getDeploymentId(), true);
            } catch (Exception e) {
                throw new BadRequestException("流程不能被删除: " + processDefinition.getDeploymentId());
            }
            this.deleteDeployment(processDefKey);
        }
    }

    @Override
    public String deploy(String id, String category) {
        String message = "";
        try {
            Model model = modelService.getModel(id);
            byte[] bpmnBytes = modelService.getBpmnXML(model);

            String processName = model.getName();
            if (!StringUtils.endsWith(processName, ".bpmn20.xml")) processName += ".bpmn20.xml";

            Deployment deployment = repositoryService.createDeployment()
                    .addBytes(processName, bpmnBytes)
                    .name(model.getName())
                    .key(model.getKey())
                    .deploy();

            List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery()
                    .deploymentId(deployment.getId()).list();

            // 设置流程分类
            for (ProcessDefinition processDefinition : list) {
                if (StringUtils.isNotBlank(category)) {
                    repositoryService.setProcessDefinitionCategory(processDefinition.getId(), category);
                }
                message += "部署成功,流程ID=" + processDefinition.getId() ;
            }

            if (list.size() == 0) {
                message = "部署失败,没有流程。";
            }
        } catch (Exception e) {
            throw new FlowableException("设计模型图不正确,检查模型正确性,模型ID=" + id, e);
        }
        return message;
    }

    @Override
    public String changeXmlToJson(String xml) {
        try {
            XMLInputFactory xif = XmlUtil.createSafeXmlInputFactory();
            InputStreamReader xmlIn = new InputStreamReader(new ByteArrayInputStream(xml.getBytes("UTF-8")), "UTF-8");
            XMLStreamReader xsr = xif.createXMLStreamReader(xmlIn);
            // bpmn模型转换
            BpmnModel bpmnModel = this.bpmnXmlConverter.convertToBpmnModel(xsr);
            if (CollectionUtils.isEmpty(bpmnModel.getProcesses())) {
                throw new BadRequestException("在定义中没有发现进程" );
            } else {
                if (bpmnModel.getLocationMap().size() == 0) {
                    BpmnAutoLayout bpmnLayout = new BpmnAutoLayout(bpmnModel);
                    bpmnLayout.execute();
                }
                // bpmn模型转换json
                ObjectNode modelNode = this.bpmnJsonConverter.convertToJson(bpmnModel);
                return modelNode.toString();
            }
        } catch (Exception e) {
            throw new BadRequestException("导入失败,出错信息:" + e.getMessage());
        }
    }
}
