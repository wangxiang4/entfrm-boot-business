package com.entfrm.biz.workflow.execution.cmd;

import com.entfrm.biz.workflow.constant.FlowableConstant;
import com.entfrm.biz.workflow.util.workflowUtil;
import org.apache.commons.compress.utils.Sets;
import org.flowable.bpmn.model.FlowNode;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.UserTask;
import org.flowable.common.engine.api.FlowableException;
import org.flowable.common.engine.api.FlowableObjectNotFoundException;
import org.flowable.common.engine.impl.interceptor.Command;
import org.flowable.common.engine.impl.interceptor.CommandContext;
import org.flowable.engine.RuntimeService;
import org.flowable.engine.impl.delegate.ActivityBehavior;
import org.flowable.engine.impl.persistence.entity.ExecutionEntity;
import org.flowable.engine.impl.persistence.entity.ExecutionEntityManager;
import org.flowable.engine.impl.util.CommandContextUtil;
import org.flowable.engine.impl.util.ProcessDefinitionUtil;
import org.flowable.task.api.Task;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 回滚任务命令定义
 * </p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public class RollBackUserTaskCmd implements Command<String>, Serializable {


    public static final long serialVersionUID = 1L;

    protected RuntimeService runtimeService;
    protected String taskId;
    protected String targetActivityId;


    public RollBackUserTaskCmd(RuntimeService runtimeService, String taskId, String targetActivityId) {
        this.runtimeService = runtimeService;
        this.taskId = taskId;
        this.targetActivityId = targetActivityId;
    }


    @Override
    public String execute(CommandContext commandContext) {
        if (targetActivityId == null || targetActivityId.length() == 0) {
            throw new FlowableException("TargetActivityId cannot be empty");
        }
        TaskEntity task = CommandContextUtil.getTaskService().getTask(taskId);
        if (task == null) {
            throw new FlowableObjectNotFoundException("task " + taskId + " doesn't exist", Task.class);
        }
        String sourceActivityId = task.getTaskDefinitionKey();
        String processInstanceId = task.getProcessInstanceId();
        String processDefinitionId = task.getProcessDefinitionId();
        Process process = ProcessDefinitionUtil.getProcess(processDefinitionId);
        FlowNode sourceFlowElement = (FlowNode) process.getFlowElement(sourceActivityId, true);
        // 只支持从用户任务退回
        if (!(sourceFlowElement instanceof UserTask)) {
            throw new FlowableException ("Task with id:" + taskId + " is not a UserTask");
        }
        FlowNode targetFlowElement = (FlowNode) process.getFlowElement(targetActivityId, true);
        // 设置只允许用户任务退回,不允许前进
        if (!(sourceFlowElement instanceof UserTask)) {
            throw new FlowableException ("Task with id:" + taskId + " is not a UserTask");
        }
        // ps:如果目前为前进,并将前进实在子流程中,目前处理的是只能退回到子流程开始节点,无法退回至子流程中任意节点
        String[] sourceAndTargetRealActivityId =  workflowUtil.getSourceAndTargetRealActivityId(sourceFlowElement, targetFlowElement);
        // 实际应操作的当前节点ID
        String sourceRealActivityId = sourceAndTargetRealActivityId[0];
        // 实际应操作的目标节点ID
        String targetRealActivityId = sourceAndTargetRealActivityId[1];

        //获取当前流程中的可以并行的网关
        Map<String, Set<String>> specialGatewayNodes = workflowUtil.getSpecialGatewayElements(process);

        // 当前节点处在的并行网关list
        List<String> sourceInSpecialGatewayList = new ArrayList<>();
        // 目标节点处在的并行网关list
        List<String> targetInSpecialGatewayList = new ArrayList<>();
        setSpecialGatewayList(sourceRealActivityId, targetRealActivityId, specialGatewayNodes,
                sourceInSpecialGatewayList, targetInSpecialGatewayList);

        // 实际应筛选执行分支路线的节点ID
        Set<String> sourceRealAcitivtyIds = null;
        // 重新统计驳回目标节点的并行网关汇聚节点
        String targetRealSpecialGateway = null;

        // 1.目标节点和当前节点都不在并行网关中
        if (targetInSpecialGatewayList.isEmpty() && sourceInSpecialGatewayList.isEmpty()) {
            sourceRealAcitivtyIds = Sets.newHashSet(sourceRealActivityId);
        }
        // 2.目标节点不在并行网关中、当前节点在并行网关中
        else if (targetInSpecialGatewayList.isEmpty() && !sourceInSpecialGatewayList.isEmpty()) {
            sourceRealAcitivtyIds = specialGatewayNodes.get(sourceInSpecialGatewayList.get(0));
        }
        // 3.目标节点在并行网关中、当前节点不在并行网关中
        else if (!targetInSpecialGatewayList.isEmpty() && sourceInSpecialGatewayList.isEmpty()) {
            sourceRealAcitivtyIds = Sets.newHashSet(sourceRealActivityId);
            targetRealSpecialGateway = targetInSpecialGatewayList.get(0);
        }
        // 4.目标节点和当前节点都在并行网关中
        else {
            int diffSpecialGatewayLevel = workflowUtil.getDiffLevel(sourceInSpecialGatewayList,targetInSpecialGatewayList);
            // 在并行网关同一层且在同一分支
            if (diffSpecialGatewayLevel == -1) {
                sourceRealAcitivtyIds = Sets.newHashSet(sourceRealActivityId);
            } else {
                // 目前处于节点前进操作,应该筛选当前节点前面已经执行完的执行分支路线实体
                if (sourceInSpecialGatewayList.size() == diffSpecialGatewayLevel) {
                    sourceRealAcitivtyIds = Sets.newHashSet(sourceRealActivityId);
                }
                // 目前处于节点驳回操作,应该筛选目标节点前面已经执行完的执行分支路线实体
                else {
                    sourceRealAcitivtyIds = specialGatewayNodes.get(sourceInSpecialGatewayList.get(diffSpecialGatewayLevel));
                }

                // 目前处于节点驳回操作,应该筛选目标节点前面已经执行完的执行分支路线实体,上面已经处理过来所以不处理
                if (targetInSpecialGatewayList.size() == diffSpecialGatewayLevel) {
                }
                // 目前处于节点前进操作,重新统计前进目标节点的并行网关汇聚节点
                else {
                    targetRealSpecialGateway = targetInSpecialGatewayList.get(diffSpecialGatewayLevel);
                }
            }
        }
        // 筛选需要处理的execution
        List<ExecutionEntity> realExecutions = getRealExecutions(commandContext, processInstanceId,
                task.getExecutionId(), sourceRealActivityId, sourceRealAcitivtyIds);
        // 执行退回，直接跳转到实际的 targetRealActivityId
        List<String> realExecutionIds =
                realExecutions.stream().map(ExecutionEntity::getId).collect(Collectors.toList());
        //根据目标活动节点跳转至查出来的那个执行分支路线实体上
        runtimeService.createChangeActivityStateBuilder().processInstanceId(processInstanceId).moveExecutionsToSingleActivityId(realExecutionIds, targetRealActivityId).changeState();

        // 目前处于节点前进操作,重新统计前进目标节点的并行网关汇聚节点
        if (targetRealSpecialGateway != null) {
            createTargetInSpecialGatewayEndExecutions(commandContext, realExecutions, process,
                    targetInSpecialGatewayList, targetRealSpecialGateway);
        }
        return targetRealActivityId;
    }



    /** 检测当前节点是否在特殊网关中存储则当前筛选出的特殊网关ID */
    private void setSpecialGatewayList(String sourceActivityId, String targetActivityId,
                                       Map<String, Set<String>> specialGatewayNodes,
                                       List<String> sourceInSpecialGatewayList,
                                       List<String> targetInSpecialGatewayList) {
        for (Map.Entry<String, Set<String>> entry : specialGatewayNodes.entrySet()) {
            if (entry.getValue().contains(sourceActivityId)) {
                sourceInSpecialGatewayList.add(entry.getKey());
            }
            if (entry.getValue().contains(targetActivityId)) {
                targetInSpecialGatewayList.add(entry.getKey());
            }
        }
    }



    /** 获取当前节点前面已经执行完的执行分支路线实体 */
    private List<ExecutionEntity> getRealExecutions(CommandContext commandContext, String processInstanceId,
                                                    String taskExecutionId, String sourceRealActivityId,
                                                    Set<String> activityIds) {
        ExecutionEntityManager executionEntityManager = CommandContextUtil.getExecutionEntityManager(commandContext);
        ExecutionEntity taskExecution = executionEntityManager.findById(taskExecutionId);
        List<ExecutionEntity> executions =
                executionEntityManager.findChildExecutionsByProcessInstanceId(processInstanceId);
        Set<String> parentExecutionIds = workflowUtil.getParentExecutionIdsByActivityId(executions,
                sourceRealActivityId);
        // 流程执行根ID
        String realParentExecutionId = workflowUtil.getParentExecutionIdFromParentIds(taskExecution,
                parentExecutionIds);
        //查询act_ru_execution表并且符合当前的流程执行根ID,跟活动ID的执行分支路线实体
        List<ExecutionEntity> childExecutions =
                executionEntityManager.findExecutionsByParentExecutionAndActivityIds(realParentExecutionId,
                        activityIds);
        return childExecutions;
    }


    /** 跳转节点前进如果是前进节点处于特殊网关中需要手动创建除主支流(跳转节点已经处理完毕的)其余的手动创建执行分支路线实体 */
    private void createTargetInSpecialGatewayEndExecutions(CommandContext commandContext,
                                              List<ExecutionEntity> excutionEntitys, Process process,
                                              List<String> targetInSpecialGatewayList,
                                              String targetRealSpecialGateway) {
        // 目标节点相对当前节点处于并行网关，需要手动生成并行网关汇聚节点(_end)的execution数据
        String parentExecutionId = excutionEntitys.iterator().next().getParentId();
        ExecutionEntityManager executionEntityManager = CommandContextUtil.getExecutionEntityManager(commandContext);
        ExecutionEntity parentExecutionEntity = executionEntityManager.findById(parentExecutionId);

        int index = targetInSpecialGatewayList.indexOf(targetRealSpecialGateway);
        for (; index < targetInSpecialGatewayList.size(); index++) {
            String targetInSpecialGateway = targetInSpecialGatewayList.get(index);
            String targetInSpecialGatewayEndId = targetInSpecialGateway + FlowableConstant.SPECIAL_GATEWAY_END_SUFFIX;
            FlowNode targetInSpecialGatewayEnd = (FlowNode) process.getFlowElement(targetInSpecialGatewayEndId, true);
            int nbrOfExecutionsToJoin = targetInSpecialGatewayEnd.getIncomingFlows().size();
            // 处理目标节点所处的分支以外的分支,即 总分枝数-1 = nbrOfExecutionsToJoin - 1
            for (int i = 0; i < nbrOfExecutionsToJoin - 1; i++) {
                //创建执行分支路线实体
                ExecutionEntity childExecution = executionEntityManager.createChildExecution(parentExecutionEntity);
                childExecution.setCurrentFlowElement(targetInSpecialGatewayEnd);
                ActivityBehavior activityBehavior = (ActivityBehavior) targetInSpecialGatewayEnd.getBehavior();
                activityBehavior.execute(childExecution);
            }
        }
    }


}
