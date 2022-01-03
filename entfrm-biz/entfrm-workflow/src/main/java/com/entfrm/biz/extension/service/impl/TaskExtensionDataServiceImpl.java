package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.TaskExtensionData;
import com.entfrm.biz.extension.entity.WorkflowAssignee;
import com.entfrm.biz.extension.entity.WorkflowButton;
import com.entfrm.biz.extension.entity.WorkflowCondition;
import com.entfrm.biz.extension.mapper.TaskExtensionDataMapper;
import com.entfrm.biz.extension.mapper.WorkflowAssigneeMapper;
import com.entfrm.biz.extension.mapper.WorkflowButtonMapper;
import com.entfrm.biz.extension.mapper.WorkflowConditionMapper;
import com.entfrm.biz.extension.service.TaskExtensionDataService;
import lombok.AllArgsConstructor;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Service;

import java.util.List;


/**
 *<p>
 * 任务扩展数据 service
 *</p>
 *
 * @Author: entfrm开发团队-王翔
 * @Date: 2021/5/12
 */
@Service
@AllArgsConstructor
public class TaskExtensionDataServiceImpl extends ServiceImpl<TaskExtensionDataMapper, TaskExtensionData> implements TaskExtensionDataService {

    private final WorkflowAssigneeMapper workflowAssigneeMapper;

    private final WorkflowButtonMapper workflowButtonMapper;

    private final WorkflowConditionMapper workflowConditionMapper;

    @Override
    public TaskExtensionData findById(Integer id) {
        TaskExtensionData taskExtensionData = super.getById(id);
        taskExtensionData.setWorkflowAssigneeList(workflowAssigneeMapper.selectList(
                new LambdaQueryWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, taskExtensionData.getId())));
        taskExtensionData.setWorkflowButtonList(workflowButtonMapper.selectList(
                new LambdaQueryWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, taskExtensionData.getId())));
        taskExtensionData.setWorkflowConditionList(workflowConditionMapper.selectList(
                new LambdaQueryWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, taskExtensionData.getId())));
        return taskExtensionData;
    }

    @Override
    public void delete(Integer id) {
        super.removeById(id);
        workflowAssigneeMapper.delete(new LambdaUpdateWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, id));
        workflowButtonMapper.delete(new LambdaUpdateWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, id));
        workflowConditionMapper.delete(new LambdaUpdateWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, id));
    }

    @Override
    public boolean save(TaskExtensionData taskExtensionData) {
        super.save(taskExtensionData);
        taskExtensionData.getWorkflowAssigneeList().forEach(workflowAssignee -> {
            workflowAssignee.setTaskExtensionDataId(taskExtensionData.getId());
            workflowAssigneeMapper.insert(workflowAssignee);
        });
        taskExtensionData.getWorkflowButtonList().forEach(workflowButton -> {
            workflowButton.setTaskExtensionDataId(taskExtensionData.getId());
            workflowButtonMapper.insert(workflowButton);
        });
        taskExtensionData.getWorkflowConditionList().forEach(workflowCondition -> {
            workflowCondition.setTaskExtensionDataId(taskExtensionData.getId());
            workflowConditionMapper.insert(workflowCondition);
        });
        return true;
    }

    @Override
    public void deleteByProcessDefId(String processDefId) {
        List<TaskExtensionData> list = super.list(new LambdaQueryWrapper<TaskExtensionData>()
                .eq(TaskExtensionData::getProcessDefId, processDefId));
        list.forEach(taskExtensionData -> {
            super.removeById(taskExtensionData.getId());
            workflowAssigneeMapper.delete(new LambdaUpdateWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, taskExtensionData.getId()));
            workflowButtonMapper.delete(new LambdaUpdateWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, taskExtensionData.getId()));
            workflowConditionMapper.delete(new LambdaUpdateWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, taskExtensionData.getId()));
        });
    }
}
