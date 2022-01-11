package com.entfrm.biz.workflow.override.json;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.util.SpringContextUtil;
import com.entfrm.biz.extension.entity.ActivityExtensionData;
import com.entfrm.biz.extension.entity.ActivityExtensionProperty;
import com.entfrm.biz.extension.entity.WorkflowCondition;
import com.entfrm.biz.extension.service.ActivityExtensionDataService;
import com.entfrm.biz.extension.service.ActivityExtensionPropertyService;
import com.fasterxml.jackson.databind.JsonNode;
import org.flowable.bpmn.model.ExtensionAttribute;
import org.flowable.bpmn.model.ExtensionElement;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.SequenceFlow;
import org.flowable.editor.language.json.converter.SequenceFlowJsonConverter;

import java.util.List;
import java.util.Map;

public class FlowableSequenceFlowJsonConverter extends SequenceFlowJsonConverter {


    @Override
    protected FlowElement convertJsonToElement(JsonNode elementNode, JsonNode modelNode,
                                               Map<String, JsonNode> shapeMap) {
        String procDefId = getProperty("process_id", modelNode).asText();
        String taskDefId = getProperty("overrideid", elementNode).asText();
        SequenceFlow flowElement = (SequenceFlow) super.convertJsonToElement(elementNode, modelNode, shapeMap);

         ActivityExtensionProperty activityExtensionProperty = SpringContextUtil.getBean(ActivityExtensionPropertyService.class).getOne(new LambdaQueryWrapper<ActivityExtensionProperty>()
                .eq(ActivityExtensionProperty::getProcessDefId, procDefId).eq(ActivityExtensionProperty::getActivityDefId,taskDefId).eq(ActivityExtensionProperty::getKey, "conditionType"));
        if(activityExtensionProperty != null ){
            ExtensionAttribute attribute = new ExtensionAttribute();
            attribute.setName("flowable:conditionType");
            attribute.setValue(activityExtensionProperty.getValue());
            flowElement.addAttribute(attribute);
        }
        List<ActivityExtensionData> list =  SpringContextUtil.getBean(ActivityExtensionDataService.class)
                .list(new LambdaQueryWrapper<ActivityExtensionData>().eq(ActivityExtensionData::getProcessDefId, procDefId)
                        .eq(ActivityExtensionData::getActivityDefId, taskDefId));
        if (list.size() > 0) {
            ActivityExtensionData activityExtensionData = list.get(0);
            List<WorkflowCondition> workflowConditionList = SpringContextUtil.getBean(ActivityExtensionDataService.class)
                    .findById(activityExtensionData.getId()).getWorkflowConditionList();

            for (WorkflowCondition workflowCondition : workflowConditionList) {
                ExtensionElement condition = new ExtensionElement();
                condition.setName("flowable:Condition");

                ExtensionAttribute id = new ExtensionAttribute();
                id.setName("id");
                id.setValue(workflowCondition.getId() + "");
                ExtensionAttribute field = new ExtensionAttribute();
                field.setName("field");
                field.setValue(workflowCondition.getField());
                ExtensionAttribute compare = new ExtensionAttribute();
                compare.setName("compare");
                compare.setValue(workflowCondition.getCompare());
                ExtensionAttribute value = new ExtensionAttribute();
                value.setName("value");
                value.setValue(workflowCondition.getValue());

                ExtensionAttribute logic = new ExtensionAttribute();
                logic.setName("logic");
                logic.setValue(workflowCondition.getLogic());
                ExtensionAttribute sort = new ExtensionAttribute();
                sort.setName("sort");
                sort.setValue(String.valueOf(workflowCondition.getSort()));

                condition.addAttribute(id);
                condition.addAttribute(field);
                condition.addAttribute(compare);
                condition.addAttribute(value);
                condition.addAttribute(logic);
                condition.addAttribute(sort);
                flowElement.addExtensionElement(condition);

            }


        }

        return flowElement;
    }


}
