package com.entfrm.biz.workflow.parser.handler;

import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.entfrm.base.util.SpringContextUtil;
import com.entfrm.biz.extension.entity.ActivityExtensionData;
import com.entfrm.biz.extension.entity.WorkflowAssignee;
import com.entfrm.biz.extension.service.ActivityExtensionDataService;
import com.entfrm.biz.workflow.constant.SqlConstants;
import com.entfrm.biz.workflow.util.WorkflowUtil;
import com.entfrm.security.util.SecurityUtil;
import org.flowable.bpmn.model.FlowElement;
import org.flowable.bpmn.model.Process;
import org.flowable.bpmn.model.UserTask;
import org.flowable.common.engine.impl.el.ExpressionManager;
import org.flowable.engine.HistoryService;
import org.flowable.engine.RepositoryService;
import org.flowable.engine.delegate.DelegateExecution;
import org.flowable.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.flowable.task.api.history.HistoricTaskInstance;
import org.flowable.task.service.TaskService;
import org.flowable.task.service.impl.persistence.entity.TaskEntity;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.*;
import java.util.stream.Collectors;

/**
 *<p>
 * 扩展用户任务活动行为
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2022/1/4
 */
public class ExtendUserTaskActivityBehavior extends UserTaskActivityBehavior {

    private static final long serialVersionUID = 1L;

    public ExtendUserTaskActivityBehavior(UserTask userTask) {
        super(userTask);
    }

    @Override /** 处理分配任务处理人 */
    protected void handleAssignments(TaskService taskService,
                                     String assignee,
                                     String owner,
                                     List<String> candidateUsers,
                                     List<String> candidateGroups,
                                     TaskEntity task,
                                     ExpressionManager expressionManager,
                                     DelegateExecution execution) {

        Process process = SpringContextUtil.getBean(RepositoryService.class).getBpmnModel(task.getProcessDefinitionId()).getMainProcess();
        FlowElement flowElement = process.getFlowElement(task.getTaskDefinitionKey());
        Boolean isMultiInstance = WorkflowUtil.isFlowElementMultiInstance(flowElement);
        // 如果当前任务是多实例则移交给MultiInstanceHandler处理
        if(isMultiInstance){
            super.handleAssignments(
                    taskService,
                    assignee,
                    owner,
                    candidateUsers,
                    candidateGroups,
                    task,
                    expressionManager,
                    execution);
            return;
        }
        List<ActivityExtensionData> list = SpringContextUtil.getBean(ActivityExtensionDataService.class)
                .list(new LambdaQueryWrapper<ActivityExtensionData>()
                        .eq(ActivityExtensionData::getActivityDefId, task.getTaskDefinitionKey())
                        .eq(ActivityExtensionData::getProcessDefId, process.getId()));
        HashSet<String> candidateUserIds = new HashSet();
        if (list.size () > 0) {
            ActivityExtensionData activityExtensionData = list.get(0);
            List<WorkflowAssignee> workflowAssigneeList =  SpringContextUtil.getBean(ActivityExtensionDataService.class)
                    .findById(activityExtensionData.getId()).getWorkflowAssigneeList();
            JdbcTemplate jdbcTemplate = SpringContextUtil.getBean(JdbcTemplate.class);
            for (WorkflowAssignee workflowAssignee : workflowAssigneeList) {
                switch (workflowAssignee.getType()) {
                    case "user":
                        candidateUserIds.addAll(Arrays.asList(workflowAssignee.getValue().split(",")));
                        break;
                    case "company":
                        // 获取公司下的人员进行候选
                        if (StrUtil.isNotBlank(workflowAssignee.getValue())) {
                            List<Map<String, Object>> userList = jdbcTemplate.queryForList(SqlConstants.QUERY_USER_BY_DEPT_ID, workflowAssignee.getValue());
                            candidateUserIds.addAll(userList.stream().map(user -> MapUtil.getStr(user, "id")).collect(Collectors.toList()));
                        }
                        break;
                    case "role":
                        // 获取角色下的人员进行候选
                        if (StrUtil.isNotBlank(workflowAssignee.getValue())) {
                            String[] roleIds = workflowAssignee.getValue().split (",");
                            for(String roleId: roleIds){
                                List<Map<String, Object>> userList = jdbcTemplate.queryForList(SqlConstants.QUERY_USER_BY_ROLE_ID, roleId);
                                candidateUserIds.addAll(userList.stream().map(user -> MapUtil.getStr(user, "id")).collect(Collectors.toList()));
                            }
                        }
                        break;
                    case "applyUserId":
                        // 流程发起人进行候选
                        candidateUserIds.add ("${applyUserId}");
                        break;
                    case "previousExecutor":
                        // 查询上一个任务的处理人进行候选
                        HistoricTaskInstance historicTaskInstance = SpringContextUtil.getBean(HistoryService.class).createHistoricTaskInstanceQuery()
                                .processInstanceId(task.getProcessInstanceId()).finished()
                                .includeProcessVariables().orderByHistoricTaskInstanceEndTime().desc().list().get(0);
                        candidateUserIds.add(historicTaskInstance.getAssignee());
                        break;
                    case "currentUserId":
                        // 当前登录用户进行候选
                        candidateUserIds.add(SecurityUtil.getUser().getId() + "");
                        break;
                    case "sql":
                        // 查询sql中指定的id用户进行候选
                        Map<String, Object> user = jdbcTemplate.queryForMap(workflowAssignee.getValue());
                        candidateUserIds.add(MapUtil.getStr(user,"id"));
                        break;
                    case "custom":
                        System.out.println("--运行自定义分配任务处理人:请自行实现--");
                        break;
                }
            }
        }
        List<String> candidateIds = new ArrayList(candidateUserIds);
        // 此处可以根据业务逻辑自定义
        if (candidateIds.size () == 0) {
            super.handleAssignments(
                    taskService,
                    null,
                    owner,
                    CollectionUtil.newArrayList(),
                    CollectionUtil.newArrayList(),
                    task,
                    expressionManager,
                    execution);
        } else if (candidateIds.size () == 1) {
            super.handleAssignments(
                    taskService,
                    candidateIds.get(0),
                    owner,
                    CollectionUtil.newArrayList(),
                    CollectionUtil.newArrayList(),
                    task,
                    expressionManager,
                    execution);
        } else if (candidateIds.size () > 1) {
            super.handleAssignments(
                    taskService,
                    null,
                    owner,
                    candidateIds,
                    null,
                    task,
                    expressionManager,
                    execution);
        }
    }

}

