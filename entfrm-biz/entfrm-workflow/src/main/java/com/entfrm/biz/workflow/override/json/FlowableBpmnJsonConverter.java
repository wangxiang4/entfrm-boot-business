package com.entfrm.biz.workflow.override.json;

import org.flowable.bpmn.model.SequenceFlow;
import org.flowable.bpmn.model.StartEvent;
import org.flowable.bpmn.model.UserTask;
import org.flowable.editor.language.json.converter.BpmnJsonConverter;

public class FlowableBpmnJsonConverter extends BpmnJsonConverter {
    static {
        convertersToBpmnMap.put(STENCIL_SEQUENCE_FLOW, FlowableSequenceFlowJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_TASK_USER, FlowableUserTaskJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_NONE, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_TIMER, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_CONDITIONAL, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_ERROR, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_ESCALATION, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_MESSAGE, FlowableStartEventJsonConverter.class);
        convertersToBpmnMap.put(STENCIL_EVENT_START_SIGNAL, FlowableStartEventJsonConverter.class);

        convertersToJsonMap.put(SequenceFlow.class, FlowableSequenceFlowJsonConverter.class);
        convertersToJsonMap.put(UserTask.class, FlowableUserTaskJsonConverter.class);
        convertersToJsonMap.put(StartEvent.class, FlowableStartEventJsonConverter.class);
    }
}
