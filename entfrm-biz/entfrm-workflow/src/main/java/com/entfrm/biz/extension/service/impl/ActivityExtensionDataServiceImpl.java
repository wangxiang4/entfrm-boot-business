package com.entfrm.biz.extension.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.entfrm.biz.extension.entity.ActivityExtensionData;
import com.entfrm.biz.extension.entity.WorkflowAssignee;
import com.entfrm.biz.extension.entity.WorkflowButton;
import com.entfrm.biz.extension.entity.WorkflowCondition;
import com.entfrm.biz.extension.mapper.ActivityExtensionDataMapper;
import com.entfrm.biz.extension.mapper.WorkflowAssigneeMapper;
import com.entfrm.biz.extension.mapper.WorkflowButtonMapper;
import com.entfrm.biz.extension.mapper.WorkflowConditionMapper;
import com.entfrm.biz.extension.service.ActivityExtensionDataService;
import lombok.AllArgsConstructor;
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
public class ActivityExtensionDataServiceImpl extends ServiceImpl<ActivityExtensionDataMapper, ActivityExtensionData> implements ActivityExtensionDataService {

    private final WorkflowAssigneeMapper workflowAssigneeMapper;

    private final WorkflowButtonMapper workflowButtonMapper;

    private final WorkflowConditionMapper workflowConditionMapper;

    @Override
    public ActivityExtensionData findById(Integer id) {
        ActivityExtensionData activityExtensionData = super.getById(id);
        activityExtensionData.setWorkflowAssigneeList(workflowAssigneeMapper.selectList(
                new LambdaQueryWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, activityExtensionData.getId())));
        activityExtensionData.setWorkflowButtonList(workflowButtonMapper.selectList(
                new LambdaQueryWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, activityExtensionData.getId())));
        activityExtensionData.setWorkflowConditionList(workflowConditionMapper.selectList(
                new LambdaQueryWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, activityExtensionData.getId())));
        return activityExtensionData;
    }

    @Override
    public void delete(Integer id) {
        super.removeById(id);
        workflowAssigneeMapper.delete(new LambdaUpdateWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, id));
        workflowButtonMapper.delete(new LambdaUpdateWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, id));
        workflowConditionMapper.delete(new LambdaUpdateWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, id));
    }

    @Override
    public boolean save(ActivityExtensionData activityExtensionData) {
        super.save(activityExtensionData);
        activityExtensionData.getWorkflowAssigneeList().forEach(workflowAssignee -> {
            workflowAssignee.setTaskExtensionDataId(activityExtensionData.getId());
            workflowAssigneeMapper.insert(workflowAssignee);
        });
        activityExtensionData.getWorkflowButtonList().forEach(workflowButton -> {
            workflowButton.setTaskExtensionDataId(activityExtensionData.getId());
            workflowButtonMapper.insert(workflowButton);
        });
        activityExtensionData.getWorkflowConditionList().forEach(workflowCondition -> {
            workflowCondition.setTaskExtensionDataId(activityExtensionData.getId());
            workflowConditionMapper.insert(workflowCondition);
        });
        return true;
    }

    @Override
    public void deleteByProcessDefId(String processDefId) {
        List<ActivityExtensionData> list = super.list(new LambdaQueryWrapper<ActivityExtensionData>()
                .eq(ActivityExtensionData::getProcessDefId, processDefId));
        list.forEach(taskExtensionData -> {
            super.removeById(taskExtensionData.getId());
            workflowAssigneeMapper.delete(new LambdaUpdateWrapper<WorkflowAssignee>().eq(WorkflowAssignee::getTaskExtensionDataId, taskExtensionData.getId()));
            workflowButtonMapper.delete(new LambdaUpdateWrapper<WorkflowButton>().eq(WorkflowButton::getTaskExtensionDataId, taskExtensionData.getId()));
            workflowConditionMapper.delete(new LambdaUpdateWrapper<WorkflowCondition>().eq(WorkflowCondition::getTaskExtensionDataId, taskExtensionData.getId()));
        });
    }
}
