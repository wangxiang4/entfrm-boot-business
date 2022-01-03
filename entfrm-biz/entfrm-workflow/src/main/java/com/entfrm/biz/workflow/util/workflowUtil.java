package com.entfrm.biz.workflow.util;

import com.entfrm.biz.workflow.constant.FlowableConstant;
import lombok.experimental.UtilityClass;
import org.apache.commons.compress.utils.Sets;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.*;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * <p>
 * 工作流工具类
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
@UtilityClass
public class workflowUtil {


    public boolean isReachable(Process process, FlowNode sourceElement, FlowNode targetElement) {
        return isReachable(process, sourceElement, targetElement, Sets.newHashSet());
    }


    /**
     * 当前节点是否可以到达目标节点,可以到达的目标节点均为已经完成的节点
     */
    public boolean isReachable(Process process, FlowNode sourceElement, FlowNode targetElement,
                               Set<String> visitedElements) {
        // Special case: start events in an event subprocess might exist as an execution and are most likely be able to
        // reach the target
        // when the target is in the event subprocess, but should be ignored as they are not 'real' runtime executions
        // (but rather waiting for a
        // trigger)
        if (sourceElement instanceof StartEvent && isInEventSubprocess(sourceElement)) {
            return false;
        }
        // No outgoing seq flow: could be the end of eg . the process or an embedded subprocess
        if (sourceElement.getOutgoingFlows().size() == 0) {
            visitedElements.add(sourceElement.getId());
            FlowElementsContainer parentElement = process.findParent(sourceElement);
            if (parentElement instanceof SubProcess) {
                sourceElement = (SubProcess) parentElement;
                // by zjm begin
                // 子流程的结束节点，若目标节点在该子流程中，说明无法到达，返回false
                if (((SubProcess) sourceElement).getFlowElement(targetElement.getId()) != null) {
                    return false;
                }
                // by zjm end
            } else {
                return false;
            }
        }
        if (sourceElement.getId().equals(targetElement.getId())) {
            return true;
        }
        // To avoid infinite looping, we must capture every node we visit
        // and check before going further in the graph if we have already
        // visited the node.
        visitedElements.add(sourceElement.getId());
        // by zjm begin
        // 当前节点能够到达子流程，且目标节点在子流程中，说明可以到达，返回true
        if (sourceElement instanceof SubProcess && ((SubProcess) sourceElement).getFlowElement(targetElement.getId()) != null) {
            return true;
        }
        // by zjm end
        List<SequenceFlow> sequenceFlows = sourceElement.getOutgoingFlows();
        if (sequenceFlows != null && sequenceFlows.size() > 0) {
            for (SequenceFlow sequenceFlow : sequenceFlows) {
                String targetRef = sequenceFlow.getTargetRef();
                FlowNode sequenceFlowTarget = (FlowNode) process.getFlowElement(targetRef, true);
                if (sequenceFlowTarget != null && !visitedElements.contains(sequenceFlowTarget.getId())) {
                    boolean reachable = isReachable(process, sequenceFlowTarget, targetElement, visitedElements);
                    if (reachable) {
                        return true;
                    }
                }
            }
        }
        return false;
    }


    /**
     * 当前元素是否是事件子流程
     */
    protected boolean isInEventSubprocess(FlowNode flowNode) {
        FlowElementsContainer flowElementsContainer = flowNode.getParentContainer();
        while (flowElementsContainer != null) {
            if (flowElementsContainer instanceof EventSubProcess) {
                return true;
            }
            if (flowElementsContainer instanceof FlowElement) {
                flowElementsContainer = ((FlowElement) flowElementsContainer).getParentContainer();
            } else {
                flowElementsContainer = null;
            }
        }
        return false;
    }


    /**
     * 获取当前节点跟目标节点世界的活动ID:包括子流程层级关系
     */
    public String[] getSourceAndTargetRealActivityId(FlowNode sourceFlowElement, FlowNode targetFlowElement) {
        // 实际应操作的当前节点ID
        String sourceRealActivityId = sourceFlowElement.getId();
        // 实际应操作的目标节点ID
        String targetRealActivityId = targetFlowElement.getId();
        List<String> sourceParentProcesss = getParentProcessIds(sourceFlowElement);
        List<String> targetParentProcesss = getParentProcessIds(targetFlowElement);

        int diffParentLevel = getDiffLevel(sourceParentProcesss, targetParentProcesss);
        if (diffParentLevel != -1) {
            sourceRealActivityId = sourceParentProcesss.size() == diffParentLevel ? sourceRealActivityId :
                    sourceParentProcesss.get(diffParentLevel);
            targetRealActivityId = targetParentProcesss.size() == diffParentLevel ? targetRealActivityId :
                    targetParentProcesss.get(diffParentLevel);
        }
        return new String[]{sourceRealActivityId, targetRealActivityId};
    }


    /**
     * 获取当前元素的父流程ID
     */
    public List<String> getParentProcessIds(FlowNode flowNode) {
        List<String> result = new ArrayList<>();
        FlowElementsContainer flowElementsContainer = flowNode.getParentContainer();
        while (flowElementsContainer != null) {
            if (flowElementsContainer instanceof SubProcess) {
                SubProcess flowElement = (SubProcess) flowElementsContainer;
                result.add(flowElement.getId());
                flowElementsContainer = flowElement.getParentContainer();
            } else if (flowElementsContainer instanceof Process) {
                Process flowElement = (Process) flowElementsContainer;
                result.add(flowElement.getId());
                flowElementsContainer = null;
            }
        }
        // 集合转反,父流程->子流程,为处理层级差异做准备
        Collections.reverse(result);
        return result;
    }


    /**
     * 查询不同层级,为后面层级之间节点跳转做准备,正常情况下都是返回最小的层级索引,如果碰到层级ID比较不一致的就返回不一致的这一层的索引
     */
    public Integer getDiffLevel(List<String> sourceList, List<String> targetList) {
        if (sourceList == null || sourceList.isEmpty() || targetList == null || targetList.isEmpty()) {
            throw new FlowableException("sourceList and targetList cannot be empty");
        }
        if (sourceList.size() == 1 && targetList.size() == 1) {
            // 都在第0层且不相等
            if (!sourceList.get(0).equals(targetList.get(0))) {
                return 0;
            } else {// 都在第0层且相等
                return -1;
            }
        }

        int minSize = sourceList.size() < targetList.size() ? sourceList.size() : targetList.size();
        Integer targetLevel = null;
        for (int i = 0; i < minSize; i++) {
            //层级ID比较是否不一致
            if (!sourceList.get(i).equals(targetList.get(i))) {
                targetLevel = i;
                break;
            }
        }
        if (targetLevel == null) {
            if (sourceList.size() == targetList.size()) {
                targetLevel = -1;
            } else {
                targetLevel = minSize;
            }
        }
        return targetLevel;
    }


    /**
     * 获取当前流程容器中的所有特殊网关:包括网关中定义的活动节点
     */
    public Map<String, Set<String>> getSpecialGatewayElements(FlowElementsContainer container,
                                                                     Map<String, Set<String>> specialGatewayElements) {
        if (specialGatewayElements == null) {
            specialGatewayElements = new HashMap<>(16);
        }
        Collection<FlowElement> flowelements = container.getFlowElements();
        for (FlowElement flowElement : flowelements) {
            //判断id是否有特殊网关的开始后缀已经是否是可以并行处理的网关
            boolean isBeginSpecialGateway =
                    flowElement.getId().endsWith(FlowableConstant.SPECIAL_GATEWAY_BEGIN_SUFFIX) && (flowElement instanceof ParallelGateway || flowElement instanceof InclusiveGateway || flowElement instanceof ComplexGateway);
            if (isBeginSpecialGateway) {
                String gatewayBeginRealId = flowElement.getId();
                String gatewayId = gatewayBeginRealId.substring(0, gatewayBeginRealId.length() - 6);
                Set<String> gatewayIdContainFlowelements = specialGatewayElements.computeIfAbsent(gatewayId, k -> new HashSet<>());
                //收集网关的节点ID已经包括网关中定义的活动节点ID
                findElementsBetweenSpecialGateway(
                        flowElement, gatewayId + FlowableConstant.SPECIAL_GATEWAY_END_SUFFIX,
                        gatewayIdContainFlowelements);
            } else if (flowElement instanceof SubProcess) {
                getSpecialGatewayElements((SubProcess) flowElement, specialGatewayElements);
            }
        }

        //网关元素降序排序,为处理层级差异做准备
        Map<String, Set<String>> specialGatewayNodesSort = new LinkedHashMap<>();
        specialGatewayElements.entrySet().stream().sorted((o1, o2) ->
                o2.getValue().size() - o1.getValue().size())
                .forEach(entry -> specialGatewayNodesSort.put(entry.getKey(), entry.getValue()));

        return specialGatewayNodesSort;
    }


    /** 查找特殊网关之间的关联关系,并且跟网关有关系的节点收集记录 */
    public void findElementsBetweenSpecialGateway(FlowElement specialGatewayBegin, String specialGatewayEndId,
                                                         Set<String> elements) {
        //收集节点ID
        elements.add(specialGatewayBegin.getId());
        List<SequenceFlow> sequenceFlows = ((FlowNode) specialGatewayBegin).getOutgoingFlows();
        if (sequenceFlows != null && sequenceFlows.size() > 0) {
            for (SequenceFlow sequenceFlow : sequenceFlows) {
                FlowElement targetFlowElement = sequenceFlow.getTargetFlowElement();
                String targetFlowElementId = targetFlowElement.getId();
                //收集结束节点ID
                elements.add(specialGatewayEndId);
                if (targetFlowElementId.equals(specialGatewayEndId)) {
                    continue;
                } else {
                    findElementsBetweenSpecialGateway(targetFlowElement, specialGatewayEndId, elements);
                }
            }
        }
    }

    public  Map<String, Set<String>> getSpecialGatewayElements(FlowElementsContainer container) {
        return getSpecialGatewayElements(container, null);
    }


    /** 获取当前跟活动节点有关联的流程实例已经产生出来的分支路线的父级ID:处理了多实例情况,多实例情况下父级ID是关联多实例活动节点执行ID的 */
    public  Set<String> getParentExecutionIdsByActivityId(List<ExecutionEntity> executions, String activityId) {
        List<ExecutionEntity> activityIdExecutions =
                executions.stream().filter(e -> activityId.equals(e.getActivityId())).collect(Collectors.toList());
        if (activityIdExecutions.isEmpty()) {
            throw new FlowableException("Active execution could not be found with activity id " + activityId);
        }
        // check for a multi instance root execution
        ExecutionEntity miExecution = null;
        boolean isInsideMultiInstance = false;
        for (ExecutionEntity possibleMiExecution : activityIdExecutions) {
            if (possibleMiExecution.isMultiInstanceRoot()) {
                miExecution = possibleMiExecution;
                isInsideMultiInstance = true;
                break;
            }
            if (isExecutionInsideMultiInstance(possibleMiExecution)) {
                isInsideMultiInstance = true;
            }
        }
        Set<String> parentExecutionIds = new HashSet<> ();
        if (isInsideMultiInstance) {
            Stream<ExecutionEntity> executionEntitiesStream = activityIdExecutions.stream();
            if (miExecution != null) {
                executionEntitiesStream = executionEntitiesStream.filter(ExecutionEntity::isMultiInstanceRoot);
            }
            executionEntitiesStream.forEach(childExecution -> {
                parentExecutionIds.add(childExecution.getParentId());
            });
        } else {
            ExecutionEntity execution = activityIdExecutions.iterator().next();
            parentExecutionIds.add(execution.getParentId());
        }
        return parentExecutionIds;
    }


    /** 父流程是否是以多实例执行的(一至找到根流程) */
    public  boolean isExecutionInsideMultiInstance(ExecutionEntity execution) {
        return getFlowElementMultiInstanceParentId(execution.getCurrentFlowElement()).isPresent();
    }

    /** 查找当前元素父流程是多实例执行的ID */
    public  Optional<String> getFlowElementMultiInstanceParentId(FlowElement flowElement) {
        FlowElementsContainer parentContainer = flowElement.getParentContainer();
        while (parentContainer instanceof Activity) {
            if (isFlowElementMultiInstance((Activity) parentContainer)) {
                return Optional.of(((Activity) parentContainer).getId());
            }
            parentContainer = ((Activity) parentContainer).getParentContainer();
        }
        return Optional.empty();
    }


    /** 检测当前父流程是否为多实例 */
    public boolean isFlowElementMultiInstance(FlowElement flowElement) {
        if (flowElement instanceof Activity) {
            return ((Activity) flowElement).getLoopCharacteristics() != null;
        }
        return false;
    }



    /**
     * 获取流程执行根ID
     * 根据当前已经筛选出来的流程父级ID(也就是流程执行根ID)去当前任务中查找(一至找到根流程执行)直到匹配流程执行根ID成功返回 */
    public String getParentExecutionIdFromParentIds(ExecutionEntity execution, Set<String> parentExecutionIds) {
        ExecutionEntity taskParentExecution = execution.getParent();
        String realParentExecutionId = null;
        while (taskParentExecution != null) {
            if (parentExecutionIds.contains(taskParentExecution.getId())) {
                realParentExecutionId = taskParentExecution.getId();
                break;
            }
            taskParentExecution = taskParentExecution.getParent();
        }
        if (realParentExecutionId == null || realParentExecutionId.length() == 0) {
            throw new FlowableException("Parent execution could not be found with executionId id " + execution.getId());
        }
        return realParentExecutionId;
    }



}
