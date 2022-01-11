package com.entfrm.biz.workflow.override.json;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.flowable.bpmn.model.BaseElement;
import org.flowable.bpmn.model.ExtensionAttribute;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.editor.language.json.converter.StartEventJsonConverter;

import java.util.Map;


public class FlowableStartEventJsonConverter extends StartEventJsonConverter{
    @Override
    protected FlowElement convertJsonToElement(JsonNode elementNode, JsonNode modelNode, Map<String, JsonNode> shapeMap) {
        StartEvent startEvent = (StartEvent)super.convertJsonToElement(elementNode, modelNode, shapeMap);
        if (getPropertyValueAsString ("formType", elementNode) != null) {
            ExtensionAttribute attribute2 = new ExtensionAttribute ();
            attribute2.setName ("flowable:formType");
            attribute2.setValue (getPropertyValueAsString ("formType", elementNode));
            startEvent.addAttribute (attribute2);
        }
        return startEvent;
    }


    //将Element转为Json
    @Override
    protected void convertElementToJson(ObjectNode propertiesNode, BaseElement baseElement) {
        super.convertElementToJson (propertiesNode, baseElement);
        if (baseElement instanceof StartEvent) {
            //读取自定义扩展属性
            if (baseElement.getAttributes ().get ("formType") != null && baseElement.getAttributes ().get ("formType").size () > 0) {
                propertiesNode.put ("formType", baseElement.getAttributes ().get ("formType").get (0).getValue ());
            }
            if (baseElement.getAttributes ().get ("formReadOnly") != null && baseElement.getAttributes ().get ("formReadOnly").size () > 0) {
                propertiesNode.put ("formReadOnly", baseElement.getAttributes ().get ("formReadOnly").get (0).getValue ());
            }
        }

    }



}
